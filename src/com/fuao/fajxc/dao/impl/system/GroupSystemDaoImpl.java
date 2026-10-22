/**
 * 
 */
package com.fuao.fajxc.dao.impl.system;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.dao.system.GroupSystemDao;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.UserGroupInfo;


/**
 * @author 蔡亚俊
 *
 * 2011-7-15
 */
public class GroupSystemDaoImpl extends HibernateDaoSupport implements GroupSystemDao {

	/**
	 * 组列表
	 * @return
	 */
	public List<Groups> groupsList()
	{
		String hql = "from Groups";
		Query query = this.getSession().createQuery(hql);
		List<Groups> grouplist = query.list();
		if(grouplist.size()>0)
		{
			return grouplist;
		}
		return null;
	}
	
	/**
	 * 父组列表
	 * @return
	 */
	public List<Groups> superGroupsList()
	{
		String hql = "from Groups g where g.superGroupId = 0";
		Query query = this.getSession().createQuery(hql);
		List<Groups> grouplist = query.list();
		if(grouplist.size()>0)
		{
			return grouplist;
		}
		return null;
	}
	
	/**
	 * 根据用户id，盘点是否有关于该用户的相关对象存在
	 * @param userid
	 * @return
	 */
	public boolean isExistsUserGroupInfo(int userid)
	{
		System.out.println("isExistsUserGroupInfo   .............");
		boolean flag = false;
		UserGroupInfo rgf = this.getUserGroupInfo(userid);
		if(rgf.getUserGroupId()>0)
		{
			flag = true;
		}
		if(rgf.getUserGroupId()==null)
			System.out.println("flag : "+flag);
		return flag;
	}

	/**
	 * 根据用户id，获得该记录
	 * @param userid
	 * @return
	 */
	public UserGroupInfo getUserGroupInfo(int userid)
	{
		System.out.println("getUserGroupInfo~~~~~~~~~~~~~~~~~~~~~");
		String hql = "from UserGroupInfo ugf where ugf.users.userId = ?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, userid);
		UserGroupInfo rgf = new UserGroupInfo();
		if(query.list().size()>0)
		{
			System.out.println(query.list().size());
			rgf = (UserGroupInfo)query.list().get(0);
			return rgf;
		}
		else 
		{
			rgf.setUserGroupId(0);
		}
		return rgf;
	}
	
	/**
	 * 添加或修改设置权限等级
	 * @param rgi
	 * @return
	 */
	public int saveOrUpdateGroup(UserGroupInfo rgi)
	{
		System.out.println("saveOrUpdateGroup.................");
		int result = 0;
		this.getSession().saveOrUpdate(rgi);
		if(this.isExistsUserGroupInfo(rgi.getUsers().getUserId())){
			System.out.println("111   11   1");
			result = 1;
		}
		
		return result;
	}
	
	/**
	 * 根据id，获得组对象
	 * @param groupid
	 * @return
	 */
	public List<Groups> getGroups(String groupids)
	{
		String[] groupid = groupids.split(",");
		List<Groups> groupslist = new ArrayList<Groups>();
		System.out.println("getGroups .....   groupid.length = "+groupid.length);
		for(int i=0;i<groupid.length;i++)
		{
			String hql = "from Groups g where g.groupId = ?";
			Query query = this.getSession().createQuery(hql);
			query.setInteger(0, Integer.parseInt(groupid[i]));
			if(query.list().size()>0)
			{
				Groups groups = (Groups)query.list().get(0);
				groupslist.add(groups);
			}
		}
		System.out.println(groupslist.size());
		return groupslist;
	}
	
	/**
	 * 获取所有用户权限等级列表
	 * @return
	 */
	public List<UserGroupInfo> getGroupInfoList()
	{
		System.out.println("getGroupInfoList  .......  ");
		String hql = "from UserGroupInfo";
		Query query = this.getSession().createQuery(hql);
		List<UserGroupInfo> list = query.list();
		if(list.size()>0)
		{System.out.println("size : "+list.size());
			return list;
		}
		return null;
	}
	
	/**
	 * 根据id，获得组对象
	 * @param groupid
	 * @return
	 */
	public Groups getObjectByGroupId(int groupid)
	{
		String hql = "from Groups g where g.groupId = ?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, groupid);
		Groups groups = new Groups();
		if(query.list().size()>0)
		{
			groups = (Groups)query.list().get(0);
			
		}
		else {
			groups.setGroupId(0);
		}
		return groups;
	}
	
	/**
	 * 根据groupName获取组对象
	 * @param groupName
	 * @return
	 */
	public Groups getObjectByGroupName(String groupName)
	{
		String hql = "from Groups g where g.groupName = ?";
		Query query = this.getSession().createQuery(hql);
		query.setString(0, groupName);
		Groups groups = new Groups();
		if(query.list().size()>0)
		{
			groups = (Groups)query.list().get(0);
		}
		else
		{
			groups.setGroupName("");
		}
		return groups;
	}
	
	/**
	 * 添加修改组
	 * @param groups
	 * @return
	 */
	public int addOrUpdateGroup(Groups groups)
	{
		System.out.println("~~~~~~~~~~~~~~~ into groups  ~~~~~~~~~~~~~~~~~");
		int result = 0;
		this.getSession().saveOrUpdate(groups);
		if(this.getObjectByGroupId(groups.getGroupId()).getGroupId()>0)
		{
			result = 1;
		}
		return result ; 
	}
	
	/**
	 * 删除组成员
	 * @param groups
	 * @return
	 */
	public int deleteGroup(Groups groups)
	{
		System.out.println("  ~~~~~~~~ ~~~~~~  into delete  ~~~~~~~~~~~~~~~~~~~~~");
		int result = 0;
		if(groups!=null)
		{
			this.getSession().delete(groups);
			result = 1;
		}
		return result;
	}
	
	/**
	 * 删除UserGroupInfo
	 * @param groups
	 * @return
	 */
	public boolean deleteGroupUserInfo(UserGroupInfo info)
	{
		boolean flag=true;
		try
		{
			this.getHibernateTemplate().delete(info);
		}
		catch(Exception ex)
		{
			logger.error("删除角色错误",ex);
			flag=false;
			ex.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 获取对象列表
	 * @param hql
	 * @return
	 */
	public List getObject(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
}
