package com.fuao.fajxc.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.fuao.fajxc.bussiness.FunctionInfoBussiness;
import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.bussiness.system.RoleSystemBussiness;
import com.fuao.fajxc.dao.newproject.Project;
import com.fuao.fajxc.dao.project.ProjectDao;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.TimePattern1;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.ProjectEmp;
import com.fuao.fajxc.vo.Reminders;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.WorkLog;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ModelDriven;

public class LoginAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	/**
	 * 日志记录
	 */
	private static Logger logger = Logger.getLogger(LoginAction.class);

	/**
	 * 登录Bussinesss注入
	 */
	private LoginBussiness loginBussiness;
	private Users users;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private FunctionInfoBussiness functionInfobiz;
	private FunctionInfoSystemBussiness functionInfoSystemBussiness;
	private RoleSystemBussiness roleSystemBussiness;
	private GroupSystemBussiness groupSystemBussiness;
	/*2011-11-22 14:42:45 桌面显示公告*/
	private MessageBussiness messageBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;
	private ProjectDao prjdao;
	private Project projectdao;
	/**
	 * Used only to recognise digital employee accounts, which are refused at the login page
	 * (A0-2). See com.fuao.fajxc.dao.harness.HarnessAccountDao.
	 */
	private com.fuao.fajxc.dao.harness.HarnessAccountDao harnessAccountDao;

	public void setHarnessAccountDao(com.fuao.fajxc.dao.harness.HarnessAccountDao harnessAccountDao) {
		this.harnessAccountDao = harnessAccountDao;
	}
	private String funcid;
    
	public String getFuncid() {
		return funcid;
	}
	public void setFuncid(String funcid) {
		this.funcid = funcid;
	}
	public ProjectDao getPrjdao() {
		return prjdao;
	}
	public Project getProjectdao() {
		return projectdao;
	}
	public void setProjectdao(Project projectdao) {
		this.projectdao = projectdao;
	}
	public void setPrjdao(ProjectDao prjdao) {
		this.prjdao = prjdao;
	}


	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}


	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
	Cookies cookie = new Cookies();

	private String loginname;

	private String loginpwd;

	private String yzm;
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	/**
	 * 获得Users对象
	 */
	public Object getModel() {
		users=new Users();
		return users;
	}
	
	
	public void setMessageBussiness(MessageBussiness messageBussiness) {
		this.messageBussiness = messageBussiness;
	}
	
	/**
	 * @return the loginBussiness
	 */
	public LoginBussiness getLoginBussiness() {
		return loginBussiness;
	}

	/**
	 * @param loginBussiness the loginBussiness to set
	 */
	public void setLoginBussiness(LoginBussiness loginBussiness) {
		this.loginBussiness = loginBussiness;
	}

	public FunctionInfoBussiness getFunctionInfobiz() {
		return functionInfobiz;
	}

	public void setFunctionInfobiz(FunctionInfoBussiness functionInfobiz) {
		this.functionInfobiz = functionInfobiz;
	}

	public void setFunctionInfoSystemBussiness(
			FunctionInfoSystemBussiness functionInfoSystemBussiness) {
		this.functionInfoSystemBussiness = functionInfoSystemBussiness;
	}

	public void setRoleSystemBussiness(RoleSystemBussiness roleSystemBussiness) {
		this.roleSystemBussiness = roleSystemBussiness;
	}

	public void setGroupSystemBussiness(GroupSystemBussiness groupSystemBussiness) {
		this.groupSystemBussiness = groupSystemBussiness;
	}
	
	
	/**
	 * 新任务消息  左下角弹窗调用的方法    位于main/menu.jsp中
	 * @author 阙超强 14015 
	 * 2011-12-21 16:58:00
	 * @throws IOException 
	 **/
	public String quartzSelect() throws IOException{
		
		String strEempId = request.getParameter("id").toString();
		int intEmpId = Integer.parseInt(strEempId);
		System.out.println("mdfuck:"+intEmpId);
		//查询待办事宜
//		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("SELECT count(id) as tmp ,verifyOrder.id FROM AuditingOrderTab where handlestate =1 and employees like '%"+intEmpId+"%' and verifyOrder.id!=''  group by verifyOrder.id");
//		if(tablist.size()>0)
//		{
//			List<VerifyOrder> orderlist = groupSystemBussiness.getObject("VerifyOrder", "");
//			if(orderlist.size()>0)
//			{
//				ServletActionContext.getContext().getSession().remove("orderlist");
//				ServletActionContext.getContext().getSession().put("orderlist", orderlist);
//			}
//			ServletActionContext.getContext().getSession().remove("backlogList");
//			ServletActionContext.getContext().getSession().put("backlogList", tablist);
//		}
		
		//查询是否有新任务    新任务安排
		String hqlNotice = "from MissionEmp where status = 0 and employee.id = "+intEmpId+" order by buildTime desc";
		Pages pagesMission = messageBussiness.exHqlPages(hqlNotice, 1, 5, null);
		if(pagesMission.getShowCount()>0){
			ServletActionContext.getContext().getSession().remove("pagesMission");
			ServletActionContext.getContext().getSession().put("pagesMission", pagesMission);
		}
		
		//判断是否有新任务和待办事宜  是否需要提示tablist.size()>0 ||
		if( pagesMission.getShowCount()>0){
			response.getWriter().print(0);
		}else{
			response.getWriter().print(1);
		}
	
		return null;
	}


	/**
	 * 登录时显示在欢迎页面的公告
	 * @author 阙超强
	 * 2011-11-22 14:40:35
	 */
	public void showNotice(){
		String hql="from Message where messagetypeByMessagetype.messagetypeid in(4,9,10,18) "+
				"and repealfalg=0 and delfalg=0 and draftfalg=0 order by messageid desc";
		
		//查询出所有公告
		//logger.info("showNoticehql:"+hql);
		List<Message> noticeList = messageBussiness.exHql(hql);
//		logger.info("showNoticenoticeList.size():"+noticeList.size());
		//查询当前页的所有公告
		Pages pagesNotice = messageBussiness.exHqlPages(hql, 1, 5, null);
		//logger.info("pagesNoticeObject:"+pagesNotice);
		//查询出所有公告的发送人  ，分两类:员工和客户
		int noticeListSize = noticeList.size();
		if(noticeListSize > 0){
			String empids = ""; 
			for(int i = 0;i < noticeListSize ; i++)
			{
				if(!StringUtil.isnull(noticeList.get(i).getSender())){
					empids += noticeList.get(i).getSender() + ",";
				}
			}
			//logger.info("dssdsdf"+empids.substring(0,empids.length()-1));
			List<Employee> employeeList = messageBussiness.getObjectList("Employee", " and id in ("+empids.substring(0,empids.length()-1)+")");
			List<Customer> customerList = messageBussiness.getObjectList("Customer", " and customerId in ("+empids.substring(0,empids.length()-1)+")");
			//发送给请求
			ServletActionContext.getContext().getSession().put("pagesNotice", pagesNotice);
			ServletActionContext.getContext().getSession().put("employeeList", employeeList);
			ServletActionContext.getContext().getSession().put("customerList", customerList);
			//logger.info("showNoticeend:");
		}
	}
	
	/**
	 * 登录Action
	 * @return
	 */
	public String User()
	{
		
		/*
		 * A0-2: a digital employee must never be able to log in to the portal.
		 *
		 * The portal identifies humans by a reversible cookie password; the platform identifies
		 * digital employees with HMAC service accounts (ADR-004). Mixing the two would put a whole
		 * organisation's authority behind a cookie that can leak. The check sits in front of the
		 * captcha and the password comparison on purpose: an attempt by an AI account is a
		 * security event even when the captcha was never solved.
		 */
		if (harnessAccountDao != null
				&& harnessAccountDao.isAiAccount(this.users == null ? null : this.users.getLoginName())) {
			logger.warn("[HARNESS-SECURITY] refused portal login for digital employee account: "
					+ this.users.getLoginName());
			HttpServletRequest harnessRequest = ServletActionContext.getRequest();
			harnessRequest.setAttribute("errorMsg",
					"\u8be5\u8d26\u53f7\u662f\u6570\u5b57\u5458\u5de5\u8d26\u53f7\uff0c\u4e0d\u5141\u8bb8\u767b\u5f55 portal\u3002");
			return "error";
		}
		
		// session
		HttpServletRequest request=ServletActionContext.getRequest();
	    HttpSession session= request.getSession();
		//用来判断是否需要记录登陆动态信息
		Object object = request.getSession().getAttribute("loginName");
		Object obj = request.getSession().getAttribute("expiresList");
		System.out.println(this.users.getLoginName());
		// 根据用户名得到对应的对象
		if(this.users.getLoginName()!=null){
			Employee employee= prjdao.getEmp(this.users.getLoginName());
			// 根据empid 得到此员工的是否有邀请的消息，以及得到消息的内容
			ProjectEmp prjemp=prjdao.inviteEmp(employee.getId());
			System.out.println(prjemp);
			if(prjemp.getEmployee()!=null){
				session.setAttribute("prjemp",prjemp);
			}else{
				session.setAttribute("prjemp",null);
			}
			//接收项目管理的员工消息
			System.out.println(String.valueOf(employee.getId()));
			List messagereceiverlist = projectdao.getMessagereceiver(String.valueOf(employee.getId()));
			System.out.println(messagereceiverlist.size());
//			Messagereceiver receiver = (Messagereceiver)messagereceiverlist.get(0);
			if(messagereceiverlist.size()>0){
				session.setAttribute("projectReceiver", messagereceiverlist.get(0));
			}else {
				session.setAttribute("projectReceiver", null);
			}
		}
		
		if(null != obj){
			
			request.getSession().removeAttribute("expiresList");
			
			this.expirationReminder();
		}
		Cookie[] cookies = request.getCookies();   
		Cookie cookie2 = null;
		
	    if(cookies==null)
	    {
	    	return "error";
	    }
	   
		String valuecode=request.getParameter("ValCode");
		String code=(String) request.getSession().getAttribute("rand");
		if(valuecode==null||!valuecode.equals(code)){
			request.setAttribute("errorMsg", "验证码错误！");
			return "error";
		}
		boolean flag=loginBussiness.UserLogin(users);
		/////////////////////////////////////////////////////////////////////
		if(flag){
			logger.info("登录名为："+users.getLoginName());
			request.getSession().setAttribute("loginName", users.getLoginName());

			cookie.putCookie(response, "loginName", users.getLoginName());
			cookie.putCookie(response, "password", users.getPassword());
			Users user = functionInfoSystemBussiness.getObject(users.getLoginName(), users.getPassword());
			request.getSession().setAttribute("empid", user.getUserId());
			request.getSession().setAttribute("useriiid", user.getUserId().toString());
			request.getSession().setAttribute("eId", user.getCustomerOrEmployeeId());
			
			if(user.getMark().equals("employee"))
			{
				//logger.info(222222+user.getMark());
				Employee emp = (Employee) loginBussiness.selEmpOrCus(user.getMark(), user.getCustomerOrEmployeeId());
				
				//判断 isLeave 是否离职 0离职状态
				if(emp.getIsLeave() == null || emp.getIsLeave().equals("") || emp.getIsLeave() ==0 ){
					request.setAttribute("errorMsg", "该员工已离职，禁止登陆系统！");
					return "error";
				}
				
				cookie.putCookie(response, "employeeName", emp.getName().toString());
				cookie.putCookie(response, "employeeId", emp.getId().toString());
				//cookie.putCookie(response, "xxxxyyyy", emp.getId().toString());
//				Cookie cookie3 = new Cookie("missempid",emp.getId().toString());   
//				cookie3.setMaxAge(60 * 60 * 24 * 7);//   
//				ServletActionContext.getResponse().addCookie(cookie3);  

				cookie.putCookie(response, "departmentId", emp.getDepartment().getId().toString());
				
				//将登陆员工信息放到session ， session又变大了 哎
				request.getSession().setAttribute("emp", emp);

				//logger.info("cookieFilaleremark::::::::::::"+emp.getDepartment().getFilialemark());
				
				cookie.putCookie(response, "filialemark", emp.getDepartment().getFilialemark());
				
		/*登录时加载公司动态    阙超强 14015  2011-12-23*/
				//执行sql获得子类ID
				String sonIds = loginBussiness.executeSql("select getChildDeptLst("+emp.getDepartment().getId()+")");

				//权限判断  判断当前登录用户是否可以查看到动态
				int intPermissionGrade = Integer.parseInt(emp.getGroups().getPermissionGrade());
				String hql = "";
				if( intPermissionGrade == 0){
					hql="from Executerecord as tb where 1 = 1 ";
				}else{
					hql="from Executerecord as tb where 1 = 1 and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
					" and tb.employee.department.id in ("+sonIds+")))";
				}
				
				//判断是否已经查看过了  seenEmpID为已经查看过员工id
				hql += " and "+emp.getId()+" not in seenEmpId ";
				
				//id倒序排列 以显示最新
				hql += " order by tb.id desc ";
				
				//执行分页查询
				//logger.info("hql"+hql);
				Pages pagesExe=messageBussiness.exHqlPages(hql, 1, 5, null);
				ServletActionContext.getContext().getSession().put("pagesExe", pagesExe);
				//logger.info("pages"+pagesExe);
		/*登录时加载公告信息*/
				this.showNotice();
				
		/*   待办审核单据提醒      */
				this.selbacklog();
		/*  待审批日志提醒 */
				this.workLog();
		/*   即将到期的单据提醒*/
//				this.expirationReminder();
		/*     安排任务          */
//				List<MissionEmp> missionemplist = groupSystemBussiness.getObject("MissionEmp", " and status = 0 and employee.id = "+emp.getId().toString()+" order by buildTime desc limit 5");
//				
//				if(missionemplist.size()>0)
//				{
//					ServletActionContext.getContext().getSession().put("notreceivemission", missionemplist);
//				}
				String hqlNotice = "from MissionEmp where status = 0 and employee.id = "+emp.getId().toString()+" order by buildTime desc";
				//logger.info("hqlNotice:"+hqlNotice);
				Pages pagesMission = messageBussiness.exHqlPages(hqlNotice, 1, 5, null);
				ServletActionContext.getContext().getSession().put("pagesMission", pagesMission);
				//logger.info("pagesMission"+pagesMission);
				
		/*   今日任务    */
//				Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
//			    calendar.add(Calendar.DATE, 0);    //得到当天
//			    
//			    String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			    
			    //员工日程计划(提醒-计划-日记事)
//			    String hqlPlan = "From Scheduleplan as tb where tb.endtime like '%"+yestedayDate+"%' and tb.plantype = 0 and tb.state = 0 and tb.employee.id = " + emp.getId().toString();
			    String hqlPlan = "From Scheduleplan as tb where tb.employee.id = " + emp.getId().toString() +" order by id desc";
			    Pages planlist = messageBussiness.exHqlPages(hqlPlan, 1, 5, null);
			    
//			    //公司安排任务 注释掉 2012-6-11 lzy
//			    List<Mission> missionlist = groupSystemBussiness.getObject("Mission", " and date(exp_end_time)>= curdate() and taskId in (select mission.taskId from MissionEmp where status = '1' and employee.id = "+emp.getId().toString()+")");
//			    //如果超出5条只显示5条
//			    if(missionlist.size() > 5){
//			    	missionlist = missionlist.subList(0, 5);
//			    }
			    
			    ServletActionContext.getContext().getSession().put("pagesPlan", planlist);
//			    ServletActionContext.getContext().getSession().put("missionlist", missionlist);
			}
			else if(user.getMark().equals("customer"))
			{
				//logger.info("custom");
				Customer cus=(Customer)loginBussiness.selEmpOrCus(user.getMark(), user.getCustomerOrEmployeeId());
				cookie.putCookie(response, "customerName", cus.getCustomerName());
				cookie.putCookie(response, "customerId", cus.getCustomerId().toString());
			}
			
			user.setLastLoginTime(user.getLoginTime());
			user.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			user.setLastIpPart(user.getIpPart());
			
			user.setIpPart(this.getIpAddr(request));
			user.setCounts(user.getCounts()+1);
			
			int result = functionInfoSystemBussiness.saveOrUpdateUsers(user);
			//logger.info(" 修改用户登录信息： result = "+result );
			
			RoleFunctionInfo rff = functionInfoSystemBussiness.isExistsPermissionByUserId(user.getUserId());
//			// 根据当前登录人得到其岗位权限，要想找到岗位权限就先得当前登录人的所属部门
//			Employee employee =(Employee) this.request.getSession().getAttribute("emp");
//			// 根据部门得到其权限
//			List<Workposition> positionList=roleSystemBussiness.positionList(employee.getDepartment().getId());
						
			String functions = "";
			String option = "";
			// 根据角色设置权限
			if(rff!=null)
			{
				functions = rff.getFunctionIds();
				option = rff.getPermissions();
			}
			else
			{
				Roles roles = roleSystemBussiness.getObject(user.getRoles().getRoleId());
				functions = roles.getFunctionIds();
				//logger.info("functions:"+functions);
				option = roles.getPermissions();
			}
//			//根据岗位设置权限	
//			if(positionList!=null && positionList.size()>0){
//				for(int i=0;i<positionList.size();i++){
//					Workposition position=positionList.get(i);
//					if(position.getFunctionIDs()!=null && !position.getFunctionIDs().equals("null") && !position.getFunctionIDs().equals("")){
//						functions+=position.getFunctionIDs();
//					}
//					if(position.getPermissions()!=null && !position.getPermissions().equals("null") && !position.getPermissions().equals("")){
//						option+=position.getPermissions();
//					}
//				}
//			}else{
//				
//			}
			if(StringUtil.isnull(functions)){
				logger.error("该用户无权限，请核实用户角色是否存在!");
				return "error";
			}
			String subfunction = functions.substring(0,functions.length()-1);
			logger.info("subfunction"+subfunction);
			//and versionFlag=1 是内部管理系统 and versionFlag=2 是销售业务子系统(新框架)
			List<FunctionInfo> functionInfoslist = groupSystemBussiness.getObject("FunctionInfo", " and versionFlag=1 and functionId in ("+subfunction+") order by delflag ");
			logger.info(" and functionId in ("+subfunction+") order by delflag ");
			List<FunctionInfo> indexlist = groupSystemBussiness.getObject("FunctionInfo", " and linkfunctionname in ( '商品入库','仓库综合查询','仓库商品报警提示','员工信息管理')");
			logger.info("option : "+option);
			String [] aa = option.split(",");
			Map map = new HashMap();
			for(int i=0;i<indexlist.size();i++)
			{
				Map map1 = new HashMap();
				for(int j=0;j<aa.length;j++)
				{
					
					if(Integer.parseInt(aa[j].substring(0,aa[j].indexOf(".") ))==indexlist.get(i).getFunctionId())
					{
						
						map1.put(aa[j].substring((aa[j].indexOf(".")+1), aa[j].length()), aa[j]);
					}
				}
				map.put(indexlist.get(i).getLinkFunctionName(),map1 );
			}
			//logger.info("aa : "+map.size());
			request.getSession().setAttribute("index", map);
			if(functionInfoslist.size()>0)
			{
				ServletActionContext.getContext().getSession().put("infolist", functionInfoslist);
			}

			
			
			/*添加登陆的动态信息到数据库*/
			if(null == object){
				this.addRecord();
			}
			
			return "success";
		}
		else{
			request.setAttribute("errorMsg", "登录失败！用户名或密码错误");
			return "error";
		}
	}
	
	/*********
	 * 新版系统登录--登录岗侠设置权限
	 */
	/**
	 * 登录Action
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String User2()
	{

//	 String a=	request.getParameter("login_email");
//	 String b=	request.getParameter("login_password");
//	 String c=	request.getParameter("format");
//	 String d=	request.getParameter("lang");
//	 String e=	request.getParameter("error_on_empty");
		
		// 判断有没有选择分岗
		String fgwop=request.getParameter("fgwopid");
		List<Workposition> positionList=new ArrayList<Workposition>();
		if(fgwop!=null && fgwop.trim().length()>0){
			int fgwopid=Integer.parseInt(fgwop);
			Workposition fgwpo=(Workposition)roleSystemBussiness.getObject(Workposition.class, fgwopid); 
			positionList.add(fgwpo);
			String functions = "";
			String option = "";
			//根据岗位设置权限	
			if(positionList!=null && positionList.size()>0){
				for(int i=0;i<positionList.size();i++){
					Workposition position=positionList.get(i);
					if(position.getFunctionIDs()!=null && !position.getFunctionIDs().equals("null") && !position.getFunctionIDs().equals("")){
						functions+=position.getFunctionIDs();
					}
					if(position.getPermissions()!=null && !position.getPermissions().equals("null") && !position.getPermissions().equals("")){
						option+=position.getPermissions();
					}
				}
				
				// 根据当前登录人与当前岗位得到岗位类型
				Employee workpemp =(Employee) this.request.getSession().getAttribute("emp");
				if(workpemp == null ){
					request.setAttribute("errorMsg", "登陆失效!重新登陆");
					return "error";
				}
				String hql="from WorkpositionEmployee where employee.id="+workpemp.getId()+" and workposition.id="+fgwpo.getId();
				List list= roleSystemBussiness.getlist(hql);
				if(list!=null && list.size()>0){
					WorkpositionEmployee wop=(WorkpositionEmployee)list.get(0);
					ServletActionContext.getContext().getSession().put("empposition",wop);
				}
			}else{
				return "nullqx";
			}
			if(StringUtil.isnull(functions)){
				logger.error("该用户无权限，请核实用户角色是否存在!");
				return "nullqx";
			}
			String subfunction = functions.substring(0,functions.length()-1);
			logger.info("subfunction"+subfunction);
			List<FunctionInfo> functionInfoslist = groupSystemBussiness.getObject("FunctionInfo", " and functionId in ("+subfunction+") order by delflag ");
			logger.info(" and functionId in ("+subfunction+") order by delflag ");
			List<FunctionInfo> indexlist = groupSystemBussiness.getObject("FunctionInfo", " and linkfunctionname in ( '商品入库','仓库综合查询','仓库商品报警提示','员工信息管理')");
			logger.info("option : "+option);
			String [] aa = option.split(",");
			Map<String,Map<String,String>> map = new HashMap<String,Map<String,String>>();
			if(aa[0]!=null && aa[0].trim().length()>0){
				for(int i=0;i<indexlist.size();i++)
				{
					Map<String,String> map1 = new HashMap<String,String>();				
					for(int j=0;j<aa.length;j++)
					{
						if(Integer.parseInt(aa[j].substring(0,aa[j].indexOf(".") ))==indexlist.get(i).getFunctionId())
						{
							
							map1.put(aa[j].substring((aa[j].indexOf(".")+1), aa[j].length()), aa[j]);
						}
					}
					map.put(indexlist.get(i).getLinkFunctionName(),map1 );
				}
			}
			//logger.info("aa : "+map.size());
			request.getSession().setAttribute("index", map);
			if(functionInfoslist.size()>0)
			{
				ServletActionContext.getContext().getSession().put("infolist", functionInfoslist);
			}
			return "success";
		}
		else{
			// session
			HttpServletRequest request=ServletActionContext.getRequest();
		    HttpSession session= request.getSession();
			//用来判断是否需要记录登陆动态信息
			Object object = request.getSession().getAttribute("loginName");
			Object obj = request.getSession().getAttribute("expiresList");
			System.out.println(this.users.getLoginName());
			// 根据用户名得到对应的对象
			if(this.users.getLoginName()!=null){
				Employee employee= prjdao.getEmp(this.users.getLoginName());
				// 根据empid 得到此员工的是否有邀请的消息，以及得到消息的内容
				if(employee!=null){
					ProjectEmp prjemp=prjdao.inviteEmp(employee.getId());
					if(prjemp.getEmployee()!=null){
						session.setAttribute("prjemp",prjemp);
					}else{
						session.setAttribute("prjemp",null);
					}
					
					//接收项目管理的员工消息
					System.out.println(String.valueOf(employee.getId()));
					List messagereceiverlist = projectdao.getMessagereceiver(String.valueOf(employee.getId()));
					System.out.println(messagereceiverlist.size());
		//			Messagereceiver receiver = (Messagereceiver)messagereceiverlist.get(0);
					if(messagereceiverlist.size()>0){
						session.setAttribute("projectReceiver", messagereceiverlist.get(0));
					}else {
						session.setAttribute("projectReceiver", null);
					}
				}
			}
			
			if(null != obj){
				
				request.getSession().removeAttribute("expiresList");
				
				this.expirationReminder();
			}
			Cookie[] cookies = request.getCookies();   
			Cookie cookie2 = null;
			
		    if(cookies==null)
		    {
		    	return "error";
		    }
		   
			String valuecode=request.getParameter("ValCode");
			String code=(String) request.getSession().getAttribute("rand");
			if(valuecode==null||!valuecode.equals(code)){
				request.setAttribute("errorMsg", "验证码错误！");
				return "error";
			}
			boolean flag=loginBussiness.UserLogin(users);
			/////////////////////////////////////////////////////////////////////
			if(flag){
				logger.info("登录名为："+users.getLoginName());
				request.getSession().setAttribute("loginName", users.getLoginName());
	
				cookie.putCookie(response, "loginName", users.getLoginName());
				cookie.putCookie(response, "password", users.getPassword());
				Users user = functionInfoSystemBussiness.getObject(users.getLoginName(), users.getPassword());
				request.getSession().setAttribute("empid", user.getUserId());
				request.getSession().setAttribute("useriiid", user.getUserId().toString());
				request.getSession().setAttribute("eId", user.getCustomerOrEmployeeId());
				
				if(user.getMark().equals("employee"))
				{
					//logger.info(222222+user.getMark());
					Employee emp = (Employee) loginBussiness.selEmpOrCus(user.getMark(), user.getCustomerOrEmployeeId());
					
					//判断 isLeave 是否离职 0离职状态
					if(emp.getIsLeave() == null || emp.getIsLeave().equals("") || emp.getIsLeave() ==0 ){
						request.setAttribute("errorMsg", "该员工已离职，禁止登陆系统！");
						return "error";
					}
					
					cookie.putCookie(response, "employeeName", emp.getName().toString());
					cookie.putCookie(response, "employeeId", emp.getId().toString());
					//cookie.putCookie(response, "xxxxyyyy", emp.getId().toString());
	//				Cookie cookie3 = new Cookie("missempid",emp.getId().toString());   
	//				cookie3.setMaxAge(60 * 60 * 24 * 7);//   
	//				ServletActionContext.getResponse().addCookie(cookie3);  
	
					cookie.putCookie(response, "departmentId", emp.getDepartment().getId().toString());
					
					//将登陆员工信息放到session ， session又变大了 哎
					request.getSession().setAttribute("emp", emp);
	
					//logger.info("cookieFilaleremark::::::::::::"+emp.getDepartment().getFilialemark());
					
					cookie.putCookie(response, "filialemark", emp.getDepartment().getFilialemark());
					
			/*登录时加载公司动态    阙超强 14015  2011-12-23*/
					//执行sql获得子类ID
					String sonIds = loginBussiness.executeSql("select getChildDeptLst("+emp.getDepartment().getId()+")");
	
					//权限判断  判断当前登录用户是否可以查看到动态
					int intPermissionGrade = Integer.parseInt(emp.getGroups().getPermissionGrade());
					String hql = "";
					if( intPermissionGrade == 0){
						hql="from Executerecord as tb where 1 = 1 ";
					}else{
						hql="from Executerecord as tb where 1 = 1 and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
						" and tb.employee.department.id in ("+sonIds+")))";
					}
					
					//判断是否已经查看过了  seenEmpID为已经查看过员工id
					hql += " and "+emp.getId()+" not in seenEmpId ";
					
					//id倒序排列 以显示最新
					hql += " order by tb.id desc ";
					
					//执行分页查询
					//logger.info("hql"+hql);
					Pages pagesExe=messageBussiness.exHqlPages(hql, 1, 5, null);
					ServletActionContext.getContext().getSession().put("pagesExe", pagesExe);
					//logger.info("pages"+pagesExe);
			/*登录时加载公告信息*/
					this.showNotice();
					
			/*   待办审核单据提醒      */
					this.selbacklog();
			/*  待审批日志提醒 */
					this.workLog();
			/*   即将到期的单据提醒*/
	//				this.expirationReminder();
			/*     安排任务          */
	//				List<MissionEmp> missionemplist = groupSystemBussiness.getObject("MissionEmp", " and status = 0 and employee.id = "+emp.getId().toString()+" order by buildTime desc limit 5");
	//				
	//				if(missionemplist.size()>0)
	//				{
	//					ServletActionContext.getContext().getSession().put("notreceivemission", missionemplist);
	//				}
					String hqlNotice = "from MissionEmp where status = 0 and employee.id = "+emp.getId().toString()+" order by buildTime desc";
					//logger.info("hqlNotice:"+hqlNotice);
					Pages pagesMission = messageBussiness.exHqlPages(hqlNotice, 1, 5, null);
					ServletActionContext.getContext().getSession().put("pagesMission", pagesMission);
					//logger.info("pagesMission"+pagesMission);
					
			/*   今日任务    */
	//				Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
	//			    calendar.add(Calendar.DATE, 0);    //得到当天
	//			    
	//			    String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				    
				    //员工日程计划(提醒-计划-日记事)
	//			    String hqlPlan = "From Scheduleplan as tb where tb.endtime like '%"+yestedayDate+"%' and tb.plantype = 0 and tb.state = 0 and tb.employee.id = " + emp.getId().toString();
				    String hqlPlan = "From Scheduleplan as tb where tb.employee.id = " + emp.getId().toString() +" order by id desc";
				    Pages planlist = messageBussiness.exHqlPages(hqlPlan, 1, 5, null);
				    
	//			    //公司安排任务 注释掉 2012-6-11 lzy
	//			    List<Mission> missionlist = groupSystemBussiness.getObject("Mission", " and date(exp_end_time)>= curdate() and taskId in (select mission.taskId from MissionEmp where status = '1' and employee.id = "+emp.getId().toString()+")");
	//			    //如果超出5条只显示5条
	//			    if(missionlist.size() > 5){
	//			    	missionlist = missionlist.subList(0, 5);
	//			    }
				    
				    ServletActionContext.getContext().getSession().put("pagesPlan", planlist);
	//			    ServletActionContext.getContext().getSession().put("missionlist", missionlist);
				}
				else if(user.getMark().equals("customer"))
				{
					//logger.info("custom");
					Customer cus=(Customer)loginBussiness.selEmpOrCus(user.getMark(), user.getCustomerOrEmployeeId());
					cookie.putCookie(response, "customerName", cus.getCustomerName());
					cookie.putCookie(response, "customerId", cus.getCustomerId().toString());
				}
				
				user.setLastLoginTime(user.getLoginTime());
				user.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				user.setLastIpPart(user.getIpPart());
				
				user.setIpPart(this.getIpAddr(request));
				user.setCounts(user.getCounts()+1);
				
				int result = functionInfoSystemBussiness.saveOrUpdateUsers(user);
				//logger.info(" 修改用户登录信息： result = "+result );
				
				RoleFunctionInfo rff = functionInfoSystemBussiness.isExistsPermissionByUserId(user.getUserId());
				// 根据当前登录人得到其岗位权限，根据岗位找到主岗
				Employee employee =(Employee) this.request.getSession().getAttribute("emp");
				// 根据部门得到其权限
				positionList=roleSystemBussiness.positionList(employee.getId()); 
				// 得到分岗编号
				List<Workposition> fglist=new ArrayList<Workposition>();
				// 保存分管岗位的集合
				if(positionList!=null && positionList.size()>0){
					String str=positionList.get(0).getParpostionid();
					// 先将主岗保存进来
					fglist.add(positionList.get(0));
					if(str!=null && str.trim().length()>0){
						String[] arr=str.split(",");
						for(int i=0;i<arr.length;i++){
							String posid=arr[i];
							Workposition wpo=(Workposition)roleSystemBussiness.getObject(Workposition.class, Integer.parseInt(posid));
							fglist.add(wpo);
						}
					}
					String hql="from WorkpositionEmployee where employee.id="+employee.getId()+" and workposition.id="+positionList.get(0).getId();
					List list= roleSystemBussiness.getlist(hql);
					if(list!=null && list.size()>0){
						WorkpositionEmployee wop=(WorkpositionEmployee)list.get(0);
						ServletActionContext.getContext().getSession().put("empposition",wop);
					}
				}
				// 找到当前登录人不是主岗的情况下
				String hql="from WorkpositionEmployee where employee.id="+employee.getId()+" and positiontype!=1";
				List otherList=roleSystemBussiness.getlist(hql);
				for(int i=0;i<otherList.size();i++){
					WorkpositionEmployee wop=(WorkpositionEmployee)otherList.get(i);
					String str=wop.getWorkposition().getParpostionid();
					fglist.add(wop.getWorkposition());
					if(str!=null && str.trim().length()>0){
						String[] arr=str.split(",");
						for(int j=0;j<arr.length;j++){
							String posid=arr[j];
							Workposition wpo=(Workposition)roleSystemBussiness.getObject(Workposition.class, Integer.parseInt(posid));
							fglist.add(wpo);
						}
					}
				}
				ServletActionContext.getContext().getSession().put("fglist", fglist);
				// 如果主岗是空的话则随便找一个岗位当主岗
				if(positionList.size()<=0 && otherList.size()>0){
					WorkpositionEmployee workemp=(WorkpositionEmployee)otherList.get(0);
					positionList.add(workemp.getWorkposition());
					String hql2="from WorkpositionEmployee where employee.id="+employee.getId()+" and workposition.id="+positionList.get(0).getId();
					List list= roleSystemBussiness.getlist(hql2);
					if(list!=null && list.size()>0){
						WorkpositionEmployee wop=(WorkpositionEmployee)list.get(0);
						ServletActionContext.getContext().getSession().put("empposition",wop);
					}
				}
				String functions = "";
				String option = "";
				String pname = "";//岗位名称
				//根据岗位设置权限	
				if(positionList!=null && positionList.size()>0){
					for(int i=0;i<positionList.size();i++){
						Workposition position=positionList.get(i);
						pname =position.getName();
						if(position.getFunctionIDs()!=null && !position.getFunctionIDs().equals("null") && !position.getFunctionIDs().equals("")){
							functions+=position.getFunctionIDs();
						}
						if(position.getPermissions()!=null && !position.getPermissions().equals("null") && !position.getPermissions().equals("")){
							option+=position.getPermissions();
						}
					}
				}else{
					logger.error("该用户无权限，请核实用户岗位是否存在!");
					return "nullqx";
				}
				if(StringUtil.isnull(functions)){
					logger.error("用户所在岗位"+pname+" 无任何菜单权限，请联系管理员添加");
					return "nullqx";
				}
				String subfunction = functions.substring(0,functions.length()-1);
				logger.info("subfunction"+subfunction);
				//and versionFlag=1 是内部管理系统 and versionFlag=2 是销售业务子系统(新框架)
				List<FunctionInfo> functionInfoslist = groupSystemBussiness.getObject("FunctionInfo", " and versionFlag=1 and functionId in ("+subfunction+") order by delflag ");
				logger.info(" and functionId in ("+subfunction+") order by delflag ");
				List<FunctionInfo> indexlist = groupSystemBussiness.getObject("FunctionInfo", " and linkfunctionname in ( '商品入库','仓库综合查询','仓库商品报警提示','员工信息管理')");
				logger.info("option : "+option);
				String [] aa = option.split(",");
				Map map = new HashMap();
				if(aa[0]!=null && aa[0].trim().length()>0){
					for(int i=0;i<indexlist.size();i++)
					{
						Map map1 = new HashMap();
						for(int j=0;j<aa.length;j++)
						{
							
							if(Integer.parseInt(aa[j].substring(0,aa[j].indexOf(".") ))==indexlist.get(i).getFunctionId())
							{
								
								map1.put(aa[j].substring((aa[j].indexOf(".")+1), aa[j].length()), aa[j]);
							}
						}
						map.put(indexlist.get(i).getLinkFunctionName(),map1 );
					}
				}
				//logger.info("aa : "+map.size());
				request.getSession().setAttribute("index", map);
				if(functionInfoslist.size()>0)
				{
					ServletActionContext.getContext().getSession().put("infolist", functionInfoslist);
				}
	
				
				
				/*添加登陆的动态信息到数据库*/
				if(null == object){
					this.addRecord();
				}
				
				return "success";
			}
			else{
				request.setAttribute("errorMsg", "登录失败！用户名或密码错误");
				return "error";
			}
		}
	}
	/**
	 * 新的登录验证帐号密码
	 */
	public void valloginNameorpwd(){

    	try {
		List supperList=new ArrayList();
		List childList=new ArrayList();
		// 判断有没有选择分岗
		String fgwop=request.getParameter("fgwopid");
		List<Workposition> positionList=new ArrayList<Workposition>();

		logger.info("potal系统...");
		// session
		HttpServletRequest request=ServletActionContext.getRequest();
	    HttpSession session= request.getSession();
	    request.removeAttribute("functionselid");
	    request.getSession().removeAttribute("functionSupLists");
	    request.getSession().removeAttribute("functionChidLists");
	    String logname=loginname;
	    String pwd=loginpwd!=null?loginpwd:"";
	    String yzm1=yzm!=null?yzm:"";
	    String selql="from Users where  delflag=0 and loginName='"+logname+"'";
	    List ls= loginBussiness.executeHql(selql);
	    if(ls.size()<1){
	    	
				response.getWriter().print("nologinname");//帐号不存在或者密码错误
		
	    }else{
	    	
	    	if(loginpwd==null || loginpwd==""){
	    	response.getWriter().print("ok");
	    	}else{
	    		users.setLoginName(logname);
	    		users.setPassword(loginpwd);
	    		boolean flag=loginBussiness.UserLogin(users);
	    		if(flag){
	    			if(yzm=="" || yzm ==null){
	    				response.getWriter().print("showyzm");//显示验证码
	    				
	    			}else{
	    				
	    				String code=(String) request.getSession().getAttribute("rand");
	    				if(yzm==null|| !yzm.equals(code)){
	    					
	    					response.getWriter().print("rongyzm");//验证码错误
	    				}else{
	    					response.getWriter().print("showsub");//显示提交按钮
	    					
	    					
	    				}
	    				
	    				
	    			}
	    			
	    			
	    		}else{
	    		
	    			request.getSession().setAttribute("cx", 1);//次数
	    			response.getWriter().print("rongpwd");//密码错误
	    			
	    		}
	    		
	    	}
	    	
	    }
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	

	public String getYzm() {
		return yzm;
	}
	public void setYzm(String yzm) {
		this.yzm = yzm;
	}
	public String getLoginpwd() {
		return loginpwd;
	}
	public void setLoginpwd(String loginpwd) {
		this.loginpwd = loginpwd;
	}
	public String potals(){
		Set set =new HashSet();
		Integer ids;
		List supperList=new ArrayList();
		List childList=new ArrayList();
		// 判断有没有选择分岗
		String fgwop=request.getParameter("fgwopid");
		List<Workposition> positionList=new ArrayList<Workposition>();
		if(fgwop!=null && fgwop.trim().length()>0){
			int fgwopid=Integer.parseInt(fgwop);
			Workposition fgwpo=(Workposition)roleSystemBussiness.getObject(Workposition.class, fgwopid); 
			positionList.add(fgwpo);
			String functions = "";
			String option = "";
			//根据岗位设置权限	
			if(positionList!=null && positionList.size()>0){
				for(int i=0;i<positionList.size();i++){
					Workposition position=positionList.get(i);
					if(position.getFunctionIDs()!=null && !position.getFunctionIDs().equals("null") && !position.getFunctionIDs().equals("")){
						functions+=position.getFunctionIDs();
					}
					if(position.getPermissions()!=null && !position.getPermissions().equals("null") && !position.getPermissions().equals("")){
						option+=position.getPermissions();
					}
				}
				
				// 根据当前登录人与当前岗位得到岗位类型
				Employee workpemp =(Employee) this.request.getSession().getAttribute("emp");
				System.out.println(workpemp.getId());
				System.out.println(fgwpo.getId());
				String hql="from WorkpositionEmployee where employee.id="+workpemp.getId()+" and workposition.id="+fgwpo.getId();
				List list= roleSystemBussiness.getlist(hql);
				if(list!=null && list.size()>0){
					WorkpositionEmployee wop=(WorkpositionEmployee)list.get(0);
					ServletActionContext.getContext().getSession().put("empposition",wop);
				}


				//获取日志访问记录集
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MONTH, -1);//时间倒退1月
				String datestr = TimePattern1.doDateTime3(c.getTime());
				String loghql = "From WorkLog where employeeByEmpId.id="+workpemp.getId()+" and  recordTime >='"+datestr+"'";
				List<WorkLog> workList = loginBussiness.executeHql(loghql);
				StringBuffer sb = new StringBuffer();
				List erList = new ArrayList();
				for (Iterator it = workList.iterator(); it
						.hasNext();) {
					WorkLog w = (WorkLog) it.next();
					sb.append(w.getId()+",");
				}
				if(sb.length() == 0){
					request.getSession().setAttribute("erList", erList);
				}else{
					String hqlRecord = "From Executerecord tb where tb.entityName='WorkLog' and tb.entityId in("+sb.substring(0,sb.length()-1)+") and tb.employee.id !="+workpemp.getId()+"  order by tb.id desc";
					erList = loginBussiness.executeHql(hqlRecord);
					request.getSession().setAttribute("erList", erList);
				}
				
			}else{
				logger.error("该用户无权限，请核实用户角色是否存在!");
				return "nullqx";
			}
			for (Workposition wor : positionList) {
		    	if(wor.getFunctionIDs()!=null){
			    	String []functs=wor.getFunctionIDs().split(",");
			    	for (int i = 0; i < (functs.length-1); i++) {
						ids=Integer.parseInt(functs[i]);
					    set.add(ids);
					}
		    	}
			}
			for (Iterator iterator = set.iterator(); iterator.hasNext();) {
				int funinfo = (Integer) iterator.next();
				List<FunctionInfo> funlist=loginBussiness.executionSql("from FunctionInfo f where f.functionId="+funinfo+"  and f.versionFlag=2");
				if(funlist.size()>0){
				  FunctionInfo funobj=funlist.get(0);
				  logger.info(funobj.getFunctionId()+",name="+funobj.getLinkFunctionName());
				  if(funobj.getSuperId()==0){
					  supperList.add(funobj);
					
				  }
				}
			}
		    if(supperList!=null && supperList.size()>0){
		    	FunctionInfo wp = (FunctionInfo)supperList.get(0);
		    	List<FunctionInfo>  funlist1=loginBussiness.executionSql("from FunctionInfo f where f.superId="+wp.getFunctionId()+"  and f.versionFlag=2");
		    	WorkpositionEmployee wopemp=(WorkpositionEmployee) request.getSession().getAttribute("empposition");
				String str=wopemp.getWorkposition().getFunctionIDs();
				String[] arrfun=null;
				if(str!=null && str.length()>0){
					arrfun=str.split(",");
					for(int i=0;i<arrfun.length;i++){
						if(funlist1.size()==0){
					    	  childList.add("");
					    	  break;
						}
						  if(funlist1.size()>0){
							  for (FunctionInfo funobj : funlist1) {
								  if(funobj.getFunctionId().toString().equals(arrfun[i])){
									  logger.info(funobj.getFunctionId()+",name="+funobj.getLinkFunctionName());
									  childList.add(funobj);
								  }
							  }
						  }
					 }
				}else{
					logger.error("该用户无菜单权限!");
					return "nullqx";
				}
		    }
			
//		    for (Iterator iterator = set.iterator(); iterator.hasNext();) {
//				int funinfo = (Integer) iterator.next();
//				List<FunctionInfo> funlist=loginBussiness.executionSql("from FunctionInfo f where f.functionId="+funinfo+"  and f.versionFlag=2");
//				if(funlist.size()>0){
//				  FunctionInfo funobj=funlist.get(0);
//				  logger.info(funobj.getFunctionId()+",name="+funobj.getLinkFunctionName());
//				  if(funobj.getSuperId()==0){
//					  supperList.add(funobj);
//					
//				  }
//				}
//			}
//		    for (Iterator iterator = supperList.iterator(); iterator.hasNext();) {
//		    	FunctionInfo wp = (FunctionInfo) iterator.next();
//				  List<FunctionInfo> funlist1=loginBussiness.executionSql("from FunctionInfo f where f.superId="+wp.getFunctionId()+"  and f.versionFlag=2"); 
//			      if(funlist1.size()==0){
//			    	  childList.add("");
//			    	  break;
//			      }else{
//					  for (FunctionInfo functionnfo : funlist1) {
//				    	  childList.add(functionnfo);
//					  }
//					  break;
//			      }
//			}
		    request.getSession().setAttribute("functionSupLists", supperList);
		    request.getSession().setAttribute("functionChidLists", childList);
		    request.setAttribute("functionselid", "00");
		    
			return "potalSuccess";
		}else{
		logger.info("potal系统...");
		// session
		HttpServletRequest request=ServletActionContext.getRequest();
	    HttpSession session= request.getSession();
	    request.removeAttribute("functionselid");
	    request.getSession().removeAttribute("functionSupLists");
	    request.getSession().removeAttribute("functionChidLists");
		boolean flag=loginBussiness.UserLogin(users);
		if(flag){
			String valuecode=request.getParameter("ValCode");
			String code=(String) request.getSession().getAttribute("rand");
			if(valuecode==null||!valuecode.equals(code)){
				request.setAttribute("errorMsg", "验证码错误！");
				return "error";
			}
			logger.info("登录名为："+users.getLoginName());
			cookie.putCookie(response, "loginName", users.getLoginName());
			cookie.putCookie(response, "password", users.getPassword());
			//将登陆员工信息放到session ， session又变大了 哎
	        request.getSession().setAttribute("userInfos", users);
	        Users usr = functionInfoSystemBussiness.getObject(users.getLoginName(), users.getPassword());
	        if(usr.getMark().equals("employee"))
			{
				Employee emp = (Employee) loginBussiness.selEmpOrCus(usr.getMark(), usr.getCustomerOrEmployeeId());
				//判断 isLeave 是否离职 0离职状态
				if(emp.getIsLeave() == null || emp.getIsLeave().equals("") || emp.getIsLeave() ==0 ){
					request.setAttribute("errorMsg", "该员工已离职，禁止登陆系统！");
					return "error";
				}
				
				//将登陆员工信息放到session ， session又变大了 哎
				request.getSession().setAttribute("emp", emp);
				positionList=new ArrayList<Workposition>();
				// 根据部门得到其权限
				positionList=roleSystemBussiness.positionList(emp.getId()); 
				// 得到分岗编号
				List<Workposition> fglist=new ArrayList<Workposition>();
				// 保存分管岗位的集合
				if(positionList!=null && positionList.size()>0){
					String str=positionList.get(0).getParpostionid();
					// 先将主岗保存进来
					fglist.add(positionList.get(0));
					if(str!=null && str.trim().length()>0){
						String[] arr=str.split(",");
						for(int i=0;i<arr.length;i++){
							String posid=arr[i];
							Workposition wpo=(Workposition)roleSystemBussiness.getObject(Workposition.class, Integer.parseInt(posid));
							fglist.add(wpo);
						}
					}
					String hql="from WorkpositionEmployee where employee.id="+emp.getId()+" and workposition.id="+positionList.get(0).getId();
					List list1= roleSystemBussiness.getlist(hql);
					if(list1!=null && list1.size()>0){
						WorkpositionEmployee wop=(WorkpositionEmployee)list1.get(0);
						ServletActionContext.getContext().getSession().put("empposition",wop);
					}
				}
				// 找到当前登录人不是主岗的情况下
				String hql="from WorkpositionEmployee where employee.id="+emp.getId()+" and positiontype!=1";
				List otherList=roleSystemBussiness.getlist(hql);
				for(int i=0;i<otherList.size();i++){
					WorkpositionEmployee wop=(WorkpositionEmployee)otherList.get(i);
					String str=wop.getWorkposition().getParpostionid();
					fglist.add(wop.getWorkposition());
					if(str!=null && str.trim().length()>0){
						String[] arr=str.split(",");
						for(int j=0;j<arr.length;j++){
							String posid=arr[j];
							Workposition wpo=(Workposition)roleSystemBussiness.getObject(Workposition.class, Integer.parseInt(posid));
							fglist.add(wpo);
						}
					}
				}
				//不知道怎么搞去掉了重复
				for ( int i = 0 ; i < fglist.size() - 1 ; i ++ ) {//去掉重复的数据
				     for ( int j = fglist.size() - 1 ; j > i; j -- ) {
				       if (fglist.get(j).getId()==fglist.get(i).getId()) {
				    	   fglist.remove(j);
				       } 
				      } 
				    }
				ServletActionContext.getContext().getSession().put("fglist", fglist);
				// 如果主岗是空的话则随便找一个岗位当主岗
				if(positionList.size()<=0 && otherList.size()>0){
					WorkpositionEmployee workemp=(WorkpositionEmployee)otherList.get(0);
					positionList.add(workemp.getWorkposition());
					String hql2="from WorkpositionEmployee where employee.id="+emp.getId()+" and workposition.id="+positionList.get(0).getId();
					List list2= roleSystemBussiness.getlist(hql2);
					if(list2!=null && list2.size()>0){
						WorkpositionEmployee wop=(WorkpositionEmployee)list2.get(0);
						ServletActionContext.getContext().getSession().put("empposition",wop);
					}
				}
				if(positionList.size()<=0){
					logger.error("该用户无权限，请核实用户角色是否存在!");
					return "nullqx";
				}
			    for (Workposition wor : positionList) {
			    	if(wor.getFunctionIDs()!=null){
				    	String []functs=wor.getFunctionIDs().split(",");
				    	for (int i = 0; i < (functs.length-1); i++) {
							ids=Integer.parseInt(functs[i]);
						    set.add(ids);
						}
			    	}
				}
			    for (Iterator iterator = set.iterator(); iterator.hasNext();) {
					int funinfo = (Integer) iterator.next();
					List<FunctionInfo> funlist=loginBussiness.executionSql("from FunctionInfo f where f.functionId="+funinfo+"  and f.versionFlag=2");
					if(funlist.size()>0){
					  FunctionInfo funobj=funlist.get(0);
					  logger.info(funobj.getFunctionId()+",name="+funobj.getLinkFunctionName());
					  if(funobj.getSuperId()==0){
						  supperList.add(funobj);
						
					  }
					}
				}
			    if(supperList!=null && supperList.size()>0){
			    	FunctionInfo wp = (FunctionInfo)supperList.get(0);
			    	List<FunctionInfo>  funlist1=loginBussiness.executionSql("from FunctionInfo f where f.superId="+wp.getFunctionId()+"  and f.versionFlag=2");
			    	WorkpositionEmployee wopemp=(WorkpositionEmployee) request.getSession().getAttribute("empposition");
					String str=wopemp.getWorkposition().getFunctionIDs();
					String[] arrfun=null;
					if(str!=null && str.length()>0){
						arrfun=str.split(",");
						for(int i=0;i<arrfun.length;i++){
							if(funlist1.size()==0){
						    	  childList.add("");
						    	  break;
							}
							  if(funlist1.size()>0){
								  for (FunctionInfo funobj : funlist1) {
									  if(funobj.getFunctionId().toString().equals(arrfun[i])){
										  logger.info(funobj.getFunctionId()+",name="+funobj.getLinkFunctionName());
										  childList.add(funobj);
									  }
								  }
							  }
						 }
					}else{
						logger.error("该用户无菜单权限!");
						return "nullqx";
					}
			    }
			    request.getSession().setAttribute("functionSupLists", supperList);
			    request.getSession().setAttribute("functionChidLists", childList);
			    request.setAttribute("functionselid", "00");
			    // 保存消息条数
			    String messhql="FROM Messagereceiver WHERE receiverer="+emp.getId()+" AND readfalg='0' AND delfalg='0' ";
			    List messlist=loginBussiness.executeHql(messhql);
			    request.getSession().setAttribute("messagecount", messlist.size());
			    /*添加登陆的动态信息到数据库*/
				this.addRecord();
				
				//获取日志访问记录集
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MONTH, -1);//时间倒退1月
				String datestr = TimePattern1.doDateTime3(c.getTime());
				String loghql = "From WorkLog where employeeByEmpId.id="+emp.getId()+" and  recordTime >='"+datestr+"'";
				List<WorkLog> workList = loginBussiness.executeHql(loghql);
				StringBuffer sb = new StringBuffer();
				List erList = new ArrayList();
				for (Iterator it = workList.iterator(); it
						.hasNext();) {
					WorkLog w = (WorkLog) it.next();
					sb.append(w.getId()+",");
				}
				if(sb.length() == 0){
					request.getSession().setAttribute("erList", erList);
				}else{
					String hqlRecord = "From Executerecord tb where tb.entityName='WorkLog' and tb.entityId in("+sb.substring(0,sb.length()-1)+") and tb.employee.id !="+emp.getId()+" order by tb.id desc";
					erList = loginBussiness.executeHql(hqlRecord);
					request.getSession().setAttribute("erList", erList);
				}
				
				return "potalSuccess";
			}else{
				request.setAttribute("errorMsg", "请正确输入本公司员工工号。");
				return "error";
			}
				
		}
		else{
			request.setAttribute("errorMsg", "登录失败！用户名或密码错误");
			return "error";
		}
	}
		
	}
	public String changeShowMenu(){
		request.removeAttribute("functionselid");
		request.getSession().removeAttribute("functionChidLists");
		List childList=new ArrayList();
		List<FunctionInfo> funlist=loginBussiness.executionSql("from FunctionInfo f where f.superId="+Integer.parseInt(funcid)+"  and f.versionFlag=2");
		WorkpositionEmployee wopemp=(WorkpositionEmployee) request.getSession().getAttribute("empposition");
		String str=wopemp.getWorkposition().getFunctionIDs();
		String[] arrfun=null;
		if(str.length()>0){
			arrfun=str.split(",");
		}
		for(int i=0;i<arrfun.length;i++){
			  if(funlist.size()>0){
				  for (FunctionInfo funobj : funlist) {
					  System.out.println("---"+funobj.getFunctionId());
					  if(funobj.getFunctionId().toString().equals(arrfun[i])){
						  logger.info(funobj.getFunctionId()+",name="+funobj.getLinkFunctionName());
						  childList.add(funobj);
					  }
				  }
			  }
		 }
		request.getSession().setAttribute("functionChidLists",childList);
		request.setAttribute("functionselid",funcid);
		return "potalSuccess";
	}
	
	public String closeSystem(){
		request.getSession().removeAttribute("userInfos");
		request.getSession().removeAttribute("code");
		request.getSession().removeAttribute("functionSupLists");
		request.getSession().removeAttribute("functionChidLists");
		return "error";
	}
	public String returnFore(){
		
		return "retSuccess";
	}
	/**
	 * 添加登陆的动态信息到数据库
	 * 
	 */
	public void addRecord(){
		//拿到登陆员工用户
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		String loginId = (String) request.getSession().getAttribute("useriiid");
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("登陆了系统。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(loginId);
			executerecord.setEntityName("Users");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
	}
	
	/**
	 * 即将到期的处理事项提醒
	 * 
	 */
	public void expirationReminder(){
		
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		if(null != emp){
			String sonIds = loginBussiness.executeSql("select getChildDeptLst("+emp.getDepartment().getId()+")");				
		
		//超时未处理故障
		List overtimeFault = loginBussiness.executionSql("select c.id from conkout c  inner join  questioncategory q  on c.issueType = q.id where  (select now( )>c.faultTime+(q.tmp1*60)) ");
		request.setAttribute("overtimeFault", overtimeFault);
		//评价不好故障
		List badReview = groupSystemBussiness.getObject("ConkOut"," and appraise=3");
		
		
		//即将到期订单
		List deuOrder = loginBussiness.executeHql("select tb.id from SaleOrder tb where tb.endTime < '"+this.getDate()+"' and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
			" and tb.employee.department.id in ("+sonIds+")))" );
		
		//即将到期合同
		List contractExpires = loginBussiness.executeHql("select tb.id from Contract tb where tb.endTime < '"+this.getDate()+"' and (tb.employeeByEmpId.id = "+emp.getId()+" or(tb.employeeByEmpId.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
			" and tb.employeeByEmpId.department.id in ("+sonIds+")))");
		
		//即将下架提醒
		List undercarriage = loginBussiness.executeHql("select tb.id from UpServer tb where tb.downtime< '"+this.getDate()+"' and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
			" and tb.employee.department.id in ("+sonIds+")))");
		
		List list = new ArrayList();
		
		if(null != overtimeFault && overtimeFault.size()>0){
			Reminders reminders = new Reminders();
			reminders.setName("超时未处理故障");
			reminders.setNumber(overtimeFault.size()+"");
			reminders.setIds(overtimeFault.toString());
			reminders.setEnitName("ConkOut");
			list.add(reminders);
		}
		
		if(null != badReview && badReview.size()>0){
			Reminders reminders1 = new Reminders();
			reminders1.setName("评价不好故障");
			reminders1.setNumber(badReview.size()+"");
			reminders1.setIds(badReview.toString());
			reminders1.setEnitName("ConkOut");
			list.add(reminders1);
		}
		 if(null != deuOrder && deuOrder.size()>0){
			Reminders reminders2 = new Reminders();
			reminders2.setName("即将到期订单");
			reminders2.setNumber(deuOrder.size()+"");
			reminders2.setIds(deuOrder.toString());
			reminders2.setEnitName("SaleOrder");
			list.add(reminders2);
		}
		if(null != contractExpires && contractExpires.size()>0){
			Reminders reminders3 = new Reminders();
			reminders3.setName("即将到期合同");
			reminders3.setNumber(contractExpires.size()+"");
			reminders3.setIds(contractExpires.toString());
			reminders3.setEnitName("Contract");
			list.add(reminders3);
		}
		 if(null != undercarriage && undercarriage.size()>0){
			Reminders reminders5 = new Reminders();
			reminders5.setName("即将下架的上架单");
			reminders5.setNumber(undercarriage.size()+"");
			reminders5.setIds(undercarriage.toString());
			reminders5.setEnitName("UpServer");
			list.add(reminders5);
		}
		request.getSession().setAttribute("expiresList", list);
		}else{
			
		}
	}
	@SuppressWarnings("unchecked")
	public void selbacklog(){
		Users user = functionInfoSystemBussiness.getObject(users.getLoginName(), users.getPassword());
		Employee emp=(Employee) loginBussiness.selEmpOrCus(user.getMark(), user.getCustomerOrEmployeeId());
		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("SELECT count(id) as tmp ,verifyOrder.id FROM AuditingOrderTab where handlestate = 1 and auditingFlag =0 and employees like '%"+emp.getId().toString()+"%' and verifyOrder.id !=''  group by verifyOrder.id");
//		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("FROM AuditingOrderTab ");
		if(tablist.size()>0)
		{
			List<VerifyOrder> orderlist = groupSystemBussiness.getObject("VerifyOrder", "");
			if(orderlist.size()>0)
			{
				ServletActionContext.getContext().getSession().put("orderlist", orderlist);
			}
			ServletActionContext.getContext().getSession().put("backlogList", tablist);
		}
	}
	public void workLog(){
		Users user = functionInfoSystemBussiness.getObject(users.getLoginName(), users.getPassword());
		Employee emp=(Employee) loginBussiness.selEmpOrCus(user.getMark(), user.getCustomerOrEmployeeId());
		System.out.println(emp.getId().toString());
		//需要批注的日志
		//select * from Table where ','+columA+',' like '%,111,%'。
		String hql = "From AuditingOrderTab where 1=1 and handlestate = 1 and auditingFlag =0 and (orderNo like 'GZRZ%' or orderNo like 'GZZJ%' or orderNo like 'GZYJ%')  and employees = '"+emp.getId().toString()+"' ";
		Pages page = messageBussiness.exHqlPages(hql, 0, 5, null);
//		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("FROM AuditingOrderTab ");
		ServletActionContext.getContext().getSession().put("replylist", page);
		//需要确认批注的日志
		hql = " From WorkLog where isView = 1 and employeeByEmpId.id="+emp.getId();//新的批注和是自己的日志
		page = messageBussiness.exHqlPages(hql, 0, 2, null);
		ServletActionContext.getContext().getSession().put("ensurelist", page);
	}
	/**
	 * 获取客户端真实IP地址
	 * @param request
	 * @return
	 */
	public String getIpAddr(HttpServletRequest request) {   
	       String ip = request.getHeader("x-forwarded-for");   
	       System.out.println("ip1 = "+ip);
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getHeader("Proxy-Client-IP");   
	           System.out.println("ip2 = "+ip);
	       }   
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getHeader("WL-Proxy-Client-IP");
	           System.out.println("ip3 = "+ip);
	       }   
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getRemoteAddr();
	           System.out.println("ip4 = "+ip);
	       }   
	       return ip;   
	   } 


	
	/**
	 * 实例化request
	 */
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}

	/**
	 * 实例化response
	 */
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}
public String  getDate() {
	SimpleDateFormat formatter;
	 formatter = new SimpleDateFormat ("yyyy-MM-dd");
    
	 Calendar calendar = java.util.Calendar.getInstance();
		calendar.add(Calendar.DATE, -3);
		Date date = calendar.getTime();
	return formatter.format(date);
	
}
public static void main(String[] args) {
	Calendar calendar = java.util.Calendar.getInstance();
	calendar.add(Calendar.DATE, -5);
	Date date = calendar.getTime();
	System.out.println(date.before(new Date()));
	SimpleDateFormat df = new SimpleDateFormat("yyyy MM dd hh:mm:ss");
	
	System.out.println(df.format(date));
}

	/*****
	 * 项目管理列表改变邀请状态   点击同意
	 */
    public String changeIsvite(){
    	boolean flag = true;
    	int prjempid=Integer.parseInt(request.getParameter("id"));
    //	int isvite=Integer.parseInt(request.getParameter("isvite"));
    	if(flag==true){
    	  try {
			PrintWriter out = response.getWriter();
			ProjectEmp prjemp=(ProjectEmp) prjdao.getPrjById(ProjectEmp.class, prjempid);
	     	prjemp.setIsinvite(2);
	    	prjdao.updateIsvite(prjemp);
	    	out.print("OK");
		} catch (IOException e) {
			e.printStackTrace();
		}
    	}
    	return null;
    }
    
    /**
     * 是否接受邀请  拒绝
     */
    public String jujue(){
    	boolean flag = true;
    	int prjempid=Integer.parseInt(request.getParameter("id"));
    	if(flag==true){
    	  try {
			PrintWriter out = response.getWriter();
			ProjectEmp prjemp=(ProjectEmp) prjdao.getPrjById(ProjectEmp.class, prjempid);
	    	prjemp.setIsinvite(0);
	    	prjdao.updateIsvite(prjemp);
	    	out.print("SUCCESS");
		} catch (IOException e) {
			e.printStackTrace();
		 }
    	}
    	return null;
    }


}
