package com.fuao.fajxc.dao.harness;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.util.HarnessJson;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.MissionEmp;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewTask;

/**
 * Portal-side data access for the tasks a digital employee has to do.
 *
 * <p>The portal's task model is three tables that grew up together in 2011:
 * <ul>
 *   <li>{@code mission} - the task itself: name, description, type, status;</li>
 *   <li>{@code new_function} - the task's content (the "function" the assignee performs);</li>
 *   <li>{@code new_task} - the <em>assignment</em>: which employee does which function.</li>
 * </ul>
 * and one more that only exists once a task is handed to a person:
 * <ul>
 *   <li>{@code mission_emp} - the employee's own todo: {@code status} 0 未接受 / 1 处理中 /
 *       2 已完成, with the feedback text and the attachment.</li>
 * </ul>
 *
 * <p>The link between the first three is a convention, not a foreign key: {@code mission.tmp2}
 * holds the {@code new_function.id} as text, and {@code new_task.fid} points at the function.
 * The convention is the portal's own and this DAO follows it rather than inventing a second one.
 *
 * <p>Everything here is written through Hibernate, so the portal's own validation and its
 * caches still apply - the same rule the rest of the harness API follows (ADR-008).
 */
public class HarnessTaskDao extends BaseDao {

    private static final Logger logger = Logger.getLogger(HarnessTaskDao.class);

    /**
     * The assignments that are waiting for a digital employee.
     *
     * <p>An assignment is a {@code new_task} row whose flag is still 0 - that is, it has not
     * been handed to the assignee's todo yet - and whose assignee is a digital employee
     * ({@code users.isAI = 1}).
     */
    public List listForDigitalEmployees() {
        List result = new ArrayList();
        Session session = getSession();
        try {
            List employees = session.createQuery(
                    "select u.customerOrEmployeeId from Users u where u.isAI = 1").list();
            if (employees == null || employees.isEmpty()) {
                return result;
            }
            List ids = new ArrayList();
            for (int i = 0; i < employees.size(); i++) {
                Object id = employees.get(i);
                if (id instanceof Number) {
                    ids.add(id);
                }
            }
            if (ids.isEmpty()) {
                return result;
            }
            List tasks = session.createQuery(
                    "from NewTask t where t.flag = 0 and t.emp.id in (:ids) order by t.id")
                    .setParameterList("ids", ids).list();
            if (tasks == null) {
                return result;
            }
            for (int i = 0; i < tasks.size(); i++) {
                NewTask task = (NewTask) tasks.get(i);
                Map row = describe(task);
                if (row != null) {
                    result.add(row);
                }
            }
        } catch (Exception e) {
            logger.error("cannot list the tasks of the digital employees", e);
        }
        return result;
    }

    /**
     * One assignment, as the platform sees it.
     *
     * @return null when the row is not something a digital employee can work on
     */
    private Map describe(NewTask task) {
        NewFunction function = task.getFunction();
        Employee employee = task.getEmp();
        if (function == null || employee == null) {
            return null;
        }
        Map row = new HashMap();
        row.put("assignmentId", String.valueOf(task.getId()));
        row.put("functionId", String.valueOf(function.getId()));
        row.put("name", function.getFunctionname());
        row.put("description", stripHtml(function.getFunctioninfo()));
        row.put("employeeId", String.valueOf(employee.getId()));
        row.put("employeeName", employee.getName());
        // The uuid of a digital employee IS its agent key - the onboarding writes it there
        // (01 §5.1), and it is how the platform finds the agent that has to do the work.
        row.put("agentKey", employee.getUuid());
        row.put("startTime", format(task.getBegintime()));
        row.put("endTime", format(task.getEndtime()));
        row.put("flag", String.valueOf(task.getFlag()));

        // The mission is the task the assignment belongs to. mission.tmp2 holds the function id.
        try {
            List missions = getSession().createQuery("from Mission m where m.tmp2 = ?")
                    .setString(0, String.valueOf(function.getId())).list();
            if (missions != null && !missions.isEmpty()) {
                Mission mission = (Mission) missions.get(0);
                row.put("missionId", String.valueOf(mission.getTaskId()));
                row.put("missionName", mission.getName());
                row.put("missionStatus", mission.getStatus());
                row.put("sbh", mission.getSbh());
            }
        } catch (Exception e) {
            logger.error("cannot find the mission of assignment " + task.getId(), e);
        }
        return row;
    }

