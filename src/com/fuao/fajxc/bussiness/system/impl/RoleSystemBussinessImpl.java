/**
 * 
 */
package com.fuao.fajxc.bussiness.system.impl;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.bussiness.system.RoleSystemBussiness;
import com.fuao.fajxc.dao.system.RoleSystemDao;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workposition;

/**
 * @author 蔡亚俊
 *
 * 2011-7-14
 */
public class RoleSystemBussinessImpl implements RoleSystemBussiness {

	private RoleSystemDao roleSystemDao ;
	
	/**
	 * 获得所有角色列表
	 * @return
	 */
	public List<Roles> getRolesList()
	{
		return roleSystemDao.getRolesList();
	}
	
	/**
	 * 新增或修改角色信息
	 * @param role
	 * @return
	 */
	public int saveOrUpdateRole(Roles role)
	{
		return roleSystemDao.saveOrUpdateRole(role);
	}
	
	/**
	 * 查询是否存在该角色
	 * @param roleid
	 * @return
	 */
	public boolean isExistsRole(String rolename)
	{
		return roleSystemDao.isExistsRole(rolename);
	}
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Roles getObject(String rolename)
	{
		return roleSystemDao.getObject(rolename);
	}
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Roles getObject(int roleId)
	{
		return roleSystemDao.getObject(roleId);
	}
	
	/**
	 * 根据id删除角色
	 * @param roles
	 * @return
	 */
	public int delRole(Roles roles)
	{
		return roleSystemDao.delRole(roles);
	}
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password)
	{
		return roleSystemDao.getUsersByLoginName(loginname, password);
	}
	
	/**
	 * 删除role_Function_info
	 * @param groups
	 * @return
	 */
	public boolean deleteRoleFunctionInfo(RoleFunctionInfo info)
	{
		return roleSystemDao.deleteRoleFunctionInfo(info);
	}
	
	public void setRoleSystemDao(RoleSystemDao roleSystemDao) {
		this.roleSystemDao = roleSystemDao;
	}
	
	/************
	 * 根据部门编号找到岗位
	 */
	public List<Workposition> positionList(int empid){
		return roleSystemDao.positionList(empid);
	}
	
	/******
	 * 根据编号找到对象
	 */
	public Object getObject(Class clazz, Integer id){
		return roleSystemDao.getObject(clazz, id);
	}
	/*********
	 * 根据hql语句找到集合
	 */
	public List getlist(String hql){
		return roleSystemDao.getlist(hql);
	}
	
}
