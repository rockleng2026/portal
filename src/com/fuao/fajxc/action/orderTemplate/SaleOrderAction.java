package com.fuao.fajxc.action.orderTemplate;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.orderTemplate.SaleOrderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Ordertype;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.SaleorderComm;
import com.fuao.fajxc.vo.SetMeal;
import com.fuao.fajxc.vo.SetMealProperty;

import com.fuao.fajxc.vo.SetmealComm;
import com.opensymphony.xwork2.ModelDriven;

public  class SaleOrderAction implements ModelDriven,ServletRequestAware,ServletResponseAware {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private SaleOrderBussiness saleOrderBussiness;
	private AuditingBussiness audBussiness;
	Cookies ck = new Cookies();
	public SaleOrderBussiness getSaleOrderBussiness() {
		return saleOrderBussiness;
	}
	public void setSaleOrderBussiness(SaleOrderBussiness saleOrderBussiness) {
		this.saleOrderBussiness = saleOrderBussiness;
	}
	/*
	 * 按订单编号查询
	 */
	public  String selectByOrderNumber()
	{
		System.out.println();
		String orderNo=request.getParameter("orderNo");
		System.out.println(orderNo);
		String hql="from SaleorderComm where delflag = 0 and orderNo='"+orderNo+"'";
		System.out.println(hql);
		Pages pages =saleOrderBussiness.exeHqlPages(hql,1, 10, null);
		System.out.println(pages.getAllCount());
		request.setAttribute("pages", pages);
		
		return "saleOrderList";
		
	}
	/**
	 * 跳转到增加页面
	 * @return
	 */
	public String addso()
	{
		String hql="from Ordertype where delflag = 0 ";
		List orderType=saleOrderBussiness.exeHql(hql);
		request.setAttribute("orderType", orderType);//单据类型
		
		String hql1="from Department where filialemark is not 'FA'";
		List department=saleOrderBussiness.exeHql(hql1);
	
		request.setAttribute("department", department);//部门
		return "addSaleOrder";
	}
	public void selectEmployee() throws IOException
	{
		String department=request.getParameter("department");
		String hql="from Employee where delflag = 0 and department.id="+Integer.parseInt(department)+"";
		List<Employee> employee=saleOrderBussiness.exeHql(hql);

		String aa="<select id='employeeList'><option value='0'>请选择员工</option>";
		for(int i=0;i<employee.size();i++)
		{
			aa+="<option value='"+employee.get(i).getId()+"'>"+employee.get(i).getName()+"</option>";
		}
		aa+="</select>";
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(aa);
		
		
	}
	
	/**
	 * 
	 * @return
	 * @throws IOException 
	 */
	public void taocan() throws IOException
	{
		String chargemode =request.getParameter("taocanType");
		System.out.println("chargemode========="+chargemode);
		String orderType =request.getParameter("orderType");
		System.out.println("orderType========="+orderType);
		String hql=" from SetmealComm where delflag= 0  and ordertype.id="+Integer.parseInt(orderType)+" and chargeMode="+Integer.parseInt(chargemode)+"";
		
		List setmeal=saleOrderBussiness.exeHql(hql);
		System.out.println(setmeal.size());
		String aa="";
		if(setmeal.size()>0)
		{
			for(int i=1;i<setmeal.size()+1;i++)
			{
				
				aa+= "<tr id='trtr'><td width='15%' align='center' height='30'><a href='javascript:void(0)' onclick='taocan("+((SetmealComm)setmeal.get(i-1)).getId()+")'>"+((SetmealComm)setmeal.get(i-1)).getName()+"</a></td>";
				aa+="<td width='10%' align='center'>"+((SetmealComm)setmeal.get(i-1)).getStartTime()+"</td>";
				aa+="<td width='10%' align='center'>"+((SetmealComm)setmeal.get(i-1)).getEndTime()+"</td>";
				aa+="<td width='30%' align='center'>"+((SetmealComm)setmeal.get(i-1)).getDescribe()+"<a href='javascript:void(0)' id='jtip"+i+"' onclick='add("+i+")'>详细信息</a>";
				aa+="<div id='alerts"+i+"' style='position:absolute; z-index:2; width:400px; height:100px; background-color:#fff;  border:1px dashed #0166d4;display:none' class='divclass'><div align='right'>";
				aa+="<span onclick=document.getElementById('alerts"+i+"').style.display='none' style='color: #993333; font-weight:bold'>关闭</span></div >"+((SetmealComm)setmeal.get(i-1)).getDescribe()+"</div>";
				aa+="<td width='10%' align='center'>"+((SetmealComm)setmeal.get(i-1)).getTemp()+"</td>";
				aa+="<td width='10%' align='center'>"+((SetmealComm)setmeal.get(i-1)).getTotalPrice()+"</td>";
				aa+="<td width='10%' align='center'>"+((SetmealComm)setmeal.get(i-1)).getPayPrice()+"</td>";
				aa+="<td width='5%' align='center'><input id='' name='a' type='radio' value='"+((SetmealComm)setmeal.get(i-1)).getId()+"'/ ></td>";

			}
		}
		else
		{
			aa+="<tr id='trtr'><td colspan='8' align='center'>没有此类型的套餐！！！！</td></tr>";
		}
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(aa);
	}

