package com.fuao.fajxc.action.customService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletInputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.customService.CustomerServiceBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.product_manageService.Product_orderService;
import com.fuao.fajxc.util.DateUtil;
import com.fuao.fajxc.vo.CurrencyProcess;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Sale_orders;
import com.opensymphony.xwork2.ModelDriven;

public class ClientCustomServiceAction implements ModelDriven<Customer>, ServletRequestAware,
		ServletResponseAware, CheckAccessMethd {

	private static Logger logger = Logger.getLogger(ClientCustomServiceAction.class);
	private static final String DEFAULT_SUCCCESS_RESPONSE_MESSAGE = "do success!";
	private static final String DEFAULT_ERROR_RESPONSE_MESSAGE = "do failed!";
	private HttpServletResponse response;
	private HttpServletRequest request;
	private Customer customer;
	private SaleorderBussiness salsBuness;
	private Product_orderService product_CommentService;
	private CustomerServiceBussiness csbiz;

	public SaleorderBussiness getSalsBuness() {
		return salsBuness;
	}

	public void setSalsBuness(SaleorderBussiness salsBuness) {
		this.salsBuness = salsBuness;
	}


	public Product_orderService getProduct_CommentService() {
		return product_CommentService;
	}

	public void setProduct_CommentService(
			Product_orderService product_CommentService) {
		this.product_CommentService = product_CommentService;
	}
	
	public CustomerServiceBussiness getCsbiz() {
		return csbiz;
	}

	public void setCsbiz(CustomerServiceBussiness csbiz) {
		this.csbiz = csbiz;
	}
	
	/**
	 * 客户客户端登录
	 */
	public void cLogin()
	{
		
		checkAccessMethod();
		String method = request.getMethod();
		String cUUID = request.getParameter("uuid");
		String clientVersion = request.getParameter("client_version");
		String appKey = request.getParameter("appKey");
		String cName = request.getParameter("cusName");
		String cPass = request.getParameter("password");
		//String time = request.getParameter("time");
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
	@SuppressWarnings("unchecked")
	public void cReg() {
		//String msgStr = "success";
		//int msgCode = 0;
		
		// 获取登录输入客户端KEY
		
		// KEY验证
		
		// 如果两个验证码不匹配则返回错误提示
		
//		if (appKey == null) {
//			msgStr = "验证码错误";
//			msgCode = -1;
//		}
		checkAccessMethod();
		
		String cUUID = request.getParameter("uuid");
		String clientVersion = request.getParameter("client_version");//客户端版本号
		String appKey = request.getParameter("appKey");
		String cName = request.getParameter("cusName");
		String cPass = request.getParameter("password");
		String cEmail = request.getParameter("email");
		//String time = request.getParameter("time");
		String pid = request.getParameter("pid");//代理商ID 用于识别推广注册的代理商
		String ip = request.getParameter("cusIp");
		String reqSrc = request.getRemoteAddr();
		
		logger.debug("do=cReg src="+reqSrc+" time="+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()));
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
		
		checkAccessMethod();
		String clientVersion = request.getParameter("client_version");//客户端版本号
		String appKey = request.getParameter("appKey");//访问授权
		String attrs = request.getParameter("attrs");//注册用户名
		String values = request.getParameter("values");
		//String time = request.getParameter("time");
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
	 * 购买VIP服务
	 */
	public void buyVIPService(){
	
		checkAccessMethod();
		Customer customer=null;
		
		if( "true".equals(checkAuthCode())){
		
			// 生成一个订单号
			String authCode = request.getHeader("uuid");//客户端ID
			String sign = request.getHeader("sign");//签名
			String cid = request.getParameter("cid");//用户ID
			String sgid = request.getParameter("sgid");//商品ID
			String sgcode = request.getParameter("sgcode");//商品编码
			String allMoney =  request.getParameter("amoney");//所选商品对应的价格
			String mountstr =  "1";//数量
			String specstr = request.getParameter("specstr");//所选规格
			//String permoneystr =  request.getParameter("permoney");//所选规格对应的价格
			if(mountstr == null) mountstr = "1";
			int mount = 1;
			
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
//			so.setSoStat(1);
			so.setSoStat(0);//暂定为0状态
			so.setSoOrderTime(DateUtil.getDateNow("yyyy-MM-dd HH:mm"));
			//so.setPrices(mount*permoney);
			so.setPrices(Float.valueOf(allMoney));
			so.setSpec(specstr);
			csbiz.save(so);
			String sql="From Sale_orders where soNums='"+sgorderNum+"'";
			List l1=salsBuness.getOrdersDate(sql);
			List<Sale_orders> l2=l1;
			Sale_orders lo=l2.get(0);
			
			String hql="From Sale_goods where sgId="+sgid;
			List l3=salsBuness.getOrdersDate(hql);
			List<Sale_goods> l4=l3;
			Sale_goods lo1=l4.get(0);

		    request.setAttribute("price", allMoney);
		    //request.setAttribute("price", mount*permoney);
		
		
			//购买的商品数量
			int sgnum = 1;//下次获取数量时变更
		    //request.setAttribute("price", lo1.getSgPrice()*lo1.getSgnumbers());
			if(request.getParameter("amoney")!=null){
				
				request.setAttribute("price", request.getParameter("amoney"));
			  }else{
			    //request.setAttribute("price", mount*permoney);
			    request.setAttribute("price", allMoney);
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
			
		 
		}else{
			printMsg(-1,"authCode error!");
			return ;
		}
		
		printMsg(0, DEFAULT_SUCCCESS_RESPONSE_MESSAGE);
	}
	private String checkAuthCode() {
		String authCode = request.getHeader("uuid");
		String sign = request.getHeader("sign");
		return Boolean.toString(true);
	}

	/**
	 * VIP服务续费
	 */
	public void BuyVIPServiceAgain(){
		checkAccessMethod();
		String authCode = request.getHeader("uuid");
		String sign = request.getHeader("sign");
		String cid = request.getParameter("cid");//用户ID
		String sgid = request.getParameter("sgid");//商品ID
		String sgcode = request.getParameter("sgcode");//商品编码
		String allMoney =  request.getParameter("amoney");//所选商品对应的价格
		
		printMsg(0, DEFAULT_SUCCCESS_RESPONSE_MESSAGE);
	}
	/**
	 * VIP服务升级<br/>
	 * 用户下载流量或者上传等依据我们的标准给会员提升等级
	 */
	public void UpgradeVIPService(){
		checkAccessMethod();
		String authCode = request.getHeader("uuid");//客户端ID
		String sign = request.getHeader("sign");//签名
		String cid = request.getParameter("cid");//用户ID
				
		printMsg(0, "{\""+cid+"\":\"123\",\"vip\":\"2\"}");
	}
	/**
	 * 根据会员的类型名称查询VIP服务接口<br/>
	 * 
	 */
	public void queryVIPService(){
		checkAccessMethod();
		String authCode = request.getHeader("uuid");//客户端ID
		String sign = request.getHeader("sign");//签名
		String cid = request.getParameter("sgname");//会员名称
		Map<String,String> sgMap = new HashMap<String,String>();
		sgMap.put("付费周期", "月付");
		sgMap.put("加速流量", "2");
		sgMap.put("接入设备数", "5");
		sgMap.put("加速带宽", "500KB");
		sgMap.put("商品价格/元", "10.0");
		printMsg(0,logMsg(sgMap));
		
	}
	
	
	/**
	 * 查询用户购买服务记录接口
	 */
	public void QueryVIPServiceRecode(){
		checkAccessMethod();
		String authCode = request.getParameter("uuid");//客户端ID
		String sign = request.getParameter("sign");//签名
		String cid = request.getParameter("cid");//用户ID
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		Map<String,String> sgMap = new HashMap<String,String>();
		Map<String,String> sgMap2 = new HashMap<String,String>();
		sgMap.put("payTime", "2015-04-07");
		sgMap.put("desc", "购买会员xxxxx");
		sgMap2.put("payTime", "2015-04-07");
		sgMap2.put("desc", "购买会员xxxxx");
		list.add(sgMap);
		list.add(sgMap2);
		printMsg(0,logMsg(list));
		//付费周期：月付 加速流量：2 接入设备数：5加速带宽：500KB商品价格/元： 10.0
		//printMsg(0, DEFAULT_SUCCCESS_RESPONSE_MESSAGE);
	}
	

	

	/**
	 * 用户终端设别查询
	 */
	public void QueryTerminalEquipment(){
		checkAccessMethod();
		String authCode = request.getParameter("uuid");//客户端ID
		String sign = request.getParameter("sign");//签名
		String cid = request.getParameter("cid");//用户ID
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		Map<String,String> sgMap = new HashMap<String,String>();
		Map<String,String> sgMap2 = new HashMap<String,String>();
		sgMap.put("uuid", "134123451235");
		sgMap.put("time", "2015-05-05");
		sgMap2.put("uuid", "13433351236");
		sgMap2.put("time", "2015-05-06");
		list.add(sgMap);
		list.add(sgMap2);
		printMsg(0,logMsg(list));
	}
	
	
	//
	
	private String logMsg(List<Map<String, String>> list) {
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		sb.append("[");
		
		
		for (Map<String, String> map : list) {
			sb2.append(","+logMsg(map));
		}
		if(list != null && list.size()>0){
			sb.append(sb2.substring(1));
		}
		sb.append("]");
		return sb.toString();
	}
	private String logMsg(Map<String, String> sgMap) {
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		
		sb2.append("{");
		for (Entry<String, String> ent : sgMap.entrySet()) {
			sb2.append("\""+ent.getKey()+"\":"+"\""+ent.getValue()+"\",");
		}
		
		if(sgMap != null && sgMap.size()>0){
			sb.append(sb2.substring(0, sb2.length()-1)+"}");
		}
		
		return sb.toString();
	}
	
	/**
	 * 提供统一json响应接口
	 * @param errorCode
	 * @param errorMsg
	 */
	private void printMsg(int errorCode,String errorMsg){
		String jsonData = "{\"detail\":\""+errorMsg+"\",\"result\":\""+errorCode+"\"}"; 
		printMsg(jsonData);
	}
	/**
	 * 提供统一json响应接口
	 * @param errorCode
	 * @param errorMsg
	 */
	private void printMsg(String jsonData){
		try {
			System.out.println(jsonData);
			response.getWriter().print(jsonData);
		} catch (IOException e) {
			logger.error("printMsg error IOException: "+e);
		}
	}
	
	/**
	 * 验证用户请求方式<br/>
	 * 只支持post访问
	 * 
	 */
	private void checkAccessMethod(){
//		String method = request.getMethod();
//		if(!"post".equals(method.toLowerCase())){
//			printMsg(-1, "Illegal request");
//			return ;
//		}
	}
	/**
	 * 验证头部
	 */
	private void verifyHeader(){
		
	}
	/**
	 * 验证请求参数
	 */
	private void verifyBodyParam(){
		
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
	
	/**
	 * 获取客户端真实IP地址
	 * 
	 * @param request
	 * @return
	 */
	private String getIpAddr(HttpServletRequest request) {
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
	
public static void main(String[] args) {
		
		ClientCustomServiceAction cc = new ClientCustomServiceAction();
		cc.request = new HttpServletRequest() {
			
			public void setCharacterEncoding(String env)
					throws UnsupportedEncodingException {
				// TODO Auto-generated method stub
				
			}
			
			public void setAttribute(String name, Object o) {
				// TODO Auto-generated method stub
				
			}
			
			public void removeAttribute(String name) {
				// TODO Auto-generated method stub
				
			}
			
			public boolean isSecure() {
				// TODO Auto-generated method stub
				return false;
			}
			
			public int getServerPort() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			public String getServerName() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getScheme() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public RequestDispatcher getRequestDispatcher(String path) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public int getRemotePort() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			public String getRemoteHost() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getRemoteAddr() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getRealPath(String path) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public BufferedReader getReader() throws IOException {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getProtocol() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String[] getParameterValues(String name) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Enumeration getParameterNames() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Map getParameterMap() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getParameter(String name) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Enumeration getLocales() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Locale getLocale() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public int getLocalPort() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			public String getLocalName() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getLocalAddr() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public ServletInputStream getInputStream() throws IOException {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getContentType() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public int getContentLength() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			public String getCharacterEncoding() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Enumeration getAttributeNames() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Object getAttribute(String name) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public boolean isUserInRole(String role) {
				// TODO Auto-generated method stub
				return false;
			}
			
			public boolean isRequestedSessionIdValid() {
				// TODO Auto-generated method stub
				return false;
			}
			
			public boolean isRequestedSessionIdFromUrl() {
				// TODO Auto-generated method stub
				return false;
			}
			
			public boolean isRequestedSessionIdFromURL() {
				// TODO Auto-generated method stub
				return false;
			}
			
			public boolean isRequestedSessionIdFromCookie() {
				// TODO Auto-generated method stub
				return false;
			}
			
			public Principal getUserPrincipal() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public HttpSession getSession(boolean create) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public HttpSession getSession() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getServletPath() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getRequestedSessionId() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public StringBuffer getRequestURL() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getRequestURI() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getRemoteUser() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getQueryString() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getPathTranslated() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getPathInfo() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getMethod() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public int getIntHeader(String name) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			public Enumeration getHeaders(String name) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public Enumeration getHeaderNames() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getHeader(String name) {
				// TODO Auto-generated method stub
				return null;
			}
			
			public long getDateHeader(String name) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			public Cookie[] getCookies() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getContextPath() {
				// TODO Auto-generated method stub
				return null;
			}
			
			public String getAuthType() {
				// TODO Auto-generated method stub
				return null;
			}
		};
		cc.QueryTerminalEquipment();
	}
	

}
