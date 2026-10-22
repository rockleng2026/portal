package com.fuao.fajxc.action.stockpile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;

import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.DepotBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.commodity.BatchBusiness;
import com.fuao.fajxc.bussiness.commodity.BatchexpBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityModelBussiness;
import com.fuao.fajxc.bussiness.commodity.ProductBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.purchase.ToOrderBussiness;
import com.fuao.fajxc.bussiness.stockpile.IncomeBussiness;
import com.fuao.fajxc.bussiness.stockpile.WarehousingBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.dao.system.AuditingOrderDao;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Batch;
import com.fuao.fajxc.vo.Batchexp;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Income;
import com.fuao.fajxc.vo.IncomeInfo;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.Supplier;
import com.fuao.fajxc.vo.ToOrder;
import com.fuao.fajxc.vo.ToOrderprinfo;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/** * 
 * 陈萌
 * 2011-08-04
 * 入库单Action *
 */
public class WarehousingAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {	
	private Storage storage;							// 入库表
	private Users user ;	 							// 用户表	

	private CustomerBussiness customerBussiness;		// 客户信息BIZ
	private WarehousingBussiness warehousingBussiness;	// 入库单BIZ
	private BatchexpBussiness batchexpBussiness;		// 批次详表BIZ
	private SupplierBussiness supplierBussiness;		// 供应商BIZ
	private EmployeeBussiness empBussiness;				// 员工信息biz
	private CommodityBussiness commbizimpl;				// 产品表biz
	private DepotBussiness depotBussiness;				// 仓库表BIZ
	private ProductBussiness productBussiness ;			// 产品表BIZ
	private ToOrderBussiness toOrderBussiness;			// 到货表BIZ
	private AuditingBussiness audBussiness;
	private IncomeBussiness incomeBussiness;            //报益单BIZ
	private ExecuteRecordBussiness executeRecordBussiness;//记录动态信息
	
	private Logger logger = Logger.getLogger(WarehousingAction.class);
	
