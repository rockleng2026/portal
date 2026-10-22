package com.fuao.fajxc.action.customService;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.SimpleFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.registry.infomodel.User;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.customService.ClientReturnOrderBussiness;
import com.fuao.fajxc.bussiness.impl.customService.ClientReturnOrderBussinessImpl;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.RefundmentLog;
import com.fuao.fajxc.vo.ReturnOrder;
import com.fuao.fajxc.vo.SaleGoods_mids;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class ClientReturnOrderAction implements ModelDriven,ServletRequestAware, ServletResponseAware{

	private ClientReturnOrderBussiness clientReturnOrderBussinessImpl;
	private AuditingBussiness audBussiness;
	private HttpServletResponse response;
	private HttpServletRequest request;
	private RefundmentLog log;
	private SaleOrder so;
	Cookies ck=new Cookies();

	/**
	 * 页面跳转
	 * @return
	 */
	public String skippage()
	{
		String info = request.getParameter("info");		
		String mark = request.getParameter("mark");
		String clientreturnorderid = request.getParameter("clientreturnorderid")==null?"":request.getParameter("clientreturnorderid");
		if(mark.equals("add"))
		{
			FileEveryDaySerialNumber number = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
			String no = "KHTD-";
			no +=number.getSerialNumber(); 
			request.setAttribute("serial", no);
			return "add";
		}
		if(mark.equals("edit"))
		{
			RefundmentLog log = (RefundmentLog)clientReturnOrderBussinessImpl.getObject("RefundmentLog", " and id = "+clientreturnorderid+"").get(0);
			request.setAttribute("retundmentlog", log);
			return "add";
		}
		if(mark.equals("find"))
		{
			RefundmentLog log = (RefundmentLog)clientReturnOrderBussinessImpl.getObject("RefundmentLog", " and id = "+clientreturnorderid+"").get(0);
		
			request.setAttribute("retundmentlog", log);
			
			
			if(null != info && ( info == "info" || info.equals("info"))){
				
				if(log.getClientOrderNum()!=null){
					String addhql2=" and orderNo='"+log.getClientOrderNum()+"'";
					
					List audList=audBussiness.someauditingOrder(addhql2);
					request.setAttribute("auditingList", audList);
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
				}
			}
			String empid=ck.getCookie(request, "employeeId");
			System.out.println("ck::::"+empid);
			boolean flag=audBussiness.checkemp(log.getClientOrderNum(), empid);
			
			if(flag){
				request.setAttribute("mark", "mark");
			}
			boolean flag1=audBussiness.checkemp1(log.getClientOrderNum(), empid);
			if(flag1)
			{
				request.setAttribute("quanxian", "quanxian");
			}
			return "find";
		}
		return "add";
	}
	
	/**
	 * 添加
	 * @return  
	 * @throws UnsupportedEncodingException 
	 */
	public String add() throws UnsupportedEncodingException
	{
		System.out.println("~~~~~~~~~~~~~~~~~~~~~      into add      ~~~~~~~~~~~~~~~~~~~~~~~~");
		//request.setCharacterEncoding("utf-8");
		String saleOrderid = request.getParameter("saleOrderid").toString();
		System.out.println(saleOrderid);
		String declareR = request.getParameter("declareR");
		
		Users users = (Users)clientReturnOrderBussinessImpl.getObject("Users", " and loginName = '"+declareR+"'").get(0);
		System.out.println(users.getCustomerOrEmployeeId());
		Customer customer = (Customer)clientReturnOrderBussinessImpl.getObject("Customer", " and customerId = "+users.getCustomerOrEmployeeId()+"").get(0);
		SaleOrder saleOrder = (SaleOrder)clientReturnOrderBussinessImpl.getObject("SaleOrder", " and id = "+saleOrderid+" and delflag = '0'").get(0);
		Employee employee = (Employee)clientReturnOrderBussinessImpl.getObject("Employee", " and id = "+saleOrder.getEmployee().getId()+"").get(0);
		
		log.setCustomer(customer);
		log.setSaleOrder(saleOrder);
		log.setEmployeeByEmpId(employee);
		log.setDelflag("0");
		log.setApproveState(0);
		
		boolean flag = clientReturnOrderBussinessImpl.addClientReturnOrder(log);
		System.out.println("flag : "+flag);
		
		if(flag)
		{
			int marker=audBussiness.addAuditingOrder2("KHTD",log.getClientOrderNum(),"RefundmentLog",ck.getCookie(request, "filialemark"));
			System.out.println("marker:"+marker);
		}
		
		try 
		{
			if(flag)
			{
					
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 删除
	 * @return
	 */
	public String delete()
	{
		System.out.println("~~~~~~~~~~~~~~~~~~~~~      into delete      ~~~~~~~~~~~~~~~~~~~~~~~~");
		String id = request.getParameter("id");
		RefundmentLog log = (RefundmentLog)clientReturnOrderBussinessImpl.getObject("RefundmentLog", " and id = "+id+"").get(0);
		log.setDelflag("1");
		
		boolean flag = clientReturnOrderBussinessImpl.delClientReturnOrder(log);
		System.out.println("flag : "+flag);
		
		try 
		{
			if(flag)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 修改
	 * @return
	 */
	public String update()
	{
		System.out.println("~~~~~~~~~~~~~~~~~~~~~      into update      ~~~~~~~~~~~~~~~~~~~~~~~~");
		RefundmentLog rlog = (RefundmentLog)clientReturnOrderBussinessImpl.getObject("RefundmentLog", " and id = "+log.getId()+"").get(0);
		
		rlog.setReturnTime(log.getReturnTime());
		rlog.setReturnReason(log.getReturnReason());
		rlog.setReturnLimitTime(log.getReturnLimitTime());
		rlog.setAccount(log.getAccount());
		rlog.setMoney(log.getMoney());
		rlog.setApproveState(log.getApproveState());
		rlog.setApproveTime(log.getApproveTime());
		rlog.setFinancingState(log.getFinancingState());
		
		boolean flag = false;
		if(rlog.getId()>0)
		{
			flag = clientReturnOrderBussinessImpl.editClientReturnOrder(rlog);
		}
		
		System.out.println("flag : "+flag);
		try 
		{
			if(flag)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 获取所有客户退单列表
	 * @return
	 */
	public String getAllList()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String clientreturnorder = request.getParameter("clientreturnorder")==null?"":request.getParameter("clientreturnorder");
		String selectapprove = request.getParameter("selectapprove")==null?"":request.getParameter("selectapprove");
		String selectfinancing = request.getParameter("selectfinancing")==null?"":request.getParameter("selectfinancing");
		
		System.out.println(" selectapprove :   "+selectapprove+"  selectfinancing :  "+selectfinancing);
		
		String hql = " from RefundmentLog where delflag = '0' ";
		
		if(!clientreturnorder.equals("")&&clientreturnorder!=null)
		{
			hql += " and clientOrderNum like '%"+clientreturnorder+"%'";
		}
		if(!selectapprove.equals("")&&selectapprove!=null)
		{
			hql += " and approveState = "+selectapprove;
		}
		if(!selectfinancing.equals("")&&selectfinancing!=null)
		{
			hql += " and financingState = "+selectfinancing;
		}
		
		hql += "order by id desc";
		Pages pages = clientReturnOrderBussinessImpl.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		Map map = (Map)ActionContext.getContext().get("map");
		request.getSession().setAttribute("pages", pages);
		request.getSession().setAttribute("option", map);
		
		return "list";
	}
	
	/**
	 * 销售订单列表
	 * @return
	 */
	public String getSaleOrderList()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String orderid = request.getParameter("saleorderserial")==null?"":request.getParameter("saleorderserial");
		String auditingState = request.getParameter("auditingState")==null?"":request.getParameter("auditingState");
		String page = request.getParameter("page");
		String hql = "from Sale_orders where 1=1 and soStat =1";
		if(!orderid.equals("")&&orderid!=null)
		{
			hql += " and soNums like '"+orderid+"'";
		}
//		if(!auditingState.equals("")&&auditingState!=null)
//		{
//			hql += " and (auditingState =  2  or auditingState = "+auditingState+" ) ";
//		}
		hql += " order by soId desc";
		System.out.println("hql : "+hql);
		Pages pages = clientReturnOrderBussinessImpl.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		
		request.setAttribute("page", page);
		request.setAttribute("auditingState", auditingState);
		request.setAttribute("pages", pages);
		
		return "saleorderlist";
	}
	
	
	/**
	 * 批量审批客户退单
	 * @return
	 */
	public String approve()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String mark = request.getParameter("mark")==null?"":request.getParameter("mark");
		String clientreturnorder = request.getParameter("clientreturnorder")==null?"":request.getParameter("clientreturnorder");
		
		String hql =  " from RefundmentLog where delflag = '0' ";
		
		if(mark.equals("approve"))
		{
			hql += "and approveState = 0 ";
			request.setAttribute("mark", mark);
		}
		
		if(mark.equals("cancel"))
		{
			hql += "and approveState = 1 ";
			request.setAttribute("mark", mark);
		}
		
		if(!clientreturnorder.equals("")&&clientreturnorder!=null)
		{
			hql += "and clientOrderNum = '"+clientreturnorder+"' ";
		}
		
		hql += " order by id desc";
		System.out.println("hql : "+hql);
		Pages pages = clientReturnOrderBussinessImpl.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);

		request.setAttribute("pages", pages);
		
		return "batchHandel";
	}
	
	/**
	 * 批量处理
	 * @return
	 */
	public String batchOption()
	{
		System.out.println("~~~~~~~~~~~~~~~~        into batchoption          ~~~~~~~~~~~~~~~~~~~~~~~~~");
		String[] ids = request.getParameterValues("ids");
		String state = request.getParameter("state");
		int approvestate = 0;
		
		if(state.equals("1"))
		{
			approvestate = Integer.parseInt(state);
		}
		if(state.equals("0"))
		{
			approvestate = Integer.parseInt(state);
		}
		
		for(int i=0;i<ids.length;i++)
		{
			RefundmentLog log = (RefundmentLog)clientReturnOrderBussinessImpl.getObject("RefundmentLog", " and id = "+ids[i]).get(0);
			log.setApproveState(approvestate);
			log.setApproveTime(Timestamp.valueOf(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())));
			
			boolean flag = clientReturnOrderBussinessImpl.editClientReturnOrder(log);
		}
		return approve();
	}

	/**
	 * 改变审核状态
	 * @return
	 */
	public String verifyState()
	{
		String id = request.getParameter("id")==null?"":request.getParameter("id");
		RefundmentLog order= (RefundmentLog)clientReturnOrderBussinessImpl.getObject("RefundmentLog", " and id = "+id).get(0);
		order.setFinancingState(1);
		try 
		{
			boolean flag = clientReturnOrderBussinessImpl.editClientReturnOrder(order);
			if(flag)
			{
				response.getOutputStream().print("0");
			}
			else
			{
				response.getOutputStream().print("1");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}
	public Object getModel() {
		// TODO Auto-generated method stub
		log = new RefundmentLog();
		return log;
	}


	public ClientReturnOrderBussiness getClientReturnOrderBussinessImpl() {
		return clientReturnOrderBussinessImpl;
	}

	public void setClientReturnOrderBussinessImpl(
			ClientReturnOrderBussiness clientReturnOrderBussinessImpl) {
		this.clientReturnOrderBussinessImpl = clientReturnOrderBussinessImpl;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}
}
