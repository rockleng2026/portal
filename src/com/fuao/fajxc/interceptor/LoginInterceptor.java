/**
 * 
 */
package com.fuao.fajxc.interceptor;

import java.util.HashMap;
import java.util.List;




import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.StrutsStatics;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import sun.security.x509.AVA;

import com.fuao.fajxc.action.LoginAction;
import com.fuao.fajxc.dao.system.MenuInterceptorDao;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.UserGroupInfo;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workposition;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * @author 蔡亚俊
 *
 * 2011-7-13
 */
public class LoginInterceptor extends MethodFilterInterceptor implements ModelDriven,ServletRequestAware,ServletResponseAware{

	/**
	 * 日志记录
	 */
	private static Logger logger = Logger.getLogger(LoginInterceptor.class);
	private MenuInterceptorDao menuInterceptorDao;
	private Users users;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private String name;
	
	
	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.interceptor.MethodFilterInterceptor#doIntercept(com.opensymphony.xwork2.ActionInvocation)
	 */
	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("拦截器名称："+name);
		System.out.println("method : "+invocation.getProxy().getMethod());
		System.out.println("execute interceptor .... ");
		//根据上下文invocationContext获得ActionContext对象
		ActionContext ac = invocation.getInvocationContext();
		//根据Actioncontext特定参数StrutsStatics.HTTP_REQUEST获取http协议中的request
		HttpServletRequest request = (HttpServletRequest)ac.get(StrutsStatics.HTTP_REQUEST);
		//根据Actioncontext特定参数StrutsStatics.HTTP_RESPONSE获取http协议中的response
		HttpServletResponse response = (HttpServletResponse)ac.get(StrutsStatics.HTTP_RESPONSE);
		
		//获取当前登录人员登录信息
		Cookies cookies = new Cookies();
		String loginname = cookies.getCookie(request, "loginName");
		String password = cookies.getCookie(request, "password");
		String functionId = request.getParameter("funid");

		logger.error("拦截器："+"  login : "+loginname );
		//如若菜单没添加funid，系统为其添加上funid
		if(functionId==null||functionId=="")
		{
			StringBuffer url = request.getRequestURL();
//			System.out.println("url::::"+url);
			String dourl = url.substring((url.lastIndexOf("/")+1), url.length());
//			System.out.println("dourl::::"+dourl);
			List<FunctionInfo> list = menuInterceptorDao.getObject("FunctionInfo", " and linkFunctionPage like '%"+dourl+"%'");
			if(list.size()>0)
			{
				functionId = list.get(0).getFunctionId().toString();
			}
		}		
		
		Users users = menuInterceptorDao.getUsersByLoginName(loginname, password);
		RoleFunctionInfo rfi = menuInterceptorDao.isExistsPermissionByUserId(users.getUserId());
		// 根据当前登录人得到其岗位权限，要想找到岗位权限就先得当前登录人的所属部门
		Employee employee =menuInterceptorDao.getObj(loginname);
		System.out.println(employee.getDepartment().getId());
		// 根据部门得到其权限
		List<Workposition> positionList=menuInterceptorDao.positionList(employee.getDepartment().getId());
		String[] permissions = null;
		
		/*
		 * 用户对菜单是否具有操作权限（增删改查），
		 * 主要查询两张表，一、role表，角色默认的 权限；二、role_function_info表，系统管理员为其指定的特殊访问权限
		 * 首先，会去判断role_function_info表中是否有该对象记录，若有；查出员工对该菜单的操作权限
		 * 若没有，会从角色的默认的权限查找
		 * */
		//角色默认权限
		System.out.println("xxxxxxxxxxxxxxx操作权限");
		if(rfi.getRoleFunctionId()==0)
		{
			Roles roles = (Roles)menuInterceptorDao.getObject("Roles", " and roleId = "+users.getRoles().getRoleId()).get(0);
			permissions = roles.getPermissions().split(",");
		}
		else {	//为其添加的访问权限
			permissions = rfi.getPermissions().split(",");
		}
//		String p="";
//		//根据岗位设置权限	
//		if(positionList!=null && positionList.size()>0){
//			for(int i=0;i<positionList.size();i++){
//				Workposition position=positionList.get(i);
//				if(position.getPermissions()!=null && !position.getPermissions().equals("null") && !position.getPermissions().equals("")){
//					p+=position.getPermissions();
//				}
//			}
//		}else{
//		}
//		permissions=p.split(",");
		System.out.println("length ："+permissions.length);
		
		/*
		 * 得到操作权限集合后，将其封装在map中
		 * */
		Map map = new HashMap();
		if(functionId!=null){
			for(int j=0;j<permissions.length;j++)
			{
				if(Integer.parseInt(permissions[j].substring(0,permissions[j].indexOf(".") ))==Integer.parseInt(functionId))
				{
					map.put(permissions[j].substring((permissions[j].indexOf(".")+1), permissions[j].length()), permissions[j]);
				}
			}
		}
		System.out.println(1111111);
		/*
		 * 组权限
		 * */
		List<UserGroupInfo> list = menuInterceptorDao.getObject("UserGroupInfo", " and userId = "+users.getUserId());
		Map map1 = new HashMap();
		Map resouceMap = new HashMap();
		System.out.println("list.size::"+list.size());
		if(list.size()>0)
		{
			UserGroupInfo ugi = (UserGroupInfo)list.get(0);
			String[] groupids = ugi.getGroupIds().split(",");
			resouceMap.put("resouce", ugi.getResourcePermission());
			for(int i=0;i<groupids.length;i++)
			{
				Groups groups = (Groups)menuInterceptorDao.getObject("Groups", " and groupId = "+groupids[i]).get(0);
				map1.put(groups.getGrade(), groups.getGrade());
			}
		}
		ac.put("map", map);							//map  用户对列表操作权限集合
		ac.put("usergrade", map1);					//map1 用户等级列表
		ac.put("resouceSet",resouceMap);			//resouceMap  访问资源权限列表
		String result = invocation.invoke();
		return result;
	}
	public MenuInterceptorDao getMenuInterceptorDao() {
		return menuInterceptorDao;
	}
	public void setMenuInterceptorDao(MenuInterceptorDao menuInterceptorDao) {
		this.menuInterceptorDao = menuInterceptorDao;
	}

	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	public Object getModel() {
		// TODO Auto-generated method stub
		users=new Users();
		return users;
	}

	/* (non-Javadoc)
	 * @see org.apache.struts2.interceptor.ServletRequestAware#setServletRequest(javax.servlet.http.HttpServletRequest)
	 */
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request = request;
	}

	/* (non-Javadoc)
	 * @see org.apache.struts2.interceptor.ServletResponseAware#setServletResponse(javax.servlet.http.HttpServletResponse)
	 */
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = response;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
