/**
 * 
 */
package com.fuao.fajxc.action.system;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;

import com.fuao.fajxc.bussiness.system.MenuFunctionSystemBussiness;
import com.fuao.fajxc.bussiness.system.RoleSystemBussiness;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.pagefunction;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author 蔡亚俊
 *
 * 2011-7-20
 */
public class MenuManagerSystemAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	/**
	 * 日志记录
	 */
	private static Logger logger = Logger.getLogger(MenuManagerSystemAction.class);
	
	private FunctionInfoSystemBussiness functionInfoSystemBussiness;
	private MenuFunctionSystemBussiness menuFunctionSystemBussiness;
	private RoleSystemBussiness roleSystemBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	/**
	 * 菜单管理
	 * @return
	 */
	public String menuManager()
	{
		Map map = (Map)ActionContext.getContext().get("map");
		System.out.println(map);
		System.out.println("size : "+map.size());
		System.out.println("execute selectFunctions ........   ");
		List<FunctionInfo> functionlist = functionInfoSystemBussiness.getAllFunctions();
		List<FunctionInfo> superfunctionlist = functionInfoSystemBussiness.getFunctionsBySuperId(0);
		Map list = new HashMap();
		//循环出所有菜单下的页面功能
		if(functionlist != null && functionlist.size()>0)
		{
			for (int i = 0; i < functionlist.size(); i++)
			{
				FunctionInfo functionInfo = functionlist.get(i);
				if(functionInfo != null)
				{
					List pagefunctionlist = this.functionInfoSystemBussiness.findobj(functionInfo.getFunctionId());
					if(pagefunctionlist != null && pagefunctionlist.size()>0)
					{
						list.put(functionInfo.getFunctionId(),pagefunctionlist);
					}
				}
			}
		}
		//request.setAttribute("page", pagefunctionlist);
		if(functionlist.size()>0&&superfunctionlist.size()>0)
		{
			
			request.getSession().setAttribute("funcntionlist", functionlist);
			request.getSession().setAttribute("superfunctionlist", superfunctionlist);
			ServletActionContext.getRequest().setAttribute("option", map);
			request.setAttribute("page", list);
			return "menumanager";
		}
		return "failure";
	}
	
	/**************
	 * 岗位管理
	 * @return
	 */
	public String newmenuManager()
	{
		Map map = (Map)ActionContext.getContext().get("map");
		System.out.println(map);
		System.out.println("size : "+map.size());
		System.out.println("execute selectFunctions ........   ");
		List<FunctionInfo> functionlist = functionInfoSystemBussiness.getAllFunctions();
		List<FunctionInfo> superfunctionlist = functionInfoSystemBussiness.getFunctionsBySuperId(0);
		Map list = new HashMap();
		//循环出所有菜单下的页面功能
		if(functionlist != null && functionlist.size()>0)
		{
			for (int i = 0; i < functionlist.size(); i++)
			{
				FunctionInfo functionInfo = functionlist.get(i);
				if(functionInfo != null)
				{
					List pagefunctionlist = this.functionInfoSystemBussiness.findobj(functionInfo.getFunctionId());
					if(pagefunctionlist != null && pagefunctionlist.size()>0)
					{
						list.put(functionInfo.getFunctionId(),pagefunctionlist);
					}
				}
			}
		}
		//request.setAttribute("page", pagefunctionlist);
		if(functionlist.size()>0&&superfunctionlist.size()>0)
		{
			
			request.getSession().setAttribute("funcntionlist", functionlist);
			request.getSession().setAttribute("superfunctionlist", superfunctionlist);
			ServletActionContext.getRequest().setAttribute("option", map);
			request.setAttribute("page", list);
			return "newmenumanager";
		}
		return "failure";
	}
	
	/**
	 * 修改菜单
	 * @return
	 */
	public String editmenuFunction()
	{
		System.out.println("execute addMenuFunction .......   ");
		Integer functionid = Integer.parseInt(request.getParameter("functionid"));
		FunctionInfo info = functionInfoSystemBussiness.getFunctionInfoByFunctionId(functionid);
		FunctionInfo superInfo = functionInfoSystemBussiness.getFunctionInfoByFunctionId(info.getSuperId());
		
		System.out.println("linkname : "+info.getLinkFunctionName());
		if(info.getFunctionId()>0&&superInfo.getFunctionId()>0)
		{
			System.out.println(" execute if ");
			request.setAttribute("info", info);
			request.setAttribute("superinfo", superInfo);
			return "editmenufunction";
		}
		return "failure";
	}
	
	/**
	 * 修改模块
	 * @return
	 */
	public String editFunction()
	{
		System.out.println(" into editfunction .... ");
		Integer functionid = Integer.parseInt(request.getParameter("functionid"));
		System.out.println(functionid);
		FunctionInfo info = functionInfoSystemBussiness.getFunctionInfoByFunctionId(functionid);
		
		if(info.getSuperId()==0)
		{
			request.setAttribute("info", info);
			request.setAttribute("functionid", functionid);
			return "editfunction";
		}
		return "failure";
	}
	
	/**
	 * 新增
	 * @return
	 */
	public String save()
	{
		try 
		{
			System.out.println(" execute save ..... ");
			String linkFunctionName = URLDecoder.decode(request.getParameter("linkFunctionName"), "utf-8");
			Integer superId = Integer.parseInt(request.getParameter("superId"));
			String linkFunctionPage = request.getParameter("linkFunctionPage");
			String imagepath = request.getParameter("imagepath");
			String description = URLDecoder.decode(request.getParameter("description"),"utf-8");
			String verString=request.getParameter("versionFlag");
			FunctionInfo info = functionInfoSystemBussiness.getFunctionInfoByLinkFunctionName(linkFunctionName);
			System.out.println(info.getFunctionId()==0);
			int result = 0;
			
			System.out.println("  add or  update ..... ");
			
			FunctionInfo addinfo = new FunctionInfo();
			addinfo.setLinkFunctionName(linkFunctionName);
			addinfo.setSuperId(superId);
			addinfo.setLinkFunctionPage(linkFunctionPage);
			addinfo.setImagepath(imagepath);
			addinfo.setDescription(description);
			addinfo.setVersionFlag(Integer.parseInt(verString));
			
			result = menuFunctionSystemBussiness.saveOrUpdate(addinfo);
		
			
			if(superId==0&&result==1)
			{
				System.out.println(" into supeid = 0 ");
				response.getOutputStream().print(2);
			}
			else if(result==1)
			{
				response.getOutputStream().print(1);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 修改
	 * @return
	 */
	public String update()
	{
		try 
		{
			System.out.println(" execute Update ..... ");
			Integer functionid = Integer.parseInt(request.getParameter("functionid"));
			String linkFunctionName = URLDecoder.decode(request.getParameter("linkFunctionName"), "utf-8");
			Integer superId = Integer.parseInt(request.getParameter("superId"));
			String linkFunctionPage = request.getParameter("linkFunctionPage");
			String imagepath = request.getParameter("imagepath");
			String verString=request.getParameter("versionFlag");
			String description = URLDecoder.decode(request.getParameter("description"),"utf-8");
			
			FunctionInfo info = functionInfoSystemBussiness.getFunctionInfoByFunctionId(functionid);
			int result = 0;
			
			if(info.getFunctionId()>0)
			{
				info.setLinkFunctionName(linkFunctionName);
				info.setLinkFunctionPage(linkFunctionPage);
				info.setImagepath(imagepath);
				info.setDescription(description);
				info.setVersionFlag(Integer.parseInt(verString));
				result = menuFunctionSystemBussiness.saveOrUpdate(info)+1;
				
			}
			
			if(superId==0&&result==2)
			{
				response.getOutputStream().print(3);
			}
			else if(result==2)
			{
				response.getOutputStream().print(2);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 删除模块
	 * @return
	 */
	public String delfuntion()
	{
		System.out.println("execute delfunction ..... ");
		Integer functionid = Integer.parseInt(request.getParameter("functionid"));
		List<RoleFunctionInfo> rgilist = functionInfoSystemBussiness.getRoleFunctionInfoList();			//用户关联列表
		List<Roles> roleslist = roleSystemBussiness.getRolesList();
		String function = functionid.toString();
		
		int result1 = 0; //一级结果
		int result2 = 0; //二级结果
		int result3 = 0; //三级结果
		FunctionInfo info = functionInfoSystemBussiness.getFunctionInfoByFunctionId(functionid);
		List<FunctionInfo> infList = functionInfoSystemBussiness.getFunctionsBySuperId(info.getFunctionId());		// 1
		if(infList.size()>0)
		{
			for(int i=0;i<infList.size();i++)
			{
				List<FunctionInfo> ziinfo = functionInfoSystemBussiness.getFunctionsBySuperId(infList.get(i).getFunctionId());   // 2
				if(ziinfo.size()>0) 
				{
					for(int j=0;j<ziinfo.size();j++)
					{
						List<FunctionInfo> ziziinfo = functionInfoSystemBussiness.getFunctionsBySuperId(ziinfo.get(j).getFunctionId());   // 3
						if(ziziinfo.size()>0)
						{
							for(int k=0;i<ziziinfo.size();k++)
							{
								List<FunctionInfo> ziziziinfo = functionInfoSystemBussiness.getFunctionsBySuperId(ziinfo.get(k).getFunctionId());	 // 4
								if(ziziziinfo.size()==0)
								{
								}
							}
						}
						result3 = casecadeDel(roleslist,rgilist,ziinfo.get(j).getFunctionId().toString(),functionInfoSystemBussiness.getFunctionInfoByFunctionId(ziinfo.get(j).getFunctionId()));
					}
				}
				result2 = casecadeDel(roleslist,rgilist,infList.get(i).getFunctionId().toString(),functionInfoSystemBussiness.getFunctionInfoByFunctionId(infList.get(i).getFunctionId()));	
			}
		}
		
		result1 = casecadeDel(roleslist,rgilist,info.getFunctionId().toString(),functionInfoSystemBussiness.getFunctionInfoByFunctionId(info.getFunctionId()));	
		
		try 
		{
			if(result1==1)
			{
				response.getOutputStream().print(1);
			}
			else {
				response.getOutputStream().print(0);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	//删除菜单树上的菜单
	public int casecadeDel(List<Roles> roleslist,List<RoleFunctionInfo> rgilist,String function,FunctionInfo info)
	{
		if(roleslist.size()>0)
		{
			for(int i=0;i<roleslist.size();i++)
			{
				String[] rolesfunctionids = roleslist.get(i).getFunctionIds().split(",");
				String[] rolespermission = roleslist.get(i).getPermissions().split(",");
				String rolestr = "";
				String rolestr1 = "";
				
				for(int j=0;j<rolesfunctionids.length;j++)
				{
					if(!rolesfunctionids[j].equals(function))
					{
						rolestr += rolesfunctionids[j]+",";
					}
				}
				
				for(int k=0;k<rolespermission.length;k++)													//遍历操作权限数组，判断哪个是要删除的，提取出来
				{
					if(!rolespermission[k].substring(0, rolespermission[k].indexOf(".")).equals(function))
					{
						rolestr1 += rolespermission[k]+",";														//提取后的操作权限集合
					}
				}
				
				if(rolestr.length()!=roleslist.get(i).getFunctionIds().length())
				{
					System.out.println(" 修改角色功能树。。。 ");
					Roles roles = roleslist.get(i);
					roles.setFunctionIds(rolestr);
					roles.setPermissions(rolestr1);
					int resultrole = roleSystemBussiness.saveOrUpdateRole(roles);
					System.out.println("resultrole  :  "+resultrole);
				}
			}
		}
		
		if(rgilist.size()>0)
		{
			for(int i=0;i<rgilist.size();i++)
			{
				String[] functionids = rgilist.get(i).getFunctionIds().split(",");						//功能数组
				String[] permissions = rgilist.get(i).getPermissions().split(",");						//操作权限数组
				String str = "";
				String str1 = "";
				
				for(int j=0;j<functionids.length;j++)													//遍历功能数组，判断哪个是要删除的，提取出来
				{
					if(!functionids[j].equals(function))
					{
						str += functionids[j]+",";														//提取后的功能集合
					}
				}
				
				if(!rgilist.get(i).getPermissions().equals("")&&rgilist.get(i).getPermissions()!=null)
				{
					for(int k=0;k<permissions.length;k++)													//遍历操作权限数组，判断哪个是要删除的，提取出来
					{
						if(!permissions[k].substring(0, permissions[k].indexOf(".")).equals(function))
						{
							str1 += permissions[k]+",";														//提取后的操作权限集合
						}
					}
				}
				else
				{
					str1 = "";
				}
				
				if(str.length()!=rgilist.get(i).getFunctionIds().length())
				{
					System.out.println(" 修改功能树。。。 ");
					int userid = rgilist.get(i).getUsers().getUserId();
					RoleFunctionInfo infos = functionInfoSystemBussiness.isExistsPermissionByUserId(userid);				
					infos.setFunctionIds(str);
					infos.setPermissions(str1);
					int result = functionInfoSystemBussiness.setPermission(infos);
				}
			}
		}
		int result = 0;
		if(info.getFunctionId()>0)
		{
			result = menuFunctionSystemBussiness.delFunctionMenu(info);
		}
		return result;
	}
	
	/*
	 * 查询这个是否有链接
	 */
	public String findFund()
	{
		try {
			
			logger.info("find by one functioninfo start+"+MenuManagerSystemAction.class.getName());
			String fundid = request.getParameter("fundids");
			Integer funids = 0;
			if(!fundid.equals(""))
			{
				funids = new Integer(fundid);
			}
			FunctionInfo functionInfo =this.functionInfoSystemBussiness.getFunctionInfoByFunctionId(funids);
			
			if(functionInfo != null)
			{
				if(functionInfo.getLinkFunctionPage().equals(""))
				{
					response.getWriter().print("1");
				}
				else
				{
					response.getWriter().print("2");
				}
			}
			else
			{
				response.getWriter().print("3");
			}
		} catch (Exception e) {
			logger.error("find by one functioninfo error"+MenuManagerSystemAction.class.getName());
		}
		return null;
	}
			
	
	
	
	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
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

	public void setFunctionInfoSystemBussiness(
			FunctionInfoSystemBussiness functionInfoSystemBussiness) {
		this.functionInfoSystemBussiness = functionInfoSystemBussiness;
	}

	public void setMenuFunctionSystemBussiness(
			MenuFunctionSystemBussiness menuFunctionSystemBussiness) {
		this.menuFunctionSystemBussiness = menuFunctionSystemBussiness;
	}

	public void setRoleSystemBussiness(RoleSystemBussiness roleSystemBussiness) {
		this.roleSystemBussiness = roleSystemBussiness;
	}
	
}
