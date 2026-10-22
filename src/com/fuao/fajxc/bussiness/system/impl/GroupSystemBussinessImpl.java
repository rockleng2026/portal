/**
 * 
 */
package com.fuao.fajxc.bussiness.system.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.dao.system.GroupSystemDao;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.UserGroupInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-15
 */
public class GroupSystemBussinessImpl implements GroupSystemBussiness {

	private GroupSystemDao groupSystemDao ;

	/**
	 * 组列表
	 * @return
	 */
	public List<Groups> groupsList()
	{
		return groupSystemDao.groupsList();
	}
	
	/**
	 * 父组列表
	 * @return
	 */
	public List<Groups> superGroupsList()
	{
		return groupSystemDao.superGroupsList();
	}
	
	/**
	 * 根据用户id，盘点是否有关于该用户的相关对象存在
	 * @param userid
	 * @return
	 */
	public boolean isExistsUserGroupInfo(int userid)
	{
		return groupSystemDao.isExistsUserGroupInfo(userid);
	}
	
	/**
	 * 根据用户id，获得该记录
	 * @param userid
	 * @return
	 */
	public UserGroupInfo getUserGroupInfo(int userid)
	{
		return groupSystemDao.getUserGroupInfo(userid);
	}
	
	/**
	 * 添加或修改设置权限等级
	 * @param rgi
	 * @return
	 */
	public int saveOrUpdateGroup(UserGroupInfo rgi)
	{
		return groupSystemDao.saveOrUpdateGroup(rgi);
	}
	
	/**
	 * 根据id，获得组对象
	 * @param groupid
	 * @return
	 */
	public List<Groups> getGroups(String groupids)
	{
		return groupSystemDao.getGroups(groupids);
	}
	
	/**
	 * 获取所有用户权限等级列表
	 * @return
	 */
	public List<UserGroupInfo> getGroupInfoList()
	{
		return groupSystemDao.getGroupInfoList();
	}
	
	/**
	 * 根据id，获得组对象
	 * @param groupid
	 * @return
	 */
	public Groups getObjectByGroupId(int groupid)
	{
		return groupSystemDao.getObjectByGroupId(groupid);
	}
	
	/**
	 * 根据groupName获取组对象
	 * @param groupName
	 * @return
	 */
	public Groups getObjectByGroupName(String groupName)
	{
		return groupSystemDao.getObjectByGroupName(groupName);
	}
	
	/**
	 * 添加修改组
	 * @param groups
	 * @return
	 */
	public int addOrUpdateGroup(Groups groups)
	{
		return groupSystemDao.addOrUpdateGroup(groups);
	}
	
	/**
	 * 删除组成员
	 * @param groups
	 * @return
	 */
	public int deleteGroup(Groups groups)
	{
		return groupSystemDao.deleteGroup(groups);
	}
	
	/**
	 * 获取对象列表
	 * @param hql
	 * @return
	 */
	public List getObject(String tableName, String andhql)
	{
		String hql = "from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		return groupSystemDao.getObject(hql);
	}
	/**
	 * 删除UserGroupInfo
	 * @param groups
	 * @return
	 */
	public boolean deleteGroupUserInfo(UserGroupInfo info)
	{
		return groupSystemDao.deleteGroupUserInfo(info);
	}
	
	public void setGroupSystemDao(GroupSystemDao groupSystemDao) {
		this.groupSystemDao = groupSystemDao;
	}
}
