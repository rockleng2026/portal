package com.fuao.fajxc.action.newproject;

/*******
 * 项目问题Action
 * @author wangxiong@fuaotech.com
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.aspectj.weaver.patterns.TypePatternQuestions.Question;

import com.fuao.fajxc.bussiness.stockpile.StockpileDetailsBussiness;
import com.fuao.fajxc.dao.newproject.Project;
import com.fuao.fajxc.dao.newproject.QuestionProject;
import com.fuao.fajxc.util.PageBuilder;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Messagetype;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewPrjtresource;
import com.fuao.fajxc.vo.NewProblem;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewQuestion;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.NewWatch;
import com.fuao.fajxc.vo.Scheduleplan;
import com.opensymphony.xwork2.ActionSupport;

public class QuestionProjectAction extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private static final Logger logger = Logger
			.getLogger(QuestionProjectAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private QuestionProject questiondao;
	private StockpileDetailsBussiness stockpileDetailsBussiness;
	private NewProblem newProblem = new NewProblem();
	private NewQuestion newQuestion = new NewQuestion();
	private File filedata1;// 附件上传
	private String questionfilePath;// 上的附件名
	private Project projectdao;// 项目列表dao
	private String creattime;// 开始时间
	private String endTime;// 结束时间
	private String questionname1;// 标题
	private String hidename;
	private String hidename1;
	private String hidepro;

	
	
	/*
	 * 项目消费记录
	 */
	
	public String findbyresource() throws Exception
	{
		try {
			//任务id
			String hql = "from NewPrjtresource as np where 1=1 and np.appstatus = 1";
			String pageNo = request.getParameter("pageNo") == null ? "1" : request
					.getParameter("pageNo");
			String id= request.getParameter("idnp");
			Integer id1 = 0;
			
			NewProject project = null;
			String tmp4= "";
			if(id != null && !id.equals(""))
			{
				String npid= "";
				List prolist =  this.questiondao.getObject("NewProject", new Integer(id));
				if(prolist != null && prolist.size()>0)
				{
					project = (NewProject) prolist.get(0);
				}
				List list = this.questiondao.findById(Integer.parseInt(id));
				if(list != null && list.size()>0)
				{
					for(int np = 0; np<list.size();np++)
					{
						NewFunction function = (NewFunction)list.get(np);
						npid += function.getId() +",";
					}
				}
				String tmp1 = "";
				if(npid != null && !npid.equals(""))
				{
					tmp1 = npid.substring(0,npid.length()-1);
				}else{
					tmp1 = "0";
				}
				String tmp2 = "";
				List taskList = this.questiondao.findBytask(tmp1);
				if(taskList !=null && taskList.size() >0)
				{
					for (int i = 0; i < taskList.size(); i++)
					{
						NewTask task = (NewTask)taskList.get(i);
						tmp2 += task.getId()+",";
					}
				}
				if(tmp2 !=null && !tmp2.equals(""))
				{
					tmp4 = tmp2.substring(0, tmp2.length()-1); 	
				}
				else
				{
					tmp4 = "0";
				}
				id1 = Integer.parseInt(id);
				hql += " and np.task.id in("+tmp4+")";
				request.setAttribute("idnp",id);
			}
			request.setAttribute("pro", project);
			//支出人员金额
			String empname = request.getParameter("empnames");
			//审批人
			String empname1 = request.getParameter("emps");
			//支出金额
			String money = request.getParameter("nmoney");
			//开始时间
			String begintime = request.getParameter("begintime");
			//结束时间
//			String endtime = request.getParameter("endtime");
			//原因
			String remake = request.getParameter("remakes");
			
			if(empname != null && !empname.equals(""))
			{
				String str = URLDecoder.decode(empname, "utf-8");
				hql += " and np.empsubmit.name like '%"+str+"%'";
				request.setAttribute("empname", str);
			}
			if(empname1 != null && !empname1.equals(""))
			{
				String str = URLDecoder.decode(empname1, "utf-8");
				hql += " and np.emp.name like '%"+str+"%'";
				request.setAttribute("empname1", str);
			}
			if(money != null && !money.equals(""))
			{
				hql += " and np.nmoney <"+ (new Double(money));
				request.setAttribute("money", money);
			}
			if(begintime != null && !begintime.equals(""))
			{
				hql += " and np.subtime >='"+begintime+"'";
				request.setAttribute("begintime",begintime);
			}
			if(remake != null && !remake.equals(""))
			{
				String str = URLDecoder.decode(remake, "utf-8");
				hql += " and np.remakes like '%"+str+"%'";
				request.setAttribute("remake", str);
			}
			hql += " order by id asc";
			Pages page = this.questiondao.exHqlPages(hql, new Integer(pageNo), 10, null);
			
			//计算金额
			String hqlprjt = "from NewPrjtresource as pr where 1=1  and pr.task.id in("+tmp4+")";
			List prjtList = this.questiondao.findObj(hqlprjt);
			double moneynum =0.0;
			if(prjtList != null && prjtList.size()>0)
			{
				for(int m =0; m<prjtList.size();m++)
				{
					NewPrjtresource prjtresource = (NewPrjtresource) prjtList.get(m);
					 moneynum += prjtresource.getNmoney();
				}
			}
			double promoney = project.getMoney();
			double sumoney = promoney-moneynum;
			if(sumoney < 0)
			{
				request.setAttribute("message", "亏损金额");
				String moneyCount = sumoney +"";
				String moneys = moneyCount.substring(1, moneyCount.length());
				request.setAttribute("sumoney", moneys);
			}
			else
			{
				request.setAttribute("message","盈利");
				request.setAttribute("sumoney",sumoney);
			}
			//用了多少金额
			request.setAttribute("moneyCount", moneynum);
			//剩余金额
			
			request.setAttribute("pages", page);
			request.setAttribute("listnp", page.getPageList());
			String dc = request.getParameter("dc");
			if(dc != null && !dc.equals(""))
			{
				return "prjt_down";
			}
			
		} catch (Exception e) {
			logger.error("项目消费记录questionProjectAction");
		}
		return "findnp";
	}
	
	
	
	/*
	 * 默认请求(分页)
	 */
	public String select() throws Exception {
		String demo = "";
		if (this.hidename != null && !this.hidename.equals("")) {
			demo += URLDecoder.decode(hidename, "utf-8");
		}


		String hql = "from NewQuestion as nq where 1=1 ";
		String str = "";

		if (demo != null && !demo.equals("")) {
			hql += " and nq.questionname like '%" + demo.trim() + "%'";
		}
		if (this.creattime != null && !this.creattime.equals("")) {
			hql += " and  nq.lastdate >= '" + this.creattime + "'";
		}
		if (this.endTime != null && !this.endTime.equals("")) {
			hql += " and nq.lastdate <= '" + this.endTime + "'";
		}

		hql += " order by nq.lastdate desc";
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		logger.info("hql" + hql);
		// 分页
		Pages pages = this.questiondao.exHqlPages(hql, new Integer(pageNo), 10,
				null);
		List listdemo = pages.getPageList();

		// 查询所有已经立项申请的项目即项目在进行了的项目
		//		
		request.setAttribute("pages", pages);
		request.setAttribute("data", pages.getPageList());
		request.setAttribute("startTime", this.creattime);
		request.setAttribute("endTime", this.endTime);
		request.setAttribute("titlename", demo);
		return "select";
	}

	/*
	 * 领导评价(每个员工写的项目日志)
	 */
	public String findByscheduleplan() throws Exception {
		if (hidename != null && !hidename.equals("")) {
			hidename = URLDecoder.decode(hidename, "utf-8");
		}

		// 在之前算出来看在Scheduleplan表里是否有s.taskid在NewFunction里是否有这个字段
		String testDemo = "";
		List scheList1 = this.questiondao
				.findObj("from Scheduleplan as s where 1=1 and s.function.id !=0 and s.function.id is not null");
		for (int m = 0; m < scheList1.size(); m++) {
			Scheduleplan scheduleplan = (Scheduleplan) scheList1.get(m);
			// 判断这个id在NewFunction里是否存在0
			if(scheduleplan.getFunction()!=null)
			{
				List listFunction = this.questiondao.getObject("NewFunction",
						scheduleplan.getFunction().getId());
				if (listFunction != null && listFunction.size() > 0) {
					testDemo += scheduleplan.getFunction().getId() + ",";
				}
			}
		}
		// 项目ID
		String proid = null;
		if (questionname1 != null && !questionname1.equals("-1")) {
			proid = questionname1;
		}

		String hql = "from Scheduleplan as s where 1=1 and s.function.id !=0 and s.function.id is not null";
		if (!testDemo.equals("") && testDemo != null) {
			String taskid = testDemo.substring(0, testDemo.length() - 1);
			hql += " and s.function.id in(" + taskid + ")";
		}

		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String str = "";
		if (proid != null && !proid.equals("")) {
			// 得到一个project
			NewProject project = (NewProject) this.questiondao.getObject(
					"NewProject", new Integer(proid)).get(0);
			// 得到project下的所有功能
			List functionList = this.questiondao.getObject2("NewFunction",
					project.getId());
			if (functionList != null && functionList.size() > 0) {
				for (int l = 0; l < functionList.size(); l++) {
					// 得到所有的newFunction的Id
					NewFunction function = (NewFunction) functionList.get(l);
					str += function.getId() + ",";
				}
			} else {
				str += "0";
			}
		}
		// 项目不为空的状态下
		if (str != null && !str.equals("")) {
			// 最后出现的地方
			if (str.endsWith(",")) {
				int num = str.lastIndexOf(",");
				String str1 = str.substring(0, num);
				hql += " and s.function.id in(" + str1 + ")";
			} else {
				hql += " and s.function.id in(" + str + ")";
			}
		}
		if (hidename != null && !hidename.equals("")) {
			hql += " and s.subjecttitle like '%" + hidename + "%'";
		}
		if (creattime != null && creattime != null) {
			hql += " and s.begintime >= '" + creattime + "'";
		}
		if (endTime != null && !endTime.equals("")) {
			hql += " and s.begintime <= '" + endTime + "'";
		}

		hql +=" order by id desc";
		Pages page = this.questiondao.exHqlPages(hql, new Integer(pageNo), 10,
				null);
		List sList = page.getPageList();
		List addList = new ArrayList();
		// 得到所有立项的项目

		// 得到当前的登入人
		Employee employee = (Employee) this.request.getSession().getAttribute(
				"emp");
		// 得到回复次数
		for (int i = 0; i < sList.size(); i++) {
			Scheduleplan scheduleplan = (Scheduleplan) sList.get(i);
			List pList = this.questiondao.findByCount1(scheduleplan.getId());

			scheduleplan.setTmp(pList.size() + "");

			// 得到项目查看者
			String whql = "from NewWatch as nw where 1=1 and nw.project.id="
					+ scheduleplan.getFunction().getNewProject().getId();
			List wlist = this.questiondao.findObj(whql);
			if (wlist != null) {
				for (int m = 0; m < wlist.size(); m++) {
					NewWatch watch = (NewWatch) wlist.get(m);
					// 判断当前的登入人是否匹配查看者模式,如果匹配返回
					// System.out.println("领导评价人"+watch.getEmp().getId());
					if ((employee.getId()).toString().equals(
							(watch.getEmp().getId()).toString())) {
						scheduleplan.setTmp1("1");
					} else {
						scheduleplan.setTmp1("0");
					}
				}
			}
			// 查看当前登入人是否匹配以下三种模式的任意一种模式
			// 项目负责人
			// System.out.println("项目负责人"+scheduleplan.getFunction().getNewProject().getEmployee().getId());
			// 自身发布项目便签人
			// System.out.println("发布便签"+scheduleplan.getEmployee().getId());
			// 查看者也就是领导
			if(scheduleplan.getFunction() !=null){
				if ((employee.getId()).toString().equals(
						(scheduleplan.getFunction().getNewProject().getEmployee()
								.getId()).toString())
						|| (employee.getId()).toString().equals(
								scheduleplan.getEmployee().getId().toString())) {
					scheduleplan.setTmp2("2");
				} else {
					scheduleplan.setTmp2("0");
				}
			}
			addList.add(scheduleplan);
		}

		page.setPageList(addList);

		List newPro = this.questiondao.findBynewPro();
		request.setAttribute("newPro1", newPro);

		request.setAttribute("startTime", this.creattime);
		request.setAttribute("endTime", this.endTime);
		request.setAttribute("titlename", hidename);
		request.setAttribute("pid", questionname1);

		request.setAttribute("pages", page);
		request.setAttribute("schadulplan", page.getPageList());
		return "select";
	}

	/*
	 * 根据问题查询这个问题的所有评论
	 */
	public String selectId() throws Exception {

		String id = request.getParameter("id");
		int id1 = 0;
		if (id != null) {
			id1 = new Integer(id);
		}

		String testStr = request.getParameter("test");
		
		String empno = request.getParameter("quid");
		int quid = 0;
		if (empno != null) {
			quid = new Integer(empno);
		}

		// 得到具体的是任务还是领导评价问题
		String indexdemo = request.getParameter("indexdemo");
		int indexdemo1 = 0;
		if (indexdemo != null) {
			indexdemo1 = new Integer(indexdemo);
		}
		request.setAttribute("indexdemo", indexdemo1);
		try {
			String hql = "from NewProblem as npbl where 1=1";
			Integer count = 0;
			NewQuestion qList = null;
			if (id1 != 0) {
				hql += " and npbl.newQuestion.id=" + id;
				List problemList = this.questiondao.findByCount(id1);
				count = problemList.size();
				// 得到当前的ID的对象
				qList = (NewQuestion) this.questiondao.getObject("NewQuestion",
						id1).get(0);
				if(testStr == null)
				{
					boolean flag1 = this.questiondao.updatequsetion(
							qList.getPid() + 1, qList.getId());
				}
			}
			if (quid != 0) {
				hql += "and npbl.newQuestion.id=" + quid;
			}

			hql += " order by npbl.id desc";
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = this.questiondao.exHqlPages(hql, new Integer(pageNo),
					3, null);
			// 回复的次数
			request.setAttribute("pages", page);
			request.setAttribute("count", count);
			List list = null;
			if (id1 != 0) {
				list = this.questiondao.getObject("NewQuestion", id1);
			}
			if (quid != 0) {
				list = this.questiondao.getObject("NewQuestion", quid);
			}
			// 得到单个的问题
			NewQuestion newQuestion = (NewQuestion) list.get(0);
			request.setAttribute("question", newQuestion);

			// 得到当前的登入人
			Employee employee = (Employee) this.request.getSession()
					.getAttribute("emp");

			request.setAttribute("emp", employee);
		} catch (Exception e) {
			// e.printStackTrace();
			logger.error("根据问题查询这个问题的所有评论");
		}
		return "selectbyid";
	}

	/*
	 * 
	 */
	public String selectId1() throws Exception {
		String id = request.getParameter("id");

		int id1 = 0;
		if (id != null) {
			id1 = new Integer(id);
		}

		String empno = request.getParameter("quid");
		int quid = 0;
		if (empno != null) {
			quid = new Integer(empno);
		}
		String sid = request.getParameter("sid");
		Integer sid1 = 0;
		Scheduleplan scheduleplan1 = null;
		Employee employee1 = null;
		if (sid != null && !sid.equals("")) {
			sid1 = new Integer(sid);
			scheduleplan1 = (Scheduleplan) this.questiondao.getObject(
					"Scheduleplan", sid1).get(0);
			employee1 = (Employee) this.questiondao.getObject("Employee",
					scheduleplan1.getEmployee().getId()).get(0);
		}
		if (id1 != 0) {
			scheduleplan1 = (Scheduleplan) this.questiondao.getObject(
					"Scheduleplan", id1).get(0);
			employee1 = (Employee) this.questiondao.getObject("Employee",
					scheduleplan1.getEmployee().getId()).get(0);
		}
		if (quid != 0) {
			scheduleplan1 = (Scheduleplan) this.questiondao.getObject(
					"Scheduleplan", quid).get(0);
			employee1 = (Employee) this.questiondao.getObject("Employee",
					scheduleplan1.getEmployee().getId()).get(0);
		}
		request.setAttribute("scheduleplan1", scheduleplan1);
		request.setAttribute("emp1", employee1);
		// 得到具体的是任务还是领导评价问题
		String indexdemo = request.getParameter("indexdemo");
		int indexdemo1 = 0;
		if (indexdemo != null) {
			indexdemo1 = new Integer(indexdemo);
		}
		request.setAttribute("indexdemo", indexdemo1);

		try {
			String hql = "from NewProblem as npbl where 1=1";
			Integer count = 0;
			if (quid != 0) {
				hql += "and  npbl.scheduleplan.id=" + quid;
			}
			if (new Integer(sid1) != 0) {
				hql += " and npbl.scheduleplan.id = " + sid1;
			}
			if (id1 != 0) {
				hql += " and npbl.scheduleplan.id = " + id1;
			}
			hql += " order by npbl.time desc";
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = this.questiondao.exHqlPages(hql, new Integer(pageNo),
					3, null);
			// 回复的次数
			request.setAttribute("pages", page);

		} catch (Exception e) {
			logger.error("aa");
		}

		return "selectbyid";
	}

	/*
	 * 项目便签详情
	 */
	public String findByonesche() throws Exception {
		String id = request.getParameter("id");
		Scheduleplan scheduleplan = (Scheduleplan) this.questiondao.getObject(
				"Scheduleplan", new Integer(id)).get(0);
		request.setAttribute("sche", scheduleplan);
		return "onesche";
	}

	/*
	 * 添加评论请求
	 */
	public String addProblem() throws Exception {
		request.setCharacterEncoding("utf-8");
		// 添加一条评论的时候，就代表浏览了一次

		// 评论内容
		String contents = URLDecoder.decode(request.getParameter("contents"),
				"utf-8");
		// 所属问题
		Integer id = new Integer(request.getParameter("id"));
		// 所属问题还是领导评价
		Integer indexdemo = new Integer(request.getParameter("indexdemo"));
		// Demo
		String test = request.getParameter("test");
		Scheduleplan scheduleplan = null;
		NewQuestion newQuestion1 = null;
		if (test != null && !test.equals("")) {
			scheduleplan = (Scheduleplan) this.questiondao.getObject(
					"Scheduleplan", id).get(0);
		} else {
			newQuestion1 = (NewQuestion) this.questiondao.getObject(
					"NewQuestion", id).get(0);
		}

		// 分割字符
		if (contents.endsWith("<")) {
			int len = contents.indexOf("<");
			String str = contents.substring(0, len);
			this.newProblem.setContents(str);
		} else {
			this.newProblem.setContents(contents);
		}

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date = format.format(new Date()).toString();
		// System.out.println(date);
		// 设置时间
		this.newProblem.setTime(date);
		// 设置默认是否发帖还是结贴
		this.newProblem.setIsend(0);
		// 属于问题还是任务
		this.newProblem.setProblemortask(indexdemo);
		// 评论人
		Employee employee = (Employee) this.request.getSession().getAttribute(
				"emp");
		this.newProblem.setEmployee(employee);
		// 评论次数
		this.newProblem.setCount(0);
		// 所属问题
		if (newQuestion1 != null) {
			this.newProblem.setNewQuestion(newQuestion1);
		}
		// 保存所属问题
		this.request.setAttribute("question", newQuestion1);
		//
		if (scheduleplan != null) {
			this.newProblem.setScheduleplan(scheduleplan);
		}
		Integer quid = 0;
		if (indexdemo != 2) {
			quid = newQuestion1.getId();
		} else {
			quid = scheduleplan.getId();
		}

		boolean flag = this.questiondao.saveProblem(newProblem);
		if (flag == true) {
			logger.info("添加评论");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(quid);
		}

		return null;
	}

	/*
	 * 报表请求
	 */
	public String fusionCharts() throws Exception {
		/*
		 * 1.柱状图描述项目进度 默认为最近发起的一个项目
		 */
		// 所有的在进行中的项目
		String str1 = hidepro;
		String hqlpro = "from NewProject as np where np.projectstatus not in (0,1)";
		List proList = this.questiondao.findObj(hqlpro);
		request.setAttribute("proList", proList);
		if (hidepro != null && !hidepro.equals("")) {
			hqlpro += " and np.id =" + new Integer(hidepro);
		}
		List list = this.questiondao.findObj(hqlpro);

		request.setAttribute("list", list);

		/*
		 * 2.饼状图描述任务进度 默认为最近发起的一个项目
		 */
		// 最近立项的项目


		// 项目id 根据这个id来查询项目功能进度
		String hqlfunction = "from NewFunction as newf where 1=1 and newf.flag=0 and newf.parentid=-1";
		String pagehql = "from NewTask as nt where 1=1 and nt.flag=0";
		// System.out.println(str1);
		String id = this.questiondao.findObj1();
		NewProject newProject = null;
		if (str1 != null && !str1.equals("")) {

			Integer proid = new Integer(str1);
			hqlfunction += " and newf.newProject.id =" + proid;
			List proList2 = this.questiondao.getObject("NewProject", proid);
			if(proList2 !=null && proList2.size()>0)
			{
				newProject = (NewProject) proList2.get(0);
			}
		} else {
			if(id.trim().length()>0){
				hqlfunction += " and newf.newProject.id =" + new Integer(id);
				newProject = (NewProject) this.questiondao.getObject("NewProject",
						new Integer(id)).get(0);
				List prolist1 =  this.questiondao.getObject("NewProject", new Integer(id));
				if(prolist1 != null && prolist1.size()>0)
				{
					newProject = (NewProject)prolist1.get(0);
				}
			}
		}
		List functionList = this.questiondao.findObj(hqlfunction);
		// 默认的项目ID
		Integer num = 0;
		String strDemo = "";
		List alist = new ArrayList();
		
		for (int i = 0; i < functionList.size(); i++) {
			NewFunction newFunction = (NewFunction) functionList.get(i);
			num += (100 - newFunction.getFstate());
			// 根据任务编号找出所有子级任务。
			String hql="from NewFunction where flag=0 and parentid="+newFunction.getId();
			List parentlist=questiondao.findObj(hql);
			for(int j=0;j<parentlist.size();j++){
				NewFunction parentfun=(NewFunction)parentlist.get(j);
				strDemo+=parentfun.getId()+",";
			}
			strDemo += newFunction.getId()+",";
		}

		request.setAttribute("num", num);
		request.setAttribute("str", "未完成");
		request.setAttribute("functionList", functionList);
		// 得到当前的时间
		SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
		if(newProject!=null){
			// /得到开始时间
			request.setAttribute("startTime", newProject.getBegintime());
			// /得到结束时间
			request.setAttribute("endTime", newProject.getEndtime());
			request.setAttribute("nowTime", sm.format(new Date()));
			// 得到当前的项目名称
			request.setAttribute("proname", newProject.getProjectname());
		}
		// }

		// 项目下的所有项目功能

		/*
		 * //3.曲线图(要显示的每个人的项目进度) 默认的项目为：(最近上线的一个项目，即这个已经在进行中了或完成了的一个项目)
		 */
		// 得到一个项目的所有的参与人(邀请成功的人)
		// String parthql =
		// "from NewParticipator as np where 1=1 and np.isagree =2 and np.newProject.id="+new
		// Integer(id);
		// List partList = this.questiondao.findObj(parthql);
		// 根据每个人查询对应的个人进度
		// 得到一项目项目的所有项目功能

		// 判断function下的Id是否以","结尾
		boolean falg = strDemo.endsWith(",");

		Pages pages = null;
		if (falg == true && !strDemo.equals("") && strDemo != null) {
			String strTest = strDemo.substring(0, strDemo.length() - 1);
			pagehql += " and nt.function.id in(" + strTest + ")";
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			pages = this.questiondao.exHqlPages(pagehql, new Integer(pageNo),
					5, null);
		}
		request.setAttribute("pages", pages);
		if(pages != null){
			request.setAttribute("taskList", pages.getPageList());
		}

		/*
		 * 滚动
		 */
		// 得到当前的时间
		Date data2 = sm.parse(sm.format(new Date()).toString());
		Calendar c = Calendar.getInstance();
		Calendar c1 = Calendar.getInstance();
		c.setTime(data2);

		int inputday = c.get(Calendar.DAY_OF_YEAR);
		c.set(Calendar.DAY_OF_YEAR, inputday - 7);
		Date data4 = c.getTime();
		String time = sm.format(data4).toString();
		String endTime1 = sm.format(data2);
		// 在之前算出来看在Scheduleplan表里是否有s.taskid在NewFunction里是否有这个字段
		String testDemo = "";
		List scheList1 = this.questiondao
				.findObj("from Scheduleplan as s where 1=1 and s.function.id!=0");
		for (int m = 0; m < scheList1.size(); m++) {
			Scheduleplan scheduleplan = (Scheduleplan) scheList1.get(m);
			// 判断这个id在NewFunction里是否存在
			List listFunction = this.questiondao.getObject("NewFunction",
					scheduleplan.getFunction().getId());
			if (listFunction != null && listFunction.size() > 0) {
				testDemo += scheduleplan.getFunction().getId() + ",";
			}
		}
		String hql1 = "from Scheduleplan as s where 1=1 and s.function.id!=0 and s.begintime between '"
				+ time + "' and '" + endTime1 + "'";
		if (!testDemo.equals("") && testDemo != null) {
			String taskid = testDemo.substring(0, testDemo.length() - 1);
			hql1 += " and s.function.id in(" + taskid + ")";
		}

		List scheList = this.questiondao.findObj(hql1);
		request.setAttribute("scheList", scheList);
		request.setAttribute("hidepro", hidepro);
		request.setAttribute("questiondao", questiondao);

		return "fusion";
	}

	/****
	 * 创建问题列表 分（已创建问题，待解决问题）
	 */
	public String QuestionList() {
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		// 待解决的问题
		String hql2 = "from NewQuestion where handlestatus=1 and indexdemos=1";
		Pages page2 = this.questiondao.exHqlPages(hql2, new Integer(pageNo),
				10, null);
		request.setAttribute("pages", page2);
		request.setAttribute("waitquestionlist", page2.getPageList());
		// 得到当前登入人
		return "question";
	}

	public String findBymequestion() throws Exception {
		// 得到当前的登入人
		Employee employee = (Employee) this.request.getSession().getAttribute(
				"emp");
		// 已创建的问题列表
		String hql = "from NewQuestion as nq where indexdemos=1 and nq.employee.id="
				+ employee.getId();
		if (creattime != null && !creattime.equals("")) {
			hql += " and nq.lastdate >= '" + creattime + "'";
		}
		if (endTime != null && !endTime.equals("")) {
			hql += " and nq.lastdate <= '" + endTime + "' ";
		}
		if (hidename1 != null && !hidename1.equals("")) {
			hidename1 = URLDecoder.decode(hidename1,"utf-8");
			hql += " and nq.questionname like '%" + hidename1 + "%'";
		}
		hql += " order by lastdate desc";
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		Pages page = this.questiondao.exHqlPages(hql, new Integer(pageNo), 10,
				null);
		request.setAttribute("pages", page);
		request.setAttribute("questionlist", page.getPageList());

		request.setAttribute("startTime", this.creattime);
		request.setAttribute("endTime", this.endTime);
		request.setAttribute("titlename", this.hidename1);
		return "find";

	}

	/*
	 * 创建项目问题
	 */
	public String createproUI() throws Exception {
		try {
			// 得到当前的登入人
			Employee employee = (Employee) this.request.getSession()
					.getAttribute("emp");
			request.setAttribute("emp", employee);
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String datanowTime = dateFormat.format(new Date());
			request.setAttribute("nowTime", datanowTime);
		} catch (Exception e) {
			logger.error("创建项目问题QuestionProJectAction.createproUI()!");
		}
		return "createUI";
	}

	/*
	 * 添加问题和修改问题操作
	 */
	public String createPro() throws Exception {
		try {
			// 得到附件
			// 问题名称
			String questionname = URLDecoder.decode(request
					.getParameter("questionname"), "utf-8");
			// 最后期限
			String lasttime = URLDecoder.decode(request
					.getParameter("lasttime"), "utf-8");
			// 问题描述
			String contents = URLDecoder.decode(request
					.getParameter("contents"), "utf-8");
			String coString = contents.trim();
			// 得到索引

			// 添加到newQuestion
			this.newQuestion.setQuestionname(questionname);
			this.newQuestion.setLastdate(lasttime);
			this.newQuestion.setQuestioninfo(coString);

			// /附件添加
			// pid为点击率
			this.newQuestion.setPid(0);
			this.newQuestion.setHandlestatus(0);
			this.newQuestion.setIndexdemos(1);
			this.newQuestion.setFj("0");

			// 得到当前登入人
			Employee employee = (Employee) this.request.getSession()
					.getAttribute("emp");
			this.newQuestion.setEmployee(employee);
			// 添加操作

			boolean flag = this.questiondao.saveQuestion(newQuestion);

			response.setCharacterEncoding("utf-8");
			if (flag == true) {
				logger.info("添加项目问题成功");
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.error("创建项目问题!questionProjectAction.createPro");
		}
		return null;
	}

	public String updateUI() throws Exception {
		try {
			// 问题名称
			String questionname = URLDecoder.decode(request
					.getParameter("questionname"), "utf-8");
			// 最后期限
			String lasttime = URLDecoder.decode(request
					.getParameter("lasttime"), "utf-8");
			// 问题描述
			String contents = URLDecoder.decode(request
					.getParameter("contents"), "utf-8");
			// 得到索引
			// 得到ID值
			String cString = contents.trim();
			if (cString.startsWith("<", 0) || cString.endsWith(">")) {
				String strT = cString.substring(3, cString.length() - 3);
				this.newQuestion.setQuestioninfo(strT);
			} else {
				this.newQuestion.setQuestioninfo(cString);
			}
			String quid = request.getParameter("quid");

			// 添加到newQuestion
			this.newQuestion.setQuestionname(questionname);
			this.newQuestion.setLastdate(lasttime);

			// /附件添加
			// this.newQuestion.setFj(filename);
			// pid为点击率
			this.newQuestion.setPid(0);
			this.newQuestion.setHandlestatus(0);
			this.newQuestion.setIndexdemos(1);
			this.newQuestion.setFj("0");

			// 得到当前登入人
			Employee employee = (Employee) this.request.getSession()
					.getAttribute("emp");
			this.newQuestion.setEmployee(employee);
			// 添加操作
			// 修改操作
			Integer quid1 = new Integer(quid);
			this.newQuestion.setId(quid1);
			boolean flag = this.questiondao.updateQuestion(newQuestion);
			response.setCharacterEncoding("utf-8");
			if (flag == true) {
				logger.info("修改问题成功");
				response.getWriter().print("3");
			} else {
				response.getWriter().print("4");
			}

		} catch (Exception e) {

		}
		return null;
	}

	/*
	 * 修改未提交上去的问题
	 */
	public String updatequestion() throws Exception {
		// 得到要修改的项目问题
		String id = request.getParameter("questids");
		Integer questid = 0;
		if (id != null) {
			questid = new Integer(id);
			NewQuestion newQuestion = (NewQuestion) this.questiondao.getObject(
					"NewQuestion", questid).get(0);
			request.setAttribute("question", newQuestion);

			// /得到当前登入人
			Employee employee = (Employee) this.request.getSession()
					.getAttribute("emp");
			request.setAttribute("emp", employee);
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String datanowTime = dateFormat.format(new Date());
			request.setAttribute("nowTime", datanowTime);

			return "createUI";
		}
		return null;
	}

	/*
	 * 删除请求(项目问题)
	 */
	public String delquestion() throws Exception {
		try {
			Integer questid1 = Integer.parseInt(request
					.getParameter("questid1"));
			NewQuestion newQuestion = (NewQuestion) this.questiondao.getObject(
					"NewQuestion", questid1).get(0);

			boolean falg = this.questiondao.del(newQuestion);
			if (falg == true) {
				response.setCharacterEncoding("utf-8");
				response.getWriter().print("1");
			}
		} catch (Exception e) {
			logger.error("删除问题questionProjectAction.delquestion()");
		}

		return null;
	}

	/*
	 * 提交问题
	 */
	public String uploadstate() throws Exception {
		try {
			Integer questid2 = Integer.parseInt(request
					.getParameter("questid2"));
			boolean flag = this.questiondao.updatastate(1, questid2);
			response.setCharacterEncoding("utf-8");
			if (flag == true) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.error("提交问题questionProjectAction.uploadstate()");
		}
		return null;
	}

	/*
	 * 详情(个人项目问题)
	 */
	public String findByquestion() throws Exception {
		try {
			Integer questid3 = Integer.parseInt(request
					.getParameter("questid3"));
			NewQuestion newQuestion = (NewQuestion) this.questiondao.getObject(
					"NewQuestion", questid3).get(0);
			request.setAttribute("newquest", newQuestion);
		} catch (Exception e) {
			logger.error("详情questionProjectAction.findByquestion()");
		}
		return "showquestion";
	}

	public String jietie() throws Exception {
		try {
			// 结贴的ID
			Integer questid = new Integer(request.getParameter("questid"));
			boolean falg = this.questiondao.updatastate(2, questid);
			response.setCharacterEncoding("utf-8");
			if (falg == true) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.error("结贴questionProjectAction.jietie()");
		}
		return null;
	}

	/*
	 * 历史记录请求
	 */
	public String historyquestion() throws Exception {
		// 查询所有的问题的浏览次数，回复次数
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String hql = "from NewQuestion as nq where 1=1 and nq.handlestatus not in(0)";
		Pages page = this.questiondao.exHqlPages(hql, new Integer(pageNo), 10,
				null);

		List qlist = page.getPageList();

		List listq = new ArrayList();
		for (int i = 0; i < qlist.size(); i++) {
			NewQuestion question = (NewQuestion) qlist.get(i);
			List list = this.questiondao.findByCount(question.getId());
			question.setTemp1(list.size() + "");
			listq.add(question);
		}

		page.setPageList(listq);

		request.setAttribute("pages", page);
		request.setAttribute("tempList", page.getPageList());
		return "history";
	}

	/*
	 * 上传附件
	 */
	
	public File getFiledata1() {
		return filedata1;
	}

	public void setFiledata1(File filedata1) {
		this.filedata1 = filedata1;
	}

	public NewQuestion getNewQuestion() {
		return newQuestion;
	}

	public void setNewQuestion(NewQuestion newQuestion) {
		this.newQuestion = newQuestion;
	}

	public QuestionProject getQuestiondao() {
		return questiondao;
	}

	public void setQuestiondao(QuestionProject questiondao) {
		this.questiondao = questiondao;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public StockpileDetailsBussiness getStockpileDetailsBussiness() {
		return stockpileDetailsBussiness;
	}

	public void setStockpileDetailsBussiness(
			StockpileDetailsBussiness stockpileDetailsBussiness) {
		this.stockpileDetailsBussiness = stockpileDetailsBussiness;
	}

	public NewProblem getNewProblem() {
		return newProblem;
	}

	public void setNewProblem(NewProblem newProblem) {
		this.newProblem = newProblem;
	}

	public String getQuestionfilePath() {
		return questionfilePath;
	}

	public void setQuestionfilePath(String questionfilePath) {
		this.questionfilePath = questionfilePath;
	}

	public Project getProjectdao() {
		return projectdao;
	}

	public void setProjectdao(Project projectdao) {
		this.projectdao = projectdao;
	}

	public String getCreattime() {
		return creattime;
	}

	public void setCreattime(String creattime) {
		this.creattime = creattime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getQuestionname1() {
		return questionname1;
	}

	public void setQuestionname1(String questionname1) {
		this.questionname1 = questionname1;
	}

	public String getHidename() {
		return hidename;
	}

	public void setHidename(String hidename) {
		this.hidename = hidename;
	}

	public String getHidename1() {
		return hidename1;
	}

	public void setHidename1(String hidename1) {
		this.hidename1 = hidename1;
	}

	public String getHidepro() {
		return hidepro;
	}

	public void setHidepro(String hidepro) {
		this.hidepro = hidepro;
	}
	public static void main(String[] args) {
		QuestionProjectAction action = new QuestionProjectAction();
		action.getQuestiondao().findObj("from NewPrjtresource where 1=1");
		
	}
}
