package com.fuao.fajxc.action.schedulePlan;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.schedulePlan.SchedulePlanBusiness;
import com.fuao.fajxc.dao.newproject.QuestionProject;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.Scheduleplan;
import com.opensymphony.xwork2.ModelDriven;


@SuppressWarnings("unchecked")
public class SchedulePlaningAction implements ModelDriven,ServletRequestAware, ServletResponseAware{

	@SuppressWarnings("unused")
	private HttpServletResponse response;
	private HttpServletRequest request;
	private SchedulePlanBusiness spbiz;
	private QuestionProject questionProject;
	private Scheduleplan plan;
	private EmployeeBussiness empbiz;
	//private Employee emp ;
	private ExecuteRecordBussiness executeRecordBussiness;
	
	

	public QuestionProject getQuestionProject() {
		return questionProject;
	}

	public void setQuestionProject(QuestionProject questionProject) {
		this.questionProject = questionProject;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	/**
	 * 拿到登录员工对象
	 * @author 阙超强
	 * 2011-11-25 12:14:19
	 */
	public Employee getemp(){
//		/*获取登录员工信息*/
//		emp = new Employee();
//		Object obj = request.getSession().getAttribute("eId");
//		String strEmpId = "";
//		if(null != obj){
//			strEmpId = obj.toString();
//		}else{
//			return null;
//		}
//		emp = empbiz.oneEmp(Integer.parseInt(strEmpId));
		
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		return emp;
	}
	
	/**
	 * 修改日程或计划信息
	 * @author 阙超强
	 * 2011-11-25 11:47:48
	 */
	public String updateSchedule(){		
		System.out.println(plan.getFunction().getId());
		System.out.println(plan.getIsplan());
		if(plan.getFunction().getId()==0){
			plan.setFunction(null);
		}
		plan.setEmployee(getemp());
		//执行修改
		spbiz.updateSchedulePlan(plan);
		
		/*author 阙超强 14015 记录动态信息*/
		//拿到登陆员工用户
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		//添加记录到动态记录表
		if(loginEmp != null){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("修改了一个日程计划。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId("-1");
			executerecord.setEntityName("Scheduleplan");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		//判断是日程还是计划		
		return (plan.getPlantype() == 0)?"updateSchedule":"updatePlan";
		
	}
	
	/**
	 * 增加日程和计划
	 * @author 阙超强
	 * 2011-11-24 11:50:24
	 * 新增定时器
	 * 2011-12-1 11:18:35
	 * @throws ParseException 
	 */
	public String addScheduleInfo() throws ParseException{
		//添加登陆用户至日程信息
		String mark = request.getParameter("mark");
		if(plan.getFunction()!=null){
			if(plan.getFunction().getId()==0){
				plan.setFunction(null);
			}
		}else{
			plan.setFunction(null);
		}
		plan.setEmployee(getemp());
		System.out.println(plan.getPlantype());
		if(5 != plan.getPlantype())
		{
		        String importementlevel = request.getParameter("importantLevel");
		        plan.setImportantLevel(Integer.parseInt(importementlevel));
		}
		//增加日程或计划
		if(plan.getWorkcontent() != null && !plan.getWorkcontent().equals("")){
			plan.setWorkcontent(plan.getWorkcontent().replace("<IMG src=\"face/","<IMG src=\""+request.getContextPath()+"/SinaEditor/Edit/face/"));
			plan.setWorkcontent(StringUtil.textToHtml(plan.getWorkcontent()));
		}
		if(plan.getWorkremind() != null && !plan.getWorkremind().equals("")){
			plan.setWorkremind(plan.getWorkremind().replace("<IMG src=\"face/","<IMG src=\""+request.getContextPath()+"/SinaEditor/Edit/face/"));
		}
		if(plan.getTodayWorkPlan() != null && !plan.getTodayWorkPlan().equals("")){
			plan.setTodayWorkPlan(plan.getTodayWorkPlan().replace("<IMG src=\"face/","<IMG src=\""+request.getContextPath()+"/SinaEditor/Edit/face/"));
		}
		if(plan.getTomorrowWorkPlan() != null && !plan.getTomorrowWorkPlan().equals("")){
			plan.setTomorrowWorkPlan(plan.getTomorrowWorkPlan().replace("<IMG src=\"face/","<IMG src=\""+request.getContextPath()+"/SinaEditor/Edit/face/"));
		}
		Scheduleplan result = spbiz.addSchedule(plan);//
		/*********************日程定时*******************************/
//	    //定时任务
//	    Timer timer = new Timer();
//	    //定时任务的开始时间和每次任务间隔时间 每次间隔一天
//	    Date startTime = null;
//	    long marginTime = 1000*60*60*24;
//	   
//		// 首次运行时间           定为第二天00:00
//	    Calendar c = Calendar.getInstance();
//	  	c.add(Calendar.DAY_OF_MONTH,1);
//	  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd '00:00:00'");
//	    startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdf.format(c.getTime()));
//	  	
//	    //设置启动任务计划，启动和间隔时间
//	    timer.schedule(new TimerTask(){
//	        @Deprecated
//			public void run()
//	        {
//	        	//拿出需要自动更新添加的的对象
//	        	String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
//	        	List<Scheduleplan> spList = spbiz.ObjectList("Scheduleplan", " and durationTime > " + "'"+nowTime+"'");
//	        	
//	        	int spListSize = spList.size();
//	        	//当没有更新时   停掉定时器
//	        	if(spListSize == 0){
//	        		this.cancel();
//	        	}	        	
//	        	if(spListSize > 0){
//	        		
//	        		for(int i = 0; i < spListSize; i++){
//	        			
//	        			Scheduleplan sp = spList.get(i);
//	        			//先拿出到期时间放着
//	    	  	      	String dur = sp.getDurationTime();
//	    	  	      	
//	        			
//	        			Calendar c = Calendar.getInstance();
//	        			int week = c.get(Calendar.DAY_OF_WEEK)-1;
//	        			int date = c.get(Calendar.DAY_OF_MONTH);
//	        			int month = c.get(Calendar.MONTH)+1;
//	        			
//	        			//结束时间
//	        			String endTime = "";
//	        			//日程类型
//	        			int planType = sp.getPlantype();
//	        			if(planType == 0){
//			        			//重置结束时间  为开始时间后的23小时		        			
//			    	  	      	c.add(Calendar.HOUR_OF_DAY,23);
//			    	  	      	endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getTime());
//			    	  	      	
//			    	  	      	sp.setDurationTime(nowTime);			//把原来的日程剩余时间改为now
//			    	  	      	spbiz.updateSchedulePlan(sp);
//			    	  	      	
//			    	  	      	sp.setDurationTime(dur);				//把新增的日程剩余时间在改为原来的			    	  	      	
//			        			sp.setBegintime(nowTime);				//重置开始时间为任务执行的当前时间
//			        			sp.setEndtime(endTime);					//重置结束时间
//			        			spbiz.addSchedulePlan(sp);
//			        			System.out.println("qcq ------------------执行了日程更新更新" + planType);
//	        			}else if(planType == 1 && week == 1){
//		        				c.add(Calendar.DAY_OF_MONTH,7);
//			    	  	      	endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getTime());
//	        				
//	        					sp.setDurationTime(nowTime);
//	    	    	  	      	spbiz.updateSchedulePlan(sp);
//	    	    	  	      	
//	    	    	  	      	sp.setDurationTime(dur);			    	  	      	
//	    	        			sp.setBegintime(nowTime);
//	    	        			sp.setEndtime(endTime);
//	    	        			spbiz.addSchedulePlan(sp);
//	    	        			System.out.println("qcq ------------------执行了周更新更新" + planType);
//	        			}else if(planType == 2 && date == 1){
//		        				c.add(Calendar.MONTH,1);
//			    	  	      	endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getTime());
//	        					
//	        					sp.setDurationTime(nowTime);
//	    	    	  	      	spbiz.updateSchedulePlan(sp);
//	    	    	  	      	
//	    	    	  	      	sp.setDurationTime(dur);			    	  	      	
//	    	        			sp.setBegintime(nowTime);
//	    	        			sp.setEndtime(endTime);
//	    	        			spbiz.addSchedulePlan(sp);
//	    	        			System.out.println("qcq ------------------执行了月更新更新" + planType);
//	        			}else if(planType == 3 && date == 1 && (month == 3 || month == 6 || month == 9 || month == 12)){
//		        				c.add(Calendar.MONTH,3);
//			    	  	      	endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getTime());
//	        					
//	        					sp.setDurationTime(nowTime);
//	    	    	  	      	spbiz.updateSchedulePlan(sp);
//	    	    	  	      	
//	    	    	  	      	sp.setDurationTime(dur);			    	  	      	
//	    	        			sp.setBegintime(nowTime);
//	    	        			sp.setEndtime(endTime);
//	    	        			spbiz.addSchedulePlan(sp);
//	    	        			System.out.println("qcq ------------------执行了季度更新更新" + planType);
//	        			}else if(planType == 4 && month ==1 && date ==1){
//		        				c.add(Calendar.YEAR,1);
//			    	  	      	endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getTime());
//	        				
//	        					sp.setDurationTime(nowTime);
//	    	    	  	      	spbiz.updateSchedulePlan(sp);
//	    	    	  	      	
//	    	    	  	      	sp.setDurationTime(dur);		    	  	      	
//	    	        			sp.setBegintime(nowTime);
//	    	        			sp.setEndtime(endTime);
//	    	        			spbiz.addSchedulePlan(sp);
//	    	        			System.out.println("qcq ------------------执行了年更新更新" + planType);
//	        			}
//	        		}
//	        	}
//			}}, startTime, marginTime);
	    /********************************日程定时**************************************/
		//StringUtil.replaceHtml2ToText(input)
		int pTyle = plan.getPlantype();
		if(result != null){
			
			/*author 阙超强 14015 记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个日程计划。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId("-1");
				executerecord.setEntityName("Scheduleplan");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			if( mark != null && "worklog".equals(mark)){
				
				return "goaddworklogpage";
			}
			String returnFlag = "addPlanSuccess";
			//0-4 计划 5 日记事 6 提醒
			if(pTyle == 5){returnFlag = "addSuccess";}
		    else if(pTyle == 6){returnFlag = "addRemindSuccess";}
			//添加日程成功      添加计划成功 添加提醒成功
			return returnFlag;
		}
		return "error";
	}
		
	/**
	 * 显示日程或计划的详细信息
	 * @author 阙超强
	 * 2011-11-24 17:22:35
	 * 
	 * 新增跳转至其修改页面
	 * 2011-11-25 10:46:34
	 */
	public String show(){
		
		Employee e = (Employee)request.getSession().getAttribute("emp");
		// 得到所有项目
		System.out.println(e.getId());
		List prjlist= empbiz.projectByEid(e.getId());
		request.setAttribute("prjlist", prjlist);
		
		//获取日程id
		String sid = request.getParameter("schedulId").toString();
		int id = Integer.parseInt(sid);
		//获取日程计划对象
		Scheduleplan scheduleplan = (Scheduleplan) spbiz.getObjectById(id);
		request.setAttribute("data", scheduleplan);
		
		//判断跳转到详细信息还是修改页面
		String strStyle = request.getParameter("style").toString();
		int style = Integer.parseInt(strStyle);
		
		//得到taskid
		String idt = request.getParameter("taskid");
		Integer taskid=0;
		if(idt !=null && !idt.equals(""))
		{
			taskid = new Integer(idt);
		}
//			
//		taskid = new Integer(request.getParameter("taskid"));
		request.setAttribute("taskid", taskid);
		String hqltask = "from NewTask as nt where 1=1 and nt.id = "+taskid;
		String hqlfunction = "from NewFunction as nf where 1=1";
		List listTask = this.questionProject.findObj(hqltask);
		List listfunction = new ArrayList();
		String temp="";
		String temp1 = "";
		if(listTask !=null)
		{
			for(int i=0;i<listTask.size();i++)
			{
				NewTask newtask = (NewTask) listTask.get(i);
				if(newtask.getFunction() !=null)
				{
					temp1 += newtask.getFunction().getId()+",";
				}
			}
			String str1 = "";
			if(temp1 != null && !temp1.equals(""))
			{
				str1 = temp1.substring(0, temp1.length()-1);
			}
			else
			{
				str1= "0";
			}
			hqlfunction += " and nf.id in("+str1+")";
		}
		listfunction = this.questionProject.findObj(hqlfunction);
		
		for(int i = 0; i<listfunction.size();i++)
		{
			NewFunction function = (NewFunction) listfunction.get(i);
			temp += function.getNewProject().getId() +",";
		}
		String str = "";
		if(temp != null && !temp.equals(""))
		{
			str = temp.substring(0, temp.length()-1);
		}
		else
		{
			str = "0";
		}
		request.setAttribute("listfunction", listfunction);
		String listpro = "from NewProject as np where 1=1 and np.id in("+str+")";
		List proList = this.questionProject.findObj(listpro);
		NewProject newpro = null;
		if(proList != null && proList.size()>0)
		{
			newpro = (NewProject)proList.get(0);
		}
		request.setAttribute("newpro", newpro);
		//判断是日程 计划 提醒
		int planType = scheduleplan.getPlantype();
		
		if(planType == 5){
		        return (style == 0)?"show":"goUpdate";
		}else if(planType == 6){
			 return (style == 0)?"showRemind":"goUpdateRemind";
		}
		return (style == 0)?"showPlan":"goUpdatePlan";
		
	}
	
		
	/**
	 * 跳转至日程或计划列表显示页面
	 * @author 阙超强
	 * 2011-11-25 14:55:25
	 * @throws IOException 
	 */
	public String goList() throws IOException{
		//得到分页页码
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String strEmpid = request.getSession().getAttribute("eId").toString();
		if(null == strEmpid || "".equals(strEmpid)){
			return "login";
		}
		int empid = Integer.parseInt(strEmpid);
		
		//获取当前时间用来判断工作任务是否过时
		//String strDate = new Date().toLocaleString();		
		//以下正解  上面的toLocaleString()已被划上删除线--。
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String strDate = dateFormat.format(now);
		request.setAttribute("nowDate", strDate);
		
		//获得计划的分类查看标示
		String strPlanTag = request.getParameter("planTag")==null?"0":request.getParameter("planTag");
		int planTag = Integer.parseInt(strPlanTag);
		
		//判断显示日程还是计划
		String strPlanStyle = request.getParameter("planStyle");
		int planStyle = Integer.parseInt(strPlanStyle);
		
		Pages pages = null;
		String hql = "from Scheduleplan where 1 = 1 ";
		
		//判断是不是从日历控件上选择的
		String strSelectDate = request.getParameter("selectDate")==null?"0":request.getParameter("selectDate");
		hql += " and begintime like '%" + strSelectDate + "%' ";
		
		//查询日程列表时执行
		if(planStyle == 0){//0为日程记事 1为计划 2为提醒
			hql += " and plantype = 5 and employee.id = "+ empid +" order by id desc";
			
			pages = spbiz.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("pages", pages);
			
			return "goScheduleList";
		}else if(planStyle == 2){//查询日程提醒时执行
			String hql2 = " from Scheduleplan where 1 = 1 and plantype = 6 and remindtime like '%" + strSelectDate + "%'  and employee.id = "+ empid +" order by id desc";
			
			pages = spbiz.exHqlPages(hql2, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("pages", pages);
			
			return "goRemindList";
		}
		//以下为查询计划列表时执行
		if(planTag > 4  || planTag < 0){
			hql += " and plantype = 0 and employee.id = "+ empid +" order by id desc";
		}else{
			hql += " and plantype = " + planTag + " and employee.id = "+ empid +" order by id desc";
		}
		pages = spbiz.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
		request.setAttribute("pages", pages);
		return "goPlanList";
	}
	
	/**
	 * 通过日历的查找
	 * @throws IOException 
	 */
	public void selectByDate() throws IOException{
		//获得当前登录用户
		String strEmpid = request.getSession().getAttribute("eId").toString();
		
		//获得选择的日期
		String strSelectDate = request.getParameter("selectDate");
		String hql = "from Scheduleplan where 1 = 1 and begintime like '%" + strSelectDate + "%' ";
		
		//判断显示日程还是计划
		String strPlanStyle = request.getParameter("planStyle");
		System.out.println(strPlanStyle);
		//判断日程列表/计划列表
		if("0".equals(strPlanStyle)){
			hql += " and plantype = 0 ";
		}else{
			hql += " and plantype != 0 ";
		}
		//完成hql语句组装
		hql += " and employee.id = "+ Integer.parseInt(strEmpid) +" order by id desc";
		
		//查出所有符合条件的对象
		List<Scheduleplan> spList = executeRecordBussiness.exHqls(hql);
		String str = "";
		//判断是否存在相关日程
		if(spList.size() == 0){
			str += "<tr><td>未查找到相关日程</td><td><a href='goAddworknotepad.do'>新建日程</a></td></tr>";
		}else{
			//遍历查找到的对象信息，分解后返回给页面
			Scheduleplan scheduleplan = null;
			for(int i =0; i < spList.size();i++){
				scheduleplan = spList.get(i);
				String finishtime = (scheduleplan.getFinishtime()==null)?"未填写。。。":scheduleplan.getFinishtime();
				String state = (scheduleplan.getState()==0)?"未完成":"已完成";
				String importantLevel = "";
				if(scheduleplan.getImportantLevel() == 0){
					importantLevel = "不重要";
				}else if(scheduleplan.getImportantLevel() == 1){
					importantLevel = "一般";
				}
				else if(scheduleplan.getImportantLevel() == 2){
					importantLevel = "<FONT color=#ff0000>重要</FONT>";
				}
				
				Date date = TimePattern.doStringTime(scheduleplan.getEndtime());
				String update = date.before(new Date())?"任务过时":"<a href='showworknotepad.do?style=1&schedulId="+scheduleplan.getId().toString()+"' title='点击修改'><img border='0' src='<%=path %>/img/page.gif'/></a>";
				//为日程时，组装的代码
				if("0".equals(strPlanStyle)){
					String todayWorkContent = (scheduleplan.getTomorrowWorkPlan().length() < 40)?scheduleplan.getTomorrowWorkPlan():scheduleplan.getTodayWorkPlan().substring(0, 40)+"...";
					str += "<TR ALIGN=center VALIGN=middle  ID=TableTitle><TD WIDTH=15% HEIGHT=25>开始时间</TD><TD WIDTH=15%>计划结束时间</TD><TD WIDTH=15%>完成时间</TD><TD WIDTH=23%>工作内容</TD><TD WIDTH=8%>重要度</TD><TD WIDTH=8%>状态</TD><TD WIDTH=8%>修改</TD></TR>";
					str += "<TR class='TableDetail1'><TD WIDTH=15% HEIGHT=23>"+scheduleplan.getBegintime()+"</TD><TD WIDTH=15%>"+scheduleplan.getEndtime()+"</TD><TD WIDTH=15%>"+finishtime+"</TD><TD WIDTH=23%><a href='showworknotepad.do?style=0&schedulId="+scheduleplan.getId().toString()+"'>"+todayWorkContent+"</a></TD><TD WIDTH=8%>"+importantLevel+"</TD><TD WIDTH=8%>"+state+"</TD><td WIDTH=8%>"+update+"</td></TR>";
				}
				//为计划时，组装的代码（多一项显示计划类型，内容不为同一字段）
				else{
					String planType = "";
					if(scheduleplan.getPlantype()==1){planType="周计划";}
					else if(scheduleplan.getPlantype()==2){planType="月计划";}
					else if(scheduleplan.getPlantype()==3){planType="季计划";}
					else if(scheduleplan.getPlantype()==4){planType="年计划";}
					String WorkContent = (scheduleplan.getTomorrowWorkPlan().length() < 40)?scheduleplan.getTomorrowWorkPlan():scheduleplan.getTomorrowWorkPlan().substring(0, 40)+"...";
					
					str += "<TR ALIGN=center VALIGN=middle  ID=TableTitle><TD WIDTH=5% HEIGHT=25>计划类型</TD><TD WIDTH=15% HEIGHT=25>开始时间</TD><TD WIDTH=15%>计划结束时间</TD><TD WIDTH=15%>完成时间</TD><TD WIDTH=18%>工作内容</TD><TD WIDTH=8%>重要度</TD><TD WIDTH=8%>状态</TD><TD WIDTH=8%>修改</TD></TR>";
					str += "<TR class='TableDetail1'><TD WIDTH=15% HEIGHT=23>"+planType+"</TD><TD WIDTH=15% HEIGHT=23>"+scheduleplan.getBegintime()+"</TD><TD WIDTH=15%>"+scheduleplan.getEndtime()+"</TD><TD WIDTH=15%>"+finishtime+"</TD><TD WIDTH=18%><a href='showworknotepad.do?style=0&schedulId="+scheduleplan.getId().toString()+"'>"+WorkContent+"</a></TD><TD WIDTH=8%>"+importantLevel+"</TD><TD WIDTH=8%>"+state+"</TD><td WIDTH=8%>"+update+"</td></TR>";
				}
			}
		}
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(str);
	}
	

	/**
	 * 跳转至添加页面
	 * @author 阙超强
	 * 2011-11-24 11:50:37
	 */
	public String goAdd(){	
		Employee e = (Employee)request.getSession().getAttribute("emp");
		Employee e2 = (Employee)ServletActionContext.getContext().get("emp");
		String data= request.getParameter("data");
		request.setAttribute("data", data);
		// 得到所有项目
		System.out.println(e.getId());
		List prjlist= empbiz.projectByEid(e.getId());
		System.out.println(prjlist.size());
		request.setAttribute("prjlist", prjlist);
		return "goAdd";
	}
	
	/*模型驱动*/
	public Object getModel() {
		plan = new Scheduleplan();
		return plan;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public SchedulePlanBusiness getSpbiz() {
		return spbiz;
	}
	public void setSpbiz(SchedulePlanBusiness spbiz) {
		this.spbiz = spbiz;
	}
	public EmployeeBussiness getEmpbiz() {
		return empbiz;
	}
	public void setEmpbiz(EmployeeBussiness empbiz) {
		this.empbiz = empbiz;
	}
	public Scheduleplan getPlan() {
		return plan;
	}
	public void setPlan(Scheduleplan plan) {
		this.plan = plan;
	}
}
