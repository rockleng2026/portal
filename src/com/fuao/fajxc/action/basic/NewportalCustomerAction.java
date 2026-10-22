package com.fuao.fajxc.action.basic;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.helpers.DateTimeDateFormat;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.CustomerMoveBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.message.MessagetypeBussiness;
import com.fuao.fajxc.bussiness.system.UploadBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.IntentFollowUp;
import com.fuao.fajxc.vo.Messagetype;
import com.fuao.fajxc.vo.Sale_orders;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 新系统3.0版本    客户action
 * @付飞翔 14031 修改
 *
 */
public class NewportalCustomerAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private CustomerBussiness customerBussiness;
		private MessagetypeBussiness messagetypeBussiness;
	   private boolean ok;
	   private List<File> filedata;
	   private List<String> sczjmc;
	   private List<String> FiledataFileName;
	   private List<String> FiledataContentType;
	   private String name;
	   private DepartmentAction deptaction;
	   private String delnr;
	   private String custidcard;
	   public String getCustidcard() {
		return custidcard;
	}
	public void setCustidcard(String custidcard) {
		this.custidcard = custidcard;
	}

	private UploadBussiness upbiz;
		public boolean isOk() {
		return ok;
	    }
        	public void setOk(boolean ok) {
		this.ok = ok;
	    }  

		public MessagetypeBussiness getMessagetypeBussiness() {
			return messagetypeBussiness;
		}

		public void setMessagetypeBussiness(MessagetypeBussiness messagetypeBussiness) {
			this.messagetypeBussiness = messagetypeBussiness;
		}

		private HttpServletRequest request;
		private HttpServletResponse response;
		private Customer customer;
		private CustomerMoveBussiness customerMoveBussiness;
		//记录动态类
		private ExecuteRecordBussiness executeRecordBussiness;
		private String customerName;//客户姓名
		private String customertype;
		private String customertype2;
		private String cardid;
		private String mobilePhone;
		private String qq;
		private String email;
		private String customerCompany;
		private String businessLicense;
		private String companyScale;
		private String companyphone;
		private String companyadress;
		private String employeeName;
		private String customerExplain;
		private String date;
		private String customerfj;
		private String phone;
		
		public String getCustomertype2() {
			return customertype2;
		}
		public void setCustomertype2(String customertype2) {
			this.customertype2 = customertype2;
		}
		public String getCustomerName() {
			return customerName;
		}
		public void setCustomerName(String customerName) {
			this.customerName = customerName;
		}
		public String getCustomertype() {
			return customertype;
		}
		public void setCustomertype(String customertype) {
			this.customertype = customertype;
		}
		public String getCardid() {
			return cardid;
		}
		public void setCardid(String cardid) {
			this.cardid = cardid;
		}
		public String getMobilePhone() {
			return mobilePhone;
		}
		public void setMobilePhone(String mobilePhone) {
			this.mobilePhone = mobilePhone;
		}
		public String getQq() {
			return qq;
		}
		public void setQq(String qq) {
			this.qq = qq;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getCustomerCompany() {
			return customerCompany;
		}
		public void setCustomerCompany(String customerCompany) {
			this.customerCompany = customerCompany;
		}
		public String getBusinessLicense() {
			return businessLicense;
		}
		public void setBusinessLicense(String businessLicense) {
			this.businessLicense = businessLicense;
		}
		public String getCompanyScale() {
			return companyScale;
		}
		public void setCompanyScale(String companyScale) {
			this.companyScale = companyScale;
		}
		public String getCompanyphone() {
			return companyphone;
		}
		public void setCompanyphone(String companyphone) {
			this.companyphone = companyphone;
		}
		public String getCompanyadress() {
			return companyadress;
		}
		public void setCompanyadress(String companyadress) {
			this.companyadress = companyadress;
		}
		public String getEmployeeName() {
			return employeeName;
		}
		public void setEmployeeName(String employeeName) {
			this.employeeName = employeeName;
		}
		public String getCustomerExplain() {
			return customerExplain;
		}
		public void setCustomerExplain(String customerExplain) {
			this.customerExplain = customerExplain;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public String getCustomerfj() {
			return customerfj;
		}
		public void setCustomerfj(String customerfj) {
			this.customerfj = customerfj;
		}
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public ExecuteRecordBussiness getExecuteRecordBussiness() {
			return executeRecordBussiness;
		}

		public void setExecuteRecordBussiness(
				ExecuteRecordBussiness executeRecordBussiness) {
			this.executeRecordBussiness = executeRecordBussiness;
		}

		Cookies ck = new Cookies();
		public CustomerBussiness getCustomerBussiness() {
			return customerBussiness;
		}

		public void setCustomerBussiness(CustomerBussiness customerBussiness) {
			this.customerBussiness = customerBussiness;
		}

		public Object getModel() {
			customer =new Customer();
			return customer;
		}
		
		/**
		 * 得到request
		 */
		public void setServletRequest(HttpServletRequest arg0) {
			this.request=arg0;
			
		}
		
		/**
		 * 得到response
		 */
		public void setServletResponse(HttpServletResponse arg0) {
			this.response=arg0;
			
		}
		/*
		 * 客户删除附件
		 * 
		 * 
		 */
		
		public void delfj(){
		String sql="select customerfj From Customer where customerId="+custidcard; //客户id
		
		List<String> l2=  customerBussiness.exhql(sql);
		String l3="";
		for (int i = 0; i < l2.size(); i++) {
			l3=l2.get(0);
		}
		String [] fjlist=l3.split(",");
		String  fj="";
		for (int i = 0; i < fjlist.length; i++) {
			if(fjlist[i]!="" && fjlist[i]!=null){
			if(delnr.equals(fjlist[i])){
				
			}else{
				if(i!=fjlist.length-1){
				fj=fj+fjlist[i]+",";
				}else{
					fj=fj+fjlist[i];
				}
			}
			}
		}
		String hql="update customer set customerfj='"+fj+"' where customer_id="+custidcard;
		customerBussiness.sqlupdate(hql);
		request.getSession().removeAttribute("sczj");
			try {
				response.getWriter().print(1);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/**
		 * 新曾客户身份证是否唯一
		 */
		
		 public void 	chackemail(){
			  String sql="from Customer where email='"+custidcard+"' and del <>1";
			  
			List l2=  customerBussiness.exhql(sql);
			if(l2.size()>0)
			{
				try {
					response.getWriter().print("1");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else
			{
				try {
					response.getWriter().print("0");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		  }
			
	  public void 	chackidcard(){
		  String sql="from Customer where cardid='"+custidcard+"' and del <>1";
		  
		List l2=  customerBussiness.exhql(sql);
		if(l2.size()>0)
		{
			try {
				response.getWriter().print("1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else
		{
			try {
				response.getWriter().print("0");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	  }
		
		/*
		 * 添加意向客户信息对象
		 */
		public String add(){
			try {				
				customer.setIsLoginAccount(0);
				customer.setDel("0");
				customer.setAuthorization("fuaotech");
				customer.setDate(TimePattern.doTimeDf3(new Date()));
				Customer cus = customerBussiness.addCustomer(customer);
				
				/*  添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个客户信息。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(cus.getCustomerId().toString());
					executerecord.setEntityName("Customer");
					
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
			 return	"select";
		}
		
		
		
		/*
		 * 删除客户信息对象
		 */
		public void del(){
			try {
				
				String id=request.getParameter("id");
				Customer data=customerBussiness.getCustomerdata(id);
				data.setDel("1");
				customerBussiness.updateData(data);
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个客户信息。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("Customer");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print(1);
			} catch (Exception e) {
				try {
					response.getWriter().print(0);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		
		/*
		 * 更改客户信息对象
		 */
		public String update(){
			try {
				String customerId=request.getParameter("customerId");//客户主键编号
				Customer cu=customerBussiness.getCustomerdata(customer.getCustomerId().toString());
				cu.setRealName(customer.getRealName());
				cu.setCustomerType(customer.getCustomerType());
				cu.setCustomerType2(customer.getCustomerType2());
				cu.setEmployee(customer.getEmployee());
				cu.setCardid(customer.getCardid());
				cu.setCustomerCompany(customer.getCustomerCompany());
				cu.setCustomerAddress(customer.getCustomerAddress());
				cu.setPhone(customer.getPhone());
				cu.setMobilePhone(customer.getMobilePhone());
				cu.setEmail(customer.getEmail());
				cu.setZipCode(customer.getZipCode());
				cu.setDate(customer.getDate());
				cu.setFacsimile(customer.getFacsimile());
				cu.setQq(customer.getQq());
				customerBussiness.updateData(cu);
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个客户信息。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(customer.getCustomerId().toString());
					executerecord.setEntityName("Customer");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
			} catch (Exception e) {
				e.printStackTrace(); 
			}
			return "select";
		}
		
		/*
		 * 根据条件进行筛选查询客户信息
		 */
		public String getpage() throws IOException{
			
			String marker2=request.getParameter("marker");
			String taskid=request.getParameter("taskid");
			String id = request.getParameter("id");
			
			request.setAttribute("marker", marker2);
			request.setAttribute("taskid", taskid);
			
			
			Employee emp = (Employee)request.getSession().getAttribute("emp");
			if(null == emp){
				request.setAttribute("errorMsg", "由于您长时间未活动  请从新登录");
				return "login";
			}
			//定义hql语句
//			String hql = "from Customer where 1=1 and customer_type2=3";
			String hql = "from Customer where 1=1 ";
			
			if(id!=null && !id.equals("")){
				int sid = Integer.parseInt(id);
				hql += " and customerId="+sid;
			}
			
			System.out.println("old hql is:"+hql);
			System.out.println("客户类型是:"+request.getParameter("customerType2"));
			
			
			/****分字段全局查找****/
			if(null != customer.getCustomerId()){
				hql +=" and customerId like '%" + customer.getCustomerId() + "%' ";
			}
			if(null != customer.getRealName() && !"".equals(customer.getRealName())){
				hql +=" and realName like '%" + URLDecoder.decode(customer.getRealName(),"UTF-8") + "%' ";
			}
			if(null != customer.getCustomerType() && !"".equals(customer.getCustomerType())){
				hql +=" and customerType like '%" + URLDecoder.decode(customer.getCustomerType(),"UTF-8") + "%' ";
			}
			if(null != customer.getEmployee() && null != customer.getEmployee().getName() && !"".equals(customer.getEmployee().getName())){
				hql +=" and employee.name like '%" + URLDecoder.decode(customer.getEmployee().getName(),"UTF-8") + "%' ";
			}
			if(null != customer.getPhone() && !"".equals(customer.getPhone())){
				hql +=" and phone like '%" + URLDecoder.decode(customer.getPhone(),"UTF-8") + "%' ";
			}
			if(null != customer.getCustomerCompany() && !"".equals(customer.getCustomerCompany())){
				hql +=" and customerCompany like '%" + URLDecoder.decode(customer.getCustomerCompany(),"UTF-8") + "%' ";
			}
			//筛选条件:根据客户类型(意向客户、试用客户、正式客户、审核客户)
			if(null !=customer.getCustomerType2() && !"".equals(customer.getCustomerType2())){
				hql +=" and customerType2="+request.getParameter("customerType2");
			}
			/****分字段全局查找end******/
			
			//权限管理
			String sonIds = customerBussiness.executeSql("select getChildDeptLst("+emp.getDepartment().getId()+")");
			Map map = (Map)ActionContext.getContext().get("map");
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			hql += " and del!='1' and (employee.id = "+emp.getId()+" or(employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
			" and employee.department.id in ("+sonIds+")))";
			hql+="order by id desc";
			
			System.out.println("hql is ::::::::::::::::::::::::::::"+hql);
			//执行分页查询
			Pages pages=customerBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 25, null);
			
			/******************字段的ajax查询***************/
			if(null != request.getParameter("tage") && request.getParameter("tage").equals("y")){
				PropertyEditor property = new PropertyEditor();
				String strr="";
				String str="";
				if(null != pages.getPageList() && pages.getPageList().size()>0){
				for(int i=0; i<pages.getPageList().size(); i++){
					Customer customer = new Customer();
					customer = (Customer)pages.getPageList().get(i);
					System.out.println("//////////////////"+customer.getCustomerType2());
					str = property.getID("selectcustomer").toString();
				    str = str.replace("#customerId#", customer.getCustomerId().toString());
					str = str.replace("#realName#", customer.getRealName());
					str = str.replace("#customerType#", customer.getCustomerType());
					//ytl 新增修改(按客户类型查询)
					str = str.replace("#customerType2#", customer.getCustomerType2());
					
					str = str.replace("#employee.name#", customer.getEmployee().getName());
					str = str.replace("#phone#", customer.getPhone());
					str = str.replace("#qq#", customer.getQq());
					str = str.replace("#customerCompany#", customer.getCustomerCompany());
					strr +=str;		
				}
				pages.setUrl("getpageCustomer.do?type2=1");
					strr+="#"+pages.getHtml("selectcustomer");
				}
				   response.setCharacterEncoding("utf-8");
				   response.getWriter().print(strr);
				   System.out.println(strr);
				   System.out.println(">>>>>>>>>>>>>>>>3"+hql);
				   return null;
			}
			
			request.setAttribute("pages", pages);
			request.getSession().setAttribute("option", map);
			
			//改变消息提醒状态
			String mark1=request.getParameter("mark1");
			if(mark1!=null){
				String hql3="update Sendmessage set state=1 where sendtable='Customer'";
				int ii=customerBussiness.updateConkout(hql3);
				System.out.println("iii:::"+ii);
			}
			return "newportallistCustomer";
		}
		/*
		 * 添加客户信息--新portal系统
		 */
		
		public String newportaladd(){
			try {
			    Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				Customer cu=new Customer();
				//String customertype2="";
				String customertype=request.getParameter("customertype");
				//customertype2=request.getParameter("customertype2");
				String cardid=request.getParameter("cardid");
				String mobilePhone=request.getParameter("mobilePhone");
				String qq=request.getParameter("qq");
				String email=request.getParameter("email");
				String date=request.getParameter("date");
			
				
					String customerName=request.getParameter("customerName");
					String customerCompany=request.getParameter("customerCompany");
					String businessLicense=request.getParameter("businessLicense");
					String companyScale=request.getParameter("companyScale");
					String companyphone=request.getParameter("companyphone");
					String companyadress=request.getParameter("companyadress");
					String customerExplain=request.getParameter("customerExplain");
					String customerfj=request.getParameter("customerfj");
			
				String phone=request.getParameter("phone");
				String empid="";
				empid=request.getParameter("empid");
				Map txt=(Map)request.getSession().getAttribute("sczj")!=null?(Map)request.getSession().getAttribute("sczj"):null;
				if(txt!=null){
				String sfza=(String)txt.get("身份证A");
				String sfzb=(String)txt.get("身份证B");
				String yyzz=(String)txt.get("营业执照");
				String fj="";
				if(sfza!="" && sfza!=null ){
				 fj=sfza+",";
				}
				if(sfzb!="" && sfzb!=null ){
					 fj=fj+sfzb+",";
					}
				if(yyzz!="" && yyzz!=null ){ 
						 fj=fj+yyzz;
			}
				
				cu.setCustomerfj(fj);
		}
				cu.setRealName(customerName);
				cu.setCardid(cardid);
				cu.setMobilePhone(mobilePhone);
				cu.setCustomerCompany(customerCompany);
				cu.setPhone(phone);
				cu.setQq(qq);
				cu.setDel("0");
				cu.setEmail(email);
				cu.setCustomerName(customerName);
				cu.setLicense(businessLicense);
				cu.setCompanyScale(companyScale);
				cu.setCompanyphone(companyphone);
				cu.setCompanyadress(companyadress);
				cu.setEmployee(loginEmp);
				cu.setDate(date);
				cu.setCustomerexplain(customerExplain);
				if(customertype==""||customertype==null){
					cu.setCustomerType2("3");
				}else{
					cu.setCustomerType2(customertype);
				}
				if(empid!=""&&empid!=null){
					int emmployeeid=Integer.parseInt(empid);
					String hql="From Employee where id="+emmployeeid;
					List emplist=customerBussiness.exHql(hql);
					Employee employee=(Employee)emplist.get(0);
					cu.setEmployee(employee);
				}else{
					cu.setEmployee(loginEmp);
				}
				customerBussiness.addCustomer(cu);
				} catch (Exception e) {
					e.printStackTrace();
				}
				request.getSession().removeAttribute("sczj");
				//customerBussiness.addData(cu);
				/*付飞翔 14031   添加记录动态信息*/
				//拿到登陆员工用户
				//添加记录到动态记录表
				if(customertype.equals("1")){
					request.setAttribute("kflx", "1");
					
				}else{
					request.setAttribute("kflx", "3");
				}
				
			return mycustomerlist();
		}
		/**
		 *  查询部门客户信息
		 * @return
		 */
		 
		private static  StringBuffer x;
		 public StringBuffer selemp(String deptid){
				
			 x.append(deptid);
			 x.append(",");
			 int dept=Integer.parseInt(deptid);
			 String hql="select id FROM Department where  parentId="+dept;
			 List dlist = customerBussiness.exHql(hql);
			 String a="";
			 
			 int y=dlist.size();
			 System.out.println(y);
			 if(y>0){
				
			 for (int i = 0; i < dlist.size(); i++) {
				Object o=dlist.get(i);
				a=o.toString();
				x.append(a);
				x.append(",");
				System.out.println(a);
				 if(dlist.size()>0){
					 selemp(a);
					 System.out.println(x);
				 }
			 }}
			 System.out.println(x);
			
				return x;
			 
			 	
			 }
		public String  deptcustomerlist(){
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Employee Emp = (Employee) request.getSession().getAttribute("emp");
			int ids=Emp.getDepartment().getId();
			int zw=0;
			 x=new StringBuffer();
			
			 StringBuffer sb=selemp(String.valueOf(ids));
			String sb1=sb.toString();
			if(Emp.getWorkposition()!=null){
			zw=Emp.getWorkposition().getIspersonman();
			}
			if(zw==1){
				
				request.setAttribute("bmqx", 1);
			}else{
				
				request.setAttribute("bmqx", 2);
			}
			String sql1="select id From Employee where department.id in("+sb1+"-1)";
			List list11=customerBussiness.exHql(sql1);
			List<Integer> l2=list11;
			String str="";
			for (int i = 0; i < l2.size(); i++) {
			
					if(l2.size()-1==i){
						str=str+l2.get(i).toString();
					}else{
						
						str=str+l2.get(i).toString()+",";
					}
				
			}
			
			String hql="From Customer where employee.id in ("+str + ") and del<>1 ";
			String company="";
			String name="";
			String customertype="3";
			company=request.getParameter("company");
			name=request.getParameter("name");
			if(request.getAttribute("kflx")!=null){
				String khlx=(String)request.getAttribute("kflx");
				   if(khlx.equals("1")){
					   customertype="1";
				   }
			}
			else{
			String s=(String)request.getSession().getAttribute("customerType2");
			
			customertype=request.getParameter("customerType2")!=null?request.getParameter("customerType2"):s;
			}
			if(customertype==null){
				
				customertype="3";
			}
				if(name!=""&&name!=null){
					hql+=" and realName like "+"'%"+name+"%'";
				}else{
					hql+="";
				}
				if(company!=""&&company!=null){
					hql+=" and customer_company like "+"'%"+company+"%'";
				}else{
					hql+="";
				}
				if(customertype!=""&&customertype!=null){
					hql+=" and customer_type2="+"'"+customertype+"'";
				}else{
					
				}
				hql=hql+" order by customerId desc";
			int  	pageNo=1;
			
			pageNo=request.getParameter("pageNo")!=null?Integer.parseInt(request.getParameter("pageNo")):1;
			if(pageNo<1){
				
				pageNo=1;
			}
			
			String sql="from IntentFollowUp  order by date desc ";
		    List list=customerBussiness.exhql(sql);
		    List<IntentFollowUp> list1=list;
		    request.setAttribute("list1", list1);
			int  pageSize=13;
			
			Pages pg= executeRecordBussiness.exHqlPages(hql, pageNo, pageSize, null );
			List solistList = pg.getPageList();
			int  allline=pg.getAllCount();//总行数
			int gageNoall = allline / 13;// 总页数
	
			if (allline % 13 != 0) {
				gageNoall = gageNoall + 1;
			}
			List<Customer> newcustomerlist = solistList;
			request.setAttribute("newcustomerlist1", newcustomerlist);
			request.setAttribute("customertype", customertype);
			request.setAttribute("allline", allline);
			request.setAttribute("gageNoall", gageNoall);
			request.setAttribute("pageNo", pageNo);

			
			
			return "deptcustomerlist";
		}
		/*
		 * 查询我的客户信息--新portal系统
		 */
		public String mycustomerlist(){
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String empid=request.getParameter("empid")!=null?request.getParameter("empid"):"";
			Employee Emp = (Employee) request.getSession().getAttribute("emp");
			int ids=Emp.getId();
			String hql="";
			if(empid!=""){
				hql="From Customer where vendition="+Integer.parseInt(empid) + " and del<>1 ";
				
				request.setAttribute("empid", empid);
			}else{
				hql="From Customer where vendition="+ids + " and del<>1 ";
			}
			
			String company="";
			String name="";
			String customertype="3";
			company=request.getParameter("company");
			name=request.getParameter("name");
			if(request.getAttribute("kflx")!=null){
				String khlx=(String)request.getAttribute("kflx");
				   if(khlx.equals("1")){
					   customertype="1";
				   }
			}
			else{
			String s=(String)request.getSession().getAttribute("customerType2");
			
			customertype=request.getParameter("customerType2")!=null?request.getParameter("customerType2"):s;
			}
			if(customertype==null){
				
				customertype="3";
			}
				if(name!=""&&name!=null){
					hql+=" and realName like "+"'%"+name+"%'";
				}else{
					hql+="";
				}
				if(company!=""&&company!=null){
					hql+=" and customer_company like "+"'%"+company+"%'";
				}else{
					hql+="";
				}
				if(customertype!=""&&customertype!=null){
					hql+=" and customer_type2="+"'"+customertype+"'";
				}else{
					
				}
				hql=hql+" order by id desc";
			int  	pageNo=1;
			
			pageNo=request.getParameter("pageNo")!=null?Integer.parseInt(request.getParameter("pageNo")):1;
			if(pageNo<1){
				
				pageNo=1;
			}
			
			String sql="from IntentFollowUp  order by date desc ";
		    List list=customerBussiness.exhql(sql);
		    List<IntentFollowUp> list1=list;
		    request.setAttribute("list1", list1);
			int  pageSize=13;
			
			Pages pg= executeRecordBussiness.exHqlPages(hql, pageNo, pageSize, null );
			List solistList = pg.getPageList();
			int  allline=pg.getAllCount();//总行数
			int gageNoall = allline / 13;// 总页数
	
			if (allline % 13 != 0) {
				gageNoall = gageNoall + 1;
			}
			List<Customer> newcustomerlist = solistList;
			request.setAttribute("newcustomerlist", newcustomerlist);
			request.setAttribute("customertype", customertype);
			request.setAttribute("allline", allline);
			request.setAttribute("gageNoall", gageNoall);
			request.setAttribute("pageNo", pageNo);

			return "mycustomerlists";
		}
		/*
		 *查看客户详情---新portal系统 
		 */
		public String seecustomerdetails(){
			Employee emp = (Employee)request.getSession().getAttribute("emp");
			int customertypeid=Integer.parseInt(request.getParameter("customertypeid"));
			String employeeName=emp.getName();
			request.setAttribute("employeeName", employeeName);
			int id=Integer.parseInt(request.getParameter("customerid"));
			String hql="From Customer where customer_id="+id;
			Customer customer=null;
			System.out.println(hql);
			customer =(Customer)executeRecordBussiness.exHql(hql);
			request.setAttribute("customer", customer);
			request.setAttribute("customertypeid",customertypeid);
			if(request.getParameter("dept")!=null){
				return "deptcustomerdes";
			}else{
			return "customerdes";
			}
			
		}
		/*
		 * 添加客户信息时跳转页面---新portal系统
		 */
		public String newportaladdcustomer(){
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Employee emp = (Employee)request.getSession().getAttribute("emp");
			String employeeName=emp.getName();
			request.setAttribute("employeeName", employeeName);
			return "newportalempName";
			
		}
		/*
		 * 修改客户信息--新portal系统
		 */
		public String updatacustomers(){
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			Employee emp = (Employee)request.getSession().getAttribute("emp");
			String employeeName=emp.getName();
			request.setAttribute("employeeName", employeeName);
			int id=Integer.parseInt(request.getParameter("customerid"));
			String hql="From Customer where customer_id="+id;
			Customer customer=null;
		
			customer =(Customer)executeRecordBussiness.exHql(hql);
			
			request.setAttribute("customer", customer);
			if(customer.getCustomerType2().equals("1")){
			return "updatacustomers";
			}else {
			return "updatacustomers1";
			}
		}
		public String updatacustomers1(){
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			Employee emp = (Employee)request.getSession().getAttribute("emp");
			String employeeName=emp.getName();
			request.setAttribute("employeeName", employeeName);
			int id=Integer.parseInt(request.getParameter("customerid"));
			String hql="From Customer where customer_id="+id;
			Customer customer=null;
		
			customer =(Customer)executeRecordBussiness.exHql(hql);
			
			request.setAttribute("customer", customer);
			
			request.getSession().setAttribute("customer", customer);
			return "updatacustomers1";
			
		}
		/*
		 * 删除客户信息提交时候--新portal系统
		 */
		 public void  delcust(){
			 
			 
			 String ids1=request.getParameter("ids");
			String ids[]= ids1.split(",");
			 if(ids.length>0){
			 for (int i = 0; i < ids.length; i++) {
				String hql="update Customer set del='1' where customerId="+Integer.parseInt(ids[i]);
				 customerBussiness.updateConkout(hql);
			 }
			 }
				try {
					response.getWriter().print(1);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		 }
		/*
		 * 修改客户信息提交时候--新portal系统
		 */
		public String newportalupdata(){
			Customer cu=null;
			String id=null;
			if(request.getParameter("customerid")!=null){
			 id=request.getParameter("customerid");
			 cu=customerBussiness.getCustomerdata(id);
			}
			try {
			   // Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//String customertype2="";
				
				
				String customertype=request.getParameter("customertype");
				//customertype2=request.getParameter("customertype2");
				String cardid=request.getParameter("cardid");
				String mobilePhone=request.getParameter("mobilePhone");
				String qq=request.getParameter("qq");
				String email=request.getParameter("email");
				String date=request.getParameter("date");
				String customerName=request.getParameter("customerName");
				String customerCompany=request.getParameter("customerCompany");
				String businessLicense=request.getParameter("businessLicense");
				String companyScale=request.getParameter("companyScale");
				String companyphone=request.getParameter("companyphone");
				String companyadress=request.getParameter("companyadress");
				String customerExplain=request.getParameter("customerExplain");
				String phone=request.getParameter("phone");
				String empid="";
				Map txt=(Map)request.getSession().getAttribute("sczj")!=null?(Map)request.getSession().getAttribute("sczj"):null;
				if(txt!=null){
				String sfza=(String)txt.get("身份证A");
				String sfzb=(String)txt.get("身份证B");
				String yyzz=(String)txt.get("营业执照");
				String fj="";
				if(sfza!="" && sfza!=null ){
					 fj=sfza+",";
					}
					if(sfzb!="" && sfzb!=null ){
						 fj=fj+sfzb+",";
						}
					if(yyzz!="" && yyzz!=null ){
							 fj=fj+yyzz;
				}
				cu.setCustomerfj(fj);
		}
				
				empid=request.getParameter("empid");
				cu.setCustomerId(Integer.parseInt(id));
				cu.setRealName(customerName);
				cu.setCardid(cardid);
				cu.setMobilePhone(mobilePhone);
				cu.setCustomerCompany(customerCompany);
				cu.setPhone(phone);
				cu.setQq(qq);
				cu.setEmail(email);
				cu.setCustomerName(customerName);
				cu.setLicense(businessLicense);
				cu.setCompanyScale(companyScale);
				cu.setCompanyphone(companyphone);
				cu.setCompanyadress(companyadress);
				cu.setDate(date);
				cu.setCustomerexplain(customerExplain);
				if(customertype==""||customertype==null){
					cu.setCustomerType2("3");
				}else{
					cu.setCustomerType2(customertype);
				}
				if(empid!=""&&empid!=null){
					int emmployeeid=Integer.parseInt(empid);
					String hql="From Employee where id="+emmployeeid;
					List emplist=customerBussiness.exHql(hql);
					Employee employee=(Employee)emplist.get(0);
					cu.setEmployee(employee);
				}else{
					//cu.setEmployee(loginEmp);
				}
				customerBussiness.doupdata(cu);
				} catch (Exception e) {
					e.printStackTrace();
				}
				request.getSession().removeAttribute("sczj");
			return mycustomerlist();
		}
		/*
		 *得到所有员工列表---新portal系统 
		 */
		public void getemplist(){
			try {
				response.setCharacterEncoding("UTF-8");
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String hql="from Employee where isLeave=1 and delflag=0";
			List emplist=customerBussiness.exHql(hql);
			String str = "<select name='empid'>";
			for(int i=0;i<emplist.size();i++){
				Employee emp = (Employee)emplist.get(i);
				int ids=emp.getId();
				str+="<option value="+"'"+emp.getId()+"'"+">"+emp.getName()+"</option>";
			}
			str+="</select>";
			try {
				response.getWriter().print(str);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		 /**
		  * 客户交接记录
		  * @return
		  */
		public String customerMove(){
			String custid=request.getParameter("custid");
			
			String oldempid=request.getParameter("employeeName");
			String newempid=null;
			if(request.getParameter("empid")!=null){
			newempid=request.getParameter("empid");
			
	
			String content=request.getParameter("jiaojie");
			String date=request.getParameter("date1");
			
			int custid1=Integer.parseInt(custid);
			int oldempid1=Integer.parseInt(oldempid);
			int newempid1=Integer.parseInt(newempid);
		    String sql="insert into customermove(customerId,oldPrincipal,newPrincipal,moveCause,movetime,Delflag) values("+custid1+","+oldempid1+","+newempid1+",'"+content+"','"+date+"',0)";
			customerBussiness.sqlupdate(sql);
		    String sql1="update customer set vendition="+newempid1+" where customer_id="+custid;
			customerBussiness.sqlupdate(sql1);
			}
			return mycustomerlist();
		}
		/**
		 * 批量客户交接
		 * @return
		 * @throws IOException
		 */
		public String customerMoveall(){
			String custid1=request.getParameter("custid");
			
			String []custid2=custid1.split(",");
			
			String oldempid=request.getParameter("employeeName");
			String newempid=null;
			if(request.getParameter("empid")!=null){
			newempid=request.getParameter("empid");
			
	
			String content=request.getParameter("jiaojie");
			String date=request.getParameter("date1");
			
		
			int oldempid1=Integer.parseInt(oldempid);
			int newempid1=Integer.parseInt(newempid);
			for (int i = 0; i < custid2.length; i++) {
				if(custid2[i]!="" && custid2[i]!=null){
			
			int custid11=Integer.parseInt(custid2[i]);
		    String sql="insert into customermove(customerId,oldPrincipal,newPrincipal,moveCause,movetime,Delflag) values("+custid11+","+oldempid1+","+newempid1+",'"+content+"','"+date+"',0)";
			customerBussiness.sqlupdate(sql);
		    String sql1="update customer set vendition="+newempid1+" where customer_id="+custid2[i];
		    
		    
		   
			customerBussiness.sqlupdate(sql1);
			
			}
			}
			}
			return mycustomerlist();
		}
		
		
		/*
		 *新portal系统 --上传附件
		 */
		public String doUpload() throws IOException {
			request.getSession().setAttribute("filedata", filedata);
			ActionContext ac=ActionContext.getContext();
			ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
			System.out.println("Debugging MC --->     --->    --->   filedata = "+filedata);
			String savePath = sc.getRealPath("/");
			savePath = savePath + "uploads/";
			Map zj = new HashMap();
			Map filepaths=new HashMap();
			File f1 = new File(savePath);
			if (!f1.exists()) {
				f1.mkdirs();
			}
			int size = filedata.size();
			
			if (size == 0)
				return "error";
			
			String extName = "";
			String name = null;
			String fjhzname="";
			for (int i = 0; i < size; i++) {
				extName = FiledataFileName.get(i).substring(
				FiledataFileName.get(i).lastIndexOf("."));
				fjhzname+=extName+",";
				name = UUID.randomUUID().toString();
				File file = new File(savePath + name + extName);
				System.out.println(filedata.get(i).getName()+filedata.get(i).getPath());
				try {
					FileUtils.copyFile(filedata.get(i), file);
				} catch (IOException e) {
					response.getWriter().print(3);
					e.printStackTrace();
					return null;
					
				}
				System.out.println("Debugging MC --->     --->    --->   /uploads/"+name + extName);
				filepaths.put(i, name + extName);
			}
			request.getSession().setAttribute("abcname", name+extName);
			request.getSession().setAttribute("fjhzname", fjhzname);
			response.getWriter().print(1);
			String str="";
			for(int i=0;i<filedata.size();i++){
				File file=((List<File>) filedata).get(i);
				str+=file.toString();
			}
			request.setAttribute("filepaths", str);
			
			
			String files="";
			for(int j=0;j<filepaths.size();j++){
				String paths=filepaths.get(j).toString();
				files+=paths+",";
			}
			
			System.out.println(files);
			request.getSession().setAttribute("files", files);
			return null;
		}
		/****
		 * 根据电话或者QQ查询客户是否存在
		 * @return
		 * @throws IOException 
		 */
		public void selectisno() throws IOException
		{
			String temp=request.getParameter("temp");
			String test=request.getParameter("test");
			String hql="from Customer where "+temp+"='"+test+"' and del='0'";
//			String hql="from Customer where qq='"+test+"' or phone='"+test+"' or mobilePhone='"+test+"' and del='0'";
			System.out.println(">>>>>>>>>>>>>>>>2"+hql);
			List<Customer> customer=customerBussiness.exHql(hql);
			if(customer.size()>0)
			{
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		/*
		 * 获取单个客户信息对象
		 */
		public String get(){
			try {
				String id=request.getParameter("id");
				Customer data=customerBussiness.getCustomerdata(id);
				request.setAttribute("data", data);
				return "addCustomer";
			} catch (Exception e) {
				return "will";
			}
		}
		/*
		 * 添加客户交接记录
		 */
		/*
		 * 获取单个客户信息对象
		 */
		public String move(){
			try {
				String id=request.getParameter("customerId");
				Customer data=customerBussiness.getCustomerdata(id);
				request.setAttribute("data", data);
				return "move";
			} catch (Exception e) {
				return "will";
			}
		}
		/**
		 * 增加客户跟踪记录
		 */
		
		public String customerrecord(){
			
			String str[]=request.getParameterValues("c1");//跟进方式，多种
			String content=request.getParameter("gznr");//跟进内容
			String custid=request.getParameter("custid");//客户id
			String userid=request.getParameter("userid");//员工id
			
			String str1="";
			for (int i = 0; i < str.length; i++) {
				if(i==str.length-1){
					str1=str1+str[i];
				}else{
					str1=str1+str[i]+",";
				}
			
			}
			 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 

			 java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
			 String str_date1 = formatter.format(currentTime);

			String hql="insert into intentfollow_up(Customer_id,empID,_date_,detail,followtype,del) values("+Integer.parseInt(custid)+","+Integer.parseInt(userid)+",'"+str_date1+"','"+content+"','"+str1+"','0')"; 
			System.out.println(hql);
			customerBussiness.sqlupdate(hql);
			return mycustomerlist();
		}
		/**
		 * 
		 * @return
		 */
		public String seefollow(){
			
			String empid=request.getParameter("empid");
			String custid=request.getParameter("custid");
			String sql="from IntentFollowUp where  customer="+custid;
		    List list=customerBussiness.exhql(sql);
		    List<IntentFollowUp> list1=list;
		    request.setAttribute("list", list1);
			return "seefollow";
		}
	public String customerjj(){
			
			String empid=request.getParameter("empid");
			String custid=request.getParameter("custid");
			String sql="from CustomerMove where delflag='0' and customer="+custid;
		    List list=customerBussiness.exhql(sql);
		    List<CustomerMove> list1=list;
		    request.setAttribute("list", list1);
			return "customerjj";
		}
		/**
		 * 去分配客户页面
		 * @return
		 */
		public String godeal(){
			try {
				String id=request.getParameter("id");
				Customer data=customerBussiness.getCustomerdata(id);
				request.setAttribute("data", data);
				return "deal";
			} catch (Exception e) {
				return "will";
			}
		}
		/**
		 * 分配客户
		 * @return
		 */
		public void deal(){
			try {
				String id=request.getParameter("id");
				String empid = request.getParameter("empid");
				String customerType2 = request.getParameter("customerType2");
				Customer data=customerBussiness.getCustomerdata(id);
				data.setCustomerType2(customerType2);
				Employee e =  new Employee();
				e.setId(StringUtil.strToInt(empid, 0));
				data.setEmployee(e);
				customerBussiness.updateData(data);
				response.getWriter().print(0);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					response.getWriter().print(1);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		/*
		 * 获得消息类型
		 */
		 public String messtype(){
				System.out.println("4334443");
				String hql="from Messagetype where messagetypeid=2";
				List meslist=messagetypeBussiness.exHql(hql);
				request.setAttribute("messagetypes", (Messagetype)meslist.get(0));
				
				String hql1="from Messagetype where superid=2";
				List meslist1=messagetypeBussiness.exHql(hql1);
				request.setAttribute("messagetypes1", meslist1);
				return "messageCustomer";
			}
		 public  String messJudge()
		 {
			   String messJudge=request.getParameter("messJudge");
				String hql="from Messagetype where messagetypeid=2";
				List meslist=messagetypeBussiness.exHql(hql);
				request.setAttribute("messagetypes", (Messagetype)meslist.get(0));
				
				
			 return null;
		 }
		 /**
		  * 获得所有的客户
		  * @return
		  */
		 public String show()

		 {
			 
			 System.out.println("customer message");
			 String hql="from Customer where del= 0";
			List<Customer> cusList= customerBussiness.exHql(hql);
			request.setAttribute("cusList", cusList);
			System.out.println("size=="+cusList.size());
			return "all";
			 
		 }

		 /**
		  * 新增客户跟进记录--新potal系统
		  */
		 
		 
		 		 /**

			 * 模糊查询
			 * @return
			 */
		   public String selectByInput() throws IOException
		   {
			   String textSuggest1=request.getParameter("textSuggest");
			  String  textSuggest=URLDecoder.decode(textSuggest1,"UTF-8");
			   String hql="from Customer where del= 0 and customerName='"+textSuggest+"'";
				System.out.println(">>>>>>>>>>>>>>>>1"+hql);
			   List<Customer> cusList= customerBussiness.exHql(hql);
				request.setAttribute("cusList", cusList);
			   return "all";
		   }
		   
		   
		   public void checkName() throws IOException{
			
			    String name=new String(request.getParameter("customerName").getBytes("gbk"),"utf-8");
			    String sname=request.getParameter("sname");
			    System.out.println("sname"+sname);
			    String hql=null;
			    //判断燕查询的是 1名字 还是 2身份证号 还是 3邮箱 数字标记
			    if(sname.equals("1")){
			    	hql="from Customer where realName='"+name+"'"; 
			    }else if(sname.equals("2")){
			    	hql="from Customer where cardid='"+name+"'"; 
			    }else if(sname.equals("3")){
			    	hql="from Customer where email='"+name+"'";  
			    }
			    System.out.println("-----"+name);
			    List<Customer> customer=customerBussiness.exHql(hql);
			    System.out.println(customer.size());
			    if(customer.size()!=0){
			    ok=false;
			    }else{
			    ok=true;
			    }
			    response.setCharacterEncoding("GBK");
			    PrintWriter out = response.getWriter();
			    out.println(ok);
			
		   }
		public void setDelnr(String delnr) {
			this.delnr = delnr;
		}
		public String getDelnr() {
			return delnr;
		}
		 
		 
}