    /**
     * The digital employee takes the task.
     *
     * <p>This is the portal's "handout": a row in {@code mission_emp} with status 1 (处理中),
     * and the assignment marked as handed over so it is not offered twice.
     *
     * <p>Doing it twice is not an error: the platform polls, and a poll that arrives after the
     * answer would otherwise create a second todo row.
     */
    public Map accept(String missionId, String employeeId) {
        Map result = new HashMap();
        Session session = getSession();
        Transaction transaction = null;
        try {
            Integer missionKey = Integer.valueOf(missionId);
            Integer empKey = Integer.valueOf(employeeId);

            List existing = session.createQuery(
                    "from MissionEmp me where me.mission.taskId = ? and me.employee.id = ?")
                    .setInteger(0, missionKey.intValue())
                    .setInteger(1, empKey.intValue())
                    .list();
            if (existing != null && !existing.isEmpty()) {
                result.put("ok", Boolean.TRUE);
                result.put("alreadyAccepted", Boolean.TRUE);
                result.put("missionEmpId", String.valueOf(((MissionEmp) existing.get(0)).getId()));
                return result;
            }

            Mission mission = (Mission) session.createQuery("from Mission where taskId = ?")
                    .setInteger(0, missionKey.intValue()).uniqueResult();
            Employee employee = (Employee) session.createQuery("from Employee where id = ?")
                    .setInteger(0, empKey.intValue()).uniqueResult();
            if (mission == null || employee == null) {
                result.put("ok", Boolean.FALSE);
                result.put("error", "no such mission or employee");
                return result;
            }

            transaction = session.beginTransaction();
            MissionEmp me = new MissionEmp();
            me.setMission(mission);
            me.setEmployee(employee);
            me.setStatus("1");
            me.setBuildTime(new Date());
            me.setReceiveTime(new Date());
            me.setSbh(java.util.UUID.randomUUID().toString());
            session.save(me);

            // The assignment is handed over now; the flag is what keeps the platform from
            // offering the same work again.
            List assignments = session.createQuery("from NewTask t where t.flag = 0 and t.emp.id = ?")
                    .setInteger(0, empKey.intValue()).list();
            for (int i = 0; assignments != null && i < assignments.size(); i++) {
                NewTask assignment = (NewTask) assignments.get(i);
                if (assignment.getFunction() != null
                        && mission.getTmp2() != null
                        && mission.getTmp2().equals(String.valueOf(assignment.getFunction().getId()))) {
                    assignment.setFlag(Integer.valueOf(1));
                    session.update(assignment);
                }
            }
            session.flush();
            transaction.commit();
            transaction = null;

            result.put("ok", Boolean.TRUE);
            result.put("missionEmpId", String.valueOf(me.getId()));
            return result;
        } catch (Exception e) {
            rollback(transaction);
            logger.error("cannot accept mission " + missionId, e);
            result.put("ok", Boolean.FALSE);
            result.put("error", e.getMessage());
            return result;
        }
    }

    /**
     * The digital employee finished the task.
     *
     * <p>The feedback text is what a human reads when they ask "what did the agent actually
     * do?" - so it is the agent's own answer, not a summary written by the platform.
     */
    public Map complete(String missionId, String employeeId, String describe, String attachmentId) {
        Map result = new HashMap();
        Session session = getSession();
        Transaction transaction = null;
        try {
            Integer missionKey = Integer.valueOf(missionId);
            Integer empKey = Integer.valueOf(employeeId);

            List rows = session.createQuery(
                    "from MissionEmp me where me.mission.taskId = ? and me.employee.id = ?")
                    .setInteger(0, missionKey.intValue())
                    .setInteger(1, empKey.intValue())
                    .list();
            if (rows == null || rows.isEmpty()) {
                result.put("ok", Boolean.FALSE);
                result.put("error", "the task was never accepted, so there is nothing to complete");
                return result;
            }

            transaction = session.beginTransaction();
            MissionEmp me = (MissionEmp) rows.get(0);
            me.setStatus("2");
            me.setCompleteTime(new Date());
            me.setCompleteDescribe(describe == null ? "" : describe);
            if (attachmentId != null && attachmentId.trim().length() > 0) {
                me.setCompleteFjbs(attachmentId.trim());
            }
            session.update(me);

            // The task itself is finished as well - the status the task list shows.
            Mission mission = me.getMission();
            if (mission != null && !"2".equals(mission.getStatus())) {
                mission.setStatus("2");
                session.update(mission);
            }
            session.flush();
            transaction.commit();
            transaction = null;

            result.put("ok", Boolean.TRUE);
            result.put("missionEmpId", String.valueOf(me.getId()));
            return result;
        } catch (Exception e) {
            rollback(transaction);
            logger.error("cannot complete mission " + missionId, e);
            result.put("ok", Boolean.FALSE);
            result.put("error", e.getMessage());
            return result;
        }
    }

