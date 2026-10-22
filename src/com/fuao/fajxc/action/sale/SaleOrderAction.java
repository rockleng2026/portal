package com.fuao.fajxc.action.sale;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.record.formula.functions.Value;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.dialect.FirebirdDialect;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.cwtj_ygyj.YgyjDao;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.RenewLog;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.UpServer;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.VerifyOrder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.commons.digester.ObjectParamRule;

/**
 * 销售订单lzy销售订单lzy销售订单lzy销售订单lzy销售订单lzy销售订单lzy
 * 

 */
public class SaleOrderAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
    private static Logger logger = Logger.getLogger(SaleOrderAction.class);
	private static final long serialVersionUID = 1L;
//销售订单lzy
	private SaleorderBussiness sobiz;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private SaleOrder so;
	private RenewLog rl;
	private String mess;
	private AuditingBussiness audBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;
	private List<SaleOrder> orderlist;
	private Customer data;
	private List upserverlist;
	private List saveupserver;
	private String oper;
	
	private Integer empid;

	
	private YgyjDao yjDao;
	private List yjlist;
	
	public String getOper() {
		return oper;
	}

	public void setOper(String oper) {
		this.oper = oper;
	}

	public Customer getCustomer() {
		return data;
	}

	public List getUpserverlist() {
		return upserverlist;
	}

	public void setUpserverlist(List upserverlist) {
		this.upserverlist = upserverlist;
	}

	public void setCustomer(Customer customer) {
		this.data = customer;
	}

	public List getSaveupserver() {
		return saveupserver;
	}

	public void setSaveupserver(List saveupserver) {
		this.saveupserver = saveupserver;
	}

	public List<SaleOrder> getOrderlist() {
		return orderlist;
	}

	public void setOrderlist(List<SaleOrder> orderlist) {
		this.orderlist = orderlist;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}


	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	Cookies ck = new Cookies();
	
	

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public String getMess() {
		return mess;
	}

	public void setMess(String mess) {
		this.mess = mess;
	}

	public RenewLog getRl() {
		return rl;
	}

	public void setRl(RenewLog rl) {
		this.rl = rl;
	}

	public SaleorderBussiness getSobiz() {
		return sobiz;
	}

	public void setSobiz(SaleorderBussiness sobiz) {
		this.sobiz = sobiz;
	}

	public Object getModel() {

		so = new SaleOrder();
		return so;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public YgyjDao getYjDao() {
		return yjDao;
	}

	public void setYjDao(YgyjDao yjDao) {
		this.yjDao = yjDao;
	}

	public List getYjlist() {
		return yjlist;
	}

	public void setYjlist(List yjlist) {
		this.yjlist = yjlist;
	}

	public Integer getEmpid() {
		return empid;
	}

	public void setEmpid(Integer empid) {
		this.empid = empid;
	}

	/**
	 * 弹出订单列表
	 */
	public String dialog() {

		

		String hql="from SaleOrder where delflag = 0 ";
		String dpage=request.getParameter("pageNo");
		int pageNo=1;
		
		String name = request.getParameter("name");
		if(name !=null && !name.equals(""))
		{
			hql +=" and supplierName like '%"+name+"%'";
		}
		if(dpage != null && !dpage.equals(""))
		{
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
		hql += " order by id desc";
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages=sobiz.select(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		return "dialog";
	}
	
	/**
	 * 获取订单编号
	 * @throws IOException 
	 */
	public String addpage() {
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>");
		List<AllType> atlist = sobiz.getList("from AllType");
		
		List orderType = sobiz.getList("from Questioncategory q where q.questioncategory.id=1 ");
		List payType = new ArrayList();
		List paystatus = new ArrayList();
		for(int i=0;i<atlist.size();i++)
		{
			if(atlist.get(i).getType() == 3)
			{
				payType.add(atlist.get(i));
			}
			if(atlist.get(i).getType() == 4)
			{
				paystatus.add(atlist.get(i));
			}
		}
		Cookies cook = new Cookies();
		request.setAttribute("employeeName",cook.getCookie(request, "employeeName"));
		request.setAttribute("employeeId",cook.getCookie(request, "employeeId"));
		request.setAttribute("paystatus", paystatus);
		request.setAttribute("payType", payType);
		request.setAttribute("orderType", orderType);
		System.out.println("ck::::::::F:::"+cook.getCookie(request, "filialemark"));
		//VerifyOrder ver=audBussiness.gettVerifyOrder(ck.getCookie(request, "filialemark"), "XSDD");

		return "addOrUp";
		
	}
	
	/**
	 * 获取订单列表
	 * @return
	 */
	public String select() {
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		//获得权限标识
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		
		if(null == emp){
			request.setAttribute("errorMsg", "由于您长时间未活动  请从新登录");
			return "login";
		}
		System.out.println("Id"+emp.getDepartment().getId());
		//获取到子部门ID
		String sonIds = sobiz.exSql("select getChildDeptLst("+emp.getDepartment().getId()+")");
		
		
		String hql="from SaleOrder as tb where 1=1 and delflag!='1' and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
		" and tb.employee.department.id in ("+sonIds+")))";
		Map map = (Map)ActionContext.getContext().get("map");		
		String dpage=request.getParameter("pageNo");
		if(id!=null && !"".equals(id)){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		int pageNo=1;
		//筛选单据的单号
		String saleOrderNo = request.getParameter("orderNo");
		
		if(null != saleOrderNo && !saleOrderNo.equals("")){
			
			hql += " and tb.saleOrderNo like '%"+saleOrderNo+"%'";
		}
		//参数 ：实体名		页面上传递的实体名的参数
		String marker = request.getParameter("marker")==null?"":request.getParameter("marker");
		//单据的审核状态      0：未审   1：待审   2：已审
		String state = request.getParameter("state")==null?"1":request.getParameter("state");
		Cookies cook = new Cookies();
		String employeeId = cook.getCookie(request, "employeeId");			//从cookie中获取员工id
		
		
		List<Employee> emplist = sobiz.getList(" from Employee where id = "+employeeId);
		String funid = request.getParameter("funid");						//菜单栏id
		String resouceSet = "";
		
		
		if(dpage != null && !dpage.equals(""))
		{
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}
		else
		{
			hql += " order by id desc";
			request.getSession().setAttribute("hql", hql);
		}
		System.out.println("hql : "+hql);
		Pages pages=sobiz.select(hql, pageNo, 20, null);
		
		request.setAttribute("pages", pages);
		
		return "success";
	}
	//查询订单
	public String select1() throws ParseException{
		String userName=request.getParameter("userName");
		String dpage=request.getParameter("pageNo");
		String deadline=request.getParameter("deadline");
		String determine="";
		if(deadline==null)
		{
			deadline="";
		}
		if(deadline.equals(determine)==false && deadline!=null && deadline.equals("")==false)
		{
			request.getSession().removeAttribute("determine");
			request.getSession().setAttribute("determine", deadline);
		}
		int pageNo=1;
		Customer customer=new Customer();
		
		Customer c = (Customer)request.getSession().getAttribute("customer");
		customer.setCustomerId( c.getCustomerId());
		if(dpage != null && !dpage.equals(""))
		{
			pageNo = Integer.parseInt(dpage);
		}
		String hql1=" from SaleOrder  where customer='"+customer.getCustomerId()+"' order by id desc";
		Pages pages=sobiz.select(hql1, pageNo, 10, null);
		
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String strDate = dateFormat.format(now);//当前日期
		request.setAttribute("nowDate", strDate);
		//System.out.println("两天前的日期：" + dateFormat.format(new Date(now.getTime() - (long)2 * 24 * 60 * 60 * 1000)));  
		//System.out.println("五天后的日期：" + dateFormat.format(new Date(now.getTime() + (long)5 * 24 * 60 * 60 * 1000)));
		//15天后的时间
		String fifteenDate=dateFormat.format(new Date(now.getTime() + (long)15 * 24 * 60 * 60 * 1000));
		request.setAttribute("fifteenDate", fifteenDate);
		List list=pages.getPageList();
		List<Object> so= new ArrayList();
		java.util.Date beginDate;
		java.util.Date endDate;
		java.util.Date fifteen;
		long day;
		if(list!=null)
		{
		for(int i=0;i<list.size();i++)
		{
				SaleOrder saleorder=(SaleOrder)list.get(i);
				//saleorder.getProperty().getName();
				beginDate=dateFormat.parse(strDate);
				endDate=dateFormat.parse((saleorder.getEndTime()));
				fifteen=dateFormat.parse(fifteenDate);
				
				if(beginDate.getTime()>=endDate.getTime())
				{
					day=(beginDate.getTime()-endDate.getTime())/(24*60*60*1000); 
					saleorder.setDay(day);
				}
				else if(beginDate.getTime()<endDate.getTime()&& fifteen.getTime()>=endDate.getTime()){
					day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
					saleorder.setDay(day);
				}
				else
				{
					day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
					saleorder.setDay(day);
				}

				
				
		}
		System.out.println(list.size());
		
		for(int i=0;i<list.size();i++)
		{
				
				SaleOrder saleorder=(SaleOrder)list.get(i);
				beginDate=dateFormat.parse(strDate);
				endDate=dateFormat.parse((saleorder.getEndTime()));
				fifteen=dateFormat.parse(fifteenDate);
				if(request.getSession().getAttribute("determine").equals("daoqi")){
					if(beginDate.getTime()>endDate.getTime())
					{
						so.add((SaleOrder)list.get(i));
					}
				}
				else if(request.getSession().getAttribute("determine").equals("weidaoqi"))
				{
					if(beginDate.getTime()<endDate.getTime())
					{
						so.add((SaleOrder)list.get(i));
					}
				}
				
				else if(request.getSession().getAttribute("determine").equals("kuaidaoqi"))
				{
					
					if(beginDate.getTime()<endDate.getTime()&&fifteen.getTime()>endDate.getTime())
					{
						so.add((SaleOrder)list.get(i));
					}
				}
				else 
				{
					so.add((SaleOrder)list.get(i));
				}
				
				
		}
		pages.setPageList(so);
		}
		request.setAttribute("pages", pages);
		return "saleOrderList";
	}

	/**
	 * 订单详细信息
	 * 
	 * @return
	 */
	public String selectInfo()
	{
		String saleOrderNo=request.getParameter("saleOrderNo");
		System.out.println(saleOrderNo);
		String hql="and saleOrderNo='"+saleOrderNo+"'";
		SaleOrder saleOrder=(SaleOrder)sobiz.getOrderList("SaleOrder", hql).get(0);
		
		request.setAttribute("saleorder", saleOrder);
		return "salrOrderInfo";
	}
	
	/**
	 * 添加新订单
	 * 修改订单共用方法
	 * @return
	 */
	
	
	public String add()
	{
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>");
		//判断是否分公司的员工登录获取分公司部门的代号标识
		String fmark=ck.getCookie(request, "filialemark");
		String cosID = request.getParameter("cusname"); 							//获取客户ID	
		String empId = request.getParameter("empid");								//获取业务员工ID
		String payTypeid = request.getParameter("payType");							//获取订单付款类型
		String payStatusid = request.getParameter("payStatus");						//获取订单付款状态
		String orderTypeid = request.getParameter("orderType");						//获取订单类型
		String cabinetid = request.getParameter("cabinetid");						//获取机柜ID
		Customer cus = (Customer)sobiz.getObj(Customer.class, cosID);				//查询订单客户
		 Employee emp = (Employee)sobiz.getObj(Employee.class, empId);				//查询业务员工
		 AllType payType = (AllType)sobiz.getObj(AllType.class, payTypeid);			//查询订单付款类型
		 AllType payStatus = (AllType)sobiz.getObj(AllType.class, payStatusid);		//查询订单付费状态
		 //查询订单类型
		 Questioncategory orderType = (Questioncategory)sobiz.getObj(Questioncategory.class, orderTypeid);
		 //查询机柜
		 Property property = (Property)sobiz.getObj(Property.class, cabinetid);
		 so.setProperty(property);
		 so.setCustomer(cus);
		 so.setEmployee(emp);
		 so.setAllTypeByOrdertype(orderType);
		 so.setAllTypeByPayStatus(payStatus);
		 so.setAllTypeByPayStyle(payType);
		 so.setDelflag("0");
		 so.setAuditingState("3");
		 int i=0;
		 //执行动态记录标志
		 String exeContent = "";
		 if(so.getId()!=null){
			 i=1;
			 exeContent = "修改了一个销售订单。";
			 so.setAuditingState("2");//修改订单暂时不需要重新审核
		 }else{
			 FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
				String no=serial.getSerialNumber();
			 if(so.getPrice()>100000){
			 so.setSaleOrderNo("VIPXSDD"+no);
			 }else{
				 so.setSaleOrderNo("XSDD"+no);
			 }
			 exeContent = "添加了一个销售订单。";
		 }
		 
	/*阙超强 14015 执行添加或修改时添加动态记录 */
	SaleOrder sa = sobiz.addorupdate(so);
		System.out.println("qcq ------------------------- saleorder::" + sa.getId());
		
		//拿到登陆员工用户
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		
		//添加记录到动态记录表
		if(loginEmp != null){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent(exeContent);
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(sa.getId().toString());
			executerecord.setEntityName("SaleOrder");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		
		//
		String s=so.getSaleOrderNo();
		System.out.println(s);
		if(true && i==0){//i==0 表示是新增的订单
			int marker =0;
			if(so.getPrice()>10000){
				marker=audBussiness.addAuditingOrder2("VIPXSDD",so.getSaleOrderNo(),"SaleOrder",fmark);
			}else{
				marker=audBussiness.addAuditingOrder2("XSDD",so.getSaleOrderNo(),"SaleOrder",fmark);
			}
			//当插入审核流程的方法返回0是 代表该单据没有审核流程 修改单据的审核状态为审核通过
			if(marker==0){
				List<SaleOrder> saleOrder = sobiz.getList("from SaleOrder where saleOrderNo='"+so.getSaleOrderNo()+"'");
				if(saleOrder != null && saleOrder.size()>0){
				SaleOrder sao = saleOrder.get(0);
				sao.setAuditingState("1");
				sobiz.addorup(sao);
				}
			}
			//sobiz.updateSaleorder(s);//审核表里面插入UUID
			if(marker==0||marker==2){
					if(true){
						return "select";
					}
					else
						return null;
			}
			else 
					return null;
		}
		else if(true){// i 不等于0 标识是修改订单 这里没有加入审核流程
			return "select";
		}
		else 
			return null;
	}
	
	/**
	 * 订单详细信息
	 * 
	 */
	public String info()
	{
		//获取到订单ID
		String orderid = request.getParameter("id");
		
		//获取info的信息
		String info = request.getParameter("info");		
		
		//查询订单信息
		SaleOrder so = (SaleOrder)sobiz.getObj(SaleOrder.class, orderid);
		
        //将查询出来的订单信息放到request中传到页面显示		
		request.setAttribute("saleorder", so);
		
	
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(so.getSaleOrderNo()!=null){
				String addhql2=" and orderNo='"+so.getSaleOrderNo()+"'";
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
		boolean flag=audBussiness.checkemp(so.getSaleOrderNo(), empid);
		System.out.println("saleActionflag:::::"+flag);
		if(flag){
			request.setAttribute("mark", "mark");
		}
		boolean flag1=audBussiness.checkemp1(so.getSaleOrderNo(), empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}

		return "info";
	}
	
	/**
	 * 跳转到修改订单页面
	 */
	public String update()
	{
		String id = request.getParameter("id");
		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
		request.setAttribute("saleorder", saleorder);
		return this.addpage();
	}
	
	/**
	 * 删除订单
	 * @throws IOException 
	 */
	public void del() throws IOException
	{
		String id = request.getParameter("id");
		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
		saleorder.setDelflag("1");
		//拿出id 记录动态
		String saleId = saleorder.getId().toString();
		
		boolean b =sobiz.addorup(saleorder);
		if(b)
		{
		/*阙超强 14015 执行添加或修改时添加动态记录 */
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一个销售订单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(saleId);
				executerecord.setEntityName("SaleOrder");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			response.getWriter().println(0);
		}else
		{
			response.getWriter().println(1);
		}
	}
	/**
	 * 跳转到订单续费
	 */
	public String renewPage(){
		String id = request.getParameter("id");
		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
		request.setAttribute("saleorder", saleorder);
		return "renew";
	} 
	
	/**
	 * 订单续费
	 */
	public String renew()
	{
		String id = request.getParameter("saleOrderNo");
		System.out.println(id);
		SaleOrder saleorder = (SaleOrder)sobiz.getObj(SaleOrder.class, id);
		rl.setSaleOrder(saleorder);
		rl.setInputTime(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		rl.setEmployee(null);
		rl.setFinanceaffirm("0");
		boolean b = sobiz.addrenew(rl);
		request.getSession().setAttribute("trim", "yes");
		response.setCharacterEncoding("GBK");
		if(b)
		{
			saleorder.setEndTime(rl.getNextRenewTime());
			sobiz.addorup(saleorder);
			this.setMess("success");
		}else
		{
			this.setMess("error");
		}
		return "selectrl";
	}
	public String selectrl(){
		String hql="from SaleOrder s where delflag = 0 ";
		String dpage=request.getParameter("pageNo");
		int pageNo=1;
		
		String saleOrderNo = request.getParameter("orderNo");
		if(saleOrderNo !=null && !saleOrderNo.equals(""))
		{
			hql +=" and s.saleOrderNo like '%"+saleOrderNo+"%'";
		}
		if(dpage != null && !dpage.equals(""))
		{
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
		hql += " order by id desc";
		
		request.getSession().setAttribute("hql", hql);
		}
		logger.error("hql:"+hql);
		Pages pages=sobiz.select(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		return "renewlist";
	}
	
	public String soWanring()
	{
		System.out.println("********#############**********");
		try 
		{
			Cookies cook = new Cookies();
			String loginName = cook.getCookie(request, "loginName");
			String password = cook.getCookie(request, "password");
			String selhql = " from Users where loginName = '"+loginName+"' and password = '"+password+"'";
			System.out.println("hql : "+selhql);
			List<Users> ulist = sobiz.getList(selhql);
			System.out.println("size : "+ulist.size());
			boolean flag = false ;
			if(ulist.size()>0)
			{
				if(ulist.get(0).getRoles().getRoleName().equals("运维人员"))
				{
					flag = true;
				}
			}
			System.out.println("flag : "+flag);
			if(flag)
			{
				String hql = " from SaleOrder where delflag = 0 and auditingState = 1";
				List<SaleOrder> solist = sobiz.getList(hql);
				String mes = "";
				mes+="<td class='bgred'><a style='color:red;' target='right' href='addShowUpserver.do?funid=194'>";
				mes+="销售订单（已审）：("+solist.size()+")</a></td>  ";
				if(mes!="")
				{
					response.setCharacterEncoding("UTF-8");
					response.getWriter().print(mes);
				}
				else
				{
					response.getWriter().print(0);
				}
			}
			else
			{
				response.getWriter().print(0);
			}
		} catch (IOException e) {

			e.printStackTrace();
		}
		return null;
	}
	
	public void selectcus() throws IOException
	{
		String cusnameId=request.getParameter("cusnameId");
		String authorization1=request.getParameter("authorization");
		String authorization = URLDecoder.decode(authorization1, "UTF-8");
		Customer cus = (Customer)sobiz.getObj(Customer.class, cusnameId);	
		if(cusnameId.equals("")||cusnameId==null)
		{
			response.getWriter().print("0");
			return ;
		}
		if(cus!=null)
		{
			if(authorization.equals(cus.getAuthorization()))
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("2");
			}
		}
	}
	
	public String getOrderList(){
		
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		
		if(null == emp){
			request.setAttribute("errorMsg", "由于您长时间未活动  请从新登录");
			return "login";
		}
		System.out.println("Id"+emp.getDepartment().getId());
		//获取到子部门ID
		String sonIds = sobiz.exSql("select getChildDeptLst("+emp.getDepartment().getId()+")");
		
		
		String hql="from SaleOrder as tb where 1=1 and delflag!='1' and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
		" and tb.employee.department.id in ("+sonIds+")))";
		
		
		String dpage=request.getParameter("pageNo");
		int pageNo=0;
		if(dpage!=null){
		   pageNo=1;
		}
		
		String realname="";
		String questionname="";
		String typename="";
		String auditingState="";
		String salename = "";
		try {
			realname = URLDecoder.decode(so.getCustomer().getRealName(),"utf-8");
			questionname= URLDecoder.decode(so.getAllTypeByOrdertype().getQuestionName(),"utf-8");
			typename=URLDecoder.decode(so.getAllTypeByPayStatus().getTypeName(), "utf-8");
			auditingState=URLDecoder.decode(so.getAuditingState(), "utf-8");
			salename=URLDecoder.decode(request.getParameter("salename"), "utf-8");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		// 根据客户名称查找出对应的客户信息
		List<Customer> customer  = new ArrayList();
		if(!StringUtil.isnull(realname)){
			String chql=" from Customer where realName like '%"+realname+"%'"; 
			customer = sobiz.getList(chql);
		}
		// 根据输入的订单类型查找
		List<Questioncategory> question  = new ArrayList();
		if(!StringUtil.isnull(questionname)){
			String ohql=" from Questioncategory  where questionName like  '%"+questionname+"%'";
			question = sobiz.getList(ohql);
		}
		// 根据输入的使用状态查找
		List<AllType> type = new ArrayList();
		if(!StringUtil.isnull(typename)){
			String shql=" from AllType where typename like '%"+typename+"%'";
			type = sobiz.getList(shql);
		}
		// 根据销售员工名称查找销售人员信息
		List<Employee> emplist = new ArrayList();
		if(!StringUtil.isnull(salename)){
			String ehql="FROM Employee WHERE NAME LIKE '%"+salename+"%' ";
			emplist =sobiz.getList(ehql);
		}
		
		//String hql="from SaleOrder where delflag=0 ";
		if(auditingState.trim().length()>0){
		   auditingState = auditingState.substring(0, 1);
		}
		System.out.println(auditingState);
		if(auditingState.equals("未")){
			hql +="and auditingState=0";
		}
		if(auditingState.equals("已")){
			hql +="and auditingState=1 or auditingState=2 ";
		}
		if(so.getSaleOrderNo().trim().length()>0){
			hql +=" and saleOrderNo like '%"+so.getSaleOrderNo()+"%'";
		}
		if(so.getCustomer().getRealName().trim().length()>0){
	        String customerid="";
			for(int i=0;i<customer.size();i++){
				customerid +=","+customer.get(i).getCustomerId();
			}
			if(customer.size()<=0){
				customerid="''";
			}
			customerid = customerid.replaceFirst(",", "");
			hql +=" and customer_id in ("+customerid+")";
		}
		if(salename.trim().length()>0){
			
			hql += " and employee.name like '%"+salename+"'%";
		}
		if(so.getAllTypeByOrdertype().getQuestionName().trim().length()>0){
			String questionid="";
			for (int i = 0; i < question.size(); i++) {
				questionid+=","+question.get(i).getId();
			}
			if(question.size()<=0){
				questionid+="''";
			}
			questionid=questionid.replaceFirst(",", "");
			hql +=" and ordertype in(" +questionid+")";
		}
		if(so.getAllTypeByPayStatus().getTypeName().trim().length()>0){
			String typeid="";
			for (int i = 0; i < type.size(); i++) {
				typeid+=","+type.get(i).getId();
			}
			if(type.size()<=0){
				typeid+="''";
			}
			typeid = typeid.replaceFirst(",", "");
			hql +=" and pay_status in("+typeid+")";
		}
		if(salename !=null && salename.trim().length()>0){
			String empids = "";
			for (Iterator it = emplist.iterator(); it.hasNext();) {
				Employee e = (Employee) it.next();
				empids +=","+e.getId();
			}
			if(emplist.size()<= 0){
				empids +="''";
			}
			empids = empids.replaceFirst(",", "");
			hql += " and tb.employee.id in("+empids+")";
		}
		if(so.getBeginTime().trim().length()>0 ){
			hql +=" and beginTime>='"+so.getBeginTime()+"'";
		}
		if(so.getEndTime().trim().length()>0){
			hql +=" and endTime<='"+so.getEndTime()+"'";
		}
		//筛选条件:根据客户类型(意向客户、试用客户、正式客户、审核客户)
		if(null !=so.getPrice() && so.getPrice()!=0){
			hql +=" and price="+so.getPrice();
		}
		//查询分页
		if(null !=so.getPrice() && so.getPrice()!=0){
			hql +=" and price="+so.getPrice();
		}
		if(request.getParameter("pageNo") == null || request.getParameter("pageNo").equals(""))
		{
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}
		else
		{
			request.getSession().setAttribute("hql", hql);
		}
		logger.info("hql----"+hql);
		Pages pages=sobiz.select(hql, pageNo, 10, null);
		//orderlist=sobiz.getList(hql);
		try {
			String str="";
			for(int i=0;i<pages.getPageList().size();i++){
				SaleOrder s = new SaleOrder();
				s = (SaleOrder)pages.getPageList().get(i);
				String state="";
				String img="";			
				
				if(s.getAuditingState().equals("0")||s.getAuditingState().trim().length()<=0){
					state="未审核";
					img="<IMG style='CURSOR: hand' onclick='valEdit('"+s.getSaleOrderNo()+"','updatesaleOrder.do?id="+s.getId()+"')' hspace=2 src='"+request.getContextPath()+"/img/del.gif'  border=0>";
				}
				if(s.getAuditingState().equals("1")||s.getAuditingState().equals("2")){
					state="已审核";
					img="<a href='javascript:void();' onclick='return del("+s.getId()+");'><img src='"+request.getContextPath()+"/images/res.gif' width='20px' height='20px' border=0 ></a>";
				}
				if(s.getAuditingState().equals("8")){
					state="审核进行中";
					img="<IMG style='CURSOR: hand' onclick='valEdit('"+s.getSaleOrderNo()+"','updatesaleOrder.do?id="+s.getId()+"')' hspace=2 src='"+request.getContextPath()+"/images/res.gif'  border=0>";
				}
				str +="<tr><td align=center><a href='infosaleOrder.do?id="+s.getId()+"'>"+s.getSaleOrderNo()+"</a></td><td align=center>"+s.getCustomer().getRealName()+"</td><td align=center>"+s.getAllTypeByOrdertype().getQuestionName()+"</td><td align=center>" +
						s.getAllTypeByPayStatus().getTypeName()+"</td><td align=center>"+s.getBeginTime()+"</td><td align=center>"+s.getEndTime()+"</td><td align=center>"+state+"</td><td align=center><a href='infosaleOrder.do?info=info&id="+s.getId()+"'>详细信息</a></td>" +
						"<td align=center><a href='followAuditing.do?orderNo="+s.getSaleOrderNo()+"'>流程跟踪</a></td><td align=center>"+s.getPrice()+"</td><td align=center>"+s.getEmployee().getName()+"</td><td align=center>" +
						img+"</td></tr>";
			}
			pages.setUrl("getOrderListsaleOrder.do?type2=1&tage=y&funid=179");//selectsaleOrder.do
			str+="#"+pages.getHtml("selectcustomer");
//			str="123456#11111111111";
			System.out.println(str);
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}		
		
		
		return null;
	}

	/**
	 * 查询快到期动态数据
	 */
	@SuppressWarnings("unchecked")
	public String kdq(){
		
		String dpage=request.getParameter("pageNo");
		int pageNo=0;
		// 已到期查询
//		String hql="from SaleOrder where delflag=0 ";// 已到期
	    String hql = "from UpServer u,SaleOrder s where u.saleOrder.id=s.id";
	    List<Map<String, String>> listmap=new ArrayList<Map<String,String>>();
		if(null == dpage){
			pageNo=1;
		}else{
			pageNo=Integer.parseInt(dpage);
		}
		
		String saleOrderNo = "";//销售订单编号 .
		String upserverNo = "";//上架单编号
		String realname="";   // 客户
		String questionname=""; //订单类型
		String salename=""; // 销售人员 .
		String typename=""; // 付费类型
		//String paystas=""; // 付费状态
		
		
		try {
			saleOrderNo = request.getParameter("saleOrderNo");
			
			upserverNo = request.getParameter("upserverNo");
			if( upserverNo != null){
				upserverNo=URLDecoder.decode(upserverNo,"utf-8");
			}
			realname = request.getParameter("realName");
			if(realname != null){
				realname = URLDecoder.decode(realname,"utf-8");//
			}
			questionname  = request.getParameter("questionname");
			if(questionname != null){
				questionname= URLDecoder.decode(questionname,"utf-8");//
			}
			salename = request.getParameter("saleName");
			if(salename != null ){
				salename=URLDecoder.decode(salename,"utf-8");
			}
			typename = request.getParameter("typeName");
			if(typename != null){
				typename= URLDecoder.decode(typename,"utf-8");//
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		// 根据客户名称查找出对应的客户信息
		List<Customer> customer  = new ArrayList();
		if(!StringUtil.isnull(realname)){
			String chql=" from Customer where realName like '%"+realname+"%'"; 
			customer = sobiz.getList(chql);
		}
		// 根据输入的订单类型查找
		List<Questioncategory> question  = new ArrayList();
		if(!StringUtil.isnull(questionname)){
			String ohql=" from Questioncategory  where questionName like  '%"+questionname+"%'";
			question = sobiz.getList(ohql);
		}
		// 根据输入的使用状态查找
		List<AllType> type = new ArrayList();
		if(!StringUtil.isnull(typename)){
			String shql=" from AllType where typename like '%"+typename+"%'";
			type = sobiz.getList(shql);
		}
		// 根据销售员工名称查找销售人员信息
		List<Employee> emp = new ArrayList();
		if(!StringUtil.isnull(salename)){
			String ehql="FROM Employee WHERE NAME LIKE '%"+salename+"%' ";
			emp =sobiz.getList(ehql);
		}
	    String nowdatestr = TimePattern.doTimeDf3(new Date());
		// 判断是快到期还是已到期
	if(so.getAllTypeByPayStatus()!=null){
		if(so.getAllTypeByPayStatus().getType()==1){
			hql +=" and DATEDIFF(downtime,'"+nowdatestr+"')>0 AND DATEDIFF(downtime,'"+nowdatestr+"')<=15";
		}
		if(so.getAllTypeByPayStatus().getType()==0){
			hql +="  and datediff(downtime,'"+nowdatestr+"')<=0";
		}
	}
	
	//if(saleOrderNo !=null){	
		if(saleOrderNo!=null && saleOrderNo.trim().length()>0){
			hql +=" and saleOrderNo like '%"+so.getSaleOrderNo()+"%'";
		}
		if(realname != null && realname.trim().length()>0){
	        String customerid="";
			for(int i=0;i<customer.size();i++){
				customerid +=","+customer.get(i).getCustomerId();
			}
			if(customer.size()<=0){
				customerid="''";
			}
			customerid = customerid.replaceFirst(",", "");
			hql +=" and customer_id in ("+customerid+")";
		}
		if(questionname != null && questionname.trim().length()>0){
			String questionid="";
			for (int i = 0; i < question.size(); i++) {
				questionid+=","+question.get(i).getId();
			}
			if(question.size()<=0){
				questionid+="''";
			}
			questionid=questionid.replaceFirst(",", "");
			hql +=" and ordertype in(" +questionid+")";
		}
		if(typename != null && typename.trim().length()>0){
			String typeid="";
			for (int i = 0; i < type.size(); i++) {
				typeid+=","+type.get(i).getId();
			}
			if(type.size()<=0){
				typeid+="''";
			}
			typeid = typeid.replaceFirst(",", "");
			hql +=" and pay_style in("+typeid+")";
		}
		if(salename !=null && salename.trim().length()>0){
			String empid="";
			for(int i=0;i<emp.size();i++){
				empid+=","+emp.get(i).getId();
			}
			if(emp.size()<=0){
				empid+="''";
			}
			empid=empid.replaceFirst(",","");
			hql+=" and u.saleOrder.employee.id in("+empid+")";
		}
	  if(upserverNo != null && upserverNo.trim().length()>0){
		  hql += " and u.upNo like '%"+upserverNo+"%'";
	  }
		
	  
//		if(so.getBeginTime().trim().length()>0 ){
//			hql +=" and beginTime>='"+so.getBeginTime()+"'";
//		}
//		
//		if(request.getParameter("endtime")!=null){
//			hql += " and u.uptime ='"+request.getParameter("endtime")+"'";
//		}
		
//		if(request.getParameter("uptime")!=null){
//			String dd = request.getParameter("uptime");
//			hql += " and u.uptime ='"+request.getParameter("uptime")+"'";
//		}
//		if(request.getParameter("downtime")!=null){
//			String dd = request.getParameter("downtime");
//			hql += " and u.downtime ='"+request.getParameter("downtime")+"'";
//		}
		
//		if(null !=so.getPrice() && so.getPrice()!=0){
//			hql +=" and price="+so.getPrice();
//		}
	//}
	  logger.info("hql:+++"+hql);
		Pages pages=sobiz.select(hql, pageNo, 20, null);
		if(pages.getPageList()!=null){
			for(int i=0;i<pages.getPageList().size();i++){
				Map<String,String> map=new HashMap<String, String>();
				System.out.println(pages.getPageList().get(0));
				Object[] obj = (Object[])pages.getPageList().get(i);
				if(obj!=null&&obj.length>0){
				    UpServer up=(UpServer)obj[0];
				    SaleOrder saleorder=(SaleOrder)obj[1];
				    System.out.println(up.getUptime());
				    System.out.println(saleorder.getSaleOrderNo());
				    System.out.println(up.getSaleOrder().getCustomer().getCustomerName());
					map.put("saleOrderNo", saleorder.getSaleOrderNo());
					map.put("upserverId", up.getId().toString());
					map.put("upserverNo", up.getUpNo());
					map.put("customer", up.getSaleOrder().getCustomer().getRealName());
					map.put("ordertype", up.getSaleOrder().getAllTypeByOrdertype().getQuestionName());
					String paystatus=(up.getSaleOrder().getAllTypeByPayStatus().getType()==1?"快到期":"已到期");
					map.put("paystatus", paystatus);
					map.put("begintime", up.getSaleOrder().getBeginTime());
					map.put("uptime", up.getUptime().toString());
					map.put("downtime", up.getDowntime().toString());
					map.put("salename", up.getSaleOrder().getEmployee().getName());
					map.put("paystyle", up.getSaleOrder().getAllTypeByPayStyle().getTypeName());
					map.put("price", up.getSaleOrder().getPrice().toString());
					map.put("id", up.getSaleOrder().getId().toString());
					map.put("cid", up.getSaleOrder().getCustomer().getCustomerId().toString());
					map.put("eid", up.getSaleOrder().getEmployee().getId().toString());
					listmap.add(map);
				}
			}
		}

		try {
			//String str="";
			  if(request.getParameter("tage") != null && request.getParameter("tage").equals("s")){
					PropertyEditor property = new PropertyEditor();
					String strr="";
					String str="";
					if(null != listmap && listmap.size()>0)
					{
						for(int i=0; i<listmap.size(); i++)
						{
							Map<String,String> m=listmap.get(i);
							str=property.getID("kdqsaleOrder").toString();
						    str = str.replace("#saleOrderNo#", m.get("saleOrderNo"));
						    str = str.replace("#upserverId#", m.get("upserverId"));//
						    str = str.replace("#upserverNo#", m.get("upserverNo"));//
						    
							str = str.replace("#customer#", m.get("customer"));
							str = str.replace("#ordertype#",m.get("ordertype"));
							str = str.replace("#paystatus#",m.get("paystatus"));
							str = str.replace("#begintime#", m.get("begintime"));
							str = str.replace("#uptime#",m.get("uptime"));
							str = str.replace("#downtime#",m.get("downtime"));
							str = str.replace("#salename#",m.get("salename"));
							str = str.replace("#paystyle#", m.get("paystyle"));
							str = str.replace("#price#", m.get("price"));
							str = str.replace("#id#", m.get("id"));// 订单编号
							str = str.replace("#cid#",m.get("cid"));// 客户编号
							str = str.replace("#eid#",m.get("eid"));// 员工编号
							strr +=str;		
						}
						if(so.getAllTypeByPayStatus().getType()==1){
						   pages.setUrl("kdqsaleOrder.do?allTypeByPayStatus.type=1&funid=14");
						}else{
							pages.setUrl("kdqsaleOrder.do?allTypeByPayStatus.type=0&funid=14");
						}
					
						this.printOrderList(listmap);
						
					}  
					strr+="#"+pages.getHtml("selectcustomer");
					//清空listmap集合
					listmap.clear();
				   response.setCharacterEncoding("utf-8");
				   response.getWriter().print(strr);
				   //System.out.println(strr);
                   return null;
			   }
		} catch (IOException e) {
			e.printStackTrace();
		}		
		request.setAttribute("listmap", listmap);
		try{
			if(pages!=null){
			   this.printOrderList(listmap);
			}
		}catch (NullPointerException e) {
		}
		request.setAttribute("pages", pages);
		if(so.getAllTypeByPayStatus().getType()==1){
			return "kdq";
		}else{
			return "ydq";
		}
	}     
	
	/**
	 * 修改客户信息
	 */
	public String updateCustomer(){
		logger.info("updateCustomer");
		String customerid=so.getCustomer().getCustomerId().toString();
		logger.error(sobiz);
		this.data = (Customer) sobiz.getObj(Customer.class, customerid);
		logger.error(2222);
		Employee emp = new Employee();
		
		emp=(Employee)sobiz.getObj(Employee.class, so.getEmployee().getId().toString());
		String deptid=emp.getDepartment().getId().toString();
		this.data.setEmployee(emp);
		logger.error(333);
		Department dept=new Department();
	    dept=(Department)sobiz.getObj(Department.class, deptid);
	    logger.error(dept.getName());
		request.setAttribute("data", this.data);
		logger.error(555);
		return "updatecustomer";		
	}
	@SuppressWarnings("unchecked")
	public void printOrderList(List lis){
		//List list = new ArrayList();
//		 for(int i=0;i<lis.size();i++){
//			 SaleOrder saleOrder = (SaleOrder) lis.get(i);
//			 Map map= new HashMap();
//			 map.put("said", saleOrder.getSaleOrderNo());
//			 map.put("cuName",saleOrder.getCustomer().getRealName());
//			 map.put("typeName",saleOrder.getAllTypeByOrdertype().getQuestionName());
//			 map.put("quetime","快到期");
//			 map.put("statimes",saleOrder.getBeginTime());
//			 map.put("endtimes",saleOrder.getEndTime() );
//			 map.put("saName",saleOrder.getEmployee().getName());
//			 map.put("paperType", saleOrder.getAllTypeByPayStyle().getTypeName());
//			 map.put("prices",saleOrder.getPrice() );
//			 list.add(map);
//			
//		 }
		 System.out.println("sale="+lis);
	     request.getSession().setAttribute("exportOders", lis);
		}
	public void exportorders(){
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment;filename=allSalary.xls");
		System.out.println("order打印了。。。。");
		List rows = (List) request.getSession().getAttribute("exportOders");
		try {
			if("part".equals(oper)){
				this.getExcel(response.getOutputStream(),rows);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	public List<String> getHeadOrder(){
		List<String> tlist = new ArrayList<String>();
		tlist.add("订单号 ");
		tlist.add("客户 ");
		tlist.add("订单类型 ");
		tlist.add("使用状态  ");
		tlist.add("开始时间");
		tlist.add("到期时间 ");
		tlist.add("销售人员");
		tlist.add("合同类别");
		tlist.add("订单金额");
		return tlist;
	}
	public boolean getExcel(OutputStream fout,List list){
		
		try {
    
			HSSFWorkbook wbook = new HSSFWorkbook();
			
			HSSFSheet sheet = wbook.createSheet("查询日志");
			
			setTrainTitle(sheet,this.getHeadOrder());
			
			setTrainData(list,sheet);
			wbook.write(fout);
			fout.flush();
			fout.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public void setTrainTitle(HSSFSheet sheet,List<String>tlist){
		HSSFRow row = sheet.createRow(0);
		int i=0;
		for(String s : tlist){
			HSSFCell cell = row.createCell(i);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(s);
			i++;
		}
	}
	
	public void setTrainData(List list,HSSFSheet sheet){
		List tlist = list;
		for(int i=1;i<(tlist.size()+1);i++){
			HSSFRow row = sheet.createRow(i);
			Map map = (Map)tlist.get((i-1));
			List<Object> ins = this.getAllMap(map, i);
			//调用getParamsValue方法将一个实体转换成一个集合**
			for(int j = 0;j < ins.size(); j++){
				HSSFCell cell = row.createCell(j);
				//设置单元格为字符串类型
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				//设置内容
				String value = ins.get(j) == null?"无":ins.get(j).toString();
				//单元格赋值
				cell.setCellValue(value);
				//设置表格宽度
				sheet.setColumnWidth(j,6000);
			}
		}
	}
	public List getAllMap(Map map,int s){
		List ins = new ArrayList();
		//每取出一个对象将它封装到集合中
	    ins.add(map.get("saleOrderNo"));
	    ins.add(map.get("customer"));
	    ins.add(map.get("ordertype"));
	    ins.add(map.get("paystatus"));
	    ins.add(map.get("begintime"));
	    ins.add(map.get("downtime"));
	    ins.add(map.get("salename"));
	    ins.add(map.get("paystyle"));
	    ins.add(map.get("price"));
		return ins;
	}
	
	
	/**
	 * 财务统计功能
	 * @author 袁天龙
	 * 2012.9.26
	 */
//-----------------统计每个员工月份订单量-----------------------//
	//员工业绩
	public String ygyj(){
		//本月订单
		List list=yjDao.countNow();	
		System.out.println("by"+list.size());
		//上个月订单
		List lastmonthlist = yjDao.countLastMonth();
		System.out.println("sy"+lastmonthlist.size());
		//最近六个月订单
		List sixmonthlist = yjDao.countSixMonth();
		System.out.println("ly"+sixmonthlist.size());
		//所有员工订单总量
		List totallist = yjDao.countTotal();
		System.out.println("zl"+totallist.size());
		
		
		
		int maxlength = 0;
		maxlength = list.size();
		if(lastmonthlist.size()> maxlength)
			maxlength = lastmonthlist.size();
		if(sixmonthlist.size()>maxlength)
			maxlength = sixmonthlist.size();
		if(totallist.size() > maxlength)
			maxlength = totallist.size();
		Map<String, String[]>  map = new HashMap<String, String[]>();
		String[][] str = new String[maxlength][6];
		int num  = -1;
		int firstnum = 0 ;
		int lastmonth = 0;
		for (firstnum=0; firstnum < list.size(); firstnum++) {
		//	str[firstnum][0] = ""+firstnum;
			Object[] obj =  (Object[])list.get(firstnum);//[0]name[1]count
			str[firstnum][0] = obj[2].toString();
			Map<String, String> m=new HashMap<String, String>();
			System.out.println(obj[0].toString()+"--1--"+obj[1].toString());
			String keystr = obj[0].toString();//name
			String valuestr = obj[1].toString();//count
			//m.put(keystr,valuestr);
			//m.put("count", obj[1].toString());
			str[firstnum][1] = keystr;
			str[firstnum][2] = valuestr;
			map.put(keystr,str[firstnum] );
		}
		
		num = firstnum;
		if(num == 0){
			num = -1;
		}else{
			num = num -1;
		}
		for (lastmonth=0; lastmonth < lastmonthlist.size(); lastmonth++) {
		//	Map m =  (Map)list.get(i);
			Object[] obj = (Object[])lastmonthlist.get(lastmonth);
			Map m = new HashMap();
			String keystr = obj[0].toString();
			String valuestr = obj[1].toString();
			//m.put(keystr,valuestr);
			System.out.println(obj[0].toString()+"--2--"+obj[1].toString());
			if(map.containsKey(keystr)){
				String[] ss = (String[])map.get(keystr);
				ss[3] = valuestr;
			}else{
				num +=1;
				str[num][0]=obj[2].toString();
				str[num][1]=keystr;
				str[num][3] = valuestr;
				map.put(keystr, str[num]);
			}
		}
		
		
		for (int i = 0; i < sixmonthlist.size(); i++) {
		//	Map m =  (Map)list.get(i);
			Map m = new HashMap();
			Object[] obj = (Object[])sixmonthlist.get(i);
			String keystr = obj[0].toString();
			String valuestr = obj[1].toString();
			//String name = (String)m.get("name");
			System.out.println(obj[0].toString()+"--3--"+obj[1].toString());
			if(map.containsKey(keystr)){
				String[] ss = (String[])map.get(keystr);
				ss[4] = valuestr;
			}else{
				num +=1;
				str[num][0]=obj[2].toString();
				str[num][1]=keystr;
				str[num][4] = valuestr;
				map.put(keystr, str[num]);
			}
		}
		
		for (int i = 0; i < totallist.size(); i++) {
		//	Map m =  (Map)list.get(i);
			Map m = new HashMap();
			Object[] obj = (Object[])totallist.get(i);
			String keystr = obj[0].toString();
			String valuestr = obj[1].toString();
			//String name = (String)m.get("name");
			System.out.println(obj[0].toString()+"--4--"+obj[1].toString());
			if(map.containsKey(keystr)){
				String[] ss = (String[])map.get(keystr);
				ss[5] = valuestr;
			}else{
				num +=1;
				str[num][0]=obj[2].toString();
				str[num][1]=keystr;
				str[num][5] = valuestr;
				map.put(keystr, str[num]);
			}
		}
		
	for (Iterator it = map.keySet().iterator(); it.hasNext();) {
		String empname = (String)it.next();
		String[] tt2 = (String[])map.get(empname);
		System.out.println("key ="+empname);
		System.out.println("value ="+tt2[0]+" - "+tt2[1]+" - "+tt2[2]+" - "+tt2[3]+" - "+tt2[4]+" - "+tt2[5]);
	}
	    orderMoney();
		request.setAttribute("listmap",map);
		return "ygyj";
	}
	
//----------------------统计每个员工本月，上个月，最近6个月，总的订单金额-----//
	public String orderMoney(){
		//本月订单
		List list=yjDao.countNowMoney();	
		System.out.println("by"+list.size());
		//上个月订单
		List lastmonthlist = yjDao.countLastMonthMoney();
		System.out.println("sy"+lastmonthlist.size());
		//最近六个月订单
		List sixmonthlist = yjDao.countSixMonthMoney();
		System.out.println("ly"+sixmonthlist.size());
		//所有员工订单总量
		List totallist = yjDao.countTotalMoney();
		System.out.println("zl"+totallist.size());
		
		int maxlength = 0;
		maxlength = list.size();
		if(lastmonthlist.size()> maxlength)
			maxlength = lastmonthlist.size();
		if(sixmonthlist.size()>maxlength)
			maxlength = sixmonthlist.size();
		if(totallist.size() > maxlength)
			maxlength = totallist.size();
		Map<String, String[]>  map = new HashMap<String, String[]>();
		String[][] str = new String[maxlength][6];
		int num  = -1;
		int firstnum = 0 ;
		int lastmonth = 0;
		for (firstnum=0; firstnum < list.size(); firstnum++) {
			Object[] obj =  (Object[])list.get(firstnum);//[0]name[1]count
			str[firstnum][0] = obj[2].toString();
			Map<String, String> m=new HashMap<String, String>();
			System.out.println(obj[0].toString()+"--1--"+obj[1].toString());
			String keystr = obj[0].toString();//name
			String valuestr = obj[1].toString();//count
			//m.put(keystr,valuestr);
			//m.put("count", obj[1].toString());
			str[firstnum][1] = keystr;
			str[firstnum][2] = valuestr;
			map.put(keystr,str[firstnum] );
		}
		
		num = firstnum;
		if(num == 0){
			num = -1;
		}else{
			num = num -1;
		}
		for (lastmonth=0; lastmonth < lastmonthlist.size(); lastmonth++) {
		//	Map m =  (Map)list.get(i);
			Object[] obj = (Object[])lastmonthlist.get(lastmonth);
			Map m = new HashMap();
			String keystr = obj[0].toString();
			String valuestr = obj[1].toString();
			//m.put(keystr,valuestr);
			System.out.println(obj[0].toString()+"--2--"+obj[1].toString());
			if(map.containsKey(keystr)){
				String[] ss = (String[])map.get(keystr);
				ss[3] = valuestr;
			}else{
				num +=1;
				str[num][0]=obj[2].toString();
				str[num][1]=keystr;
				str[num][3] = valuestr;
				map.put(keystr, str[num]);
			}
		}
		
		
		for (int i = 0; i < sixmonthlist.size(); i++) {
		//	Map m =  (Map)list.get(i);
			Map m = new HashMap();
			Object[] obj = (Object[])sixmonthlist.get(i);
			String keystr = obj[0].toString();
			String valuestr = obj[1].toString();
			//String name = (String)m.get("name");
			System.out.println(obj[0].toString()+"--3--"+obj[1].toString());
			if(map.containsKey(keystr)){
				String[] ss = (String[])map.get(keystr);
				ss[4] = valuestr;
			}else{
				num +=1;
				str[num][0]=obj[2].toString();
				str[num][1]=keystr;
				str[num][4] = valuestr;
				map.put(keystr, str[num]);
			}
		}
		
		for (int i = 0; i < totallist.size(); i++) {
		//	Map m =  (Map)list.get(i);
			Map m = new HashMap();
			Object[] obj = (Object[])totallist.get(i);
			String keystr = obj[0].toString();
			String valuestr = obj[1].toString();
			//String name = (String)m.get("name");
			System.out.println(obj[0].toString()+"--4--"+obj[1].toString());
			if(map.containsKey(keystr)){
				String[] ss = (String[])map.get(keystr);
				ss[5] = valuestr;
			}else{
				num +=1;
				str[num][0]=obj[2].toString();
				str[num][1]=keystr;
				str[num][5] = valuestr;
				map.put(keystr, str[num]);
			}
		}
		
	for (Iterator it = map.keySet().iterator(); it.hasNext();) {
		String empname = (String)it.next();
		String[] tt2 = (String[])map.get(empname);
		System.out.println("key ="+empname);
		System.out.println("value ="+tt2[0]+" - "+tt2[1]+" - "+tt2[2]+" - "+tt2[3]+" - "+tt2[4]+" - "+tt2[5]);
	}
		request.setAttribute("moneymap",map);
		return "ygyj";
	}

	
	/**
	 * 点击详细信息,查看某员工的成单量分析
	 * @return
	 */
	public String showCdlfx(){
		empid = (Integer)request.getAttribute("empid");
	//	List olist = yjDao.orderInfo(empid);
		Date d = new Date();
		int mon = d.getMonth()+1;
		int[] monarr = new int[mon];
		List<Object[]> list=new ArrayList<Object[]>();
		List<Object[]> list2=new ArrayList<Object[]>();
		for(int i=0;i<mon;i++){
			int j = (i+1);
			Object[] obj = new Object[6];
			obj[0]=j;
			List olist = yjDao.orderInfo(empid,j);
			int num=0;
			int paystyle=0;
			int count=0;
			for(int a=0;a<olist.size();a++){
				Object[] object = (Object[])olist.get(a);
				num=Integer.parseInt(object[1].toString());
				paystyle = Integer.parseInt(object[2].toString());
				if(paystyle==15){
				    obj[1]=num;
				    count+=num;
				}
				//季付
				if(paystyle==16){
					obj[2]=num;
					count+=num;
				}
				//半年付
				if(paystyle==17){
					obj[3]=num;
					count+=num;
				}
				//年付
				if(paystyle==18){
					obj[4]=num;
					count+=num;
				}
			}
			if(olist.size()<=0){
				obj[1]=0;
				obj[2]=0;
				obj[3]=0;
				obj[4]=0;
				obj[5]=0;
			}
			obj[5]=count;
			list.add(obj);
		}
		
		request.setAttribute("olist", list);
		cldfxBefore();
		cdlfxTotal();
		
		cdlfxMoney();
		cdlfxBeforeMoney();
		totalMoney();
		return "cdlfx";
	}
	
	/**
	 * 成单量分析  以前
	 * @return
	 */
	public String cldfxBefore(){
		Calendar ca = Calendar.getInstance();
		int year = (ca.get(Calendar.YEAR))-1;
		empid = (Integer)request.getAttribute("empid");
		List blist = yjDao.orderBefore(empid, year);
		List<Object[]> list = new ArrayList<Object[]>();
		int yf=0;
		int jf=0;
		int bnf=0;
		int nf=0;
		int count=0;
		int paystyle=0;
		Object[] object = new Object[5];
		for(int i=0;i<blist.size();i++){
			Object[] obj = (Object[])blist.get(i);
			paystyle=Integer.parseInt(obj[1].toString()); // 付款方式
			if(paystyle==15){
				yf=Integer.parseInt(obj[0].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){ //季付
				jf=Integer.parseInt(obj[0].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Integer.parseInt(obj[0].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Integer.parseInt(obj[0].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		
			if(blist.size()<=0){
				object[0]=0;
				object[1]=0;
				object[2]=0;
				object[3]=0;
				object[4]=0;
			}
			object[4]=count;
			list.add(object);
			
		request.setAttribute("blist", list);
		return "cdlfx";
	}
	
	/**
	 * 成单量分析  总计
	 * @return
	 */
	public String cdlfxTotal(){
		empid = (Integer)request.getAttribute("empid");
		List tlist = yjDao.orderTotal(empid);
		List<Object[]> totallist = new ArrayList<Object[]>();
		Object[] object = new Object[5];
		int paystyle=0;
		int yf=0;
		int jf=0;
		int bnf=0;
		int nf=0;
		int count=0;
		for(int i=0;i<tlist.size();i++){
			Object[] obj = (Object[])tlist.get(i);
			paystyle=Integer.parseInt(obj[1].toString());
			if(paystyle==15){
				yf=Integer.parseInt(obj[0].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){
				jf=Integer.parseInt(obj[0].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Integer.parseInt(obj[0].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Integer.parseInt(obj[0].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		if(tlist.size()<=0){
			object[0]=0;
			object[1]=0;
			object[2]=0;
			object[3]=0;
			object[4]=0;
			totallist.add(object);
		}
		object[4]=count;
		totallist.add(object);
		request.setAttribute("tlist", totallist);
		return "cdlfx";
	}
	
	/**
	 * 成单量分析   某个员工每个月金额
	 * @return
	 */
	public String cdlfxMoney(){
		empid = (Integer)request.getAttribute("empid");
		Date d = new Date();
		int mon = d.getMonth()+1;
		int[] monarr = new int[mon];
		List<Object[]> list=new ArrayList<Object[]>();
		for(int i=0;i<mon;i++){
			int j = (i+1);
			Object[] obj = new Object[6];
			obj[0]=j;
			List olist = yjDao.orderMoney(empid,j);
			double num=0; 
			int paystyle=0;
			double count=0;
			for(int a=0;a<olist.size();a++){
				Object[] object = (Object[])olist.get(a);
				num=Double.parseDouble(object[1].toString());
				paystyle = Integer.parseInt(object[2].toString());
				if(paystyle==15){
					obj[1]=num;
					count+=num;
				}
				//季付
				if(paystyle==16){
					obj[2]=num;
					count+=num;
				}
				//半年付
				if(paystyle==17){
					obj[3]=num;
					count+=num;
				}
				//年付
				if(paystyle==18){
					obj[4]=num;
					count+=num;
				}
			}
			if(olist.size()<=0){
				obj[1]=0;
				obj[2]=0;
				obj[3]=0;
				obj[4]=0;
				obj[5]=0;
			}
			obj[5]=count;
			list.add(obj);
		}
		
		request.setAttribute("mlist", list);
		return "cdlfx";
	}
	
	/**
	 * 成单量分析  以前金额
	 * @return
	 */
	public String cdlfxBeforeMoney(){
		Calendar ca = Calendar.getInstance();
		int year = (ca.get(Calendar.YEAR)-1);
		empid = (Integer)request.getAttribute("empid");
		List belist = yjDao.orderBeforeMoney(empid, year);
		List<Object[]> list = new ArrayList<Object[]>();
		double yf=0;
		double jf=0;
		double bnf=0;
		double nf=0;
		double count=0;
		int paystyle=0;
		Object[] object = new Object[5];
		for(int i=0;i<belist.size();i++){
			Object[] obj = (Object[])belist.get(i);
			paystyle=Integer.parseInt(obj[1].toString()); // 付款方式
			if(paystyle==15){
				yf=Double.parseDouble(obj[0].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){ //季付
				jf=Double.parseDouble(obj[0].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Double.parseDouble(obj[0].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Double.parseDouble(obj[0].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		
			if(belist.size()<=0){
				object[0]=0;
				object[1]=0;
				object[2]=0;
				object[3]=0;
				object[4]=0;
			}
			object[4]=count;
			list.add(object);
			
		request.setAttribute("blist2", list);
		return "cdlfx";
	}
	
	/**
	 * 成单量分析  总计金额
	 * @return
	 */
	public String totalMoney(){
		empid = (Integer)request.getAttribute("empid");
		List list = yjDao.orderTotalMoney(empid);
		List<Object[]> totallist = new ArrayList<Object[]>();
		Object[] object = new Object[5];
		int paystyle=0;
		double yf=0;
		double jf=0;
		double bnf=0;
		double nf=0;
		double count=0;
		for(int i=0;i<list.size();i++){
			Object[] obj = (Object[])list.get(i);
			paystyle=Integer.parseInt(obj[1].toString());
			if(paystyle==15){
				yf=Double.parseDouble(obj[0].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){
				jf=Double.parseDouble(obj[0].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Double.parseDouble(obj[0].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Double.parseDouble(obj[0].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		if(list.size()<=0){
			object[0]=0;
			object[1]=0;
			object[2]=0;
			object[3]=0;
			object[4]=0;
			totallist.add(object);
		}
		object[4]=count;
		totallist.add(object);
		request.setAttribute("tolist", totallist);
		return "cdlfx";
	}
	
	
	//---------统计季付、半年付、年付订单数量-----------//
	public String tjByMonth(){
		Date d=new Date();
		int mon= d.getMonth()+1;
		int[] monarr=new int[mon];
		List<Object[]> list=new ArrayList<Object[]>();
		List<Object[]> list2=new ArrayList<Object[]>();
		for(int i=0;i<mon;i++){
			int j=(i+1);// 得到当前月.
			Object[] obj=new Object[6];
			obj[0]=j;
			List tjlist = yjDao.tj(j);
			int num=0;
			int paystyle=0;
			int count=0;
			for(int a=0;a<tjlist.size();a++){
			   Object[] o =(Object[])tjlist.get(a);
			   num=Integer.parseInt(o[1].toString());
			   paystyle = Integer.parseInt(o[2].toString());
			    // 15 代表月付
			    if(paystyle==15){
			      obj[1]=num;
			      count+=num;
			    }
				// 16 代表是季付
				if(paystyle==16){
				   obj[2]=num;
				   count=count+num;
				}
				//17 ==>半年付
				if(paystyle==17){
				   obj[3]=num;
				   count=count+num;
				}
				//18 ==>年付
				if(paystyle==18){
				   obj[4]=num;
				   count=count+num;
				}
			}
			if(tjlist.size()<=0){
				obj[1]=0;
				obj[2]=0;
				obj[3]=0;
				obj[4]=0;
				obj[5]=0;
			}
			obj[5]=count;
			list.add(obj);
		}
		System.out.println("--------");
		for(int i=0;i<list.size();i++){
			Object[] o=list.get(i);
			System.out.println("月："+o[0]+"，"+",月付:"+o[1]+"季付："+o[2]+",半年付："+o[3]+"，年付："+o[4]+"，总素:"+o[5]);
		}
		System.out.println("fff");
		request.setAttribute("li", list);
		request.setAttribute("li2", list2);
		
		tjMoneyByMonth();
		countBefore();
		countBeforeMoney();
		countTotal();
		countTotalMoney();
		return "qtcdl";
	}
	
	/**
	 * 统计以前(当前年之前的总订单数量)
	 * @return
	 */
	public String countBefore(){
		Calendar ca = Calendar.getInstance();
		int year = (ca.get(Calendar.YEAR))-1;
		List blist = yjDao.countBefore(year);
		List<Object[]> list = new ArrayList<Object[]>();
		int yf=0; // 月付
		int jf=0; // 季付
		int bnf=0; // 半年付
		int nf=0;  //年付
		int count=0; //总计
		int paystyle=0; //付款方式
		Object[] object = new Object[5];
		for(int i=0;i<blist.size();i++){
			Object[] obj = (Object[])blist.get(i);
			paystyle=Integer.parseInt(obj[2].toString()); // 付款方式
			if(paystyle==15){
				yf=Integer.parseInt(obj[1].toString());
				obj[0]=yf;
				count+=yf;
			}
			if(paystyle==16){ //季付
				jf=Integer.parseInt(obj[1].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Integer.parseInt(obj[1].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Integer.parseInt(obj[1].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		
			if(blist.size()<=0){
				object[0]=0;
				object[1]=0;
				object[2]=0;
				object[3]=0;
				object[4]=0;
			}
			object[4]=count;
			list.add(object);
			
			request.setAttribute("before", list);
			return "qtcdl";
	}
	
	
	/**
	 * 统计以前的 季付 半年付 年付的金额
	 */
	public String countBeforeMoney(){
		Calendar ca = Calendar.getInstance();
		int year = (ca.get(Calendar.YEAR)-1);
		List jlist = yjDao.countBeforeJe(year);
		List<Object[]> jelist = new ArrayList<Object[]>();
		Object[] object = new Object[5];
		int paystyle=0; //支付方式
		double yf=0;
		double jf=0; //季付金额
		double bnf=0; // 半年付金额
		double nf=0; //年付金额
		double count=0; //总计金额
		for(int i=0;i<jlist.size();i++){
			Object[] obj = (Object[])jlist.get(i);
			paystyle=Integer.parseInt(obj[2].toString()); //得到支付方式
			if(paystyle==15){
				yf=Double.parseDouble(obj[1].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){ //季付
				jf=Double.parseDouble(obj[1].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Double.parseDouble(obj[1].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Double.parseDouble(obj[1].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		
		if(jlist.size()<=0){
			object[0]=0;
			object[1]=0;
			object[2]=0;
			object[3]=0;
			object[4]=0;
			jelist.add(object);
		}
		object[4]=count;
		jelist.add(object);
		request.setAttribute("beforem", jelist);
		return "qtcdl";
	}
	
	//-----------统计季付、半年付、年付订单的金额--------//
	public String tjMoneyByMonth(){
		Date date = new Date();
		int mon = date.getMonth()+1;  //得到当前月
		List<Object[]> list = new ArrayList<Object[]>();
		for(int i=0;i<mon;i++){
			int j=(i+1);// 得到当前月.
			Object[] obj=new Object[6];
			obj[0]=j;
			List tjlist = yjDao.countMoney(j);
			double num=0;
			int paystyle=0;
			double count=0;
			for(int a=0;a<tjlist.size();a++){
			   Object[] o =(Object[])tjlist.get(a);
			   num=Double.parseDouble(o[1].toString());
			   paystyle = Integer.parseInt(o[2].toString());
			    if(paystyle==15){
			    	obj[1]=num;
			    	count+=num;
			    }
				// 16 代表是季付
				if(paystyle==16){
				   obj[2]=num;
				   count=count+num;
				}
				//17 ==>半年付
				if(paystyle==17){
				   obj[3]=num;
				   count=count+num;
				}
				//18 ==>年付
				if(paystyle==18){
				   obj[4]=num;
				   count=count+num;
				}
			}
			if(tjlist.size()<=0){
				obj[1]=0;
				obj[2]=0;
				obj[3]=0;
				obj[4]=0;
				obj[5]=0;
			}
			obj[5]=count;
			list.add(obj);
		}
		System.out.println("--------");
		for(int i=0;i<list.size();i++){
			Object[] o=list.get(i);
			System.out.println("月："+o[0]+"，"+"季付："+o[1]+",半年付："+o[2]+"，年付："+o[3]+"，总素:"+o[4]);
		}
		System.out.println("fff");
		request.setAttribute("li2", list);
		return "qtcdl";
	}
	
	/**
	 * 统计总的季付、半年付、年付的订单数量 (总计)
	 * @return
	 */
	public String countTotal(){
		List total = yjDao.selTotal();
		List<Object[]> totallist = new ArrayList<Object[]>();
		Object[] object = new Object[5];
		int yf=0;
		int paystyle=0;
		int jf=0;
		int bnf=0;
		int nf=0;
		int count=0;
		for(int i=0;i<total.size();i++){
			Object[] obj = (Object[])total.get(i);
			paystyle=Integer.parseInt(obj[1].toString());
			if(paystyle==15){
				yf=Integer.parseInt(obj[0].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){
				jf=Integer.parseInt(obj[0].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Integer.parseInt(obj[0].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Integer.parseInt(obj[0].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		if(total.size()<=0){
			object[0]=0;
			object[1]=0;
			object[2]=0;
			object[3]=0;
			object[4]=0;
			totallist.add(object);
		}
		object[4]=count;
		totallist.add(object);
		request.setAttribute("totallist", totallist);
		return "qtcdl";
	}
	
	/**
	 * 统计总的季付、半年付、年付订单的金额 (总计)
	 * @return
	 */
	public String countTotalMoney(){
		List totalmoney = yjDao.selTotalMoney();
		List<Object[]> list = new ArrayList<Object[]>();
		Object[] object = new Object[5];
		int paystyle=0;
		double yf=0;
		double jf=0;
		double bnf=0;
		double nf=0;
		double count=0;
		for(int i=0;i<totalmoney.size();i++){
			Object[] obj = (Object[])totalmoney.get(i);
			paystyle=Integer.parseInt(obj[1].toString());
			if(paystyle==15){
				yf=Double.parseDouble(obj[0].toString());
				object[0]=yf;
				count+=yf;
			}
			if(paystyle==16){
				jf=Double.parseDouble(obj[0].toString());
				object[1]=jf;
				count+=jf;
			}
			if(paystyle==17){
				bnf=Double.parseDouble(obj[0].toString());
				object[2]=bnf;
				count+=bnf;
			}
			if(paystyle==18){
				nf=Double.parseDouble(obj[0].toString());
				object[3]=nf;
				count+=nf;
			}
		}
		
		if(totalmoney.size()<=0){
			object[0]=0;
			object[1]=0;
			object[2]=0;
			object[3]=0;
			object[4]=0;
			list.add(object);
		}
		object[4]=count;
		list.add(object);
		request.setAttribute("totalmoney", list);
		return "qtcdl";
	}
	
	
	

  }
	