	//公共变量
	private final static String error= "error";

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}
	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}


	Cookies ck=new Cookies();
	
	
	public IncomeBussiness getIncomeBussiness() {
		return incomeBussiness;
	}
	public void setIncomeBussiness(IncomeBussiness incomeBussiness) {
		this.incomeBussiness = incomeBussiness;
	}
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}
	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}


	private HttpServletRequest request;					// Request
	private HttpServletResponse response;				// Response
	private Object[] ids;								// 对象数组	
	
	//获得入库单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	
	private String strPrice;		//获得价格字符串
	private String strCount;		//获得价格字符串
	private String strCode;			//获得价格字符串
	
	private String strToOrderId;	// 到货单ID
	
	
	
	
	public BatchexpBussiness getBatchexpBussiness() {
		return batchexpBussiness;
	}
	public void setBatchexpBussiness(BatchexpBussiness batchexpBussiness) {
		this.batchexpBussiness = batchexpBussiness;
	}
	public String getStrToOrderId() {
		return strToOrderId;
	}
	public void setStrToOrderId(String strToOrderId) {
		this.strToOrderId = strToOrderId;
	}
	public String getStrCount() {
		return strCount;
	}
	public void setStrCount(String strCount) {
		this.strCount = strCount;
	}
	public ToOrderBussiness getToOrderBussiness() {
		return toOrderBussiness;
	}
	public void setToOrderBussiness(ToOrderBussiness toOrderBussiness) {
		this.toOrderBussiness = toOrderBussiness;
	}
	public ProductBussiness getProductBussiness() {
		return productBussiness;
	}
	public void setProductBussiness(ProductBussiness productBussiness) {
		this.productBussiness = productBussiness;
	}
	public String getStrPrice() {
		return strPrice;
	}
	public void setStrPrice(String strPrice) {
		this.strPrice = strPrice;
	}
	public String getStrCode() {
		return strCode;
	}
	public void setStrCode(String strCode) {
		this.strCode = strCode;
	}
 	public void setUser(Users user) {
 		this.user = user;
 	}
 	public CommodityBussiness getCommbizimpl() {
 		return commbizimpl;
 	}
 	public void setCommbizimpl(CommodityBussiness commbizimpl) {
 		this.commbizimpl = commbizimpl;
 	}
 	public DepotBussiness getDepotBussiness() {
 		return depotBussiness;
 	}
 	public void setDepotBussiness(DepotBussiness depotBussiness) {
 		this.depotBussiness = depotBussiness;
 	}
 	public CustomerBussiness getCustomerBussiness() {
 		return customerBussiness;
 	}
 	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
 		this.customerBussiness = customerBussiness;
 	}
 	public WarehousingBussiness getWarehousingBussiness() {
 		return warehousingBussiness;
 	}
 	public void setWarehousingBussiness(WarehousingBussiness warehousingBussiness) {
 		this.warehousingBussiness = warehousingBussiness;
 	}
 	public EmployeeBussiness getEmpBussiness() {
 		return empBussiness;
 	}
 	public void setEmpBussiness(EmployeeBussiness empBussiness) {
 		this.empBussiness = empBussiness;
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
 	public Object[] getIds() {
 		return ids;
 	}
 	public void setIds(Object[] ids) {
 		this.ids = ids;
 	}
 	public Storage getStorage() {
 		return storage;
 	}
 	public void setStorage(Storage storage) {
 		this.storage = storage;
 	}
 	public void setServletRequest(HttpServletRequest request) {
 		this.request=request;
 	}
 	public void setServletResponse(HttpServletResponse response) {
 		this.response=response;
 	}
 	public Object getModel() {
 		storage = new Storage();
 		return storage;
 	}
	public FileEveryDaySerialNumber getSerial() {
		return serial;
	}
	public void setSerial(FileEveryDaySerialNumber serial) {
		this.serial = serial;
	}
	public SupplierBussiness getSupplierBussiness() {
		return supplierBussiness;
	}
	public void setSupplierBussiness(SupplierBussiness supplierBussiness) {
		this.supplierBussiness = supplierBussiness;
	}


	/**
	 * 添加入库单
	 */
	public String add(){
		boolean flag=addAndedit("add");
		try{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个入库单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId("");
					executerecord.setEntityName("Storage");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			}
			else{
				System.out.println("添加失败");
				response.getWriter().print("1");
			}
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	
	
  
	/**
	 * 删除入库商品信息
	 */
	public String del(){
		String str = "";
		for(int j=0;j<ids.length;j++)
		{
			str += ids[j].toString()+",";
		}
		if(str != null){
			str = str.substring(0,str.length()-1);
		String hql = " and storageId in ("+str+")";
		List<Storage> list = warehousingBussiness.someStorage(hql);
		String str2 = "";
		List<StorageInfo> storageinfo = null;
		for(int i=0;i<list.size();i++)
		{
			str2+= list.get(i).getStorageId()+",";
		}
		if(str2 != null && str2 != "")
		{
			str2 = str2.substring(0,str2.length()-1);
			String hql2 = "from StorageInfo where storage in ("+str2+")";
			storageinfo = warehousingBussiness.getStorageInfo(hql2);
		}
		if(storageinfo != null && storageinfo.size()>0)
		{
			try {
				response.getWriter().print("2");
				return null;
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		}
		}
		boolean flag = warehousingBussiness.delStorage(ids);
		try {
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一些入库单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Storage");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			}else{
				response.getWriter().print("1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改入库商品信息
	 */
	public String edit(){
		boolean flag=this.addAndedit("edit");
		try{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个入库单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId("");
					executerecord.setEntityName("Storage");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				response.getWriter().write("0");
			}
			else{
				response.getWriter().write("1");
			}
		}
		catch(Exception ex){
			System.out.println("修改出错");
			ex.printStackTrace();
		}
		return "warehousingInfo";
	}
	
	
	/**
     * 入库信息查询
     */
     public String warehousingInfo()
     {
    	String marker2=request.getParameter("marker");
 		String taskid=request.getParameter("taskid");
 		String id = request.getParameter("id");
 		
 		request.setAttribute("marker", marker2);
 		request.setAttribute("taskid", taskid);
    	 
 		String pageNo= request.getParameter("pageNo")== null?"1":request.getParameter("pageNo");
 		String addhql="";
 		String purNo=request.getParameter("purNo");//单号。
 		String purtime=request.getParameter("time");//时间
 		String purplace="";
		try {
			purplace = request.getParameter("place")!=null? new String(request.getParameter("place").getBytes("iso-8859-1"),"GBK"):"";
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//仓库位置
 		String tiaojian=request.getParameter("tiaojian");
// 		if(purNo!=null){
// 			addhql+=" and storageNo like '%"+purNo+"%'";
// 		}
 		if(request.getParameter("fy")!=null){
			
			purNo=(String)request.getSession().getAttribute("purNo");
			purtime=(String)request.getSession().getAttribute("dtime");
			purplace=(String)request.getSession().getAttribute("depot");
		}else{
			
			request.getSession().setAttribute("purNo", "");
			request.getSession().setAttribute("dtime", "");
				request.getSession().setAttribute("depot", "");
			
		}
 		
 		if(tiaojian!=null)
 		{
 			if(tiaojian.equals("1"))
 			{
 				
 				String hql1="from Depot where name ='"+purNo+"'";
 				List<Depot> dp=warehousingBussiness.select(hql1);
 				if(dp.size()>0)
 				{
	 				addhql+="and depot.id="+dp.get(0).getId()+"";
 				}
 			}
 			else if(tiaojian.equals("2"))
 			{
 				addhql+=" and storageNo like '%"+purNo+"%'";
 			}
 			else if(tiaojian.equals("3"))
 			{
 				String hql1=" from Customer where realName='"+purNo+"'";
 				List<Customer> cu=warehousingBussiness.select(hql1);
 				if(cu.size()>0)
 				{
 					addhql+=" and customer.id="+cu.get(0).getCustomerId()+" ";
 				}
 			}
 			else if(tiaojian.equals("4"))
 			{
 				String hql1="from Employee where name='"+purNo+"'";
 				List<Employee> ep=warehousingBussiness.select(hql1);
 				if(ep.size()>0)
 				{
	 				addhql+="and employee.id="+ep.get(0).getId()+"";
 				}
 			}
 		}else{
 			
 			if(purplace!=null && !purplace.equals("")){
 				String hql1="from Depot where name ='"+purNo+"'";
 				List<Depot> dp=warehousingBussiness.select(hql1);
 				if(dp.size()>0)
 				{
	 				addhql+="and depot.id="+dp.get(0).getId()+"";
 				}
 				request.getSession().setAttribute("depot", purplace);
 			}
 			if(purtime!=null && !purtime.equals("")){
 				
 				addhql+=" and storageDate like '%"+purtime+"%'";
 				request.getSession().setAttribute("dtime", purtime);
 			}
 			if(purNo!=null && !purNo.equals("") ){
 				
 				
 				
 				addhql+=" and storageNo like '%"+purNo+"%'";
 				request.getSession().setAttribute("purNo", purNo);
 			}
 			
 			
 		}
 		String hql="from Storage where delflag=0 "+addhql;
 		if(id!=null && !id.equals("")){
 			int sid = Integer.parseInt(id);
 			hql += " and storageId="+sid;
 		}
 		hql += " order by storageId desc";
 		
 		System.out.println(hql);
 		Map map = (Map)ActionContext.getContext().get("map");
 		Pages pages=warehousingBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
 		if(pages.getAllCount()>0)
 		{
 			for(int i=0;i<pages.getPageList().size();i++)
 			{
 				if(((Storage)pages.getPageList().get(i)).getStorageRemark()!=null&&((Storage)pages.getPageList().get(i)).getStorageRemark().equals("")==false)
 				{
 					if(((Storage)pages.getPageList().get(i)).getStorageRemark().length()>13)
 					{
 						String mark=((Storage)pages.getPageList().get(i)).getStorageRemark().substring(0, 13);
 						((Storage)pages.getPageList().get(i)).setStorageRemark(mark+".....");
 					}
 				}
 			}
 		}
 		request.setAttribute("pages", pages);
 		request.getSession().setAttribute("option", map);
 		if(request.getParameter("potalckd")==null){
 		return "warehousingInfo";}else{
 			
 			return "newwarehousingInfo";
 			 
 		}
     }
	 /*potal 欣方法
	  * *
	  */
     
     
     public String newwarehousingInfo()
     {
    	String marker2=request.getParameter("marker");
 		String taskid=request.getParameter("taskid");
 		String id = request.getParameter("id");
 		
 		request.setAttribute("marker", marker2);
 		request.setAttribute("taskid", taskid);
    	 
 		String pageNo= request.getParameter("pageNo")== null?"1":request.getParameter("pageNo");
 		String addhql="";
 		String purNo=request.getParameter("purNo");//单号。
 		String purtime=request.getParameter("time");//时间
 		String purplace="";
		try {
			
			
			
			purplace = request.getParameter("place")!=null?new String(request.getParameter("place").getBytes("iso-8859-1"),"GBK"):"";
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//仓库位置
 		String tiaojian=request.getParameter("tiaojian");
// 		if(purNo!=null){
// 			addhql+=" and storageNo like '%"+purNo+"%'";
// 		}
 		if(request.getParameter("fy")!=null){
			
			purNo=(String)request.getSession().getAttribute("purNo");
			purtime=(String)request.getSession().getAttribute("dtime");
			purplace=(String)request.getSession().getAttribute("depot");
		}else{
			
			request.getSession().setAttribute("purNo", "");
			request.getSession().setAttribute("dtime", "");
				request.getSession().setAttribute("depot", "");
			
		}
 		
 		if(tiaojian!=null)
 		{
 			if(tiaojian.equals("1"))
 			{
 				
 				String hql1="from Depot where name ='"+purNo+"'";
 				List<Depot> dp=warehousingBussiness.select(hql1);
 				if(dp.size()>0)
 				{
	 				addhql+="and depot.id="+dp.get(0).getId()+"";
 				}
 			}
 			else if(tiaojian.equals("2"))
 			{
 				addhql+=" and storageNo like '%"+purNo+"%'";
 			}
 			else if(tiaojian.equals("3"))
 			{
 				String hql1=" from Customer where realName='"+purNo+"'";
 				List<Customer> cu=warehousingBussiness.select(hql1);
 				if(cu.size()>0)
 				{
 					addhql+=" and customer.id="+cu.get(0).getCustomerId()+" ";
 				}
 			}
 			else if(tiaojian.equals("4"))
 			{
 				String hql1="from Employee where name='"+purNo+"'";
 				List<Employee> ep=warehousingBussiness.select(hql1);
 				if(ep.size()>0)
 				{
	 				addhql+="and employee.id="+ep.get(0).getId()+"";
 				}
 			}
 		}else{
 			
 			if(purplace!=null && !purplace.equals("")){
 				String hql1="from Depot where name ='"+purplace+"'";
 				List<Depot> dp=warehousingBussiness.select(hql1);
 				if(dp.size()>0)
 				{
	 				addhql+="and depot.id="+dp.get(0).getId()+"";
 				}
 				request.getSession().setAttribute("depot", purplace);
 			}
 			if(purtime!=null && !purtime.equals("")){
 				
 				addhql+=" and storageDate like '%"+purtime+"%'";
 				request.getSession().setAttribute("dtime", purtime);
 			}
 			if(purNo!=null && !purNo.equals("") ){
 				
 				
 				
 				addhql+=" and storageNo like '%"+purNo+"%'";
 				request.getSession().setAttribute("purNo", purNo);
 			}
 			
 			
 		}
 		String hql="from Storage where delflag=0 "+addhql;
 		if(id!=null && !id.equals("")){
 			int sid = Integer.parseInt(id);
 			hql += " and storageId="+sid;
 		}
 		hql += " order by storageId desc";
 		
 		System.out.println(hql);
 		Map map = (Map)ActionContext.getContext().get("map");
 		Pages pages=warehousingBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
 		if(pages.getAllCount()>0)
 		{
 			for(int i=0;i<pages.getPageList().size();i++)
 			{
 				if(((Storage)pages.getPageList().get(i)).getStorageRemark()!=null&&((Storage)pages.getPageList().get(i)).getStorageRemark().equals("")==false)
 				{
 					if(((Storage)pages.getPageList().get(i)).getStorageRemark().length()>13)
 					{
 						String mark=((Storage)pages.getPageList().get(i)).getStorageRemark().substring(0, 13);
 						((Storage)pages.getPageList().get(i)).setStorageRemark(mark+".....");
 					}
 				}
 			}
 		}
 		request.setAttribute("pages", pages);
 		request.getSession().setAttribute("option", map);
 	
 			
 			return "newwarehousingInfo";
 			 
 		
     }
	/**
	 * 入库单详细信息
	 */
	public String detail(){
		String id=request.getParameter("cid");
		String purNo = request.getParameter("purNo");
		//获取info的信息
		String info = request.getParameter("info");
	
		//String empid=ck.getCookie(request, "employeeId");
		Employee emp=(Employee)request.getSession().getAttribute("emp");
		String empid=String.valueOf(emp.getId());
		if(id!=null){
			List list=warehousingBussiness.someStorage(" and storageId="+id);
			
			if(list.size()>0 && list != null){
			request.setAttribute("storageList", list.get(0));
			if(((Storage)list.get(0)).getStorageVerify()==0)
			{
				boolean flag=audBussiness.checkemp1(purNo,empid);
				System.out.println("saleActionflag:::::"+flag);
				if(flag){
					request.setAttribute("mark", "mark");
				}
			}
			}
		}
		
	
		System.out.println("ck::::"+empid);
		
		
		boolean flag1=audBussiness.checkemp1(purNo, empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(purNo!=null){
				String addhql2=" and orderNo='"+purNo+"'";
				
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0){
					
					//String depid = ck.getCookie(request, "departmentId");
					String	depid=String.valueOf(emp.getDepartment().getId());
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
		if(request.getParameter("potal")!=null){
			return "newdetail";
		}else{
		return "detail";
		}
	}
	
	
	
	/**
	 * 显示批量输入条形码的页面
	 * @return
	 */
	public String showbarcode(){
		
		return "showbarcode";
	}
	
	
	/**
	 * 添加或修改入库单
	 */
	public boolean addAndedit(String addOredit)
	{
		try {
			// 设置 备注
			storage.setStorageRemark(URLDecoder.decode(storage.getStorageRemark(),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		// 添加 ， 把所有的值设置好传递到BIZ中用事务处理
		if(addOredit.equals("add")){
			// 已经获得入库单数据了 storage
			
			// 获取入库详单数据
			String[] strToOrderIds = strToOrderId.split(",");
			
			// 循环获取入库详单
			for(int i = 0; i < strToOrderIds.length; i++ ){
				// 根据到货单Id 获得批次详表的List集合
				List listBatchexp = batchexpBussiness.findBatchexpByToOrderId(strToOrderIds[i]);
				Batchexp ba = (Batchexp)listBatchexp.get(i);
				System.out.println("获得的批次详表中的数据：数量= "+ba.getCount());
			}
			
		}
		// 修改
		else if(addOredit.equals("edit")){
			
			
			
		}
		return false;
	}
	
	


	/**
	 * 显示添加入库单业务类型
	 */
	public String addshow()
	{
		String rkNo="RK-"+serial.getSerialNumber();
		request.setAttribute("RKNo", rkNo);
		List typeList=warehousingBussiness.selType("");
		request.setAttribute("typeList", typeList);
		if(request.getParameter("potal")!=null){
			return "newadd";
		}else{
			
			
			return "add";
		}
	}
	
	
	
	
	
	/**
	 * 删除入库详单
	 */
	public String delInfo(){
		String infoId=request.getParameter("infoId");
		System.out.println("输出INFOID = "+infoId);
		if(infoId!=null){
			// 根据ID ， 先删除产品表中的数据
			boolean booleanPro = productBussiness.delProductByStorageInfoId(" and storageInfoId = " + Integer.parseInt(infoId));
			if(booleanPro){
				// 根据ID 删除入库详单数据
				booleanPro=warehousingBussiness.delStorageInfo(" and storageInfoId="+infoId);
				
				// 修改到货单入库状态
				if(booleanPro){
					String id = request.getParameter("id");
					if( !id.equals("kh") && id != "kh")
					{
					System.out.println(id);
					if(id!=null){
						String type = request.getParameter("type");
						if(type.equals("新购入库") || type=="新购入库")
						{
						// 查询到货单
						ToOrder toOrder = toOrderBussiness.getToOrderdata(id);
						toOrder.setStorageState(0);
						if(toOrder!=null){
							// 根据到货单ID 修改到货单入库状态
							booleanPro= toOrderBussiness.updateData(toOrder);
							if(booleanPro){
								System.out.println("修改状态成功="+toOrder.getStorageState());
							}
						}
						}else if(type.equals("报益入库") || type=="报益入库")
							
						{
							List list  = incomeBussiness.someIncomeInfo("and id = "+id);
							if(list != null && list.size()>0)
							{
								Income income = (Income)list.get(0);
								income.setAuditingState(0);
								incomeBussiness.upstatu(income);
								}
						}
					}
					}
				}
				try{
					if(booleanPro){
						response.getWriter().print("0");
						}
					else{
						response.getWriter().print("1");
					}
				}
				catch(Exception ex){
					System.out.println("删除详单时出错");
					ex.printStackTrace();
				}
			}
		}
		return null;
	}
	
	
	/**
	 * 入库更新显示
	 * 
	 */
	public String updateShow()
	{
		
		String id=request.getParameter("cid");
	
		Storage storage=(Storage) warehousingBussiness.someStorage(" and storageId="+id).get(0);
		
		System.out.println("cm: ---> ----> 执行按编号修改后， 得到ID ：  "+storage.getStorageId());
		request.setAttribute("oneStorage", storage);
		System.out.println("--------------------------"+storage.getStorageInfos().size());
		List typeList=warehousingBussiness.selType("");
		request.setAttribute("typeList", typeList);
	
		return "add";
		
	}
	
	/**
	 * 获得当前登录用户信息
	 * @return
	 */
	public Users getUser(){
		System.out.println("cm ---> Action --> getUser() --> 进入获得当前用户信息方法 " );
		
		// 根据用户名查询用户
		Cookies cookies = new Cookies();
		String strLoginName = cookies.getCookie(request, "loginName");
		String strPassword = cookies.getCookie(request,"password");
		Users u = warehousingBussiness.getUsersByLoginName(strLoginName, strPassword);
		request.setAttribute("user", u);
		return user;
	}
	
    /**
     * 盘盈入库
     */
    public String inventoryProfit()
    {
    	return "Profit";
    }
    
    /**
     * 服务器下架入库
     */
    public String serverBelow()
    {
    	return "serverBelow";
    }    
    
       
    /**2013.5.16
     * 仓库详细信息 14032	
     */
    public String depotdetil(){
    	
    	String id=request.getParameter("id");
    	String anum=request.getParameter("anum");//可用数量
    	request.setAttribute("anum", anum);
    	String bnum=request.getParameter("bnum");//出库数量
    	request.setAttribute("bnum", bnum);
    	String cnum=request.getParameter("cnum");//冻结数量
    	request.setAttribute("cnum", cnum);
    	
    	List li=customerBussiness.exHql("from Depot where id="+Integer.parseInt(id));
    	Depot de=new Depot();
    	de=(Depot)li.get(0);//获得仓库的详细信息
    	request.setAttribute("depot", de);
    	//入库
    	List cklist=customerBussiness.exHql("from Storage where  storageVerify=1 and depot.id="+Integer.parseInt(id)+" order by id desc" );
    	List<Storage> ck=cklist;
    	request.setAttribute("ck", ck);
    	//出库
    				
    	List rklist=customerBussiness.exHql("from Outbound where depot.id="+Integer.parseInt(id)+" order by id desc" );
    	List<Outbound> rk=rklist;
    	request.setAttribute("rk", rk);
    	return "depotdetil";
    }
    
    /**
	 * 显示对话框
	 */
	public String showDialog()
	{
		String mark=request.getParameter("mark");
		String pageNoS = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		int pageNo=Integer.parseInt(pageNoS);
		// 显示 仓库信息
		if(mark.equals("depot")){
			String hql="from Depot where del = 0 ";
			String name = request.getParameter("cname");
			if(name !=null && !name.equals("")){
				hql +=" and name like '%"+name+"%'";
			}
			hql+=" order by id desc";

			Pages pages=depotBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showDepotDialog";
		}
		else if(mark.equals("custom")){
			String hql="from Customer as tb where 1=1 and del!='1'";
			String name = request.getParameter("cusname");
			if(name !=null && !name.equals("")){
				hql +=" and customerName like '%"+name+"%'";
			}
			hql+="order by tb.id desc";
			Pages pages=customerBussiness.exHqlPages(hql, pageNo, 25, null);
			request.setAttribute("pages", pages);
			return "showcustomDialog";
		}
		else if(mark.equals("commodity")){
			String hql="from Product where delflag=0";
			String name = request.getParameter("name");
			if(name !=null && !name.equals(""))
			{
				hql +=" and property.name like '%"+name+"%'";
			}
			hql+="order by id desc";
			Pages pages=commbizimpl.exHqlPages(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showcommodityDialog";
		}
		else if(mark.equals("employee")){
			String hql="from Employee where delflag=0";
			String name = request.getParameter("ename");
			if(name !=null && !name.equals(""))
			{
				hql +=" and name like '%"+name+"%'";
			}
			hql+="order by id desc";
			Pages pages=empBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages",pages);
			return "showemployeeDialog";
		}else if(mark.equals("prjemp")){
			String hql = "from Employee where delflag=0";
			String name = request.getParameter("ename");
			if(name!=null && !name.equals("")){
				hql += " and name like '%"+name+"%'";
			}
			hql += " order by id desc";
			Pages pages=empBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showemployeeDialog";
		}
		else if(mark.equals("supplier"))
		{
			System.out.println("supplier");
			String hql="from Supplier where del = 0 ";
			String name = request.getParameter("name");
			if(name !=null && !name.equals(""))
			{
				hql +=" and supplierName like '%"+name+"%'";
			}
			hql+=" order by date desc";
			Pages pages=supplierBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showsupplierDialog";
		}else if(mark.equals("toOrder")){	// 三个条件：未入库、已审核、未删除
			String hql="from ToOrder where delflag = 0 and toOrderVerify=1 and storageState=0";
			String name = request.getParameter("name");
			if(name !=null && !name.equals(""))
			{
				hql +=" and piciNO like '%"+name+"%'";
			}
			hql+=" order by id desc";
			Pages pages = toOrderBussiness.exHqlPages(hql, pageNo, 10, null);
			request.setAttribute("pages",pages);
			return "toOrderDialog";
		}
		else{
			return "warehousingInfo";
		}
		
	}
	
	public String transferStorageInfo(){
		System.out.println("CM： --->     --->  action  ---> 进入transferStorageInfo 方法了  ");
		String infoIda = request.getParameter("infoId");
		System.out.println("CM： --->     --->  action  ---> 进入transferStorageInfo  infoId 的值是：  " + infoIda);
		request.setAttribute("infoIda", infoIda);
		return null;
	}
	 /**
	  * 查询入库单详情
	  * @return
	  */
    public String seerkdlist(){
    	String sno=request.getParameter("sno");
        List l1=customerBussiness.exHql("from  Storage where  storageNo='"+sno+"'");
        Storage s=new Storage();
        s=(Storage)l1.get(0);
        List l2=customerBussiness.exHql("from  StorageInfo where  storage.storageNo='"+sno+"'");
    	if(l2.size()>0){
    		StorageInfo si = new StorageInfo();
    		si=(StorageInfo)l2.get(0);
    		
    		request.setAttribute("StorageInfo",si);
    		
    		
    		
    	}
    	request.setAttribute("Storage", s);
        return "seerkdlist";
    }
    
	/**13.5.15 库存列表
	 * 14032
	 * @return
	 */
	public String seldepot(){
		
		String empname="";
		String depname="";
		try {
			
			empname=request.getParameter("empname")!=null?new String(request.getParameter("empname").getBytes("iso-8859-1"),"GBK"):"";//库管人员
			depname =request.getParameter("depname")!=null?new String(request.getParameter("depname").getBytes("iso-8859-1"),"GBK"):"";
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//仓库位置
		String hql="from Depot where 1=1 ";
		
		if(empname!=null && !empname.equals("")){
			hql+=" and employee.name like '%"+empname+"%'";			
		}
		if(depname!=null && !depname.equals("")){
			hql+=" and name like '%"+depname+"%'";			
		}
		hql+="order by id ";
		
		String sql="from Depot where del='0'";//查询仓库列表
		List  depotuse= customerBussiness.exHql(sql);
		List<Depot> delist=depotuse;
		Map countlist=new HashMap();
		Map countlist1=new HashMap();
		Map countlist2=new HashMap();
		if(delist.size()>0){
		for (int i = 0; i < delist.size(); i++) {
			String sel="SELECT COUNT(*) FROM Product  WHERE usestate=2  and  depot.id="+delist.get(i).getId();//未使用的
			List  count= customerBussiness.exhql(sel);//仓库里可用产品数量
			
			request.setAttribute(delist.get(i).getName(), count.get(0));//对应仓库的已用数量
			countlist.put(delist.get(i).getName(), count.get(0));
		}
		for (int i = 0; i < delist.size(); i++) {
			String sel="SELECT COUNT(*) FROM Product  WHERE usestate=1  and isfreeze<>1  and  depot.id="+delist.get(i).getId();//未使用的
			List  count= customerBussiness.exhql(sel);//仓库里出库产品数量
			
			request.setAttribute(delist.get(i).getName(), count.get(0));//对应仓库的已用数量
			countlist1.put(delist.get(i).getName(), count.get(0));
		}
		for (int i = 0; i < delist.size(); i++) {
			String sel="SELECT COUNT(*) FROM Product  WHERE usestate=1  and isfreeze=1  and   depot.id="+delist.get(i).getId();//冻结
			List  count= customerBussiness.exhql(sel);//仓库里冻结产品数量
			String sel1="SELECT COUNT(*) FROM Product  WHERE usestate=4 and  depot.id="+delist.get(i).getId();//冻结
			List  count1= customerBussiness.exhql(sel);//仓库里冻结产品数量
			Object o=count.get(0);
			Object o1=count1.get(0);
			Integer num=Integer.parseInt(o.toString())+Integer.parseInt(o1.toString());
			
			request.setAttribute(delist.get(i).getName(), count.get(0));//对应仓库的已用数量
			countlist2.put(delist.get(i).getName(), num);
		}
		
		}
		
		request.setAttribute("cuountlist",countlist);
		request.setAttribute("cuountlist1",countlist1);
		request.setAttribute("cuountlist2",countlist2);
		String pageNo= request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		Pages pages = toOrderBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		List  li=pages.getPageList();
		List<Depot> depot=li;
		request.setAttribute("pages",pages);
		request.setAttribute("depot",depot);
		
		
		return "seldepot";
	}
	/**
	 * 新增入库单以及审核流程
	 */
	 public String addstorage(){
		 
		System.out.println(storage.getStorageNo());
		List<Batchexp> batchexp;
		String rktype=request.getParameter("menu1");//入库类型
		String depid= request.getParameter("depid");//仓库id
		String time=request.getParameter("storageDate");//
		List depot= customerBussiness.exhql("from Depot where id="+Integer.parseInt(depid));//查找到仓库
		Depot dep=new Depot();
		dep=(Depot)depot.get(0);
	    
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("MMddHHmmss"); 

	java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

	String tt = formatter.format(currentTime); //将日期时间格式化 
	  String brocdnum=tt;
		if(rktype.equals("cgzb")){//采购储备
			rktype="9";	
			
		}else if(rktype.equals("ckzh")){//仓库转换
			rktype="8";	
			
		}else if(rktype.equals("sbhk")){//设备回库
			rktype="10";	
						
		}else if(rktype.equals("khtg")){//客户托管
			
			rktype="6";	
		}
		List alltype= customerBussiness.exhql("from AllType where id="+Integer.parseInt(rktype));//查找到仓库
		AllType at=new AllType();
		at=(AllType)alltype.get(0);
		storage.setAllType(at);
		storage.setDepot(dep);
		storage.setStorageDate(time);
		 Employee emp=(Employee)request.getSession().getAttribute("emp");
		storage.setEmployee(emp);
		
		if(rktype.equals("9")){//采购储备
		storage.setStorageVerify(0);
   	 	storage.setDelflag("0");	
   		
   	 	storage.setCustomer(null); 
   	    warehousingBussiness.add(storage);	
   	  
   		String cgdh=request.getParameter("purorderno");//采购单号
   	 	if(cgdh!=null && cgdh!=""){
   	 	StorageInfo  si=new StorageInfo();
   	 	List list=customerBussiness.exHql("From PurOrder where purOrderNo='"+cgdh+"'"); 
   	 	si.setStorage(storage);
   	 	String money1=request.getParameter("price1");
	 	storage.setProductPriceSum(Double.valueOf(money1));
   	 	PurOrder purorder=new PurOrder();//采购单关联
   	 	purorder=(PurOrder)list.get(0);
   	 	si.setPurorder(purorder);
   	    audBussiness.add(si);
   	    Set<PurOrderInfo> pp=purorder.getPurOrderInfos();
   	    for (Iterator iterator = pp.iterator(); iterator.hasNext();) {
			PurOrderInfo purOrderInfo1= (PurOrderInfo) iterator.next();
			Integer  mid=purOrderInfo1.getModel().getModel();
			
			
	
   	    StorageInfo sinfo;
   	      String sl= request.getParameter("xgrksl");
		for (int j = 0; j < Integer.parseInt(sl); j++) {
	       			 StorageInfo newsinfo = new StorageInfo();
		        		newsinfo.setStorage(storage);
		        		sinfo = warehousingBussiness.addStorageInfo(newsinfo);
	       	    		Depot d = new Depot();
	       	    		d.setId(storage.getDepot().getId());
	       	    		Product p = new Product();
	       	    	    List list1=customerBussiness.exHql("From Property where model.model="+mid); 
	       	    	    Property p1=new Property();
	       	    	    if(list1.size()>0){
	       	    	    p1=(Property)list1.get(0);
	       	    	    p.setProperty(p1);
	       	    	    }else{
	       	    	    	
	       	    	     p1.setModel(purOrderInfo1.getModel());
	       	    	     warehousingBussiness.add(p1);	
	       	    	  
	       	    	     p.setProperty(p1);
	       	    	    }
	       	    		//Property property = commbizimpl.getProperty(modelid[j].trim());
        	    		//p.setProperty(property);
	       	    	    String txm=request.getParameter("rt"+j);
	       	    	    p.setBarcode(brocdnum+txm);
	       	    		Customer c = new Customer();
	       	    		//c.setCustomerId(Integer.parseInt(customid[j]));
	       	    		//p.setTmp(c);
	       	    		p.setDepot(d);
	       	    		p.setStorageInfo(sinfo);
	       	    		p.setUseSum(0);
	       	    		p.setUsestate(3);
	       	    		p.setParentId(0);
	       	    		p.setDelflag("0");
	       	    		productBussiness.addProductObj(p);
	       	    	
		}
		}
		
   	    
   	 	}
   	 	
		 //storage.set
			request.getSession().setAttribute("sorage", storage);
			audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
		}else if(rktype.equals("8")){//仓库转换
			storage.setStorageVerify(0);
	   	 	storage.setDelflag("0");
	   	 	storage.setCustomer(null); 
	   	 	
	   	 	String money1=request.getParameter("price2");
		 	storage.setProductPriceSum(Double.valueOf(money1));
	   	    warehousingBussiness.add(storage);	
	   	    String ckdh=request.getParameter("cukd");//得到的出库单号
	   	    List list=customerBussiness.exHql("From OutboundInfo where outbound.outboundNo='"+ckdh+"'"); 
	   	 StorageInfo sinfo;
	   	    if(list.size()>0){//改变这个出库单的商品的使用状态
	   	    	OutboundInfo obi=new OutboundInfo();
	   	    	obi=(OutboundInfo)list.get(0);
	   	      
	   	    	StorageInfo newsinfo = new StorageInfo();
	   	    	newsinfo.setStorage(storage);
	   	    	sinfo = warehousingBussiness.addStorageInfo(newsinfo);
	   	       
	   	    	Product pro=new Product();
	   	    	pro=obi.getProduct();
	   	    	pro.setUseSum(0);
   	    		pro.setUsestate(3);
   	    		pro.setParentId(0);
   	    		pro.setDepot(dep);
   	    		pro.setStorageInfo(sinfo);
	   	    
	   	    
	   	 	audBussiness.updObj(pro);
       	    	}
	   	    	
	   	   
	   	    request.getSession().setAttribute("sorage", storage);
			audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
		}else if(rktype.equals("10")){//设备回库
			storage.setStorageVerify(0);
	   	 	storage.setDelflag("0");
	   	 	storage.setCustomer(null); 
	   	 	String money1=request.getParameter("price4");
	   	 	storage.setProductPriceSum(Double.valueOf(money1));
	   	    warehousingBussiness.add(storage);	
			String idlist=request.getParameter("idlist");//得到产品的id列表
			if(idlist!=null && idlist!=""){
				String[] proids=idlist.split(",");
		    	 StorageInfo sinfo;
				for (int j = 0; j < proids.length; j++) {
				
				
					
						
			       			 StorageInfo newsinfo = new StorageInfo();
				        		 newsinfo.setStorage(storage);
				        		 sinfo = warehousingBussiness.addStorageInfo(newsinfo);
			       	    		Depot d = new Depot();
			       	    		d.setId(storage.getDepot().getId());
			       	    		Product p = new Product();
			       	    	    List list1=customerBussiness.exHql("From Property where id='"+Integer.parseInt(proids[j])+"'"); 
			       	    	    Property p1=new Property();
			       	    	    p1=(Property)list1.get(0);
			       	    	    p.setProperty(p1);
			       	    	    String txm=request.getParameter("t"+proids[j]);
			       	    	    p.setBarcode(brocdnum+txm);
			       	    		Customer c = new Customer();
			       	    		//c.setCustomerId(Integer.parseInt(customid[j]));
			       	    		//p.setTmp(c);
			       	    		p.setDepot(d);
			       	    		p.setStorageInfo(sinfo);
			       	    		p.setUseSum(0);
			       	    		p.setUsestate(3);
			       	    		p.setParentId(0);
			       	    		p.setDelflag("0");
			       	    		productBussiness.addProductObj(p);
			       	    	
					 
				}
				
				
				
				
			}
			request.getSession().setAttribute("sorage", storage);
			audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
			
		}else if(rktype.equals("6")){//客户托管
			storage.setStorageVerify(0);
	   	 	storage.setDelflag("0");
		 	String money1=request.getParameter("price3");
	   	 	storage.setProductPriceSum(Double.valueOf(money1));
	   	 	String custid=request.getParameter("custid");
	   	    Customer cust=new Customer();
	   	 	if(custid!=null && custid!=""){
	   	 		
	   	 	 List list1=customerBussiness.exHql("From Customer where id='"+Integer.parseInt(custid)+"'"); 
	   	 	
	   	 	cust=(Customer)list1.get(0);
	   	 	
	   	 	}
	   	 	
	   	 	storage.setCustomer(cust); 
	   	 	
	   	    warehousingBussiness.add(storage);	
	   		String idlist=request.getParameter("idlist");//得到产品的id列表
			if(idlist!=null && idlist!=""){
				String[] proids=idlist.split(",");
				 StorageInfo sinfo;
				for (int j = 0; j < proids.length; j++) {
					 List list1=customerBussiness.exHql("From Product where id='"+Integer.parseInt(proids[j])+"'"); 
					 StorageInfo newsinfo = new StorageInfo();
	        		 newsinfo.setStorage(storage);
	        		 sinfo = warehousingBussiness.addStorageInfo(newsinfo);
       	    		Depot d = new Depot();
       	    		d.setId(storage.getDepot().getId());
       	    		Product p = new Product();
       	    		String s=proids[j];
       	    	    List list2=customerBussiness.exHql("From Property where id='"+Integer.parseInt(proids[j])+"'"); 
       	    	    Property p1=new Property();
       	    	    p1=(Property)list2.get(0);
       	    	    p.setProperty(p1);
       	    	    String txm=request.getParameter("t"+proids[j]);
       	    	    p.setBarcode(brocdnum+txm);
       	    		Customer c = new Customer();
       	    		//c.setCustomerId(Integer.parseInt(customid[j]));
       	    		//p.setTmp(c);
       	    		p.setDepot(d);
       	    		p.setStorageInfo(sinfo);
       	    		p.setUseSum(0);
       	    		p.setUsestate(3);
       	    		p.setParentId(0);
       	    		p.setDelflag("0");
       	    		productBussiness.addProductObj(p);
       	    	
						 
						 
					 
				}
			}
			request.getSession().setAttribute("sorage", storage);
			audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
		}
		 return "rkdlb";
	 }
	/**
	 * 记录入库单和入库详单信息 跳转页面到条形码
	 * @return
	 * @throws IOException 
	 * @throws ParseException 
	 */
	public String findBatchexpCode() throws IOException, ParseException{
		
		
	   List<AllType> alltype = warehousingBussiness.selType("and id ="+storage.getAllType().getId());
	   //判断入库类型是新购入库则执行新购入库操作
	   if (alltype != null && alltype.get(0).getTypeName().equals("新购入库")){

		List<Batchexp> batchexp;
		Map map = new HashMap();
		String[] toOrderid = request.getParameterValues("toOrderId");
		if(toOrderid == null || toOrderid.length<=0)
		{
			 storage.setStorageVerify(0);
	    	 storage.setDelflag("0");
	    	 storage.setCustomer(null);
	    	 Storage s = warehousingBussiness.addStorage(storage);
	    	 return "select";
		}
		for(int i = 0; i<toOrderid.length; i++)
		{
			
			batchexp = batchexpBussiness.findBatchexpByToOrderId(toOrderid[i]);
			if(batchexp.size()>0){
			map.put(batchexp.get(0).getToOrder().getPiciNo(), batchexp);
			}
		}
		request.setAttribute("map", map);
		request.getSession().setAttribute("storggeinfo", toOrderid);
		request.getSession().setAttribute("sorage", storage);
		audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
		return "showbarcode";
	   }
	   
	   else if (alltype != null && alltype.get(0).getTypeName().equals("客户商品入库"))
		   
	   {
		  // String[] customid = request.getParameterValues("customerid");
		   String[] modelid = request.getParameterValues("models");
		   String[] barcode = request.getParameterValues("barcode");
		   storage.setStorageVerify(0);
	    	 storage.setDelflag("0");
	    	 Storage s = warehousingBussiness.addStorage(storage);
	    	 StorageInfo sinfo;
	    	 if(s != null){
	    		
	        		
	        		 for(int j=0;j<barcode.length;j++)
	        	    	{
	        			 StorageInfo newsinfo = new StorageInfo();
		        		 newsinfo.setStorage(s);
		        		 sinfo = warehousingBussiness.addStorageInfo(newsinfo);
	        	    		Depot d = new Depot();
	        	    		d.setId(storage.getDepot().getId());
	        	    		Product p = new Product();
	        	    		Property property = commbizimpl.getProperty(modelid[j].trim());
	        	    		p.setProperty(property);
	        	    		p.setBarcode(barcode[j].trim());
	        	    		Customer c = new Customer();
	        	    		//c.setCustomerId(Integer.parseInt(customid[j]));
	        	    		//p.setTmp(c);
	        	    		p.setDepot(d);
	        	    		p.setStorageInfo(sinfo);
	        	    		p.setUseSum(0);
	        	    		p.setUsestate(3);
	        	    		p.setParentId(0);
	        	    		p.setDelflag("0");
	        	    		productBussiness.addProductObj(p);
	        	    	}
	        		 
	        	 }
	    	 audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
	    	 return "select";
	   }else if( alltype != null && alltype.get(0).getTypeName().equals("报益入库"))
	   {
		   List<IncomeInfo> incomeInfo;
			Map map = new HashMap();
			String[] incomeid = request.getParameterValues("incomeid");
			
			if(incomeid == null || incomeid.length<=0)
			{
				 storage.setStorageVerify(0);
		    	 storage.setDelflag("0");
		    	 storage.setCustomer(null);
		    	 Storage s = warehousingBussiness.addStorage(storage);
		    	 return "select";
			}
			for(int i = 0; 	i<incomeid.length; i++)
			{
				incomeInfo = incomeBussiness.someIncomeInfo("and incomeId = "+incomeid[i]);
				if(incomeInfo.size()>0){
				map.put(incomeInfo.get(0).getIncome().getIncomeNo(), incomeInfo);
				}
			}
			request.setAttribute("map", map);
			request.getSession().setAttribute("storggeinfo", incomeid);
			request.getSession().setAttribute("sorage", storage);
			audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
			return "incomeShowbarcode";
	   }
	   
	   else{
		   
		   String[] barcode = request.getParameterValues("barcode");
		   String[] modelid = request.getParameterValues("models");
		   storage.setStorageVerify(0);
	    	 storage.setDelflag("0");
	    	 storage.setCustomer(null);
	    	 Storage s = warehousingBussiness.addStorage(storage);
	    	 if (null != s && barcode != null && barcode.length>0)
	    	 {
	    		
        		 
        		 for(int j=0;j<barcode.length;j++)
        		 {
        			 StorageInfo newsinfo = new StorageInfo();
            		 newsinfo.setStorage(s);
            		 StorageInfo sinfo = warehousingBussiness.addStorageInfo(newsinfo);
        			 Depot d = new Depot();
     	    		d.setId(storage.getDepot().getId());
     	    		Product p = new Product();
     	    		Property property = commbizimpl.getProperty(modelid[j].trim());
     	    		p.setProperty(property);
     	    		p.setBarcode(barcode[j].trim());
     	    		p.setDepot(d);
     	    		p.setStorageInfo(sinfo);
     	    		p.setUseSum(0);
     	    		p.setUsestate(3);
     	    		p.setParentId(0);
     	    		p.setDelflag("0");
     	    		productBussiness.addProductObj(p);
        		 }
        		 audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
        		 return "select"; }
	    	 
	    	 
		   
	   }
		   return "select";
	}
	
	
    //新购商品入库
    public String addStorage()
    {
    	 String[] toOrderid = (String[])request.getSession().getAttribute("storggeinfo");
    	 Storage storage = (Storage)request.getSession().getAttribute("sorage");
    	 if(null != storage)
    	 {
    		 request.getSession().removeAttribute("sorage");
    	 }
    	 if(null!=toOrderid )
    	 {
    		 request.getSession().removeAttribute("storggeinfo");
    	 }
    	
    	 Double price=0.0;
    	 for(int i=0;i<toOrderid.length;i++)
    	 {
    		 ToOrder t = toOrderBussiness.getToOrderdata(toOrderid[i].trim());
    		 price = price+t.getGrossmoney();
    	 }
    	 storage.setProductPriceSum(price);
    	 storage.setStorageVerify(0);
    	 storage.setDelflag("0");
    	 try{
    	 Storage s = warehousingBussiness.addStorage(storage);
    	 StorageInfo sinfo;
    	 for(int i=0;i<toOrderid.length;i++)
    	 {
    		 ToOrder t = toOrderBussiness.getToOrderdata(toOrderid[i].trim());
    		 t.setStorageState(1);
    		 toOrderBussiness.updateData(t);
    		 StorageInfo newsinfo = new StorageInfo();
    		 newsinfo.setStorage(s);
    		 newsinfo.setToOrder(t);
    		 sinfo = warehousingBussiness.addStorageInfo(newsinfo);
    		 String[] barCode = request.getParameterValues("barcode"+i);
        	 String[] models = request.getParameterValues("model"+i);
        	 if(models == null || models.length<0)
        	 {
        		 return "select";
        	 }
    		 for(int j=0;j<barCode.length;j++)
    	    	{
    	    		Depot d = new Depot();
    	    		d.setId(storage.getDepot().getId());
    	    		Product p = new Product();
    	    		Property property = commbizimpl.getProperty(models[j].trim());
    	    		p.setProperty(property);
    	    		p.setBarcode(barCode[j].trim());
    	    		p.setDepot(d);
    	    		p.setStorageInfo(sinfo);
    	    		p.setUseSum(0);
    	    		p.setUsestate(3);
    	    		p.setParentId(0);
    	    		p.setDelflag("0");
    	    		productBussiness.addProductObj(p);
    	    	}
    	 }
    	 audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
    	 }catch (Exception e) {
			return "error";
		}
    	 
  
	return "select";
}
    
    /**
     * 报益入库
     */
    public String addIncomeStorage()
    {
    	 String[] incomeId = (String[])request.getSession().getAttribute("storggeinfo");
    	 Storage storage = (Storage)request.getSession().getAttribute("sorage");
    	 if(null != storage)
    	 {
    		 request.getSession().removeAttribute("sorage");
    	 }
    	 if(null!=incomeId )
    	 {
    		 request.getSession().removeAttribute("storggeinfo");
    	 }
    	 Double price=0.0;
    	 storage.setProductPriceSum(price);
    	 storage.setStorageVerify(0);
    	 storage.setDelflag("0");
    	 try{
    	 Storage s = warehousingBussiness.addStorage(storage);
    	 StorageInfo sinfo;
    	 boolean b = false;
    	 Income t = null;
    	 for(int i=0;i<incomeId.length;i++)
    	 {
    		List list =incomeBussiness.selIncome("and id ="+incomeId[i].trim());
    		
    		 if(null != list || list.size()>0)
    		 {
    			t = (Income)list.get(0); 
    			 //设置报益单的入库状态为1 表示已入库
       		 t.setInmark(1);
       		 //修改报益单
       		   b = incomeBussiness.upstatu(t);
    		 }
    		
    		  if(b)
    		  {
    		 StorageInfo newsinfo = new StorageInfo();
    		 newsinfo.setStorage(s);
    		 newsinfo.setIncome(t);
    		 sinfo = warehousingBussiness.addStorageInfo(newsinfo);
    		 String[] barCode = request.getParameterValues("barcode"+i);                           //循环获取每个单号的条形码
        	 String[] models = request.getParameterValues("model"+i);                              //循环获取类型
    		if(models == null || models.length<0)
    		{
    			return "select";
    		}
        	 for(int j=0;j<barCode.length;j++)
    	    	{
    	    		Depot d = new Depot();
    	    		d.setId(storage.getDepot().getId());
    	    		Product p = new Product();
    	    		Property property = commbizimpl.getProperty(models[j].trim());
    	    		p.setProperty(property);
    	    		p.setBarcode(barCode[j].trim());
    	    		p.setDepot(d);
    	    		p.setStorageInfo(sinfo);
    	    		p.setUseSum(0);
    	    		p.setUsestate(3);
    	    		p.setParentId(0);
    	    		p.setDelflag("0");
    	    		productBussiness.addProductObj(p);
    	    	}
    	 }
    	 }
    	 audBussiness.addAuditingOrder2("RK", storage.getStorageNo(),"Storage",ck.getCookie(request, "filialemark"));
    	 }catch (Exception e) {
			return "error";
		}
    	 
  
	return "select";
}

/**
 * 入库单审核通过后修改相应单据的状态
 * @return
 */
    public String ading()
    {
    	
    	String orderNo = request.getParameter("orderNo");
    	Storage s = null;
    	String infoid = "";
    	List<Storage> list =  warehousingBussiness.someStorage("and storageNo = "+"'"+orderNo+"'");
    	if(list != null && list.size()>0)
    	{
    		 s = list.get(0);
    		StorageInfo[] si = s.getStorageInfos().toArray(new StorageInfo[0]);
    		for(int i=0;i<si.length;i++)
    		{
    			 infoid += si[i].getStorageInfoId()+",";
    			 infoid = infoid.substring(0,infoid.length()-1);
    			boolean b= productBussiness.upproductStatu(infoid);
    			if(b)
    			{
    				
    			}
    			 
    		}
    	}
    	return null;
    }
    
    /**
	 * 跳转到库存查询页面
	 */
	public String selectStocks()
	{
		String pageNo= request.getParameter("pageNo")== null?"1":request.getParameter("pageNo");
		String hql="from Model where delflag=0";
		List<Model> model=warehousingBussiness.select(hql);
		request.setAttribute("model", model);
		String hql1="from Product where delflag=0";
		Pages pages=warehousingBussiness.exHqlPages(hql1, Integer.parseInt(pageNo), 40, null);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", "1");
		return "selectStocks";
	}
	/**
	 * 根据商品类型查找商品
	 */
	public String selectModelType()
	{
		HttpSession session =request.getSession();
		String modelid=request.getParameter("modelTypeId");
		if(modelid==null)
		{
			modelid=(String) session.getAttribute("modelid1");
		}
		String pageNo= request.getParameter("pageNo")== null?"1":request.getParameter("pageNo");
		String hql="from Model where delflag=0";
		List<Model> model=warehousingBussiness.select(hql);
		request.setAttribute("model", model);
		String hql1="from Product where delflag=0 and property.model.model="+Integer.parseInt(modelid)+"";
		Pages pages=warehousingBussiness.exHqlPages(hql1, Integer.parseInt(pageNo), 40, null);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", "2");
		
		session.setAttribute("modelid1", modelid);
		return "selectStocks";
	}
	/***
	 * 根据仓库查询
	 */
	public String selectDepot()
	{
		HttpSession session =request.getSession();
		String depotid=request.getParameter("depotid");
		if(depotid==null)
		{
			depotid=(String) session.getAttribute("depotid1");
		}
		String pageNo= request.getParameter("pageNo")== null?"1":request.getParameter("pageNo");
		String hql="from Model where delflag=0";
		List<Model> model=warehousingBussiness.select(hql);
		request.setAttribute("model", model);
		String hql1="from Product where delflag=0 and depot.id="+Integer.parseInt(depotid)+"";
		Pages pages=warehousingBussiness.exHqlPages(hql1, Integer.parseInt(pageNo), 40, null);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", "3");
		session.setAttribute("depotid1", depotid);
		return "selectStocks";
	}
	/**
	 *时间查询
	 */
	public String selectTime()
	{
		System.out.println("aaaa");
		HttpSession session =request.getSession();
		String time=request.getParameter("time");
		String number=request.getParameter("number");
		String modelid=request.getParameter("modelid");
		String hql1="from Product where delflag=0";
		
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
		Date now = new Date();
		String strDate = dateFormat.format(now);//当前日期
		
		if(modelid!=null&&(modelid.equals("0"))==false)//商品查询
		{
			hql1+="and property.model.model="+Integer.parseInt(modelid)+"";
		}
		
		if(time!=null && number!=null)
		{
			if(time.equals("3"))//选择的年份
			{
				for(int i=1;i<13;i++)
				{
					if(number.equals(i+""))//选择的那年
					{
						if(i<10)
							hql1+=" and storageInfo.storage.storageDate like '%201"+i+"-%'";
						else
						{
							int a=2010+i;
							hql1+=" and storageInfo.storage.storageDate like '%"+a+"-%'";
						}
					}
				}
				
			}
			
			if(time.equals("2"))//选择的季度
			{
				if(number.equals("1"))//1季度
				{
					hql1+=" and storageInfo.storage.storageDate like '%"+strDate+"-01-%' or storageInfo.storage.storageDate like '%"+strDate+"-02-%' or storageInfo.storage.storageDate like '%"+strDate+"-03-%'";
				}
				else if(number.equals("2"))//2季度
				{	
					hql1+=" and storageInfo.storage.storageDate like '%"+strDate+"-04-%' or storageInfo.storage.storageDate like '%"+strDate+"-05-%' or storageInfo.storage.storageDate like '%"+strDate+"-06-%'";
				}
				else if(number.equals("3"))//3季度
				{
					hql1+=" and storageInfo.storage.storageDate like '%"+strDate+"-07-%' or storageInfo.storage.storageDate like '%"+strDate+"-08-%' or storageInfo.storage.storageDate like '%"+strDate+"-09-%'";
				}
				else if(number.equals("4"))//4季度
				{	
					hql1+=" and storageInfo.storage.storageDate like '%"+strDate+"-10-%' or storageInfo.storage.storageDate like '%"+strDate+"-11-%' or storageInfo.storage.storageDate like '%"+strDate+"-12-%'";
				}
			}
			if(time.equals("1"))//选择的月份
			{
				for(int i=1;i<13;i++)
				{
					if(number.equals(i+""))//选择的几月份
					{
					if(i<10)
						hql1+=" and storageInfo.storage.storageDate like '%"+strDate+"-0"+i+"-%'";
					else
						hql1+=" and storageInfo.storage.storageDate like '%"+strDate+"-"+i+"-%'";
					}
				}
			}
		}
		String pageNo= request.getParameter("pageNo")== null?"1":request.getParameter("pageNo");
		String hql="from Model where delflag=0";
		List<Model> model=warehousingBussiness.select(hql);
		request.setAttribute("model", model);
		List list=warehousingBussiness.select(hql1);
		if(time==null||number==null)
		{
			hql1=session.getAttribute("hql1").toString();
		}
		Pages pages=warehousingBussiness.exHqlPages(hql1, Integer.parseInt(pageNo), 40, null);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", "4");
		session.setAttribute("hql1", hql1);
		return "selectStocks";
	}
	/**
	 * 模糊查询
	 * @throws IOException 
	 */
	public String select() throws IOException{
	System.out.println("aaaaa");	
	String barcode1=request.getParameter("barcode");//条形码
	String barcode= URLDecoder.decode(barcode1, "UTF-8");
	String modelname1=request.getParameter("modelname");//商品类型名称
	String modelname= URLDecoder.decode(modelname1, "UTF-8");
	String storageDate=request.getParameter("storageDate");//入库时间
	String typeName1=request.getParameter("typeName");//入库类型
	String typeName= URLDecoder.decode(typeName1, "UTF-8");
	String depotname1=request.getParameter("depotname");//仓库
	String depotname= URLDecoder.decode(depotname1, "UTF-8");
	String employeename1=request.getParameter("empname");//经手人
	String employeename= URLDecoder.decode(employeename1, "UTF-8");
	//页码
	String pageNo=request.getParameter("pageNo");
	if(null == pageNo){
		pageNo ="1";
	}
	String  hql1="from Product where delflag=0";
	if(barcode!=null && (barcode.equals("")==false))
	{
		hql1+=" and barcode like '%"+barcode+"%'";
	}
	if(modelname!=null&&(modelname.equals(""))==false)
	{
		hql1+="and  property.model.name like '%"+modelname+"%'";
	}
	if(storageDate!=null&&(storageDate.equals("")==false))
	{
		hql1+="and storageInfo.storage.storageDate like '%"+storageDate+"%'";
	}
	if(typeName!=null&& (typeName.equals("")==false))
	{
		hql1+="and storageInfo.storage.allType.typeName like '%"+typeName+"%'";
	}
	if(depotname!=null && (depotname.equals("")==false))
	{
		hql1+="and storageInfo.storage.depot.name like '%"+depotname+"%'";
	}
	if(employeename!=null && (employeename.equals("")==false))
	{
		hql1+="and storageInfo.storage.employee.name like '%"+employeename+"%'";
	}
	
	Pages pages=warehousingBussiness.exHqlPages(hql1, Integer.parseInt(pageNo), 40, null);
	PropertyEditor property = new PropertyEditor();
	String strr="";
	String str="";
	if(pages!=null && pages.getPageList().size()>0)
	{
		for(int i=0; i<pages.getPageList().size(); i++)
		{
			Product product=new Product();
			product=(Product) pages.getPageList().get(i);
			 str=property.getID("selectproduct").toString();
			 String state="";
			 if(product.getUsestate()==1)
			 {
				 state="使用中";
			 }
			 if(product.getUsestate()==2)
			 {
				 state="未使用";
			 }
			 if(product.getUsestate()==3)
			 {
				 state="入库未审核";
			 }
			 if(product.getUsestate()==4)
			 {
				 state="出库未审核";
			 }
			 str=str.replace("#barcode#", product.getBarcode());
			 str=str.replace("#modelname#", "<a href='selectModelTypeWarehousing.do?modelTypeId="+product.getProperty().getModel().getModel()+"'>"+product.getProperty().getModel().getName()+"</a>");
			 str=str.replace("#storageDate#", product.getStorageInfo().getStorage().getStorageDate());
			 str=str.replace("#typeName#", product.getStorageInfo().getStorage().getAllType().getTypeName());
			 str=str.replace("#usersate#", state);
			 str=str.replace("#depotname#","<a href='selectDepotWarehousing.do?depotid="+product.getStorageInfo().getStorage().getDepot().getId()+"'>"+product.getStorageInfo().getStorage().getDepot().getName()+"</a> ");
			 str=str.replace("#employeename#", product.getStorageInfo().getStorage().getEmployee().getName());
			strr +=str;		
		}
		pages.setUrl("selectStocksWarehousing.do");
		strr+="#"+pages.getHtml("selectproduct");
	}
	 response.setCharacterEncoding("utf-8");
	 response.getWriter().print(strr);
	 String hql="from Model where delflag=0";
	List<Model> model=warehousingBussiness.select(hql);
	request.setAttribute("model", model);
	 return null;
	}
	
	//显示详细的内容然后再添加
	public String detailstorage()
	{
		try {
			//入库单号
			String storageNo = request.getParameter("storageNo");
			request.setAttribute("storageNo", storageNo);
			//仓库
			String dep = request.getParameter("dep");
			if(!dep.equals(""))
			{
				String str = URLDecoder.decode(dep, "utf-8");
				request.setAttribute("dep", str);
			}
			//仓库类型
			String storageType = request.getParameter("storageType");
			request.setAttribute("storageType", storageType);
			//经手人
			String emp = request.getParameter("emp");
			if(!emp.equals(""))
			{
				String str = URLDecoder.decode(emp, "utf-8");
				request.setAttribute("emp",str);
			}
			//cus
			String cus = request.getParameter("cus");
			request.setAttribute("cus", cus);
			//入库时间
			String storagetime = request.getParameter("storagetime");
			request.setAttribute("storagetime", storagetime);
			//总价格
			String sum = request.getParameter("sum");
			request.setAttribute("sum", sum);
			//备注
			String remark = request.getParameter("remark");
			if(!remark.equals(""))
			{
				String strTemp = URLDecoder.decode(remark, "utf-8");
				request.setAttribute("remark", strTemp);
			}
			
			//根据到货单号查询出信息
			String strTemp = request.getParameter("allid");
			String [] strTemps = null;
			if(!strTemp.equals(""))
			{
				strTemps = strTemp.split(",");
			}
			logger.info("");
			//根据这个到货单查找信息
			Map map = new HashMap();
			logger.info(strTemps.length);
			if(strTemps.length>0)
			{
				for(int i=0;i<strTemps.length;i++)
				{
					//生成条形码
					String str = "KC-";
					
					SimpleDateFormat sm =  new SimpleDateFormat("yyyyMMddHHmmss");
					str += sm.format(new Date());
					Random rd = new Random();
					int num = (int)(rd.nextDouble()*10000);
					str += num;
					logger.info("条形码：====="+str);
					
					String hqlTemp = "from ToOrder as t where 1=1 and t.toOrderNum='"+strTemps[i]+"'";
					List list = warehousingBussiness.select(hqlTemp);
					map.put(str, list);
				}
			}
			request.setAttribute("maporder", map);
		
			
			logger.info(map);
//			request.setAttribute("KCdang", str);
			
		} catch (Exception e) {
			e.printStackTrace();			
		}
		return "detailstorage";
	}
	
	//新购入库
	public String newSig()
	{
		try {
			//添加入库操作
			String storageNo = request.getParameter("storageNo");
			//仓库
			String dep = request.getParameter("dep");
			//仓库类型
			String storageType = request.getParameter("storageType");
			//经手人
			String emp = request.getParameter("emp");
			//cus
			String cus = request.getParameter("cus");
			//入库时间
			String storagetime = request.getParameter("storagetime");
			//总价格
			String sum = request.getParameter("sum");
			//备注
			String remark = request.getParameter("remark");
			if(!remark.equals(""))
			{
				String str = URLDecoder.decode(remark, "utf-8");
				storage.setStorageRemark(str);
			}
			//条形码
			String RKdang = request.getParameter("RKdang");
			if(!emp.equals(""))
			{
				String str = URLDecoder.decode(emp, "utf-8");
				String hql = "from Employee as e where 1=1 and e.name='"+str+"'";
				Employee employee = (Employee)warehousingBussiness.select(hql).get(0);
				storage.setEmployee(employee);
			}
			Depot depot = new Depot();
			if(!dep.equals(""))
			{
				String str = URLDecoder.decode(dep, "utf-8");
				String hqldept = "from Depot as dp where 1=1 and dp.name='"+str+"'";
				depot = (Depot)warehousingBussiness.select(hqldept).get(0);
				storage.setDepot(depot);
			}
			
			String hqlstor = "from AllType as at where 1=1 and at.id="+new Integer(storageType);
			AllType allType = (AllType) warehousingBussiness.select(hqlstor).get(0);
			storage.setAllType(allType);
			
			storage.setStorageNo(storageNo);
			storage.setStorageDate(storagetime);
//			storage.setProductPriceSum(new Double(sum));
			
			storage.setIdentitys(RKdang);
			
			storage.setStorageVerify(0);
	    	storage.setDelflag("0");
	    	storage.setCustomer(null);
	    	Storage s = warehousingBussiness.addStorage(storage);
			
	    	
	    	//通过入库的到货单的采购单，索引到采购单详细
	    	String toOrderid = request.getParameter("toOrderid");
	    	String [] strTemp = null;
	    	String [] purorder = null;
	    	String [] orderandkey = null;
	    	
	    	
	    	Product p = new Product();
	    	List listkey = new ArrayList();
	    	StorageInfo sinfo;
	    	if(!toOrderid.equals(""))
    		{	
	    		strTemp = toOrderid.split(",");
	    		for(int n = 0; n<strTemp.length;n++)
	    		{
	    			 
	    		}
	    		if(strTemp.length>0)
	    		{
	    			for(int i=0;i<strTemp.length;i++)
	    			{
	    				String test = strTemp[i].trim();
	    				String [] str = test.split("b");
	    				System.out.println(str[0]);
	    				System.out.println(str[1]);
	    				
	    				//得到到货单的ID，通过id得到采购单
	    				String hqlorders = "from ToOrder as to where 1=1 and to.id="+new Integer(str[0]);
	    				ToOrder order =(ToOrder) warehousingBussiness.select(hqlorders).get(0);
	    				String purid = order.getPurOrder().getId().toString();
	    				
	    				//添加到入库详细
		    			 StorageInfo newsinfo = new StorageInfo();
		        		 newsinfo.setStorage(s);
		        		 newsinfo.setToOrder(order);
		        		 sinfo = warehousingBussiness.addStorageInfo(newsinfo);
		        		 
		        		 ////添加到产品表里
		    			String hqlpur = "from PurOrderInfo as po where 1=1 and po.purOrder.id="+new Integer(purid);
		    			PurOrderInfo orderInfo = (PurOrderInfo) warehousingBussiness.select(hqlpur).get(0);
		    			
		    			if(orderInfo !=null)
		    			{
		    				//查询商品信息，根据数量给每个商品分配一个条形码
		    				int count = orderInfo.getCount();
		    				
		    				for(int l =0;l<count;l++)
		    				{
		    					String strs = "KC-";
		    					
		    					SimpleDateFormat sm =  new SimpleDateFormat("yyyyMMddHHmmss");
		    					strs += sm.format(new Date());
		    					Random rd = new Random();
		    					int num = (int)(rd.nextDouble()*10000);
		    					strs += num;
		    					logger.info("条形码：====="+strs);
		    					listkey.add(strs);
		    					
		    					Property property = commbizimpl.getProperty(orderInfo.getModel().getModel());
			    				p.setProperty(property);
			    				p.setDepot(depot);
			    				p.setStorageInfo(sinfo);
			    				p.setBarcode(strs);
			    				p.setUseSum(0);
			    				p.setUsestate(3);
			    				p.setParentId(0);
			    				p.setDelflag("0");
			    				productBussiness.addProductObjs(p);
		    				}
		    			}
	    			}
	    		}
    		}
	    	request.getSession().setAttribute("listkey",listkey);
	    	audBussiness.addAuditingOrder2("RK", storageNo,"Storage",ck.getCookie(request, "filialemark"));
	    	response.getWriter().print("1");
	    	
		} catch (Exception e) {
			logger.error("======新购入库");
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	/*
	 * 导出,打印条形码
	 */
	public String doload()
	{
		try {
			List listkey = (List) request.getSession().getAttribute("listkey");
			
			String str = "";
			for(int i= 0;i<listkey.size();i++)
			{
				str += "'"+listkey.get(i).toString()+"',";
			}
			logger.info("++barcode"+str);
			String hql = "from Product as pd where 1=1 "; 
			if(!str.equals(""))
			{
				hql += " and pd.barcode in ("+str.substring(0, str.length()-1)+")";
			}
			else
			{
				hql += " and pd.barcode in ("+str+")";
			}
			List purOrderInfos = warehousingBussiness.select(hql);
			request.setAttribute("purOrderInfos", purOrderInfos);
			//清楚缓存
			
		} catch (Exception e) {
			logger.error("doload error");
			e.printStackTrace();
			return error;
		}
		return "doloadlist";
	}
	/*
	 * 显示
	 */
	public String showdoload()
	{
		try {
			List listkey = (List) request.getSession().getAttribute("listkey");
			
			String str = "";
			for(int i= 0;i<listkey.size();i++)
			{
				str += "'"+listkey.get(i).toString()+"',";
			}
			logger.info("++barcode"+str);
			String hql = "from Product as pd where 1=1 "; 
			if(!str.equals(""))
			{
				hql += " and pd.barcode in ("+str.substring(0, str.length()-1)+")";
			}
			else
			{
				hql += " and pd.barcode in ("+str+")";
			}
			List purOrderInfos = warehousingBussiness.select(hql);
			request.setAttribute("purOrderInfos", purOrderInfos);
			//清楚缓存
			
		} catch (Exception e) {
			logger.error("doload error");
			e.printStackTrace();
			return error;
		}
		return "showdoload";
	}

	
}
