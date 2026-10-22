package com.fuao.fajxc.action.basic;

import javax.servlet.ServletContext;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import sun.org.mozilla.javascript.internal.Undefined;

import com.fuao.fajxc.action.system.UploadAction;
import com.fuao.fajxc.bussiness.FbManipulateBussiness;
import com.fuao.fajxc.bussiness.FieldPropertyBussiness;
import com.fuao.fajxc.bussiness.FieldRemarkBussiness;
import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.bussiness.UserRelationBussiness;
import com.fuao.fajxc.bussiness.basic.DepartmentBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.mission.MissiontypeBussiness;
import com.fuao.fajxc.bussiness.system.UploadBussiness;
import com.fuao.fajxc.util.PageBean;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StrUtil;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.UtilCommon;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.EmployeeFjfb;
import com.fuao.fajxc.vo.EmployeeGrade;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.FieldProperty;
import com.fuao.fajxc.vo.FieldRemark;
import com.fuao.fajxc.vo.IntentFollowUp;
import com.fuao.fajxc.vo.Leavesimple;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.UserRelation;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.ibm.icu.text.SimpleDateFormat;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.xml.internal.ws.api.server.SDDocument;

import java.util.UUID;

public class EmployeeAction implements ServletRequestAware, ModelDriven,
		ServletResponseAware {

	private static Logger logger = Logger.getLogger(EmployeeAction.class);
	private Employee emp;
	private Leavesimple leavesimple;
	private EmployeeBussiness empBussiness;
	private DepartmentBussiness dembussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private UploadBussiness uploadbiz;
	private FbManipulateBussiness fbManipulateBussiness;
	private UserRelationBussiness userRelationBussiness;
	private FieldPropertyBussiness fieldPropertyBussiness;
	private FieldRemarkBussiness fieldRemarkBussiness;
	private MissiontypeBussiness missiontypeBussiness;
	private Object[] ids;
	private int page; // 第几页
	private String fjids;
	private List<UserRelation> listfjjtcy;
	private List<FieldProperty> listFieldProperty;
	private FieldProperty fieldProperty;
	private FieldRemark fieldRemark;
	private List<FieldRemark> listFieldRemark;
	private LoginBussiness loginBussiness;
	private static final long serialVersionUID = -4848248679889814408L;
	//入职的开始，结束时间条件查询
	private String rzbegintime;
	private String rzendtime;
	private Integer empid;
	private Integer depid;
	private String sname;
	
	// 出生日期的开始，结束时间条件查询
	private String csbegintime;
	private String csendtime;
	// 标识是否是dc
	private String dc;
	private String money1;//审核业务额度页面传过来的参数
	private String money2;
	private String money3;
	private String money4;
	private String money5;
	private String money6;
	private String money7;
	private String money8;
	private String money9;
	private String money10;
	private String money11;
	private String money12;
	private String jd1;
	private String jd2;
	private String jd3;
	private String jd4;
	private String sbn;
	private String xbn;
	private String year;
	private String fileRealName;
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	
	public MissiontypeBussiness getMissiontypeBussiness() {
		return missiontypeBussiness;
	}

	public void setMissiontypeBussiness(MissiontypeBussiness missiontypeBussiness) {
		this.missiontypeBussiness = missiontypeBussiness;
	}

	public String getMoney1() {
		return money1;
	}

	public void setMoney1(String money1) {
		this.money1 = money1;
	}

	public String getMoney2() {
		return money2;
	}

	public void setMoney2(String money2) {
		this.money2 = money2;
	}

	public String getMoney3() {
		return money3;
	}

	public void setMoney3(String money3) {
		this.money3 = money3;
	}

	public String getMoney4() {
		return money4;
	}

	public void setMoney4(String money4) {
		this.money4 = money4;
	}

	public String getMoney5() {
		return money5;
	}

	public void setMoney5(String money5) {
		this.money5 = money5;
	}

	public String getMoney6() {
		return money6;
	}

	public void setMoney6(String money6) {
		this.money6 = money6;
	}

	public String getMoney7() {
		return money7;
	}

	public void setMoney7(String money7) {
		this.money7 = money7;
	}

	public String getMoney8() {
		return money8;
	}

	public void setMoney8(String money8) {
		this.money8 = money8;
	}

	public String getMoney9() {
		return money9;
	}

	public void setMoney9(String money9) {
		this.money9 = money9;
	}

	public String getMoney10() {
		return money10;
	}

	public void setMoney10(String money10) {
		this.money10 = money10;
	}

	public String getMoney11() {
		return money11;
	}

	public void setMoney11(String money11) {
		this.money11 = money11;
	}

	public String getMoney12() {
		return money12;
	}

	public void setMoney12(String money12) {
		this.money12 = money12;
	}

	public String getJd1() {
		return jd1;
	}

	public void setJd1(String jd1) {
		this.jd1 = jd1;
	}

	public String getJd2() {
		return jd2;
	}

	public void setJd2(String jd2) {
		this.jd2 = jd2;
	}

	public String getJd3() {
		return jd3;
	}

	public void setJd3(String jd3) {
		this.jd3 = jd3;
	}

	public String getJd4() {
		return jd4;
	}

	public void setJd4(String jd4) {
		this.jd4 = jd4;
	}

	public String getSbn() {
		return sbn;
	}

	public void setSbn(String sbn) {
		this.sbn = sbn;
	}

	public String getXbn() {
		return xbn;
	}

	public void setXbn(String xbn) {
		this.xbn = xbn;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getDc() {
		return dc;
	}

	public void setDc(String dc) {
		this.dc = dc;
	}

	public String getRzbegintime() {
		return rzbegintime;
	}

	public void setRzbegintime(String rzbegintime) {
		this.rzbegintime = rzbegintime;
	}

	public String getRzendtime() {
		return rzendtime;
	}

	public void setRzendtime(String rzendtime) {
		this.rzendtime = rzendtime;
	}

	public String getCsbegintime() {
		return csbegintime;
	}

	public void setCsbegintime(String csbegintime) {
		this.csbegintime = csbegintime;
	}

	public String getCsendtime() {
		return csendtime;
	}

	public void setCsendtime(String csendtime) {
		this.csendtime = csendtime;
	}

	// 添加动态记录的业务类
	private ExecuteRecordBussiness executeRecordBussiness;

	public Leavesimple getLeavesimple() {
		return leavesimple;
	}

	public void setLeavesimple(Leavesimple leavesimple) {
		this.leavesimple = leavesimple;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public LoginBussiness getLoginBussiness() {
		return loginBussiness;
	}

	public void setLoginBussiness(LoginBussiness loginBussiness) {
		this.loginBussiness = loginBussiness;
	}
	public Employee getEmp() {
		return emp;
	}

	public void setEmp(Employee emp) {
		this.emp = emp;
	}


	/**
	 * 查找所有员工信息
	 * 
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public String select() throws IOException {
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		
		// 获得权限标识
		Map map = (Map) ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);

		// 页码
		String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
		String addhql = "";

		if (null != emp.getName() && "" != emp.getName()
				&& !emp.getName().equals("")) {
			addhql += " and name like '%"
					+ URLDecoder.decode(emp.getName(), "UTF-8") + "%'";

		}
		if (null != emp.getSex()) {
			addhql += " and sex = " + emp.getSex();

		}
		if (null != emp.getAge()) {
			addhql += " and age = " + emp.getAge();

		}
		if (null != emp.getBirth() && emp.getBirth() != "") {
			addhql += " and birth like '%"
					+ URLDecoder.decode(emp.getBirth(), "UTF-8") + "%'";

		}
		if (null != emp.getTel() && emp.getTel() != "") {
			addhql += " and tel like '%"
					+ URLDecoder.decode(emp.getTel(), "UTF-8") + "%'";

		}

		if (null != emp.getEducation() && emp.getEducation() != ""
				&& !emp.getEducation().equals("")) {
			addhql += " and education like '%"
					+ URLDecoder.decode(emp.getEducation(), "UTF-8") + "%'";

		}
		if (null != emp.getDepartment()
				&& null != emp.getDepartment().getName()
				&& emp.getDepartment().getName() != ""
				&& !emp.getDepartment().getName().equals("")) {
			addhql += " and department.name like '%"
					+ URLDecoder.decode(emp.getDepartment().getName(), "UTF-8")
					+ "%'";

		}
		if (null != emp.getEntryTime() && emp.getEntryTime() != "") {
			addhql += " and entryTime like '%"
					+ URLDecoder.decode(emp.getEntryTime(), "UTF-8") + "%'";

		}
		if (null != emp.getGroups() && null != emp.getGroups().getGroupName()
				&& emp.getGroups().getGroupName() != "") {
			addhql += " and groups.groupName like '%"
					+ URLDecoder
							.decode(emp.getGroups().getGroupName(), "UTF-8")
					+ "%'";

		}
		if (null != emp.getEmpNo() && emp.getEmpNo() != "") {
			addhql += " and empNo like '%"
					+ URLDecoder.decode(emp.getEmpNo(), "UTF-8") + "%'";

		}
		if (null != emp.getIsLeave()) {
			addhql += " and isLeave = " + emp.getIsLeave();

		}
		String ss=request.getParameter("ss");
		System.out.println(ss);
		String ename=request.getParameter("ename");
		if(ename==null){
			ename="";
		}
		
		System.out.println(ename);
		if(ss!=null){
			String ename2=request.getParameter("ename2");
			request.getSession().setAttribute("ename02", ename2);
			System.out.println(ename2);
		}
		addhql += " and name like '%"+ename+"%'";
		
		String hql = "from Employee where delflag=0 and 1=1" + addhql; 
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by isLeave desc , id desc ";
		
		
		System.out.println(hql);
		Pages pages = empBussiness.paginationQuery(hql, Integer
				.parseInt(pageNo), 20, null);

		for (int i = 0; i < pages.getPageList().size(); i++) {
			Employee emp = (Employee) pages.getPageList().get(i);
			// 得到今天的时间判断此员工今天有没有请假。
			List leavelist = empBussiness.getLeavesimpleByEmpid(emp.getId());
			if (leavelist.size() > 0) {
				emp.setIsqj("1");
				pages.getPageList().set(i, emp);
			}
		}
		if (request.getParameter("tage") != null
				&& request.getParameter("tage").equals("s")) {
			PropertyEditor property = new PropertyEditor();
			String strr = "";
			String str = "";
			if (null != pages.getPageList() && pages.getPageList().size() > 0) {
				for (int i = 0; i < pages.getPageList().size(); i++) {
					Employee emp = new Employee();
					emp = (Employee) pages.getPageList().get(i);
					str = property.getID("selectemp").toString();
					String sex = emp.getSex() == 1 ? "男" : "女";
					String isLeave = emp.getIsLeave() == 0 ? "离职" : "在职";
					str = str.replace("#name#", emp.getName());
					str = str.replace("#sex#", sex);
					str = str.replace("#age#", emp.getAge() + "");
					str = str.replace("#birth#", emp.getBirth());
					str = str.replace("#tel#", emp.getTel());
					str = str.replace("#education#", emp.getEducation());
					str = str.replace("#departmentName#", emp.getDepartment()
							.getName());
					str = str.replace("#groupsName#", emp.getGroups()
							.getGroupName());
					str = str.replace("#empNo#", emp.getEmpNo());
					str = str.replace("#entryTime#", emp.getEntryTime());
					str = str.replace("#isLeave#", isLeave);
					str = str.replace("#id#", emp.getId() + "");
					strr += str;
				}
				pages.setUrl("selectemp.do?deptid=all&funid=14");
				strr += "#" + pages.getHtml("selectemp");
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(strr);
			System.out.println(strr);
			return null;

		}
		request.setAttribute("pages", pages);
		return "yqsuccess";
	}
	
	
	/**
	 * 查找所有员工信息
	 * 
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public String select2() throws IOException {
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		// 得到所有的部门
		List deptlist= empBussiness.selDep("");
		
		request.setAttribute("deptlist", deptlist);
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		
		// 获得权限标识
		Map map = (Map) ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);

		// 页码
		String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
		String addhql = "";
      if(emp!=null){
		if (null != emp.getName() && "" != emp.getName()
				&& !emp.getName().equals("")) {
			addhql += " and name like '%"
					+ URLDecoder.decode(emp.getName(), "UTF-8") + "%'";
			this.emp.setName(URLDecoder.decode(emp.getName(), "UTF-8"));
		}
		if(emp.getSex()!=null && -1 != emp.getSex()) {
			addhql += " and sex = " + emp.getSex();

		}

		if (null != emp.getEducation() && !emp.getEducation().equals("-1")) {
			addhql += " and education='"
					+ URLDecoder.decode(emp.getEducation(), "UTF-8") + "'";
            this.emp.setEducation(URLDecoder.decode(emp.getEducation(), "UTF-8"));
		}
		if (null != emp.getDepartment() && emp.getDepartment().getId()!=-1) {
			addhql += " and department.id="+emp.getDepartment().getId();
		}
		if (null != emp.getEmpNo() && !emp.getEmpNo().equals("")) {
			addhql += " and empNo like '%"
					+ URLDecoder.decode(emp.getEmpNo(), "UTF-8") + "%'";
		}
		if (null != emp.getIsLeave() && emp.getIsLeave()!=-1) {
			addhql += " and isLeave = " + emp.getIsLeave();
		}
		// 判断入职时间
		if(this.rzbegintime!=null && !this.rzbegintime.equals("")){
			addhql+=" and entryTime>='"+rzbegintime+"'";
			request.setAttribute("rzbegintime", rzbegintime);
		}
		if(this.rzendtime!=null && !this.rzendtime.equals("")){
			addhql+=" and entryTime<='"+rzendtime+"'";
			request.setAttribute("rzendtime", rzendtime);
		}
		// 出生日期
		if(this.csbegintime!=null && !this.csbegintime.equals("")){
			addhql+=" and birth>='"+this.csbegintime+"'";
			request.setAttribute("csbegintime", csbegintime);
		}
		if(this.csendtime!=null && !this.csendtime.equals("")){
			addhql+=" and birth<='"+this.csendtime+"'";
			request.setAttribute("csendtime", csendtime);
		}
      }
		
		String hql = "from Employee where delflag=0 and 1=1" + addhql; 
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by isLeave desc , id desc ";
		
		
		System.out.println(hql);
		Pages pages = empBussiness.paginationQuery(hql, Integer
				.parseInt(pageNo), 20, null);

		for (int i = 0; i < pages.getPageList().size(); i++) {
			Employee emp = (Employee) pages.getPageList().get(i);
			// 得到今天的时间判断此员工今天有没有请假。
			List leavelist = empBussiness.getLeavesimpleByEmpid(emp.getId());
			if (leavelist.size() > 0) {
				emp.setIsqj("1");
				pages.getPageList().set(i, emp);
			}
		}
		if(this.dc!=null && this.dc.equals("1")){
			request.setAttribute("emplist", pages.getPageList());
			return "dcsuccess";
		}else{
			request.setAttribute("pages", pages);
			return "success";
		}
	}
	
	
	
    public void selectf() throws IOException{
    	String name=(String) request.getSession().getAttribute("ename02");
    	System.out.println(name);
    	if(name!=null){
    	 response.setContentType("text/html;charset=GBk");
         response.getWriter().print(name);
    	}else{
    	response.getWriter().print("");
    	}
    }

	

	/**
	 * 返回某个部门的的员工
	 * 
	 * @return "selectempbydept"
	 */
	public String Dept() {

		Map map = (Map) ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		String strdeptid = request.getParameter("deptid");
		int deptid = 0;

		if (strdeptid == null || strdeptid.equals("")) {
			strdeptid = (String) request.getSession().getAttribute("sdeptid");
			if (strdeptid == null || strdeptid.equals("")) {
				deptid = 0;
			} else {
				deptid = Integer.valueOf(strdeptid);
			}
		} else {
			request.getSession().setAttribute("sdeptid", deptid);
			deptid = Integer.valueOf(strdeptid);
		}

		String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
		String addhql = " and department.id=" + deptid + " ";
		//
		String hql = "from Employee where delflag=0 and isLeave=1 " + addhql
				+ " order by isLeave desc , id desc ";
		logger.info(hql);
		Pages pages = empBussiness.paginationQuery(hql, Integer
				.parseInt(pageNo), 20, null);
		request.setAttribute("pages", pages);
		// logger.info(pages.getPageList().size());

		return "selectempbydept";
	}

	/**
	 * 添加员工时查询所有部门
	 * 
	 * @return
	 */

	public String addShow() {
		List list = empBussiness.selDep("");
		List<EmployeeGrade> list1=empBussiness.emplevel();//员工级别
		String Hql="from Workposition";
		String Hql1="from WorkpositionEmployee";
		List list2=empBussiness.selectObect(Hql);
		List list3=empBussiness.selectObect(Hql1);
		request.setAttribute("list1", list1);
		request.setAttribute("list3", list3);
		request.setAttribute("list2", list2);
		System.out.println(list.size());
		request.getSession().setAttribute("depList", list);
		System.out.println(".........................................1");
		// 查询字段表标题 start
		List<FieldRemark> listFieldRemark = fieldRemarkBussiness
				.getFieldRemarkByEntityName("Employee");
		// List<FieldRemark> listFieldRemark =
		// fieldRemarkBussiness.getFieldRemarkAll("from FieldRemark fr where 1 = 1 and fr.beanNames like '%Employee%' ");
		if (null != listFieldRemark && listFieldRemark.size() > 0) {
			for (int i = 0; i < listFieldRemark.size(); i++) {
				// 获取字段表每个对象 for( Iterator it = set.iterator(); )
				System.out.println(listFieldRemark.get(i).getName());
				// 使用set循环获取每组类型包括具体数据
				for (Iterator it = listFieldRemark.get(i).getFieldProperties()
						.iterator(); it.hasNext();) {
					FieldProperty f = (FieldProperty) it.next();
					if ("Employee".equals(f.getBeanName())
							&& f.getBeanUuid() == "") {
						System.out
								.println("Debugging MC --->     --->    --->   it.next = "
										+ f.getTemp1());
					}
				}
			}
			request.setAttribute("listallf", listFieldRemark);
			request.setAttribute("beanName", "Employee");
			request.setAttribute("addfp", "1");
		}
		// 查询字段表标题 end
		request.setAttribute("addshowemp", 1);
		return "add";
	}

	/**
	 * 添加员工
	 * 
	 * @rturn
	 * @throws IOException
	 */
	public String add() throws IOException {
		if (null == emp || emp == null) {
			System.out.println("Debugging MC --->     --->  员工对象为空");
		}
		// 去掉员工编号空格
		if (emp.getEmpNo() != null) {
			emp.setEmpNo(emp.getEmpNo().replace(" ", ""));
		}
		// 职位ID
		String position = request.getParameter("position");
		if (position != null) {
			System.out.println("position = " + position);
			List<Groups> grouplist = empBussiness.ObjectList("Groups",
					" and groupId = " + Integer.parseInt(position));
			if (grouplist.size() > 0) {
				emp.setGroups(grouplist.get(0));
			}
		}
		// 部门ID
		String depid = request.getParameter("depid");
		if (depid != null) {
			System.out.println("Debugging MC --->     --->  depid = " + depid);
			if (!depid.equals("-1")) {
				Department dep = dembussiness.onedep(" and id="
						+ Integer.parseInt(depid));
				emp.setDepartment(dep);
			}
		}
		// 添加相片
		String name = (String) request.getSession().getAttribute("sczj1");
		if (name != null) {
			System.out.println(name);
			emp.setPhoto(name);
			request.getSession().removeAttribute("sczj1");
		}

		// 添加员工
		emp.setUuid(UUID.randomUUID().toString());
		Employee employee = empBussiness.addReturnEmp(emp, listFieldProperty,
				request);
		if (employee == null) {
			System.out.println("Debugging MC --->   Action中  --->  添加员工失败");
			response.setContentType("text/html;charset=GBK");
			response
					.getWriter()
					.print(
							"<script>alert('添加员工信息失败');window.location.href='selectemp.do';</script>");// 失败
			return null;
		}
		// 添加字段表
		if (null == listFieldProperty || listFieldProperty.size() < 1) {
			System.out
					.println("Debugging MC --->     --->  listFieldProperty 是空的");
		} else {
			for (int i = 0; i < listFieldProperty.size(); i++) {
				FieldProperty fieldProperty = listFieldProperty.get(i);
				if (null != fieldProperty) {
					fieldProperty.setBeanName("Employee");
					fieldProperty.setUuid(UUID.randomUUID().toString());
					fieldProperty.setBeanUuid(emp.getUuid());
					// 添加到字段表中
					if (fieldPropertyBussiness.addFieldProperty(fieldProperty) == 1) {
						System.out
								.println("Debugging MC --->     --->  字段属性表fieldProperty添加成功");
					} else {
						System.out
								.println("Debugging MC --->     --->  字段属性表FieldProperty添加失败");
					}
				} else {
					System.out
							.println("Debugging MC --->     --->  字段属性表listFieldProperty为空");
				}
			}
		}
		response.setContentType("text/html;charset=GBK");
		response
				.getWriter()
				.println(
						"<script>alert('添加成功');window.location.href='selectemp.do';</script>");// 成功

		/* 阙超强 14015 添加记录动态信息 */
		// 拿到登陆员工用户
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		// 添加记录到动态记录表
		if (loginEmp != null) {
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个员工信息。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(employee.getId().toString());
			executerecord.setEntityName("Employee");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}

		return null;
	}

	/**
	 * 检查员工身份证件号码是否存在
	 * 
	 * @throws IOException
	 */
	public void ckIdentity() throws IOException {
		String name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
		Employee emp11 = empBussiness.getEmployeeByEmpIdentity(name);
		if (null != emp11 && emp11 != null) {
			response.getWriter().println(1); // 重复
		} else {
			if (name.length() == 15 || name.length() == 18) {
				response.getWriter().println(0); // 可以添加员工编号
			} else {
				response.getWriter().print(2);// 身份证件号码格式不正确
			}

		}
	}

	/**
	 * 检查员工工号是否存在
	 * 
	 * @throws IOException
	 */
	public void ckno() throws IOException {
		String name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
		Employee emp11 = empBussiness.getEmployeeByEmpNo(name);
		if (null != emp11 && emp11 != null) {
			response.getWriter().println(1); // 重复
		} else {
			response.getWriter().println(0); // 可以添加员工编号
		}
	}

	/**
	 * 根据员工ID 查询员工信息
	 * 
	 * @return
	 */
	public String show() {
		String strId = request.getParameter("id");
		if ("" == strId || strId == "") {
			strId = "";
		}
		int id = Integer.parseInt(strId);
		Employee emp1 = empBussiness.oneEmp(id);
		List<EmployeeFjfb> list = uploadbiz.selectEmpById(id + "");
		if (null != list && list.size() > 0) {// 上传的附件
			request.setAttribute("fjlb", list);
		}
		// 查询字段表标题 start
		List<FieldRemark> listFieldRemark = fieldRemarkBussiness
				.getFieldRemarkByEntityName("Employee");

		if (null != listFieldRemark && listFieldRemark.size() > 0) {
			// 打印给调试者看
			for (int i = 0; i < listFieldRemark.size(); i++) {
				// 获取字段表每个对象 for( Iterator it = set.iterator(); )
				System.out.println("==============================="
						+ listFieldRemark.get(i).getName());
				// 使用set循环获取每组类型包括具体数据
				for (Iterator it = listFieldRemark.get(i).getFieldProperties()
						.iterator(); it.hasNext();) {
					FieldProperty f = (FieldProperty) it.next();
					if ("Employee".equals(f.getBeanName())
							&& f.getBeanUuid().equals(emp1.getUuid())) {
					}
				}
			}
			// 打印给调试者看

			// 把字段属性表的集合获取出来，条件：员工表名、员工UUID、
			List<FieldProperty> listFieldProperty = fieldPropertyBussiness
					.getFieldPropertyByBeanAndBeanName("Employee", emp1
							.getUuid());

			if (null != listFieldProperty && listFieldProperty.size() > 0) {
				for (int i = 0; i < listFieldProperty.size(); i++) {
				}
			}
			request.setAttribute("listFieldProperty", listFieldProperty);
			request.getSession().setAttribute("sessionListFp",
					listFieldProperty);
			request.setAttribute("listallf", listFieldRemark);
			request.setAttribute("beanName", "Employee");
		}
		// 查询字段表标题 end

		request.setAttribute("showemp", emp1);
		return this.addShow();
	}

	/**
	 * 修改员工信息
	 * 
	 * @return
	 */
	public String edit() {
		if (null == emp || emp == null) {
			System.out.println("Debugging MC --->     --->  员工对象为空");
		}
		// 员工ID
		String strId = request.getParameter("id");
		System.out.println("Debugging MC --->     --->  需要修改的员工ID = " + strId);
		if (strId != null) {
			int id = Integer.parseInt(strId);
			emp.setId(id);
		}
		// 职位ID
		String position = request.getParameter("position");
		if (position != null) {
			System.out.println("Debugging MC --->     --->  position = "
					+ position);
			List<Groups> grouplist = empBussiness.ObjectList("Groups",
					" and groupId = " + Integer.parseInt(position));
			if (grouplist.size() > 0) {
				emp.setGroups(grouplist.get(0));
			}
		}
		// 部门ID
		String depid = request.getParameter("depid");
		if (depid != null) {
			System.out.println("Debugging MC --->     --->  depid = " + depid);
			if (!depid.equals("-1")) {
				Department dep = dembussiness.onedep(" and id="
						+ Integer.parseInt(depid));
				emp.setDepartment(dep);
			}
		}
		if (empBussiness.updateEmp(emp, request)) { // 修改员工成功后
			System.out
					.println("Debugging MC --->  修改员工基本信息成功   --->  接下来修改字段属性表  --->   ");
			List<FieldProperty> listFpSession = (List<FieldProperty>) request
					.getSession().getAttribute("sessionListFp");

			if (null != listFpSession && listFpSession.size() > 0) {// 获取的Session字段属性集合不为空
				for (int i = 0; i < listFpSession.size(); i++) {
					FieldProperty fp = listFpSession.get(i);
					if (null != fp && fp != null && fp.getId() != null) {
						if (fieldPropertyBussiness.deleteFieldProperty(fp) > 0) { // 删除
							System.out
									.println("Debugging MC action ---> 删除字段属性成功");
						} else {
							System.out
									.println("Debugging MC --->  action   --->  删除字段属性失败");
						}
					}
				}
				request.getSession().removeAttribute("sessionListFp");// 删除Session
			} else {
				System.out.println("Session中字段表List获取为空");
			}
			if (null != listFieldProperty && listFieldProperty.size() > 0) {// 获取的字段属性集合不为空
				// 删除之后，重新添加List内容
				for (int i = 0; i < listFieldProperty.size(); i++) {
					FieldProperty fieldProperty = listFieldProperty.get(i);
					if (null != fieldProperty) {
						fieldProperty.setBeanName("Employee");
						fieldProperty.setUuid(UUID.randomUUID().toString());
						fieldProperty.setBeanUuid(emp.getUuid());
						// 添加到字段表中
						if (fieldPropertyBussiness
								.addFieldProperty(fieldProperty) == 1) {
							System.out
									.println("Debugging MC --->     --->  字段属性表fieldProperty添加成功");
						} else {
							System.out
									.println("Debugging MC --->     --->  字段属性表FieldProperty添加失败");
						}
					} else {
						System.out
								.println("Debugging MC --->     --->  字段属性实体类FieldProperty为空");
					}
				}
			} else {
				System.out.println("List中的ListFieldProperty是空的");
			}

			String empleveldi=request.getParameter("empgrade1")!=null?request.getParameter("empgrade1"):"0";
			String empworkposition=request.getParameter("empworkposition")!=null?request.getParameter("empworkposition"):"0";
			empBussiness.editempgrade(empleveldi, strId);
			
			//empBussiness.empworkposit(empworkposition,strId);
			/* 阙超强 14015 添加记录动态信息 */
			// 拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute(
					"emp");
			// 添加记录到动态记录表
			if (loginEmp != null) {
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个员工的信息。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(emp.getId().toString());
				executerecord.setEntityName("Employee");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}

		}
		return "select";
	}

	/**
	 * 删除员工
	 * 
	 * @return
	 * @throws IOException
	 */
	public String del() throws IOException {
		System.out.println("delAction");
		if (null == ids || ids.equals(null)) {
			System.out.println("员工IDS为空");
			response.getWriter().print("2");
		}
		// 根据员工IDS获取附件列表，删除附件
		String[] strIds = (String[]) ids;
		if (strIds != null && strIds.length > 0) {
			for (int i = 0; i < strIds.length; i++) {
				System.out.println("要删除员工ID是：" + strIds[i]);
				int eId = Integer.parseInt(strIds[i]);
				// 获取员工对象
				Employee ep = empBussiness.oneEmp(eId);
				// 根据员工对象的UUID删除附件表
				empBussiness.deleteFjById(ep.getId());
			}
		}
		boolean flag = empBussiness.delEmp(ids);
		// 此处删除有点问题 boolean返回值为false 一样删除成功
		try {
			if (flag) {
				response.getWriter().print(1);

				/* 阙超强 14015 添加记录动态信息 */
				// 拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession()
						.getAttribute("emp");
				// 添加记录到动态记录表
				if (loginEmp != null) {
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个或多个员工信息。");
					executerecord.setExecuteTime(TimePattern
							.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Employee");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}

			} else {
				response.getWriter().print(0);

				/* 阙超强 14015 添加记录动态信息 */
				// 拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession()
						.getAttribute("emp");
				// 添加记录到动态记录表
				if (loginEmp != null) {
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个或多个员工信息。");
					executerecord.setExecuteTime(TimePattern
							.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Employee");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
			}
		} catch (Exception ex) {
			logger.error("删除时错误！", ex);
			ex.printStackTrace();
		}
		return null;
	}

	/*
	 * 检测员工是否存在
	 */
	public void being() {
		boolean flag = false;
		String id = request.getParameter("id");
		Employee data = empBussiness.oneEmp(Integer.parseInt(id));
		if (data != null) {
			flag = true;
		}
		try {
			if (flag) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("0");
			}
		} catch (Exception ex) {
			logger.error("员工判断存在出错", ex);
			ex.printStackTrace();
		}
	}

	/**
	 * 根据name查找员工信息
	 * 
	 * @return
	 */
	public String like() {
		String ename = request.getParameter("ename");
		try {
			ename = new String(ename.getBytes("ISO-8859-1"), "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String hql = " and name like '%" + ename + "%'";
		if (page == 0)
			page = 1;
		PageBean pb = empBussiness.selEmp(10, page, hql);
		request.getSession().setAttribute("pagebean", pb);
		return "success";
	}

	/**
	 * 显示员工详细信息
	 */
	public String detail() {
		String id = request.getParameter("cid"); // 获得员工ID
		if (id != null && "" != id) { // 如果不为空
			List list1 = empBussiness.selEmps(" and id=" + id);
			if (list1.size() > 0) {
				Employee emp = (Employee) list1.get(0);
				request.setAttribute("empDetial", emp);
				request.setAttribute("beanName", "Employee");
			}
			List<EmployeeFjfb> list = uploadbiz.selectEmpById(id + "");// 获得附件List
			if (null != list && list.size() > 0) {
				request.setAttribute("fjlb", list);
				request.setAttribute("zdfj", 1);
			} else {
				request.setAttribute("detailfj", 0);
			}
			Employee emp1 = empBussiness.oneEmp(Integer.parseInt(id));
			// 查询字段表
			List<FieldRemark> listallf = getFieldPropertyByBeanNameAndBeanUUIDAndTypeName(
					"Employee", emp1.getUuid());
			if (listallf != null && listallf.size() > 0) {
				request.setAttribute("listallf", listallf);
			}
		}
		return "detail";
	}

	/**
	 * 实例化对象
	 */
	public Object getModel() {
		System.out.println("moden");
		emp = new Employee();
		return emp;
	}

	/**
	 * 实例化response
	 */
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * 根据name查找员工信息
	 * 
	 * @return
	 */
	public String ajaxlike() {
		String ename = request.getParameter("ename");
		try {
			ename = new String(ename.getBytes("ISO-8859-1"), "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String hql = " and name like '%" + ename + "%'";
		List elist = empBussiness.selEmps(hql);

		String name = "";
		if (elist.size() == 1) {
			name = (elist.get(0).toString());
		} else {
			name = "fail";
		}
		response.setContentType("text/xml; charset=GB2312");
		response.setHeader("Cache-Control", "no-cache");
		try {
			response.getWriter().write(name);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 删除家庭成员
	 * 
	 * @return
	 * @throws IOException
	 */
	public String delFjjtcyids() throws IOException {
		System.out.println("删除方法。。。。。。。。。。。。。fjids.length()=" + fjids.length());
		if (null == fjids || fjids == "" || fjids == null) {
			System.out.println("附表为空");
			response.getWriter().print("3");
		}
		String strBean = request.getParameter("bean");
		int i = empBussiness.delUserRelationByIds(strBean, fjids);
		if (i > 0) {
			response.getWriter().print("1");
		} else if (i == 0) {
			response.getWriter().print("0");
		} else {
			response.getWriter().print("2");
		}
		return null;
	}

	/**
	 * 获取每个员工对应类型的所有字段属性值
	 * 
	 * @param strEntityName
	 * @param strUuid
	 * @return
	 */
	public List<FieldRemark> getFieldPropertyByBeanNameAndBeanUUIDAndTypeName(
			String strEntityName, String strUuid) {
		// 获取字段表所有数据
		List<FieldRemark> listFieldRemark = fieldRemarkBussiness
				.getFieldRemarkAll("from FieldRemark fr where 1 = 1 ");
		if (null == listFieldRemark || listFieldRemark.size() == 0) {
			System.out
					.println("Debugging MC --->     --->    --->   listFieldRemark is null");
			return null;
		}
		for (int i = 0; i < listFieldRemark.size(); i++) {
			// 获取字段表每个对象 for( Iterator it = set.iterator(); )
			System.out.println(listFieldRemark.get(i).getName());
			// 使用set循环获取每组类型包括具体数据
			for (Iterator it = listFieldRemark.get(i).getFieldProperties()
					.iterator(); it.hasNext();) {
				FieldProperty f = (FieldProperty) it.next();
				if (strUuid.equals(f.getBeanUuid())) {
					System.out
							.println("Debugging MC --->     --->    --->   it.next = "
									+ f.getTemp1());
					return listFieldRemark;
				}
			}
		}
		return null;
	}

	/**
	 * 获取每个员工对应类型的所有字段属性值
	 * 
	 * @param strEntityName
	 * @param strUuid
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByBeanNameAndBeanUUID(
			String strEntityName, String strUuid) {
		List<FieldProperty> listFieldProperty = fieldPropertyBussiness
				.getFieldPropertyByEntityNameUUID(strEntityName, strUuid);
		if (null == listFieldProperty || listFieldProperty.size() == 0) {
			System.out
					.println("Debugging MC --->     --->    --->   listFieldProperty is null");
			return null;
		}
		for (int i = 0; i < listFieldProperty.size(); i++) {
			FieldProperty fieldProperty = listFieldProperty.get(i);
			System.out
					.println("Debugging MC --->     --->    --->   fieldProperty.getTemp1()="
							+ fieldProperty.getTemp1());
		}
		return null;
	}

	/*******
	 * 员工离职操作
	 */
	public String leave() {
		int empid = Integer.parseInt(request.getParameter("empid"));
		String leavereason = request.getParameter("leavereason");
		String leaver = "";

		try {
			leaver = new String(leavereason.getBytes("iso-8859-1"), "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		String leavetime = request.getParameter("leavetime");
		empBussiness.emplz(empid, leaver, leavetime);
		return "leave";
	}

	/*******
	 * 根据员工编号得到其所有客户信息
	 */
	public String customerByEid() {
		// 页码
		String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
		String empno = request.getParameter("empid");
		int empid = 0;
		if (empno != null) {
			empid = Integer.parseInt(empno);
		}

		// 区分是意向还是正式客户。
		String customerType = request.getParameter("customertype");
		if (customerType != null && customerType.trim().length() > 0) {
			customerType = customerType;
		}
		// List<Customer>
		// customerlist=empBussiness.customerByEid(empid,customerType);
		String hql = "from Customer where del=0 and vendition=" + empid
				+ " and customerType2=" + customerType;
		Pages pages = empBussiness.paginationQuery(hql, Integer
				.parseInt(pageNo), 20, null);

		// 绑定所有员工数据
		List<Employee> emplist = empBussiness.setEmp();
		request.setAttribute("customerlist", pages.getPageList());
		request.setAttribute("pages", pages);
		request.setAttribute("emplist", emplist);
		request.setAttribute("emp", empid);
		request.setAttribute("customerType", customerType);
		return "changeCus";
	}

	/*******
	 * 任务移交
	 */
	public String fzr() {
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		String now = dateFormat2.format(new Date());
		System.out.println(ids.length);
		int empid = Integer.parseInt(request.getParameter("empid"));
		int oldfzr = Integer.parseInt(request.getParameter("oldfzr"));
		Employee newemp = empBussiness.oneEmp(empid);
		Employee oldemp = empBussiness.oneEmp(oldfzr);
		// 当下转移的客户信息
		List<CustomerMove> movelist = new ArrayList<CustomerMove>();
		// 根据客户编号修改其对应的负责人
		for (int i = 0; i < ids.length; i++) {
			System.out.println(ids[i]);
			Integer cid = Integer.parseInt(ids[i].toString());
			Customer cus = (Customer) empBussiness.getCustomer(Customer.class,
					cid);
			empBussiness.yjCustomer(empid, cid);
			// 任务移交成功后，添加移交记录
			CustomerMove moveCus = new CustomerMove();
			moveCus.setCustomer(cus);
			moveCus.setEmployeeByNewPrincipal(newemp);
			moveCus.setEmployeeByOldPrincipal(oldemp);
			moveCus.setDelflag("0");
			moveCus.setMovetime(now);
			empBussiness.saveYJ(moveCus);
			movelist.add(moveCus);
		}
		System.out.println(empid + "," + oldfzr);
		request.setAttribute("movelist", movelist);
		return "zysuccess";
	}

	/**********
	 * 查看客户移交记录
	 */
	public String customerJL() {
		// 页码
		String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
		int cid = Integer.parseInt(request.getParameter("cid"));
		System.out.println(cid);
		// 根据客户编号得到移交的记录。
		String hql = "from CustomerMove where customer.customerId=" + cid
				+ "  ORDER BY movetime DESC";
		Pages pages = empBussiness.paginationQuery(hql, Integer
				.parseInt(pageNo), 20, null);
		request.setAttribute("pages", pages);
		// List<CustomerMove> movelist= empBussiness.customerJL(cid);
		// request.setAttribute("movelist", movelist);

		return "movelist";
	}

	/***
	 * 查询部门员工
	 * 
	 * @return
	 */
	public String department() {
		String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		// 执行sql获得子类ID
		String sonIds = loginBussiness.executeSql("select getChildDeptLst("
				+ empposition.getWorkposition().getDepartment().getId() + ")");
		String[] son = sonIds.split(",");
		String hql1 = "(";
		if (son.length > 1) {
			for (int i = 0; i < son.length; i++) {
				if (i != son.length - 1)
					hql1 += "department.id=" + Integer.parseInt(son[i])
							+ " or ";
				else
					hql1 += "department.id=" + Integer.parseInt(son[i]) + ")";
			}
		} else {
			hql1 = "department.id=" + loginEmp.getDepartment().getId() + "";
		}

		String hql = "from Employee where delflag=0 and isLeave=1 and delflag=0 and "
				+ hql1 + " order by department.id   ";

		Pages pages = empBussiness.paginationQuery(hql, Integer
				.parseInt(pageNo), 20, null);
		request.setAttribute("pages", pages);
		return "department";
	}

	/*************
	 * 添加请假单。
	 * 
	 * @return
	 */
	public String addLeave() {

		System.out.println(this.leavesimple.getContent());
		// 添加请假单数据。
		empBussiness.addLeavesimple(this.leavesimple);

		return "leave";
	}

	public String showphoto() throws IOException {
		String str = (String) request.getSession().getAttribute("sczj1");
		response.setContentType("text/html;charset=GBk");
		if (str == null) {
			response.getWriter().print("<span>暂无可显示的内容</span>");
			return null;
		} else {
			response.getWriter().print("<img src='/FAJxc" + str + "'/>");
			System.out.println(str);
		}

		return null;
	}
	/**
	 * 添加员工业务
	 * @return
	 */
    public String addOperation(){
    	String pageNo = request.getParameter("pageNo");
		if (null == pageNo) {
			pageNo = "1";
		}
    	int superid=PublicMissionType.operationtype;
        String empid=request.getParameter("empid");
        int id=Integer.parseInt(empid);
        String hql="From Employee where id="+id;
        Employee emp=empBussiness.exHql(hql).get(0);
        String empname=emp.getName();
        request.setAttribute("empid", empid);
        request.setAttribute("empname", empname);
        String hql2="From Missiontype where superid="+superid;
        List missiontypelist=empBussiness.exHql(hql2);
        request.setAttribute("missiontypelist",missiontypelist);
        System.out.println(missiontypelist.size());
        String hql3="From OperationEmployeematch where empid="+empid;
        Pages pages = empBussiness.paginationQuery(hql3, Integer
				.parseInt(pageNo), 4, null);
		request.setAttribute("pages", pages);
		request.setAttribute("empid", empid);
    	return "addOperation";
    	
    }
    /**
     * 将数据写入员工业务表中
     */
    public void addOperation2(){
    
    	try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    int empid=Integer.parseInt(request.getParameter("empid"));
    int typeid=Integer.parseInt(request.getParameter("typeid"));
    double money1=Double.parseDouble(this.money1);
    double money2=Double.parseDouble(this.money2);
    double money3=Double.parseDouble(this.money3);
    double money4=Double.parseDouble(this.money4);
    double money5=Double.parseDouble(this.money5);
    double money6=Double.parseDouble(this.money6);
    double money7=Double.parseDouble(this.money7);
    double money8=Double.parseDouble(this.money8);
    double money9=Double.parseDouble(this.money9);
    double money10=Double.parseDouble(this.money10);
    double money11=Double.parseDouble(this.money11);
    double money12=Double.parseDouble(this.money12);
    double jd1=Double.parseDouble(this.jd1);
    double jd2=Double.parseDouble(this.jd2);
    double jd3=Double.parseDouble(this.jd3);
    double jd4=Double.parseDouble(this.jd4);
    double sbn=Double.parseDouble(this.sbn);
    double xbn=Double.parseDouble(this.xbn);
    double year=Double.parseDouble(this.year);
    String hql="From OperationEmployeematch where empid="+empid+" and typeid="+typeid+" and temp=-1";
    List operationEmployeelist=empBussiness.exHql(hql);
    OperationEmployeematch operationEmployee=null;
    double money=Double.parseDouble(request.getParameter("money"));
    String explain=request.getParameter("explain");
    String explains="";
	try {
		explains = URLDecoder.decode(explain, "utf-8");
	} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd ");
    // 得到当前时间
    Date now = new Date();
    String creatTime = dateFormat2.format(now);
    if(operationEmployeelist==null||operationEmployeelist.size()==0){
    
    	empBussiness.addOperationDepart(typeid, empid, money, creatTime, explains,-1);
    	 String hql2="From OperationEmployeematch where empid="+empid+" and typeid="+typeid+" and temp=-1";
    	 List operationEmployeelist2=empBussiness.exHql(hql2);
    	 OperationEmployeematch operationEmployee2=null;
    	 operationEmployee2=(OperationEmployeematch)operationEmployeelist2.get(0);
    	 int foreignId=operationEmployee2.getId();
    	 missiontypeBussiness.addAuditline(foreignId,money1,money2,money3,money4,money5,money6,money7,money8,money9,money10,money11,money12,jd1,jd2,jd3,jd4,sbn,xbn,year,2,0,creatTime);
    	try {
			response.getWriter().print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }	
   
    else if(operationEmployeelist!=null||operationEmployeelist.size()!=0){
    	operationEmployee=(OperationEmployeematch)operationEmployeelist.get(0);
    	int ids=operationEmployee.getId();
    	empBussiness.addOperationEmployee(ids, empid, money, creatTime, explains,-1);
    	missiontypeBussiness.updateAuditline(ids,money1,money2,money3,money4,money5,money6,money7,money8,money9,money10,money11,money12,jd1,jd2,jd3,jd4,sbn,xbn,year,2,0,creatTime);
    	try {
			response.getWriter().print(1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
   
    
		
   
   
    } 

    /**
     * 职位管理 14032
     * @return
     */
    public String chengposition(){
    	int empidx = request.getParameter("cid")!=null?Integer.parseInt(request.getParameter("cid")):0;
    	if(empidx==0){
    		empidx=request.getParameter("empid")!=null?Integer.parseInt(request.getParameter("empid")):-1;	
    	}
    	String Hql="from Workposition";
    
    	String snmestr=request.getParameter("sname")!=null?request.getParameter("sname"):"-1";
    	String Hql0="from Employee where id="+empidx;
    	int dep=request.getParameter("depid")!=null?Integer.parseInt(request.getParameter("depid")):-1;
//    	System.out.println(dep);
//    	
//    	if(snmestr.equals("s1")){
//   		 Hql="from Workposition where department.id="+dep;
//   		
//   		
//    	}else if(snmestr.equals("s3")){
//    		 Hql="from Workposition where department.id="+dep;
//    	}else if(snmestr.equals("s2")){
//    	  Hql="from Workposition where department.id="+dep;
//   
//    	}else{
//    		Hql="from Workposition where department.id=-1";
//    		
//   	}
    	String hql2="from Department";
		String Hql1="from WorkpositionEmployee";
		List list1=empBussiness.selectObect(Hql0);
		List list3=empBussiness.selectObect(Hql1);
		List list4=empBussiness.selectObect(hql2);
		request.setAttribute("list3", list3);
		
		request.setAttribute("list1", list1);
		request.setAttribute("list4", list4);
		request.setAttribute("dep", dep);
    	return "chengposition";
    }
   
    /**
     * div load 的职位页面    14032
     * @return
     */
    public String selworkpositionbydept(){
    	int dep=request.getParameter("depid")!=null?Integer.parseInt(request.getParameter("depid")):-1;
    	String snmestr=request.getParameter("sname")!=null?request.getParameter("sname"):"-1";
    	String Hql="from Workposition";
    	if(snmestr.equals("s1")){
   		 Hql="from Workposition where department.id="+dep;
   		
   		
    	}else if(snmestr.equals("s3")){
    		 Hql="from Workposition where department.id="+dep;
    	}else if(snmestr.equals("s2")){
    	  Hql="from Workposition where department.id="+dep;
   
    	}else{
    		Hql="from Workposition where department.id=-1";
    		
    	}
    	List list2=empBussiness.selectObect(Hql);
    	request.setAttribute("list2", list2);
    	return  "selwpbd";
    	
    }
    

    
    /*
     * 从部门业务转到员工业务数据写入
     */
    public void getAuthorization2(){
    	
    		try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	int deptid=Integer.parseInt(request.getParameter("deptid"));
    	int typeid=Integer.parseInt(request.getParameter("typeid"));
    	int empid=Integer.parseInt(request.getParameter("empid"));
    	String hql="From OperationEmployeematch where  typeid="+typeid+" and temp="+deptid;
    	List operationEmployeelist=empBussiness.exHql(hql);
        OperationEmployeematch operationEmployee=null;
    	String moneys=request.getParameter("money");
    	double money=Double.parseDouble(moneys);
    	String explain=request.getParameter("explain");
    	String explains="";
		try {
			explains = URLDecoder.decode(explain, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd ");
        // 得到当前时间
        Date now = new Date();
        String creatTime = dateFormat2.format(now);
        if(operationEmployeelist==null||operationEmployeelist.size()==0){
        empBussiness.addOperationDepart(typeid, empid, money, creatTime, explains,deptid);
        try {
			response.getWriter().print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        }else if(operationEmployeelist!=null||operationEmployeelist.size()!=0){
        	operationEmployee=(OperationEmployeematch)operationEmployeelist.get(0);
        	int ids=operationEmployee.getId();
        	empBussiness.addOperationEmployee(ids, empid, money, creatTime, explains,deptid);
        	try {
				response.getWriter().print(1);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
	
		
    	
    }
    /**
     * 删除部门转入员工业务
     * @return
     */
    public void delOperationTO(){
    	int empid=Integer.parseInt(request.getParameter("empid"));
    	int typeid=Integer.parseInt(request.getParameter("typeid"));
    	int temp=Integer.parseInt(request.getParameter("temp"));
    	if(temp==-1){
    	String hql2="From OperationEmployeematch where empid="+empid+" and typeid="+typeid+" and temp=-1";
    	List operationEmployeelist=empBussiness.exHql(hql2);
    	OperationEmployeematch operationEmployee=null;
        operationEmployee=(OperationEmployeematch)operationEmployeelist.get(0);
    	int foreignId=operationEmployee.getId();
    	missiontypeBussiness.delAuditline(foreignId, 2, 0);
    	}
        empBussiness.DelOperationEmployee(empid, typeid, temp);
    	try {
			response.getWriter().print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }
     
    /**新potal客户的
     * 
     * @return
     */
    String str1="";
	 public String selemp1(String deptid){
		 
		 int dept=Integer.parseInt(deptid);
		 String hql="FROM Department where delflag=0 and  parentId="+deptid+" order by squnum";
		 List dlist = missiontypeBussiness.exHql(hql);
		 List<Department> list1=dlist;
		 String a="";
		 int y=dlist.size();
		 System.out.println(y);
		 if(y>0){
			
		 for (int i = 0; i < list1.size(); i++) {
			
			Object o=list1.get(i).getId();
			Integer o1=list1.get(i).getIslevel();
			a=o.toString();
			String b=o1.toString();
			x.append(a);
			str1=str1+"<option  name='sel' value='"+list1.get(i).getId()+"'>"+list1.get(i).getName()+"</option>";
			x.append(",");
			System.out.println(a);
			 if(list1.size()>0){
				 selemp1(a);
				 System.out.println(x);
			 }
		 }}
		 System.out.println(x);
		 System.out.println(str1);
		
	
			return str1;
		 
		 	 
		 	
		 }
    private static  StringBuffer x;
	 public StringBuffer selemp(String deptid){
			
		 x.append(deptid);
		 x.append(",");
		 int dept=Integer.parseInt(deptid);
		 String hql="select id FROM Department where  delflag=0 and  parentId="+dept;
		 List dlist = empBussiness.exHql(hql);
		 String a="";
		 
		 int y=dlist.size();
		 System.out.println(y);
		 if(y>0){
			
		 for (int i = 0; i < dlist.size(); i++) {
			Object o=dlist.get(i);
			a=o.toString();
			x.append(a);
			x.append(",");
			System.out.println(a);
			 if(dlist.size()>0){
				 selemp(a);
				 System.out.println(x);
			 }
		 }}
		 System.out.println(x);
		
			return x;
		 
		 	
		 }
    public String getEmplist(){//公司全部员工
	
		Employee Emp = (Employee) request.getSession().getAttribute("emp");
		int ids=Emp.getId();
		int dept=Emp.getDepartment().getId();
		 x=new StringBuffer();
		 str1=new String();
		 String deptlist=selemp1("28");
		 request.setAttribute("deptlist",deptlist);
		 StringBuffer sb=selemp(String.valueOf(dept));
		String sb1=sb.toString();
		String hql="From Employee where  isLeave='1'";
		//String hql="From Employee where department in ("+sb1 + "-1) and isLeave='1'";
		String company="";
		String name1="";
		String customertype="3";
		String seldept="";
		try {
			seldept=request.getParameter("seldept")!=null?new String(request.getParameter("seldept").getBytes(
			"iso-8859-1"), "GBK"):"";
			company=request.getParameter("empno")!=null?new String(request.getParameter("empno").getBytes(
			"iso-8859-1"), "GBK"):"";
			name1=request.getParameter("empname")!=null?new String(request.getParameter("empname").getBytes(
			"iso-8859-1"), "GBK"):"";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
			if(!name1.equals("")&& name1!=null){
				hql+=" and name like "+"'%"+name1+"%'";
			}else{
				hql+="";
			}
			if(!seldept.equals("")&& seldept!=null){
				hql+=" and department.id="+Integer.parseInt(seldept)+" ";
			}else{
				hql+="";
			}
			if(company!=""&&company!=null){
				hql+=" and empNo like "+"'%"+company+"%'";
			}else{
				hql+="";
			}
		
			hql=hql+" order by id desc";
		int  	pageNo=1;
		
		pageNo=request.getParameter("pageNo")!=null?Integer.parseInt(request.getParameter("pageNo")):1;
		if(pageNo<1){
			
			pageNo=1;
		}
		
		String sql="from IntentFollowUp  order by date desc ";
	    List list=empBussiness.exHql(sql);
	    List<IntentFollowUp> list1=list;
	    request.setAttribute("list1", list1);
		int  pageSize=13;
		
		Pages pg= executeRecordBussiness.exHqlPages(hql, pageNo, pageSize, null );
		List solistList = pg.getPageList();
		int  allline=pg.getAllCount();//总行数
		int gageNoall = allline / 13;// 总页数

		if (allline % 13 != 0) {
			gageNoall = gageNoall + 1;
		}
		List<Customer> newcustomerlist = solistList;
		request.setAttribute("newcustomerlist", newcustomerlist);
		request.setAttribute("allline", allline);
		request.setAttribute("gageNoall", gageNoall);
		request.setAttribute("pageNo", pageNo);

		return "deptallemplist";
	}
    public String getEmplistbydept(){
    	
		Employee Emp = (Employee) request.getSession().getAttribute("emp");
		int ids=Emp.getId();
		int dept=Emp.getDepartment().getId();
		String workdept="from Workposition where department="+dept;
		List lwork=empBussiness.exHql(workdept);
		List<Workposition> lw=lwork;
		String workstr="<select name='pwork' ><option></option>";
		if(lw.size()>0){
		for (int i = 0; i < lw.size(); i++) {
			workstr=workstr+"<option value='"+lw.get(i).getId()+"'>"+lw.get(i).getName()+"</option>";		
		}
		}	
		workstr=workstr+"</select>";
		request.setAttribute("workstr",workstr );
		 x=new StringBuffer();
			
		 StringBuffer sb=selemp(String.valueOf(dept));
		String sb1=sb.toString();
		//String hql="From Employee where  isLeave='1'";
		String hql="From Employee where department in ("+sb1 + "-1) and isLeave='1'";
		String company="";
		String name="";
		String pwork="";
		String customertype="3";
		try {
			pwork=request.getParameter("pwork")!=null?new String(request.getParameter("pwork").getBytes(
			"iso-8859-1"), "GBK"):"";
			company=request.getParameter("empno")!=null?new String(request.getParameter("empno").getBytes(
			"iso-8859-1"), "GBK"):"";
			name=request.getParameter("empname")!=null?new String(request.getParameter("empname").getBytes(
			"iso-8859-1"), "GBK"):"";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
			if(name!=""&&name!=null){
				hql+=" and name like "+"'%"+name+"%'";
			}else{
				hql+="";
			}
			if(!pwork.equals("")&& pwork!=null){
				hql+=" and workposition.id="+Integer.parseInt(pwork)+"	";
			}else{
				hql+="";
			}
			if(company!=""&&company!=null){
				hql+=" and empNo like "+"'%"+company+"%'";
			}else{
				hql+="";
			}
		
			hql=hql+" order by id desc";
		int  	pageNo=1;
		
		pageNo=request.getParameter("pageNo")!=null?Integer.parseInt(request.getParameter("pageNo")):1;
		if(pageNo<1){
			
			pageNo=1;
		}
		
		String sql="from IntentFollowUp  order by date desc ";
	    List list=empBussiness.exHql(sql);
	    List<IntentFollowUp> list1=list;
	    request.setAttribute("list1", list1);
		int  pageSize=13;
		
		Pages pg= executeRecordBussiness.exHqlPages(hql, pageNo, pageSize, null );
		List solistList = pg.getPageList();
		int  allline=pg.getAllCount();//总行数
		int gageNoall = allline / 13;// 总页数

		if (allline % 13 != 0) {
			gageNoall = gageNoall + 1;
		}
		List<Customer> newcustomerlist = solistList;
		request.setAttribute("newcustomerlist", newcustomerlist);
		request.setAttribute("allline", allline);
		request.setAttribute("gageNoall", gageNoall);
		request.setAttribute("pageNo", pageNo);

		return "deptemplist";
	}
    /**
     * 新potal---详细信息的页面
     * @return
     */
     public String getEmpInfo(){
    	 
    	 String id=request.getParameter("sid");
    	 String Sql="from Employee where id="+Integer.parseInt(id);
    	 List list=empBussiness.exHql(Sql);
    	 List<Employee> emplist=list;
    	 request.setAttribute("emplist", emplist);
    	 
    	 return "getempInfo";
     }
     /**
      * 获得列表
      */
  
     /**
      * 上传头像
      * @return
      */
     public String upload() {
 		String extName = ""; // 保存文件拓展名
 		String newFileName = ""; // 保存新的文件名
 		String nowTimeStr = ""; // 保存当前时间
 		PrintWriter out = null;
 		SimpleDateFormat sDateFormat;
 		Random r = new Random();

 		String savePath = ServletActionContext.getServletContext().getRealPath(
 				""); // 获取项目根路径
 		savePath = savePath + "/file/";
 		response.setContentType("text/html;charset=GBK"); // 务必，防止返回文件名是乱码

 		// 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）
 		int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数
 		sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式
 		nowTimeStr = sDateFormat.format(new Date()); // 当前时间
 		// 获取拓展名
 		if (fileuploadFileName.lastIndexOf(".") >= 0) {
 			extName = fileuploadFileName.substring(fileuploadFileName
 					.lastIndexOf("."));
 		}
 		try {
 			out = response.getWriter();
 			newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字
 			
 			String filePath = savePath + newFileName;
 			filePath = filePath.replace("\\", "/");
 			
 			//检查上传的是否是图片
 			if (UtilCommon.checkIsImage(extName)) {
 				FileUtils.copyFile(fileupload, new File(filePath));
 				filePath = StrUtil.getStr(filePath);
 				out.print("<font color='red'>" + fileuploadFileName
 						+ "上传成功!</font>#" + filePath + "#" + fileuploadFileName);

 			} else {
 				out.print("<font color='red'>上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!</font>");
 			}
 			out.flush();
 			out.close();
 		//	log.info("上传end");
 			} catch (IOException e) {
 			e.printStackTrace();
 			out.print("上传失败，出错啦!");
 			//log.info("上传error");
 		}
 		return null;
 	}
     public String upload1() {
  		String extName = ""; // 保存文件拓展名
  		String newFileName = ""; // 保存新的文件名
  		String nowTimeStr = ""; // 保存当前时间
  		PrintWriter out = null;
  		SimpleDateFormat sDateFormat;
  		Random r = new Random();

  		String savePath = ServletActionContext.getServletContext().getRealPath(
  				""); // 获取项目根路径
  		savePath = savePath + "/file/";
  		response.setContentType("text/html;charset=GBK"); // 务必，防止返回文件名是乱码

  		// 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）
  		int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数
  		sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式
  		nowTimeStr = sDateFormat.format(new Date()); // 当前时间
  		// 获取拓展名
  		if (fileupload1FileName.lastIndexOf(".") >= 0) {
  			extName = fileupload1FileName.substring(fileupload1FileName
  					.lastIndexOf("."));
  		}
  		try {
  			out = response.getWriter();
  			newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字
  			
  			String filePath = savePath + newFileName;
  			filePath = filePath.replace("\\", "/");
  			
  			//检查上传的是否是图片
  			if (UtilCommon.checkIsImage(extName)) {
  				FileUtils.copyFile(fileupload1, new File(filePath));
  				filePath = StrUtil.getStr(filePath);
  				out.print("<font color='red'>" + fileupload1FileName
  						+ "上传成功!</font>#" + filePath + "#" + fileupload1FileName);

  			} else {
  				out.print("<font color='red'>上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!</font>");
  			}
  			out.flush();
  			out.close();
  		//	log.info("上传end");
  			} catch (IOException e) {
  			e.printStackTrace();
  			out.print("上传失败，出错啦!");
  			//log.info("上传error");
  		}
  		return null;
  	}
     /**
      * 
      */
     /**
      * 新potal页面的新增的load页面
      * @return
      */
      public String  addload(){
    	  x=new StringBuffer();
    	  String sb=selemp1(String.valueOf(28));
    	  System.out.println(sb);
    	  String sql="From Workposition";
    	  empBussiness.exHql(sql);
    	  String deptselect="<select id='deptlist' name='deptlist' style=‘width: 110px;’><option value='-1'>下拉选择部门</option>"+sb+"<select>";
    	  request.setAttribute("deptlist",deptselect);
    	  return "addload";
      }
      /**
       * 部门二级联动选择职位
       */
     
	public void selworkposition(){
    	
    	  
			String deptid0=deptid;
			 String sql="From Workposition where department.id="+Integer.parseInt(deptid0);
			 List wplist=empBussiness.exHql(sql);
		    List<Workposition>  l3=wplist;
		    String res="";
		    for (int i = 0; i < l3.size(); i++) {
				
		    	res=res+"<option value='"+l3.get(i).getId()+"' >"+l3.get(i).getName()+"</option>";
			}
		    response.setContentType("text/html;charset=GBK");
    	try {
    	   
			response.getWriter().print(res);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      }
      /**
       * 新系统添加员工页面
       * @return
       */
      public String addEmp(){
      String name=	  request.getParameter("xingMing");
    	String sex=request.getParameter("xingBie");
    	String age=  request.getParameter("nianLing");
    	String birth=  request.getParameter("chuShengRiQi");
    	String nation=  request.getParameter("MinZu");
    	String  health= request.getParameter("jianKangZhuangKuang");
    	String stature=request.getParameter("shenGao");
    	String heft= request.getParameter("tiZhong");
    	String Tel=request.getParameter("lianXiDianHua");
    	
    	String education="";
		try {
			education = new String(request.getParameter("xueLi1").getBytes("iso-8859-1"),"GBK")!=""?new String(request.getParameter("xueLi1").getBytes("iso-8859-1"),"GBK"):request.getParameter("xueLi2");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String empNo= request.getParameter("yuanGongGongHao");
    	String department=  !request.getParameter("deptlist").equals("-1") ?request.getParameter("deptlist"):"nochange";
    	String computeleve= request.getParameter("jiSuanJiShuiPing");
    	String engleve= request.getParameter("waiYuShuiPing");
    	String censusreg=  request.getParameter("weiHun");
    	String touxiang=    request.getParameter("img1")!=null? request.getParameter("img1"):"nochange";
    	String entryTime=  request.getParameter("ruZhiShiJian");
    	String workposition11=  request.getParameter("zhiWei")!=null? request.getParameter("zhiWei"):"nochange";
    	String isLeave= request.getParameter("liZhi")!=null? request.getParameter("liZhi"):"";
    	String cardid= request.getParameter("shenFenZhengHaoMa")!=null? request.getParameter("shenFenZhengHaoMa"):"";
    	String empgrade= !request.getParameter("yuanGongJiBie").equals("")? request.getParameter("yuanGongJiBie"):"nochange";
    	String	urgenttel =request.getParameter("jinJiLianXiDianHua")!=null? request.getParameter("jinJiLianXiDianHua"):"";
    	String	married=  request.getParameter("huJiDiZhi")!=null? request.getParameter("huJiDiZhi"):"";
    	String	email = request.getParameter("youXiang")!=null? request.getParameter("youXiang"):"";
    	String	empId = request.getParameter("empid")!=null? request.getParameter("empid"):"add";
    	  String  place=  request.getParameter("jiaTingZhuZhi");
    	  String  time  = request.getParameter("chuangJianRiQi");
    	  String  nowplace =  request.getParameter("xianZhuZhi");  
    	  String  specialty =  request.getParameter("xingQuTeChangAiHao");
    		// 职位ID
    	
    	  Employee emp=new Employee();
    	  if(empId!="add"){
    		  String hql="From Employee where id="+Integer.parseInt(empId);
    		  List l1=empBussiness.exHql(hql);
    		  List<Employee> l2=l1;
    		  
    		  emp=l2.get(0);
    		  if(l2.get(0).getDepartments()!=null){  emp.setDepartments(l2.get(0).getDepartments());}
    		
    		  if(l2.get(0).getWorkposition()!=null){  emp.setWorkposition(l2.get(0).getWorkposition());}
    		  emp.setUuid(l2.get(0).getUuid());
    		  emp.setPhoto(l2.get(0).getPhoto());
    	  }else{
    		  emp.setPhoto(touxiang);
    		  emp.setUuid(UUID.randomUUID().toString());
    		  
    	  }
    	  if(empgrade!="nochange"){
  		   String sql="From EmployeeGrade where gradeNum="+Short.parseShort(empgrade);
  		   List empgrade1=empBussiness.exHql(sql);
  		   List<EmployeeGrade> l2=empgrade1;
  		   emp.setEmpgrade(l2.get(0));
    	  }
    	  if(touxiang!="nochange"){
    		  emp.setPhoto(touxiang);
    		  
    		  
    	  }
  		if(workposition11!="nochange"){
  			List<Workposition> grouplist = empBussiness.ObjectList("Workposition",
  					" and id = " + Integer.parseInt(workposition11));
  			if (grouplist.size() > 0) {
  				emp.setWorkposition(grouplist.get(0));
  			}
  		}
  		// 部门ID
  	
  		if (department != "nochange") {
  			System.out.println("Debugging MC --->     --->  depid = " + department);
  			if (!department.equals("-1")) {
  				Department dep = dembussiness.onedep(" and id="
  						+ Integer.parseInt(department));
  				emp.setDepartment(dep);
  			}
  		}
  		 java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
		 // 得到当前时间
		 	Date now = new Date();
			String nowstr = dateFormat2.format(now);  
  		
    	
    	  emp.setName(name);
    	  
    	  emp.setAge(Integer.parseInt(age));
    	  emp.setSex(Integer.parseInt(sex));
    	  emp.setStature(stature);
    	  emp.setBirth(birth);
    	  emp.setDelflag(0);
    	  emp.setNation(nation);
    	  emp.setEducation(education);
    	  emp.setHealth(health);
    	  emp.setHeft(heft);
    	  emp.setTel(Tel);
    	  emp.setPlace(place);
    	  emp.setEmpNo(empNo);
    	  emp.setComputeleve(computeleve);
    	  emp.setEngleve(engleve);
    	  emp.setCensusreg(censusreg);
    	  emp.setEntryTime(entryTime);
    	 // emp.setWorkposition(workposition);
    	  emp.setIsLeave(1);
    	  emp.setCardid(cardid);
    	  emp.setSpecialty(specialty);
    	  emp.setUrgenttel(urgenttel);
    	  emp.setMarried(married);
    	  emp.setTime(nowstr);
    	  emp.setEmail(email);
    	  emp.setNowplace(nowplace);
    	  if(empId!="add"){
    		  emp.setId(Integer.parseInt(empId));
    		  
    	  }
    	  Object emp1=  empBussiness.addemp(emp);//返回emp的id
    	  String empid=emp1.toString();
    	  String sql1="From Employee where id="+Integer.parseInt(empid);
    	  List emplist=empBussiness.exHql(sql1);
    	  List<Employee> empl1=emplist;
    	
    	  // 教育，家庭，工作 添加到通用表中
    	  
    	  String t1=request.getParameter("t1");//教育阶段  field_remark 2
    	  String t2=request.getParameter("t2");//家庭成员   field_remark 1
    	  String t3=request.getParameter("t3");//工作经验    field_remark 3
    	 if(!t1.equals("1")){
    	  for (int i = 2; i <= Integer.parseInt(t1); i++) {
    		 
			String jyjdtime1=request.getParameter("begintime"+String.valueOf(i));
			String jyjdtime2=request.getParameter("endtime"+String.valueOf(i));  
			String schoolname=request.getParameter("schoolname"+String.valueOf(i)); 
			String xueli=request.getParameter("xueli"+String.valueOf(i));
			String zhuanye=request.getParameter("zhuanye"+String.valueOf(i));
			String uuid=UUID.randomUUID().toString();
			System.out.println("begintime"+String.valueOf(i));
			  empl1.get(0).getUuid();
			  if(jyjdtime1!=null && jyjdtime2!=null && schoolname!=null && xueli!=null && zhuanye!=null){
			  String proprtsql="insert into field_property(uuid,fieldId,beanName,beanUuid,temp1,temp2,temp3,temp4,temp5)" +
			  		" values('"+uuid+"',2,'Employee','"+empl1.get(0).getUuid()+"','"+schoolname+"','"+jyjdtime1+"','"+jyjdtime2+"','"+zhuanye+"','"+xueli+"')";
		Boolean b=	empBussiness.add(proprtsql);  		
			  }
    	  } 
    	 }
    	 if(!t3.equals("1")){
    	  for (int i = 2; i <= Integer.parseInt(t3); i++) {
     		 
  			String jyjdtime1=request.getParameter("btime"+String.valueOf(i));
  			String jyjdtime2=request.getParameter("etime"+String.valueOf(i));  
  			String conname=request.getParameter("conname"+String.valueOf(i)); 
  			String positiontwo=request.getParameter("positiontwo"+String.valueOf(i));
  			String leavename=request.getParameter("leavename"+String.valueOf(i));
  			String uuid=UUID.randomUUID().toString();
  			System.out.println("begintime"+String.valueOf(i));
  			  empl1.get(0).getUuid();
  			 if(jyjdtime1!=null && jyjdtime2!=null && conname!=null && positiontwo!=null && leavename!=null){
  			  String proprtsql="insert into field_property(uuid,fieldId,beanName,beanUuid,temp1,temp2,temp3,temp4,temp5)" +
  			  		" values('"+uuid+"',3,'Employee','"+empl1.get(0).getUuid()+"','"+conname+"','"+jyjdtime1+"','"+jyjdtime2+"','"+positiontwo+"','"+leavename+"')";
  			Boolean b=	empBussiness.add(proprtsql);  
  			 }
      	  }
    	 }
    	 if(!t2.equals("1")){
    	  for (int i = 2; i <= Integer.parseInt(t2); i++) {
     		 
  			String tname=request.getParameter("tname"+String.valueOf(i));
  			String guanxi=request.getParameter("guanxi"+String.valueOf(i));  
  			String danwei=request.getParameter("danwei"+String.valueOf(i)); 
  			String position=request.getParameter("position"+String.valueOf(i));
  			String phone=request.getParameter("phone"+String.valueOf(i));
  			String uuid=UUID.randomUUID().toString();
  			System.out.println("begintime"+String.valueOf(i));
  			  empl1.get(0).getUuid();
  			 if(tname!=null && guanxi!=null && danwei!=null && position!=null && phone!=null){
  			  String proprtsql="insert into field_property(uuid,fieldId,beanName,beanUuid,temp1,temp2,temp3,temp4,temp5)" +
  			  		" values('"+uuid+"',1,'Employee','"+empl1.get(0).getUuid()+"','"+tname+"','"+guanxi+"','"+position+"','"+danwei+"','"+phone+"')";
  			Boolean b=empBussiness.add(proprtsql);  		
  			 }
      	  }
    	 }
    	 //上传附件到通用表中
    		Map txt=(Map)request.getSession().getAttribute("sczj")!=null?(Map)request.getSession().getAttribute("sczj"):null;
			if(txt!=null){
			String sfza=(String)txt.get("身份证A");
			String sfzB=(String)txt.get("身份证B");
			String sfzb=(String)txt.get("毕业证");
			String yyzz=(String)txt.get("学士学位证");
			String grzp=(String)txt.get("个人照片");
			String gt=(String)txt.get("其他");
			String fj="";
		
			if(sfza!=null & sfza!=""){
				String mz="身份证A";
				this.scfj( mz,sfza, empl1.get(0).getUuid());
				
			}
			if(sfzB!=null & sfzB!=""){
				String mz="身份证B";
				this.scfj(mz,sfzB, empl1.get(0).getUuid());
				
			}
			if(sfzb!=null & sfzb!=""){
				String mz="毕业证";
				this.scfj(mz,sfzb, empl1.get(0).getUuid());
				
			}
			if(yyzz!=null & yyzz!=""){
				String mz="学士学位证";
				this.scfj(mz,yyzz, empl1.get(0).getUuid());
				
			}
			if(grzp!=null & grzp!=""){
				String mz="个人照片";
				this.scfj(mz,grzp, empl1.get(0).getUuid());
				
			}
			if(gt!=null & gt!=""){
				String mz="其他";
				this.scfj(mz,gt, empl1.get(0).getUuid());
				
			}
			
			}
			
			request.getSession().removeAttribute("sczj");
    	  return getEmplist();
    	  
      	}
      public void scfj(String mz,String sfza,String Uuid){
    	  
    	  java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
		 // 得到当前时间
		 	Date now = new Date();
			String nowstr = dateFormat2.format(now);
			int dot = sfza.lastIndexOf('.'); 
		   String fjsc="insert into common_scfjb(fjmc,fjhz,fjlj,sbh,fbsbh,build_time)" +
	  		" values('"+mz+"','"+dot+"','"+sfza+"','"+UUID.randomUUID().toString()+"','"+Uuid+"','"+nowstr+"')";
		  empBussiness.add(fjsc);  
    	  
      }
      /**
       * 员工详情
       * @return
       */
      
      public String detail1() {
    	    response.setContentType("text/html;charset=GBK");
  		String id = request.getParameter("cid"); // 获得员工ID
  		String edit =request.getParameter("isedit")!=null?request.getParameter("isedit"):"notis";
  		if (id != null && "" != id) { // 如果不为空
  			List list1 = empBussiness.exHql("FROM Employee where  id=" + id);
  			String uuid="";
  			if (list1.size() > 0) {
  				Employee emp = (Employee) list1.get(0);
  				request.setAttribute("empDetial", emp);
  				request.setAttribute("beanName", "Employee");
  				uuid=emp.getUuid();
  			}
  			List list = empBussiness.exHql("from CommonScfjb where fbsbh='"+uuid+"'");// 获得附件List
  			List<CommonScfjb> l21=list;
  			if (null != list && list.size() > 0) {
  				request.setAttribute("fjlb1", l21);
  			
  			} else {
  				
  			}
  		
  			String sql="FROM FieldProperty  where beanUuid='"+uuid+"' and beanName='Employee' ";
  			List lt=empBussiness.exHql(sql);
  			List<FieldProperty> l2=lt;
  			request.setAttribute("fplist", l2);
  			
  			
  		
  	  x=new StringBuffer();
	  String sb=selemp1(String.valueOf(28));
	  System.out.println(sb);
	  String sql1="From Workposition";
	  empBussiness.exHql(sql1);
	  String deptselect="<select id='deptlist' name='deptlist' style=‘width: 110px;’><option value='-1'></option>"+sb+"<select>";
	  request.setAttribute("deptlist",deptselect);
  		}
	  if(edit.equals("edit")){
		  
		  return "detail2";
	  }else{
  		return "detail1";
	  }
  	}  
      /**
       * 删除员工附件
       */
      public void delfj(){
    	  
    	    response.setContentType("text/html;charset=GBK");
     	 String del="Delete from common_scfjb where id="+Integer.parseInt(deptid); 
     	  empBussiness.add(del);
     	  
     	  try {
 			response.getWriter().print(12);
 		} catch (IOException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	  
      }
      /**
       * 删除记录
       */
 public void deljl(){
    	  
    	 String del="Delete from field_property where id="+Integer.parseInt(deptid); 
    	  empBussiness.add(del);
    	    response.setContentType("text/html;charset=GBK");
    	  try {
			response.getWriter().print(12);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      }
      /**
       * 员工
       * 身份证唯一验证
       * 
       * 
       */
      private String empname;
      public void checkName(){
    	 
    	  try {
    		    response.setContentType("text/html;charset=GBK");
			
    	  String sql="From Employee where email='"+empname+"'";
    	  List l2=  empBussiness.exHql(sql);
    	 List<Employee> l3=l2;
    	 if(l3.size()<1){
    		 
    		 response.getWriter().print("0");
    	 }else{
    		 
    		 response.getWriter().print("1");
    		 
    		 
    	 }
    	  
    	 } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	  
    	  
      }
      
      public void checkName1(){
     	 
    	  try {
				
    		    response.setContentType("text/html;charset=GBK");
    	  String sql="From Employee where cardid='"+empname+"'";
    	  List l2=  empBussiness.exHql(sql);
    	 List<Employee> l3=l2;
    	 if(l3.size()<1){
    		 
    		 response.getWriter().print("0");
    	 }else{
    		 
    		 response.getWriter().print("1");
    		 
    		 
    	 }
    	  
    	 } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	  
    	  
      }
      public void checkEmpno(){
      	 
    	  try {
    		    response.setContentType("text/html;charset=GBK");
			
    	  String sql="From Employee where empNo='"+empname+"'";
    	  List l2=  empBussiness.exHql(sql);
    	 List<Employee> l3=l2;
    	 if(l3.size()<1){
    		 
    		 response.getWriter().print("0");
    	 }else{
    		 
    		 response.getWriter().print("1");
    		 
    		 
    	 }
    	  
    	 } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	  
    	  
      }
      
      
      
     private File fileupload;
     private File fileupload1;
 	public File getFileupload1() {
		return fileupload1;
	}
	public void setFileupload1(File fileupload1) {
		this.fileupload1 = fileupload1;
	}
	public File getFileupload() {
		return fileupload;
	}
	public void setFileupload(File fileupload) {
		this.fileupload = fileupload;
	}
	private String fileupload1FileName; 
 	public String getFileupload1FileName() {
		return fileupload1FileName;
	}
	public void setFileupload1FileName(String fileupload1FileName) {
		this.fileupload1FileName = fileupload1FileName;
	}

	private String fileuploadFileName; 
	// 以下为Getter 和 Setter 方法
	public UploadBussiness getUploadbiz() {
		return uploadbiz;
	}
	public String getFileuploadFileName() {
		return fileuploadFileName;
	}
	public void setFileuploadFileName(String fileuploadFileName) {
		this.fileuploadFileName = fileuploadFileName;
	}
	public void setUploadbiz(UploadBussiness uploadbiz) {
		this.uploadbiz = uploadbiz;
	}

	public String getFjids() {
		return fjids;
	}

	public void setFjids(String fjids) {
		this.fjids = fjids;
	}

	public FbManipulateBussiness getFbManipulateBussiness() {
		return fbManipulateBussiness;
	}

	public void setFbManipulateBussiness(
			FbManipulateBussiness fbManipulateBussiness) {
		this.fbManipulateBussiness = fbManipulateBussiness;
	}

	/**
	 * @return the dembussiness
	 */
	public DepartmentBussiness getDembussiness() {
		return dembussiness;
	}

	/**
	 * @param dembussiness
	 *            the dembussiness to set
	 */
	public void setDembussiness(DepartmentBussiness dembussiness) {
		this.dembussiness = dembussiness;
	}

	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids
	 *            the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @param page
	 *            the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}

	/**
	 * @return the empBussiness
	 */
	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}

	/**
	 * @param empBussiness
	 *            the empBussiness to set
	 */
	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public List<UserRelation> getListfjjtcy() {
		return listfjjtcy;
	}

	public void setListfjjtcy(List<UserRelation> listfjjtcy) {
		this.listfjjtcy = listfjjtcy;
	}

	public UserRelationBussiness getUserRelationBussiness() {
		return userRelationBussiness;
	}

	public void setUserRelationBussiness(
			UserRelationBussiness userRelationBussiness) {
		this.userRelationBussiness = userRelationBussiness;
	}

	public FieldPropertyBussiness getFieldPropertyBussiness() {
		return fieldPropertyBussiness;
	}

	public void setFieldPropertyBussiness(
			FieldPropertyBussiness fieldPropertyBussiness) {
		this.fieldPropertyBussiness = fieldPropertyBussiness;
	}

	public FieldRemarkBussiness getFieldRemarkBussiness() {
		return fieldRemarkBussiness;
	}

	public void setFieldRemarkBussiness(
			FieldRemarkBussiness fieldRemarkBussiness) {
		this.fieldRemarkBussiness = fieldRemarkBussiness;
	}

	public List<FieldProperty> getListFieldProperty() {
		return listFieldProperty;
	}

	public void setListFieldProperty(List<FieldProperty> listFieldProperty) {
		this.listFieldProperty = listFieldProperty;
	}

	public FieldProperty getFieldProperty() {
		return fieldProperty;
	}

	public void setFieldProperty(FieldProperty fieldProperty) {
		this.fieldProperty = fieldProperty;
	}

	public FieldRemark getFieldRemark() {
		return fieldRemark;
	}

	public void setFieldRemark(FieldRemark fieldRemark) {
		this.fieldRemark = fieldRemark;
	}

	public List<FieldRemark> getListFieldRemark() {
		return listFieldRemark;
	}

	public void setListFieldRemark(List<FieldRemark> listFieldRemark) {
		this.listFieldRemark = listFieldRemark;
	}
	 private String deptid;
     public String getDeptid() {
		return deptid;
	}
	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}
	public static void main(String[] args) throws Exception {
		String src = "我不爱你。你也不要爱我";
		src = src.replaceAll("(?:我不|你也|爱我)", "?:dd");
		System.out.println(src);
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public String getEmpname() {
		return empname;
	}

	
}
