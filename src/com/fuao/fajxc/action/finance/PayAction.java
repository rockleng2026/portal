package com.fuao.fajxc.action.finance;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.finance.PayBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.bussiness.system.impl.AuditingBussinessImpl;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.PaymentLog;
import com.fuao.fajxc.vo.PurOrder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class PayAction implements ServletRequestAware,ModelDriven,ServletResponseAware {

	private PayBussiness paybussiness;
	private HttpServletRequest request;
	private PaymentLog payLog;
	private EmployeeBussiness empBussiness;
	private Object[] ids;
	private HttpServletResponse response;
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	//添加动态记录
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	Cookies ck = new Cookies();
	private AuditingBussiness audBussiness;
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the empBussiness
	 */
	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}

	/**
	 * @param empBussiness the empBussiness to set
	 */
	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	/**
	 * @return the request
	 */
	public HttpServletRequest getRequest() {
		return request;
	}

	/**
	 * @param request the request to set
	 */
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}


	/**
	 * 
	 * 付款单
	 * @return
	 */
	public String select()
	{
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
 		String addhql = "";
		String payNo = request.getParameter("payNo");
		if(payNo!=null&&payNo!="")
		{
			addhql += " and payNo like '%"+payNo+"%'";
		}else{
			payNo = "0";
		}
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String hql = "from PaymentLog where del=0"+addhql ;
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by id desc";
		
		Pages pages = empBussiness.paginationQuery(hql, Integer.parseInt(pageNo), 10, null);
		
		request.setAttribute("pages", pages);
		
		return "success";
	}
	
	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * 显示添加付款单
	 * @return
	 */
	public String addShow()
	{
		String no="FK-"+serial.getSerialNumber();
//        String addhql="";
        //采购单列表
//		List list=payBussiness.selPurOrder(addhql);
		request.setAttribute("FKNo", no);
//		request.getSession().setAttribute("purOrderList", list);
		//付款类型
		Integer superids = PublicMissionType.payMisstype;
		String hql = "from Missiontype as mt where 1=1 and mt.superid ="+ superids;
		List listpayType = empBussiness.selectObect(hql);
		request.setAttribute("listpayType", listpayType);
		return "add";
	}
	
	public PayBussiness getpaybussiness() {
		return paybussiness;
	}

	public void setpaybussiness(PayBussiness paybussiness) {
		this.paybussiness = paybussiness;
	}

	/**
	 * 添加付款单
	 * @return
	 */
	public String add()
	{
	
		payLog.setTemp("0");
		//公共变量业务总监
		Integer  empcheifs= PublicMissionType.empcheif;
		Employee employees =(Employee) this.paybussiness.getobjid(Employee.class, empcheifs);
		payLog.setEmps(employees);
		String purOrderid = request.getParameter("purOrderid");
		PurOrder order = null;
		if(!purOrderid.equals(""))
		{
			String hqlpuroder = "from PurOrder as po where 1=1 and po.id ="+new Integer(purOrderid);
		    order = (PurOrder)empBussiness.selectObect(hqlpuroder).get(0);
		}
		payLog.setPurOrder(order);
		//付款类型
		String missid = request.getParameter("missid");
		Missiontype missiontype = null;
		if(!"".equals(missid) && !"-1".equals(missid))
		{
		 	missiontype =  (Missiontype)empBussiness.getCustomer(Missiontype.class, new Integer(missid));
		}
		payLog.setMissiontype(missiontype);
		PaymentLog pLog = paybussiness.addReturnPaymentLog(payLog);
		if(null != pLog){
			int marker=audBussiness.addAuditingOrder2("FK",payLog.getPayNo(),"PaymentLog",ck.getCookie(request, "filialemark"));
				if(marker==0||marker==2){
					if(null != pLog){
						/*阙超强 14015   添加记录动态信息*/
						//拿到登陆员工用户
						Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
						//添加记录到动态记录表
						if(null != loginEmp){
							Executerecord executerecord = new Executerecord();
							executerecord.setEmployee(loginEmp);
							executerecord.setContent("添加了一个付款单。");
							executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
							executerecord.setEntityId(pLog.getId().toString());
							executerecord.setEntityName("PaymentLog");
							executerecord.setSeenEmpId("");
							executeRecordBussiness.addData(executerecord);
						}
						
						return "select";
					}
					else
						return null;
			}
				else 
					return null;
		}
		else 
			return null;
	}
	
	/**
	 * 
	 * 删除所选付款单
	 */
	public String del()
	{

		boolean flag=paybussiness.delpay(ids);
		try
		{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一些付款单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("PaymentLog");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 单击修改付款单跳转
	 * @return
	 */
	public String updateshow()
	{
		List list1=paybussiness.selPurOrder("");
		request.getSession().setAttribute("purOrderList", list1);
		List list2=empBussiness.selEmps("");
		request.getSession().setAttribute("empList", list2);
		List list=paybussiness.selPay(" and id="+Integer.parseInt(request.getParameter("id")));
		if(list!=null){
			PaymentLog pml=(PaymentLog)list.get(0);
			request.setAttribute("pmlShow", pml);
		}
		request.getSession().setAttribute("purOrderList", list);
		//付款类型
		Integer superids = PublicMissionType.payMisstype;
		String hql = "from Missiontype as mt where 1=1 and mt.superid ="+ superids;
		List listpayType = empBussiness.selectObect(hql);
		request.setAttribute("listpayType", listpayType);
		return "add";
	}
	
	/**
	 * 修改付款单
	 * @return
	 */
	public String edit()
	{
		String purId=request.getParameter("purId");
		String empId=request.getParameter("empL");
		if(!"".equals(purId))
		{
			PurOrder po=(PurOrder) paybussiness.selPurOrder(" and id="+Integer.parseInt(purId)).get(0);
			payLog.setPurOrder(po);
		}
		if(!"".equals(empId) && empId != null)
		{
			Employee emp=empBussiness.oneEmp(Integer.parseInt(empId));	
			payLog.setEmployee(emp);
		}
		
		//付款类型
		String missid = request.getParameter("missids");
		Missiontype missiontype = null;
		if(!"".equals(missid) && !"-1".equals(missid))
		{
			System.out.println(missid);
		 	missiontype =  (Missiontype)empBussiness.getCustomer(Missiontype.class, new Integer(missid));
		}
		payLog.setMissiontype(missiontype);
		
		try {
			payLog.setDefrayMode(URLDecoder.decode(payLog.getDefrayMode(),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		boolean flag=paybussiness.updatePay(payLog);
		try
		{
			if(flag)
			{
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个付款单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(payLog.getId().toString());
					executerecord.setEntityName("PaymentLog");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			}else{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 显示付款单详细信息
	 * @return
	 */
	public String detail()
	{
		//获得付款单Id
		String id=request.getParameter("cid");
		//获得付款单号
		String payNo=request.getParameter("payNo");
		String info = request.getParameter("info");
		
		if(payNo!=null){
			String addhql2 = " and orderNo='"+payNo+"'";
			List audList = audBussiness.someauditingOrder(addhql2);
			request.setAttribute("auditingList", audList);
		}
		//如果是详细信息则跳转到详细信息页面
	if(null != info && ( info == "info" || info.equals("info"))){
		if(id!=null){
			PaymentLog pml = (PaymentLog) paybussiness.selPay(" and id="+Integer.parseInt(id)).get(0);
			
			System.out.println("==="+pml.getEmployee().getId());
			request.setAttribute("pmList", pml);
		
			if(pml.getPayNo() != null){
				String addhql2 = " and orderNo='"+pml.getPayNo()+"'";
				
				List audList = audBussiness.someauditingOrder(addhql2);
		if(null != audList && audList.size()>0){
			
			String depid = ck.getCookie(request, "departmentId");
			
			for(int i=0; i<audList.size(); i++){
				
				AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
				
				if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 ){
					
					//表示未审核
					request.setAttribute("flage", 0);
					
				}else if(aot.getDepartment().getId() == Integer.parseInt(depid)&&
						(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2)){
					
					//表示已经审核
					request.setAttribute("flage", 1);
					
					request.setAttribute("aot", aot);
					
				}
			}
		}
		String empid=ck.getCookie(request, "employeeId");
//		boolean flag=audBussiness.checkemp(pml.getPayNo(), empid);
		
//		if(flag){
//			request.setAttribute("mark", "mark");
//		}
		//当前登入人
		boolean flag1=audBussiness.checkemp1(pml.getPayNo(), empid);
		Employee employee = (Employee)this.request.getSession().getAttribute("emp");
		request.setAttribute("emp", employee);	
		
		if(employee.getId().toString().equals(pml.getEmps().getId().toString()))
			request.setAttribute("quanxian", "quanxian");
		}
			
			
		}
		//各种全局变量
		//业务总监
		request.setAttribute("empcheif", PublicMissionType.empcheif);
		//CEO
		request.setAttribute("empCEO", PublicMissionType.empCEO);
		//CFO
		request.setAttribute("empCFO", PublicMissionType.empCFO);
		//
	}
		return "detail";
	}
	
	/*
	 * 流程(wangxiong@fuao.....)
	 */
	public String updateVerif()
	{
		try {
			boolean falg = false;
			//当前退款的id
			String payid = request.getParameter("payid");
			//审批人
			String empid = request.getParameter("empid");
			//标识状态
			String temp = request.getParameter("temp");
			//客户
			String cusid = request.getParameter("cusid");
			//标识为通过还是拒绝
			String passTemp = request.getParameter("str");
			String isstart = "";
			//判断这个客户是否为vip客户
			if(!"".equals(cusid))
			{
				Customer customer = (Customer) this.paybussiness.getobjid(Customer.class,new Integer(cusid));
				if(customer != null)
				{
					isstart = customer.getCusClass();
					if(!"".equals(isstart) && "1".equals(isstart))
					{
						falg = true;
					}
				}
			}
			
			//通过
			String sql = "update paymentlog set ";
//			if()
			//普通客户提交
			if(empid.equals(PublicMissionType.empcheif.toString()) && temp.equals("0") && falg == false)
			{
//				/业务总监审批 ，提交给CFO审批
				sql+=" auditingState =8 ,empsid = "+PublicMissionType.empCFO+" ,temp ='2' where id="+new Integer(payid);
			}
			//vip客户提交
			if(empid.equals(PublicMissionType.empcheif.toString()) && temp.equals("0") && falg == true)
			{
				sql += " auditingState =8 ,empsid = "+PublicMissionType.empCEO+" ,temp ='1' where id="+new Integer(payid);
			}
			
			//CEO审批(针对vip客户)
			if(empid.equals(PublicMissionType.empCEO.toString()) && temp.equals("1"))
			{
				 sql +=" empsid = "+PublicMissionType.empCFO+" ,temp ='2' where id="+new Integer(payid);
			}
			//CFO审批
			if(empid.equals(PublicMissionType.empCFO.toString()) && temp.equals("2"))
			{
				//普通客户CFO审批//经过一系列的审批，改通过审批
				sql +=" auditingState =1 ,temp ='3' where id="+new Integer(payid);
			}
			int count = this.paybussiness.updateVerif(sql);
			if(count >0)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("2");
			}
			
			//当业务总监、CEO、CFO都全审批了，那就改客户的金额.
			
			
		} catch (Exception e) {
		}
		return null;
	}
	
			
	

	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	public Object getModel() {
		payLog=new PaymentLog();
		return payLog;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
}
