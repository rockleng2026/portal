package com.fuao.fajxc.action.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.CustomerMoveBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.bussiness.message.MessagetypeBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Messagetype;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 客户action
 * @author 14015 修改
 *
 */
public class CustomerAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private CustomerBussiness customerBussiness;
		private MessagetypeBussiness messagetypeBussiness;
	   private boolean ok;
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
		 * 添加客户信息对象
		 */
		public String add(){
			try {				
				customer.setIsLoginAccount(0);
				customer.setDel("0");
				customer.setAuthorization("fuaotech");
				customer.setDate(TimePattern.doTimeDf3(new Date()));
				Customer cus = customerBussiness.addCustomer(customer);
				
				/*阙超强 14015   添加记录动态信息*/
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
			return "listCustomer";
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
		 
		 
}
