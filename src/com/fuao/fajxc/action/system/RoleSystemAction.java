/**
 * 
 */
package com.fuao.fajxc.action.system;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.bussiness.system.RoleSystemBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.UserGroupInfo;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.regexp.internal.REUtil;

/**
 * @author 蔡亚俊
 * 
 *         2011-7-14
 */
public class RoleSystemAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private RoleSystemBussiness roleSystemBussiness;
	private FunctionInfoSystemBussiness functionInfoSystemBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Roles roles;

	/**
	 * 角色列表
	 * 
	 * @return
	 */
	public String roleList() {
		
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		Map map = (Map)ActionContext.getContext().get("map");
		System.out.println("execute rolelist .....  .....  ");
		List<Roles> roleList = roleSystemBussiness.getRolesList();
		System.out.println(ServletActionContext.getRequest()==null);
		if (roleList.size() > 0) {
			ServletActionContext.getRequest().getSession().setAttribute("rolelist", roleList);
			ServletActionContext.getRequest().setAttribute("option", map);
			return "rolelist";
		}
		return "failure";
	}

	
	/**
	 * 新增或修改角色信息
	 * 
	 * @return
	 */
	public String saveOrUpdate() {

		try {
			System.out.println("execute saveOrUpdate .......");
			String rolename = URLDecoder.decode(request.getParameter("rolename"), "utf-8");
			Integer superId = Integer.parseInt(request.getParameter("superid"));
			String desc = URLDecoder.decode(request.getParameter("desc"), "utf-8");
			Integer roleid = Integer.parseInt(request.getParameter("roleid"));

			int result = 0;
			Roles roles = roleSystemBussiness.getObject(roleid);
			boolean flag = roleSystemBussiness.isExistsRole(roles.getRoleName());
			System.out.println(" aaaa  " + flag);
			if (flag) {
				System.out.println("flag is true");
				Roles role = roleSystemBussiness.getObject(roleid);
				role.setRoleName(rolename);
				role.setSuperId(superId);
				role.setRoledescription(desc);

				result = roleSystemBussiness.saveOrUpdateRole(role);
			} else {
				System.out.println("flag is false");
				Roles role = new Roles();
				role.setRoleName(rolename);
				role.setSuperId(superId);
				role.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.format(new Date()));
				role.setRoleFunctionId(0);
				role.setRoledescription(desc);

				result = roleSystemBussiness.saveOrUpdateRole(role);
			}

			System.out.println("result ： " + result);

			if (result > 0) {
				this.response.getOutputStream().print(result);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}
	
	/**
	 * 修改按钮
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String editRole() throws UnsupportedEncodingException
	{
		System.out.println("editRole......");
		System.out.println(this.request==null);
		Integer roleid = Integer.parseInt(ServletActionContext.getRequest().getParameter("roleid"));
		System.out.println("roleid："+roleid);
		Roles roles = roleSystemBussiness.getObject(roleid);
		
		List<Roles> roleList = roleSystemBussiness.getRolesList();
		if (roleList.size() > 0&&roles.getRoleId()>0) {
			ServletActionContext.getRequest().setAttribute("rolelist", "");
			ServletActionContext.getRequest().setAttribute("rolelist", roleList);
			
			ServletActionContext.getRequest().setAttribute("role", "");
			ServletActionContext.getRequest().setAttribute("role", roles);
			return "edit";
		}
		return "failure";
	}

	/**
	 * 删除按钮
	 * @return
	 */
	public String delRole()
	{
		Integer roleid = Integer.parseInt(request.getParameter("roleid"));
		System.out.println(" delRole  id: "+roleid);
		Roles roles = roleSystemBussiness.getObject(roleid);
		
		int result = roleSystemBussiness.delRole(roles);
		System.out.println(result);
		try {
			if(result>0)
			{
				this.response.getOutputStream().print(result);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 设置角色权限页面显示
	 * @return
	 */
	public String rolePermsionSet()
	{
		String roleid = request.getParameter("roleid");
		List<FunctionInfo> functionlist = functionInfoSystemBussiness.getAllFunctions();
		List<FunctionInfo> superfunctionlist = functionInfoSystemBussiness.getFunctionsBySuperId(0);
		
		System.out.println(" r: "+roleid);
		Roles role = roleSystemBussiness.getObject(Integer.parseInt(roleid));
		
		System.out.println(" f:  "+role.getFunctionIds()+"  P:  "+role.getPermissions());
		
		request.getSession().setAttribute("roleid",roleid);
		request.getSession().setAttribute("functionIds", role.getFunctionIds());
		request.getSession().setAttribute("permissions", role.getPermissions());
		request.getSession().setAttribute("funcntionlist", functionlist);
		request.getSession().setAttribute("superfunctionlist", superfunctionlist);
		return "rolefunctionlist";
	}
	
	/**
	 * 给角色设置权限
	 * @return
	 */
	public String setRolePermission()
	{
		System.out.println("~~~~~~~~~~~~~~~~         into setRolePermission          ~~~~~~~~~~~~~~~~~~");
		Integer roleid = Integer.parseInt(request.getParameter("roleid"));
		String functionIDs = request.getParameter("functionIDs");
		String permissions = request.getParameter("permissions");
		
		System.out.println("rid : "+roleid+"  f:  "+functionIDs+"   p:   "+permissions);
		
		Roles roles = roleSystemBussiness.getObject(roleid);
		if(roles.getRoleId()>0)
		{
			roles.setFunctionIds(functionIDs);
			roles.setPermissions(permissions);
		}
		
		int result = roleSystemBussiness.saveOrUpdateRole(roles);
		System.out.println("result : "+result);
		try 
		{
			if(result>0)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	public void setRoleSystemBussiness(RoleSystemBussiness roleSystemBussiness) {
		this.roleSystemBussiness = roleSystemBussiness;
	}

	
	public void setFunctionInfoSystemBussiness(
			FunctionInfoSystemBussiness functionInfoSystemBussiness) {
		this.functionInfoSystemBussiness = functionInfoSystemBussiness;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	public Object getModel() {
		// TODO Auto-generated method stub
		roles = new Roles();
		return roles;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.struts2.interceptor.ServletRequestAware#setServletRequest(
	 * javax.servlet.http.HttpServletRequest)
	 */
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request = ServletActionContext.getRequest();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.struts2.interceptor.ServletResponseAware#setServletResponse
	 * (javax.servlet.http.HttpServletResponse)
	 */
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = ServletActionContext.getResponse();
	}

}
