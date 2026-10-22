package com.fuao.fajxc.action.customService;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.customService.CustomerServiceBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.product_manageService.Product_orderService;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.DateUtil;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TwoDimensionBarcode.TwoDimensionCode;
import com.fuao.fajxc.vo.CurrencyProcess;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.GoodsClass_expand;
import com.fuao.fajxc.vo.Goods_dict;
import com.fuao.fajxc.vo.Operate;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.SaledFlow;
import com.fuao.fajxc.vo.UpServer;
import com.opensymphony.xwork2.ModelDriven;

public class CustomServiceAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private HttpServletResponse response;

	private HttpServletRequest request;
	private SaleorderBussiness salsBuness;
	private Product_orderService product_CommentService;
	private String selvar;
	private String selvar11;
	private String inpvar;
	private String htStart;
	private String htEnd;
	private Customer customer; 
	private Customer custBean;
    private List<DeliveryAddress> dal;
    private DeliveryAddress deli;
    public int count;
	private String salnos;
	private String flagsnos;
	private double salMonys;
    private String Contact_Type;
	private static Logger logger = Logger.getLogger(CustomServiceAction.class);
	private CustomerServiceBussiness csbiz;
	private int cusId;

	public Customer getCustBean() {
		return custBean;
	}

	public void setCustBean(Customer custBean) {
		this.custBean = custBean;
	}

	public String getContact_Type() {
		return Contact_Type;
	}

	public void setContact_Type(String contactType) {
		Contact_Type = contactType;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public DeliveryAddress getDeli() {
		return deli;
	}

	public void setDeli(DeliveryAddress deli) {
		this.deli = deli;
	}

	public List<DeliveryAddress> getDal() {
		return dal;
	}

	public void setDal(List<DeliveryAddress> dal) {
		this.dal = dal;
	}

	public int getCusId() {
		return cusId;
	}

	public void setCusId(int cusId) {
		this.cusId = cusId;
	}

	public String getFlagsnos() {
		return flagsnos;
	}

	public void setFlagsnos(String flagsnos) {
		this.flagsnos = flagsnos;
	}
    
	public double getSalMonys() {
		return salMonys;
	}

	public void setSalMonys(double salMonys) {
		this.salMonys = salMonys;
	}

	public String getSalnos() {
		return salnos;
	}
    
	public void setSalnos(String salnos) {
		this.salnos = salnos;
	}

	public SaleorderBussiness getSalsBuness() {
		return salsBuness;
	}

	public void setSalsBuness(SaleorderBussiness salsBuness) {
		this.salsBuness = salsBuness;
	}

	/**
	 * 定单流程
	 */
	@SuppressWarnings("unchecked")
	public String customFlow(){
		logger.info("sno="+salnos);
		int oid=0,flag=0;
		try {
			List<SaleOrder> sOrder=salsBuness.getOrdersDate("from SaleOrder s where s.saleOrderNo='"+salnos+"'");
			SaledFlow sdf = new SaledFlow();
			SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (SaleOrder saleOrder : sOrder) {
				    oid=saleOrder.getId();
			  List<SaledFlow> sflow=salsBuness.getOrdersDate("from SaledFlow s where s.Tsaleorders.id="+oid);
				    logger.info("so="+saleOrder.getId());
				 if(saleOrder.getAuditingState().equals("0")){
					for (SaledFlow saledFlow : sflow) {
						if(saledFlow.getDfContent().equals("等待用户确认定单信息...")){
						    	saledFlow.setDfstat("0");
					    	    salsBuness.updtFlowInfo(saledFlow);
						}
						if(saledFlow.getDfContent().equals("等待相关人员审核...")){
							flag=1;
							break;
						}

					}
					if(flag==0){
						sdf.setDfContent("等待相关人员审核...");
						 sdf.setDfId(0);
					     sdf.setTsaleorders(saleOrder);
					     sdf.setDftime(sim.format(new Date()));
						 salsBuness.saveFlowInfo(sdf);
					}
					request.getSession().setAttribute("mpsFlags","a2");
				 }
				if(saleOrder.getAuditingState().equals("1")){
					for (SaledFlow saledFlow : sflow) {
					    if(saledFlow.getDfContent().equals("相关人员已审核等待用户付款...")){
					    	flag=1;
					    	break;
					    }
					    if(saledFlow.getDfContent().equals("等待用户确认定单信息...")){
					    	saledFlow.setDfstat("0");
				    	    salsBuness.updtFlowInfo(saledFlow);
					    }
					
					    
					}
					if(flag==0){
						sdf.setDfContent("相关人员已审核等待用户付款...");
						 sdf.setDfId(0);
					     sdf.setTsaleorders(saleOrder);
					     sdf.setDftime(sim.format(new Date()));
						 salsBuness.saveFlowInfo(sdf);
					}
					request.getSession().setAttribute("mpsFlags","a3");
				}
				if(saleOrder.getAuditingState().equals("3")){
					for (SaledFlow saledFlow : sflow) {
					    if(saledFlow.getDfContent().equals("等待用户确认定单信息...")){
							flag=1;
							break;
					     }
					
					}
					if(flag==0){
						sdf.setDfContent("等待用户确认定单信息...");
						 sdf.setDfId(0);
					     sdf.setTsaleorders(saleOrder);
					     sdf.setDftime(sim.format(new Date()));
						 salsBuness.saveFlowInfo(sdf);
					}
				    request.getSession().setAttribute("mpsFlags","a1");
				}
			}
			 List<SaledFlow> sOder=salsBuness.getOrdersDate("from SaledFlow s where s.Tsaleorders.id="+oid);
			 for (SaledFlow saledFlow : sOder) {
				if(saledFlow.getDfContent().equals("财务已审核，等待按排运维人员上架...")){
					 request.getSession().setAttribute("mpsFlags","a4");
				}
			 }
	         request.getSession().setAttribute("FlowList",sOder);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "cusFlows";
	}
	/**
	 * 定单流程
	 */

	/**
	 * 退出系统
	 */
	public String outSystems(){
		request.getSession().removeAttribute("loginname");
		request.getSession().removeAttribute("code");
		request.getSession().removeAttribute("customer");
		return "outsyst";
	}
	/**
	 * 客户登录
	 */
	
	public String customerLogin() {

		
		
		// 获取登录名
		String loginid = request.getParameter("userid");

		if (loginid == null || loginid == "" || loginid.equals("")) {
			request.setAttribute("errorMsg", "请输入用户名！");
			return "error";

		}
		request.setAttribute("username", loginid);

		request.getSession().setAttribute("loginname", loginid);
		//获取登录密码

		// 获取登录密码

		String password = request.getParameter("passwd");

		if (password == null || password == "" || password.equals("")) {
			request.setAttribute("errorMsg", "请输入密码！");
			return "error";

		}

		// 获取登录输入验证码
		String valuecode = request.getParameter("ValCode");
		// 获取验证码与登录验证码进行比对
		String code = (String) request.getSession().getAttribute("rand");
		// 如果两个验证码不匹配则返回到登录页面并给出提示
		if (valuecode == null || !valuecode.equals(code)) {

			request.setAttribute("errorMsg", "验证码错误！");
			return "error";
		}
		// 根据登录名也密码查询客户是否存在
		Customer customer = csbiz.customerLogin(loginid, password);
		// 如果用户问NULL表示用户不存在 。返回到登录页面并给出提示 用户名或密码错误
		if (customer == null) {
			request.setAttribute("errorMsg", "用户名或密码错误！");
			return "error";
		} else {
			if (customer.getIsLoginAccount() == 2) {
				request.setAttribute("errorMsg", "您还没激活账户，请到您的邮箱激活账户！");
				
				return "error";
			}

			Cookies cookie = new Cookies();
			cookie.putCookie(response, "customerId", customer.getCustomerId()
					.toString());
			request.getSession().setAttribute("customer", customer);
			int pageNo = 1;
			// 登录成功把登录的ip,登录的时间记录到数据库，下次登陆时查询 ---14032
			String ip = request.getLocalAddr();
			List<String> custList = csbiz.selcust(loginid, ip);
			Integer moneyInteger = 0;
			for (int i = 0; i < custList.size(); i++) {
				String string = custList.get(i);
				moneyInteger = moneyInteger + Integer.parseInt(string);
			}
			request.getSession().setAttribute("money", moneyInteger);
			// 判断是否是正式客户如果是进入首页，点击订单详情如果不是条跳转到填写详细信息的页面
		

			String hql = hql = "from ConkOut c where c.delflag = 0 and c.state=4 and c.customer.customerId = "
					+ customer.getCustomerId() + " order by id desc";

			Pages pages = csbiz.get(hql, pageNo, 10, null);

			if (null != pages.getPageList() && pages.getPageList().size() > 0) {

				request.setAttribute("pages", pages);

				request.setAttribute("mark", pages.getPageList().size());

				return "success";

			} else

				return "success";
		}

	}
	/*
	 * 判断用户是否设置10天免费登录
	 */
	public void isOkCookies()
	{
		Cookie[] cookies = request.getCookies();
        for(Cookie c :cookies ){
            if(c.getName().equals("customerId"))
            {
            
            	try {
					response.getWriter().print(c.getValue());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            	
            }
            if(c.getName().equals("isOkPhone"))
            {
            	request.getSession().setAttribute("IsOkPhone", c.getValue());
            }
        }
    	
        
      // Test.snsRequest();
        return ;
	}
	
	/**
	 * 客户客户端登录
	 */
	public void cLogin()
	{
		
		//String contentLength = request.getHeader("Content-Length");
		//String ContentType = request.getHeader("Content-Length");
		String method = request.getMethod();
		String cUUID = request.getParameter("uuid");
		String clientVersion = request.getParameter("client_version");
		String appKey = request.getParameter("appKey");
		String cName = request.getParameter("cusName");
		String cPass = request.getParameter("password");
		String time = request.getParameter("time");
		String ip = request.getParameter("cusIp");//客户端用户IP
		String reqSrc = request.getRemoteAddr();
		logger.debug("do=cLogin method="+method+"src="+reqSrc+" time="+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()));
//		if(!method.toLowerCase().equals("post")){printMsg(-1, "Illegal request"); return ;}
		if(appKey == null || !appKey.trim().equals("snscloud_node_b")){printMsg(-1, "appKey is error"); return ;}
		if(cUUID == null || cUUID.trim().equals("")){printMsg(-1, "uuid is error"); return ;}
		if(cName == null || cName.trim().equals("")){printMsg(-1, "cName is error"); return ;}
		if(cPass == null || cPass.trim().equals("")){printMsg(-1, "cPass is error"); return ;}
		if(clientVersion == null || clientVersion.trim().equals("")){printMsg(-1, "clientVersion is error"); return ;}
		if(ip == null || ip.trim().equals("")){printMsg(-1, "ip is error"); return ;}
		
		Customer customer = csbiz.customerLogin(cName, cPass);
		
		// 如果用户问NULL表示用户不存在 。返回到登录页面并给出提示 用户名或密码错误
		if (customer == null) {printMsg(-1, cName +" is not existed"); return ;}
		//if (customer.getIsLoginAccount() == 2) request.setAttribute("errorMsg", "您还没激活账户，请到您的邮箱激活账户！");
		//记录登录地址
		csbiz.selcust(cName, ip);
		String jsonData = "{\"detail\":\"success\",\"result\":\"0\"}";
		try {
			response.getWriter().print(jsonData);
		} catch (IOException e) {
			logger.error("cusClientLogin faild :"+e);
		}
	}
	
	/**
	 * 客户客户端注册
	 */
	public void cReg() {
		String msgStr = "success";
		int msgCode = 0;
		
		// 获取登录输入客户端KEY
		
		// KEY验证
		
		// 如果两个验证码不匹配则返回错误提示
		
//		if (appKey == null) {
//			msgStr = "验证码错误";
//			msgCode = -1;
//		}
		String method = request.getMethod();
		String cUUID = request.getParameter("uuid");
		String clientVersion = request.getParameter("client_version");//客户端版本号
		String appKey = request.getParameter("appKey");
		String cName = request.getParameter("cusName");
		String cPass = request.getParameter("password");
		String cEmail = request.getParameter("email");
		String time = request.getParameter("time");
		String pid = request.getParameter("pid");//代理商ID 用于识别推广注册的代理商
		String ip = request.getParameter("cusIp");
		String reqSrc = request.getRemoteAddr();
		
		logger.debug("do=cReg src="+reqSrc+" time="+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()));
//		if(!method.toLowerCase().equals("post")){printMsg(-1, "Illegal request"); return ;}
		if(appKey == null || !appKey.trim().equals("snscloud_node_b")){printMsg(-1, "appKey is error"); return ;}
		if(cUUID == null || cUUID.trim().equals("")){printMsg(-1, "uuid is error"); return ;}
		if(cName == null || cName.trim().equals("")){printMsg(-1, "cName is error"); return ;}
		if(cPass == null || cPass.trim().equals("")){printMsg(-1, "cPass is error"); return ;}
		if(cEmail == null || cEmail.trim().equals("")){printMsg(-1, "cEmail is error"); return ;}
		if(pid == null || pid.trim().equals("")){printMsg(-1, "pid is error"); return ;}
		if(clientVersion == null || clientVersion.trim().equals("")){printMsg(-1, "clientVersion is error"); return ;}
		if(ip == null || ip.trim().equals("")){printMsg(-1, "ip is error"); return ;}
		
		//验证用户名
		List<Customer> list = new ArrayList<Customer>();
		list = csbiz.getList("Customer", " and customerName = '" + cName+ "'");
		System.out.println("username size : " + list.size());
		if (list.size() > 0){printMsg(-1, cName+ "username is existed"); return ;}
		//验证邮箱
		list = csbiz.getList("Customer", " and email = '" + cEmail + "'");
		System.out.println("email size : " + list.size());
		if (list.size() > 0){printMsg(-1, "email is existed: "+cEmail); return ;}
		//写入数据库
		Customer customer = new Customer();
		customer.setCustomerName(cName);
		customer.setCustomerPassword(cPass);
		customer.setEmail(cEmail);
		customer.setLocalip(ip);
		customer.setUserFrom("client"+":"+clientVersion);//客户来自客户端:版本号
		customer.setUserFrom2(cUUID);//uuid
		customer.setUserNotes(pid);//代理商ID
		customer.setDel("0");
		customer.setIsLoginAccount(2);
		customer.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		customer.setIssetmibao(0 + "");
		customer = csbiz.addCustomer(customer);
		if(customer.getCustomerId() ==null || customer.getCustomerId() <=0){printMsg(-1, cName +" register failed"); return ;}
		
		//success
		printMsg(0, cName +" register success");
	}
	
	/**
	 * 用户查询
	 */
	@SuppressWarnings("unchecked")
	public void cQuery() {
		
		String clientVersion = request.getParameter("client_version");//客户端版本号
		String appKey = request.getParameter("appKey");//访问授权
		String attrs = request.getParameter("attrs");//注册用户名
		String values = request.getParameter("values");
		String time = request.getParameter("time");
		String reqSrc = request.getRemoteAddr();
		
		logger.debug("do=cQuery client_version="+clientVersion+" src="+reqSrc+" time="+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()));
		
		if(appKey == null || !appKey.trim().equals("snscloud_node_b")){printMsg(-1, "appKey is error"); return ;}
		if(attrs == null || attrs.trim().equals("")){printMsg(-1, "attrs is error"); return ;}
		if(values == null || values.trim().equals("")){printMsg(-1, "values is error"); return ;}
		
		String[] fields = attrs.split(",");
		String[] fValues = values.split(",");
		if(fields.length != fValues.length){printMsg(-1, "Is not equal to the number of fileds and values"); return ;}
		
		List<String> fieldList = Arrays.asList(fields);
		List<String> valueList = Arrays.asList(values);
		
		//简版处理，设置只传用户名的情况做查询--以后做扩展
		String cusName = fieldList.get(0);
		String value = valueList.get(0);
		
		
		if(clientVersion == null || clientVersion.trim().equals("")){printMsg(-1, "clientVersion is error"); return ;}
		
		//验证用户名
		List<Customer> list = new ArrayList<Customer>();
		list = csbiz.getList("Customer", " and customerName = '" + value+ "'");
		System.out.println("username size : " + list.size());
		if (list == null || list.size() <= 0){printMsg(-1, cusName+ " is not existed"); return ;}
		
		StringBuffer sb = new StringBuffer();
		sb.append("{\"detail\":[");
		for (int i = 0; i < list.size(); i++) {
			Customer c = list.get(i);
			if(i == 0){
				sb.append("{");
			}else{
				sb.append(",{");
			}
			sb.append("\"cusId\":\"").append(c.getCustomerId()).append("\",");
			sb.append("\"cusName\":\"").append(c.getCustomerName()).append("\",");
			sb.append("\"email\":\"").append(c.getEmail()).append("\",");
			String regDate = (c.getDate() == null || c.getDate().length()<10)? "":c.getDate().substring(0, 10);
			sb.append("\"regDate\":\"").append(regDate).append("\",");
			sb.append("\"uuid\":\"").append(c.getUserFrom2()).append("\"");
			
			sb.append("}");
		}
		sb.append("],\"result\":\"0\"}");
		logger.info("query success："+sb.toString());
		printMsg(sb.toString());
	}
	/**
	 * 提供统一json响应接口
	 * @param errorCode
	 * @param errorMsg
	 */
	private void printMsg(int errorCode,String errorMsg){
		String jsonData = "{\"detail\":\""+errorMsg+"\",\"result\":\""+errorCode+"\"}"; 
		try {
			response.getWriter().print(jsonData);
			logger.info(jsonData);
		} catch (IOException e) {
			logger.error("customer register error IOException: "+e);
		}
	}
	/**
	 * 提供统一json响应接口
	 * @param errorCode
	 * @param errorMsg
	 */
	private void printMsg(String jsonData){
		try {
			response.getWriter().print(jsonData);
		} catch (IOException e) {
			logger.error("printMsg error IOException: "+e);
		}
	}
	
	
	/**
	 * 立云客户登录 2013-03-27
	 */
	public String litscloudUserLogin() {
		
		// 获取登录名
		 String IsOk=request.getParameter("IsOk");
		 String loginid = request.getParameter("userid");
		 String password = request.getParameter("passwd");
		 String valuecode = request.getParameter("yanzhengma1");
		 String code = (String) request.getSession().getAttribute("rand");
		 String dl=request.getParameter("dl1");
		 if(IsOk.equals("1"))
		 {
			
			if (loginid == null || loginid == "" || loginid.equals("")) {
				request.getSession().setAttribute("msgtip", "请输入用户名！");
				return "lits_login_error";
	
			}
	
			request.getSession().setAttribute("loginname", loginid);
			//获取登录密码
	
			// 获取登录密码
	
			
	
			if (password == null || password == "" || password.equals("")) {
				request.getSession().setAttribute("msgtip", "请输入密码！");
				return "lits_login_error";
	
			}
	
			// 获取登录输入验证码
			// 获取验证码与登录验证码进行比对
			
			// 如果两个验证码不匹配则返回到登录页面并给出提示
		if (valuecode == null || !valuecode.equals(code)) {
	
			request.getSession().setAttribute("msgtip", "验证码错误！");
				return "lits_login_error";
			}
			// 根据登录名也密码查询客户是否存在
			Customer customer = csbiz.customerLogin(loginid, password);
			// 如果用户问NULL表示用户不存在 。返回到登录页面并给出提示 用户名或密码错误
			if (customer == null) {
				request.getSession().setAttribute("msgtip", "用户名或密码错误！");
				return "lits_login_error";
			} else {
				if ( customer.getIsLoginAccount() == null || customer.getIsLoginAccount() == 2 ) {
					request.getSession().setAttribute("msgtip", "您还没激活账户");
					
					return "lits_login_error";
				}
	
				
				if(dl.equals("2"))
				{
					Cookie cookie= new Cookie("customerId",customer.getCustomerName());
				cookie.setMaxAge(432000);
				response.addCookie(cookie);
				}
				request.getSession().setAttribute("customer", customer);
				// 登录成功把登录的ip,登录的时间记录到数据库，下次登陆时查询 ---
				String ip = "";
				if (request.getHeader("x-forwarded-for") == null) {
					ip = request.getRemoteAddr();
				}else{
					ip = request.getHeader("x-forwarded-for");
				}
				request.getSession().setAttribute("ipaddress", ip);
				return "lits_login_success";
			}
		 }
		 else
		 {
			// 获取登录名

				if (loginid == null || loginid == "" || loginid.equals("")) {
					request.getSession().setAttribute("msgtip", "请输入手机号！");
					return "lits_login_error";

				}
				request.setAttribute("username", loginid);

				
				//获取登录密码

				// 获取登录密码


				if (password == null || password == "" || password.equals("")) {
					request.getSession().setAttribute("msgtip", "请输入密码！");
					return "lits_login_error";

				}

				// 获取登录输入验证码
				
				// 获取验证码与登录验证码进行比对
				
				// 如果两个验证码不匹配则返回到登录页面并给出提示
				if (valuecode == null || !valuecode.equals(code)) {

					request.getSession().setAttribute("msgtip", "验证码错误！");
					return "lits_login_error";
				}
				// 根据登录名也密码查询客户是否存在
				List<Customer> customer= csbiz.getList("Customer", "and mobilePhone='"+loginid+"' and phoneIsOk=1");
				
				// 如果用户问NULL表示用户不存在 。返回到登录页面并给出提示 用户名或密码错误
				if (customer.size()>0) {
					for (int i=0;i<customer.size();i++)
					{
						if(customer.get(i).getCustomerPassword().equals(password))
						{
							
							
							
							if(dl.equals("2"))
							{
								Cookie cookie= new Cookie("customerId",customer.get(i).getMobilePhone());
							cookie.setMaxAge(432000);
							response.addCookie(cookie);
							
							Cookie cookie1= new Cookie("isOkPhone",IsOk);
							cookie1.setMaxAge(432000);
							response.addCookie(cookie1);
							}
							request.getSession().setAttribute("customer", customer.get(i));
							request.getSession().setAttribute("loginname", customer.get(0).getCustomerName());
							// 登录成功把登录的ip,登录的时间记录到数据库，下次登陆时查询 ---
							String ip = "";
							if (request.getHeader("x-forwarded-for") == null) {
								ip = request.getRemoteAddr();
							}else{
								ip = request.getHeader("x-forwarded-for");
							}
							request.getSession().setAttribute("ipaddress", ip);
							return "lits_login_success";
						}
					}
				} 

		 }

		 request.getSession().setAttribute("msgtip", "手机号或密码错误、或者没有开启手机功能！");
		 
		 return "lits_login_error";
	}
	
	/**
	 * 立云客户定单 2013-03-28
	 */
	public String litscloudgetOrder() {
		Customer cst=null;
		if(request.getSession().getAttribute("customer")!=null){
		 cst=(Customer)request.getSession().getAttribute("customer");
		}else{
			cst = new Customer();
		}
//		String strcid = request.getParameter("cid");
		Integer uid= cst.getCustomerId();//客户id
		String soid=request.getParameter("soid")!=null?request.getParameter("soid"):"ddxq";//

		try {
			response.setCharacterEncoding("GBK");
			request.setCharacterEncoding("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//request.getSession().removeAttribute("pageNo");
		try {
			String 	soNums = request.getParameter("sonums")!=null?new String(request.getParameter("sonums").getBytes(
			"iso-8859-1"), "UTF-8"):"0";
			String	 sgnames = request.getParameter("sgname")!=null?new String(request.getParameter("sgname").getBytes(
			"iso-8859-1"), "GBK"):"0";
			String	sgcode = request.getParameter("Sgcode")!=null?new String(request.getParameter("Sgcode").getBytes(
			"iso-8859-1"), "GBK"):"0";
			
		Integer soStat = request.getParameter("soStat") != null ? Integer
				.parseInt(request.getParameter("soStat")) : -1;
		String 
		stime = request.getParameter("sgtime") != null ? request
				.getParameter("sgtime") : "0";
		String pageNo1 = request.getParameter("pageNo") != null ? request
				.getParameter("pageNo") : "1";
				
				
				String pagenum = request.getParameter("pagenum") != null ? request
						.getParameter("pagenum") : "1";
						
		String hql = "from Sale_orders where customer.customerId="+uid+" ";

		if (!soNums.equals("0") && !soNums.equals("")) {
			hql = hql + "and soNums like '%" + soNums + "%'";
			request.setAttribute("soNums", soNums);
		}

		if (soStat != -1) {
			hql = hql + " and soStat=" + soStat;
			request.setAttribute("soStat", soStat);
		}else{
			request.setAttribute("soStat", "-1");
			
		}
		if (!stime.equals("0") && !stime.equals("")) {
			hql = hql + "and soOrderTime like '%" + stime + "%'";
			request.setAttribute("stime", stime);
		}
		int pageNo = Integer.parseInt(pageNo1);
		int pageall=Integer.parseInt(pagenum);
		if(pageNo>pageall){
			
			pageNo=pageall;
		}
		if(pageNo<0){
			
			pageNo=1;
		}
		int pageSize = 4;
		String hql1 = "from SaleGoods_mids where 1=1 ";
		String idhql = "select  sale_orders.soId from SaleGoods_mids where 1=1 ";
		if (!sgnames.equals("0") && !sgnames.equals("")) {
			idhql = idhql + " and sale_goods.sgname like '%" + sgnames + "%'";
			request.setAttribute("sgnames", sgnames);
		}
		if (!sgcode.equals("0") && !sgcode.equals("")) {
			idhql = idhql + " and sale_goods.sgcode like '%" + sgcode + "%'";
			request.setAttribute("sgcode", sgcode);
		} 
		//idhql = idhql+" and sale_goods.sgStat <> '2'";
		List list3 = salsBuness.getOrdersDate(idhql);
		String idstr = "";
		if (list3.size() != 0) {
			for (int i = 0; i < list3.size(); i++) {
				idstr = idstr + list3.get(i).toString() + ",";
			}
			
		}
		hql = hql + " and soId in(" + idstr + "-1) order by soId desc";
		System.out.println(idhql);
		System.out.println(hql);
		List list1 = salsBuness.getOrdersDate(hql1);// 订单列表

		Pages pg = salsBuness.select(hql, pageNo,
				pageSize, null);
		List solistList = pg.getPageList();
		List<Sale_orders> solist1 = solistList;
		System.out.println(solist1);
		int pgall = pg.getAllCount();// 总行数
		int gageNoall = pgall / 4;// 总页数
		
		if (pgall % 4 != 0) {
			gageNoall = gageNoall + 1;
		}
		if(!soid.equals("ddxq")){
		List<Operate> operate=null;//运维单list
		String uplist1="From UpServer where soOrders.soNums='"+soid+"'";
		List upserverlist = salsBuness.getOrdersDate(uplist1);// 上价单list
		List<UpServer> upserver=upserverlist;
		  if(upserver.size()>0){
		    	request.setAttribute("upserver", upserver);
		    	
		    	
					int xid=upserver.get(0).getId();

		    		String Operatelist="From Operate where  upserver.id="+xid+"";
		    		List operatelist = salsBuness.getOrdersDate(Operatelist);// 运维单list
		    		operate=operatelist;
		    		 

		    	    
		    	    	
		    	    	
		    	    
		    		
			
					
					
				
		    }
		
	
		
	    request.setAttribute("upserver", upserver);//ss
	    request.setAttribute("soid", soid);//ss
	    if(operate!=null){
	    request.setAttribute("operate1", operate);
	    }
	   
		}
		request.setAttribute("pageNo1", pageNo1);
		request.setAttribute("pageNo", pageNo);
		request.getSession().setAttribute("pageNo1", pageNo);
		request.setAttribute("gageNoall", gageNoall);
 		request.setAttribute("solist3", solist1);
		request.setAttribute("list1", list1);
		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(!soid.equals("ddxq")){
			
			return "ddxq";
		}else{
			return "getOrder";
		}
			
		
		}

	/**
	 * 立云客户定单 2013-03-28
	 *//*
	public String litscloudgetOrder() {
		Customer cst=null;
		if(request.getSession().getAttribute("customer")!=null){
		 cst=(Customer)request.getSession().getAttribute("customer");
		}else{
			cst = new Customer();
		}
//		String strcid = request.getParameter("cid");
		Integer uid= cst.getCustomerId();//客户id
		String soid=request.getParameter("soid")!=null?request.getParameter("soid"):"ddxq";//

		try {
			response.setCharacterEncoding("GBK");
			request.setCharacterEncoding("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//request.getSession().removeAttribute("pageNo");
		try {
			String 	soNums = request.getParameter("sonums")!=null?new String(request.getParameter("sonums").getBytes(
			"iso-8859-1"), "UTF-8"):"0";
			String	 sgnames = request.getParameter("sgname")!=null?new String(request.getParameter("sgname").getBytes(
			"iso-8859-1"), "GBK"):"0";
			String	sgcode = request.getParameter("Sgcode")!=null?new String(request.getParameter("Sgcode").getBytes(
			"iso-8859-1"), "GBK"):"0";
			
		Integer soStat = request.getParameter("soStat") != null ? Integer
				.parseInt(request.getParameter("soStat")) : -1;
		String 
		stime = request.getParameter("sgtime") != null ? request
				.getParameter("sgtime") : "0";
		String pageNo1 = request.getParameter("pageNo") != null ? request
				.getParameter("pageNo") : "1";
				
				
				String pagenum = request.getParameter("pagenum") != null ? request
						.getParameter("pagenum") : "1";
						
		String hql = "from Sale_orders where customer.customerId="+uid+" ";

		if (!soNums.equals("0") && !soNums.equals("")) {
			hql = hql + "and soNums like '%" + soNums + "%'";
			request.setAttribute("soNums", soNums);
		}

		if (soStat != -1) {
			hql = hql + " and soStat=" + soStat;
			request.setAttribute("soStat", soStat);
		}else{
			request.setAttribute("soStat", "-1");
			
		}
		if (!stime.equals("0") && !stime.equals("")) {
			hql = hql + "and soOrderTime like '%" + stime + "%'";
			request.setAttribute("stime", stime);
		}
		int pageNo = Integer.parseInt(pageNo1);
		int pageall=Integer.parseInt(pagenum);
		if(pageNo>pageall){
			
			pageNo=pageall;
		}
		if(pageNo<0){
			
			pageNo=1;
		}
		int pageSize = 4;
		String hql1 = "from SaleGoods_mids where 1=1 ";
		String idhql = "select  sale_orders.soId from SaleGoods_mids where 1=1 ";
		if (!sgnames.equals("0") && !sgnames.equals("")) {
			idhql = idhql + " and sale_goods.sgname like '%" + sgnames + "%'";
			request.setAttribute("sgnames", sgnames);
		}
		if (!sgcode.equals("0") && !sgcode.equals("")) {
			idhql = idhql + " and sale_goods.sgcode like '%" + sgcode + "%'";
			request.setAttribute("sgcode", sgcode);
		} 
		//idhql = idhql+" and sale_goods.sgStat <> '2'";
		List list3 = salsBuness.getOrdersDate(idhql);
		String idstr = "";
		if (list3.size() != 0) {
			for (int i = 0; i < list3.size(); i++) {
				idstr = idstr + list3.get(i).toString() + ",";
			}
			
		}
		hql = hql + " and soId in(" + idstr + "-1) order by soId desc";
		System.out.println(idhql);
		System.out.println(hql);
		List list1 = salsBuness.getOrdersDate(hql1);// 订单列表

		Pages pg = salsBuness.select(hql, pageNo,
				pageSize, null);
		List solistList = pg.getPageList();
		List<Sale_orders> solist1 = solistList;
		System.out.println(solist1);
		int pgall = pg.getAllCount();// 总行数
		int gageNoall = pgall / 4;// 总页数
		
		if (pgall % 4 != 0) {
			gageNoall = gageNoall + 1;
		}
		if(!soid.equals("ddxq")){
		List<Operate> operate=null;//运维单list
		String uplist1="From UpServer where soOrders.soNums='"+soid+"'";
		List upserverlist = salsBuness.getOrdersDate(uplist1);// 上价单list
		List<UpServer> upserver=upserverlist;
		  if(upserver.size()>0){
		    	request.setAttribute("upserver", upserver);
		    	
		    	
					int xid=upserver.get(0).getId();

		    		String Operatelist="From Operate where  upserver.id="+xid+"";
		    		List operatelist = salsBuness.getOrdersDate(Operatelist);// 运维单list
		    		operate=operatelist;
		    		 

		    	    
		    	    	
		    	    	
		    	    
		    		
			
					
					
				
		    }
		
	
		
	    request.setAttribute("upserver", upserver);//ss
	    request.setAttribute("soid", soid);//ss
	    if(operate!=null){
	    request.setAttribute("operate1", operate);
	    }
	   
		}
		request.setAttribute("pageNo1", pageNo1);
		request.setAttribute("pageNo", pageNo);
		request.getSession().setAttribute("pageNo1", pageNo);
		request.setAttribute("gageNoall", gageNoall);
 		request.setAttribute("solist3", solist1);
		request.setAttribute("list1", list1);
		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(!soid.equals("ddxq")){
			
			return "ddxq";
		}else{
			return "getOrder";
			
		}
		
		
	
	}*/
	/**
	 * liyun huoqushangpin  
	 * @return
	 *  
	 */
	public String litscloudgetprodut() {
		  String twhere=request.getParameter("page")!=null?request.getParameter("page"):"";

		  String sgcode=request.getParameter("sgcode");
		  String sql="From  Sale_goods where  sgcode='"+sgcode+"'";
		  List salegood=salsBuness.getOrdersDate(sql);
		  List<Sale_goods> sllist=salegood;
		  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
			String str_date1 = formatter.format(currentTime); //将日期时间格式化 
		 request.setAttribute("date1", str_date1);
		  request.setAttribute("sllist", sllist);
		  
		  Sale_goods sg = (Sale_goods)sllist.get(0);
		  String attrstr = "";
		  if(sg != null && sg.getSgAttribute() != null){
			  attrstr =sg.getSgAttribute().trim();//无@2|2|CPU|2@3|3|内存|1,3,4@无
		  }
//			组合规格字符串
			String specstr = sg.getSgspecifications();
			String first_spec_str = "";//保存第一规格的属性组合字符串 最后放到requst中去
			String second_spec_str = "";//保存第二规格的属性组合字符串 最后放到requst中去
			
			// String strge=sa.getSgspecifications();//属性
			 String isstrge="";//是否符合规则
//			   组合规格字符串
			   String strge=sg.getSgspecifications();//字符串类型‘1，2，222，222，22’第一个为行1的checkbox值，第二个为行2的checkbox值
			   if(strge!=null && strge!=""){
				  String str[]= strge.split("\\|");
				  Integer a=str.length;//有多少条数据
				  System.out.println(strge);
				  for (int i = 0; i < str.length; i++) {//获取第一个的checkbox的选中值
					  if(str[i]!=null && !str[i].equals("")){
						  String list=str[i];
						  String lexing[]=list.split(",");
						  	if(lexing.length>2){
							 for (int j = 0; j < 1; j++) {
						    	 if(lexing[0]!=null && !lexing[0].equals("")){
						    	 }
							 }
						  	}else{
						  		isstrge="no";
						  	}
					  }}
				}
				  if(!isstrge.equals("no")){
					  request.setAttribute("strge", strge);//内容
				  }
				  
		    
			System.out.println("w.......,=" + sg.getSgAttribute());
//		     得到商品属性
			   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
			   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//			   attributMap.put(label, value)
			   if(attrstr == null || attrstr.trim().equals("")){
					logger.info("组合商品属性：该商品无特殊属性");
				}else{
					String[] str1 = attrstr.split("@");//第一次分割
					if(str1.length != 4){
						logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
					}else{
						String  input_str = str1[0];//文本
						String  select_str = str1[1];//下拉
						String  checkbox_str = str1[2];//多选
						String  radio_str = str1[3];//单选
						
						attr_map = buildMap(attr_map,input_str);
						attr_map = buildMap(attr_map,select_str);
						attr_map = buildMap(attr_map,checkbox_str);
						attr_map = buildMap(attr_map,radio_str);
						
						for (Iterator it = attr_map.keySet().iterator(); it
								.hasNext();) {
							String label = (String) it.next();
							logger.info("label="+label);
						}
					}
				}
			   StringBuffer sb = new StringBuffer();
			   
			   Goods_dict gd   = (Goods_dict)salsBuness.getObj(Goods_dict.class, ""+sg.getGoods_dict().getGdId());
			  
			   Set set =  gd.getGoodsClass_expands();
				if(set == null || set.size()== 0){//无属性
					logger.info("类目编码为"+gd.getGdcodes()+"无类目属性");
				}else{
					for (Iterator it = set.iterator(); it.hasNext();) {
						GoodsClass_expand gde = (GoodsClass_expand) it.next();
						//用|分割
						sb.append(gde.getGeTemp1());
						sb.append("|");
						sb.append(gde.getGeTemp2());
						sb.append("|");
						sb.append(gde.getGeTemp3());
						sb.append("|");
						sb.append(gde.getGeTemp4());
						sb.append("|");
						sb.append(gde.getGeTemp5());
						sb.append("|");
						sb.append(gde.getGeTemp6());
						sb.append("|");
						sb.append(gde.getGeTemp7());
						sb.append("|");
						sb.append(gde.getGeTemp8());
						sb.append("|");
						sb.append(gde.getGeTemp9());
						sb.append("|");
						sb.append(gde.getGeTemp10());
						sb.append("|");
						sb.append(gde.getGeTemp11());
						sb.append("|");
						sb.append(gde.getGeTemp12());
						sb.append("|");
						sb.append(gde.getGeTemp13());
						sb.append("|");
						sb.append(gde.getGeTemp14());
						sb.append("|");
						sb.append(gde.getGeTemp15());
						break;//只得到第一条数据
					}
					String dict_attr_str = sb.toString();
					
					String[] ge_temp = dict_attr_str.split("\\|");
					logger.info("ge_temp.length="+ge_temp.length);
					int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
					for(int j=0;j<ge_temp.length;j++){
						if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
							logger.info("为空不处理");
						}else{
							//alert("ge_temp["+j+"]="+ge_temp[j]);
							String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
							logger.info("str2.length="+str2.length);
							logger.info("str2="+ge_temp[j]);
							
							if(str2.length != 6){//去掉不规范数据
								logger.info("数据不规范");
							}else{
								
								String tag =str2[0];
								
								String label = str2[1];
								String tips  = str2[2];
								String keystr  = str2[3];
								String valuestr  = str2[4];
								String specflag  = str2[5];
								
								//logger.info("第"+j+"轮,tag="+tag);
								//logger.info("第"+j+"轮,label="+label);
								//logger.info("第"+j+"轮,keystr="+keystr);
								//logger.info("第"+j+"轮,valuestr="+valuestr);
								//logger.info("第"+j+"轮,specflag="+specflag);
								String tagid = "";//标签的id值
								String tagname = "";//标签的name值
								if(tag.equals("1")){//文本框
									//文本框
									//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
									tagid = "input"+j;
									tagname = "input"+j; 
									//这里keystr 在文本框中默认是1 不需要填入
									String[] str3_value = valuestr.split("-");
									String inputstr = "";
									if(attr_map.containsKey(label)){
										String[]  ss = {label,attr_map.get(label)[3]};
										attributMap.put(j,ss );
									}
								}else if(tag.equals("2")){//下拉框
									tagid = "select"+j;
									tagname = "select"+j;
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									//logger.info(str3_key.length+"----"+str3_value.length);
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("下拉框中的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									String optkey = "";
									if(attr_map.containsKey(label)){
										optkey = attr_map.get(label)[3];
										for(int i=0;i<str3_key.length;i++){//
											if(optkey.equals(str3_key[i])){
												String[]  ss = {label,str3_value[i]};
												attributMap.put(j,ss );
											}
										}
										
									}
								}else if(tag.equals("3")){//多选框
									//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
									tagid = "checkbox"+j;
									tagname = "checkbox"+j;
									
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("多选框的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									if(specflag.trim().equals("0")){
										String checkkeys = "";
										String ckvaluestr = "";
										if(attr_map.containsKey(label)){
											checkkeys = attr_map.get(label)[3];
											String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
											
											for(int i=0;i<str3_key.length;i++){
												String ckstr = "";//定义一个变量 是否选中
												for (int k = 0; k < checkkey.length; k++) {
													if(checkkey[k].equals(str3_key[i])){
														ckstr="checked='checked'";
														ckvaluestr += str3_value[i]+",";
														break;
													}//满足条件 选中 并推出当前循环
												}
											}
										}
										if(ckvaluestr.equals("")){
											ckvaluestr = "无";
										}else{
											ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
										}
										
										String[]  ss = {label,ckvaluestr};
										attributMap.put(j,ss );
										
									}else if(specflag.trim().equals("1")){
//										保存的规格字符串
//										1,1,500,6,测试1,1_1|1,3,750,6,测试4,1_3|2,1,400,6,测试2,2_1|2,3,700,6,测试5,2_3|4,1,500,6,测试3,4_1|4,3,750,6,测试6,4_3|
										if(specstr  == null || specstr.trim().equals("")){
											logger.info("商品中未配置规格");
										}else{
											String[] specarra = specstr.split("\\|");
										}
										
										
										if(specnum == 0){//第一个规格属性
											for(int i=0;i<str3_key.length;i++){
												first_spec_str += str3_key[i]+"-"+str3_value[i]+"-"+tagname+"-"+",";
											}
											if(first_spec_str !="") first_spec_str = first_spec_str.substring(0,first_spec_str.length()-1);//去掉最后一个,
											specnum +=1;
										}else if(specnum == 1){//第二个规格属性
											for(int i=0;i<str3_key.length;i++){
												second_spec_str +=str3_key[i]+"-"+str3_value[i]+"-"+tagname+",";
											}
											
											if(second_spec_str !="") second_spec_str = second_spec_str.substring(0,second_spec_str.length()-1);//去掉最后一个,
											specnum +=1;
										}else if(specnum == 2){//超过2个规格属性
											logger.info("规格属性的数量已经达到2个，只取前2个");
										}else{//规格属性的值混乱 
											logger.info("规格数量标识错误");
										}
									}else{//规格鉴别标识错误
										logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
									}
								}else if(tag.equals("4")){//单选框
									tagid = "radio"+j;
									tagname = "radio"+j;
									//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("多选框的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									String radiokey = "";
									
									if(attr_map.containsKey(label)){
										radiokey = attr_map.get(label)[3];
										for(int i=0;i<str3_key.length;i++){
											String ckstr = "";
											if(radiokey.equals(str3_key[i])){
												ckstr = "checked";
												String[]  ss = {label,str3_value[i]};
												attributMap.put(j,ss );
											}
										}
									}
								}else{
									logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
								}
							}
						}
					}
				}
			   
	       request.setAttribute("getpropertys",attributMap);
	       
		  if(twhere!=""){
			  
			  return "productpage";
		  }else{
			  
			  return "litscloudgetprodut";
		  }
		  
		  
	}
	/**
	 * 立云客户确认购买页面  生成定单，并生成定单商品外键关系  2013-4-2 防止重复提交
	 * @return
	 */
	public String litscloudcreatorder(){
		Customer customer=null;
		if(request.getSession().getAttribute("customer")!=null){
		 customer=(Customer)request.getSession().getAttribute("customer");
		// 生成一个订单号
		}else{
			
		return	"relogin";
		}
		String sgid = request.getParameter("sgid");
		String sgcode = request.getParameter("sgcode");
		String specstr = request.getParameter("specstr");//所选规格
		String mountstr =  request.getParameter("shuliang");//数量
		String permoneystr =  request.getParameter("permoney");//所选规格对应的价格
		
		int mount = Integer.parseInt(mountstr);
		int permoney = Integer.parseInt(permoneystr);
		
		SimpleDateFormat sm = new SimpleDateFormat("yyyyMMddHHmmss");
		String sgorderNum = "sg-";
		sgorderNum += sm.format(new Date());
		Random rd = new Random();
		int num = (int) (rd.nextDouble() * 10000);
		sgorderNum += num;

		logger.info("订单号：+++" + sgorderNum);
		request.setAttribute("sgnum", sgorderNum);
	   
		Sale_orders so=new Sale_orders();
		so.setCustomer(customer);
		so.setSoNums(sgorderNum);
//		so.setSoStat(1);
		so.setSoStat(0);//暂定为0状态
		so.setSoOrderTime(DateUtil.getDateNow("yyyy-mm-dd HH:MM"));
		so.setPrices(mount*permoney);
		so.setSpec(specstr);
		csbiz.save(so);
		String sql="From Sale_orders where soNums='"+sgorderNum+"'";
		List l1=salsBuness.getOrdersDate(sql);
		List<Sale_orders> l2=l1;
		Sale_orders lo=l2.get(0);
		
		String hql="From Sale_goods where sgid='"+sgid+"'";
		List l3=salsBuness.getOrdersDate(hql);
		List<Sale_goods> l4=l3;
		Sale_goods lo1=l4.get(0);

	    request.setAttribute("price", mount*permoney);
	
	
		//购买的商品数量
		int sgnum = 1;//下次获取数量时变更
	    //request.setAttribute("price", lo1.getSgPrice()*lo1.getSgnumbers());
		if(request.getParameter("amoney")!=null){
			
			request.setAttribute("price", request.getParameter("amoney"));
		  }else{
		    request.setAttribute("price", mount*permoney);
		  }
		String sql0="insert into  salegoods_mids(so_id,sg_id,so_orderNumber) values("+lo.getSoId()+","+lo1.getSgId()+","+sgnum+")";

		csbiz.addsql(sql0);
		
		//获取时间
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
		String str_date1 = formatter.format(currentTime); //将日期时间格式化 
		//request.setAttribute("sNum",sgorderNum);//这个和sgnum值一样
		//流程通用通用方法(定单状态---生成定单，待付款-定单号，生成时间，
		CurrencyProcess cp=new CurrencyProcess();
		cp.setPname("已审核待客户付款");//对应流程名字
		cp.setPnum(sgorderNum);//对应定单名字
		cp.setPstat(1);//对应定单状态
		cp.setBegintime(str_date1);
		csbiz.save(cp);
		return "addoeder";
	}
	
	/**
	 * 立云客户确认购买页面  生成定单，并生成定单商品外键关系  2013-4-2 防止重复提交
	 * @return
	 */
	public String buildorder(){
		Customer customer=null;
		if(request.getSession().getAttribute("customer")!=null){
		 customer=(Customer)request.getSession().getAttribute("customer");
		// 生成一个订单号
		}else{
			
		return	"relogin";
		}
		String sgid = request.getParameter("sgid");
		String sgcode = request.getParameter("sgcode");
		String specstr = request.getParameter("spec_checkstr");//所选规格
		String mountstr =  request.getParameter("shuliang");//数量
		String permoneystr =  request.getParameter("permoney");//所选规格对应的价格
		
		int mount = Integer.parseInt(mountstr);
		double permoney = Double.parseDouble(permoneystr);
		
		SimpleDateFormat sm = new SimpleDateFormat("yyyyMMddHHmmss");
		String sgorderNum = "sg-";
		sgorderNum += sm.format(new Date());
		Random rd = new Random();
		int num = (int) (rd.nextDouble() * 10000);
		sgorderNum += num;

		logger.info("订单号：+++" + sgorderNum);
		request.setAttribute("sgnum", sgorderNum);
	   
		Sale_orders so=new Sale_orders();
		so.setCustomer(customer);
		so.setSoNums(sgorderNum);
//		so.setSoStat(1);
		
		so.setSoStat(0);//暂定为0状态
		//Cookie[] ck = request.getCookies();
		
		Sale_goods  goods = (Sale_goods)salsBuness.getObj(Sale_goods.class, sgid);
		if(goods.getSgchecks().equals("0"))
		{
			so.setSoStat(1);//实物订单 不是上架类型
		}else
		{
			so.setSoStat(0);//上架类型
//			String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='XXTXSDD'";
//			List list = salsBuness.getList(hql);
//			//添加审批
//			Cookies ck = new Cookies();	
//			int marker = product_CommentService.addAuditingOrder2("XXTXSDD",so.getSoNums(), "Sale_orders", ck.getCookie(request, "filialemark"));
			
		}
		so.setIsDelivery(goods.getIsDelivery());//是否需要发货
		
		
		so.setSoOrderTime(DateUtil.getDateNow("yyyy-mm-dd HH:MM"));
		//so.setPrices(mount*permoney);
		permoney = goods.getSgPrice();
		so.setSgPrice(permoney);
		
		so.setSpec(specstr);
		so.setCount(new Integer(mount));
//		csbiz.save(so);//只做保存到对象中不写入数据库
		
//		String sql="From Sale_orders where soNums='"+sgorderNum+"'";
//		List l1=salsBuness.getOrdersDate(sql);
//		List<Sale_orders> l2=l1;
//		Sale_orders lo=l2.get(0);
//		
//		String hql="From Sale_goods where sgId='"+sgid+"'";
//		List l3=salsBuness.getOrdersDate(hql);
//		List<Sale_goods> l4=l3;
//		Sale_goods lo1=l4.get(0);

	    	
		//购买的商品数量
		int sgnum = mount;//下次获取数量时变更
	    //request.setAttribute("price", lo1.getSgPrice()*lo1.getSgnumbers());
		if(request.getParameter("amoney")!=null){
			
			request.setAttribute("price", request.getParameter("amoney"));
		  }else{
		    request.setAttribute("price", mount*permoney);
		  }
//		String sql0="insert into  salegoods_mids(so_id,sg_id,so_orderNumber) values("+lo.getSoId()+","+lo1.getSgId()+","+sgnum+")";
//		csbiz.addsql(sql0);
		
		//得到地址
		String confidion = " and customer.customerId =" +customer.getCustomerId();
//		String confidion = " and customer.customerId =" +1077;
		
		List listda = csbiz.getList("DeliveryAddress", confidion);
		
		
		
		request.setAttribute("permoney", permoney);
		request.setAttribute("sgcode",sgcode );
		request.setAttribute("sgid",sgid );
		request.setAttribute("totalprice", mount*permoney);
		request.setAttribute("mount", mount);
		
		request.setAttribute("so", so);
		request.setAttribute("deliverylist", listda);
		
		
		
		
		
		
		//获取时间
		return "to_sure_address";
	}
	public String saveorder(){
		
		Customer customer=null;
		if(request.getSession().getAttribute("customer")!=null){
		 customer=(Customer)request.getSession().getAttribute("customer");
		}else{
			return	"relogin";
		}
		String sgid = request.getParameter("sgid");
		String sgcode = request.getParameter("sgcode");
		String specstr = request.getParameter("spec_checkstr");//所选规格
		String mountstr =  request.getParameter("sgcount");//数量
		String permoneystr =  request.getParameter("permoney");//所选规格对应的价格
		
		String delivery_address =  request.getParameter("delivery_address");//快递地址
		String socode =  request.getParameter("socode");//订单号
		String delivery_price =  request.getParameter("delivery_price");//快递方式
		String delivery_type =  request.getParameter("delivery_type");//快递方式
		String leave_msg =  request.getParameter("leave_msg");//卖家留言
		
		//String socode =  request.getParameter("socode");//订单号
		
		int mount = Integer.parseInt(mountstr);
		double permoney = Double.parseDouble(permoneystr);
		
		String sgorderNum = "";
		sgorderNum = socode;

		logger.info("订单号：+++" + sgorderNum);
		request.setAttribute("sgnum", sgorderNum);
	   
		Sale_orders so=new Sale_orders();
		so.setCustomer(customer);
		so.setSoNums(sgorderNum);
//		so.setSoStat(1);
		
		//so.setSoStat(0);//暂定为0状态
		Sale_goods  goods = (Sale_goods)salsBuness.getObj(Sale_goods.class, sgid);
		if("0".equals(goods.getSgchecks()))
		{
			so.setSoStat(1);//实物订单 不是上架类型
		}else
		{
//			so.setSoStat(0);//上架类型 
			so.setSoStat(1);//上架类型 2013-07-31 变更为前台用户提交设置状态为是审核通过 代付款
			String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='XXTXSDD'";
			List list = salsBuness.getList(hql);
			//添加审批
			Cookies ck = new Cookies();	
			int marker = product_CommentService.addAuditingOrder2("XXTXSDD",so.getSoNums(), "Sale_orders", ck.getCookie(request, "filialemark"));
			
		}
		so.setIsDelivery(goods.getIsDelivery());//是否需要发货
		if(so.getIsDelivery() !=null && so.getIsDelivery() == 1){//暂时定为卖家包邮
			so.setDevilvprice(new Double(delivery_price));
			so.setSgDelivtype(delivery_type);
			so.setSgAddress(delivery_address);
		}
		
		so.setSoOrderTime(DateUtil.getDateNow("yyyy-mm-dd HH:MM"));
		
		so.setSgPrice(permoney);
		double  allmoney = mount*permoney + new Double(delivery_price);
		so.setPrices(allmoney);
		so.setSpec(specstr);
		so.setCount(new Integer(mount));
		so.setDivsg(leave_msg);
		so.setSoCheckStat(0);
		csbiz.save(so);//
		
		String sql="From Sale_orders where soNums='"+sgorderNum+"'";
		List l1=salsBuness.getOrdersDate(sql);
		List<Sale_orders> l2=l1;
		Sale_orders lo=l2.get(0);
//		
//		String hql="From Sale_goods where sgId='"+sgid+"'";
//		List l3=salsBuness.getOrdersDate(hql);
//		List<Sale_goods> l4=l3;
//		Sale_goods lo1=l4.get(0);

	    	
		//购买的商品数量
		int sgnum = mount;//下次获取数量时变更
	    //request.setAttribute("price", lo1.getSgPrice()*lo1.getSgnumbers());
		if(request.getParameter("amoney")!=null){
			
			request.setAttribute("price", request.getParameter("amoney"));
		  }else{
		    request.setAttribute("price", allmoney);
		  }
		String sql0="insert into  salegoods_mids(so_id,sg_id,so_orderNumber) values("+lo.getSoId()+","+goods.getSgId()+","+sgnum+")";
		csbiz.addsql(sql0);//保存中间表
		
		return "addoeder";
	}
	public String ucenter(){
	
		Customer c = (Customer)request.getSession().getAttribute("customer");
		String ip = (String)request.getSession().getAttribute("ipaddress");
		if(c == null){
			return "customer_no_session";
		}
		List<String> custList = csbiz.selcust(c.getCustomerName(), ip);
		float moneyInteger = 0;
		for (int i = 0; i < custList.size(); i++) {
			String string = custList.get(i);
			moneyInteger = moneyInteger + Float.parseFloat(string);
		}
		request.getSession().setAttribute("money", moneyInteger);
		// 判断是否是正式客户如果是进入首页，点击订单详情如果不是条跳转到填写详细信息的页面
	

		String hql = hql = "from ConkOut c where c.delflag = 0 and c.state=4 and c.customer.customerId = "
				+ customer.getCustomerId() + " order by id desc";
		int pageNo = 1;
		Pages pages = csbiz.get(hql, pageNo, 10, null);

		if (null != pages.getPageList() && pages.getPageList().size() > 0) {

			request.setAttribute("pages", pages);

			request.setAttribute("mark", pages.getPageList().size());

			return "lits_ucenter";

		} else

			return "lits_ucenter";
	}
	/**
	 * 用户退出
	 * @return
	 */
	public String litscloudUserLogout() {

		if (null != request.getSession().getAttribute("customer")) {
			System.out.println("22222");
			request.getSession().removeAttribute("customer");
		}
		if (null != request.getSession().getAttribute("loginname")) {
			System.out.println("loginname");
			request.getSession().removeAttribute("loginname");
		}
		return "logout_success";
	}
	
	/**
	 * 客户注册
	 */
	public String customerRegister() {

		// 获取登录输入验证码
		String valuecode = request.getParameter("user_code");
		// 获取验证码与登录验证码进行比对
		String code = (String) request.getSession().getAttribute("code");
		// 如果两个验证码不匹配则返回到登录页面并给出提示
		if (valuecode == null || !valuecode.equals(code)) {
			request.setAttribute("errorMsg", "验证码错误！");
			return "registererror";
		}

		String userfrom = request.getParameter("user_from");
		String userfrom2 = request.getParameter("user_from2");
		String usernotes = request.getParameter("user_notes");
		System.out.println(customer.getCustomerName() + "   user_code : "
				+ valuecode + "  code : " + code);
		boolean flag = false;
		Customer c = null;
		String result = "registererror";
		if (customer != null) {
			customer.setUserFrom(userfrom);
			customer.setUserFrom2(userfrom2);
			customer.setUserNotes(usernotes);
			customer.setDel("0");
			customer.setIsLoginAccount(2);
			customer.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new Date()));
			customer.setIssetmibao(0 + "");
			c = csbiz.addCustomer(customer);
			System.out.println("客户密码：" + c.getCustomerPassword());
			if (c.getCustomerId() > 0) {
				// 成功分配跟单人员

				flag = true;
			}
		}
		System.out.println("flag : " + c.getCustomerId());
		if (flag) {
			String uri = geturl(); // 项目路径
			String url = uri + "/customerIsActiveCustomerServer.Action?id="
					+ c.getCustomerId() + "&isActive=1";
			String urltext = uri + "/customService/registerCustomer?id="
					+ c.getCustomerId();
			System.out.println("url : " + url);
			String msg = "亲爱的"
					+ customer.getCustomerName()
					+ ": <br/><br/>欢迎加入立云！<br/><br/>请点击下面的链接完成注册：<br/><br/><A href= "
					+ url
					+ ">"
					+ urltext
					+ "</A>"
					+ "<br/><br/>如果以上链接无法点击，请将上面的地址复制到你的浏览器(如IE)的地址栏进入立云。<br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
			Email sendemail = new Email();

			sendemail.sendEmail(customer.getEmail(),
					"立云客服系统用户注册--请激活你的帐号，完成注册", msg);

			result = "registersuccess";
			request.setAttribute("registerActiveMessage", "请登录您的邮箱激活账户");
		}
		return result;
	}

	public String customerRegister1() {

		// 获取登录输入验证码
		

		String userfrom = request.getParameter("user_from");
		String userfrom2 = request.getParameter("user_from2");
		String usernotes = request.getParameter("user_notes");
		
		boolean flag = false;
		Customer c = null;
		String result = "registererror";
		if (customer != null) {
			customer.setUserFrom(userfrom);
			customer.setUserFrom2(userfrom2);
			customer.setUserNotes(usernotes);
			customer.setIsLoginAccount(2);
			customer.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new Date()));
			customer.setIssetmibao(0 + "");
			customer.setDel("0");
			c = csbiz.addCustomer(customer);
			System.out.println("客户密码：" + c.getCustomerPassword());
			if (c.getCustomerId() > 0) {
				// 成功分配跟单人员

				flag = true;
			}
		}
		request.getSession().setAttribute("customer", c);
		
		return "zhuCeYanZheng";
	}
	public String geturl() {
		String scheme = request.getScheme(); // http
		String servername = request.getServerName(); // ip
		int port = request.getServerPort(); // port
		String path = request.getServletPath(); // uri
		String name = request.getSession().getServletContext().getRealPath("/"); // tomcat
																					// 项目路径
		String objectname = "";
		int webapps = name.indexOf("webapps");
		int htdocs = name.indexOf("htdocs");
		if (webapps > 0) {
			objectname = name.substring(webapps + 8, name.length() - 1);
		}
		if (htdocs > 0) {
			objectname = name.substring(htdocs + 7, name.length() - 1);
		}
		System.out.println(scheme + "://" + servername + ":" + port + "/"
				+ objectname + path);
		logger.info("注册路径     name ：" + name);
		logger.info("注册路径     objectname ：" + objectname);
		logger.info("注册路径：" + scheme + "://" + servername + ":" + port + "/"
				+ objectname);

		return scheme + "://" + servername + ":" + port + "/" + objectname;
	}

	/**
	 * 激活注册
	 */
	public String customerIsActive() {
		String id = request.getParameter("id");
		String isActive = request.getParameter("isActive");
		System.out.println(id + "  ==  " + isActive);
		Customer c = csbiz.getcustomer(Integer.parseInt(id));
		String result = "registererror";
		String msg = "您已经成功激活注册账户，请登录！";
		if (c != null) {
			System.out.println("loginAccount : " + c.getIsLoginAccount());
			if (c.getIsLoginAccount() == 3) {
				request.getSession()
						.setAttribute("activeid", c.getCustomerId());
				System.out.println(" id ******* : " + c.getCustomerId());
				result = "centeremail";
			}
			if (c.getIsLoginAccount() == 1) {
				msg = "您已经重置修改过密码了，链接已失效，请重新申请修改密码！";
				System.out.println("msg : " + msg);
				request.setAttribute("registerActiveMessage", msg);
				result = "registersuccess";
			}
			if (c.getIsLoginAccount() == 2) {
				c.setIsLoginAccount(1);
				boolean flag = csbiz.updateCustomer(c);
				if (flag) {
					result = "registersuccess";
					msg = "您已成功注册了，请到您的注册邮箱激活注册账号！<br/>为了您的账户安全，<br/>请登录后去个人资料完善您的其他密保设置。";
					request.setAttribute("registerActiveMessage", msg);
				}
			}
		}
		return result;
	}
   public void checkEmployeeNums(){
	   String mpsString = request.getParameter("nums");
	   String massage="";
	   logger.info("nums="+mpsString);
	   List<Employee> ltsList=csbiz.getList("Employee"," and empNo='"+mpsString+"'");
	   if(ltsList.size()>0){
		   massage="ok";
	   }else{
		   massage="not";
	   }
	   response.setContentType("text/html;charset=GBK");
	   try {
		response.getWriter().write(massage);
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
   }
	/**
	 * 修改个人资料
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String editPersionData() {
		//String Contact_Type = request.getParameter("Contact_Type");
		//String u_password2 = request.getParameter("u_password2");
		System.out.println("u_password2  " + custBean.getCustomerPassword()+ "    "
				+ custBean.getCustomerId() + "  pinyin:   "
				+ custBean.getRealNamePinyin() + "  type : " + Contact_Type+"");
//		if(Contact_Type.equals("1")){
//			Map paraMap=(Map) request.getSession().getAttribute("sczj");
//			Iterator it = paraMap.entrySet().iterator(); 
//			String license=null;
//			while (it.hasNext()){ 
//			Map.Entry pairs = (Map.Entry)it.next(); 
//			 license=(String) pairs.getValue();
//			}			
//		}
		String result = "editerror";		
		if (custBean.getCustomerId() > 0) {
			Customer c = csbiz.getcustomer(custBean.getCustomerId());
			if (!custBean.getCustomerPassword().equals("") && custBean.getCustomerPassword() != null) {
				System.out.println("UU : " + custBean.getCustomerPassword());
				c.setCustomerPassword(custBean.getCustomerPassword());
			}
			
			if(Contact_Type.equals("1")){
//				Map paraMap=(Map) request.getSession().getAttribute("sczj");
//				if(paraMap!=null){			
//				Iterator it = paraMap.entrySet().iterator(); 
//				String license=null;
//				while (it.hasNext()){ 
//				Map.Entry pairs = (Map.Entry)it.next(); 
//				 license=(String) pairs.getValue();
//				}	
//				c.setLicense(license);
//				}
//				request.getSession().removeAttribute("sczj");
				  
				  String license=(String) request.getSession().getAttribute("sczj1");
					if(license!=null){			
						c.setLicense(license);
				}
			}
			
			if(Contact_Type.equals("0")){

				String cardPhoto=(String) request.getSession().getAttribute("sczj1");
				if(cardPhoto!=null){			
					c.setCardPhoto(cardPhoto);
			}
				request.getSession().removeAttribute("sczj1");
			}
			
			c.setCustomerCompany(custBean.getCustomerCompany());
			c.setCustomerType2(3+"");
			c.setCustomerCompanyYw(custBean.getCustomerCompanyYw());
			c.setRealName(custBean.getRealName());
			c.setCusClass(Contact_Type);
			c.setRealNamePinyin(custBean.getRealNamePinyin());
			if (!"国家".equals(custBean.getCustomerCountry()))
				c.setCustomerCountry(custBean.getCustomerCountry());
			if (!"省份、州".equals(custBean.getCustomerProvince()))
				c.setCustomerProvince(custBean.getCustomerProvince());
			if (!"地级市、县".equals(custBean.getCustomerCity()))
				c.setCustomerCity(custBean.getCustomerCity());
			c.setPhone(custBean.getPhone());
			c.setMobilePhone(custBean.getMobilePhone());
			c.setQq(custBean.getQq());
			c.setEmail(custBean.getEmail());
			c.setCustomerAddress(custBean.getCustomerAddress());
			c.setAddressYw(custBean.getAddressYw());
			c.setFacsimile(custBean.getFacsimile());
			c.setBusinesslinkpersion(custBean.getBusinesslinkpersion());
			c.setZipCode(custBean.getZipCode());
			c.setDobusinesscode(custBean.getDobusinesscode());
			c.setUserNotes(custBean.getUserNotes());
			c.setCardid(custBean.getCardid());
			logger.info("businesslinkpersion="+custBean.getBusinesslinkpersion());
			List<Employee> lis=csbiz.getList("Employee"," and empNo='"+custBean.getBusinesslinkpersion()+"'");
			for (Employee employee : lis) {
				c.setEmployee(employee);
			}
			boolean flag = csbiz.updateCustomer(c);
			if (flag) {
				request.getSession().setAttribute("customer", c);
				result = "editdata";
			}
		}
		return result;
	}

	/**
	 * 修改密码
	 * 
	 * @return
	 */
	public String editpassword() {
		String id = request.getParameter("id");
		String result = "emailerror";
		
		System.out.println("ssss : " + customer.getCustomerId());
		Customer c = csbiz.getcustomer(customer.getCustomerId());
		if (customer.getCustomerId() > 0) {
			c.setCustomerPassword(customer.getCustomerPassword());
			c.setIsLoginAccount(1);
			boolean flag = csbiz.updateCustomer(c);
			if (flag) {
				result = "editpassowrd";
			}
		}
		return result;
	}

	/**
	 * 修改密码14030
	 * @return
	 * @throws IOException 
	 */
	public void checkpass() throws IOException{
		
		int passok=1;
		String logininame=(String) request.getSession().getAttribute("loginname");
		String newpass1=	request.getParameter("newpass1");
		String password=	request.getParameter("password");
		Customer customer = csbiz.customerLogin(logininame, password);
		if(customer==null){
			response.getWriter().print(passok);
		}else{
	      boolean  ok=csbiz.checkpassword(newpass1,logininame);
		if(!ok){
			response.getWriter().print(passok);
		}else{
			passok=2;
			response.getWriter().print(passok);
		}
		}
	
	}
	
	public String addAddress(){
		String loginname=(String) request.getSession().getAttribute("loginname");
		System.out.println(loginname);
		Customer cus=csbiz.getCustomid(loginname);
		System.out.println(cus.getCustomerId());
		String phones=request.getParameter("phones");//座机
		String netherlands=request.getParameter("netherlands");//地区名
		String consignee=request.getParameter("consignee");//收信人
		String particularAddress=request.getParameter("particularAddress");//详细地址
		String postalcode=request.getParameter("postalcode");//邮编
		String mobile=request.getParameter("mobile");
		System.out.println(phones+netherlands+consignee+particularAddress+postalcode+mobile);
		DeliveryAddress deli=new DeliveryAddress();
		
		deli.setPhones(phones);
		deli.setNetherlands(netherlands);
		deli.setConsignee(consignee);
		deli.setParticularAddress(particularAddress);
		deli.setPostalcode(postalcode);
		deli.setMobile(mobile);
		deli.setCustomer(cus);		
	   boolean flag=csbiz.addAddress(deli);
	   if(flag){
		   System.out.println("添加成功");
	   }else{
		   System.out.println("添加失败");
		   
	   }
		return "address";
	}
	public String uplateAddress(){
		String loginname=(String) request.getSession().getAttribute("loginname");
		System.out.println(loginname);
		Customer cus=csbiz.getCustomid(loginname);
		System.out.println(cus.getCustomerId());
		
		String id=request.getParameter("id");
		
		String phones=request.getParameter("phones");//座机
		String netherlands=request.getParameter("netherlands");//地区名
		String consignee=request.getParameter("consignee");//收信人
		String particularAddress=request.getParameter("particularAddress");//详细地址
		String postalcode=request.getParameter("postalcode");//邮编
		String mobile=request.getParameter("mobile");
		System.out.println(phones+netherlands+consignee+particularAddress+postalcode+mobile);

		DeliveryAddress deli= csbiz.getDaliver(id);
		System.out.println(deli.getAddressId());
		deli.setPhones(phones);
		deli.setNetherlands(netherlands);
		deli.setConsignee(consignee);
		deli.setParticularAddress(particularAddress);
		deli.setPostalcode(postalcode);
		deli.setMobile(mobile);
		deli.setCustomer(cus);
		boolean b=csbiz.updateAddress(deli);
		
		if(b){
			System.out.println("添加成功");
		}
		return "updateaddr";
	}
	
	
	
	
	//查询用户地址
	public String checkAddress(){
		String loginname=(String) request.getSession().getAttribute("loginname");
		Customer cus=csbiz.getCustomid(loginname);
           dal=csbiz.getAddress(cus);
           count=dal.size();
           if(count==0){
        	   System.out.println(count);
        	   return "emptyaddress";
           }
           
           DeliveryAddress d=null;
           for (int i = 0; i < dal.size(); i++) {
			 d=dal.get(0);
		}
           
           int id1=d.getAddressId();
           String id=id1+"";
           deli=csbiz.getDaliver(id);
		return "showaddress";
	}

	public String useAddress(){
		String id=request.getParameter("id");
		 deli=csbiz.getDaliver(id);
      return  "useAddress";
	}
	
	public String delAddress(){
		String id=request.getParameter("id");
		csbiz.delAddress(id);
		return checkAddress();
	}
	
	
	
	
	/**
	 * 设置密码保护资料
	 * 
	 * @return
	 */
	public String setmibao() {
		String id = request.getParameter("id");
		String questionid = request.getParameter("questionid");
		try {
			String answer = URLDecoder.decode(request.getParameter("answer"),
					"utf-8");
			System.out.println(id + "   :  " + questionid + "  =  " + answer);

			// 获取登录输入验证码
			String valuecode = request.getParameter("valuecode");
			// 获取验证码与登录验证码进行比对
			String code = (String) request.getSession().getAttribute("code");
			// 如果两个验证码不匹配则返回到登录页面并给出提示
			if (valuecode == null || !valuecode.equals(code)) {
				System.out.println("1111");
				request.setAttribute("errorMsg", "验证码错误，请重新填写！");
				response.getOutputStream().print("2");
			} else {
				boolean flag = false;
				Customer c = csbiz.getcustomer(Integer.parseInt(id));
				if (c != null) {
					c.setQuestionid(questionid);
					c.setAnswervalue(answer);
					c.setIssetmibao(1 + "");
					flag = csbiz.updateCustomer(c);
				}
				if (flag) {
					response.getOutputStream().print("1");
				} else {
					response.getOutputStream().print("0");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 邮件方式取回密码
	 * 
	 * @return
	 */
	public String getbackPasswordByEmail() {
		response.setContentType("text/html;charset=GBK");

		// 获取登录输入验证码
		String valuecode = request.getParameter("valuecode");
		// 获取验证码与登录验证码进行比对
		String code = (String) request.getSession().getAttribute("code");

		try {

			// 如果两个验证码不匹配则返回到登录页面并给出提示
			if (valuecode == null || !valuecode.equals(code)) {
				System.out.println("1111");
				request.setAttribute("errorMsg", "验证码错误，请重新填写！");
				return "emailerror";
			}
			List<Customer> list = (List<Customer>) csbiz.getList("Customer",
					" and customerName = '" + customer.getCustomerName()
							+ "' and cardid = '" + customer.getCardid() + "'");
			if (list.size() == 0) {
				request.setAttribute("errorMsg", "用户名称或者身份证号错误，请重新填写！");
				return "emailerror";
			} else {
				boolean flag = false;
				Customer c = (Customer) list.get(0);
				if (c.getIssetmibao().equals("1")) {
					if (!c.getQuestionid().equals(customer.getQuestionid())) {
						request.setAttribute("errorMsg", "安全问题不对，请重新选！");
						return "emailerror";
					}
					if (c.getQuestionid().equals(customer.getQuestionid())
							&& !c.getAnswervalue().equals(
									customer.getAnswervalue())) {
						request.setAttribute("errorMsg", "安全问题回答不对，请重新填写！");
						return "emailerror";
					}
					if (c.getQuestionid().equals(customer.getQuestionid())
							&& c.getAnswervalue().equals(
									customer.getAnswervalue())) {
						c.setIsLoginAccount(3);
						flag = csbiz.updateCustomer(c);
					}

					if (flag) {

						String uri = geturl();
						String url = uri
								+ "/customerIsActiveCustomerServer.Action?id="
								+ c.getCustomerId() + "&isActive=1";
						String urltext = uri
								+ "/customService/getPasswordByEmail?id="
								+ c.getCustomerId();
						System.out.println("url : " + url);
						String msg = "亲爱的"
								+ c.getCustomerName()
								+ ": <br/><br/>欢迎使用立云邮件方式取回密码功能！<br/><br/>请点击以下链接重置您的密码：<br/><br/><A href= "
								+ url
								+ ">"
								+ url
								+ "</A>"
								+ "<br/><br/>如果您没有申请找回密码，请忽略此邮件。<br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
						Email sendemail = new Email();
						sendemail.sendEmail(c.getEmail(), "立云客服系统--邮件方式取回密码",
								msg);
						request.getSession().setAttribute("customeremail",
								c.getEmail());
						return "emailsuccess";
					} else {
						return "emailerror";
					}
				} else {
					request.setAttribute("errorMsg",
							"对不起，您没有设置密保资料，请尝试短信取回密码功能！");
					return "emailerror";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取客户的产品列表(客户登陆)
	 * 
	 * @throws IOException
	 * 
	 */
	public String getorderlist() throws IOException {

		String typeId = request.getParameter("typeId");

		Customer customer = (Customer) request.getSession().getAttribute(
				"customer");
		if (null == customer) {
			response.getWriter().print(0);
			return null;
		} else {
			StringBuffer str = new StringBuffer();

			// 根据客户登录名与客户选项的业务类型 查找客户订单列表
			List list = csbiz.getorder(typeId, customer.getCustomerId());

			// 如果订单列表不问NULL
			if (null != list && list.size() > 0) {

				// 循环订单列表
				for (int i = 0; i < list.size(); i++) {
					// 将订单列表转换成订单对象
					SaleOrder so = (SaleOrder) list.get(i);

					// 定义set对象 用于接收订单中的 上架单对象
					Set<UpServer> set = so.getUpServers();

					// 将订单中的上架单对象取出

					// 循环订单中的上架单
					for (UpServer obj : set) {

						if (obj instanceof UpServer) {

							// 转换成上架单对象
							UpServer upServer = obj;
							String ips = upServer.getServerIp();
							if (ips != null) {
								ips = ips.replace("，", ",");
							} else {
								ips = upServer.getServerIp();
							}
							// 将上架单中的IP号取出组成字符串传到页面
							if (null != ips && ips != ""
									&& ips.indexOf(",") > 0) {
								String[] ip = ips.split(",");
								for (int j = 0; j < ip.length; j++) {
									str.append("<option value='"
											+ upServer.getProduct().getId()
											+ "'>" + ip[j] + "</option>");

								}
							} else {
								str.append("<option value='"
										+ upServer.getProduct().getId() + "'>"
										+ ips + "</option>");
							}
						}
					}

				}
				response.getWriter().print(str.toString());
				return null;
			} else {
				// 如果订单list为NUll返回1
				response.getWriter().print(1);

				return null;
			}
		}
	}

	/**
	 * 获取客户的产品列表(员工登陆)
	 * 
	 * @throws IOException
	 * 
	 */
	public String getorderlist2() throws IOException {

		response.setContentType("text/html");
		String typeId = request.getParameter("typeId");
		String customerId = request.getParameter("customerId");

		Employee emp = (Employee) request.getSession().getAttribute("emp");
		if (null == emp) {
			response.getWriter().print(0);
			return null;
		} else {
			StringBuffer str = new StringBuffer();

			// 根据客户登录名与客户选项的业务类型 查找客户订单列表
			List list = csbiz.getorder(typeId, Integer.parseInt(customerId));

			// 如果订单列表不问NULL
			if (null != list && list.size() > 0) {

				// 循环订单列表
				for (int i = 0; i < list.size(); i++) {
					// 将订单列表转换成订单对象
					SaleOrder so = (SaleOrder) list.get(i);

					// 定义set对象 用于接收订单中的 上架单对象
					Set<UpServer> set = so.getUpServers();

					// 将订单中的上架单对象取出

					// 循环订单中的上架单
					for (UpServer obj : set) {

						if (obj instanceof UpServer) {

							// 转换成上架单对象
							UpServer upServer = obj;
							Integer serverid = upServer.getProduct().getId();// 服务器id
																				// 将服务器id放到select中
																				// 2012-7-24
							String ips = upServer.getServerIp();
							if (ips != null) {
								ips = ips.replace("，", ",");
							} else {
								ips = upServer.getServerIp();
							}
							// 将上架单中的IP号取出组成字符串传到页面
							if (null != ips && ips != ""
									&& ips.indexOf(",") > 0) {
								String[] ip = ips.split(",");
								for (int j = 0; j < ip.length; j++) {
									str.append("<option value='" + serverid
											+ "#" + ip[j] + "'>" + ip[j]
											+ "</option>");

								}
							} else {
								str.append("<option value='" + serverid + "#"
										+ ips + "'>" + ips + "</option>");
							}
						}
					}

				}
				response.getWriter().print(str.toString());
				return null;
			} else {
				// 如果订单list为NUll返回1
				response.getWriter().print(1);

				return null;
			}
		}
	}

	public Customer getModel() {
		customer = new Customer();
		return customer;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;

	}

	public CustomerServiceBussiness getCsbiz() {
		return csbiz;
	}

	public void setCsbiz(CustomerServiceBussiness csbiz) {
		this.csbiz = csbiz;
	}

	/**
	 * 获取客户端真实IP地址
	 * 
	 * @param request
	 * @return
	 */
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		System.out.println("ip1 = " + ip);
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
			System.out.println("ip2 = " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
			System.out.println("ip3 = " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
			System.out.println("ip4 = " + ip);
		}
		return ip;
	}

	/**
	 * 生成随机数，根据位数
	 * 
	 * @param length
	 * @return
	 */
	public String main(int length) {
		String rad = "0123456789";
		StringBuffer result = new StringBuffer();
		Random rand = new Random();
		for (int i = 0; i < length; i++) {
			int randNum = rand.nextInt(10);
			result.append(rad.substring(randNum, randNum + 1));
		}
		return result.toString();
	}

	public static void main(String[] args) {
		// Date d = new Date();
		// java.text.SimpleDateFormat dateFormat = new
		// java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss ");
		// dateFormat.format(d);
		// String name = "/data0/htdocs/FAJxc/";
		// String name1 =
		// "D:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\FAJxc\\";
		// int webapps = name1.indexOf("webapps");
		// int htdocs = name.indexOf("htdocs");
		// if(webapps>0)
		// {
		// System.out.println(name1.substring(webapps+8, name1.length()-1));
		// }
		// if(htdocs>0)
		// {
		// System.out.println(name.substring(htdocs+7, name.length()-1));
		// }
		String ss = "192.168.1.1";
		String[] str = ss.split("#");
		System.out.println(str.length);
		System.out.println(str[0]);
	}

	/**
	 * 查询所有客户对象
	 * 
	 * @return
	 */
	public String all() {
		System.out.println("------------------------");
		List clist = csbiz.getList("Customer", "and del!='1'");
		request.setAttribute("clist", clist);
		System.out.println("跳转");
		return "allcustomer";
	}

	public String exit() {

		if (null != request.getSession().getAttribute("customer")) {
			System.out.println("22222");
			request.getSession().removeAttribute("customer");
		}
		return "error";
	}

	public String checkFiled() {
//		logger.info("checkFiled s");
		boolean flag = false;
		String username = request.getParameter("user_name") == null ? ""
				: request.getParameter("user_name");
		String email = request.getParameter("email") == null ? "" : request
				.getParameter("email");
		String authorization = request.getParameter("authorization") == null ? "" : request
				.getParameter("authorization");
		String user_tel = request.getParameter("user_tel") == null ? ""
				: request.getParameter("user_tel");
		System.out.println("user_tel : " + user_tel);
		String user_qq = request.getParameter("user_qq") == null ? "" : request
				.getParameter("user_qq");
		System.out.println(username + "  1   " + email + "  2  " + "    "
				+ user_tel + "   3  " + user_qq);
//		logger.info("checkFiled 1");
		List list = null;
		if (!username.equals("") && username != null) {
			list = csbiz.getList("Customer", " and customerName = '" + username
					+ "'");
			System.out.println("username size : " + list.size());
			if (list.size() > 0) {
				flag = true;
			}
		}
//		logger.info("checkFiled 2");
		if (!authorization.equals("") && authorization != null) {
			list = csbiz.getList("Customer", " and authorization = '" + authorization
					+ "'");
			System.out.println("authorization size : " + list.size());
			if (list.size() > 0) {
				flag = true;
			}
		}
//		logger.info("checkFiled 3");
		if (!email.equals("") && email != null) {
			list = csbiz.getList("Customer", " and email = '" + email + "'");
			System.out.println("email size : " + list.size());
			if (list.size() > 0) {
				flag = true;
			}
		}
//		logger.info("checkFiled 4");
		if (!user_tel.equals("") && user_tel != null) {
			list = csbiz.getList("Customer", " and mobilePhone = '" + user_tel
					+ "'");
			System.out.println("user_tel size : " + list.size());
			if (list.size() > 0) {
				flag = true;
			}
		}
//		logger.info("checkFiled 5");
		if (!user_qq.equals("") && user_qq != null) {
			list = csbiz.getList("Customer", " and qq = '" + user_qq + "'");
			System.out.println("user_qq size : " + list.size());
			if (list.size() > 0) {
				flag = true;
			}
		}
		logger.info("checkFiled 6");
		try {
			response.setContentType("text/html");
			if (flag) {
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (Exception e) {
			logger.info("字段验证出错");
			e.printStackTrace();
		}
//		logger.info("checkFiled flag="+flag);
//		logger.info("checkFiled e");
		return null;
	}

	/**
	 * 根据条件查询查询客户
	 * 
	 * @return
	 */
	public String selOrder() {

		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String pageNo = request.getParameter("pageNo") != null ? request
				.getParameter("pageNo") : "";
		if (pageNo == "") {
			pageNo = "1";
		}
		request.setAttribute("pageNo", pageNo);
		Customer customer = (Customer) request.getSession().getAttribute(
				"customer");
		int cid = customer.getCustomerId();// 查询到当前客户id
		String hql = "from SaleOrder WHERE delflag=0 and customer.customerId=" + cid;
		int sel = 0;
		try {
			sel = selvar != null ? Integer.parseInt(new String(selvar
					.getBytes("ISO-8859-1"), "UTF-8")) : 0;
		} catch (NumberFormatException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}// 页面下拉列表 的值
		System.out.println(sel);

		String inp = inpvar != "" ? inpvar : "-1";// 选择的条件
		System.out.println(inp);
		String time1 = htStart != "" ? htStart : "-1";
		String timeend = htEnd != "" ? htEnd : "-1";
		if (sel == 4) {
			hql = hql + " and saleOrderNo like '%" + inp + "%'";
		} else if (sel == 1) {
			int i = 0;
			if (inp.equals("1")) {
				i = 1;
			} else {
				i = 0;
			}
			hql = hql + " and isgetorder=" + i;
		} else if (sel == 2) {

			hql = hql + " and beginTime>='" + time1 + "' and endTime<='" + timeend+"'";
		} else if (sel == 3) {

			hql = hql + " and endTime between '" + time1 + "' and '" + timeend +"'";

		}
		System.out.println(hql);
		Pages pages = csbiz.get(hql, Integer.parseInt(pageNo), 2, null);
		List<Object> list = pages.getPageList();
		List<SaleOrder> list1 = (List) list;
		
			request.getSession().setAttribute("orderlist", list1);
	
		System.out.println(list1.size());
		int allCount = pages.getAllCount();
		System.out.println("总条数" + allCount);
		int size = allCount / 2;
		System.out.println(size);
		if (allCount % 2 != 0) {
			size = size + 1;
		}
		int nInteger[] = new int[size];
		List listUP=csbiz.selupserver();
		request.setAttribute("listUP", listUP);
		request.setAttribute("pagenum", nInteger);
		request.setAttribute("pagelist", pages);
		request.setAttribute("pagessize", size);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().print(1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "selorder";
	}

	/**
	 * 确定订单页面
	 */
	public String defineorder() {
		String paratid = request.getParameter("paratid") != null ? request.getParameter("paratid"):"";
				

	
	
	
	   List<SaleOrder>		str = csbiz.selaudState(paratid);
		
		request.setAttribute("paratid", paratid);
        request.setAttribute("str", str);
			return "defineorder";
		
	}

	/**
    *  完成确定修改
    */
   public String    qdorder(){
	  String idString=request.getParameter("id");
	   
	   csbiz.qdorder(idString);
	   
	return selOrder();
   }
   /**
    * 判断是否正是用户
    * @return
    */
   public void checkOrder(){
	   Customer customer = (Customer) request.getSession().getAttribute(
		"customer");
String cid = customer.getCustomerName();
		String iscustomer = csbiz.iscustomer(cid);
	System.out.println(iscustomer);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().print(iscustomer);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   
   }
	public String    qrOrder(){
		  String idString=request.getParameter("id");
		 
		   csbiz.qrorder(idString);
		   
		return selOrder();
		   
	}
	  // 个人信息页面
	public String selgrmessange(){
		   Customer customer = (Customer) request.getSession().getAttribute(
			"customer");
	int cid = customer.getCustomerId();
	Customer c = csbiz.getcustomer(cid);
	request.getSession().setAttribute("customer",c);
		return "selgrmessange";
		
		
	}
	//二维码生成器
	public String buil2dbarcode(){
		String info = request.getParameter("charinfo");
		if(info == null || info == ""){
			request.setAttribute("tipmsg", "未输入文字");
			return "2d_barcode_noparam";
		}
		String imgPath = "D:/My Documents/Downloads/Michael_QRCode.png";
		String encoderContent = "Hello 大大、小小,welcome to QRCode!" + "\nMyblog [ http://sjsky.iteye.com ]" + "\nEMail [ sjsky007@gmail.com ]";
		TwoDimensionCode handler = new TwoDimensionCode();
		handler.encoderQRCode(encoderContent, imgPath, "png");
		System.out.println("========encoder success");
		String decoderContent = handler.decoderQRCode(imgPath);
		System.out.println("解析结果如下：");
		System.out.println(decoderContent);
		System.out.println("========decoder success!!!");
		return "2d_barcode_success";
	}
  
	public void faEmail() throws IOException
	{
		System.out.println("aaaa");
		String rad = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer result = new StringBuffer();
		Random rand = new Random();
		for (int i = 0; i < 8; i++) {
			int randNum = rand.nextInt(36);
			result.append(rad.substring(randNum, randNum + 1));
		}
		String suiJiMa= result.toString();
		request.getSession().setAttribute("suiJiMa", suiJiMa);
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		
		String msg = "亲爱的"
			+ cu.getCustomerName()
			+ ": <br/><br/>欢迎使用立云邮件方式取回密码功能！<br/><br/>你的验证码是：<br/><br/>"
			+ "<br/><br/>"+suiJiMa+"<br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
	Email sendemail = new Email();
	
	String email=(String) request.getSession().getAttribute("email");
	if(email!=null&&(email.equals("")==false))
	{
		sendemail.sendEmail(email, "立云客服系统--邮件方式取回密码",msg);
	}
	else
	{
	sendemail.sendEmail(cu.getEmail(), "立云客服系统--邮件方式取回密码",msg);
	}
	response.getWriter().print("1");
	
	//request.getSession().setAttribute("customeremail",customer.getEmail());
	}
	public void yanZhengMa() throws IOException
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String suiJiMa=(String) request.getSession().getAttribute("suiJiMa");
		String suijima=request.getParameter("suijima");
		if(suijima.equals(suiJiMa))
		{
			cu.setIsLoginAccount(1);
			boolean a=csbiz.updateCustomer(cu);
			if(a)
			{
			//	request.getSession().removeAttribute("customer");
				System.out.println("aaaa");
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
		}
		else
			response.getWriter().print("0");
		
	}
	public void zhaoHuiPassword() throws IOException
	{
		String password=request.getParameter("password");
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		cu.setCustomerPassword(password);
		boolean a=csbiz.updateCustomer(cu);
		if(a)
		{
			request.getSession().removeAttribute("customer");
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
		
	}
	
	//修改密码
	public void updateNewPassword() throws IOException
	{
		String password=request.getParameter("newPassword");
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		cu.setCustomerPassword(password);
		boolean a=csbiz.updateCustomer(cu);
		if(a)
		{
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
	}
	//修改手机
	public void updatePhone() throws IOException
	{
		
		String phone=request.getParameter("phone");
	
		if(phone!=null)
		{
			request.getSession().setAttribute("phone", phone);
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
		
	}
	//修改手机邮箱验证
	public void yanZhengMa1() throws IOException
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String suiJiMa=(String) request.getSession().getAttribute("suiJiMa");
		String phone=(String) request.getSession().getAttribute("phone");
		String suijima=request.getParameter("suijima");
		if(suijima.equals(suiJiMa))
		{
			cu.setMobilePhone(phone);
			boolean a=csbiz.updateCustomer(cu);
			if(a)
			{
				request.getSession().removeAttribute("phone");
				request.getSession().setAttribute("customer", cu);
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
		}
		else
			response.getWriter().print("0");
		
	}
	//修改邮箱
	public void updateEmail() throws IOException
	{
		
		String email=request.getParameter("email");
	
		if(email!=null)
		{
			request.getSession().setAttribute("email", email);
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
		
	}
	//修改邮箱，邮箱验证
	public void yanZhengMa2() throws IOException
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String suiJiMa=(String) request.getSession().getAttribute("suiJiMa");
		String email=(String) request.getSession().getAttribute("email");
		String suijima=request.getParameter("suijima");
		if(suijima.equals(suiJiMa))
		{
			cu.setEmail(email);
			boolean a=csbiz.updateCustomer(cu);
			if(a)
			{
				request.getSession().removeAttribute("email");
				request.getSession().setAttribute("customer", cu);
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
		}
		else
			response.getWriter().print("0");
		
	}
	public void yanZhengMaLogon() throws IOException
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String suiJiMa=(String) request.getSession().getAttribute("suiJiMa");
		String suijima=request.getParameter("suijima");
		if(suijima.equals(suiJiMa))
		{
			cu.setIsLoginAccount(1);
			boolean a=csbiz.updateCustomer(cu);
			if(a)
			{
				request.getSession().removeAttribute("customer");
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
		}
		else
			response.getWriter().print("0");
		
	}
	//根据邮箱查找用户
	public void selectEmail()
	{
		String youxiang=request.getParameter("youxiang");
		String yanzhengma=request.getParameter("yanzhengma");
		 String code = (String) request.getSession().getAttribute("rand");
		List<Customer> cu=csbiz.getList("Customer", " and email='"+youxiang+"'");
		
		if(code.equals(yanzhengma)==false)
		{
			try {
				response.getWriter().print("2");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(cu.size()>0)
		{
			try {
				request.getSession().setAttribute("customer", cu.get(0));
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
	public void updateAuthorization()
	{
		String authorization=request.getParameter("authorization");
		
		if(authorization!=null)
		{
			request.getSession().setAttribute("authorization", authorization);
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
	//修改授权码
	public void yanZhengMa3() throws IOException
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String suiJiMa=(String) request.getSession().getAttribute("suiJiMa");
		String authorization=(String) request.getSession().getAttribute("authorization");
		String suijima=request.getParameter("suijima");
		if(suijima.equals(suiJiMa))
		{
			cu.setAuthorization(authorization);
			boolean a=csbiz.updateCustomer(cu);
			if(a)
			{
				request.getSession().removeAttribute("authorization");
				request.getSession().setAttribute("customer", cu);
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
		}
		else
			response.getWriter().print("0");
		
	}
	//开启手机登录
	public void bangdingPhone()
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		cu.setPhoneIsOk(1);
	   	boolean isOk= csbiz.updateCustomer(cu);
	   	if(isOk)
	   	{
	   		request.getSession().setAttribute("customer", cu);
	   		try {
				response.getWriter().print(1);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	   	}
	   	else
	   	{
	   		try {
				response.getWriter().print(0);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	   	}
		
		
	}
	public String customerName() 
	{

 		logger.info("customerName start");
		String cuName=request.getParameter("cuName");
		String cuSFZ=request.getParameter("cuSFZ");
		String cuGDPhone=request.getParameter("cuGDPhone");
		String cuSFZTime=request.getParameter("cuSFZTime").toString();
		String cuDZ=request.getParameter("cuDZ");
		String img1=request.getParameter("img1");
		String img11=request.getParameter("img11");
		logger.info("customerName 2175-"+cuName+cuDZ+cuSFZTime);
		
		
		
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		cu.setRealName(cuName);
		cu.setCardid(cuSFZ);
		cu.setPhone(cuGDPhone);
		cu.setCuSFZTime(cuSFZTime.toString());
		cu.setCustomerAddress(cuDZ);
		request.getSession().setAttribute("customer1", cu);
		
		String[] imgList=new String[2];
		imgList[0]=img1;
		imgList[1]=img11;
		
		
		request.getSession().setAttribute("imgList", imgList);
		logger.info("customerName end");
		return "chenggongSC";
		
		
	}
	public void customerNameBaocun()
	{
		Customer cus=(Customer) request.getSession().getAttribute("customer1");
		String[]img= (String[]) request.getSession().getAttribute("imgList");
		 
		for(int i=0;i<img.length;i++)
		{
			
			if(i==0)
			{
				cus.setCustomerfj(img[i].toString());
			}
			else
			{
				cus.setCustomerfj(cus.getCustomerfj()+"*"+img[i].toString());
			}
		}
		boolean aa=csbiz.updateCustomer(cus);
		if(aa)
		{
			try {
				request.getSession().removeAttribute("customer1");
				request.getSession().removeAttribute("imgList");
				request.getSession().setAttribute("customer", cus);
				response.getWriter().print("0");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else
		{

			try {
				response.getWriter().print("1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	public String updateCU()
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String realName=request.getParameter("realName");
		String date=request.getParameter("date");
		String businesslinkpersion=request.getParameter("businesslinkpersion");
		String customerType=request.getParameter("customerType");
		String mobilePhone=request.getParameter("mobilePhone");
		String cardid=request.getParameter("cardid");
		String qq=request.getParameter("qq");
		String email=request.getParameter("email");
		String facsimile=request.getParameter("facsimile");
		String customerCompany=request.getParameter("customerCompany");
		String dobusinesscode=request.getParameter("dobusinesscode");
		String companyScale=request.getParameter("companyScale");
		String phone=request.getParameter("phone");
		String customerAddress=request.getParameter("customerAddress");
		
		
		cu.setRealName(realName);
		cu.setDate(date);
		cu.setBusinesslinkpersion(businesslinkpersion);
		cu.setCustomerType(customerType);
		cu.setMobilePhone(mobilePhone);
		cu.setCardid(cardid);
		cu.setQq(qq);
		cu.setEmail(email);
		cu.setFacsimile(facsimile);
		cu.setCustomerCompany(customerCompany);
		cu.setDobusinesscode(dobusinesscode);
		cu.setCompanyScale(companyScale);
		cu.setPhone(phone);
		cu.setCustomerAddress(customerAddress);
		boolean aa=csbiz.updateCustomer(cu);
		
		if(aa)
		{
			request.getSession().setAttribute("customer", cu);
			return "lits_ucenter";
		}
		return "lits_ucenter";
	}
	public void updateCUTX()
	{
		Customer cu=(Customer) request.getSession().getAttribute("customer");
		String img=request.getParameter("img");
		cu.setCustomerTX(img);
		boolean aa=csbiz.updateCustomer(cu);
		if(aa)
		{
			try {
				response.getWriter().print("1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			response.getWriter().print("0");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	

	public void validateU(){
		try {
		Customer c = (Customer)request.getSession().getAttribute("customer");
		if(c == null){
			
				response.getWriter().print(0);
			}else{
				response.getWriter().print(1);
			}
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return ;
	}
	/**
	 * 立云团购页面
	 * @return
	 */
	public String detailOfGoods3(){
		
		String sgcode = request.getParameter("sgcode");
		List sglist = csbiz.getSgByCode(sgcode);
		Sale_goods sg = null;
		if(null!=sglist && sglist.size()>0){
			sg = (Sale_goods)sglist.get(0);
		}
		   String attrstr=sg.getSgAttribute().trim();//无@2|2|CPU|2@3|3|内存|1,3,4@无
//			组合规格字符串
			String specstr = sg.getSgspecifications();
			String first_spec_str = "";//保存第一规格的属性组合字符串 最后放到requst中去
			String second_spec_str = "";//保存第二规格的属性组合字符串 最后放到requst中去
			
			// String strge=sa.getSgspecifications();//属性
			 String isstrge="";//是否符合规则
//			   组合规格字符串
			   String strge=sg.getSgspecifications();//字符串类型‘1，2，222，222，22’第一个为行1的checkbox值，第二个为行2的checkbox值
			   if(strge!=null && strge!=""){
				  String str[]= strge.split("\\|");
				  Integer a=str.length;//有多少条数据
				  System.out.println(strge);
				  for (int i = 0; i < str.length; i++) {//获取第一个的checkbox的选中值
					  if(str[i]!=null && !str[i].equals("")){
						  String list=str[i];
						  String lexing[]=list.split(",");
						  	if(lexing.length>2){
							 for (int j = 0; j < 1; j++) {
						    	 if(lexing[0]!=null && !lexing[0].equals("")){
						    	 }
							 }
						  	}else{
						  		isstrge="no";
						  	}
					  }}
				}
				  if(!isstrge.equals("no")){
					  request.setAttribute("strge", strge);//内容
				  }
		
		
		
		System.out.println("w.......,=" + sg.getSgAttribute());
//	     得到商品属性
		   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
		   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//		   attributMap.put(label, value)
		   if(attrstr == null || attrstr.trim().equals("")){
				logger.info("组合商品属性：该商品无特殊属性");
			}else{
				String[] str1 = attrstr.split("@");//第一次分割
				if(str1.length != 4){
					logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
				}else{
					String  input_str = str1[0];//文本
					String  select_str = str1[1];//下拉
					String  checkbox_str = str1[2];//多选
					String  radio_str = str1[3];//单选
					
					attr_map = buildMap(attr_map,input_str);
					attr_map = buildMap(attr_map,select_str);
					attr_map = buildMap(attr_map,checkbox_str);
					attr_map = buildMap(attr_map,radio_str);
					
					for (Iterator it = attr_map.keySet().iterator(); it
							.hasNext();) {
						String label = (String) it.next();
						logger.info("label="+label);
					}
				}
			}
		   StringBuffer sb = new StringBuffer();
		   
		   Goods_dict gd   = (Goods_dict)salsBuness.getObj(Goods_dict.class, ""+sg.getGoods_dict().getGdId());
		  
		   Set set =  gd.getGoodsClass_expands();
			if(set == null || set.size()== 0){//无属性
				logger.info("类目编码为"+gd.getGdcodes()+"无类目属性");
			}else{
				for (Iterator it = set.iterator(); it.hasNext();) {
					GoodsClass_expand gde = (GoodsClass_expand) it.next();
					//用|分割
					sb.append(gde.getGeTemp1());
					sb.append("|");
					sb.append(gde.getGeTemp2());
					sb.append("|");
					sb.append(gde.getGeTemp3());
					sb.append("|");
					sb.append(gde.getGeTemp4());
					sb.append("|");
					sb.append(gde.getGeTemp5());
					sb.append("|");
					sb.append(gde.getGeTemp6());
					sb.append("|");
					sb.append(gde.getGeTemp7());
					sb.append("|");
					sb.append(gde.getGeTemp8());
					sb.append("|");
					sb.append(gde.getGeTemp9());
					sb.append("|");
					sb.append(gde.getGeTemp10());
					sb.append("|");
					sb.append(gde.getGeTemp11());
					sb.append("|");
					sb.append(gde.getGeTemp12());
					sb.append("|");
					sb.append(gde.getGeTemp13());
					sb.append("|");
					sb.append(gde.getGeTemp14());
					sb.append("|");
					sb.append(gde.getGeTemp15());
					break;//只得到第一条数据
				}
				String dict_attr_str = sb.toString();
				
				String[] ge_temp = dict_attr_str.split("\\|");
				logger.info("ge_temp.length="+ge_temp.length);
				int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
				for(int j=0;j<ge_temp.length;j++){
					if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
						logger.info("为空不处理");
					}else{
						//alert("ge_temp["+j+"]="+ge_temp[j]);
						String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
						logger.info("str2.length="+str2.length);
						logger.info("str2="+ge_temp[j]);
						
						if(str2.length != 6){//去掉不规范数据
							logger.info("数据不规范");
						}else{
							
							String tag =str2[0];
							
							String label = str2[1];
							String tips  = str2[2];
							String keystr  = str2[3];
							String valuestr  = str2[4];
							String specflag  = str2[5];
							
							//logger.info("第"+j+"轮,tag="+tag);
							//logger.info("第"+j+"轮,label="+label);
							//logger.info("第"+j+"轮,keystr="+keystr);
							//logger.info("第"+j+"轮,valuestr="+valuestr);
							//logger.info("第"+j+"轮,specflag="+specflag);
							String tagid = "";//标签的id值
							String tagname = "";//标签的name值
							if(tag.equals("1")){//文本框
								//文本框
								//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
								tagid = "input"+j;
								tagname = "input"+j; 
								//这里keystr 在文本框中默认是1 不需要填入
								String[] str3_value = valuestr.split("-");
								String inputstr = "";
								if(attr_map.containsKey(label)){
									String[]  ss = {label,attr_map.get(label)[3]};
									attributMap.put(j,ss );
								}
							}else if(tag.equals("2")){//下拉框
								tagid = "select"+j;
								tagname = "select"+j;
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								//logger.info(str3_key.length+"----"+str3_value.length);
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("下拉框中的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								String optkey = "";
								if(attr_map.containsKey(label)){
									optkey = attr_map.get(label)[3];
									for(int i=0;i<str3_key.length;i++){//
										if(optkey.equals(str3_key[i])){
											String[]  ss = {label,str3_value[i]};
											attributMap.put(j,ss );
										}
									}
									
								}
							}else if(tag.equals("3")){//多选框
								//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
								tagid = "checkbox"+j;
								tagname = "checkbox"+j;
								
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("多选框的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								if(specflag.trim().equals("0")){
									String checkkeys = "";
									String ckvaluestr = "";
									if(attr_map.containsKey(label)){
										checkkeys = attr_map.get(label)[3];
										String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
										
										for(int i=0;i<str3_key.length;i++){
											String ckstr = "";//定义一个变量 是否选中
											for (int k = 0; k < checkkey.length; k++) {
												if(checkkey[k].equals(str3_key[i])){
													ckstr="checked='checked'";
													ckvaluestr += str3_value[i]+",";
													break;
												}//满足条件 选中 并推出当前循环
											}
										}
									}
									if(ckvaluestr.equals("")){
										ckvaluestr = "无";
									}else{
										ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
									}
									
									String[]  ss = {label,ckvaluestr};
									attributMap.put(j,ss );
									
								}else if(specflag.trim().equals("1")){
//									保存的规格字符串
//									1,1,500,6,测试1,1_1|1,3,750,6,测试4,1_3|2,1,400,6,测试2,2_1|2,3,700,6,测试5,2_3|4,1,500,6,测试3,4_1|4,3,750,6,测试6,4_3|
									if(specstr  == null || specstr.trim().equals("")){
										logger.info("商品中未配置规格");
									}else{
										String[] specarra = specstr.split("\\|");
									}
									
									
									if(specnum == 0){//第一个规格属性
										for(int i=0;i<str3_key.length;i++){
											first_spec_str += str3_key[i]+"-"+str3_value[i]+"-"+tagname+"-"+",";
										}
										if(first_spec_str !="") first_spec_str = first_spec_str.substring(0,first_spec_str.length()-1);//去掉最后一个,
										specnum +=1;
									}else if(specnum == 1){//第二个规格属性
										for(int i=0;i<str3_key.length;i++){
											second_spec_str +=str3_key[i]+"-"+str3_value[i]+"-"+tagname+",";
										}
										
										if(second_spec_str !="") second_spec_str = second_spec_str.substring(0,second_spec_str.length()-1);//去掉最后一个,
										specnum +=1;
									}else if(specnum == 2){//超过2个规格属性
										logger.info("规格属性的数量已经达到2个，只取前2个");
									}else{//规格属性的值混乱 
										logger.info("规格数量标识错误");
									}
								}else{//规格鉴别标识错误
									logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
								}
							}else if(tag.equals("4")){//单选框
								tagid = "radio"+j;
								tagname = "radio"+j;
								//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("多选框的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								String radiokey = "";
								
								if(attr_map.containsKey(label)){
									radiokey = attr_map.get(label)[3];
									for(int i=0;i<str3_key.length;i++){
										String ckstr = "";
										if(radiokey.equals(str3_key[i])){
											ckstr = "checked";
											String[]  ss = {label,str3_value[i]};
											attributMap.put(j,ss );
										}
									}
								}
							}else{
								logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
							}
						}
					}
				}
			}
		   
	     request.setAttribute("getpropertys",attributMap);
	     
	     //得到月销量 总销量
	     int saled_month_amount = 100;//月销量
	     int saled_total_amount = 999;//总销量
	     int remaining_amount = 73;//剩余量
	     request.setAttribute("sa", sg);
	     request.setAttribute("saled_month_amount", saled_month_amount);
	     request.setAttribute("saled_total_amount", saled_total_amount);
	     request.setAttribute("remaining_amount", remaining_amount);
	     
	     String thumb = sg.getSgThumb();
	     if(thumb != null && !thumb.trim().equals("")){
	    	 if(thumb.startsWith("|")){
	    		 thumb = thumb.substring(1,thumb.length());
	    	 }
	    	 String[] thumbarra = thumb.split("\\|");
	    	 request.setAttribute("thumbarra",thumbarra );
	    	 request.setAttribute("thumblength",thumbarra.length );
	     }
	     
	     
	     request.setAttribute("first_spec_str", first_spec_str);//记录第一规格的key value
		 request.setAttribute("second_spec_str", second_spec_str);//记录第二规格的key value
		return "toliyun";
	}
	/**
	 * 立云前台页面
	 * @return
	 */
	public String detailOfGoods2(){
		
		String sgcode = request.getParameter("sgcode");
		List sglist = csbiz.getSgByCode(sgcode);
		Sale_goods sg = null;
		if(null!=sglist && sglist.size()>0){
			sg = (Sale_goods)sglist.get(0);
		}
		   String attrstr=sg.getSgAttribute().trim();//无@2|2|CPU|2@3|3|内存|1,3,4@无
//			组合规格字符串
			String specstr = sg.getSgspecifications();
			String first_spec_str = "";//保存第一规格的属性组合字符串 最后放到requst中去
			String second_spec_str = "";//保存第二规格的属性组合字符串 最后放到requst中去
			
			// String strge=sa.getSgspecifications();//属性
			 String isstrge="";//是否符合规则
//			   组合规格字符串
			   String strge=sg.getSgspecifications();//字符串类型‘1，2，222，222，22’第一个为行1的checkbox值，第二个为行2的checkbox值
			   if(strge!=null && strge!=""){
				  String str[]= strge.split("\\|");
				  Integer a=str.length;//有多少条数据
				  System.out.println(strge);
				  for (int i = 0; i < str.length; i++) {//获取第一个的checkbox的选中值
					  if(str[i]!=null && !str[i].equals("")){
						  String list=str[i];
						  String lexing[]=list.split(",");
						  	if(lexing.length>2){
							 for (int j = 0; j < 1; j++) {
						    	 if(lexing[0]!=null && !lexing[0].equals("")){
						    	 }
							 }
						  	}else{
						  		isstrge="no";
						  	}
					  }}
				}
				  if(!isstrge.equals("no")){
					  request.setAttribute("strge", strge);//内容
				  }
		
		
		
		System.out.println("w.......,=" + sg.getSgAttribute());
//	     得到商品属性
		   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
		   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//		   attributMap.put(label, value)
		   if(attrstr == null || attrstr.trim().equals("")){
				logger.info("组合商品属性：该商品无特殊属性");
			}else{
				String[] str1 = attrstr.split("@");//第一次分割
				if(str1.length != 4){
					logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
				}else{
					String  input_str = str1[0];//文本
					String  select_str = str1[1];//下拉
					String  checkbox_str = str1[2];//多选
					String  radio_str = str1[3];//单选
					
					attr_map = buildMap(attr_map,input_str);
					attr_map = buildMap(attr_map,select_str);
					attr_map = buildMap(attr_map,checkbox_str);
					attr_map = buildMap(attr_map,radio_str);
					
					for (Iterator it = attr_map.keySet().iterator(); it
							.hasNext();) {
						String label = (String) it.next();
						logger.info("label="+label);
					}
				}
			}
		   StringBuffer sb = new StringBuffer();
		   
		   Goods_dict gd   = (Goods_dict)salsBuness.getObj(Goods_dict.class, ""+sg.getGoods_dict().getGdId());
		  
		   Set set =  gd.getGoodsClass_expands();
			if(set == null || set.size()== 0){//无属性
				logger.info("类目编码为"+gd.getGdcodes()+"无类目属性");
			}else{
				for (Iterator it = set.iterator(); it.hasNext();) {
					GoodsClass_expand gde = (GoodsClass_expand) it.next();
					//用|分割
					sb.append(gde.getGeTemp1());
					sb.append("|");
					sb.append(gde.getGeTemp2());
					sb.append("|");
					sb.append(gde.getGeTemp3());
					sb.append("|");
					sb.append(gde.getGeTemp4());
					sb.append("|");
					sb.append(gde.getGeTemp5());
					sb.append("|");
					sb.append(gde.getGeTemp6());
					sb.append("|");
					sb.append(gde.getGeTemp7());
					sb.append("|");
					sb.append(gde.getGeTemp8());
					sb.append("|");
					sb.append(gde.getGeTemp9());
					sb.append("|");
					sb.append(gde.getGeTemp10());
					sb.append("|");
					sb.append(gde.getGeTemp11());
					sb.append("|");
					sb.append(gde.getGeTemp12());
					sb.append("|");
					sb.append(gde.getGeTemp13());
					sb.append("|");
					sb.append(gde.getGeTemp14());
					sb.append("|");
					sb.append(gde.getGeTemp15());
					break;//只得到第一条数据
				}
				String dict_attr_str = sb.toString();
				
				String[] ge_temp = dict_attr_str.split("\\|");
				logger.info("ge_temp.length="+ge_temp.length);
				int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
				for(int j=0;j<ge_temp.length;j++){
					if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
						logger.info("为空不处理");
					}else{
						//alert("ge_temp["+j+"]="+ge_temp[j]);
						String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
						logger.info("str2.length="+str2.length);
						logger.info("str2="+ge_temp[j]);
						
						if(str2.length != 6){//去掉不规范数据
							logger.info("数据不规范");
						}else{
							
							String tag =str2[0];
							
							String label = str2[1];
							String tips  = str2[2];
							String keystr  = str2[3];
							String valuestr  = str2[4];
							String specflag  = str2[5];
							
							//logger.info("第"+j+"轮,tag="+tag);
							//logger.info("第"+j+"轮,label="+label);
							//logger.info("第"+j+"轮,keystr="+keystr);
							//logger.info("第"+j+"轮,valuestr="+valuestr);
							//logger.info("第"+j+"轮,specflag="+specflag);
							String tagid = "";//标签的id值
							String tagname = "";//标签的name值
							if(tag.equals("1")){//文本框
								//文本框
								//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
								tagid = "input"+j;
								tagname = "input"+j; 
								//这里keystr 在文本框中默认是1 不需要填入
								String[] str3_value = valuestr.split("-");
								String inputstr = "";
								if(attr_map.containsKey(label)){
									String[]  ss = {label,attr_map.get(label)[3]};
									attributMap.put(j,ss );
								}
							}else if(tag.equals("2")){//下拉框
								tagid = "select"+j;
								tagname = "select"+j;
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								//logger.info(str3_key.length+"----"+str3_value.length);
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("下拉框中的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								String optkey = "";
								if(attr_map.containsKey(label)){
									optkey = attr_map.get(label)[3];
									for(int i=0;i<str3_key.length;i++){//
										if(optkey.equals(str3_key[i])){
											String[]  ss = {label,str3_value[i]};
											attributMap.put(j,ss );
										}
									}
									
								}
							}else if(tag.equals("3")){//多选框
								//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
								tagid = "checkbox"+j;
								tagname = "checkbox"+j;
								
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("多选框的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								if(specflag.trim().equals("0")){
									String checkkeys = "";
									String ckvaluestr = "";
									if(attr_map.containsKey(label)){
										checkkeys = attr_map.get(label)[3];
										String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
										
										for(int i=0;i<str3_key.length;i++){
											String ckstr = "";//定义一个变量 是否选中
											for (int k = 0; k < checkkey.length; k++) {
												if(checkkey[k].equals(str3_key[i])){
													ckstr="checked='checked'";
													ckvaluestr += str3_value[i]+",";
													break;
												}//满足条件 选中 并推出当前循环
											}
										}
									}
									if(ckvaluestr.equals("")){
										ckvaluestr = "无";
									}else{
										ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
									}
									
									String[]  ss = {label,ckvaluestr};
									attributMap.put(j,ss );
									
								}else if(specflag.trim().equals("1")){
//									保存的规格字符串
//									1,1,500,6,测试1,1_1|1,3,750,6,测试4,1_3|2,1,400,6,测试2,2_1|2,3,700,6,测试5,2_3|4,1,500,6,测试3,4_1|4,3,750,6,测试6,4_3|
									if(specstr  == null || specstr.trim().equals("")){
										logger.info("商品中未配置规格");
									}else{
										String[] specarra = specstr.split("\\|");
									}
									
									
									if(specnum == 0){//第一个规格属性
										for(int i=0;i<str3_key.length;i++){
											first_spec_str += str3_key[i]+"-"+str3_value[i]+"-"+tagname+"-"+",";
										}
										if(first_spec_str !="") first_spec_str = first_spec_str.substring(0,first_spec_str.length()-1);//去掉最后一个,
										specnum +=1;
									}else if(specnum == 1){//第二个规格属性
										for(int i=0;i<str3_key.length;i++){
											second_spec_str +=str3_key[i]+"-"+str3_value[i]+"-"+tagname+",";
										}
										
										if(second_spec_str !="") second_spec_str = second_spec_str.substring(0,second_spec_str.length()-1);//去掉最后一个,
										specnum +=1;
									}else if(specnum == 2){//超过2个规格属性
										logger.info("规格属性的数量已经达到2个，只取前2个");
									}else{//规格属性的值混乱 
										logger.info("规格数量标识错误");
									}
								}else{//规格鉴别标识错误
									logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
								}
							}else if(tag.equals("4")){//单选框
								tagid = "radio"+j;
								tagname = "radio"+j;
								//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("多选框的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								String radiokey = "";
								
								if(attr_map.containsKey(label)){
									radiokey = attr_map.get(label)[3];
									for(int i=0;i<str3_key.length;i++){
										String ckstr = "";
										if(radiokey.equals(str3_key[i])){
											ckstr = "checked";
											String[]  ss = {label,str3_value[i]};
											attributMap.put(j,ss );
										}
									}
								}
							}else{
								logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
							}
						}
					}
				}
			}
		   
	     request.setAttribute("getpropertys",attributMap);
	     
	     //得到月销量 总销量
	     int saled_month_amount = 100;//月销量
	     int saled_total_amount = 999;//总销量
	     int remaining_amount = 73;//剩余量
	     request.setAttribute("sa", sg);
	     request.setAttribute("saled_month_amount", saled_month_amount);
	     request.setAttribute("saled_total_amount", saled_total_amount);
	     request.setAttribute("remaining_amount", remaining_amount);
	     
	     String thumb = sg.getSgThumb();
	     if(thumb != null && !thumb.trim().equals("")){
	    	 if(thumb.startsWith("|")){
	    		 thumb = thumb.substring(1,thumb.length());
	    	 }
	    	 String[] thumbarra = thumb.split("\\|");
	    	 request.setAttribute("thumbarra",thumbarra );
	    	 request.setAttribute("thumblength",thumbarra.length );
	     }
	     
	     
	     request.setAttribute("first_spec_str", first_spec_str);//记录第一规格的key value
		 request.setAttribute("second_spec_str", second_spec_str);//记录第二规格的key value
		return "toliyun";
	}
	private HashMap<String, String[]> buildMap(HashMap<String, String[]> attr_map, String input_str) {
		  if(input_str.equals("无")){
				logger.info("组合商品属性：该商品无文本属性");
			}else{
				String[] str2 = input_str.split(";");//第二次分割 //		2|2|CPU|2;2|4|disk|2
				for (int i = 0; i < str2.length; i++) {
					String  tagstr = str2[i];
					String[] str3 = tagstr.split("\\|");//第三次分割
					if(str3.length !=4){
						logger.error("组合商品属性-数据问题：文本标识数据;分割，数组长度不为4");
					}else{
						String serial = str3[0];//属性序号
						String tagserial = str3[1];//标签序号 1文本 2 下拉 3多选 4单选
						String label = str3[2];//label名称 唯一标识 整体用他来区分每个属性
						String value = str3[3];//显示的值
						
						if(attr_map.containsKey(label)){
							logger.error("label标识有重复的,请核查数据"+label);
						}else{
							attr_map.put(label,str3);
						}
					}
				}
				
			}
		  return attr_map;
		}
	
	 public String listPay()
	 {
		 Customer c = (Customer)request.getSession().getAttribute("customer");
			String pageNo1 = request.getParameter("pageNo") != null ? request
					.getParameter("pageNo") : "1";
			String hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'";

		Pages pages = csbiz.get(hql, Integer.parseInt(pageNo1), 6, null);
		request.getSession().setAttribute("dateTime", "最初");
		request.getSession().setAttribute("dateTime1", "至今");
		 request.setAttribute("pages", pages);
		 request.setAttribute("mark", 0);
		 return "listPay";
	 }
	 public String listPayDateTime()
	 {
		 String dateTime=request.getParameter("dateTime");
		 String dateTime1=request.getParameter("dateTime1");

		 
		 
		 Customer c = (Customer)request.getSession().getAttribute("customer");
			String pageNo1 = request.getParameter("pageNo") != null ? request
					.getParameter("pageNo") : "1";
			String hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
					"and (collectionTime >='"+dateTime+"' and collectionTime <= '"+dateTime1+"' )";
			if(dateTime==null||dateTime==""&&dateTime==null||dateTime=="")
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'";
			}
			else if(dateTime.equals(dateTime1))
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
				"and collectionTime ='"+dateTime+"'";
			}
			else if(dateTime==""||dateTime==null)
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
				"and collectionTime =<'"+dateTime1+"'";
			}
			else if(dateTime1==""||dateTime1==null)
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
				"and collectionTime >='"+dateTime+"'";
			}
		Pages pages = csbiz.get(hql, Integer.parseInt(pageNo1), 6, null);
		request.getSession().setAttribute("dateTime", dateTime);
		request.getSession().setAttribute("dateTime1", dateTime1);
		 request.setAttribute("pages", pages);
		 request.setAttribute("mark", 1);
		 return "listPay";
	 }
	 public String listPayDateTime1()
	 {
		 String dateTime=(String) request.getSession().getAttribute("dateTime");
		 String dateTime1=(String) request.getSession().getAttribute("dateTime1");


		 
		 Customer c = (Customer)request.getSession().getAttribute("customer");
			String pageNo1 = request.getParameter("pageNo") != null ? request
					.getParameter("pageNo") : "1";
			String hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
					"and (collectionTime >='"+dateTime+"' and collectionTime <= '"+dateTime1+"' )";
			if(dateTime==null||dateTime==""&&dateTime==null||dateTime=="")
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'";
			}
			else if(dateTime.equals(dateTime1))
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
				"and collectionTime ='"+dateTime+"'";
			}
			else if(dateTime==""||dateTime==null)
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
				"and collectionTime =<'"+dateTime1+"'";
			}
			else if(dateTime1==""||dateTime1==null)
			{
				hql="from Charge where saleOrder.customer.customerId="+c.getCustomerId()+" and del='0'" +
				"and collectionTime >='"+dateTime+"'";
			}
		Pages pages = csbiz.get(hql, Integer.parseInt(pageNo1), 6, null);
		request.getSession().setAttribute("dateTime", dateTime);
		request.getSession().setAttribute("dateTime1", dateTime1);
		 request.setAttribute("pages", pages);
		 request.setAttribute("mark", 1);
		 return "listPay";
	 }
	public void getPersion(){
		String sgid = request.getParameter("sgid");
		PrintWriter out;
		try {
			out  = response.getWriter();
		} catch (IOException e) {
			
			e.printStackTrace();
			return ;
		}
		if(sgid == null || !StringUtil.isNumeric(sgid)){
			out.print("-1");
			return ;
		}
		
		List list = csbiz.getList("SaleGoods_mids", " and sale_goods.sgId = "+sgid);
		if(list != null ){
			out.print(list.size());
		}else{
			out.print("-1");
		}
			
		
	}
	public void setSelvar(String selvar) {
		this.selvar = selvar;
	}

	public String getSelvar() {
		return selvar;
	}

	public void setInpvar(String inpvar) {
		this.inpvar = inpvar;
	}

	public String getInpvar() {
		return inpvar;
	}

	public void setSelvar11(String selvar11) {
		this.selvar11 = selvar11;
	}

	public String getSelvar11() {
		return selvar11;
	}

	public void setHtStart(String htStart) {
		this.htStart = htStart;
	}

	public String getHtStart() {
		return htStart;
	}

	public void setHtEnd(String htEnd) {
		this.htEnd = htEnd;
	}

	public String getHtEnd() {
		return htEnd;
	}

	public Product_orderService getProduct_CommentService() {
		return product_CommentService;
	}

	public void setProduct_CommentService(
			Product_orderService product_CommentService) {
		this.product_CommentService = product_CommentService;
	}

}
