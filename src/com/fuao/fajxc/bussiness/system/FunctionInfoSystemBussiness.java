/**
 * 
 */
package com.fuao.fajxc.bussiness.system;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Users;

/**
 * @author 蔡亚俊
 *
 * 2011-7-11
 */
public interface FunctionInfoSystemBussiness {

	/**
	 * 获取用户列表
	 * @return
	 */
	public List<Users> getUserList(String mark);
	
	/**
	 * 获取所有功能菜单
	 * @return
	 */
	public List<FunctionInfo> getAllFunctions();
	
	/**
	 * 获取superID下功能菜单
	 * @param superId
	 * @return
	 */
	public List<FunctionInfo> getFunctionsBySuperId(int superId);
	
	/**
	 * 设置用户访问权限
	 * @param userid
	 * @return
	 */
	public int setPermission(RoleFunctionInfo info);
	
	/**
	 * 根据用户id查询该用户是否存在访问权限
	 * @param userid
	 * @return
	 */
	public RoleFunctionInfo isExistsPermissionByUserId(int userid);
	
	/**
	 * 根据用户id查询该用户在roleFunctionInfo表中是否存在
	 * @param userid
	 * @return
	 */
	public boolean isPermissionByUserId(int userid);
	
	/**
	 * 根据用户id查询是否有该用户，有则返回这个对象
	 * @param userid
	 * @return
	 */
	public Users isExistsUsersByUserId(int userid);
	
	/**
	 * 根据用户名和密码获取用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getObject(String loginname,String password);
	
	/**
	 * 根据functionid获取功能对象
	 * @param functionid
	 * @return
	 */
	public FunctionInfo getFunctionInfoByFunctionId(int functionid);
	
	/**
	 * 根据linkFunctionName获取功能对象
	 * @param linkFunctionName
	 * @return
	 */
	public FunctionInfo getFunctionInfoByLinkFunctionName(String linkFunctionName);
	
	/**
	 * 添加或更新用户数据
	 * @param user
	 * @return
	 */
	public int saveOrUpdateUsers(Users user);
	
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public int delUsers(Users user);
	
	/**
	 * 获取用户和菜单关联列表
	 * @return
	 */
	public List<RoleFunctionInfo> getRoleFunctionInfoList();
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) ;
	
	/*
	 * 页面功能
	 */
	public List findobj(Integer id);
	/********
	 * 根据hql语句查询集合
	 */
	public List exHql(String hql);
}
