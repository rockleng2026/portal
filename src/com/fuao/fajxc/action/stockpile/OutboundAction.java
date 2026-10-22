package com.fuao.fajxc.action.stockpile;
import org.apache.log4j.Logger;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.action.system.AuditingAction;
import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.DepotBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityBussiness;
import com.fuao.fajxc.bussiness.commodity.ProductBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.stockpile.IncomeBussiness;
import com.fuao.fajxc.bussiness.stockpile.OutboundBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.impl.purchase.PurReturnOrderDaoImpl;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Contract;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.fuao.fajxc.vo.ReturnOrderInfo;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.StatInfo;
import com.fuao.fajxc.vo.UpServer;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import freemarker.template.utility.Execute;
/**
 * 出库Action
 * @author 14012
 *
 */
public class OutboundAction implements ModelDriven, ServletRequestAware,ServletResponseAware {
	public static Logger  log = Logger.getLogger(OutboundAction.class);
	private OutboundBussiness obb;
	private HttpServletRequest request;
	private EmployeeBussiness empBussiness;
	private CommodityBussiness commbizimpl;
	private DepotBussiness depotBussiness;
	private CustomerBussiness customerBussiness;
	private SupplierBussiness supplierBussiness;
	private IncomeBussiness incomeBussiness;
	private ProductBussiness  productBussiness;

	private HttpServletResponse response;
	private Outbound outbound;
	private Object[] ids;
	private AuditingBussiness audBussiness;
	//记录动态
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
	
	
	private static Logger logger = Logger.getLogger(PurReturnOrderDaoImpl.class);
	//获得出库单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	//获得产品Id字符串
	private String proId;
	//声明置文件工具
	PropertyEditor proEdit=new PropertyEditor();
	
	Cookies ck = new Cookies();
	
	


	public ProductBussiness getProductBussiness() {
		return productBussiness;
	}

	public void setProductBussiness(ProductBussiness productBussiness) {
		this.productBussiness = productBussiness;
	}

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

	/**
	 * @return the proId
	 */
	public String getProId() {
		return proId;
	}

	/**
	 * @param proId the proId to set
	 */
	public void setProId(String proId) {
		this.proId = proId;
	}

	/**
	 * @return the supplierBussiness
	 */
	public SupplierBussiness getSupplierBussiness() {
		return supplierBussiness;
	}

	/**
	 * @param supplierBussiness the supplierBussiness to set
	 */
	public void setSupplierBussiness(SupplierBussiness supplierBussiness) {
		this.supplierBussiness = supplierBussiness;
	}


	/**
	 * @return the customerBussiness
	 */
	public CustomerBussiness getCustomerBussiness() {
		return customerBussiness;
	}

