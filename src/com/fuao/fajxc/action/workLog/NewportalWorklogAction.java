package com.fuao.fajxc.action.workLog;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.bussiness.workLog.WorkLogBussiness;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.PageBuilder;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Leavesimple;
import com.fuao.fajxc.vo.LogTabInfo;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Messagetype;
import com.fuao.fajxc.vo.MissionEmp;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.WorkLog;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 新系统3.0版本的日志管理Action
 * 
 * @author 胡宝林 14024
 * @time 2013-1-18 11:35:12
 */

@SuppressWarnings("unchecked")
public class NewportalWorklogAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	protected int current;
	protected int page;
	protected int row;
	private CommonBiz commbiz;
	private List rows = new ArrayList();
	private String str = "";
	private List workLogs  = null;
	private int pageCount = 14;
	private int total;

	


	public CommonBiz getCommbiz() {
		return commbiz;
	}

	public void setCommbiz(CommonBiz commbiz) {
		this.commbiz = commbiz;
	}

	public int getCurrent() {
		return (this.page - 1) * this.row;
	}

	public void setCurrent(int current) {
		this.current = current;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	/**************** 以上是CMS 分页用 *****************/

	private int datecount; // 月日志实写总数。
	private int weekcount; // 月周志实写总数。
	private WorkLog workLog;
	private String oper;
	private String msg;
	private Scheduleplan sch;// 日程记事对象
	private String depts;// 保存部门
	
	public String getDepts() {
		return depts;
	}

	public void setDepts(String depts) {
		this.depts = depts;
	}

	public Scheduleplan getSch() {
		return sch;
	}

	public void setSch(Scheduleplan sch) {
		this.sch = sch;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getOper() {
		return oper;
	}

	public void setOper(String oper) {
		this.oper = oper;
	}

	private AuditingBussiness audBussiness;

	public WorkLog getWorkLog() {
		return workLog;
	}

	public void setWorkLog(WorkLog workLog) {
		this.workLog = workLog;
	}

	public int getDatecount() {
		return datecount;
	}

	public void setDatecount(int datecount) {
		this.datecount = datecount;
	}

	public int getWeekcount() {
		return weekcount;
	}

	public void setWeekcount(int weekcount) {
		this.weekcount = weekcount;
	}

	private HttpServletRequest request;
	private HttpServletResponse response;

	private WorkLogBussiness workLogBussiness; // 日志business层
	private ExecuteRecordBussiness executeRecordBussiness; // 记录动态

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

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
	"yyyy-MM-dd HH:mm:ss");
	// 得到当前时间
	Date now = new Date();
	String nowstr = dateFormat2.format(now);

	/* 模型驱动 */
	public Object getModel() {
		workLog = new WorkLog();
		return workLog;
	}

	//下载查看附件
	 public String download()throws Exception{
	    	String Url=request.getParameter("url");
	    	boolean isOnLine = true;
	    	String chinaName="uploads/"+Url;
	    	ActionContext ac=ActionContext.getContext();
	    	ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
			String savePath = sc.getRealPath("/");	
			String url=savePath+chinaName;
			System.out.println(url);
	    File f = new File(url); 

	    if(!f.exists()){

	    response.sendError(404,"File not found!"); 

	    return null; 

	    }

	    BufferedInputStream br = new BufferedInputStream(new FileInputStream(f)); 

	    byte[] buf = new byte[1024]; 

	    int len = 0; 

	    response.reset(); //非常重要

	    if(isOnLine){ //在线打开方式

	    URL u = new URL("file:///"+url); 

	    response.setContentType(u.openConnection().getContentType()); 

	    response.setHeader("Content-Disposition", "inline; filename="+Url); 

	    //文件名应该编码成UTF-8

	    }

	    else{ //纯下载方式

	    response.setContentType("application/x-msdownload"); 

	    response.setHeader("Content-Disposition", "attachment; filename=" +Url); 

	    }

	    OutputStream out = response.getOutputStream(); 

	    while((len = br.read(buf))>0)

	    out.write(buf,0,len); 

	    br.close(); 

	    out.close(); 
	    return null;
	    } 
	
	
	
	 /**
	 * 检查日志是否批阅过，给出提示信息
	 */
	public void check()
	{
		try 
		{
			int j = 0;

			int count = 0;

			int x = 0;

			String realIds = "";

			response.setCharacterEncoding("utf-8");
			StringBuffer sb = new StringBuffer();
			String idsStr = request.getParameter("ids");
			String[] ids = idsStr.split(",");
			List list = workLogBussiness.getByIds(ids);
			Employee loginEmp = this.getEmp();
			
			for (int i = 0; i < list.size(); i++)
			{

				WorkLog workLog = (WorkLog) list.get(i);
				
				int loginID = loginEmp.getId();
				
				if(workLog.getEmployeeByReplier()!=null && workLog.getIsView() != 0)
				{
					int replierID = workLog.getEmployeeByReplier().getId();
					
					if (replierID==loginID) 
					{
						if (j == 0)
						{
							sb.append("序号:");
						}
	
						sb.append(workLog.getId()).append(" ");
	
						j++;
	
						count++;
					} 
					else
					{
	
						x++;
					}
				}

				if (list.size() - 1 == i)
				{
					if (x == 0) 
					{
						sb.append("已经批阅过！是否继续批阅日志？");
					} 
					else if (j != 0) 
					{
						sb.append("已经批阅过！是否继续批阅日志？");
					}
				}
			}

			if (count == 0 || list.size() == 0) 
			{
				sb.setLength(0);
				sb.append("1");
			}
			
			response.getWriter().write(sb.toString());
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}

	/**
	 * 进入批阅日志的页面
	 */
	public String batchreply(){
		int count=1;
		int flag=1; // 标识有没有批阅
		String countstr=request.getParameter("count");
		String flagstr=request.getParameter("flag");
		if(countstr!=null){
			count=Integer.parseInt(countstr);
		}
		if(flagstr!=null){
			flag=Integer.parseInt(flagstr);
		}
		String idsStr = request.getParameter("ids");
		String[] ids = idsStr.split(",");
		List list = workLogBussiness.getByIds(ids);
		// 默认先取到每一个日志并显示出来
		WorkLog workLog = (WorkLog) list.get(count-1);
		Date date=new Date();
		try {
			date = dateFormat2.parse(workLog.getRecordTime());
		} catch (ParseException e) {
		}
		String date2= dateFormat2.format(date);
        // 查看今天的日志便签
	    String schehql = "From Scheduleplan tb where tb.endtime like '%"
			+ date2 + "%' and tb.plantype = 5 and tb.employee.id = "
			+ workLog.getEmployeeByEmpId().getId();
	    List schelist= workLogBussiness.exeHql(schehql);
	    // 获取批阅列表
		String hql = "From AuditingOrderTab where 1=1 and handlestate = 2 and auditingFlag =1 and orderNo = '"
				+ workLog.getLogNo() + "'";
		// audBussiness.
		List replylist = workLogBussiness.exeHql(hql);
		request.setAttribute("replyList", replylist);
	    request.setAttribute("schelist", schelist);
		request.setAttribute("worklog", workLog);
		request.setAttribute("list", list);
		request.setAttribute("num", count);// 标识选中的是第几个
		request.setAttribute("ids", idsStr);
		request.setAttribute("flag", flag);
		request.setAttribute("len", list.size());// 主要判断有没有下一个
		if(workLog.getType()!=0){
			// 是周，月志的情况下
			String[] weLogInfo=workLog.getContent().split("\\|");
			if(weLogInfo.length>0){
				request.setAttribute("weLogInfo", weLogInfo);
			}
		}
		return "batchreply";
	}
	
	
	/**
	 * 判断是否是日志
	 */
	public void judge() {
		try {
			int j = 0;

			int count = 0;

			int x = 0;
			StringBuffer sb = new StringBuffer();
			String idsStr = request.getParameter("ids");
			String[] ids = idsStr.split(",");
			List list = workLogBussiness.getByIds(ids);
			for (int i = 0; i < list.size(); i++) {

				WorkLog workLog = (WorkLog) list.get(i);
				if (workLog.getType() != 0) {
					if (j == 0) {
						sb.append("序号:");
					}

					sb.append(workLog.getId()).append(" ");

					j++;

					count++;
				} else {

					x++;
				}

				if (list.size() - 1 == i) {
					if (x == 0) {
						sb.append("周志或者月志不能进行对比！");
					} else if (j != 0) {
						sb.append("周志或者月志不能进行对比！是否继续对比其它序号日志？");
					}
				}
			}

			if (count == 0 || list.size() == 0) {
				sb.setLength(0);
				sb.append("1");
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 得到全部要对比的日志信息
	 */
	public String getWorkInfo()
	{	
		try
		{
			
			/* 得到所有要对比的日志信息，然后从其中除掉周志和月志，赋值给一个日志字符串 */
			str="";
			String idsStr = request.getParameter("ids");
			String[] ids = idsStr.split(",");
			List workLogs = workLogBussiness.getByIds(ids);

			for (int i = workLogs.size() - 1; i < workLogs.size() && i >= 0; i--) {
				WorkLog workLog = (WorkLog) workLogs.get(i);
				if (workLog.getType() > 0) {
					workLogs.remove(i);
				}
			}
			
			for(int i = 0 ;i < workLogs.size();i++ )
			{
				WorkLog workLog = (WorkLog) workLogs.get(i);
				
				if(i==workLogs.size()-1)
				{
					str+=workLog.getId();
				}
				else
				{
					str+=workLog.getId()+",";
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return contrast();
	}
	
	/**
	 * 得到对比日志的信息
	 */
	public String contrast()
	{
		try 
		{
			/* 进行分页查询 */
			String hql = "from WorkLog w  where w.id in ("+str+")";
			String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			Pages page = this.workLogBussiness.exeHqlPages(hql, new Integer(pageNo), 3, 0);
			request.setAttribute("pages",page);
			this.workLogs = page.getPageList();
			
			LogTabInfo lti = null;

			for (int i = 0; i < workLogs.size(); i++) {
				WorkLog workLog = (WorkLog) workLogs.get(i);
				String[] str = workLog.getRecordTime().split(" ");
				workLog.setRecordTime(str[0]);

				//String content = "";
				// 进行日志内容偏签的攫取
				//logSigns = new ArrayList();
				//StringBuffer sb = new StringBuffer("");
				/*
				if (workLog.getWorkresult() != null) {
					String workResult = workLog.getWorkresult().replaceAll(
							"<.*?>", "");
					workLog.setWorkresult(workResult);
				}*/
				String p = workLog.getContent();
				String[] shuzu = p.split("<TBODY>");
				System.out.println(shuzu.length);

				for (int j = 1; j < shuzu.length; j++) {
					
					lti = new LogTabInfo();
					
					String st = shuzu[j];

					String s = "开始时间</TD><TD width=120>";
					String s2 = "结束时间</TD><TD width=60>";
					String s3 = "概述:<TR><TD colSpan=3></TD></TR><TR>";
					String s4 = "参与人员</TD><TD width=60>";
					int beginIndex = st.indexOf("开");

					if (beginIndex > 0) {
						//sb.append("日志偏签").append(j).append(":");
						beginIndex = st.indexOf("参") + s4.length() + 2;
						int endIndex = st.indexOf("<", beginIndex);
						String time = st.substring(beginIndex, endIndex);
						lti.setPI(time);
						//System.out.println("参与人员:" + time);
						//sb.append("参与人员:").append(time);

						beginIndex = st.indexOf("开");
						beginIndex = beginIndex + s.length() + 2;
						endIndex = st.indexOf("<", beginIndex);
						time = st.substring(beginIndex, endIndex);
						lti.setBeginTiem(time);
						//System.out.println("beinIndex" + time);
						//sb.append("开始时间:").append(time);

						beginIndex = st.indexOf("结") + s2.length() + 2;
						endIndex = st.indexOf("<", beginIndex);
						time = st.substring(beginIndex, endIndex);
						lti.setEndTime(time);
						//System.out.println("endIndex" + time);
						//sb.append("结束时间:").append(time);

						beginIndex = st.indexOf("概述", endIndex) + s3.length()
								+ 4;
						endIndex = st.indexOf("<", beginIndex);
						time = st.substring(beginIndex, endIndex);
						lti.setContent(time);
						System.out.println("logSign"+(i+1)+""+(j));
						request.setAttribute("logSign"+(i+1)+""+(j), lti);
						//System.out.println("工作概述:" + time);
						//sb.append("工作概述:").append(time);
						//content += sb.toString();
						//logSigns.add(sb.toString());
						//sb.setLength(0);
					}
				}

				
				request.setAttribute("workLog" + (i + 1), workLog);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "contrast";
	}

	/**
	 *获得当前登录员工
	 */
	public Employee getEmp() {
		// 拿到当前登录员工
		Object object = request.getSession().getAttribute("emp");
		Employee loginEmp = null;
		if (null != object) {
			loginEmp = (Employee) object;
		} else {
			// 为空时 返回重新登录
			request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
		}
		return loginEmp;
	}

	public List getWorkLogIds(String str) {
		String[] ids = str.split(",");
		List workLogIds = new ArrayList();
		List list = workLogBussiness.getByIds(ids);

		for (int i = 0; i < list.size(); i++) {
			WorkLog workLog = (WorkLog) list.get(i);

			if (workLog.getIsView() == 0) {
				workLogIds.add(workLog.getId());
			}
		}
		return workLogIds;
	}

	/**
	 * 添加评论 (批量批阅)
	 */
	public String URTo()
	{
		
		try 
		{
			Employee loginEmp = this.getEmp();
			if (null == loginEmp) {
				response.getWriter().print(1);
				return"";
			}
			
			//
			String audid  ="";
			String audhql = "From AuditingOrderTab where 1=1 and handlestate = 1 and auditingFlag =0 and (orderNo like 'GZRZ%' or orderNo like 'GZZJ%' or orderNo like 'GZYJ%')  and employees = '"
				+ loginEmp.getId().toString() + "' ";
			List list = workLogBussiness.exeHql(audhql);
			
			//批注内容
			String replycontent = request.getParameter("replycontent");
			
			//String str = TimePattern.doTimeDf3(new Date());
			//得到ids
			String idsStr = request.getParameter("ids");
			String[] ids = idsStr.split(",");
			//List ids = getWorkLogIds(idsStr);
			// 获得需要添加批注的日志
			//String strId = request.getAttribute("id").toString();
			
			// 获得批注内容
			String reply = URLDecoder.decode(URLDecoder.decode(replycontent,
			"UTF-8"), "UTF-8");
			
			for(int j = 0; j < ids.length;j++)
			{
				int id = Integer.parseInt(ids[j]);
				
				WorkLog wLog = workLogBussiness.getById(id);

				if(workLog.getLogNo() != null)
				{
					for(int i = 0; i < list.size();i++)
					{
						AuditingOrderTab a = (AuditingOrderTab) list.get(i);
						
						if(a.getOrderNo().trim().equals(workLog.getLogNo().trim()))
						{
							 audid  = a.getId().toString().trim();
						}
					}
				}
				
				if (audid == null || audid.equals("")) 
				{
					
					// 判断取的最大auditingOrder
					String hql2 = " From AuditingOrderTab where 1=1  and orderNo = '"
							+ wLog.getLogNo() + "' order by auditingOrder desc";
					List list2 = workLogBussiness.exeHql(hql2);
					int maxOrder = 0;
					if (list2 != null && list2.size() > 0) {
						maxOrder = ((AuditingOrderTab) list2.get(0))
								.getAuditingOrder();
					}
					
					// 插入审批记录
					AuditingOrderTab aot = new AuditingOrderTab();
	
					aot.setAuditingFlag(1);
					aot.setAuditingOrder(maxOrder + 1);
					aot.setDepartment(loginEmp.getDepartment());
					aot.setOrderNo(wLog.getLogNo());
					
					aot.setMark("0");// 默认0一人审核
					
					aot.setEmployees(loginEmp.getId().toString());
					aot.setHandlestate(2);
					TimePattern tp = new TimePattern();
					Date date = new Date();
					String nowtime = tp.doTimeDf3(date);
					aot.setIncepttime(Timestamp.valueOf(nowtime));
					aot.setEmployeeByInceptemp(loginEmp);
					aot.setTmp(StringUtil.textToHtml2(reply.replace(
							"<IMG src=\"face/", "<IMG src=\""
									+ request.getContextPath()
									+ "/SinaEditor/Edit/face/")));
					aot.setAuditingtime(Timestamp.valueOf(TimePattern
							.doTimeDf3(date)));
					audBussiness.addAuditingOrder(aot);
	
					// 更改日志状态为新批注
					wLog.setIsView(1);
					
				 /* String str  = wLog.getReplyContent().replace(
							"<IMG src=\"face/",
							"<IMG src=\"" + request.getContextPath()
									+ "/SinaEditor/Edit/face/");*/
					
					if(wLog.getReplyContent()!=null)
					{
						wLog.setReplyContent(StringUtil.textToHtml2(wLog
								.getReplyContent().replace(
										"<IMG src=\"face/",
										"<IMG src=\"" + request.getContextPath()
												+ "/SinaEditor/Edit/face/")));
					}
					else
					{
						wLog.setReplyContent(reply);
						wLog.setReplyTime(nowtime);
						wLog.setEmployeeByReplier(loginEmp);
					}
					workLogBussiness.addReply(wLog);
					response.getWriter().print(0);
	
				} 
				else
				{
					// 修改审批记录
					// 为对象设置值
					wLog.setReplyContent(reply);
					wLog.setEmployeeByReplier(loginEmp);
					wLog.setReplyTime(TimePattern.doTimeDf3(new Date()));
					wLog.setIsView(1);
	
					// 添加批注 （修改对象）
					boolean result = workLogBussiness.addReply(wLog);
					
					// 插入审批
					String hql = " update AuditingOrderTab set tmp ='" + reply
							+ "',handlestate = 2 , auditingFlag =1,auditingtime='"
							+ TimePattern.doTimeDf3(new Date()) + "' where id= "
							+ audid;
					audBussiness.updatehql(hql);
	
					if (result == false) {
						request.setAttribute("errorMsg", "添加批注失败,请重试！");
						response.getWriter().print(1);
					} else {
						response.getWriter().print(0);
					}
				}
		   }	
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}

		return "otherList";
	};
	
	/**
	 * 得到当前日志的员工信息
	 */

	public void getTitle()
	{
		try 
		{
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			String id = request.getParameter("workID");
			 StringBuffer sb  = null;
			System.out.println(id + "--------------");
			int ID = Integer.parseInt(id);
			WorkLog worklog = workLogBussiness.getById(ID);
			
			//转换时间格式为 年 月 日
			
			if(worklog.getType()==0)
			{
				if (worklog.getWorkresult() == null
						|| "".equals(worklog.getWorkresult())) {
					//  sb = new StringBuffer( "<lable style=\"font-size:16px;\">个人总结</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb  = new StringBuffer();
					  sb.append("<lable style=\"font-size:16px;\">员工姓名:</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:16px;\">所属部门:</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:16px;\">时间:</lable>");
					  response.getWriter().write(sb.toString());
				} else {
					//  sb = new StringBuffer( "<lable style=\"font-size:16px;\">个人总结</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					 sb  = new StringBuffer();  
					 sb.append("<lable style=\"font-size:16px;\">&nbsp;&nbsp;").append(worklog.getRecordTime()).append("</lable>&nbsp;&nbsp;");
					 sb.append("<lable style=\"font-size:16px;\">员工姓名:").append(worklog.getEmployeeByEmpId().getName()).append("</lable>&nbsp;&nbsp;&nbsp;");
					 sb.append("<lable style=\"font-size:16px;\">所属部门:").append(worklog.getEmployeeByEmpId().getDepartment().getName()).append("</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					 
					response.getWriter().write(sb.toString());
				}
			}
			/*
			else if(worklog.getType()==1)
			{
				if (worklog.getContent() == null
						|| "".equals(worklog.getContent())) {
					  sb = new StringBuffer( "<lable style=\"font-size:16px;\">一周总结</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:13px;\">员工姓名:</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:13px;\">所属部门:</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:13px;\">时间:</lable>");
					response.getWriter().write(sb.toString());
				} else {
					 // sb = new StringBuffer( "<lable style=\"font-size:13px;\">一周总结</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb  = new StringBuffer();
					  sb.append("<lable style=\"font-size:11px;\">").append(worklog.getRecordTime()).append("</lable>&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">员工姓名:").append(worklog.getEmployeeByEmpId().getName()).append("</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">所属部门:").append(worklog.getEmployeeByEmpId().getDepartment().getName()).append("</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">").append(worklog.getRecordTime()).append("</lable>");
					response.getWriter().write(sb.toString());
				}
			}
			else
			{
				if (worklog.getContent() == null
						|| "".equals(worklog.getContent())) {
					  sb = new StringBuffer( "<lable style=\"font-size:11px;\">&nbsp;月总结</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">员工姓名:</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">所属部门:</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">时间:</lable>");
					response.getWriter().write(sb.toString());
				} else {
					  sb  = new StringBuffer();
					  sb.append("<lable style=\"font-size:11px;\">").append(worklog.getRecordTime()).append("</lable>&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">员工姓名:").append(worklog.getEmployeeByEmpId().getName()).append("</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					  sb.append("<lable style=\"font-size:11px;\">所属部门:").append(worklog.getEmployeeByEmpId().getDepartment().getName()).append("</lable>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					response.getWriter().write(sb.toString());
				}
			}
			*/
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 得到主题
	 */
	
	/* 类型是 */
	public void getTitle1()
	{
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			String id = request.getParameter("workID");
			System.out.println(id + "--------------");
			int ID = Integer.parseInt(id);
			WorkLog worklog = workLogBussiness.getById(ID);
			
			//转换时间格式为 年 月 日
			
			if(worklog.getType()==0)
			{
					response.getWriter().write("个人总结");
			}
			else if(worklog.getType()==1)
			{
				
					response.getWriter().write("周总结");
				}
			else
			{
				response.getWriter().write("月总结");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*得到日志内容*/
	
	/**
	 * 得到内容
	 */
	
	public void getContent()
	{
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			String id = request.getParameter("workID");
			System.out.println(id + "--------------");
			int ID = Integer.parseInt(id);
			WorkLog worklog = workLogBussiness.getById(ID);
			if(worklog.getType()==0)
			{
				if (worklog.getWorkresult() == null
						|| "".equals(worklog.getWorkresult())) {
					response.getWriter().write("<center>个人总结没写！</center>");
				} else {
					response.getWriter().write(worklog.getWorkresult());
				}
			}
			else if(worklog.getType()==1)
			{
				if (worklog.getContent() == null
						|| "".equals(worklog.getContent())) {
					response.getWriter().write("<center>周志没写！</center>");
				} else 
				{
					String[] content = worklog.getContent().split("</style>");
					response.getWriter().write(content[1]);
				}
			}
			else
			{
				if (worklog.getContent() == null
						|| "".equals(worklog.getContent())) {
					response.getWriter().write("<center>月志没写！</center>");
				} else {
					String[] content = worklog.getContent().split("</style>");
					response.getWriter().write(content[1]);
				}
			}
				
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 添加日志
	 * 
	 * @return String result
	 */
	
	public String addTo() {
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "errorPage";
		}
		workLog.setEmployeeByEmpId(loginEmp);
		
		String txt=(String)request.getSession().getAttribute("uploadtxt");
		workLog.setAccessory(txt);
		//取到后删除session
		request.getSession().removeAttribute("uploadtxt");
		
		workLog.setRecordTime(TimePattern.doTimeDf3(new Date()));
		workLog.setIsView(0);
		// 生成日志编号
		String logNo = "";
		if (workLog.getType() == 0) {// 日
			logNo = "GZRZ" + loginEmp.getEmpNo()
					+ TimePattern.doTimeDf2(new Date())
					+ (new Random().nextInt(10000));
		} else if (workLog.getType() == 1) {// 周
			logNo = "GZZJ" + loginEmp.getEmpNo()
					+ TimePattern.doTimeDf2(new Date())
					+ (new Random().nextInt(10000));
		} else if (workLog.getType() == 2)// 月
			logNo = "GZYJ" + loginEmp.getEmpNo()
					+ TimePattern.doTimeDf2(new Date())
					+ (new Random().nextInt(10000));
		workLog.setLogNo(logNo);
		String content = workLog.getWorkresult();
		// <IMG src="face/001.gif">
		if (content != null && content != "") {
			content = StringUtil.textToHtml2(content.replace(
					"<IMG src=\"face/", "<img src=\""
							+ request.getContextPath()
							+ "/SinaEditor/Edit/face/"));
			content = content.replace("<img src=\"face/", "<img src=\""
					+ request.getContextPath() + "/SinaEditor/Edit/face/");
		}

		workLog.setWorkresult(content);
		if (workLog.getSelftemper() != null && !workLog.getSelftemper().equals("")) {
			workLog.setSelftemper(StringUtil.textToHtml2(workLog
					.getSelftemper().replace(
							"<IMG src=\"face/",
							"<IMG src=\"" + request.getContextPath()
									+ "/SinaEditor/Edit/face/")));
			workLog.setSelftemper(workLog.getSelftemper().replace(
					"<img src=\"face/",
					"<IMG src=\"" + request.getContextPath()
							+ "/SinaEditor/Edit/face/"));
		}
		if (workLog.getSuggestion() != null && !workLog.getSuggestion().equals("")) {
			workLog.setSuggestion(StringUtil.textToHtml2(workLog
					.getSuggestion().replace(
							"<IMG src=\"face/",
							"<IMG src=\"" + request.getContextPath()
									+ "/SinaEditor/Edit/face/")));
			workLog.setSuggestion(workLog.getSuggestion().replace(
					"<img src=\"face/",
					"<IMG src=\"" + request.getContextPath()
							+ "/SinaEditor/Edit/face/"));
		}
		WorkLog wLog = workLogBussiness.addReturn(workLog);
		if (null == wLog) {
			return "errorPage";
		}
		// 添加记录到动态记录表
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(loginEmp);
		executerecord.setContent("添加了一条工作日志。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(wLog.getId().toString());
		executerecord.setEntityName("WorkLog");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		// 添加审批流程
		int marker = 0;
		marker = audBussiness.addAuditingOrder3(loginEmp, "" + wLog.getLogNo(),"WorkLog", "");
		
		// 得到投诉建议的级别，并且发消息给这个领导的主管
		String tsjy=workLog.getTsjyflag();
		if(tsjy!=null && !tsjy.equals("0")){ // 发消息给本部门领导
			int flag=0;	
			//消息表有PK之后,再向接收消息表写入记录
			String infoEmp="";
			// 判断发送消息给谁
			if(tsjy.equals("1")){
				if(loginEmp.getDepartment().getEmployee()!=null){
					infoEmp=loginEmp.getDepartment().getEmployee().getId()+"";
				}else{
					flag=1;
					Email sendemail = new Email();
					sendemail.sendEmail(PublicMissionType.email,
							"福奥科技对本级领导投诉建议消息。", wLog.getSuggestion());
				}
			}
			if(tsjy.equals("2")){
				Department parentDept=(Department)workLogBussiness.getEmp(Department.class, loginEmp.getDepartment().getParentId());
				if(parentDept.getEmployee()!=null){
					infoEmp=parentDept.getEmployee().getId()+"";
				}else{
					flag=1;
					Email sendemail = new Email();
					sendemail.sendEmail(PublicMissionType.email,
							"福奥科技对上级领导投诉建议消息。", wLog.getSuggestion());
				}
			}
			if(tsjy.equals("4")){
				Department parentDept=(Department)workLogBussiness.getEmp(Department.class, PublicMissionType.boss);
				if(parentDept.getEmployee()!=null){
					infoEmp=parentDept.getEmployee().getId()+"";
				}else{
					flag=1;
					Email sendemail = new Email();
					sendemail.sendEmail(PublicMissionType.email,
							"福奥科技对总经办投诉建议消息。", wLog.getSuggestion());
				}
			}
			if(tsjy.equals("3")){
				// 找到选中的部门
				Department parentDept=(Department)workLogBussiness.getEmp(Department.class, Integer.parseInt(depts));
				if(parentDept.getEmployee()!=null){
					infoEmp=parentDept.getEmployee().getId()+"";
				}else{
					flag=1;
					Email sendemail = new Email();
					sendemail.sendEmail(PublicMissionType.email,
							"福奥科技跨部门投诉建议消息。", wLog.getSuggestion());
				}
			}
			if(flag==1){
				//发送短消息(对参与人员),先向message表写入数据,messageid有值后再向messagereceiver表写数
				Messagetype sendertype = (Messagetype)workLogBussiness.getEmp(Messagetype.class, 1);  //sendertype员工消息
				Messagetype messagetype = (Messagetype)workLogBussiness.getEmp(Messagetype.class, PublicMissionType.typeid); //messagetype 消息类型:日志消息
				String sender = loginEmp.getId().toString();
				Message mess = new Message();
				mess.setSender(sender);  //发送人(当前登录人ID)
				mess.setMessagetypeBySendertype(sendertype); //发送类型:员工消息
				mess.setMessagetypeByMessagetype(messagetype);//消息类型:个人公告
				mess.setTitleweb("goAddNewReplyWorkLogNewportal.do?logNo="+wLog.getLogNo()+"&id="+wLog.getId());
				mess.setMessagecontent(wLog.getSuggestion());
				mess.setRepealfalg("0"); //是否撤销 0为否 	 1为是
				mess.setDelfalg("0"); //删除标识
				mess.setDraftfalg("0"); //草稿标识
				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String releasetime = sdf.format(now);
				mess.setReleasetime(Timestamp.valueOf(releasetime));
				mess.setTmp1("0");
				workLogBussiness.addSch(mess);
				Messagereceiver receiver = new Messagereceiver();
				receiver.setMessage(mess);
				receiver.setMessagetype(sendertype);
				receiver.setReceiverer(infoEmp);
				receiver.setReceivetime(Timestamp.valueOf(releasetime));
				receiver.setReadfalg("0"); //是否读取 未读取0
				receiver.setDelfalg("0"); //删除标识 没有0
				receiver.setTmp1("0");  //0是员工 1是客户
				workLogBussiness.addSch(receiver);
			}
		}
	return "successPage";
}

	/**
	 * 跳转至(我的)日志列表查询全部 2012-1-9 16:02:02 补充条件查询
	 * 
	 * @return
	 */
	
	public String select() {
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		
		// 拿到每页放多少条数据
		String strPageCount = request.getParameter("pageCount");
		int pageCount = 14;
		if (null != strPageCount && !"".equals(strPageCount)) {
			pageCount = Integer.parseInt(strPageCount);
		}

		// 拿到当前第几页
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		String typestr=request.getParameter("logtype");
		int type=0;
		if(typestr!=null && !typestr.equals("")){
			type=Integer.parseInt(typestr);
		}
		// 自定义hql语句
		String hql = "From WorkLog as tb where type="+type+" and tb.employeeByEmpId = "
				+ loginEmp.getId();

		/********************* 条件查询 *********************/
		// 判断是否的左边框框的列表和重新条件查询 是就清空session
		String clear = request.getParameter("clear");
		if ("0".equals(clear) || "0" == clear) {
			request.getSession().removeAttribute("isView1");
			request.getSession().removeAttribute("selectDate1");
		}

		// 拿到session值 view是否进行了条件查询
		Object objIsViewSe = request.getSession().getAttribute("isView1");
		Object objSelectDateSe = request.getSession().getAttribute(
				"selectDate1");

		// 查看批注的类型和日志添加的时间
		int isView = -1;
		String selectDate = null;

		// 判断session中是否有值
		if (null != objIsViewSe) {
			isView = Integer.parseInt(objIsViewSe.toString());
		} else if (null == objIsViewSe) {

			// 拿到页面传过来的条件
			Object objIsView = request.getAttribute("isView");
			if (null != objIsView) {
				isView = Integer.parseInt(objIsView.toString());
				request.getSession().setAttribute("isView1", isView);
			}
		}
		// 如果是-1 就是查询全部 不是查询相应的
		if (isView != -1) {
			hql += " and tb.isView = " + isView;
		}

		// 如果Session不为空
		if (null != objSelectDateSe) {
			selectDate = objSelectDateSe.toString();
			hql += " and tb.recordTime like '%" + selectDate + "%' ";
		} else if (null == objSelectDateSe) {

			// 如果session为空，再拿到页面传过来的日期
			Object objSelectDateRe = request.getParameter("selectDate");
			if (null != objSelectDateRe) {
				selectDate = objSelectDateRe.toString();
				hql += " and tb.recordTime like '%" + selectDate + "%' ";
				request.getSession().setAttribute("selectDate1", selectDate);
			}
		}
		/************************************************/
		hql += " order by id desc";

		// 执行分页查询
		Pages pages = workLogBussiness
				.exeHqlPages(hql, pageNo, pageCount, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		session.setAttribute("workList", pages.getPageList());
		request.setAttribute("pages", pages);
		request.setAttribute("mark", type);
		request.setAttribute("logtype", type);

		return "myList";
	}

	/**
	 * 处理他人刚开始页面展示出来的顶层的下拉框
	 * 
	 */
	
	public void dealWith(Employee ep)
	{
		try
		{
			int grade = ep.getWorkposition().getWorkgrade().getGrade();
			
			List deparmentParent = new ArrayList();
			List deparments = new ArrayList();
			List groups = new ArrayList();
			List employees = new ArrayList();
			
			if(grade==5)
			{
				//第四级别的部门
				deparmentParent = workLogBussiness.getDepartmentIDs(ep.getDepartment().getId());
				request.setAttribute("deparmentParent", deparmentParent);
				
				//第三级别的部门(默认从第一个部门开始 )
				deparments = workLogBussiness.getDepartmentIDs(((Department)deparmentParent.get(0)).getId());
				request.setAttribute("deparments", deparments);
				
				//第二级别的部门(默认从第一个部门开始)
				groups = workLogBussiness.getDepartmentIDs(((Department)deparments.get(0)).getId());
				request.setAttribute("groups", groups);
				
				//第一级别
				employees = workLogBussiness.getEmployee(((Department)groups.get(0)).getId());
				request.setAttribute("employees", employees);
			}
			else if(grade==4) //级别在部门以上
			{
				//第四级别的部门
				request.setAttribute("deparmentParent", "");
				
				//第三级别的部门(默认从第一个部门开始 )
				deparments = workLogBussiness.getDepartmentIDs(((Department)deparmentParent.get(0)).getId());
				request.setAttribute("deparments", deparments);
				
				//第二级别的部门(默认从第一个部门开始)
				groups = workLogBussiness.getDepartmentIDs(((Department)deparments.get(0)).getId());
				request.setAttribute("groups", groups);
				
				//第一级别
				employees = workLogBussiness.getEmployee(((Department)groups.get(0)).getId());
				request.setAttribute("employees", employees);
			}
			else if(grade==3)//级别在部门
			{
				
				request.setAttribute("deparmentParent", "");
				
				request.setAttribute("deparments", "");
				
				//第二级别的部门(默认从第一个部门开始
				groups = workLogBussiness.getDepartmentIDs(((Department)deparments.get(0)).getId());
				request.setAttribute("groups", groups);
				
				//第一级别
				employees = workLogBussiness.getEmployee(((Department)groups.get(0)).getId());
				request.setAttribute("employees", employees);
			}
			else if(grade==2)//级别在组长
			{
				
				request.setAttribute("deparmentParent", "");
				
				request.setAttribute("deparments", "");
				
				request.setAttribute("groups", "");
				
				//第一级别
				employees = workLogBussiness.getEmployee(((Department)groups.get(0)).getId());
				request.setAttribute("employees", employees);
			}
			else //员工级别
			{
				request.setAttribute("deparmentParent", "");
				
				request.setAttribute("deparments", "");
				
				request.setAttribute("groups", "");
				
				request.setAttribute("employees", "");
			}
			
			request.setAttribute("deparments", deparments);
		}
		catch(Exception e)
		{
			 e.printStackTrace();
		 }
	}
	
	/**
	 * 员工信息
	 */
	public void getEmployeeByDepartmentID()
	{
		
			String departmentIDStr = request.getParameter("departmentID");
			
			if(departmentIDStr!=null&&!"-1".equals(departmentIDStr))
			{
				int departmentID = Integer.parseInt(departmentIDStr);
				
				String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
						+ departmentID + ")");
				
				String hql= "from Employee e where e.department.id in ("+sonIds+")";
				
				List employees = workLogBussiness.exeHql(hql);
				
				StringBuffer stb = new StringBuffer("<option  id=\"deparmentID\" value=\"-1\">请选择:</option>");
				
				for(int i = 0 ; i < employees.size();i++)
				{
					Employee employee = (Employee) employees.get(i);
					
					//判断是否离职或者被删除了
					//e.getIsLeave()==0||e.getDelflag()==1
					if(employee.getDelflag()==null){
						if(employee.getIsLeave()==1){
							stb.append("<option id=\"employeeID\" value=\"").append(employee.getId()).append("\">").append(employee.getName()).append("</option><br/>");
							
						}
						
					}else{
						
						if(employee.getIsLeave()==0 && employee.getDelflag()==1)
						{
							
						}else{
							
							stb.append("<option id=\"employeeID\" value=\"").append(employee.getId()).append("\">").append(employee.getName()).append("</option><br/>");
						}
					}
					
				
				}
				response.setCharacterEncoding("utf-8");
				try {
					try {
						response.getWriter().write(stb.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			//request.setAttribute("employees",employees);
		
	try
	{}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public void getEmployeeByDepartmentID1()
	{
		try
		{
			String departmentIDStr = request.getParameter("departmentID");
			
			if(departmentIDStr!=null&&!"-1".equals(departmentIDStr))
			{
				int departmentID = Integer.parseInt(departmentIDStr);
				
				
				
				String hql= "from Employee e where e.department.id="+departmentID+")";
				
				List employees = workLogBussiness.exeHql(hql);
				
				StringBuffer stb = new StringBuffer("<option  id=\"deparmentID\" value=\"-1\">请选择:</option>");
				
				for(int i = 0 ; i < employees.size();i++)
				{
					Employee employee = (Employee) employees.get(i);
					
					//判断是否离职或者被删除了
					//e.getIsLeave()==0||e.getDelflag()==1
					if(employee.getIsLeave()==1&&employee.getDelflag()==0)
					{
						stb.append("<option id=\"employeeID\" value=\"").append(employee.getId()).append("\">").append(employee.getName()).append("</option><br/>");
					}
				}
				response.setCharacterEncoding("utf-8");
				response.getWriter().write(stb.toString());
			}
			//request.setAttribute("employees",employees);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 跳转至他人日志列表
	 */
	public String selectOther()
	{
		
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		
		String audhql = "From AuditingOrderTab where 1=1 and handlestate = 1 and auditingFlag =0 and (orderNo like 'GZRZ%' or orderNo like 'GZZJ%' or orderNo like 'GZYJ%')  and employees = '"
			+ loginEmp.getId().toString() + "' ";
		//String audhql = "From AuditingOrderTab where 1=1 and handlestate = 1 and auditingFlag =0 ";
		List list = workLogBussiness.exeHql(audhql);
		request.setAttribute("audlist", list);
		
		// 拿到每页放多少条数据
		String strPageCount = request.getParameter("pageCount");
		System.out.println("结果怎样:"+strPageCount);
		if(strPageCount==null)
		{
			System.out.println(1);
		}
		else if("".equals(strPageCount))
		{
			System.out.println(2);
		}
		if (null != strPageCount && !"".equals(strPageCount)) {
			pageCount = Integer.parseInt(strPageCount);
		}

		// 拿到当前第几页
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		/****************** 权限查看 *****************/
		// 执行sql获得子类ID
		//	getChildDeptLst( int id);
		String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
				+ empposition.getWorkposition().getDepartment().getId() + ")");
		
		// 执行sql获得兼职部门及id;
//		String otherIds = "";
//		List otherp = workLogBussiness
//				.exeHql("from WorkpositionEmployee where employee.id="
//						+ loginEmp.getId()+" and positiontype=3");
		
		
//		for (Iterator it = otherp.iterator(); it.hasNext();) {
//			WorkpositionEmployee wpe = (WorkpositionEmployee) it.next();
//			// 在这里还要标识其是主管的
//			if(wpe.getWorkposition().getIspersonman()==1){
//				int deptid = wpe.getWorkposition().getDepartment().getId();
//				otherIds += workLogBussiness.executeSql("select getChildDeptLst("
//						+ deptid + ")");
//			}
//			otherIds +=",";
//		}
//		
//		if(otherIds.equals(",")){
//			otherIds = "";
//		}
//		if(!otherIds.equals("")){
//			otherIds = otherIds.substring(0, otherIds.length()-1);
//		}
//
//		String otherhql = "";
//		if (!otherIds.equals("")) {
//			otherhql = " or (tb.employeeByEmpId.department.id in(" + otherIds
//					+ "))";
//		}

		// 权限判断 判断当前登录用户是否可以查看到动态
		int intPermissionGrade = Integer.parseInt(loginEmp.getGroups()
				.getPermissionGrade());

		// 判断类型
		String typestr=request.getParameter("type");
		int type=0;
		if(typestr!=null){
			type=Integer.parseInt(typestr);
		}
		// 自定义hql语句
		String hql = "";
		// 判断是否为最高权限0 是就可以看到所有
		if (intPermissionGrade == 0) {
			hql = "from WorkLog tb where 1 = 1 and type=0 ";
		} else {
			hql = "from WorkLog tb where 1=1 and type="+type+" and  tb.employeeByEmpId.department.id in ("
					+ sonIds
					+ ") and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
		}
		// hql =
		// " from WorkLog tb where 1=1 and tb.employeeByEmpId.workpostion";
		// 得到关联部门的员工id数组

		/**************** 项目下拉框项目类型值  *******************/
		try
		{
			String condition = "";
			
			String hql1 = "from Department  d where d.id in ";
			
			List  deparetmentList = null;
			
//			if(!"".equals(otherIds))
//			{
//				condition+="("+sonIds+","+otherIds+")";
//			}
//			else
//			{
				condition+="( "+sonIds+" )";
			//}
			
			hql1+=condition;
			deparetmentList = workLogBussiness.exeHql(hql1);
			request.getSession().setAttribute("deparments",deparetmentList);
			
			hql1 = "from Employee e where e.department.id in "+condition+"";
			List employees = workLogBussiness.exeHql(hql1);
			for(int i = employees.size()-1; i < employees.size()&&i>=0;i--)
			{
				Employee e= (Employee) employees.get(i);
				
				//看看是否员工被删除了还是辞职了  Isleave0 是离职   delflag 1是删除
				if(e.getIsLeave()==0||e.getDelflag()==1)
				{
					employees.remove(i);
				}
			}
			
			request.getSession().setAttribute("employees",employees);
			
			
			//默认显示50条记录
			request.getSession().setAttribute("defaultPageCount",pageCount);
			
			//显示记录数如下（10,20,30,40,50,60,70）
			int [] pageCounts = {10,20,30,40,50,60,70};
			request.getSession().setAttribute("pageCounts",pageCounts);
		} 
		catch(Exception e)
		{
			e.printStackTrace();
		}
			
		

		/********************* 条件查询 *********************/
		// 判断是否的左边框框的列表和重新条件查询 是就清空session
		String clear = request.getParameter("clear");
		if ("0".equals(clear) || "0" == clear) {
			request.getSession().removeAttribute("view2");
			request.getSession().removeAttribute("selectDate2");
		}

		// 拿到session值 view是否进行了条件查询
		Object objView = request.getSession().getAttribute("view2");
		Object objSelectDateSe = request.getSession().getAttribute(
				"selectDate2");

		int isView = -1;
		String selectDate = null;

		if (null != objView) {
			isView = Integer.parseInt(objView.toString());
		} else if (null == objView) {
			// 拿到条件查询的条件（不为必有）
			Object objIsView = request.getAttribute("isView");
			if (null != objIsView) {
				isView = Integer.parseInt(objIsView.toString());
				request.getSession().setAttribute("view2", isView);
			}
		}
		// 如果是-1 就是查询全部 不是查询相应的
		if (isView != -1) {
			hql += " and tb.isView = " + isView;
		}

		// 如果Session不为空
		if (null != objSelectDateSe) {
			selectDate = objSelectDateSe.toString();
			hql += " and tb.recordTime like '%" + selectDate + "%' ";
			
		} else if (null == objSelectDateSe) {

			// 如果session为空，再拿到页面传过来的日期
			Object objSelectDateRe = request.getParameter("selectDate");
			if (null != objSelectDateRe) {
				selectDate = objSelectDateRe.toString();
				hql += " and tb.recordTime like '%" + selectDate + "%' ";
				request.getSession().setAttribute("selectDate2", selectDate);
			}
		}
		
		
	/************* 条件 添加部门类型和员工名称 ****************/
		String departmentIDStr = request.getParameter("departmentID");
		String employyeName = request.getParameter("employeeID");
		
		if(departmentIDStr != null&&!"-1".equals(departmentIDStr))
		{
			 sonIds = workLogBussiness.executeSql("select getChildDeptLst("
					+  new Integer(departmentIDStr) + ")");
			hql += " and tb.employeeByEmpId.department.id in( " + sonIds+ " )";
		}
		if(employyeName != null&&!"-1".equals(employyeName))
		{
			hql +=" and tb.employeeByEmpId.id = '"+ employyeName+"'";
		}
		
	
		/******************************************/

		// id倒序排列 以显示最新
		hql += " order by id desc";

		// 执行分页查询
		Pages pages = workLogBussiness
				.exeHqlPages(hql, pageNo, pageCount, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			/*
			if(log.getEmployeeByEmpId().getDelflag()==1||log.getEmployeeByEmpId().getIsLeave()==0)
			{
				workList.remove(log);
			}
			*/
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		
		session.setAttribute("workList",workList);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", type);
		request.setAttribute("LogType", type);
		
		return "otherList";
	}

	/**
	 * 部门和兼职的职位
	 */
	
	public boolean getResult(Employee loginEmp,WorkLog worklog)
	{
		boolean result = false;
		
		try
		{
			// 执行sql获得子类ID
			//	getChildDeptLst( int id);
			String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
					+ loginEmp.getDepartment().getId() + ")");
			
			// 执行sql获得兼职部门及id;
			String otherIds = "";
			List otherp = workLogBussiness
					.exeHql("from WorkpositionEmployee where employee.id="
							+ loginEmp.getId());
			
			
			for (Iterator it = otherp.iterator(); it.hasNext();) {
				WorkpositionEmployee wpe = (WorkpositionEmployee) it.next();
				int deptid = wpe.getWorkposition().getDepartment().getId();
				otherIds += workLogBussiness.executeSql("select getChildDeptLst("
						+ deptid + ")");
				otherIds +=",";
			}
			
			if(otherIds.equals(",")){
				otherIds = "";
			}
			if(!otherIds.equals("")){
				otherIds = otherIds.substring(0, otherIds.length()-1);
			}

			String otherhql = "";
			if (!otherIds.equals("")) {
				otherhql = " or (tb.employeeByEmpId.department.id in(" + otherIds
						+ "))";
			}

			// 权限判断 判断当前登录用户是否可以查看到动态
			int intPermissionGrade = Integer.parseInt(loginEmp.getGroups()
					.getPermissionGrade());

			// 自定义hql语句
			String hql = "";

			// 判断是否为最高权限0 是就可以看到所有
			if (intPermissionGrade == 0)
			{
				hql = "from WorkLog tb where 1 = 1 ";
			} 
			else
			{
				hql = "from WorkLog tb where 1 = 1 and ((tb.employeeByEmpId.groups.permissionGrade > "
						+ loginEmp.getGroups().getPermissionGrade()
						+ " and tb.employeeByEmpId.department.id in ("
						+ sonIds
						+ ")) "
						+ otherhql
						+ ") and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
			}
			
			List workLogList  = workLogBussiness.exeHql(hql);
			
			for(int i = 0 ; i < workLogList.size();i++)
			{
				WorkLog wl = (WorkLog) workLogList.get(i);
				
				if(worklog.getId() == wl.getId())
				{
					result = true;
				}
			}
		}
		catch(Exception e)
		{
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	/**
	 * 查看详情
	 * 
	 * @return
	 * @throws IOException
	 */
	
	public void goDeal() throws IOException
	{
		// 获得查看的日志
		String strId = request.getParameter("id");
		int id = 0;
		if (null != strId && !"".equals(strId)) {
			id = Integer.parseInt(strId);
		}
		WorkLog workLog = workLogBussiness.getById(id);

		// 传递给页面
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(workLog.getContent());

	}

	/**
	 * 查看详情 跳转新的页面 2012-6-10
	 * 
	 * @return
	 * @throws IOException
	 */
	public String goDeal2() throws IOException {
		// 获得查看的日志
		String strId = request.getParameter("id");
		int id = 0;
		if (null != strId && !"".equals(strId)) {
			id = Integer.parseInt(strId);
		}
		WorkLog workLog = workLogBussiness.getById(id);
		//传递给页面
		request.setAttribute("worklog", workLog);
		return "loginfo";

	}

	/**
	 * 添加批注跳转
	 * 
	 * @return
	 */
	public String goAddReply() {
		String strId = request.getParameter("id");
		int id = 0;
		if (null != strId || !"".equals(strId)) {
			id = Integer.parseInt(strId);
		}
		// 拿到需要条件批注的日志
		WorkLog workLog = workLogBussiness.getById(id);
		request.setAttribute("data", workLog);

		return "goAddReply";
	}

	/**
	 * 添加批注跳转(新)
	 * 
	 * @return
	 */
	public String goAddNewReply() {
	 	String strId = request.getParameter("id");
		String logNo = request.getParameter("logNo");
		String mark="0";
		// 根据当前登录人与当前时间
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
	    Date now=new Date();
	    String str=dateFormat2.format(now);
		int id = 0;
		WorkLog workLog = new WorkLog();
		if (null != strId && !"".equals(strId)) {
			id = Integer.parseInt(strId);
			// 拿到需要条件批注的日志
			workLog = workLogBussiness.getById(id);

		} else if (null != logNo || !"".equals(logNo)) {
			List list = workLogBussiness.exeHql("From WorkLog where logNo = '"
					+ logNo + "'");
			if (list != null && list.size() > 0)
				workLog = (WorkLog) list.get(0);

		}
		
		//查询是不是审批人员登录
		String hqlshengpi="from WorkpositionEmployee where workposition.department.id="+employee.getDepartment().getId()+" and employee.id="+employee.getId()+"";
		List listrenwu=workLogBussiness.exeHql(hqlshengpi);
		if(listrenwu.size()>0)
		{
			Workposition wp=((WorkpositionEmployee)listrenwu.get(0)).getWorkposition();
			System.out.println(wp.getIspersonman());
			if(wp.getIspersonman()==1)//是否能评分
			{
				mark="1";
			}
		}
		request.setAttribute("mark", mark);
	    // 添加访问记录
		String str3=dateFormat.format(now);
		Executerecord execuRecord=new Executerecord();
		execuRecord.setEmployee(employee);
		execuRecord.setContent("添加日志批注");
		execuRecord.setExecuteTime(str3);
		execuRecord.setEntityId(id+"");
		execuRecord.setEntityName("WorkLog");
		workLogBussiness.addRecord(execuRecord);
		
	    // 拿出今日操作动态记录，操作记录要改。
		String hqlRecord = "From Executerecord tb where tb.entityName='WorkLog' and tb.entityId='"+strId+"'";
		List<Executerecord> recordList = workLogBussiness.exeHql(hqlRecord);
		request.setAttribute("worklog", workLog);
		Date date=new Date();
		try {
			date = dateFormat2.parse(workLog.getRecordTime());
		} catch (ParseException e) {
		}
		String date2= dateFormat2.format(date);
        // 查看今天的日志便签
	    String schehql = "From Scheduleplan tb where tb.endtime like '%"
			+ date2 + "%' and tb.plantype = 5 and tb.employee.id = "
			+ workLog.getEmployeeByEmpId().getId();
	    List schelist= workLogBussiness.exeHql(schehql);
		// 获取批阅列表
		String hql = "From AuditingOrderTab where 1=1 and handlestate = 2 and auditingFlag =1 and orderNo = '"
				+ workLog.getLogNo() + "'";
		// audBussiness.
		List list = workLogBussiness.exeHql(hql);
		request.setAttribute("replyList", list);
		request.setAttribute("recordList", recordList);
		request.setAttribute("audid", request.getParameter("audid"));
		request.setAttribute("schelist", schelist);
		if(workLog.getType()==0){
			// 是日志的情况下
			return "goAddNewReply";	
		}else{
			// 是周，月志的情况下
			String[] weLogInfo=workLog.getContent().split("\\|");
			if(weLogInfo.length>0){
				request.setAttribute("weLogInfo", weLogInfo);
			}
			return "addweekOryue";
		}
	}

	/**
	 * 添加批注
	 */
	public String addReply() {
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}

		// 获得需要添加批注的日志
		String strId = request.getAttribute("id").toString();
		int id = 0;
		if (null != strId) {
			id = Integer.parseInt(strId);
		}
		WorkLog wLog = workLogBussiness.getById(id);

		// 获得批注内容
		String reply = request.getParameter("reply").toString();

		// 为对象设置值
		wLog.setReplyContent(reply);
		wLog.setEmployeeByReplier(loginEmp);
		wLog.setReplyTime(TimePattern.doTimeDf3(new Date()));
		wLog.setIsView(1);

		// 添加批注 （修改对象）
		boolean result = workLogBussiness.addReply(wLog);
		if (result == false) {
			request.setAttribute("errorMsg", "添加批注失败,请重试！");
			return "no";
		}
		return "addReply";
	}

	/**
	 * 添加批注
	 */
	public void addNewReply()
	{
		// 拿到当前登录员工
		try 
		{
			Employee loginEmp = this.getEmp();
			if (null == loginEmp)
			{
				response.getWriter().print(1);
				return;
			}

			// 获得需要添加批注的日志
			String strId = request.getAttribute("id").toString();
			int id = 0;
			if (null != strId) {
				id = Integer.parseInt(strId);
			}
			
			double grade = 0;
			//得到上级评分
			if(!"".equals(request.getParameter("mark"))&&request.getParameter("mark")!=null)
			{
				grade = Double.parseDouble(request.getParameter("mark"));
			}
			
			WorkLog wLog = workLogBussiness.getById(id);

			// 获得批注内容
			String reply = URLDecoder.decode(URLDecoder.decode(request
					.getParameter("reply"), "UTF-8"), "UTF-8");
			
			String audid  ="";
			//String audid = request.getParameter("audid");
			
			String audhql = "From AuditingOrderTab where 1=1 and handlestate = 1 and auditingFlag =0 and (orderNo like 'GZRZ%' or orderNo like 'GZZJ%' or orderNo like 'GZYJ%')  and employees = '"
				+ loginEmp.getId().toString() + "' ";
			List list = workLogBussiness.exeHql(audhql);
			
			if(workLog.getLogNo() != null)
			{
				for(int i = 0; i < list.size();i++)
				{
					AuditingOrderTab a = (AuditingOrderTab) list.get(i);
					
					if(a.getOrderNo().trim().equals(workLog.getLogNo().trim()))
					{
						 audid  = a.getId().toString().trim();
					}
				}
			}
			
			if (audid == null || audid.equals("")) 
			{
				
				// 判断取的最大auditingOrder
				String hql2 = " From AuditingOrderTab where 1=1  and orderNo = '"
						+ wLog.getLogNo() + "' order by auditingOrder desc";
				List list2 = workLogBussiness.exeHql(hql2);
				int maxOrder = 0;
				if (list2 != null && list2.size() > 0) {
					maxOrder = ((AuditingOrderTab) list2.get(0))
							.getAuditingOrder();
				}
				
				// 插入审批记录
				AuditingOrderTab aot = new AuditingOrderTab();

				aot.setAuditingFlag(1);
				aot.setAuditingOrder(maxOrder + 1);
				aot.setDepartment(loginEmp.getDepartment());
				aot.setOrderNo(wLog.getLogNo());
				
				aot.setMark("0");// 默认0一人审核
				
				aot.setEmployees(loginEmp.getId().toString());
				aot.setHandlestate(2);
				TimePattern tp = new TimePattern();
				Date date = new Date();
				String nowtime = tp.doTimeDf3(date);
				aot.setIncepttime(Timestamp.valueOf(nowtime));
				aot.setEmployeeByInceptemp(loginEmp);
				aot.setTmp(StringUtil.textToHtml2(reply.replace(
						"<IMG src=\"face/", "<IMG src=\""
								+ request.getContextPath()
								+ "/SinaEditor/Edit/face/")));
				aot.setAuditingtime(Timestamp.valueOf(TimePattern
						.doTimeDf3(date)));	
				
					aot.setGrade(grade);
				audBussiness.addAuditingOrder(aot);
				
				// 更改日志状态为新批注
				wLog.setIsView(1);
				
			 /* String str  = wLog.getReplyContent().replace(
						"<IMG src=\"face/",
						"<IMG src=\"" + request.getContextPath()
								+ "/SinaEditor/Edit/face/");*/
				
				if(wLog.getReplyContent()!=null)
				{
					wLog.setReplyContent(StringUtil.textToHtml2(wLog
							.getReplyContent().replace(
									"<IMG src=\"face/",
									"<IMG src=\"" + request.getContextPath()
											+ "/SinaEditor/Edit/face/")));
				}
				else
				{
					wLog.setReplyContent(reply);
					wLog.setReplyTime(nowtime);
					wLog.setEmployeeByReplier(loginEmp);
				}
				workLogBussiness.addReply(wLog);
				response.getWriter().print(0);

			} 
			else
			{
				// 修改审批记录
				// 为对象设置值
				wLog.setReplyContent(reply);
				wLog.setEmployeeByReplier(loginEmp);
				wLog.setReplyTime(TimePattern.doTimeDf3(new Date()));
				wLog.setIsView(1);

				// 添加批注 （修改对象）
				boolean result = workLogBussiness.addReply(wLog);
				
				// 插入审批
				String hql = " update AuditingOrderTab set tmp ='" + reply
						+ "',handlestate = 2 , auditingFlag =1,auditingtime='"
						+ TimePattern.doTimeDf3(new Date()) +",grade ="+grade+ "' where id= "
						+ audid;
				audBussiness.updatehql(hql);

				if (result == false) {
					request.setAttribute("errorMsg", "添加批注失败,请重试！");
					response.getWriter().print(1);
				} else {
					response.getWriter().print(0);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查看批注（分2种：查看自己的日志批注，要改状态。有权限的查看别人的不改状态。）
	 * 
	 */
	public String goSeeReply() {
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		// 获得查看批注的日志
		String strId = request.getAttribute("id").toString();
		int id = 0;
		if (null != strId) {
			id = Integer.parseInt(strId);
		}
		WorkLog wLog = workLogBussiness.getById(id);

		request.setAttribute("data", wLog);

		// 判断是否为自己的日志，是否要改状态
		int idOne = wLog.getEmployeeByEmpId().getId();
		int idTwo = loginEmp.getId();
		if (idOne == idTwo) {
			request.setAttribute("isMy", 0);
		} else {
			request.setAttribute("isMy", 1);
		}

		return "goSeeReply";
	}

	/**
	 * 跳转到详情页面
	 */
	public String goDetail()
	{
		Employee loginEmp = this.getEmp();
		String strId = request.getParameter("id");
		String logNo = request.getParameter("logNo");
		int id = 0;
		WorkLog workLog = new WorkLog();
		if (null != strId && !"".equals(strId)) {
			id = Integer.parseInt(strId);
			// 拿到需要条件批注的日志
			workLog = workLogBussiness.getById(id);

		} else if (null != logNo || !"".equals(logNo)) {
			List list = workLogBussiness.exeHql("From WorkLog where logNo = '"
					+ logNo + "'");
			if (list != null && list.size() > 0)
				workLog = (WorkLog) list.get(0);

		}
		request.setAttribute("worklog", workLog);
	    Date now=new Date();
	    String str=dateFormat2.format(now);
		String hqlRecord = "From Executerecord tb where tb.executeTime like '%"
				+ str + "%' ";
		List<Executerecord> recordList = workLogBussiness.exeHql(hqlRecord);
		Date date=new Date();
		try {
			date = dateFormat2.parse(workLog.getRecordTime());
		} catch (ParseException e) {
		}
		String date2= dateFormat2.format(date);
        // 查看今天的日志便签
	    String schehql = "From Scheduleplan tb where tb.endtime like '%"
			+ date2 + "%' and tb.plantype = 5 and tb.employee.id = "
			+ workLog.getEmployeeByEmpId().getId();
	    List schelist= workLogBussiness.exeHql(schehql);
		request.setAttribute("schelist", schelist);
	    request.setAttribute("recordList", recordList);

		//判断是否他上级
		//看看是否是它的子集或者它的兼职部门里面它		
		boolean result = getResult( loginEmp,workLog);
		
		//自已不能够批阅
		/*
		if(result)
		{
			
			result = (loginEmp.getId()==workLog.getEmployeeByEmpId().getId())?false:true;
		}
		*/
		
		if(result)
		{
			request.setAttribute("isResult",true);
			System.out.println("结果是 :"+true);
		}
		else
		{
			request.setAttribute("isResult",false);
			System.out.println("结果是:"+false);
		}
		
		
		// 获取批阅列表
		String hql = "From AuditingOrderTab where 1=1 and handlestate = 2 and auditingFlag =1 and orderNo = '"
				+ workLog.getLogNo() + "'";
		// audBussiness.
		List list = workLogBussiness.exeHql(hql);
		request.setAttribute("replyList", list);

		// 判断自己是否有批注的权力 审批列表最新的一条 得到部门id -> 得到他的父类部门id ->父类部门的主管 是否等于本人
		// 是的话 自己可以添加审批
		boolean enabled = true;
		String hql2 = " From AuditingOrderTab where 1=1  and orderNo = '"
				+ workLog.getLogNo() + "' order by auditingOrder desc";
		List list2 = workLogBussiness.exeHql(hql2);
		for (Iterator it = list2.iterator(); it.hasNext();) {
			AuditingOrderTab aob = (AuditingOrderTab) it.next();
			if (aob.getHandlestate() != 2 || aob.getAuditingFlag() == 0) {
				enabled = false;
			}

		}

		if (list2 != null && list2.size() > 0 && enabled) {
			// 审核表中日志已经全部审核完毕 没有未审核的
			AuditingOrderTab aob = (AuditingOrderTab) list2.get(0);
			int parentDept = aob.getDepartment().getParentId();
			List deptlist = workLogBussiness
					.exeHql(" from Department where id = " + parentDept);
			Department dept = (Department) deptlist.get(0);
			if (dept.getEmployee() != null
					&& dept.getEmployee().getId().equals(loginEmp.getId())) {
				request.setAttribute("isView", "false");
				return "goAddNewReply";
			}
		}
		// request.setAttribute("audid", request.getParameter("audid"));

		// 判断是否为自己的日志，是否要改状态
		int idOne = workLog.getEmployeeByEmpId().getId();
		int idTwo = loginEmp.getId();
		if (idOne == idTwo) {
			request.setAttribute("isMy", 0);
		} else {
			request.setAttribute("isMy", 1);
		}
		// request.setAttribute("isView","true");
		return "detail";
	}
	
	/**
	 * 查看批注（分2种：查看自己的日志批注，要改状态。有权限的查看别人的不改状态。）
	 * 
	 */
	public String goSeeReply2() {
		Employee loginEmp = this.getEmp();
		String strId = request.getParameter("id");
		String logNo = request.getParameter("logNo");
		int id = 0;
		WorkLog workLog = new WorkLog();
		if (null != strId && !"".equals(strId)) {
			id = Integer.parseInt(strId);
			// 拿到需要条件批注的日志
			workLog = workLogBussiness.getById(id);

		} else if (null != logNo || !"".equals(logNo)) {
			List list = workLogBussiness.exeHql("From WorkLog where logNo = '"
					+ logNo + "'");
			if (list != null && list.size() > 0)
				workLog = (WorkLog) list.get(0);

		}
		request.setAttribute("worklog", workLog);
		// 根据当前登录人与当前时间拿出今日操作动态记录，操作记录要改
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
	    Date now=new Date();
	    String str=dateFormat2.format(now);
	    // 添加访问记录
		String str3=dateFormat.format(now);
		Executerecord execuRecord=new Executerecord();
		execuRecord.setEmployee(employee);
		execuRecord.setContent("查看日志批注");
		execuRecord.setExecuteTime(str3);
		execuRecord.setEntityId(id+"");
		execuRecord.setEntityName("WorkLog");
		workLogBussiness.addRecord(execuRecord);
	    // 拿出今日操作动态记录，操作记录要改。
		String hqlRecord = "From Executerecord tb where tb.entityName='WorkLog' and tb.entityId='"+strId+"'";
		List<Executerecord> recordList = workLogBussiness.exeHql(hqlRecord);

		Date date=new Date();
		try {
			date = dateFormat2.parse(workLog.getRecordTime());
		} catch (ParseException e) {
		}
		String date2= dateFormat2.format(date);
        // 查看今天的日志便签
	    String schehql = "From Scheduleplan tb where tb.endtime like '%"
			+ date2 + "%' and tb.plantype = 5 and tb.employee.id = "
			+ workLog.getEmployeeByEmpId().getId();
	    List schelist= workLogBussiness.exeHql(schehql);
		// 获取批阅列表
		String hql = "From AuditingOrderTab where 1=1 and handlestate = 2 and auditingFlag =1 and orderNo = '"
				+ workLog.getLogNo() + "'";
		// audBussiness.
		List list = workLogBussiness.exeHql(hql);
		request.setAttribute("replyList", list);
		request.setAttribute("schelist", schelist);
	    request.setAttribute("recordList", recordList);

		// 判断自己是否有批注的权力 审批列表最新的一条 得到部门id -> 得到他的父类部门id ->父类部门的主管 是否等于本人
		// 是的话 自己可以添加审批
		boolean enabled = true;
		String hql2 = " From AuditingOrderTab where 1=1  and orderNo = '"
				+ workLog.getLogNo() + "' order by auditingOrder desc";
		List list2 = workLogBussiness.exeHql(hql2);
		for (Iterator it = list2.iterator(); it.hasNext();) {
			AuditingOrderTab aob = (AuditingOrderTab) it.next();
			if (aob.getHandlestate() != 2 || aob.getAuditingFlag() == 0) {
				enabled = false;
			}

		}

		if (list2 != null && list2.size() > 0 && enabled) {
			// 审核表中日志已经全部审核完毕 没有未审核的
			AuditingOrderTab aob = (AuditingOrderTab) list2.get(0);
			int parentDept = aob.getDepartment().getParentId();
			List deptlist = workLogBussiness
					.exeHql(" from Department where id = " + parentDept);
			Department dept = (Department) deptlist.get(0);
			if (dept.getEmployee() != null
					&& dept.getEmployee().getId().equals(loginEmp.getId())) {
				request.setAttribute("isView", "false");
				return "goAddNewReply";
			}
		}
		// request.setAttribute("audid", request.getParameter("audid"));

		// 判断是否为自己的日志，是否要改状态
		int idOne = workLog.getEmployeeByEmpId().getId();
		int idTwo = loginEmp.getId();
		if (idOne == idTwo) 
		{
			request.setAttribute("isMy", 0);
		} else {
			request.setAttribute("isMy", 1);
		}
		// request.setAttribute("isView","true");
		String flagstr=request.getParameter("flag"); // 标识是部门日志还是个人日志。
		int flag=1;
		if(flagstr!=null){
			flag=0;
		}
		request.setAttribute("flag", flag);
		if(workLog.getType()==0){
			// 是日志的情况下
			return "loginfo";	
		}else{
			// 是周，月志的情况下
			String[] weLogInfo=workLog.getContent().split("\\|");
			if(weLogInfo.length>0){
				request.setAttribute("weLogInfo", weLogInfo);
			}
			return "weekOryueLogInfo";
		}
	}

	/**
	 * 确认查看
	 */
	public String seeReply() 
	{
		// 获得确认查看的日志
		String strId = request.getAttribute("id").toString();
		int id = 0;
		if (null != strId) {
			id = Integer.parseInt(strId);
		}
		WorkLog wLog = workLogBussiness.getById(id);

		// 设置标示为已查看
		wLog.setIsView(2);

		try {
			// 确认查看 （修改对象）
			workLogBussiness.updateObj(wLog);
			return "addSuccess";
		} catch (Exception e) {
			request.setAttribute("errorMsg", "确认查看操作失败,请重试！");
			return "no";
		}
		
	}

	/**
	 * 跳转至添加周志添加页面还是月志添加页面
	 * 
	 * @return string result
	 */
	public String goAdd() {
		String mark = request.getParameter("mark");// 拿到是周还是月、日的日志
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) 
		{
			return "no";
		}

		// 拿出所有自己的日志 判断是否写了日日志
		 if(mark!=null && mark.equals("0"))
		 {
			 String hql = "From WorkLog as tb where tb.employeeByEmpId = " +
			 loginEmp.getId() + " and type=0 order by id desc";
			 List<WorkLog> wLogList = workLogBussiness.exeHql(hql);
			 //判断今天是否写过日志了
			 for (WorkLog workLog : wLogList) {
			 String recordTime =
			 TimePattern.doDateTime(TimePattern.doStringTime(workLog.getRecordTime()));
			 String nowTime = TimePattern.doDateTime(new Date());
			 if(recordTime == nowTime || recordTime.equals(nowTime)){
			 request.setAttribute("errorMsg", "您今天已经写过了日志，一天只能写一篇！谢谢合作。");
			 return "logPrompt";
			 }
			 }
		 }

		// 得到当前时间
		Calendar calendar = Calendar.getInstance();// 此时打印它获取的是系统当前时间
		calendar.add(Calendar.DATE, 0); // 得到当天
		String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar
				.getTime());
		// 拿出今日任务
		String hqlMission = "From MissionEmp me where me.mission.cycleType in (0,5) and me.employee = "
				+ loginEmp.getId().toString()
				+ " and me.buildTime like '%"
				+ todayDate + "%'";
		List<MissionEmp> misList = workLogBussiness.exeHql(hqlMission);

		// 拿出自定义日计划
		String hqlPlan = "From Scheduleplan tb where tb.endtime like '%"
				+ todayDate + "%' and tb.plantype = 0 and tb.employee.id = "
				+ loginEmp.getId().toString();
		List<Scheduleplan> planList = workLogBussiness.exeHql(hqlPlan);
		
		//拿出昨天定义的日计划
		SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");		
		Date beginDate = new Date();	
		Calendar date = Calendar.getInstance();	
		date.setTime(beginDate);	
		date.set(Calendar.DATE, date.get(Calendar.DATE) - 1);	
		String yesterday = dft.format(date.getTime());
		hqlPlan = "From Scheduleplan tb where tb.endtime like '%"
			+ yesterday + "%' and tb.plantype = 0 and tb.employee.id = "
			+ loginEmp.getId().toString();
	   List<Scheduleplan> yesterdayPlanList = workLogBussiness.exeHql(hqlPlan);
	   
		// 拿出日程记录
		String hqlWork = "From Scheduleplan tb where tb.endtime like '%"
				+ todayDate + "%' and tb.plantype = 5 and tb.employee.id = "
				+ loginEmp.getId().toString();
		List<Scheduleplan> workList = workLogBussiness.exeHql(hqlWork);

		// 拿出今日操作动态记录 
		String hqlRecord = "From Executerecord tb where tb.executeTime like '%"
				+ todayDate + "%' and tb.employee.id = "
				+ loginEmp.getId().toString();
		List<Executerecord> recordList = workLogBussiness.exeHql(hqlRecord);
		
		// 部门列表
		String depthql="from Department where id not in(0,1,28,29) and delflag=0";
		List<Department> deptlist=workLogBussiness.exeHql(depthql);
		
		//登录的员工
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		//当前时间
		Date now=new Date();
        String nowstr=dateFormat2.format(now);
		// 查询当前人的任务
		String hqlrenwu="from NewTask where flag=0 and emp.id="+employee.getId()+" and (begintime<='"+nowstr+"' and endtime>='"+nowstr+"') order by id desc";
		List<NewTask> nt=workLogBussiness.exeHql(hqlrenwu);
		request.getSession().setAttribute("newTask", nt);
		//System.out.println(nt.get(0).getFunction().getNewProject().getProjectname());
		request.setAttribute("yesterdayPlanList", yesterdayPlanList);
		request.setAttribute("misList", misList);
		request.setAttribute("workList", workList);
		request.setAttribute("planList", planList);
		request.setAttribute("recordList", recordList);
		request.setAttribute("deptlist", deptlist);
		
		if (mark!=null && mark.equals("1")) {
			return "goAddWeek";
		} else if (mark!=null && mark.equals("2")) {
			return "goAddMonth";
		}
		return "goAdd";
	}

	/**
	 * 条件查询(暂未使用)
	 * 
	 * @return
	 */
	public String siftQuery() {

		// 拿到条件
		Object objIsView = request.getAttribute("isView");
		int isView = -1;
		if (null != objIsView) {
			isView = Integer.parseInt(objIsView.toString());
		}

		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}

		// 自定义查询
		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId();
		if (isView != -1) {
			hql += " and tb.isView = " + isView;
		}

		hql += " order by id desc";

		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, 1, 15, null);
		HttpSession session = request.getSession();
		request.setAttribute("pages", pages);
		session.setAttribute("workList", pages.getPageList());
		return null;
	}

	/**
	 * 统计数量
	 * 
	 * @return
	 */
	public String selctNum() {
		String yue = request.getParameter("yue");
		String type = request.getParameter("type");
		String empid = request.getParameter("empid");
		HttpSession session = request.getSession();
		String strPageNo = request.getParameter("pageNo");
		String hql = "";
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		if (strPageNo == null) {
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
					"yyyy");
			Date now = new Date();
			String strDate = dateFormat.format(now);// 当前日期
			String time = "";
			if (yue != null && yue.equals("") == false) {
				time = strDate + "-" + yue + "-";
			}

			hql = "From WorkLog  where type=" + Integer.parseInt(type)
					+ " and  recordTime like '%" + time + "%' ";
			if (empid != null && !empid.equals("")) {
				hql += " and employeeByEmpId.id=" + empid + " ";
			}
			hql += " order by id desc";
		} else {

			// 执行分页查询
			String hql1 = (String) session.getAttribute("workkkhql");
			if (hql1 != null) {
				hql = hql1;
			}
		}
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 50, null);
		session.setAttribute("workkkhql", hql);
		request.setAttribute("pages", pages);
		try {
			if (pages != null) {
				this.getArrList(pages);
			}
		} catch (NullPointerException e) {

		}
		return "allList";

	}

	// 数据封装
	public void getArrList(Pages p) { // ////////////////////////////////////////
		List list = new ArrayList();
		String stri = null;
		for (Iterator iter = p.getPageList().iterator(); iter.hasNext();) {
			WorkLog ps = (WorkLog) iter.next();
			Map map = new HashMap();
			map.put("code", ps.getId());
			if (ps.getType() == 0) {
				stri = "工作日志";
			} else if (ps.getType() == 1) {
				stri = "工作周志";
			} else {
				stri = "工作月志";
			}
			map.put("typed", stri);
			map.put("empname", ps.getEmployeeByEmpId().getName());
			map.put("partname", ps.getEmployeeByEmpId().getDepartment()
					.getName());
			map.put("retime", ps.getRecordTime());
			if (ps.getIsView() == 0) {
				stri = "未批注";
			} else if (ps.getIsView() == 1) {
				stri = "新批注";
			} else {
				stri = "已查看";
			}
			map.put("isview", stri);
			list.add(map);
		}
		request.getSession().setAttribute("pgList", list);
	}

	// 全部日志列表
	public String allList() {
		
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}

		// 拿到每页放多少条数据
		String strPageCount = request.getParameter("pageCount");
		int pageCount = 50;
		if (null != strPageCount && !"".equals(strPageCount)) {
			pageCount = Integer.parseInt(strPageCount);
		}

		// 拿到当前第几页
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		// 自定义hql语句
		String hql = "From WorkLog as tb where 1 = 1 ";

		/********************* 条件查询 *********************/
		// 判断是否的左边框框的列表和重新条件查询 是就清空session
		String clear = request.getParameter("clear");
		if ("0".equals(clear) || "0" == clear) {
			request.getSession().removeAttribute("isView1");
			request.getSession().removeAttribute("selectDate1");
		}

		// 拿到session值 view是否进行了条件查询
		Object objIsViewSe = request.getSession().getAttribute("isView1");
		Object objSelectDateSe = request.getSession().getAttribute(
				"selectDate1");

		// 查看批注的类型和日志添加的时间
		int isView = -1;
		String selectDate = null;

		// 判断session中是否有值
		if (null != objIsViewSe) {
			isView = Integer.parseInt(objIsViewSe.toString());
		} else if (null == objIsViewSe) {

			// 拿到页面传过来的条件
			Object objIsView = request.getAttribute("isView");
			if (null != objIsView) {
				isView = Integer.parseInt(objIsView.toString());
				request.getSession().setAttribute("isView1", isView);
			}
		}
		// 如果是-1 就是查询全部 不是查询相应的
		if (isView != -1) {
			hql += " and tb.isView = " + isView;
		}

		// 如果Session不为空
		if (null != objSelectDateSe) {
			selectDate = objSelectDateSe.toString();
			hql += " and tb.recordTime like '%" + selectDate + "%' ";
		} else if (null == objSelectDateSe) {

			// 如果session为空，再拿到页面传过来的日期
			Object objSelectDateRe = request.getParameter("selectDate");
			if (null != objSelectDateRe) {
				selectDate = objSelectDateRe.toString();
				hql += " and tb.recordTime like '%" + selectDate + "%' ";
				request.getSession().setAttribute("selectDate1", selectDate);
			}
		}
		/************************************************/
		hql += " order by id desc";

		// 执行分页查询
		Pages pages = workLogBussiness
				.exeHqlPages(hql, pageNo, pageCount, null);

		request.setAttribute("pages", pages);
		request.setAttribute("mark", "0");
		if (pages != null) {
			this.getArrList(pages);
		}
		if(request.getParameter("potal")!=null){//新的potal系统
			return "newallList";
			
			
			
		}else{
		return "allList";
		}
	} // //////////////////////////////////////////////////////

	/**
	 * 查询日日志
	 * 
	 * @return
	 */
	public String selectOtherDay() {
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
				+ empposition.getWorkposition().getDepartment().getId() + ")");
		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=0 order by id desc";

		int intPermissionGrade = Integer.parseInt(loginEmp.getGroups()
				.getPermissionGrade());

		// 自定义hql语句

		// 判断是否为最高权限0 是就可以看到所有,
//		if (intPermissionGrade == 0) {
//			hql = "from WorkLog tb where 1 = 1 ";
//		} else {
//			hql = "from WorkLog tb where 1 = 1 and (tb.employeeByEmpId.groups.permissionGrade > "
//					+ loginEmp.getGroups().getPermissionGrade()
//					+ " and tb.employeeByEmpId.department.id in ("
//					+ sonIds
//					+ ")) and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
//		}
		
		if (intPermissionGrade == 0) {
			hql = "from WorkLog tb where 1 = 1 and type=0 ";
		} else {
			hql = "from WorkLog tb where 1=1  and  tb.employeeByEmpId.department.id in ("
					+ sonIds
					+ ") and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
		}
		
		hql += "and type=0  order by id desc";
		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		session.setAttribute("workList", pages.getPageList());
		session.setAttribute("LogType",0);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 0);
		return "otherList";
	}

	/**
	 * 查询全部potal日日志
	 * 
	 * @return
	 */
	public String selectallOtherDay() {
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
				+ empposition.getWorkposition().getDepartment().getId() + ")");
		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=0 order by id desc";

		int intPermissionGrade = Integer.parseInt(loginEmp.getGroups()
				.getPermissionGrade());

		// 自定义hql语句

		// 判断是否为最高权限0 是就可以看到所有 
		//去掉工作组
//		if (intPermissionGrade == 0) {
//			hql = "from WorkLog tb where 1 = 1 ";
//		} else {
//			hql = "from WorkLog tb where 1 = 1 and (tb.employeeByEmpId.groups.permissionGrade > "
//					+ loginEmp.getGroups().getPermissionGrade()
//					+ " and tb.employeeByEmpId.department.id in ("
//					+ sonIds
//					+ ")) and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
//		}
		
		if (intPermissionGrade == 0) {
			hql = "from WorkLog tb where 1 = 1 and type=0 ";
		} else {
			hql = "from WorkLog tb where 1=1  and  tb.employeeByEmpId.department.id in ("
					+ sonIds
					+ ") and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
		}
		
		hql += "and type=0  order by id desc";
		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		session.setAttribute("workList", pages.getPageList());
		session.setAttribute("LogType",0);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 0);
		return "otherList";
	}

	/**
	 * 查询他人周日志
	 * 
	 * @return
	 */
	public String selectOtherMonth() {
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
				+ empposition.getWorkposition().getDepartment().getId() + ")");
		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=0 order by id desc";

		int intPermissionGrade = Integer.parseInt(loginEmp.getGroups()
				.getPermissionGrade());

		// 自定义hql语句

		// 判断是否为最高权限0 是就可以看到所有
		//去掉工作组
//		if (intPermissionGrade == 0) {
//			hql = "from WorkLog tb where 1 = 1 ";
//		} else {
//			hql = "from WorkLog tb where 1 = 1 and (tb.employeeByEmpId.groups.permissionGrade > "
//					+ loginEmp.getGroups().getPermissionGrade()
//					+ " and tb.employeeByEmpId.department.id in ("
//					+ sonIds
//					+ ")) and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
//		}
//		
		
		if (intPermissionGrade == 0) {
			hql = "from WorkLog tb where 1 = 1 and type=0 ";
		} else {
			hql = "from WorkLog tb where 1=1  and  tb.employeeByEmpId.department.id in ("
					+ sonIds
					+ ") and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
		}
		hql += "and type=1  order by id desc";
		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		
		session.setAttribute("workList", pages.getPageList());
		session.setAttribute("LogType",1);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 1);
		return "otherList";
	}

	/**
	 * 查询周日志
	 * 
	 * @return
	 */
	public String selectOtherWeek() {
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
				+ empposition.getWorkposition().getDepartment().getId() + ")");
		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=0 order by id desc";

		int intPermissionGrade = Integer.parseInt(loginEmp.getGroups()
				.getPermissionGrade());

		// 自定义hql语句

		// 判断是否为最高权限0 是就可以看到所有
		//去掉工作组
//		if (intPermissionGrade == 0) {
//			hql = "from WorkLog tb where 1 = 1 ";
//		} else {
//			hql = "from WorkLog tb where 1 = 1 and (tb.employeeByEmpId.groups.permissionGrade > "
//					+ loginEmp.getGroups().getPermissionGrade()
//					+ " and tb.employeeByEmpId.department.id in ("
//					+ sonIds
//					+ ")) and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
//		}
		if (intPermissionGrade == 0) {
			hql = "from WorkLog tb where 1 = 1 and type=0 ";
		} else {
			hql = "from WorkLog tb where 1=1  and  tb.employeeByEmpId.department.id in ("
					+ sonIds
					+ ") and tb.employeeByEmpId.isLeave = 1 and tb.employeeByEmpId.department.id != 1";
		}
		hql += "and type=2  order by id desc";
		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		session.setAttribute("workList", pages.getPageList());
		session.setAttribute("LogType",2);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 2);
		return "otherList";
	}

	/**
	 * 查询周日志
	 * 
	 * @return
	 */
	public String selectMonth() {
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=1 order by id desc";

		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		session.setAttribute("workList", pages.getPageList());
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 1);
		request.setAttribute("logtype", 1);
		return "myList";
	}

	/**
	 * 查询月日志
	 * 
	 * @return
	 */
	public String selectWeek() {
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=2 order by id desc";

		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		HttpSession session = request.getSession();
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		session.setAttribute("workList", pages.getPageList());
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 2);
		request.setAttribute("logtype", 2);
		return "myList";
	}

	/**
	 * 查询他人日日志
	 * 
	 * @return
	 */
	public String selectDay() {
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		String hql = "From WorkLog as tb where tb.employeeByEmpId = "
				+ loginEmp.getId() + " and type=0 order by id desc";
		// 执行分页查询
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 14, null);
		List workList = pages.getPageList();
		Iterator it = workList.iterator();
		while(it.hasNext())
		{
			WorkLog log = (WorkLog) it.next();
			String recordTime  = log.getRecordTime();
			log.setRecordTime(recordTime.substring(5));
		}
		HttpSession session = request.getSession();
		session.setAttribute("workList", pages.getPageList());
		request.setAttribute("pages", pages);
		request.setAttribute("logtype", 0);
		request.setAttribute("mark", 0);
		return "myList";
	}

	/**
	 * 
	 * 模糊查询
	 * 
	 * @return
	 * @throws IOException
	 */

	public String obscureselect() throws IOException {
		// 拿到当前登录员工
		Employee loginEmp = this.getEmp();
		if (null == loginEmp) {
			return "no";
		}
		// 拿到当前第几页
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		String employeeByEmpName1 = request.getParameter("employeeByEmpName");
		String employeeByEmpName = URLDecoder.decode(employeeByEmpName1,
				"UTF-8");
		String department1 = request.getParameter("department");
		String department = URLDecoder.decode(department1, "UTF-8");
		String isView2 = request.getParameter("isView2");
		String sonIds = workLogBussiness.executeSql("select getChildDeptLst("
				+ loginEmp.getDepartment().getId() + ")");
		String hql = " From WorkLog where  employeeByEmpId.department.id in ("
				+ sonIds + ")";
		if (workLog.getId() != null) {
			hql += " and id =" + workLog.getId() + "";
		}
		if ((employeeByEmpName.equals("") == false)
				&& employeeByEmpName != null) {
			hql += "and employeeByEmpId.name like '%" + employeeByEmpName
					+ "%'";
		}
		if (workLog.getType() == 1) {
			hql += "and type=0";
		}
		if (workLog.getType() == 2) {
			hql += "and type=1";
		}
		if (workLog.getType() == 3) {
			hql += "and type=2";
		}
		if ((workLog.getRecordTime().equals("") == false)
				&& workLog.getRecordTime() != null) {
			hql += "and recordTime like '%" + workLog.getRecordTime() + "%'";
		}
		if ((department.equals("") == false) && department != null) {
			hql += "and employeeByEmpId.department.name like '%" + department
					+ "%'";
		}
		if ((isView2.equals("") == false) && isView2 != null
				&& isView2.equals("3") == false) {
			hql += "and isView=" + Integer.parseInt(isView2) + "";
		}
		hql += " order by id desc";
		// 执行分页查询
		HttpSession session = request.getSession();
		// String hql1=(String) session.getAttribute("obscurehql");
		// if(hql1!=null)
		// {
		// hql=hql1;
		// }
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 50, null);
		session.setAttribute("workList", pages.getPageList());
		PropertyEditor property = new PropertyEditor();
		String strr = "";
		String str = "";
		if (pages != null && pages.getPageList().size() > 0) {
			for (int i = 0; i < pages.getPageList().size(); i++) {
				WorkLog wl = new WorkLog();
				wl = (WorkLog) pages.getPageList().get(i);
				str = property.getID("worklog").toString();
				String t = "";
				if (wl.getType() == 0) {
					t = "工作日志";
				}
				if (wl.getType() == 1) {
					t = "工作周志";
				}
				if (wl.getType() == 2) {
					t = "工作月志";
				}
				String isok = "";
				if (wl.getIsView() == 0) {
					isok = "<a href='goAddReplyWorkLog.do?id=" + wl.getId()
							+ "'>添加批注</a>";
				}
				if (wl.getIsView() == 1) {
					isok = "已批注";
				}
				if (wl.getIsView() == 2) {
					isok = "批注已查看";
				}
				str = str.replace("#id#", wl.getId() + "");
				str = str.replace("#type#", t);
				str = str.replace("#employeeName#", wl.getEmployeeByEmpId()
						.getName());
				str = str.replace("#departmentName#", wl.getEmployeeByEmpId()
						.getDepartment().getName());
				str = str.replace("#recordTime#", wl.getRecordTime());
				str = str.replace("#isView#", isok);
				str = str.replace("#StringValue#", "详细信息");
				strr += str;

			}
			pages.setUrl("obscureselect1WorkLog.do");
			strr += "#" + pages.getHtml();
		}
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(strr);
		session.setAttribute("obscurehql", hql);
		return null;
	}

	/**
	 * 模糊查询分页问题
	 */
	public String obscureselect1() {

		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}

		HttpSession session = request.getSession();
		String hql = (String) session.getAttribute("obscurehql");
		Pages pages = workLogBussiness.exeHqlPages(hql, pageNo, 50, null);
		session.setAttribute("workList", pages.getPageList());
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 4);
		return "otherList";
	}

	/***
	 * 分页显示文章信息
	 * 
	 * @return
	 */
	public String splitPages() {

		String hql = "from Department where delflag=0";
		List list = workLogBussiness.exeHql(hql);
		request.setAttribute("deptlist", list);// 设置绑定所有部门信息
		// 得到当前时间的日志消息，以及设置了新部门并判断了有没有写员工日志。
		Date date = new Date();
		date.setDate(date.getDate() + 1);
		String d = dateFormat2.format(date);
		List<Object[]> obj = this
				.getAllWork("2012-01-06", "2012-09-09", -1, -1);
		request.setAttribute("loglist", obj);

		System.out.println("分页了。。。");
		total = obj.size();
		System.out.println("pageCount=" + total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		// 页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page=" + page + "##row=" + row);
		rows = workLogBussiness.printList(obj);
		System.out.println("rows=" + this.rows);
		return "success";
	}

	/**
	 * 按日统计每个员工的日志信息。
	 */
	public String yjPage() {

		String hql = "from Department where delflag=0 and id not in(0,1)";
		List list = workLogBussiness.exeHql(hql);
		request.setAttribute("deptlist", list);// 设置绑定所有部门信息

		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		// 默认是查询当前月的所有员工信息。所有员工信息管理
		int mon = now.getMonth() + 1;// 得到当前月
		int year = now.getYear() + 1900;// 得到当前年份
		// 得到月天总数，星期数。
		getDateCount(mon, year);
		List<Object[]> newlist = workLogByYue(year, mon, -1, -1);
		Pages page = PageBuilder.createPage(pageNo, newlist.size(), 5);// 创建分页。

		// 算出从第几页开始
		int pyno = (pageNo - 1) * 5;
		// 分页后的集合。
		List<Object[]> pageyue = new ArrayList<Object[]>();
		// 封装集合。
		for (int i = pyno; i < pageNo * 5; i++) {
			if (i < newlist.size()) {
				Object[] o = newlist.get(i);
				pageyue.add(o);
			}
		}
		page.setPageLists(pageyue);
		request.setAttribute("loglist", "");
		request.setAttribute("yuelog", page.getPageLists());

		request.setAttribute("pages", page);

		return "logrj";
	}

	/**
	 * 按日统计每个员工的日志信息。
	 */
	public String emplogByRj() {
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if (null != strPageNo && !"".equals(strPageNo)) {
			pageNo = Integer.parseInt(strPageNo);
		}
		String hql = "from Department where delflag=0 and id not in(0,1)";
		List list = workLogBussiness.exeHql(hql);
		request.setAttribute("deptlist", list);// 设置绑定所有部门信息
		// 得到当前时间的日志消息，以及设置了新部门并判断了有没有写员工日志。
		Date date = new Date();
		date.setDate(date.getDate() + 1);
		String d = dateFormat2.format(date);
		List<Object[]> obj = this.getAllWork(nowstr, d, -1, -1);
		Pages page = PageBuilder.createPage(pageNo, obj.size(), 20);// 创建分页。
		// 分页后的集合。
		List<Object[]> pageobj = new ArrayList<Object[]>();
		// 算出从第几页开始
		int pno = (pageNo - 1) * 20;
		// 封装集合。
		for (int i = pno; i < pageNo * 20; i++) {
			if (i < obj.size()) {
				Object[] o = obj.get(i);
				pageobj.add(o);
			}
		}
		page.setPageLists(pageobj);
		request.setAttribute("loglist", page.getPageLists());
		request.setAttribute("yuelog", "");
		request.setAttribute("pages", page);

		return "logrj";
	}

	/*****
	 * 算出员工每个月的实写日志，周志数。
	 */
	public void getDateCount(int mon, int year) {
		int date = 1;
		// 根据年和月得到本月总共有多少天。
		int daysOfMonth = 0;
		switch (mon) {
		case 1:
			daysOfMonth = 31;
			break;
		case 2:
			if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
				daysOfMonth = 29;
			} else
				daysOfMonth = 28;
			break;
		case 3:
			daysOfMonth = 31;
			break;
		case 4:
			daysOfMonth = 30;
			break;
		case 5:
			daysOfMonth = 31;
			break;
		case 6:
			daysOfMonth = 30;
			break;
		case 7:
			daysOfMonth = 31;
			break;
		case 8:
			daysOfMonth = 31;
			break;
		case 9:
			daysOfMonth = 30;
			break;
		case 10:
			daysOfMonth = 31;
			break;
		case 11:
			daysOfMonth = 30;
			break;
		case 12:
			daysOfMonth = 31;
			break;
		default:
			break;
		}
		;
		System.out.println(mon + "月的总天数：" + daysOfMonth);

		int week;// 判断是星期几？
		// 计算星期几！
		if ((mon == 1) || (mon == 2)) {/* 一月、二月当作前一年的十三、十四月 */
			mon += 12;
			year--;
		}
		if ((year < 1752) || ((year == 1752) && (mon < 9))
				|| ((year == 1752) && (mon == 9) && (date < 3)))/* 判断是否在1752年9月3日前 */
			week = (date + 2 * mon + 3 * (mon + 1) / 5 + year + year / 4 + 5) % 7;/*
																				 * 1752年9月3日前的公式
																				 */
		else
			week = (date + 2 * mon + 3 * (mon + 1) / 5 + year + year / 4 - year
					/ 100 + year / 400) % 7;/* 1752年9月3日后的公式 */
		week = week + 1;
		System.out.println("星期：" + week);

		// 本月实写周志数。
		int day = daysOfMonth - ((7 - week) + 1);// 7-week
													// 这里满七了也加一编周志。其中(7-week)要加1应为星期日是不用写的
		int day2 = day / 7; // 余下天数除7算出周志。
		if (day % 7 > 5) {
			weekcount = 1 + day2 + 1;// 余数大于5则周志多一编。
		} else {
			weekcount = day2 + 1;
		}
		// 如果一号是星期天的情况。
		if (7 - week == 0) {
			weekcount = weekcount - 1;
		}
		// 本月实写日志数。
		int rday = daysOfMonth - (7 - week); // 这里少写一编日志。
		int rday2 = rday / 7; // 少写rday2编日志。
		if (rday2 % 7 == 7) {
			datecount = daysOfMonth - 1 - rday2 - 1; // 余数如果为7也少写一编日志。
		} else {
			datecount = daysOfMonth - 1 - rday2;
		}

		System.out.println(year + "年" + mon + "月应写" + weekcount + "编周志，"
				+ datecount + "编日志。");
	}

	/**
	 * 按月统计每个员工的日志信息。查看实写，已写，未写日志，周志，月志数.年使用默认的今年
	 */
	public String emplogByYj() {
		int year = now.getYear() + 1900;// 得到当前年份
		// 得到从前台传过来的月份
		int mon = Integer.parseInt(request.getParameter("mon"));
		// 得到月天总数，星期数。
		if (mon == -1) {
			mon = now.getMonth() + 1;
		}
		getDateCount(mon, year);
		int deptid = Integer.parseInt(request.getParameter("deptid"));
		int empid = Integer.parseInt(request.getParameter("empid"));

		List<Object[]> objs = workLogByYue(year, mon, deptid, empid);
		String str = "";
		for (int i = 0; i < objs.size(); i++) {
			Object[] obj = objs.get(i);
			str += "<tr><td class='tdlast' rowspan='3'>" + obj[0] + "</td>";
			str += "<td class='tdlast' rowspan='3'>" + obj[1] + "</td>";
			str += "<td class='tdlast'>实写</td>";
			str += "<td class='tdlast'><font style='font-weight: bold;' color='blue'>"
					+ datecount + "</font></td>";
			str += "<td class='tdlast'><font style='font-weight: bold;' color='blue'>"
					+ weekcount + "</font></td>";
			str += "<td class='tdlast'><font style='font-weight: bold;' color='blue'>1</font></td>";
			str += "</tr>";
			str += "<tr><td class='tdlast'>已写</td>";
			String dlog = "0";
			String wlog = "0";
			String mlog = "0";
			if (obj[3] != null) {
				dlog = obj[3].toString();
			}
			if (obj[4] != null) {
				wlog = obj[4].toString();
			}
			if (obj[5] != null) {
				mlog = obj[5].toString();
			}
			if (dlog == null || dlog.trim().length() <= 0) {
				dlog = "0";
			}
			if (wlog == null || wlog.trim().length() <= 0) {
				wlog = "0";
			}
			if (mlog == null || mlog.trim().length() <= 0) {
				mlog = "0";
			}
			// 未写日志数量
			int ndlog = datecount - Integer.parseInt(dlog);
			int nwlog = weekcount - Integer.parseInt(wlog);
			int nmlog = 1 - Integer.parseInt(mlog);
			str += "<td class='tdlast'>" + dlog + "</td>";
			str += "<td class='tdlast'>" + wlog + "</td>";
			str += "<td class='tdlast'>" + mlog + "</td>";
			str += "</tr>";
			str += "<tr><td class='tdlast'>未写</td>";
			// <a href='javascript:void(0);' onclick='yueQjDate(this)'
			// id='${obj[2]}'><font style="font-weight: bold;"
			// color="red"><%=ndlog %></font></a></td>
			str += "<td class='tdlast'><a href='javascript:void(0);' onclick='yueQjDate(this)' id='"
					+ obj[2]
					+ "'><font style='font-weight: bold;' color='red'>"
					+ ndlog
					+ "</font></a></td>";
			str += "<td class='tdlast'><font style='font-weight: bold;' color='red'>"
					+ nwlog + "</font></td>";
			str += "<td class='tdlast'><font style='font-weight: bold;' color='red'>"
					+ nmlog + "</font></td>";
			str += "</tr>";
		}

		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	/*********
	 * 封装方法，根据传过来的月份得到这个月的所有员工日志信息。
	 */
	public List<Object[]> workLogByYue(int year, int yue, int deptid, int empno) {
		if (yue == -1) {
			yue = now.getMonth() + 1;
		}
		// 得到这个月写了日志的员工统计。
		String hql = "select count(empId) num,empId,type from workLog where MONTH(recordTime)="
				+ yue + " and YEAR(recordTime)=" + year;
		if (deptid != -1) {
			// 根据部门编号得到部门下的员工信息
			String depthql = "from Employee where delflag=0 and department="
					+ deptid;
			List<Employee> deptemplist = workLogBussiness.exeHql(depthql);
			String empsid = "";
			for (int i = 0; i < deptemplist.size(); i++) {
				Employee e = deptemplist.get(i);
				empsid += "," + e.getId();
			}
			empsid = empsid.replaceFirst(",", "");
			hql += " and empId IN(" + empsid + ") ";
		}
		if (empno != -1) {
			// 根据部门编号得到部门下的员工信息
			Employee em = (Employee) workLogBussiness.getEmp(Employee.class,
					empno);
			hql += " and empId=" + em.getId();
		}
		hql += "  group by empId,type";
		// 封装所有员工日志记录的集合
		List<Object[]> newlist = new ArrayList<Object[]>();
		// 得到所有员工信息。
		String emphql = "from Employee where delflag=0 and isLeave=1 AND department NOT IN(1,0)";
		if (deptid != -1) {
			emphql += " and department=" + deptid;
		}
		if (empno != -1) {
			emphql += " and id=" + empno;
		}
		List emplist = workLogBussiness.exeHql(emphql);
		List emplists = workLogBussiness.exeHql(emphql);
		request.setAttribute("emplist", emplists);// 设置绑定所有员工信息
		// 得到已写日志的员工记录。
		List yuelist = workLogBussiness.exeSQLQuery(hql);
		System.out.println(yuelist.size());
		for (int i = 0; i < yuelist.size(); i++) {
			Object[] obj = (Object[]) yuelist.get(i);
			// 根据员工编号得到员工对象
			int empid = Integer.parseInt(obj[1].toString());
			Employee emp = (Employee) workLogBussiness.getEmp(Employee.class,
					empid);
			// 添加日志信息
			Object[] objects = new Object[5];
			objects[0] = emp.getDepartment().getName(); // 部门名称。
			objects[1] = emp.getName(); // 员工名称
			// 日志类型分日志，月志，周志并得到不同的数量。
			String str = obj[0].toString() + "," + obj[2].toString();
			objects[2] = str;// 日志数量 // 日志数量+日志类型
			objects[3] = emp.getId();// 员工编号
			// 添加到newlist中
			newlist.add(objects);
			// 添加了对象以后，将其从员工列表中删除.
			emplist.remove(emp);
		}
		// 其他的还存在emplist 中的员工信息都是没有写日，周，月志的。
		for (int i = 0; i < emplist.size(); i++) {
			Employee emp = (Employee) emplist.get(i);
			Object[] objects = new Object[5];
			objects[0] = emp.getDepartment().getName(); // 部门名称。
			objects[1] = emp.getName(); // 员工名称
			objects[2] = "-1,-1";// 没写的就是日，周，月志都没写的。
			objects[3] = emp.getId();// 员工编号
			newlist.add(objects);
		}
		// 从新装到一个新的集合里
		List<Object[]> objlist = new ArrayList<Object[]>();
		for (int i = 0; i < emplists.size(); i++) {
			Employee emp = (Employee) emplists.get(i);
			Object[] objs = new Object[6];
			objs[0] = emp.getDepartment().getName();
			objs[1] = emp.getName();
			objs[2] = emp.getId();
			for (int j = 0; j < newlist.size(); j++) {
				Object[] obj = newlist.get(j);
				int empid = Integer.parseInt(obj[3].toString());
				String str = obj[2].toString();
				String[] arr = str.split(",");
				// 0:日志。1：周志。2：月志。-1此员工这个月没有写日，周，月志。
				if (empid == emp.getId() && arr[1].equals("0")) {
					objs[3] = arr[0];
				}
				if (empid == emp.getId() && arr[1].equals("1")) {
					objs[4] = arr[0];
				}
				if (empid == emp.getId() && arr[1].equals("2")) {
					objs[5] = arr[0];
				}
				// -1说明此员工这月什么都没写
				if (empid == emp.getId() && arr[1].equals("-1")) {
					objs[3] = 0;
					objs[4] = 0;
					objs[5] = 0;
				}
			}
			objlist.add(objs);
		}
		System.out.println(objlist.size());
		return objlist;
	}

	/*********
	 * 封装方法，得到所有员工的日志消息
	 */
	public List<Object[]> getAllWork(String time1, String time2, int deptid,
			int empno) {
		// 得到所有部门信息
		String hql = "from Department where delflag=0 and id not in(0,1)";
		List deptlist = workLogBussiness.exeHql(hql);
		// 保存绑定新所有部门
		List<Department> newdept = new ArrayList<Department>();
		// 设置部门名称： 以 福奥科技+研发中心这样的部门显示
		for (int i = 0; i < deptlist.size(); i++) {
			Department dept = (Department) deptlist.get(i);
			if (dept.getParentId() != -1) {
				// 根据部门的父id 得到部门名称。
				String parent = workLogBussiness
						.exeDeptSql("SELECT NAME FROM department WHERE id="
								+ dept.getParentId());
				String deptname = parent + dept.getName();
				dept.setName(deptname);
				newdept.add(dept);
			}
		}
		// 查询今日已写日志的员工
		List list = workLogBussiness.exeWorksql(time1, time2, deptid, empno);
		// 查询所有员工日志，默认是查询今天所有人的日志。
		String emphql = "from Employee where delflag=0 and isLeave=1 AND department NOT IN(1,0)";
		if (deptid != -1) {
			emphql += " and department=" + deptid;
		}
		if (empno != -1) {
			emphql += " and id=" + empno;
		}
		List emplist = workLogBussiness.exeHql(emphql);
		List emplists = workLogBussiness.exeHql(emphql);
		request.setAttribute("emplist", emplists);// 设置绑定所有员工信息

		List<Object[]> newlist = new ArrayList<Object[]>();
		// 所有员工日志查询，将未写的，新部门封装到一个新的集合中
		System.out.println(emplist.size());
		int j = 0;
		for (int i = 0; i < emplist.size(); i++) {

			// 以下是已写日志的集合
			for (; j < list.size(); j++) {
				Object[] obj = new Object[6];
				Integer empid = Integer.parseInt(list.get(j).toString());
				Employee writeemp = (Employee) workLogBussiness.getEmp(
						Employee.class, empid);
				// 将值封装到新的集合中
				obj[0] = writeemp.getId();
				obj[1] = writeemp.getName();
				obj[2] = writeemp.getPlace();// 职位
				obj[3] = writeemp.getDepartment().getName();
				obj[4] = 2;// 0未写1，警告，2已写，因为这是今天的因此是警告
				// 得到今天的时间判断此员工今天有没有请假。
				List leavelist = workLogBussiness.getLeavesimpleByEmpid(empid,
						time1);
				if (leavelist.size() > 0) {
					obj[5] = 1;// 添加请假字段
				} else {
					obj[5] = 0;// 添加请假字段
				}

				newlist.add(j, obj);
				// 已写日志添加到集合了以后，将其从集合里面移除。
				emplist.remove(writeemp);
				System.out.println(emplist.size());
			}
			if (emplist.size() > 0) {
				Object[] obj = new Object[6];
				// 将值封装到新的集合中
				Employee emp = (Employee) emplist.get(i);
				obj[0] = emp.getId();
				obj[1] = emp.getName();
				obj[2] = emp.getPlace();// 职位
				obj[3] = emp.getDepartment().getName();
				if (time1.equals(nowstr)) {
					obj[4] = 1;// 0未写1，警告，2已写，因为这是今天未写的因此是警告
				} else {
					obj[4] = 0;// 0未写1，警告，2已写
				}
				// 得到今天的时间判断此员工今天有没有请假。
				List leavelist = workLogBussiness.getLeavesimpleByEmpid(emp
						.getId(), time1);
				if (leavelist.size() > 0) {
					obj[5] = 1;// 添加请假字段
				} else {
					obj[5] = 0;// 添加请假字段
				}
				newlist.add(j++, obj);
			}
		}

		return newlist;
	}

	/****
	 * 根据前台传过来的条件查询统计日志。
	 */
	@SuppressWarnings("deprecation")
	public String tjrz() {

		String logtime = request.getParameter("logtime");
		int deptid = Integer.parseInt(request.getParameter("deptid"));
		int empid = Integer.parseInt(request.getParameter("empid"));
		List<Object[]> objlist = new ArrayList<Object[]>();
		if (logtime.trim().length() > 0 && deptid != -1 && empid != -1) {
			try {
				Date d = dateFormat2.parse(logtime);
				d.setDate(d.getDate() + 1);
				String logtime2 = dateFormat2.format(d);
				objlist = this.getAllWork(logtime, logtime2, deptid, empid);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (logtime.trim().length() <= 0 && deptid != -1 && empid == -1) {
			// 得到当前时间的日志消息，以及设置了新部门并判断了有没有写员工日志。
			Date date = new Date();
			date.setDate(date.getDate() + 1);
			String d = dateFormat2.format(date);
			objlist = this.getAllWork(nowstr, d, deptid, -1);
		} else if (logtime.trim().length() > 0 && deptid == -1 && empid != -1) {
			try {
				Date d = dateFormat2.parse(logtime);
				d.setDate(d.getDate() + 1);
				String logtime2 = dateFormat2.format(d);
				objlist = this.getAllWork(logtime, logtime2, -1, empid);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (logtime.trim().length() > 0 && deptid != -1 && empid == -1) {
			try {
				Date d = dateFormat2.parse(logtime);
				d.setDate(d.getDate() + 1);
				String logtime2 = dateFormat2.format(d);
				objlist = this.getAllWork(logtime, logtime2, deptid, empid);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (logtime.trim().length() <= 0 && empid != -1) {
			Date date = new Date();
			date.setDate(date.getDate() + 1);
			String d = dateFormat2.format(date);
			objlist = this.getAllWork(nowstr, d, deptid, empid);
		} else if (logtime.trim().length() <= 0 && deptid == -1 && empid == -1) {
			// 得到当前时间的日志消息，以及设置了新部门并判断了有没有写员工日志。
			Date date = new Date();
			date.setDate(date.getDate() + 1);
			String d = dateFormat2.format(date);
			objlist = this.getAllWork(nowstr, d, -1, -1);
		} else if (logtime.trim().length() > 0 && deptid == -1 && empid == -1) {
			try {
				Date d = dateFormat2.parse(logtime);
				d.setDate(d.getDate() + 1);
				String logtime2 = dateFormat2.format(d);
				objlist = this.getAllWork(logtime, logtime2, -1, -1);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			String str = "";
			for (int i = 0; i < objlist.size(); i++) {
				Object[] obj = objlist.get(i);
				String imgstr = "";
				int jb = Integer.parseInt(obj[4].toString());
				if (jb == 0) {
					imgstr = "<img src=" + request.getContextPath()
							+ "/img/x.jpg width='25' height='25'></img>";
				}
				if (jb == 1) {
					imgstr = "<img src=" + request.getContextPath()
							+ "/img/quan.jpg width='25' height='25'></img>";
				}
				if (jb == 2) {
					imgstr = "<img src=" + request.getContextPath()
							+ "/img/gou.jpg width='25' height='25'></img>";
				}
				String openinfo = "";
				if (jb != 2) {
					int qj = Integer.parseInt(obj[5].toString());
					if (qj == 1) {
						// <a href="javascript:void(0);" onclick="qjinfo(this)"
						// id="${obj[0]}" class="tda">查看请假原因</a>
						openinfo += "<a href='javascript:void(0);' onclick='qjinfo(this)' id='"
								+ obj[0] + "' class='tda'>查看请假原因</a>";
					} else {
						openinfo += "<font style='font-weight: bold;' color='red'>没写日志！</font>";
					}
				}
				str += "<tr><td class='tdlast'>" + obj[1]
						+ "</td><td class='tdlast'>" + obj[3]
						+ "</td><td class='tdlast'>" + obj[2]
						+ "</td><td class='tdlast'>" + imgstr
						+ "</td><td class='tdlast'>" + openinfo + "</td></tr>";
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/******
	 * 查看员工请假详情。
	 */
	public String empByQjInfo() {
		int empid = Integer.parseInt(request.getParameter("empid"));
		String qjtime = request.getParameter("qjtime");
		if (qjtime.trim().length() <= 0 || qjtime == null) {
			qjtime = nowstr;
		}
		List leavelist = workLogBussiness.getLeavesimpleByEmpid(empid, qjtime);
		for (int i = 0; i < leavelist.size(); i++) {
			Leavesimple leave = (Leavesimple) leavelist.get(i);
			Employee leaveemp = (Employee) workLogBussiness.getEmp(
					Employee.class, leave.getEmpid());
			leave.setTemp(leaveemp.getName());
			leavelist.set(i, leave);
		}
		System.out.println(leavelist.size());
		request.setAttribute("leavelist", leavelist);
		return "qjinfo";
	}

	/******
	 * 根据月统计查看员工未写日志的请假天数。
	 */
	public String yueQjDate() {
		int empid = Integer.parseInt(request.getParameter("empid"));
		int yue = Integer.parseInt(request.getParameter("yue"));
		if (yue == -1) {
			yue = now.getMonth() + 1;
		}
		List leavelist = workLogBussiness.yueQjDate(empid, yue);
		for (int i = 0; i < leavelist.size(); i++) {
			Leavesimple leave = (Leavesimple) leavelist.get(i);
			Employee leaveemp = (Employee) workLogBussiness.getEmp(
					Employee.class, leave.getEmpid());
			leave.setTemp(leaveemp.getName());
			leavelist.set(i, leave);
		}
		System.out.println(leavelist.size());
		request.setAttribute("leavelist", leavelist);
		return "yueqjdate";
	}

	/**
	 * 上一篇日志
	 * 
	 * @return
	 * @throws IOException
	 */
	public void selectTopWork() throws IOException {
		String workId = request.getParameter("workId");
		System.out.println(workId);
		ArrayList list = new ArrayList();
		HttpSession session = request.getSession();
		list = (ArrayList) session.getAttribute("workList");
		System.out.println(list.size());
		int i;
		int j = 0;
		for (i = 0; i < list.size(); i++) {
			if (i != 0) {
				if (((WorkLog) list.get(i)).getId() == Integer.parseInt(workId)) {
					j = 1;
					break;
				}
			}
		}
		if (j == 0) {
			response.getWriter().print("0");
		} else {
			response.setCharacterEncoding("utf-8");
			String strr = ((WorkLog) list.get(i - 1)).getId() + "@"
					+ ((WorkLog) list.get(i - 1)).getContent();
			response.getWriter().print(strr);
		}

	}

	/**
	 * 下一条日志selectDownWork
	 * 
	 * @return
	 */

	public void selectDownWork() throws IOException {
		String workId = request.getParameter("workId");
		System.out.println(workId);
		ArrayList list = new ArrayList();
		HttpSession session = request.getSession();
		list = (ArrayList) session.getAttribute("workList");
		System.out.println(list.size());
		int i;
		int j = 0;
		for (i = 0; i < list.size(); i++) {
			if (i != list.size() - 1) {
				if (((WorkLog) list.get(i)).getId() == Integer.parseInt(workId)) {
					j = 1;
					break;
				}
			}
		}
		if (j == 0) {
			response.getWriter().print("1");
		} else {
			response.setCharacterEncoding("utf-8");
			String strr = ((WorkLog) list.get(i + 1)).getId() + "@"
					+ ((WorkLog) list.get(i + 1)).getContent();
			response.getWriter().print(strr);
		}

	}

	// 记录动态
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	// 日志business层
	public WorkLogBussiness getWorkLogBussiness() {
		return workLogBussiness;
	}

	public void setWorkLogBussiness(WorkLogBussiness workLogBussiness) {
		this.workLogBussiness = workLogBussiness;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public void exportLoggers() {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment;filename=allSalary.xls");
		System.out.println("进来打印了。。。。");
		List rows = (List) request.getSession().getAttribute("pgList");
		try {
			if ("part".equals(oper)) {
				this.getExcel(response.getOutputStream(), rows);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "打印失败";
		}

	}

	public boolean getExcel(OutputStream fout, List list) {

		try {

			HSSFWorkbook wbook = new HSSFWorkbook();

			HSSFSheet sheet = wbook.createSheet("全部日志");

			setTrainTitle(sheet);

			setTrainData(list, sheet);
			// FileOutputStream fout =new FileOutputStream("");
			// ByteArrayOutputStream by=;
			wbook.write(fout);
			fout.flush();
			fout.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public void setTrainTitle(HSSFSheet sheet) {
		List<String> tlist = new ArrayList<String>();
		tlist.add("日志编号");
		tlist.add("日志类型");
		tlist.add("员工名称");
		tlist.add("所属部门");
		tlist.add("提交时间");
		tlist.add("领导批注");
		HSSFRow row = sheet.createRow(0);
		int i = 0;
		for (String s : tlist) {
			HSSFCell cell = row.createCell(i);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(s);
			i++;
		}
	}

	public void setTrainData(List list, HSSFSheet sheet) {
		List tlist = list;
		System.out.println("listmap=" + tlist);
		for (int i = 1; i < (tlist.size() + 1); i++) {
			HSSFRow row = sheet.createRow(i);
			Map map = (Map) tlist.get((i - 1));
			List<Object> ins = this.getAllMap(map, i);
			// 调用getParamsValue方法将一个实体转换成一个集合**
			for (int j = 0; j < ins.size(); j++) {
				HSSFCell cell = row.createCell(j);
				// 设置单元格为字符串类型
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				// 设置内容
				String value = ins.get(j) == null ? "无" : ins.get(j).toString();
				// 单元格赋值
				cell.setCellValue(value);
				// 设置表格宽度
				sheet.setColumnWidth(j, 6000);
			}
		}
	}

	public List getAllMap(Map map, int s) {
		List ins = new ArrayList();
		// 每取出一个对象将它封装到集合中
		ins.add(map.get("code"));
		ins.add(map.get("typed"));
		ins.add(map.get("empname"));
		ins.add(map.get("partname"));
		ins.add(map.get("retime"));
		ins.add(map.get("isview"));
		return ins;
	}
	
	/********
	 * 添加日程记事
	 */
	public String addWorkSch(){
		String ntId=request.getParameter("ntId");
		String jingdu=request.getParameter("jingdu");
		try {
			System.out.println(sch.getTmp());
			System.out.println(sch.getWorkcontent());
			System.out.println(sch.getEmployee().getId());
			workLogBussiness.addSch(sch);
			if(ntId!=null&&!ntId.equals("")&&jingdu!=null&&!jingdu.equals(""))
			{
			String hql="from NewTask where id="+Integer.parseInt(ntId)+" and flag=0";
			List<NewTask> obj=workLogBussiness.exeHql(hql);
			if(obj.size()>0)
			{
				NewTask nt=obj.get(0);
				nt.setSchedule(nt.getSchedule()+Integer.parseInt(jingdu));
				workLogBussiness.updateObj(nt);
				
//				NewProject npj=obj.get(0).getFunction().getNewProject();
//				npj.setSchedule(npj.getSchedule()+Integer.parseInt(jingdu));
//				workLogBussiness.updateObj(npj);
			}
			}
			System.out.println("添加成功");
		} catch (Exception e) {
			return "errorPage";
			
		}
		return "addSch";
	}
	/********
	 * 查看日志便签详情
	 */
	public String lookSch(){
		String schid=request.getParameter("schid");
		Scheduleplan sche=(Scheduleplan)workLogBussiness.getEmp(Scheduleplan.class, Integer.parseInt(schid));
		request.setAttribute("sche", sche);
		return "lookSch";
	}
	/********
	 * 领导问询日志
	 */
	public String planEmp(){
		String schid=request.getParameter("schid");
		Scheduleplan sche=(Scheduleplan)workLogBussiness.getEmp(Scheduleplan.class, Integer.parseInt(schid));
		request.setAttribute("sche", sche);
		request.setAttribute("id", request.getParameter("id"));
		request.setAttribute("logno", request.getParameter("logno"));
		return "planemp";
	}
	/********
	 * 根据日志编号找到日志内容
	 */
	public String resultByLid(){
		String logid=request.getParameter("logid");
		WorkLog worklog=(WorkLog) workLogBussiness.getEmp(WorkLog.class,Integer.parseInt(logid));
		try {
			String str="";
			if(worklog.getWorkresult()==null){
				str=worklog.getContent();
			}else if(worklog.getWorkresult().trim().length()<=0){
				str="没有日志内容！";
			}else{
				str=worklog.getWorkresult();
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
		}
		return null;
	}
	
	/**********
	 * 查询这个人这个星期写的日志 
	 */
	public String addWeek(){
		// 根据当前登录人与当前时间拿出今日操作动态记录，操作记录要改
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		Date now=new Date();
		int year=now.getYear()+1900;
		int month=now.getMonth();
		int date=now.getDate();
		date=31;
		int jdate=date;
		Integer[] day=new Integer[7];
		for(int i=0;i<date;i++){
			day[i]=jdate--;
			if(i>=6){
				break;
			}
		}
		String str="<div><ul>";
		for(int i=0;i<day.length;i++){
			if(day[i]!=null){
				String hql="FROM WorkLog WHERE type=0 and employeeByEmpId.id="+employee.getId()+" and YEAR(recordTime)='"+year+"' AND MONTH(recordTime)="+month+" AND DAY(recordTime)="+day[i];
				List list= workLogBussiness.exeHql(hql);
				if(list!=null && list.size()>0){
					WorkLog log=(WorkLog)list.get(0);
					String rs=log.getWorkresult().substring(0,20)+"...";
					str+="<li>"+rs+"&nbsp;&nbsp;"+log.getRecordTime()+"</li>";
				}
			}
		}
		str+="</ul></div>";
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
		}
		return null;
	}
	/**
	 * 批量批阅里单个对日志进行批阅的功能。
	 */
	public void reply()
	{
		// 拿到当前登录员工
		try 
		{
			Employee loginEmp = this.getEmp();
			if (null == loginEmp)
			{
				response.getWriter().print(1);
				return;
			}

			// 获得需要添加批注的日志
			String strId = request.getAttribute("id").toString();
			int id = 0;
			if (null != strId) {
				id = Integer.parseInt(strId);
			}
			
			double grade = 0;
			//得到上级评分
			if(!"".equals(request.getParameter("mark"))&&request.getParameter("mark")!=null)
			{
				grade = Double.parseDouble(request.getParameter("mark"));
			}
			
			WorkLog wLog = workLogBussiness.getById(id);

			// 获得批注内容
			String reply = URLDecoder.decode(URLDecoder.decode(request
					.getParameter("reply"), "UTF-8"), "UTF-8");
			
			String audid  ="";
			//String audid = request.getParameter("audid");
			
			String audhql = "From AuditingOrderTab where 1=1 and handlestate = 1 and auditingFlag =0 and (orderNo like 'GZRZ%' or orderNo like 'GZZJ%' or orderNo like 'GZYJ%')  and employees = '"
				+ loginEmp.getId().toString() + "' ";
			List list = workLogBussiness.exeHql(audhql);
			
			if(workLog.getLogNo() != null)
			{
				for(int i = 0; i < list.size();i++)
				{
					AuditingOrderTab a = (AuditingOrderTab) list.get(i);
					
					if(a.getOrderNo().trim().equals(workLog.getLogNo().trim()))
					{
						 audid  = a.getId().toString().trim();
					}
				}
			}
			
			if (audid == null || audid.equals("")) 
			{
				
				// 判断取的最大auditingOrder
				String hql2 = " From AuditingOrderTab where 1=1  and orderNo = '"
						+ wLog.getLogNo() + "' order by auditingOrder desc";
				List list2 = workLogBussiness.exeHql(hql2);
				int maxOrder = 0;
				if (list2 != null && list2.size() > 0) {
					maxOrder = ((AuditingOrderTab) list2.get(0))
							.getAuditingOrder();
				}
				
				// 插入审批记录
				AuditingOrderTab aot = new AuditingOrderTab();

				aot.setAuditingFlag(1);
				aot.setAuditingOrder(maxOrder + 1);
				aot.setDepartment(loginEmp.getDepartment());
				aot.setOrderNo(wLog.getLogNo());
				
				aot.setMark("0");// 默认0一人审核
				
				aot.setEmployees(loginEmp.getId().toString());
				aot.setHandlestate(2);
				TimePattern tp = new TimePattern();
				Date date = new Date();
				String nowtime = tp.doTimeDf3(date);
				aot.setIncepttime(Timestamp.valueOf(nowtime));
				aot.setEmployeeByInceptemp(loginEmp);
				aot.setTmp(StringUtil.textToHtml2(reply.replace(
						"<IMG src=\"face/", "<IMG src=\""
								+ request.getContextPath()
								+ "/SinaEditor/Edit/face/")));
				aot.setAuditingtime(Timestamp.valueOf(TimePattern
						.doTimeDf3(date)));	
				aot.setGrade(grade);
				audBussiness.addAuditingOrder(aot);
				
				// 更改日志状态为新批注
				wLog.setIsView(1);
				
			 /* String str  = wLog.getReplyContent().replace(
						"<IMG src=\"face/",
						"<IMG src=\"" + request.getContextPath()
								+ "/SinaEditor/Edit/face/");*/
				
				if(wLog.getReplyContent()!=null)
				{
					wLog.setReplyContent(StringUtil.textToHtml2(wLog
							.getReplyContent().replace(
									"<IMG src=\"face/",
									"<IMG src=\"" + request.getContextPath()
											+ "/SinaEditor/Edit/face/")));
				}
				else
				{
					wLog.setReplyContent(reply);
					wLog.setReplyTime(nowtime);
					wLog.setEmployeeByReplier(loginEmp);
				}
				workLogBussiness.addReply(wLog);
				response.getWriter().print(0);

			} 
			else
			{
				// 修改审批记录
				// 为对象设置值
				wLog.setReplyContent(reply);
				wLog.setEmployeeByReplier(loginEmp);
				wLog.setReplyTime(TimePattern.doTimeDf3(new Date()));
				wLog.setIsView(1);

				// 添加批注 （修改对象）
				boolean result = workLogBussiness.addReply(wLog);
				
				// 插入审批
				String hql = " update AuditingOrderTab set tmp ='" + reply
						+ "',handlestate = 2 , auditingFlag =1,auditingtime='"
						+ TimePattern.doTimeDf3(new Date()) +",grade ="+grade+ "' where id= "
						+ audid;
				audBussiness.updatehql(hql);

				if (result == false) {
					request.setAttribute("errorMsg", "添加批注失败,请重试！");
					response.getWriter().print(1);
				} else {
					response.getWriter().print(0);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
