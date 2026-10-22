/**
 * 
 */
package com.fuao.fajxc.bussiness.system;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workposition;

/**
 * @author 蔡亚俊
 *
 * 2011-7-14
 */
public interface RoleSystemBussiness {

	/**
	 * 获得所有角色列表
	 * @return
	 */
	public List<Roles> getRolesList();
	
	/**
	 * 新增或修改角色信息
	 * @param role
	 * @return
	 */
	public int saveOrUpdateRole(Roles role);
	
	/**
	 * 查询是否存在该角色
	 * @param roleid
	 * @return
	 */
	public boolean isExistsRole(String rolename);
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Roles getObject(String rolename);
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Roles getObject(int roleId);
	
	/**
	 * 根据id删除角色
	 * @param roles
	 * @return
	 */
	public int delRole(Roles roles);
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password);
	
	/**
	 * 删除role_Function_info
	 * @param groups
	 * @return
	 */
	public boolean deleteRoleFunctionInfo(RoleFunctionInfo info);
	/************
	 * 根据部门编号找到岗位
	 */
	public List<Workposition> positionList(int empid);
	/******
	 * 根据编号找到对象
	 */
	public Object getObject(Class clazz, Integer id);
	/*********
	 * 根据hql语句找到集合
	 */
	public List getlist(String hql);
}