	/**
	 * @param customerBussiness the customerBussiness to set
	 */
	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}

	/**
	 * @return the depotBussiness
	 */
	public DepotBussiness getDepotBussiness() {
		return depotBussiness;
	}

	/**
	 * @param depotBussiness the depotBussiness to set
	 */
	public void setDepotBussiness(DepotBussiness depotBussiness) {
		this.depotBussiness = depotBussiness;
	}

	/**
	 * @return the commbizimpl
	 */
	public CommodityBussiness getCommbizimpl() {
		return commbizimpl;
	}

	/**
	 * @param commbizimpl the commbizimpl to set
	 */
	public void setCommbizimpl(CommodityBussiness commbizimpl) {
		this.commbizimpl = commbizimpl;
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
	 * @return the obb
	 */
	public OutboundBussiness getObb() {
		return obb;
	}

	/**
	 * @param obb the obb to set
	 */
	public void setObb(OutboundBussiness obb) {
		this.obb = obb;
	}
	
	public Object getModel() {
		outbound=new Outbound();
		return outbound;
	}
	/**
	 * 出库单列表
	 * @return
	 */
	public String outBoundInfo()
	{	
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		System.out.println("outBoundInfo....");
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找的出库单编号
		
		String purNo=request.getParameter("purNo");
		String	dtime=(String)request.getParameter("datetime");
		String	depot=(String)request.getParameter("depot");
		if(request.getParameter("fy")!=null){
			
			purNo=(String)request.getSession().getAttribute("purNo");
			dtime=(String)request.getSession().getAttribute("datetime");
			depot=(String)request.getSession().getAttribute("depot");
		}
		
			else{
				
				request.getSession().setAttribute("purNo", "");
				request.getSession().setAttribute("datetime", "");
					request.getSession().setAttribute("depot", "");
				
			}
			
		
		if(purNo!=null  && !purNo.equals("")){
			addhql+=" and outboundNo like '%"+purNo+"%'";
			request.getSession().setAttribute("purNo", purNo);
		}
		System.out.println("addhql"+addhql);
		String hql="from Outbound where delflag!='1'"+addhql;
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		
		if(dtime!=null && !dtime.equals("") ){//查询日期
		
			hql += " and time like  '%"+dtime+"%'";
			request.getSession().setAttribute("dtime", dtime);
		}
	
		if(depot!=null && !depot.equals("")){//查询仓库
		
				hql += " and depot.name  like  '%"+depot+"%'";
				request.getSession().setAttribute("depot", depot);
			}
		hql += " order by id desc";
		
		System.out.println("hql:"+hql);
		System.out.println("pageNo:"+pageNo);
		Pages pages=obb.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages"+pages);
		request.setAttribute("pages", pages);
		if(request.getParameter("potalckd")==null){
			return "outboundInfo";
		}else{
			
			return "newoutboundInfo";
		}
		
	}
	/**
	 * 弃用出库单
	 * @return
	 */
	public String delckd(){
		String cid=request.getParameter("cid");//id
		String getoutbround="FROM Outbound where id="+Integer.parseInt(cid);
		
		List clist=customerBussiness.exhql(getoutbround);
		Outbound outbount=new Outbound();
		outbount=(Outbound)clist.get(0);
		outbount.setDelflag("1");//弃用
		audBussiness.updObj(outbount);
		if(outbount.getAuditingState()==1){//已审核.商品不该状态
		
		}else{
		String outbroundinfo="FROM OutboundInfo where outbound.id="+Integer.parseInt(cid);
		List culist=customerBussiness.exhql(outbroundinfo);
		List<OutboundInfo> ll=culist;
		for (int i = 0; i < culist.size(); i++) {
			OutboundInfo obi=new OutboundInfo();
			obi=ll.get(i);
			Product pro=new Product();
			pro=obi.getProduct();
			pro.setUsestate(2);
			audBussiness.updObj(pro);
		}
		}
		return "delckd";	
	}
	
	/**
	 * 出库单详细信息
	 * @return
	 */
	public String detail()
	{
		String id=request.getParameter("cid");
		String outNo=request.getParameter("outNo");
		//获取info
		String info = request.getParameter("info");
		if(id!=null)
		{
			List list=obb.someOutBound(" and id="+id);
			request.setAttribute("outList", list.get(0));
		}
		
		String empid="";
		Employee emp=null;
		if(empid==""){
			
			 emp=(Employee)request.getSession().getAttribute("emp");
			 empid=String.valueOf(emp.getId());
		}
		System.out.println("ck::::"+empid);
		boolean flag=audBussiness.checkemp(outNo, empid);
		System.out.println("saleActionflag:::::"+flag);
		if(flag){
			request.setAttribute("mark", "mark");
		}
		boolean flag1=audBussiness.checkemp1(outNo, empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(outNo!=null){
				String addhql2=" and orderNo='"+outNo+"'";
				
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0){
					
					String depid ="";
					if(depid==""){
						 emp=(Employee)request.getSession().getAttribute("emp");
						 depid=String.valueOf(emp.getDepartment().getId());
					}
					for(int i=0; i<audList.size(); i++){
						
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						
						if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 ){
							log.info(aot.getDepartment().getId()+"部门信息"+Integer.parseInt(depid));
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
		
		if(request.getParameter("potalckd")==null){
			return "detail";
		}else{
		
			return "newdetail";
				
			
		}
		
	}
	
	/**
	 * 显示添加出库单
	 */
	public String addshow1()
	{	 DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	 format.setLenient(false);  //要转换字符串 str_test  String str_test ="2011-04-24";  
	 String ly_time = new SimpleDateFormat("ss").format(Calendar.getInstance().getTime());

     
		String ckNo="CK-"+serial.getSerialNumber()+ly_time+"";
		request.setAttribute("CKNo", ckNo);
		List typeList=obb.selType("");
		request.setAttribute("typeList", typeList);
		
		if(request.getParameter("potalckd")==null){
			return "add";
		}else{
			
			return "newadd";
		}
		
	}
	
	/**
	 * 查询套餐
	 * @return
	 */
	public String setmeal()
	{
		String chargeType=request.getParameter("chargetype");
		
	
		return null;
	}
	/**
	 * 根据mark显示对话框
	 * @return
	 * @throws UnsupportedEncodingException 
	 
	 */
	public String showDialog() throws UnsupportedEncodingException 
	{
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println("showDialog");
		System.out.println("request:"+request);
		System.out.println("depotBussiness"+depotBussiness);
		
		String num=request.getParameter("num");
		if(num !=null && !"".equals(num)){
			request.setAttribute("num", num);
		}
		String mark=request.getParameter("mark");
		System.out.println("mark:"+mark);
		//页码
		String pageNoS = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		int pageNo=Integer.parseInt(pageNoS);
		//仓库对话框
		if(mark.equals("depot")){
			String hql="from Depot where del = 0 ";
			
			String name = request.getParameter("cname");
			if(name !=null && !name.equals(""))
			{
				hql +=" and name like '%"+name+"%'";
			}
			hql+=" order by id desc";
			Pages pages=depotBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showDepotDialog";
		}
		else if(mark.equals("custom")){
			//8.10 ytl 修改,要求弹层显示正式客户(customer_type2=3);
			String hql="from Customer as tb where 1=1 and customer_type2=3 and del!='1'";
			String name1 = request.getParameter("cusname");
			Employee emp = (Employee)request.getSession().getAttribute("emp");
			
			
			if(emp == null ){
				return null;				
			}
			String sonIds = customerBussiness.executeSql("select getChildDeptLst("+emp.getDepartment().getId()+")");
			if(name1!=null)
			{
			String name=URLDecoder.decode(name1, "UTF-8");
			if(name !=null && !name.equals(""))
			{
				hql +=" and realName like '%"+name+"%' or customerName like '%"+name+"%' or customerCompany like '%"+name+"%' or qq like '%"+name+"%' or phone like '%"+name+"%' or mobilePhone like '%"+name+"%'";
			}
			}
			hql += " and del!='1' and (employee.id = "+emp.getId()+" or(employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
			" and employee.department.id in ("+sonIds+")))";
			hql+="order by tb.id desc";
			System.out.println("hql is"+hql);
			Pages pages=customerBussiness.exHqlPages(hql, pageNo, 25, null);
			request.setAttribute("pages", pages);
			return "showcustomDialog";
		}
		else if(mark.equals("commodity")){
			System.out.println("pro______________");
			//判断是否为下架单
			String down=request.getParameter("down");
			System.out.println("down::::::"+down);
			String hql="from Product where delflag=0 and usestate!=3";
			if(down!=null&&down.equals("down"))
			{
				hql+=" and useSum <> '0' ";
			}
			else
				hql+=" and usestate=2";
			String name1 = request.getParameter("name");
			if(name1 !=null && !name1.equals(""))
			{
				String name=URLDecoder.decode(name1, "UTF-8");
				hql +=" and property.name like '%"+name+"%'";
			}
			String addH=request.getParameter("addH");
			System.out.println("addH:"+addH);
			//获得服务器标识
			String sev=request.getParameter("server");
			if(addH!=null&&addH!="")
			{
				hql+=" and depotId="+Integer.parseInt(addH);
			}
			
			
			if(sev!=null){
				if(sev.equals("server")){
					hql+=" and property.model.commodityTpye.id in ("+proEdit.getID("server")+","+proEdit.getID("vpsid")+") ";
				}else if(sev.equals("cpu")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("cpu");
				}else if(sev.equals("networkCard")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("networkCard");
				}else if(sev.equals("memory")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("memory");
				}else if(sev.equals("power")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("power");
				}else if(sev.equals("hd")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("hd");
				}else if(sev.equals("mainboard")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("mainboard");
				}else if(sev.equals("crate")){
					hql+=" and property.model.commodityTpye.id="+proEdit.getID("crate");
				}
			}
			hql+=" order by id desc";
			System.out.println("hql:::::::::::::::::::::"+hql);
			Pages pages=commbizimpl.exHqlPages(hql, pageNo, 10, null);
			if(pages!=null)
				System.out.println("这是服务器的查询----  "+pages.getAllCount());
			request.setAttribute("pages", pages);
			return "showcommodityDialog";
		}
		else if(mark.equals("employee")){
			String hql="from Employee where delflag=0 and isLeave=1 and department.depNo != 111 ";
			String name1 = request.getParameter("ename");
			if(name1 !=null && !name1.equals(""))
			{
				String name=URLDecoder.decode(name1, "UTF-8");
				hql +=" and name like '%"+name+"%'";
			}
			hql+="order by id desc";
			Pages pages=empBussiness.paginationQuery(hql, pageNo, 10, null);
			String page = request.getParameter("page");
			if(page !=null && !page.equals("")){
				request.setAttribute("page", page);
			}
			request.setAttribute("pages",pages);
			return "showemployeeDialog";
		}
		else if(mark.equals("supplier")){
			System.out.println("supplier");
			String hql="from Supplier where del = 0 ";
			String name1 = request.getParameter("name");
			if(name1 !=null && !name1.equals(""))
			{
				String name=URLDecoder.decode(name1, "UTF-8");
				hql +=" and supplierName like '%"+name+"%'";
			}
			hql+=" order by date desc";
			Pages pages=supplierBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showsupplierDialog";
		}
		else if(mark.equals("toOrder")){	// 三个条件：未入库、已审核、未删除
			String hql="from ToOrder where delflag = 0 and toOrderVerify=1 and storageState=0";
			String name = request.getParameter("name");
			if(name !=null && !name.equals(""))
			{
				hql +=" and piciNO like '%"+name+"%'";
			}
			hql+=" order by id desc";
			Pages pages = commbizimpl.exHqlPages(hql, pageNo, 10, null);
			request.setAttribute("pages",pages);
			return "showtoOrderDialog";
		}
		else if(mark.equals("income")){
			System.out.println("income");
			String addhql="";
			//模糊查找的报损报溢单编号
			String purNo=request.getParameter("incomeNo");
			if(purNo!=null){
				addhql+=" and incomeNo like '%"+purNo+"%'";
			}
			String hql="from Income where delflag=0"+addhql+" order by id desc";
			Pages pages=incomeBussiness.exHqlPages(hql, pageNo, 10, null);
			System.out.println("pages"+pages);
			request.setAttribute("pages", pages);
			return "showincomeDialog";
		}else if(mark.equals("upserver")){//获得上架单列表
			//onclick="completemission('showDialogOutbound.do?mark=commodity&server=server&down=down','')"
			System.out.println("upserver");
			Map map = (Map)ActionContext.getContext().get("map");
			pageNo=Integer.parseInt((request.getParameter("pageNo")==null?"1":request.getParameter("pageNo")));
			String addhql="";
			//模糊查找
			String sjNo=request.getParameter("sjNo");
			String cid=request.getParameter("cid");
			
			Cookies cook = new Cookies();
			String employeeId = cook.getCookie(request, "employeeId");
			System.out.println("employeeId : "+employeeId);
			List<Employee> emplist = executeRecordBussiness.exHqls(" from Employee where id = "+employeeId);
			String marker = request.getParameter("marker")==null?"":request.getParameter("marker");
			String state = request.getParameter("state")==null?"1":request.getParameter("state");
			
			String funid = request.getParameter("funid");		//菜单栏id
			String resouceSet = "";
			if(funid!=null&&!funid.equals(""))
			{
				Map resouceMap = (Map)ActionContext.getContext().get("resouceSet");		//组角色访问资源权限列表
//				resouceSet = (String)resouceMap.get("resouce");//这里获取不到为空造型报错
				resouceSet = "200,";//这里获取不到为空造型报错
			}
			
			//待审核的单据
			if(marker!=null&&!marker.equals(""))
			{
				String condition = audBussiness.getOrderNOList("UpServer", employeeId,sjNo,state);
				if(condition!=null&&!condition.equals(""))
				{
					condition = condition.substring(0,condition.length()-1);
				}
				else
				{
					condition = "''";
				}
				addhql += " and upNo in ("+condition+")" ;
				request.setAttribute("tag", marker);
				request.setAttribute("state", state);
			}
			//组角色访问的资源权限   
			else if (resouceSet!=null&&!resouceSet.equals(""))
			{
				//根据单号筛选单据
				if(sjNo!=null&&sjNo!=""){
					addhql+=" and upNo like '%"+sjNo.trim()+"%'";
				}
				if(resouceSet.indexOf(funid)==-1)
				{
				//	addhql +=" and employee.id = '0'";
				}
			}
			//部门权限
			else  //根据员工id查询单据
			{
				if(sjNo!=null&&sjNo!=""){
					addhql+=" and upNo like '%"+sjNo.trim()+"%'";
				}
				if(employeeId !=null &&!employeeId.equals(""))
				{
					if(emplist.size()>0)
					{
						//职位等级小于3的，表明是主管以下的，就查询当前登录的员工id的数据列表
						if(emplist.get(0).getGroups().getGrade()<3)  
						{
							addhql +=" and saleOrder.employee.id = '"+employeeId+"'";
						}
						//职位等小于等于4的并且职位大于等3的，表明是经理级 的和主管级的。主管级的看不到经理级的数据
						else if(emplist.get(0).getGroups().getGrade()>=3&&emplist.get(0).getGroups().getGrade()<=4)
						{
							List<Employee> elist = audBussiness.getObjectList("Employee", " and groups.superGroupId = "+emplist.get(0).getGroups().getSuperGroupId()+" and groups.grade <"+emplist.get(0).getGroups().getGrade());
							String empids = "";
							for(Employee e : elist)
							{
								empids += e.getId()+",";
							}
							if(empids!=null&&!empids.equals(""))
							{
								empids = empids+employeeId;		//将自己的也查出来
								addhql +=" and saleOrder.employee.id in("+empids+")";
							}
						}
						//职位等级是5的，表明是总经办的或者管理员的。可以看到所有数据
						else
						{
							//可以不用加员工id，进行查询
						}
					}
				}
				ServletActionContext.getRequest().setAttribute("option", map);
			}
			if(cid != null || !"".equals(cid)){
				addhql += " and saleOrder.customer.customerId ="+cid+" ";
			}
			String hql="from UpServer where delflag=0"+addhql+" order by id desc";
			System.out.println("hq2l:::::"+hql);
			Pages pages=customerBussiness.exHqlPages(hql, pageNo, 20, null);
			if(pages.getAllCount()>0)
			{
				for(int i=0;i<pages.getPageList().size();i++)
				{
					if(((UpServer)pages.getPageList().get(i)).getServerIp()!=null||((UpServer)pages.getPageList().get(i)).getServerIp().equals("")==false)
					{
						String ip = ((UpServer)pages.getPageList().get(i)).getServerIp().replace("，", ",");
						ip = ip.replace(",", "<br />");
						((UpServer)pages.getPageList().get(i)).setServerIp(ip);
//						String[] serverIP=((UpServer)pages.getPageList().get(i)).getServerIp().split("，");
//						((UpServer)pages.getPageList().get(i)).setServerIp(serverIP[0]);
					}
				}
				for(int i=0;i<pages.getPageList().size();i++)
				{
					if(((UpServer)pages.getPageList().get(i)).getTemp()!=null||((UpServer)pages.getPageList().get(i)).getTemp().equals("")==false)
					{
						String serverIP=((UpServer)pages.getPageList().get(i)).getTemp();
						if(serverIP.length()>6)
						{
						String SIP=serverIP.substring(0, 6)+"...";
						((UpServer)pages.getPageList().get(i)).setTemp(SIP);
						}
					}
				}
			}
			request.setAttribute("pages", pages);
			//request.setAttribute("mark", 0);
			//from UpServer where delflag=0 order by id desc
			//from UpServer where delflag=0 and saleOrder.employee.id = '13' order by id desc
			return "showupserverDialog";
		}
		
		return null;
		
	}
	/**
	 * 客户弹窗
	 * @throws IOException 
	 */
	public void selectcusinfo() throws IOException
	{
		String id=request.getParameter("id");
		
		String hql="from Customer where del=0 and customerId="+Integer.parseInt(id)+"";
		List<Customer> customer=obb.selectInfo(hql);
		String str="<tr><td colspan='4' align='right' height='30'><input  type='button' id='close' name='close' onclick='closeInfo()' value='关闭' /></td></tr>";
		 str+="<tr><td colspan='4' align='center' height='50'>客户详细信息</td></tr>";
		if(customer.size()>0)
		{
			Customer cus=customer.get(0);
			str+="<tr><td height='30'>客户名字</td><td>"+cus.getRealName()+"</td><td>客户电话</td><td>"+cus.getPhone()+"</td></tr>";
			str+="<tr><td height='30'>身份证</td><td>"+cus.getCardid()+"</td><td>客户公司</td><td>"+cus.getCustomerCompany()+"</td></tr>";
			str+="<tr><td height='30'>客户地址</td><td>"+cus.getCustomerAddress()+"</td><td>客户银行卡号</td><td>"+cus.getBankAccount()+"</td></tr>";
			str+="<tr><td height='30'>邮箱</td><td>"+cus.getEmail()+"</td><td>邮编</td><td>"+cus.getZipCode()+"</td></tr>";
			if(cus.getEmployee()!=null&&cus.getEmployee().equals("")==false)
			{
				str+="<tr><td height='30'>录入时间</td><td>"+cus.getDate()+"</td><td>业务员</td><td>"+cus.getEmployee().getName()+"</td></tr>";
			}
			else
			{
				str+="<tr><td height='30'>录入时间</td><td>"+cus.getDate()+"</td><td>业务员</td><td>没有业务员</td></tr>";
			}
			
		}
		str+="";
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(str);
	}
	/***
	 * 采购单弹窗详细
	 * @throws IOException 
	 */
	public void selectpoinfo() throws IOException
	{
		
		
		String id=request.getParameter("id");
		
		String hql="from PurOrder where delflag=0 and id="+Integer.parseInt(id)+"";
		List<PurOrder> pur=obb.selectInfo(hql);
		String str="<tr><td colspan='4' align='right' height='30'><input  type='button' id='close' name='close' onclick='closeInfo()' value='关闭' /></td></tr>";
		 str+="<tr><td colspan='4' align='center' height='50'>采购详细信息</td></tr>";
		 if(pur.size()>0)
		 {
			 PurOrder p=pur.get(0);
			 str+="<tr><td height='30'>采购单号</td><td>"+p.getPurOrderNo()+"</td><td>供应商</td><td>"+p.getSupplier().getSupplierName()+"</td></tr>";
			 str+="<tr><td height='30'>订交时间</td><td>"+p.getOrderTime()+"</td><td>交货时间</td><td>"+p.getDeliveryTime()+"</td></tr>";
			 String hql1="from PurOrderInfo where purOrder.id="+Integer.parseInt(id)+"";
			 
			 List<PurOrderInfo> poi=obb.selectInfo(hql1);
			 if(poi.size()>0)
			 {
			   PurOrderInfo pi=poi.get(0);
			 str+="<tr><td colspan='4' align='center' height='40'>商品信息</td></tr>";
			 
			str+="<tr><td height='30'>商品类型</td><td>"+pi.getModel().getCommodityTpye().getTypeName()+"</td><td>商品型号</td><td>"+pi.getModel().getName()+"</td></tr>";
			str+="<tr><td height='30'>单价</td><td>"+pi.getPrice()+"</td><td>折扣</td><td>"+pi.getDiscount()+"</td></tr>";
			str+="<tr><td height='30'>采购数量</td><td>"+pi.getCount()+"</td><td>总价</td><td>"+pi.getSum()+"</td></tr>";
			 }
			 else
			 {
				 str+="<tr><td colspan='4' align='center' height='40'>没有商品</td></tr>";
			 }
		 }
		 response.setCharacterEncoding("UTF-8");
			response.getWriter().print(str);
	}
	public void selectto() throws IOException
	{
		String id=request.getParameter("id");
		
		String hql="from ReturnOrderInfo where returnOrder.id="+Integer.parseInt(id)+"";
		List<ReturnOrderInfo> pur=obb.selectInfo(hql);
	String str="";
		if(pur.size()>0)
		{
			for(int i=0;i<pur.size();i++)
			{
				ReturnOrderInfo rp=pur.get(i);
				str+="<TR id='tr"+i+"'><TD align=center height=30 width='18%'><input type='hidden' id='batchids' name='batchexpId' value='"+rp.getBatchexp().getId()+"'/><input id='model"+i+"' name='modelid' value='"+rp.getModel().getName()+"'/><input id='model"+i+"' type='hidden' name='model' value='"+rp.getModel().getModel()+"'/></TD>";
				str+="<TD align=center height=30 width='15%'><input id='count"+i+"' onblur='onesum("+i+")' name='count' value='"+rp.getCount()+"'/></TD>";
				str+="<TD align=center height=30 width='15%'><input id='infoprice"+i+"' onblur='onesum("+i+")' name='infoprice' value='"+rp.getReturnprice()+"'/></TD>";
				str+="<TD align=center height=30 width='15%'><input id='discount"+i+"' onblur='onesum("+i+")' name='discount' value='"+rp.getDiscount()+"'/></TD>";
				str+="<TD align=center height=30 width='15%'><input id='sum"+i+"' onblur='onesum("+i+")' name='sum' value='"+rp.getSum()+"'/></TD>";
				str+="<TD align=center height=30 width='10%'><input value='删除' class='button' type='button'  onclick='delTr("+i+")' /></TD></TR>";
				
				
				
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(str);
	}
	public void selectpo() throws IOException
	{
		String id=request.getParameter("id");
		
		String hql="from PurOrderInfo where purOrder.id="+Integer.parseInt(id)+"";
		List<PurOrderInfo> pur=obb.selectInfo(hql);
		String str="";
		if(pur.size()>0)
		{
			for(int i=0;i<pur.size();i++)
			{
				PurOrderInfo rp=pur.get(0);
				
				str+="<TR id='tr"+i+"'><TD align=center height=30 ><input type='hidden' id='batchids' name='batchids' value='"+rp.getId()+"'><input id='model"+i+"' name='modelid' value='"+rp.getModel().getName()+"'><input type='hidden' id='model"+i+"' name='model' value='"+rp.getModel().getModel()+"'></TD>";
				str+="<TD align=center height=30 ><input id='purcount"+i+"' name='purcount' value='"+rp.getCount()+"'></TD>";
				str+="<TD align=center height=30 ><input  id='count"+i+"' onblur='onesum("+i+"})' name='count' value='"+rp.getCount()+"'></TD>";
				str+="<TD align=center height=30 ><input id='infoprice"+i+"' onblur='onesum("+i+")' name='infoprice' value='"+rp.getPrice()+"'></TD>";
				str+="<TD align=center height=30 ><input id='discount"+i+"' onblur='onesum("+i+")' name='discount' value='"+rp.getDiscount()+"'></TD>";
				str+="<TD align=center height=30 ><input id='sum"+i+"' onblur='onesum("+i+")' name='sum' value='"+rp.getSum()+"'></TD>";
				str+="<TD align=center height=30 ><input type='button' value='删除' class='button' onclick='delTr("+i+")'></TD></tr>";
				
//				
				
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(str);
	}
	/**
	 * 销售订单的弹窗
	 * @throws IOException 
	 */
	public void selectSaleOrderInfo() throws IOException
	{
		String id=request.getParameter("id");
		

		String hql="from SaleOrder where delflag='0' and id="+Integer.parseInt(id)+"";
		List<SaleOrder> saleOrder=obb.selectInfo(hql);
		String str="<tr><td colspan='4' align='right' height='30'><input  type='button' id='close' name='close' onclick='closeInfo()' value='关闭' /></td></tr>";
		 str+="<tr><td colspan='4' align='center' height='50'>销售订单详细</td></tr>";
		if(saleOrder.size()>0)
		{
			SaleOrder so=saleOrder.get(0);
			str+="<tr><td>订单编号</td><td>"+so.getSaleOrderNo()+"</td><td>客户名称</td><td>"+so.getCustomer().getRealName()+"</td></tr>";
			String aud="";
			if(so.getAuditingState().equals("1")||so.getAuditingState().equals("2"))
				aud="审核通过";
			else if(so.getAuditingState().equals("8"))
				aud="审核进行中";
			else
				aud="未审核";
			str+="<tr><td>销售员工</td><td>"+so.getEmployee().getName()+"</td><td>机柜</td><td></td></tr>";
			str+="<tr><td>审核状况</td><td>"+aud+"</td><td>机位大小</td><td>"+so.getSpaceSize()+"</td></tr>";
			str+="<tr><td>机器数量</td><td>"+so.getProductNum()+"</td><td>IP数量</td><td>"+so.getIpNum()+"</td></tr>";
			str+="<tr><td>宽带总数</td><td>"+so.getBw()+"</td><td>订单价格</td><td>"+so.getPrice()+"</td></tr>";
			str+="<tr><td>订单类型</td><td>"+so.getAllTypeByOrdertype().getQuestionName()+"</td><td>付费类型</td><td>"+so.getAllTypeByPayStyle().getTypeName()+"</td></tr>";
			str+="<tr><td>开始时间</td><td>"+so.getBeginTime()+"</td><td>结束时间</td><td>"+so.getEndTime()+"</td></tr>";
			str+="<tr><td>付费状态</td><td>"+so.getAllTypeByPayStatus().getTypeName()+"</td><td>经办人</td><td>"+so.getInputAdmin()+"</td></tr>";
			str+="<tr><td>服务器配置描述</td><td colspan='3'>"+so.getServerConfiguration()+"</td></tr>";
			str+="<tr><td>备注</td><td colspan='3'>"+so.getDescription()+"</td></tr>";
		}
		str+="";
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(str);
	}
	/**
	 * 仓库弹窗
	 * @throws IOException 
	 */

	/**
	 * 员工弹窗
	 * @throws IOException 
	 */
	public void selectempinfo() throws IOException
	{
		String id=request.getParameter("id");
		
		String hql="from Employee where delflag=0 and id="+Integer.parseInt(id)+"";
		List<Employee> emp=obb.selectInfo(hql);
		String str="<tr><td colspan='4' align='right' height='30'><input  type='button' id='close' name='close' onclick='closeInfo()' value='关闭' /></td></tr>";
		 str+="<tr><td colspan='4' align='center' height='50'>销售订单详细</td></tr>";
		if(emp.size()>0)
		{
			Employee ep=emp.get(0);
			str+="<tr><td>员工名字</td><td>"+ep.getName()+"</td><td>名族</td><td>"+ep.getNation()+"</td></tr>";
			str+="<tr><td>省份证号</td><td>"+ep.getCardid()+"</td><td>健康状况</td><td>"+ep.getHealth()+"</td></tr>";
			String sex="";
			if(ep.getSex()==1||ep.getSex()==null)
			{
				sex="男";
			}
			else
			{
				sex="女";
			}
			str+="<tr><td>性别</td><td>"+sex+"</td><td>身高</td><td>"+ep.getStature()+"</td></tr>";
			String isleave="";
			if(ep.getIsLeave()==1||ep.getIsLeave()==null)
				isleave="在职";
			else
				isleave="离职";
			str+="<tr><td>入职时间</td><td>"+ep.getEntryTime()+"</td><td>是否在职</td><td>"+isleave+"</td></tr>";
			if(ep.getIsLeave()==0)
			str+="<tr><td>离职时间</td><td>"+ep.getLeaveTime()+"</td><td>离职原因</td><td>"+ep.getLeaveReason()+"</td></tr>";
			str+="<tr><td>联系电话</td><td>"+ep.getTel()+"</td><td>体重</td><td>"+ep.getHeft()+"</td></tr>";
			String married="";
			if(ep.getMarried().equals("1"))
				married="已婚";
			else
				married="未婚";
			str+="<tr><td>年龄</td><td>"+ep.getAge()+"</td><td>婚配</td><td>"+married+"</td></tr>";
			str+="<tr><td>学历</td><td>"+ep.getEducation()+"</td><td>户籍地</td><td>"+ep.getCensusreg()+"</td></tr>";
			str+="<tr><td>部门</td><td>"+ep.getDepartment().getName()+"</td><td>职位</td><td>"+ep.getGroups().getGroupName()+"</td></tr>";
			str+="<tr><td>编号</td><td>"+ep.getEmpNo()+"</td><td>计算机水平</td><td>"+ep.getComputeleve()+"</td></tr>";
			str+="<tr><td>生日</td><td>"+ep.getBirth()+"</td><td>家庭地址</td><td>"+ep.getPlace()+"</td></tr>";
			str+="<tr><td>创建日期</td><td>"+ep.getTime()+"</td><td>现居地</td><td>"+ep.getNowplace()+"</td></tr>";
			str+="<tr><td>邮箱</td><td>"+ep.getEmail()+"</td><td>英语水平</td><td>"+ep.getEngleve()+"</td></tr>";
			str+="<tr><td>紧急联系电话</td><td>"+ep.getUrgenttel()+"</td><td>特长</td><td>"+ep.getSpecialty()+"</td></tr>";
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(str);
	}
	/**
	 * 请购单弹窗的详细信息
	 * @throws IOException 
	 */
	public void selectinfo1() throws IOException
	{
		String id=request.getParameter("id");
	
		String hql="from Product where delflag=0 and property.id="+Integer.parseInt(id)+"";
		List<Product> product=obb.selectInfo(hql);
		String str="<tr><td colspan='4' align='right' height='30'><input  type='button' id='close' name='close' onclick='closeInfo()' value='关闭' /></td></tr>";
		 str+="<tr><td colspan='4' align='center' height='50'>商品详细信息</td></tr>";
		if(product.size()>0)
		{
		
			Product pd=product.get(0);
			System.out.println(pd.getProperty().getModel().getCommodityTpye().getId());
			String hql1="from CommodityTpye where del='0' and  id="+pd.getProperty().getModel().getCommodityTpye().getId()+"";
			CommodityTpye ct=(CommodityTpye)obb.selectInfo(hql1).get(0);
			str +="<tr><td>商品名称:</td><td>"+pd.getProperty().getName()+"</td><td>商品类型:</td><td>"+pd.getProperty().getModel().getCommodityTpye().getTypeName()+"</td></tr>";
			str +="<tr><td>商品型号:</td><td>"+pd.getProperty().getModel().getName()+"</td><td>商品建立时间:</td><td>"+pd.getProperty().getTime()+"</td></tr>";
			
			String temp="";
			if (ct.getField().getTemp1() != null
					&& !ct.getField().getTemp1().equals("")) {
				if(pd.getProperty().getTemp1()!=null)
				{
					 temp=pd.getProperty().getTemp1();
				}
				str+="<tr><td>"+ct.getField().getTemp1()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp2() != null
					&& !ct.getField().getTemp2().equals("")) {
				if(pd.getProperty().getTemp2()!=null)
				{
					 temp=pd.getProperty().getTemp2();
				}
				str+="<tr><td>"+ct.getField().getTemp2()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp3() != null
					&& !ct.getField().getTemp3().equals("")) {
				if(pd.getProperty().getTemp3()!=null)
				{
					 temp=pd.getProperty().getTemp3();
				}
				str+="<tr><td>"+ct.getField().getTemp3()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp4() != null
					&& !ct.getField().getTemp4().equals("")) {
				if(pd.getProperty().getTemp4()!=null)
				{
					 temp=pd.getProperty().getTemp4();
				}
				str+="<tr><td>"+ct.getField().getTemp4()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp5() != null
					&& !ct.getField().getTemp5().equals("")) {
				if(pd.getProperty().getTemp5()!=null)
				{
					 temp=pd.getProperty().getTemp5();
				}
				str+="<tr><td>"+ct.getField().getTemp5()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp6() != null
					&& !ct.getField().getTemp6().equals("")) {
				if(pd.getProperty().getTemp6()!=null)
				{
					 temp=pd.getProperty().getTemp6();
				}
				str+="<tr><td>"+ct.getField().getTemp6()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp7() != null
					&& !ct.getField().getTemp7().equals("")) {
				if(pd.getProperty().getTemp7()!=null)
				{
					 temp=pd.getProperty().getTemp7();
				}
				str+="<tr><td>"+ct.getField().getTemp7()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp8() != null
					&& !ct.getField().getTemp8().equals("")) {
				if(pd.getProperty().getTemp8()!=null)
				{
					 temp=pd.getProperty().getTemp8();
				}
				str+="<tr><td>"+ct.getField().getTemp8()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp9() != null
					&& !ct.getField().getTemp9().equals("")) {
				if(pd.getProperty().getTemp9()!=null)
				{
					 temp=pd.getProperty().getTemp9();
				}
				str+="<tr><td>"+ct.getField().getTemp9()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp10() != null
					&& !ct.getField().getTemp10().equals("")) {
				if(pd.getProperty().getTemp10()!=null)
				{
					 temp=pd.getProperty().getTemp10();
				}
				str+="<tr><td>"+ct.getField().getTemp10()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp11() != null
					&& !ct.getField().getTemp11().equals("")) {
				if(pd.getProperty().getTemp11()!=null)
				{
					 temp=pd.getProperty().getTemp11();
				}
				str+="<tr><td>"+ct.getField().getTemp11()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp12() != null
					&& !ct.getField().getTemp12().equals("")) {
				if(pd.getProperty().getTemp12()!=null)
				{
					 temp=pd.getProperty().getTemp12();
				}
				str+="<tr><td>"+ct.getField().getTemp12()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp13() != null
					&& !ct.getField().getTemp13().equals("")) {
				if(pd.getProperty().getTemp13()!=null)
				{
					 temp=pd.getProperty().getTemp13();
				}
				str+="<tr><td>"+ct.getField().getTemp13()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp14() != null
					&& !ct.getField().getTemp14().equals("")) {
				if(pd.getProperty().getTemp14()!=null)
				{
					 temp=pd.getProperty().getTemp14();
				}
				str+="<tr><td>"+ct.getField().getTemp14()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp15() != null
					&& !ct.getField().getTemp15().equals("")) {
				if(pd.getProperty().getTemp15()!=null)
				{
					 temp=pd.getProperty().getTemp15();
				}
				str+="<tr><td>"+ct.getField().getTemp15()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp16() != null
					&& !ct.getField().getTemp16().equals("")) {
				if(pd.getProperty().getTemp16()!=null)
				{
					 temp=pd.getProperty().getTemp16();
				}
				str+="<tr><td>"+ct.getField().getTemp16()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp17() != null
					&& !ct.getField().getTemp17().equals("")) {
				if(pd.getProperty().getTemp17()!=null)
				{
					 temp=pd.getProperty().getTemp17();
				}
				str+="<tr><td>"+ct.getField().getTemp17()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp18() != null
					&& !ct.getField().getTemp18().equals("")) {
				if(pd.getProperty().getTemp18()!=null)
				{
					 temp=pd.getProperty().getTemp18();
				}
				str+="<tr><td>"+ct.getField().getTemp18()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp19() != null
					&& !ct.getField().getTemp19().equals("")) {
				if(pd.getProperty().getTemp19()!=null)
				{
					 temp=pd.getProperty().getTemp19();
				}
				str+="<tr><td>"+ct.getField().getTemp19()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp20() != null
					&& !ct.getField().getTemp20().equals("")) {
				if(pd.getProperty().getTemp20()!=null)
				{
					 temp=pd.getProperty().getTemp20();
				}
				str+="<tr><td>"+ct.getField().getTemp20()+"</td><td>"+temp+"</td></tr>";
			}
			
		}
		
		System.out.println(str);
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(str);
	}
	/**
	 * 下架弹窗的详细信息
	 * @throws IOException 
	 */
	public void selectinfo() throws IOException
	{
		String id=request.getParameter("id");
		String server=request.getParameter("mark");
		System.out.println(id);
		System.out.println(server);
		String hql="from Product where delflag=0 and id="+Integer.parseInt(id)+"";
		List<Product> product=obb.selectInfo(hql);
		String str="<tr><td colspan='4' align='right' height='30'><input  type='button' id='close' name='close' onclick='closeInfo()' value='关闭' /></td></tr>";
		 str+="<tr><td colspan='4' align='center' height='50'>商品详细信息</td></tr>";
		if(product.size()>0)
		{
		
			Product pd=product.get(0);
			System.out.println(pd.getProperty().getModel().getCommodityTpye().getId());
			String hql1="from CommodityTpye where del='0' and  id="+pd.getProperty().getModel().getCommodityTpye().getId()+"";
			CommodityTpye ct=(CommodityTpye)obb.selectInfo(hql1).get(0);
			str +="<tr><td>商品名称:</td><td>"+pd.getProperty().getName()+"</td><td>商品类型:</td><td>"+pd.getProperty().getModel().getCommodityTpye().getTypeName()+"</td></tr>";
			str +="<tr><td>商品型号:</td><td>"+pd.getProperty().getModel().getName()+"</td><td>商品建立时间:</td><td>"+pd.getProperty().getTime()+"</td></tr>";
			
			String temp="";
			if (ct.getField().getTemp1() != null
					&& !ct.getField().getTemp1().equals("")) {
				if(pd.getProperty().getTemp1()!=null)
				{
					 temp=pd.getProperty().getTemp1();
				}
				str+="<tr><td>"+ct.getField().getTemp1()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp2() != null
					&& !ct.getField().getTemp2().equals("")) {
				if(pd.getProperty().getTemp2()!=null)
				{
					 temp=pd.getProperty().getTemp2();
				}
				str+="<tr><td>"+ct.getField().getTemp2()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp3() != null
					&& !ct.getField().getTemp3().equals("")) {
				if(pd.getProperty().getTemp3()!=null)
				{
					 temp=pd.getProperty().getTemp3();
				}
				str+="<tr><td>"+ct.getField().getTemp3()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp4() != null
					&& !ct.getField().getTemp4().equals("")) {
				if(pd.getProperty().getTemp4()!=null)
				{
					 temp=pd.getProperty().getTemp4();
				}
				str+="<tr><td>"+ct.getField().getTemp4()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp5() != null
					&& !ct.getField().getTemp5().equals("")) {
				if(pd.getProperty().getTemp5()!=null)
				{
					 temp=pd.getProperty().getTemp5();
				}
				str+="<tr><td>"+ct.getField().getTemp5()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp6() != null
					&& !ct.getField().getTemp6().equals("")) {
				if(pd.getProperty().getTemp6()!=null)
				{
					 temp=pd.getProperty().getTemp6();
				}
				str+="<tr><td>"+ct.getField().getTemp6()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp7() != null
					&& !ct.getField().getTemp7().equals("")) {
				if(pd.getProperty().getTemp7()!=null)
				{
					 temp=pd.getProperty().getTemp7();
				}
				str+="<tr><td>"+ct.getField().getTemp7()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp8() != null
					&& !ct.getField().getTemp8().equals("")) {
				if(pd.getProperty().getTemp8()!=null)
				{
					 temp=pd.getProperty().getTemp8();
				}
				str+="<tr><td>"+ct.getField().getTemp8()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp9() != null
					&& !ct.getField().getTemp9().equals("")) {
				if(pd.getProperty().getTemp9()!=null)
				{
					 temp=pd.getProperty().getTemp9();
				}
				str+="<tr><td>"+ct.getField().getTemp9()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp10() != null
					&& !ct.getField().getTemp10().equals("")) {
				if(pd.getProperty().getTemp10()!=null)
				{
					 temp=pd.getProperty().getTemp10();
				}
				str+="<tr><td>"+ct.getField().getTemp10()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp11() != null
					&& !ct.getField().getTemp11().equals("")) {
				if(pd.getProperty().getTemp11()!=null)
				{
					 temp=pd.getProperty().getTemp11();
				}
				str+="<tr><td>"+ct.getField().getTemp11()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp12() != null
					&& !ct.getField().getTemp12().equals("")) {
				if(pd.getProperty().getTemp12()!=null)
				{
					 temp=pd.getProperty().getTemp12();
				}
				str+="<tr><td>"+ct.getField().getTemp12()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp13() != null
					&& !ct.getField().getTemp13().equals("")) {
				if(pd.getProperty().getTemp13()!=null)
				{
					 temp=pd.getProperty().getTemp13();
				}
				str+="<tr><td>"+ct.getField().getTemp13()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp14() != null
					&& !ct.getField().getTemp14().equals("")) {
				if(pd.getProperty().getTemp14()!=null)
				{
					 temp=pd.getProperty().getTemp14();
				}
				str+="<tr><td>"+ct.getField().getTemp14()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp15() != null
					&& !ct.getField().getTemp15().equals("")) {
				if(pd.getProperty().getTemp15()!=null)
				{
					 temp=pd.getProperty().getTemp15();
				}
				str+="<tr><td>"+ct.getField().getTemp15()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp16() != null
					&& !ct.getField().getTemp16().equals("")) {
				if(pd.getProperty().getTemp16()!=null)
				{
					 temp=pd.getProperty().getTemp16();
				}
				str+="<tr><td>"+ct.getField().getTemp16()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp17() != null
					&& !ct.getField().getTemp17().equals("")) {
				if(pd.getProperty().getTemp17()!=null)
				{
					 temp=pd.getProperty().getTemp17();
				}
				str+="<tr><td>"+ct.getField().getTemp17()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp18() != null
					&& !ct.getField().getTemp18().equals("")) {
				if(pd.getProperty().getTemp18()!=null)
				{
					 temp=pd.getProperty().getTemp18();
				}
				str+="<tr><td>"+ct.getField().getTemp18()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp19() != null
					&& !ct.getField().getTemp19().equals("")) {
				if(pd.getProperty().getTemp19()!=null)
				{
					 temp=pd.getProperty().getTemp19();
				}
				str+="<tr><td>"+ct.getField().getTemp19()+"</td><td>"+temp+"</td></tr>";
			}
			if (ct.getField().getTemp20() != null
					&& !ct.getField().getTemp20().equals("")) {
				if(pd.getProperty().getTemp20()!=null)
				{
					 temp=pd.getProperty().getTemp20();
				}
				str+="<tr><td>"+ct.getField().getTemp20()+"</td><td>"+temp+"</td></tr>";
			}
			
		}
		str+="";
		System.out.println(str);
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(str);
	}
	
	
	/**
	 * 添加出库单
	 * @return
	 */
	public String add()
	{	boolean flag=true;
	try
	{
		
		if(request.getParameter("newadd")!=null || request.getParameter("newadd")!="" ){
		 String CKBum=request.getParameter("CKBum");//出库单号
		 String cktime=(String)request.getParameter("cksj");//出库时间
		 String depid=request.getParameter("depid");//仓库位置
		 String cklx=request.getParameter("cklx");//出库类型
		 String cksl=request.getParameter("cksl");//出库数量
		 String ckzj=request.getParameter("ckzj");//出库价格
		 String bz=request.getParameter("bz")!=null?request.getParameter("bz"):"";//出库价格
		 String plist=request.getParameter("productlist");//商品列表
		 String[] list=plist.split(",");
		 DateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		 format.setLenient(false);  //要转换字符串 str_test  String str_test ="2011-04-24";  
		  
	     Timestamp ts = new Timestamp(format.parse(cktime).getTime());   
		 System.out.println(ts.toString()); 
		 Employee employee=(Employee)request.getSession().getAttribute("emp");
		 String sql="from Depot where id="+Integer.parseInt(depid);
		 List depotlist=customerBussiness.exHql(sql);
		 Depot depot=(Depot)depotlist.get(0);
		 AllType at=new AllType();
		 String  atsql="from AllType where id="+Integer.parseInt(cklx);
		 List    alltlist=customerBussiness.exHql(atsql);
		 at=(AllType)alltlist.get(0);
		 Outbound ob=new Outbound();
		 ob.setDelflag("0");
		 ob.setEmployee(employee);
		 ob.setDepot(depot);
		 ob.setTime(cktime);
		 ob.setAllType(at);
		 ob.setOutboundNo(CKBum);
		 ob.setAuditingState(0);
		 obb.addOutBound(ob);
		 outbound=ob;
		 for (int i = 0; i < list.length; i++) {
				
				
			 String prostl="FROM Product where id="+Integer.parseInt(list[i]);
			 List    prostllist=customerBussiness.exHql(prostl);
			 Product product =new Product();
			 product=(Product)prostllist.get(0);
			 int pId = Integer.parseInt(list[i]);
				String hqlProduct = "update Product set usestate = 4 where id = " + pId; 
				audBussiness.updatehql(hqlProduct);
			 OutboundInfo oinfo=new OutboundInfo();
			 oinfo.setOutbound(ob);
			 oinfo.setProduct(product);
			 obb.addOutInfo(oinfo);
			 
				}
		 String[] strProId =list;
			for(int i=0;i<strProId.length;i++)
			{
				//Product pro=new Product();
				
			}
			
		/************************************14015*******************************/
			if(flag){
				int marker=audBussiness.addAuditingOrder("CK",outbound.getOutboundNo(),"Outbound",ck.getCookie(request, "filialemark"));
				System.out.println("marker:"+marker);
				if(marker==0)
					response.getWriter().print("0");
				else if(marker==2)
					response.getWriter().print("2");
				else
					response.getWriter().print("1");
			}
			else
				response.getWriter().print("1");
		}
	
		else{
		 
		 flag=addAndedit("add");
		/****************14015修改  改变添加出库单时出库商品的状态   4为出库未审核**********/
				String[] strProId = proId.split(",");
				for(int i=0;i<strProId.length;i++)
				{
					//Product pro=new Product();
					int pId = Integer.parseInt(strProId[i]);
					String hqlProduct = "update Product set usestate = 4 where id = " + pId; 
					audBussiness.updatehql(hqlProduct);
				}
			/************************************14015*******************************/
				if(flag){
					int marker=audBussiness.addAuditingOrder("CK",outbound.getOutboundNo(),"Outbound",ck.getCookie(request, "filialemark"));
					System.out.println("marker:"+marker);
					if(marker==0)
						response.getWriter().print("0");
					else if(marker==2)
						response.getWriter().print("2");
					else
						response.getWriter().print("1");
				}
				else
					response.getWriter().print("1");
			}
	}
			catch(Exception ex)
			{
				logger.error("添加出库单时出错",ex);
				ex.printStackTrace();
			}
		
		return  "delckd";
	}
	
	/**
	 * 添加或修改出库单
	 * @param addOredit
	 * @return
	 */
	public boolean addAndedit(String addOredit)
	{
		try {
			outbound.setRemark(URLDecoder.decode(outbound.getRemark(),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		boolean flag=false;
		if(addOredit.equals("add"))
		{
			Outbound ob = obb.addReturnOutBound(outbound);
			if(null != ob){
				flag = true;
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个出库单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(ob.getId().toString());
					executerecord.setEntityName("Outbound");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
			}else{
				flag = false;
			}
		}
		else
		{
			flag=obb.editOutBound(outbound);
			String cid=request.getParameter("id");
			if(cid!=null)
			{
				obb.delOutInfo(" and outboundId="+cid);
				System.out.println("删除了");
			}
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个出库单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(outbound.getId().toString());
				executerecord.setEntityName("Outbound");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
		}
		System.out.println(434334);
		boolean flag2=false;
		if(flag)
		{
			System.out.println("进入Info");
			String[] proIds=proId.split(",");

			for(int i=0;i<proIds.length;i++)
			{
				System.out.println("进入循环");
				OutboundInfo outinfo=new OutboundInfo();
				Product pro=new Product();
				pro.setId(Integer.parseInt(proIds[i]));
				outinfo.setProduct(pro);
				outinfo.setOutbound(outbound);
				flag2=obb.addOutInfo(outinfo);
				System.out.println("info:"+flag2);
			}
		}
		if(flag&&flag2)
			return true;
		return false;
	}
	
	/**
	 * 出库更新显示
	 * 
	 */
	public String updateShow()
	{
		String id=request.getParameter("cid");
		//根据Id查找出库单
		Outbound outb=(Outbound) obb.someOutBound(" and id="+id).get(0);
		System.out.println("OutBound--ere"+outb);
		request.setAttribute("oneOutBound", outb);
		
		List typeList=obb.selType("");
		request.setAttribute("typeList", typeList);
		return "add";
	}
	
	public String delInfo()
	{
		String infoId=request.getParameter("infoId");
		if(infoId!=null)
		{
			String addhql=" and id="+Integer.parseInt(infoId);
			boolean flag=obb.delOutInfo(" and id="+infoId);
			System.out.println("flag"+flag);
			try
			{
				if(flag)
					response.getWriter().print("0");
				else
					response.getWriter().print("1");
			}
			catch(Exception ex)
			{
				logger.error("删除出库详细时出错",ex);
				ex.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 修改出库单
	 * @return
	 */
	public String edit()
	{
		System.out.println("edit");
		boolean flag=this.addAndedit("edit");
		try
		{
			if(flag){
				response.getWriter().write("0");
			}
			else{
				response.getWriter().write("1");
			}
		}
		catch(Exception ex)
		{
			logger.error("修改出库单时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 删除出库单
	 * @return
	 */
	public String del()
	{
		System.out.println("delete");
		boolean flag=obb.delOutBound(ids);
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
					executerecord.setContent("删除了一些出库单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Outbound");
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
			logger.error("出库单删除时错误！",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 审核成功后执行的事件
	 * @return
	 */
	public String auditingPass()
	{
		boolean flag=false;
		String orderNo=request.getParameter("orderNo");
		try
		{
			flag=obb.auditingPass(orderNo);
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			try {
				response.getWriter().print("1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 报损出库
	 */
     public String shatter()
     {
    	 return "shatter"; 
     }
        
     /**
      * 盘亏出库
      */
	 public String shortage()
	 {
		 return"shortage";
	 }
	 
	 /**
	  * 服务器上架出库
	  */
	 public String topcarriage()
	 {
		 return "topcarriage";
	 }

	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}

	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response=response;
	}
	
	/**
	 * 添加上/下架单中的，服务器IP
	 * */
	public void findIp()
	{
		try{
			String serverid=request.getParameter("serverid");//服务器id
			String mark=request.getParameter("mark");///是上架还是下架
			//usestate使用状态（1.使用2.未使用3.已实际出库4.上架）  ip只分为使用和未使用，初始化时为2，上架用了为1
			//根据使用状态，判断是上架还是下架
			String iphql="";
			if("4".equals(mark))
			{	// mark=4  即为已经上架     下架单就是要这个
				iphql=" from Product where parentId="+serverid+" and deflag=0 and usestate=1";
			}else{
				iphql=" from Product where parentId="+serverid+" and deflag=0 and usestate=2";
			}
			List<Product> iplist=productBussiness.getProductList(iphql);
			if(iplist!=null)
			{
				System.out.println(iplist.size());
				for(Product p:iplist)
				{
					System.out.println(p.getProperty().getTemp1());
				}
				response.getWriter().print(iplist);
			}
			else
				System.out.println("ip是个空的");
		}catch(Exception e){
			System.out.println("ip报错了");
			e.printStackTrace();
		}
	}
	/**
	 * 添加上/下架单中的，服务器所在机房的查询
	 * */
	public void findServiceLocation()
	{
		
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		try{
			String parentid=request.getParameter("parentid");//服务器parentid
			String serverid=request.getParameter("serverid");//服务器id
			String mark=request.getParameter("mark");///是上架还是下架  usestate
			
			StringBuffer restr=new StringBuffer();
			
			//取得服务器对象
			System.out.println("添加上/下架单中的，取得服务器对象");
			System.out.println("parentid *********"+parentid+"\nserverid*********"+serverid+"\nmark*********"+mark);
			String lohql="  from  Product where id="+parentid;
			List<Product> servicelist=productBussiness.getProductList(lohql);
			if(servicelist!=null&&servicelist.size()!=0)
			{
				System.out.println("这不是空的"+servicelist.size());
				Product servicelocation=(Product)servicelist.get(0);
				System.out.println("取得服务器对象地址是:   "+servicelocation.getProperty().getName());
				System.out.println(servicelocation.getTmp1());
				System.out.println("id "+servicelocation.getId());
				System.out.println("barcode :"+servicelocation.getBarcode());
				restr.append(servicelocation.getProperty().getName()+"#");
				
			}
			else{
				restr.append("请填写地址#");
				System.out.println("噢，这是空的。。。");
			}
			
			
			//usestate使用状态（1.使用2.未使用3.已实际出库4.上架）  ip只分为使用和未使用，初始化时为2，上架用了为1
			//根据使用状态，判断是上架还是下架
			
			String hqll="from UpServer where product.id="+serverid+" and upFlag=1 and  delflag=0";
			List<UpServer> upServer=productBussiness.selectList(hqll);
			for(int i=0;i<upServer.size();i++)
			{
				String[] serverIp=(upServer.get(i).getServerIp()).split("，");
				for(int j=0;j<serverIp.length;j++)
				{
					restr.append(upServer.get(i).getProduct().getId()+","+serverIp[j]+";");
				}
			}
			String rst="";
			if(restr!=null&&restr.length()>=1)
				rst=restr.toString().substring(0, restr.length()-1);
			System.out.println(rst);
			response.getWriter().print(rst);
		}catch(Exception e){
			System.out.println("服务器报错了");
			e.printStackTrace();
		}
	}
	
}
