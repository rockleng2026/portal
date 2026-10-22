package com.fuao.fajxc.action.sale;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.cdn.SaleOrderBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Ordertype;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.RenewLog;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.SetMeal;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.VerifyOrder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 销售订单
 * 

 */
public class SaleAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
    private static Logger logger = Logger.getLogger(SaleAction.class);
	private static final long serialVersionUID = 1L;

	private HttpServletRequest request;
	private HttpServletResponse response;
	private SaleOrder saleOrder;
	private ExecuteRecordBussiness executeRecordBussiness;
	private SaleOrderBussiness saleOrderBussiness;
	public SaleOrderBussiness getSaleOrderBussiness() {
		return saleOrderBussiness;
	}
	public void setSaleOrderBussiness(SaleOrderBussiness saleOrderBussiness) {
		this.saleOrderBussiness = saleOrderBussiness;
	}
	/*request*/
	public HttpServletRequest getRequest() {
		return request;
	}
	/*response*/
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	/*属性封装*/
	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public SaleOrder getSaleOrder() {
		return saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	/*模型驱动*/
	public Object getModel() {

		saleOrder = new SaleOrder();
		return saleOrder;
	}

	/*request*/
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	/*response*/
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * 跳转至添加订单页面(用户)
	 * goAddSale.do
	 */
	public String goAdd(){
		String hql1 = "from Ordertype where delflag = 0 ";
		String hql2 = "from AllType where type = 3 ";
		String hql3 = "from SetMeal where delflag = 0 ";
		
		List<Ordertype> ordertypeList = saleOrderBussiness.findObjectListByHQL(hql1);
		List<AllType> typeList = saleOrderBussiness.findObjectListByHQL(hql2);
		List<SetMeal> setMealList = saleOrderBussiness.findObjectListByHQL(hql3);
		
		request.setAttribute("ordertypeList", ordertypeList);
		request.setAttribute("typeList", typeList);
		request.setAttribute("setMealList", setMealList);
		return "goAdd";
	}
	
	/**
	 * 
	 */
	public String x(){
		return "";
	} 
	
	/**
	 * 弹出订单列表
	 */
	public String dialog() {
//		String hql="from SaleOrder where delflag = 0 ";
//		String dpage=request.getParameter("pageNo");
//		int pageNo=1;
//		
//		String name = request.getParameter("name");
//		if(name !=null && !name.equals(""))
//		{
//			hql +=" and supplierName like '%"+name+"%'";
//		}
//		if(dpage != null && !dpage.equals(""))
//		{
//			pageNo = Integer.parseInt(dpage);
//			hql = request.getSession().getAttribute("hql").toString();
//		}else{
//		hql += " order by id desc";
//		request.getSession().setAttribute("hql", hql);
//		}
//		Pages pages=sobiz.select(hql, pageNo, 10, null);
//		request.setAttribute("pages", pages);
		return "dialog";
	}

	/**
	 * 获取订单编号
	 * @throws IOException 
	 */
	public String addpage() {
		
//		List<AllType> atlist = sobiz.getList("from AllType");
//		
//		List orderType = sobiz.getList("from Questioncategory q where q.questioncategory.id=1 ");
//		List payType = new ArrayList();
//		List paystatus = new ArrayList();
//		for(int i=0;i<atlist.size();i++)
//		{
//			if(atlist.get(i).getType() == 3)
//			{
//				payType.add(atlist.get(i));
//			}
//			if(atlist.get(i).getType() == 4)
//			{
//				paystatus.add(atlist.get(i));
//			}
//		}
//		Cookies cook = new Cookies();
//		request.setAttribute("employeeName",cook.getCookie(request, "employeeName"));
//		request.setAttribute("employeeId",cook.getCookie(request, "employeeId"));
//		request.setAttribute("paystatus", paystatus);
//		request.setAttribute("payType", payType);
//		request.setAttribute("orderType", orderType);
//		System.out.println("ck::::::::F:::"+cook.getCookie(request, "filialemark"));
//		//VerifyOrder ver=audBussiness.gettVerifyOrder(ck.getCookie(request, "filialemark"), "XSDD");
		return "addOrUp";
	}
	
	/**
	 * 获取订单列表
	 * @return
	 */
	public String select() {
		//获得权限标识
//		Employee emp = (Employee)request.getSession().getAttribute("emp");
//		if(null == emp){
//			request.setAttribute("errorMsg", "由于您长时间未活动  请从新登录");
//			return "login";
//		}
//		//获取到子部门ID
//		String sonIds = sobiz.exSql("select getChildDeptLst("+emp.getDepartment().getId()+")");
//		
//		String hql="from SaleOrder as tb where 1=1 and delflag!='1' and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
//		" and tb.employee.department.id in ("+sonIds+")))";
//		Map map = (Map)ActionContext.getContext().get("map");		
//		String dpage=request.getParameter("pageNo");
//		
//		int pageNo=1;
//		//筛选单据的单号
//		String saleOrderNo = request.getParameter("orderNo");
//		
//		if(null != saleOrderNo && !saleOrderNo.equals("")){
//			
//			hql += " and tb.saleOrderNo like '%"+saleOrderNo+"%'";
//		}
//		//参数 ：实体名		页面上传递的实体名的参数
//		String marker = request.getParameter("marker")==null?"":request.getParameter("marker");
//		//单据的审核状态      0：未审   1：待审   2：已审
//		String state = request.getParameter("state")==null?"1":request.getParameter("state");
//		Cookies cook = new Cookies();
//		String employeeId = cook.getCookie(request, "employeeId");			//从cookie中获取员工id
//		
//		List<Employee> emplist = sobiz.getList(" from Employee where id = "+employeeId);
//		String funid = request.getParameter("funid");						//菜单栏id
//		String resouceSet = "";
//		
//		if(dpage != null && !dpage.equals(""))
//		{
//			pageNo = Integer.parseInt(dpage);
//			hql = request.getSession().getAttribute("hql").toString();
//		}
//		else
//		{
//			hql += " order by id desc";
//			request.getSession().setAttribute("hql", hql);
//		}
//		System.out.println("hql : "+hql);
//		Pages pages=sobiz.select(hql, pageNo, 10, null);
//		request.setAttribute("pages", pages);
//		
		return "success";
	}
	//查询订单
	public String select1() throws ParseException{
//		String userName=request.getParameter("userName");
//		String dpage=request.getParameter("pageNo");
//		String deadline=request.getParameter("deadline");
//		String determine="";
//		if(deadline==null)
//		{
//			deadline="";
//		}
//		if(deadline.equals(determine)==false && deadline!=null && deadline.equals("")==false)
//		{
//			request.getSession().removeAttribute("determine");
//			request.getSession().setAttribute("determine", deadline);
//		}
//		int pageNo=1;
//		Customer customer=new Customer();
//		
//		Customer c = (Customer)request.getSession().getAttribute("customer");
//		customer.setCustomerId( c.getCustomerId());
//		if(dpage != null && !dpage.equals(""))
//		{
//			pageNo = Integer.parseInt(dpage);
//		}
//		String hql1=" from SaleOrder  where customer='"+customer.getCustomerId()+"' order by id desc";
//		Pages pages=sobiz.select(hql1, pageNo, 10, null);
//		
//		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
//		Date now = new Date();
//		String strDate = dateFormat.format(now);//当前日期
//		request.setAttribute("nowDate", strDate);
//		//System.out.println("两天前的日期：" + dateFormat.format(new Date(now.getTime() - (long)2 * 24 * 60 * 60 * 1000)));  
//		//System.out.println("五天后的日期：" + dateFormat.format(new Date(now.getTime() + (long)5 * 24 * 60 * 60 * 1000)));
//		//15天后的时间
//		String fifteenDate=dateFormat.format(new Date(now.getTime() + (long)15 * 24 * 60 * 60 * 1000));
//		request.setAttribute("fifteenDate", fifteenDate);
//		List list=pages.getPageList();
//		List<Object> so= new ArrayList();
//		java.util.Date beginDate;
//		java.util.Date endDate;
//		java.util.Date fifteen;
//		long day;
//		if(list!=null)
//		{
//		for(int i=0;i<list.size();i++)
//		{
//				SaleOrder saleorder=(SaleOrder)list.get(i);
//				//saleorder.getProperty().getName();
//				beginDate=dateFormat.parse(strDate);
//				endDate=dateFormat.parse((saleorder.getEndTime()));
//				fifteen=dateFormat.parse(fifteenDate);
//				
//				if(beginDate.getTime()>=endDate.getTime())
//				{
//					day=(beginDate.getTime()-endDate.getTime())/(24*60*60*1000); 
//					saleorder.setDay(day);
//				}
//				else if(beginDate.getTime()<endDate.getTime()&& fifteen.getTime()>=endDate.getTime()){
//					day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
//					saleorder.setDay(day);
//				}
//				else
//				{
//					day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
//					saleorder.setDay(day);
//				}
//
//				
//				
//		}
//		System.out.println(list.size());
//		
//		for(int i=0;i<list.size();i++)
//		{
//				
//				SaleOrder saleorder=(SaleOrder)list.get(i);
//				beginDate=dateFormat.parse(strDate);
//				endDate=dateFormat.parse((saleorder.getEndTime()));
//				fifteen=dateFormat.parse(fifteenDate);
//				if(request.getSession().getAttribute("determine").equals("daoqi")){
//					if(beginDate.getTime()>endDate.getTime())
//					{
//						so.add((SaleOrder)list.get(i));
//					}
//				}
//				else if(request.getSession().getAttribute("determine").equals("weidaoqi"))
//				{
//					if(beginDate.getTime()<endDate.getTime())
//					{
//						so.add((SaleOrder)list.get(i));
//					}
//				}
//				
//				else if(request.getSession().getAttribute("determine").equals("kuaidaoqi"))
//				{
//					
//					if(beginDate.getTime()<endDate.getTime()&&fifteen.getTime()>endDate.getTime())
//					{
//						so.add((SaleOrder)list.get(i));
//					}
//				}
//				else 
//				{
//					so.add((SaleOrder)list.get(i));
//				}
//				
//				
//		}
//		pages.setPageList(so);
//		}
//		request.setAttribute("pages", pages);
		return "saleOrderList";
	}

	/**
	 * 订单详细信息
	 * 
	 * @return
	 */
	public String selectInfo()
	{
//		String saleOrderNo=request.getParameter("saleOrderNo");
//		System.out.println(saleOrderNo);
//		String hql="and saleOrderNo='"+saleOrderNo+"'";
//		SaleOrder saleOrder=(SaleOrder)sobiz.getOrderList("SaleOrder", hql).get(0);
//		
//		request.setAttribute("saleorder", saleOrder);
		return "salrOrderInfo";
	}
	
	/**
	 * 添加新订单
	 * 修改订单共用方法
	 * @return
	 */
	public String add()
	{
		
		//判断是否分公司的员工登录获取分公司部门的代号标识
//		String fmark=ck.getCookie(request, "filialemark");
//		String cosID = request.getParameter("cusname"); 							//获取客户ID	
//		String empId = request.getParameter("empid");								//获取业务员工ID
//		String payTypeid = request.getParameter("payType");							//获取订单付款类型
//		String payStatusid = request.getParameter("payStatus");						//获取订单付款状态
//		String orderTypeid = request.getParameter("orderType");						//获取订单类型
//		String cabinetid = request.getParameter("cabinetid");						//获取机柜ID
//		Customer cus = (Customer)sobiz.getObj(Customer.class, cosID);				//查询订单客户
//		 Employee emp = (Employee)sobiz.getObj(Employee.class, empId);				//查询业务员工
//		 AllType payType = (AllType)sobiz.getObj(AllType.class, payTypeid);			//查询订单付款类型
//		 AllType payStatus = (AllType)sobiz.getObj(AllType.class, payStatusid);		//查询订单付费状态
//		 //查询订单类型
//		 Questioncategory orderType = (Questioncategory)sobiz.getObj(Questioncategory.class, orderTypeid);
//		 //查询机柜
//		 Property property = (Property)sobiz.getObj(Property.class, cabinetid);
////		 so.setProperty(property);
//		 so.setCustomer(cus);
//		 so.setEmployee(emp);
////		 so.setAllTypeByOrdertype(orderType);
////		 so.setAllTypeByPayStatus(payStatus);
////		 so.setAllTypeByPayStyle(payType);
//		 so.setDelflag(0);
//		 
//		 int i=0;
//		 //执行动态记录标志
//		 String exeContent = "";
//		 if(so.getId()!=null){
//			 i=1;
//			 exeContent = "修改了一个销售订单。";
//		 }else{
//			 FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
//				String no=serial.getSerialNumber();
//			 if(so.getPrice()>100000){
//			 so.setSaleOrderNo("VIPXSDD"+no);
//			 }else{
//				 so.setSaleOrderNo("XSDD"+no);
//			 }
//			 exeContent = "添加了一个销售订单。";
//		 }
//		 
//	/*阙超强 14015 执行添加或修改时添加动态记录 */
//		SaleOrder sa = sobiz.addorupdate(so);
//		System.out.println("qcq ------------------------- saleorder::" + sa.getId());
//		
//		//拿到登陆员工用户
//		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
//		
//		//添加记录到动态记录表
//		if(loginEmp != null){
//			Executerecord executerecord = new Executerecord();
//			executerecord.setEmployee(loginEmp);
//			executerecord.setContent(exeContent);
//			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
//			executerecord.setEntityId(sa.getId().toString());
//			executerecord.setEntityName("SaleOrder");
//			executerecord.setSeenEmpId("");
//			executeRecordBussiness.addData(executerecord);
//		}
//		
//		
//		//
//		String s=so.getSaleOrderNo();
//		System.out.println(s);
//		if(true && i==0){
//			int marker =0;
//			if(so.getPrice()>10000){
//				marker=audBussiness.addAuditingOrder2("VIPXSDD",so.getSaleOrderNo(),"SaleOrder",fmark);
//			}else{
//				marker=audBussiness.addAuditingOrder2("XSDD",so.getSaleOrderNo(),"SaleOrder",fmark);
//			}
//			//当插入审核流程的方法返回0是 代表该单据没有审核流程 修改单据的审核状态为审核通过
//			if(marker==0){
//				List<SaleOrder> saleOrder = sobiz.getList("from SaleOrder where saleOrderNo='"+so.getSaleOrderNo()+"'");
//				if(saleOrder != null && saleOrder.size()>0){
//				SaleOrder sao = saleOrder.get(0);
////				sao.setAuditingState("1");
//				sobiz.addorup(sao);
//				}
//			}
//			//sobiz.updateSaleorder(s);//审核表里面插入UUID
//			if(marker==0||marker==2){
//					if(true){
//						return "select";
//					}
//					else
//						return null;
//			}
//			else 
//					return null;
//		}
//		else if(true){
//			//sobiz.updateSaleorder(s);//审核表里面插入UUID
//			return "select";
//		}
//		else 
			return null;
	}
	
	/**
	 * 订单详细信息
	 * 
	 */
	public String info()
	{
//		//获取到订单ID
//		String orderid = request.getParameter("id");
//		
//		//获取info的信息
//		String info = request.getParameter("info");		
//		
//		//查询订单信息
//		SaleOrder so = (SaleOrder)sobiz.getObj(SaleOrder.class, orderid);
//		
//        //将查询出来的订单信息放到request中传到页面显示		
//		request.setAttribute("saleorder", so);
//		
//	
//		if(null != info && ( info == "info" || info.equals("info"))){
//			
//			if(so.getSaleOrderNo()!=null){
//				String addhql2=" and orderNo='"+so.getSaleOrderNo()+"'";
//				List audList=audBussiness.someauditingOrder(addhql2);
//				request.setAttribute("auditingList", audList);
//				if(null != audList && audList.size()>0){
//					
//					String empid = ck.getCookie(request, "employeeId");
//					
//					for(int i=0; i<audList.size(); i++){
//						
//						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
//						
//						if((aot.getEmployees() == empid ||aot.getEmployees().equals(empid)) && aot.getAuditingFlag() ==0 ){
//							
//							//表示未审核
//							request.setAttribute("flage", 0);
//							
//						}else if((aot.getEmployees() == empid || aot.getEmployees().equals(empid) )&&
//								(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2)){
//							
//							//表示已经审核
//							request.setAttribute("flage", 1);
//							
//							request.setAttribute("aot", aot);
//							
//						}
//					}
//					
//				}				
//			}
//		}
//		
//		String empid=ck.getCookie(request, "employeeId");
//		System.out.println("ck::::"+empid);
//		boolean flag=audBussiness.checkemp(so.getSaleOrderNo(), empid);
//		System.out.println("saleActionflag:::::"+flag);
//		if(flag){
//			request.setAttribute("mark", "mark");
//		}
//		boolean flag1=audBussiness.checkemp1(so.getSaleOrderNo(), empid);
//		if(flag1)
//		{
//			request.setAttribute("quanxian", "quanxian");
//		}

		return "info";
	}
	
	/**
	 * 跳转到修改订单页面
	 */
	public String update()
	{
//		String id = request.getParameter("id");
//		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
//		request.setAttribute("saleorder", saleorder);
		return this.addpage();
	}
	
	/**
	 * 删除订单
	 * @throws IOException 
	 */
	public void del() throws IOException
	{
//		String id = request.getParameter("id");
//		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
//		saleorder.setDelflag(1);
//		//拿出id 记录动态
//		String saleId = saleorder.getId().toString();
//		
//		boolean b =sobiz.addorup(saleorder);
//		if(b)
//		{
//		/*阙超强 14015 执行添加或修改时添加动态记录 */
//			//拿到登陆员工用户
//			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
//			
//			//添加记录到动态记录表
//			if(loginEmp != null){
//				Executerecord executerecord = new Executerecord();
//				executerecord.setEmployee(loginEmp);
//				executerecord.setContent("删除了一个销售订单。");
//				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
//				executerecord.setEntityId(saleId);
//				executerecord.setEntityName("SaleOrder");
//				executerecord.setSeenEmpId("");
//				executeRecordBussiness.addData(executerecord);
//			}
//			
//			response.getWriter().println(0);
//		}else
//		{
//			response.getWriter().println(1);
//		}
	}
	/**
	 * 跳转到订单续费
	 */
	public String renewPage(){
//		String id = request.getParameter("id");
//		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
//		request.setAttribute("saleorder", saleorder);
		return "renew";
	} 
	
	/**
	 * 订单续费
	 */
	public String renew()
	{
//		String id = request.getParameter("saleOrderNo");
//		System.out.println(id);
//		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
//		rl.setSaleOrder(saleorder);
//		rl.setInputTime(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//		rl.setEmployee(null);
//		rl.setFinanceaffirm("0");
//		boolean b = sobiz.addrenew(rl);
//		request.getSession().setAttribute("trim", "yes");
//		response.setCharacterEncoding("GBK");
//		if(b)
//		{
//			saleorder.setEndTime(rl.getNextRenewTime());
//			sobiz.addorup(saleorder);
//			this.setMess("success");
//		}else
//		{
//			this.setMess("error");
//		}
		return "selectrl";
	}
	public String selectrl(){
//		String hql="from SaleOrder s where delflag = 0 ";
//		String dpage=request.getParameter("pageNo");
//		int pageNo=1;
//		
//		String saleOrderNo = request.getParameter("orderNo");
//		if(saleOrderNo !=null && !saleOrderNo.equals(""))
//		{
//			hql +=" and s.saleOrderNo like '%"+saleOrderNo+"%'";
//		}
//		if(dpage != null && !dpage.equals(""))
//		{
//			pageNo = Integer.parseInt(dpage);
//			hql = request.getSession().getAttribute("hql").toString();
//		}else{
//		hql += " order by id desc";
//		
//		request.getSession().setAttribute("hql", hql);
//		}
//		logger.error("hql:"+hql);
//		Pages pages=sobiz.select(hql, pageNo, 10, null);
//		request.setAttribute("pages", pages);
		return "renewlist";
	}
	
	public String soWanring()
	{
//		System.out.println("********#############**********");
//		try 
//		{
//			Cookies cook = new Cookies();
//			String loginName = cook.getCookie(request, "loginName");
//			String password = cook.getCookie(request, "password");
//			String selhql = " from Users where loginName = '"+loginName+"' and password = '"+password+"'";
//			System.out.println("hql : "+selhql);
//			List<Users> ulist = sobiz.getList(selhql);
//			System.out.println("size : "+ulist.size());
//			boolean flag = false ;
//			if(ulist.size()>0)
//			{
//				if(ulist.get(0).getRoles().getRoleName().equals("运维人员"))
//				{
//					flag = true;
//				}
//			}
//			System.out.println("flag : "+flag);
//			if(flag)
//			{
//				String hql = " from SaleOrder where delflag = 0 and auditingState = 1";
//				List<SaleOrder> solist = sobiz.getList(hql);
//				String mes = "";
//				mes+="<td class='bgred'><a style='color:red;' target='right' href='addShowUpserver.do?funid=194'>";
//				mes+="销售订单（已审）：("+solist.size()+")</a></td>  ";
//				if(mes!="")
//				{
//					response.setCharacterEncoding("UTF-8");
//					response.getWriter().print(mes);
//				}
//				else
//				{
//					response.getWriter().print(0);
//				}
//			}
//			else
//			{
//				response.getWriter().print(0);
//			}
//		} catch (IOException e) {
//
//			e.printStackTrace();
//		}
		return null;
	}
	
	
}

