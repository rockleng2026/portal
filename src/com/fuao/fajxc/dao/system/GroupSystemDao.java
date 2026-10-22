/**
 * 
 */
package com.fuao.fajxc.dao.system;

import java.util.List;

import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.UserGroupInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-15
 */
public interface GroupSystemDao {

	/**
	 * 组列表
	 * @return
	 */
	public List<Groups> groupsList();
	
	/**
	 * 父组列表
	 * @return
	 */
	public List<Groups> superGroupsList();
	
	/**
	 * 根据用户id，盘点是否有关于该用户的相关对象存在
	 * @param userid
	 * @return
	 */
	public boolean isExistsUserGroupInfo(int userid);
	
	/**
	 * 根据用户id，获得该记录
	 * @param userid
	 * @return
	 */
	public UserGroupInfo getUserGroupInfo(int userid);

	/**
	 * 添加或修改设置权限等级
	 * @param rgi
	 * @return
	 */
	public int saveOrUpdateGroup(UserGroupInfo rgi);
	
	/**
	 * 根据id，获得组对象
	 * @param groupid
	 * @return
	 */
	public List<Groups> getGroups(String groupids);
	
	/**
	 * 获取所有用户权限等级列表
	 * @return
	 */
	public List<UserGroupInfo> getGroupInfoList();
	
	/**
	 * 根据id，获得组对象
	 * @param groupid
	 * @return
	 */
	public Groups getObjectByGroupId(int groupid);
	
	/**
	 * 根据groupName获取组对象
	 * @param groupName
	 * @return
	 */
	public Groups getObjectByGroupName(String groupName);
	
	/**
	 * 添加修改组
	 * @param groups
	 * @return
	 */
	public int addOrUpdateGroup(Groups groups);
	
	/**
	 * 删除组成员
	 * @param groups
	 * @return
	 */
	public int deleteGroup(Groups groups);
	
	/**
	 * 获取对象列表
	 * @param hql
	 * @return
	 */
	public List getObject(String hql);
	
	/**
	 * 删除UserGroupInfo
	 * @param groups
	 * @return
	 */
	public boolean deleteGroupUserInfo(UserGroupInfo info);
	
}