    /**
     * Publishes a task for a digital employee.
     *
     * <p>The same three rows the portal's own "发布任务" writes: the mission, the function that
     * carries the content, and the assignment. The brain proposes; a natural human publishes;
     * this is the write that puts the proposal on the shelf.
     */
    public Map publish(Map command) {
        Map result = new HashMap();
        Session session = getSession();
        Transaction transaction = null;
        try {
            String name = string(command.get("name"));
            String description = string(command.get("description"));
            String agentKey = string(command.get("agentKey"));
            if (name == null || name.trim().length() == 0 || agentKey == null) {
                result.put("ok", Boolean.FALSE);
                result.put("error", "name and agentKey are required");
                return result;
            }
            // The task name goes into two columns with two different limits: the function's
            // name is 20 characters and the mission's is 32. The portal's own "发布任务" has
            // the same limit, so a name that does not fit is a name the portal could not
            // have taken either - and saying so beats a truncation error from the database.
            if (name.trim().length() > 20) {
                result.put("ok", Boolean.FALSE);
                result.put("error", "the task name is at most 20 characters (it is "
                        + name.trim().length() + ")");
                return result;
            }
            Employee employee = (Employee) session.createQuery("from Employee where uuid = ?")
                    .setString(0, agentKey.trim()).uniqueResult();
            if (employee == null) {
                result.put("ok", Boolean.FALSE);
                result.put("error", "no digital employee with the agent key " + agentKey);
                return result;
            }

            transaction = session.beginTransaction();

            NewFunction function = new NewFunction();
            function.setFunctionname(name.trim());
            function.setFunctioninfo(description == null ? "" : description);
            function.setBegintime(date(command.get("startTime")));
            function.setEndtime(date(command.get("endTime")));
            function.setFstate(Integer.valueOf(0));
            function.setFj("");
            function.setFlag(Integer.valueOf(0));
            function.setFinishtasktype(Integer.valueOf(1));
            function.setParentid(Integer.valueOf(-1));
            session.save(function);

            Mission mission = new Mission();
            mission.setName(name.trim());
            mission.setDescription(description == null ? "" : description);
            mission.setEmployee(employee);
            mission.setStatus("0");
            mission.setIsSingle(Integer.valueOf(1));
            mission.setBuildTime(new Date());
            mission.setSbh(java.util.UUID.randomUUID().toString());
            mission.setTmp1("-1");
            mission.setTmp2(String.valueOf(function.getId()));
            session.save(mission);

            NewTask assignment = new NewTask();
            assignment.setFunction(function);
            assignment.setEmp(employee);
            assignment.setBegintime(function.getBegintime());
            assignment.setEndtime(function.getEndtime());
            assignment.setFj("");
            assignment.setSchedule(Integer.valueOf(0));
            assignment.setFlag(Integer.valueOf(0));
            session.save(assignment);

            session.flush();
            transaction.commit();
            transaction = null;

            result.put("ok", Boolean.TRUE);
            result.put("missionId", String.valueOf(mission.getTaskId()));
            result.put("assignmentId", String.valueOf(assignment.getId()));
            result.put("sbh", mission.getSbh());
            return result;
        } catch (Exception e) {
            rollback(transaction);
            logger.error("cannot publish a task for " + command.get("agentKey"), e);
            result.put("ok", Boolean.FALSE);
            result.put("error", e.getMessage());
            return result;
        }
    }

    // ------------------------------------------------------------------ helpers

    private void rollback(Transaction transaction) {
        if (transaction == null) {
            return;
        }
        try {
            transaction.rollback();
        } catch (Exception ignored) {
            // the original error is the one worth reporting
        }
    }

    private String string(Object value) {
        if (value == null) {
            return null;
        }
        return String.valueOf(value);
    }

    private String format(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat("yyyy-MM-dd").format(date);
    }

    private Date date(Object value) {
        if (value == null || String.valueOf(value).trim().length() == 0) {
            return new Date();
        }
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(String.valueOf(value).trim());
        } catch (Exception e) {
            return new Date();
        }
    }

    /**
     * The plain text of the task description.
     *
     * <p>The portal stores the description as HTML, because a human writes it in a rich text
     * box. A digital employee reads text, so the tags come off here - the portal knows its own
     * conventions and the platform should not have to guess them.
     */
    static String stripHtml(String html) {
        if (html == null) {
            return "";
        }
        String out = html;
        // The replacement is a real newline: in Matcher.appendReplacement a backslash escapes
        // the next character, so "\\n" would put a letter "n" into the text.
        out = out.replaceAll("(?i)<br\\s*/?>", "\n");
        out = out.replaceAll("(?i)</p>", "\n");
        out = out.replaceAll("(?i)<[^>]+>", "");
        out = out.replace("&nbsp;", " ");
        out = out.replace("&amp;", "&");
        out = out.replace("&lt;", "<");
        out = out.replace("&gt;", ">");
        out = out.replace("&quot;", "\"");
        out = out.trim();
        while (out.endsWith("\n")) {
            out = out.substring(0, out.length() - 1).trim();
        }
        return out;
    }
}
