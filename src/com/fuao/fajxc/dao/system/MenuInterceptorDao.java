/**
 * 
 */
package com.fuao.fajxc.dao.system;

import java.util.List;

import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workposition;

/**
 * @author 蔡亚俊
 *
 * 2011-7-20
 */
public interface MenuInterceptorDao {

	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password);
	
	/**
	 * 根据用户id查询该用户是否存在访问权限
	 * @param userid
	 * @return
	 */
	public RoleFunctionInfo isExistsPermissionByUserId(int userid);
	
	/**
	 * 获取对象列表
	 * @param tableName
	 * @param andhql
	 * @return
	 */
	public List getObject(String tableName,String andhql);
	/************
	 * 根据部门编号找到岗位
	 */
	public List<Workposition> positionList(int deptid);
	/*********
	 * 得到当前登录人
	 */
	public Employee getObj(String loginname);
}
