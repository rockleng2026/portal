/**
 * 
 */
package com.fuao.fajxc.action.system;

import java.io.IOException;
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
import org.aspectj.weaver.IWeavingSupport;

import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.UserGroupInfo;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.jndi.toolkit.url.Uri;
import com.sun.jndi.url.iiopname.iiopnameURLContextFactory;

/**
 * @author 蔡亚俊
 *
 * 2011-7-15
 */
public class GroupSystemAction implements ModelDriven, ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private HttpServletResponse response;
	private GroupSystemBussiness groupSystemBussiness;
	private FunctionInfoSystemBussiness functionInfoSystemBussiness;
	private Groups groups;
	public Map map = new HashMap();
	
	public GroupSystemAction()
	{
		map.put("5.0", "★★★★★");
		map.put("4.5", "★★★★★☆");
		map.put("4.0", "★★★★");
		map.put("3.5", "★★★☆");
		map.put("3.0", "★★★");
		map.put("2.5", "★★☆");
		map.put("2.0", "★★");
		map.put("1.5", "★☆");
		map.put("1.0", "★");
		map.put("0.5", "☆");
	}
	
	/**
	 * 页面跳转
	 * @return
	 */
	public String skippage()
	{
		String groupid = request.getParameter("groupid");
		String mark = request.getParameter("mark");
		
		List<Groups> supergrouplist = groupSystemBussiness.getObject("Groups", " and grade = 0 and permissiongrade = 0");
		List<Groups> grouppermissionlist = groupSystemBussiness.getObject("Groups", " and superGroupId = 0 and permissiongrade = 0 and grade > 0");
		List<Groups> grouppermissionlist2 = groupSystemBussiness.getObject("Groups", " and permissiongrade = 0 and grade > 0 and superGroupId = "+groupid);
		List<Groups> list = new ArrayList<Groups>();
		for(int i=0;i<grouppermissionlist.size();i++)
		{
			list.add(grouppermissionlist.get(i));
		}
		for(int k=0;k<grouppermissionlist2.size();k++)
		{
			list.add(grouppermissionlist2.get(k));
		}
		if(supergrouplist.size()>0)
		{
			if(mark.equals("edit"))
			{
				Groups groups = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(groupid));
				Groups supergroup = groupSystemBussiness.getObjectByGroupId(groups.getSuperGroupId());
				Groups permission = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(groups.getPermissionGrade()));
				request.setAttribute("groups", groups);
				request.setAttribute("supergroups", supergroup);
				request.setAttribute("permission", permission);
				request.setAttribute("grouppermissionlist", list);
			}
			if(mark.equals("add")){	
				
				request.setAttribute("grouppermissionlist", list);
			}
			
			if(mark.equals("create"))
			{
				request.setAttribute("superlist", supergrouplist);
				return "creategroup";
			}
			if(mark.equals("editcrea"))
			{
				List<Groups> supergrouplist1 = groupSystemBussiness.getObject("Groups", " and grade = 0 and permissiongrade = 0 and groupId != "+groupid);
				Groups groups = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(groupid));
				request.setAttribute("superlist", supergrouplist1);
				request.setAttribute("groups", groups);
				return "creategroup";
			}
			if(mark.equals("grouppermission"))
			{
				Groups groups = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(groupid));
				request.setAttribute("group", groups);
				return "gradepermission";
			}
			request.setAttribute("groupid", groupid);
			request.setAttribute("superlist", supergrouplist);
			return "addgroup";
		}
		return "failure";
	}
	
	/**
	 * 组/成员列表
	 * @return
	 */
	public String groupList()
	{
		Map map = (Map)ActionContext.getContext().get("map");
		Map usergrade = (Map)ActionContext.getContext().get("usergrade");
		List<Groups> grouplist = groupSystemBussiness.getObject("Groups", " and grade >0 and permissiongrade >0");
		List<Groups> supergrouplist = groupSystemBussiness.getObject("Groups", " and grade = 0 and permissiongrade = 0");
		List<Groups> grouppermissionlist = groupSystemBussiness.getObject("Groups", " and permissiongrade = 0 and grade > 0");
		
		ServletActionContext.getRequest().setAttribute("grouplist", "");
		ServletActionContext.getRequest().setAttribute("supergrouplist", "");
		if(grouplist.size()>0&&supergrouplist.size()>0)
		{
			ServletActionContext.getRequest().setAttribute("grouplist", grouplist);
			ServletActionContext.getRequest().setAttribute("supergrouplist", supergrouplist);
			ServletActionContext.getRequest().setAttribute("grouppermissionlist", grouppermissionlist);
			ServletActionContext.getRequest().getSession().setAttribute("option", map);
			ServletActionContext.getRequest().setAttribute("usergrade", usergrade);
			return "grouplist";
		}
		return "failure";
	}
	
	/**
	 * 权限等级列表
	 * @return
	 */
	public String permissionGradeList()
	{
		Integer userid = Integer.parseInt(request.getParameter("userid"));
	
		List<Groups> grouplist = groupSystemBussiness.getObject("Groups", " and grade >0 and permissiongrade >0");
		List<Groups> supergrouplist = groupSystemBussiness.getObject("Groups", " and grade = 0 and permissiongrade = 0");
		Users users = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
		UserGroupInfo ugi = groupSystemBussiness.getUserGroupInfo(userid);
		
		String supergroupid = "";
		if(ugi.getUserGroupId()>0)
		{
			List<Groups> groupslist = groupSystemBussiness.getGroups(ugi.getGroupIds());	
			if(groupslist.size()>0)
			{
				for(int i=0;i<groupslist.size();i++)
				{
					supergroupid+=groupslist.get(i).getSuperGroupId()+",";
				}
			}
		}
		
		
		List<FunctionInfo> infolist = groupSystemBussiness.getObject("FunctionInfo", " and linkFunctionName like '%列表%'");	
		request.setAttribute("infolist1", infolist);
		
		if(grouplist.size()>0&&supergrouplist.size()>0&&users.getUserId()>0)
		{
			request.setAttribute("supergroupid", supergroupid);
			request.setAttribute("usergroupinfo", ugi);
			request.setAttribute("user", users);
			request.setAttribute("grouplist", grouplist);
			request.setAttribute("supergrouplist", supergrouplist);
			request.setAttribute("map", map);
			return "setpermissiongrade";
		}
		return "failure";
	}
	
	/**
	 * 权限等级设置
	 * @return
	 */
	public String setPermissionGrade()
	{
		Integer userid = Integer.parseInt(request.getParameter("userid"));
		String groupids = request.getParameter("groupid");
		String supergroupids = request.getParameter("supergroupids");
		String resourcePermission = request.getParameter("resourcePermission");
		String[] aaStrings = groupids.split(",");
		
		for(int i=0;i<aaStrings.length;i++)
		{
			Groups groups = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(aaStrings[i]));
			
		}
		boolean flag = this.groupSystemBussiness.isExistsUserGroupInfo(userid);
		int result = 0;
		if(flag)
		{
			UserGroupInfo ugi = groupSystemBussiness.getUserGroupInfo(userid);
			ugi.setSupergroupIds(supergroupids);
			ugi.setGroupIds(groupids);
			ugi.setResourcePermission(resourcePermission);
			result = groupSystemBussiness.saveOrUpdateGroup(ugi);
		}
		else
		{
			Users users = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
			UserGroupInfo ugi = new UserGroupInfo();
			ugi.setUsers(users);
			ugi.setSupergroupIds(supergroupids);
			ugi.setGroupIds(groupids);
			result = groupSystemBussiness.saveOrUpdateGroup(ugi);
		}
		try {
			if(result>0)
			{
				response.getOutputStream().print(result);
			}
			else
			{
				response.getOutputStream().print(0);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	/**
	 * 用户权限等级
	 * @return
	 */
	public String userPermissionGradeList()
	{
		List<UserGroupInfo> ugfList = groupSystemBussiness.getGroupInfoList();
		if(ugfList.size()>0)
		{
			this.request.setAttribute("usergroupinfolist", ugfList);
			return "userpermissiongradelist";
		}
		return "failure";
	}
	
	
	
	public String addOrUpdate()
	{
		try 
		{
			Integer groupId = Integer.parseInt(request.getParameter("groupid"));
			String groupName = URLDecoder.decode(request.getParameter("groupName"),"utf-8");
			Integer superGroupId = Integer.parseInt(request.getParameter("superGroupId"));
			String permissionGrade = URLDecoder.decode(request.getParameter("permissionGrade"),"utf-8");
			String description = URLDecoder.decode(request.getParameter("description"),"utf-8");
			System.out.println("P : "+permissionGrade);
			
			Groups grade = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(permissionGrade));
			
			Groups groups = groupSystemBussiness.getObjectByGroupName(groupName);
			int result = 0;
			if(groupId==0)
			{
				Groups group = new Groups();
				group.setGroupName(groupName);
				group.setSuperGroupId(superGroupId);
				group.setPermissionGrade(permissionGrade);
				group.setGrade(grade.getGrade());
				group.setStartTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				group.setDescription(description);
				
				result = groupSystemBussiness.addOrUpdateGroup(group);
			}
			if(groupId>0)
			{
				Groups groups2 = groupSystemBussiness.getObjectByGroupId(groupId);
				System.out.println(groups2.getGroupId());
				groups2.setGroupName(groupName);
				groups2.setPermissionGrade(permissionGrade);
				groups2.setDescription(description);
				
				result = groupSystemBussiness.addOrUpdateGroup(groups2)+1;
			}
			
			System.out.println("result = "+result);
			
			if(result==1)
			{
				response.getOutputStream().print(result);
			}
			if(result==2)
			{
				response.getOutputStream().print(result);
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String addCreate()
	{
		try 
		{
			groups.setGroupName(URLDecoder.decode(groups.getGroupName(),"utf-8"));
			groups.setDescription(URLDecoder.decode(groups.getDescription(),"utf-8"));
			groups.setGrade(0.0);
			groups.setPermissionGrade("0");
			groups.setStartTime(new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date()));
			
			int result = groupSystemBussiness.addOrUpdateGroup(groups);
			
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
	
	public String editCreate()
	{
		try 
		{
			Integer gid = Integer.parseInt(request.getParameter("gid"));
			String groupname = URLDecoder.decode(groups.getGroupName(),"utf-8");
			int sid = groups.getSuperGroupId();
			String description = URLDecoder.decode(groups.getDescription(),"utf-8");
			System.out.println("sid: "+groups.getSuperGroupId());
			Groups groups = groupSystemBussiness.getObjectByGroupId(gid);
			groups.setSuperGroupId(sid);
			groups.setGroupName(groupname);
			groups.setDescription(description);
			
			int result = groupSystemBussiness.addOrUpdateGroup(groups);
			
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
	
	public String addGrade()
	{
		try 
		{
			groups.setGroupName(URLDecoder.decode(groups.getGroupName(),"utf-8"));
			groups.setDescription(URLDecoder.decode(groups.getDescription(),"utf-8"));
			groups.setPermissionGrade("0");
			groups.setStartTime(new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date()));
			
			int result = groupSystemBussiness.addOrUpdateGroup(groups);
			
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
	
	public String delete()
	{
		System.out.println("   delete into ..........    ");
		Integer gid = Integer.parseInt(request.getParameter("gid"));
		Groups groups = groupSystemBussiness.getObjectByGroupId(gid);
		int result = 0;
		if(groups.getGroupId()>0)
		{
			result = groupSystemBussiness.deleteGroup(groups);
		}
		
		try 
		{
			if(result==1)
			{
				response.getOutputStream().print(result);
			}
			else
			{
				response.getOutputStream().print(0);	
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	public String selectgradelist()
	{
		String groupid = request.getParameter("groupid");
		List<Groups> groupslist = groupSystemBussiness.getObject("Groups", " and permissionGrade = 0 and grade > 0");
		request.setAttribute("grouplist", groupslist);
		request.setAttribute("map", map);
		request.setAttribute("groupid", groupid);
		return "selectgrouplist";
	}
	
	public void setGroupSystemBussiness(GroupSystemBussiness groupSystemBussiness) {
		this.groupSystemBussiness = groupSystemBussiness;
	}
	

	public void setFunctionInfoSystemBussiness(
			FunctionInfoSystemBussiness functionInfoSystemBussiness) {
		this.functionInfoSystemBussiness = functionInfoSystemBussiness;
	}

	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	public Object getModel() {
		// TODO Auto-generated method stub
		groups = new Groups();
		return groups;
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

}