	/**
	 * 查询套餐
	 * @return
	 */
	public String selecttaocan()
	{
		String id=request.getParameter("id");
		String hql=" from SetmealComm where delflag= 0  and id="+Integer.parseInt(id)+"";
		
		List setmeal= saleOrderBussiness.exeHql(hql);
		request.setAttribute("setmeal", setmeal.get(0));
		
		String hql1=" from SetmealPropertyComm where delflag= 0 and setmealComm.id="+Integer.parseInt(id)+" ";
		List setmealproperty= saleOrderBussiness.exeHql(hql1);
		request.setAttribute("setmealproperty", setmealproperty);
		return "taocaninfo";
	}

	/*
	 * 增加
	 */
	public void addSaleOrder() throws IOException 
	{

		String fmark=ck.getCookie(request, "filialemark");
		String orderType=request.getParameter("orderType");
		String taocanType=request.getParameter("taocanType");
		String fufeiType=request.getParameter("fufeiType");
		String xiaoshou=request.getParameter("xiaoshou");
		String cus=request.getParameter("cus");
		String orderDes=request.getParameter("orderDes");
		String orderId=request.getParameter("orderId");
		String ordermiaoshu = URLDecoder.decode(orderDes, "UTF-8");
		
		
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			String loginname =loginEmp.getName();//登录员工
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
			String no=serial.getSerialNumber();
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String strDate = dateFormat.format(now);//当前日期
		
		String hql=" from SetmealComm where delflag= 0  and id="+Integer.parseInt(orderId)+"";
		List setmeal= saleOrderBussiness.exeHql(hql);
		SetmealComm setmealcomm=(SetmealComm) setmeal.get(0);
		SaleorderComm saleorder=new SaleorderComm();
			saleorder.setOrderNo("XSDD"+no);
			saleorder.setUuid(UUID.randomUUID().toString());
			//saleorder.setEmployeeId(xiaoshou);
			saleorder.setCustomerId(Integer.parseInt(cus));
			saleorder.setSetmealComm(setmealcomm);
			saleorder.setPayStyle(Integer.parseInt(fufeiType));
			saleorder.setPrice(setmealcomm.getPayPrice());
			saleorder.setPayStatus(Integer.parseInt(taocanType));
			saleorder.setAuditState(0);
			saleorder.setDescribtion(ordermiaoshu);
			saleorder.setDelflag(0);
			saleorder.setInputAdmin(loginname);
			saleorder.setBuildTime(strDate);
			saleorder.setAuditEmp(xiaoshou);
			saleorder.setEmployeeId(Integer.parseInt(xiaoshou));
		 SaleorderComm soc=(SaleorderComm) saleOrderBussiness.add(saleorder);
		 int marker;
		 if(soc!=null)
		 {
			 marker= audBussiness.addAuditingOrder2("XSDD",soc.getOrderNo(),"SaleOrder",fmark);
			 if(marker==0)
			 {
				 response.getWriter().print("0");
			 }
		 }
		 
		 else
		 {
			 response.getWriter().print("1");
		 }
	
	}
	/*
	 * 列表
	 */
	public String saleOrderList()
	{
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		
		String hql="from SaleorderComm where delflag = 0 order by id desc ";
		Pages pages =saleOrderBussiness.exeHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "saleOrderList";
	}
	/**
	 * 详细信息
	 * @return
	 */
	public String saleOrderInfo()
	{
		String id=request.getParameter("id");
		String info = request.getParameter("info");		
		
		
		
		String hql="from SaleorderComm where delflag = 0 and id="+Integer.parseInt(id)+" ";
		SaleorderComm sac=  (SaleorderComm) saleOrderBussiness.exeHql(hql).get(0);
		request.setAttribute("SaleorderComm", sac);
		String hql3="from Customer where del= 0 and customerId="+sac.getCustomerId()+" ";
		List<Customer> customer= saleOrderBussiness.exeHql(hql3);
		request.setAttribute("customer", (Customer)customer.get(0));
		
		String hql2="from Employee where delflag = 0 and id="+sac.getAuditEmp()+" ";
		System.out.println(hql2);
		List<Employee> employee= saleOrderBussiness.exeHql(hql2);
		request.setAttribute("employee", employee.get(0));
		
		
		String hql1="from SetmealComm where delflag = 0 and id="+sac.getSetmealComm().getId()+"";
		List smc= saleOrderBussiness.exeHql(hql1);
		request.setAttribute("setmealComm", (SetmealComm)smc.get(0));
		
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(sac.getOrderNo()!=null){
				String addhql2=" and orderNo='"+sac.getOrderNo()+"'";
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0){
					
					String empid = ck.getCookie(request, "employeeId");
					
					for(int i=0; i<audList.size(); i++){
						
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						
						if((aot.getEmployees() == empid ||aot.getEmployees().equals(empid)) && aot.getAuditingFlag() ==0 ){
							
							//表示未审核
							request.setAttribute("flage", 0);
							
						}else if((aot.getEmployees() == empid || aot.getEmployees().equals(empid) )&&
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
		boolean flag=audBussiness.checkemp(sac.getOrderNo(), empid);
		System.out.println("saleActionflag:::::"+flag);
		if(flag){
			request.setAttribute("mark", "mark");
		}
		boolean flag1=audBussiness.checkemp1(sac.getOrderNo(), empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}

		return "saleOrderInfo";
	}
	/*
	 * 修改
	 */
	public String updateSaleOrder()
	{
		String id=request.getParameter("id");
		
		
		String hql="from SaleorderComm where delflag = 0 and id="+Integer.parseInt(id)+" ";
		SaleorderComm sac=  (SaleorderComm) saleOrderBussiness.exeHql(hql).get(0);
		request.setAttribute("SaleorderComm", sac);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa");
		String hql3="from Customer where del= 0 and customerId="+sac.getCustomerId()+" ";
		List<Customer> customer= saleOrderBussiness.exeHql(hql3);
		request.setAttribute("customer", (Customer)customer.get(0));
		
		
		String hql1="from SetmealComm where delflag = 0 and id="+sac.getSetmealComm().getId()+"";
		List smc= saleOrderBussiness.exeHql(hql1);
		request.setAttribute("setmealComm", (SetmealComm)smc.get(0));
		
		String hql2="from Ordertype where delflag = 0 ";
		List orderType=saleOrderBussiness.exeHql(hql2);
		request.setAttribute("orderType", orderType);//单据类型
		
		
		
		
		String hql5="from Department where filialemark is not 'FA'";
		List department=saleOrderBussiness.exeHql(hql5);
	
		request.setAttribute("department", department);//部门‘
		
		
		String hql6="from Employee where delflag = 0 and id="+sac.getEmployeeId()+"";
		System.out.println(hql6);
		List employee=saleOrderBussiness.exeHql(hql6);
		
		if(employee!=null)
		{
			String hql7="from Employee where delflag = 0 and department.id="+((Employee)employee.get(0)).getDepartment().getId()+"";
			System.out.println(hql7);
			List employee1=saleOrderBussiness.exeHql(hql7);
			request.setAttribute("employee1", employee1);
			request.setAttribute("dtId", ((Employee)employee1.get(0)).getDepartment().getId());
			
		}
		return "updatesaleOrder";
	}
	/**
	 * 修改单据
	 * @throws IOException 
	 */
	public void updateSO() throws IOException
	{
		String orderNumber=request.getParameter("orderNumber");//单据编号
		String orderType=request.getParameter("orderType");//订单类型
		String taocanType=request.getParameter("taocanType");//套餐类型
		String fufeiType=request.getParameter("fufeiType");//付费类型
		String xiaoshou=request.getParameter("xiaoshou");//销售人员
		String cusname=request.getParameter("cusname");//客户姓名
		String discountDes1=request.getParameter("discountDes");//折扣描述
		String price=request.getParameter("price");//价格
		String isfouDiscount1=request.getParameter("isfouDiscount");//是否折扣
		String xufeiStartTime=request.getParameter("xufeiStartTime");//开始时间
		String orderNextXufei=request.getParameter("orderNextXufei");//结束时间
		String orderDes1=request.getParameter("orderDes");//订单描述
		
		String discountDes= URLDecoder.decode(discountDes1, "UTF-8");
		String isfouDiscount= URLDecoder.decode(isfouDiscount1, "UTF-8");
		String orderDes= URLDecoder.decode(orderDes1, "UTF-8");
		String orderId=request.getParameter("orderId");//套餐id
		
		String sql="update saleorder_comm " +
				"set customer_id="+Integer.parseInt(cusname)+" " +
				", setmeal_id="+Integer.parseInt(orderId)+" " +
				", pay_style="+Integer.parseInt(fufeiType)+" " +
				", price="+Float.parseFloat(price)+" " +
				", is_discount="+Integer.parseInt(isfouDiscount)+" "  +
				", discount_describe='"+discountDes+"' " +
				", pay_status='"+Integer.parseInt(fufeiType)+"' " +
				", start_time='"+xufeiStartTime+"' " +
				", pay_nexttime='"+orderNextXufei+"' " +
				", describtion='"+orderDes+"' " +
				", employee_id="+Integer.parseInt(xiaoshou)+" " +
				
				"where  order_no='"+orderNumber+"' ";
		System.out.println(sql);
		int num=saleOrderBussiness.exeUpdateSql(sql);
		if(num>0)
		{
			response.getWriter().print("0");
		}
		else
		{
			response.getWriter().print("1");
		}
		
		
	}
	/*
	 * 删除
	 */
	public void delSaleOrder() throws IOException
	{
		String id=request.getParameter("id");
		String sql="update saleorder_comm set delflag=1 where id="+Integer.parseInt(id)+"";
		int num=saleOrderBussiness.exeUpdateSql(sql);
		
		if(num>0)
		{
			response.getWriter().print("0");
		}
		else
		{
			response.getWriter().print("1");
		}
		
		
	}
	
	/**
	 * 
	 * 单据类型列表
	 */
	public String orderTypeList()
	{
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		String hql="from Ordertype where delflag = 0 ";
		//List<Ordertype> or=saleOrderBussiness.exeHql(hql);
		Pages pages =saleOrderBussiness.exeHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "orderTypeList";
	}
	/**
	 * 
	 * 增加类型单据
	 * @throws IOException 
	 */
	public void addOrderType() throws IOException
	{
		
		String orderTypeName1=request.getParameter("orderTypeName");
		String orderTypeName=URLDecoder.decode(orderTypeName1,"UTF-8");
		String beizhu1=request.getParameter("beizhu");
		String beizhu=URLDecoder.decode(beizhu1,"UTF-8");
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String strDate = dateFormat.format(now);//当前日期
		Ordertype ordertype=new Ordertype();
		ordertype.setTemp1(beizhu);
		ordertype.setName(orderTypeName.toString());
		ordertype.setTemp2(strDate);
		ordertype.setDelflag(0);
		Ordertype ot=(Ordertype) saleOrderBussiness.add(ordertype);
		if(ot!=null)
		{
			response.getWriter().print("0");
		}
		else
		{
			response.getWriter().print("1");
		}
		
	}
	/**
	 * 详细信息
	 * 
	 */
	
	public String orderType(){
		String id=request.getParameter("id");
		String mark=request.getParameter("mark");
		
		String hql="from Ordertype where delflag = 0 and id="+Integer.parseInt(id)+" ";
		System.out.println(hql);
		Ordertype orderType=  (Ordertype) saleOrderBussiness.exeHql(hql).get(0);
		if(orderType!=null)
		{
			request.setAttribute("orderType", orderType);
		}
		if(mark.equals("1"))
		{
			return "orderTypeInfo";
		}
		else if(mark.equals("2"))
		{
			return "update";
		}
		return "success";
	}
	/**
	 * 修改类型单据
	 * @return
	 * @throws IOException 
	 */
	public void updateOrderType() throws IOException
	{
		String orderTypeName1=request.getParameter("orderTypename");
		String orderTypeName=URLDecoder.decode(orderTypeName1,"UTF-8");
		String beizhu1=request.getParameter("beizhu");
		String beizhu=URLDecoder.decode(beizhu1,"UTF-8");
		String id=request.getParameter("orderTypeId");
		String sql="update ordertype set name='"+orderTypeName+"' , temp1='"+beizhu+"' where id="+Integer.parseInt(id)+"";
		System.out.println(sql);
		int num= saleOrderBussiness.exeUpdateSql(sql);
		if(num>0)
		{
			response.getWriter().print("0");
		
		}
		else
		{
			response.getWriter().print("1");
		}
	}
	/*
	 * 删除单据类型
	 */
	public void delOrderType() throws IOException
	{
		String id=request.getParameter("id");
		String sql="update ordertype set delflag=1 where id="+Integer.parseInt(id)+"";
		int num=saleOrderBussiness.exeUpdateSql(sql);
		if(num>0)
		{
			response.getWriter().print("0");
		}
		else
		{
			response.getWriter().print("1");
		}
	}
	
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}
	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
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

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
		
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
		
	}
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}


}
