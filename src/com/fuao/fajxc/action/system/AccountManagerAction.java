package com.fuao.fajxc.action.system;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.MD5;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ModelDriven;
public class AccountManagerAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	/**
	 * 日志记录
	 */
	private static Logger logger = Logger.getLogger(AccountManagerAction.class);	
	private FunctionInfoSystemBussiness functionInfoSystemBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public void setFunctionInfoSystemBussiness(
			FunctionInfoSystemBussiness functionInfoSystemBussiness) {
		this.functionInfoSystemBussiness = functionInfoSystemBussiness;
	}
	public Object getModel() {
		return null;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	/**
	 * 修改密码 --跳转
	 * @return
	 */
	public String editPass()
	{
		System.out.println("execute editpass  ....  ... ");
		Cookies cookies = new Cookies();
		String loginname = cookies.getCookie(request, "loginName");
		String password = cookies.getCookie(request, "password");
		
		Users users = functionInfoSystemBussiness.getObject(loginname, password);
		if(users.getUserId()>0)
		{
			request.setAttribute("user", users);
		}
		return "edit";
	}

	/**
	 * 修改密码
	 * @return
	 */
	public String editPassword()
	{
		Integer uid = Integer.parseInt(request.getParameter("uid"));
		String password = request.getParameter("password");
		
		Users user = functionInfoSystemBussiness.isExistsUsersByUserId(uid);
		int result = 0;
		if(user.getUserId()>0)
		{
			user.setPassword(password);
			result = functionInfoSystemBussiness.saveOrUpdateUsers(user);
		}
		try 
		{
			if(result>0)
			{
				Cookies cookies = new Cookies();
				cookies.putCookie(response, "password", password);
				return "uppwdsuccess";
			}
		} catch (Exception e) {
		}
		return "uppwderror";
	}

	/**
	 * 加密
	 * @param loginName		要加密字符串
	 * @param password      加密的密钥
	 * @return
	 */
	public String jiami(String loginName,String password)
	{
		String oldString = loginName;
		String SPKEY = password;
		System.out.println(oldString+"   dddd   "+SPKEY);
		MD5 md5 = new MD5();
		String reValue = md5.get3DESEncrypt(oldString, SPKEY);
		reValue = reValue.trim().intern();
		System.out.println("进行3-DES加密后的内容: " + reValue);
		String reValue2 = md5.get3DESDecrypt(reValue, password);
		System.out.println("进行3-DES解密后的内容: " + reValue2);
		return reValue;
	}
	
	/**
	 * 获取客户端真实IP地址
	 * @param request
	 * @return
	 */
	public String getIpAddr(HttpServletRequest request) {   
	       String ip = request.getHeader("x-forwarded-for");   
	       System.out.println("ip1 = "+ip);
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getHeader("Proxy-Client-IP");   
	           System.out.println("ip2 = "+ip);
	       }   
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getHeader("WL-Proxy-Client-IP");
	           System.out.println("ip3 = "+ip);
	       }   
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getRemoteAddr();
	           System.out.println("ip4 = "+ip);
	       }   
	       return ip;   
	} 
	
	/**********
	 * 进入账户管理界面
	 */
	public String zhgl(){
		
		Cookies cookies = new Cookies();
		String loginname = cookies.getCookie(request, "loginName");
		String password = cookies.getCookie(request, "password");
		
		Users users = functionInfoSystemBussiness.getObject(loginname, password);
		if(users.getUserId()>0)
		{
			request.setAttribute("user", users);
		}
		try {
			InetAddress address = InetAddress.getLocalHost();  
			// 保存登录IP与登录状态
			Employee emp=(Employee)request.getSession().getAttribute("emp");
			String hql="from Executerecord where employee.id="+emp.getId()+" and content like '%登陆了系统%' order by executeTime desc";
			List recordList=functionInfoSystemBussiness.exHql(hql);
			if(recordList!=null && recordList.size()>1){
				Executerecord bcrecord=(Executerecord)recordList.get(0);
				Executerecord screcord=(Executerecord)recordList.get(1);
				Map<String, String> map=new HashMap<String, String>();
				// 得到IP地址
				map.put("IP", address.getHostAddress());
				map.put("bclogintime",bcrecord.getExecuteTime());
				map.put("sclogintime", screcord.getExecuteTime());
				request.setAttribute("loginstate", map);
			}
		} catch (Exception e) {
		}
		
		return "accountmanager";
	}
	
}
