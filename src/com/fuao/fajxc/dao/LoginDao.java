package com.fuao.fajxc.dao;

import java.util.List;

import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Users;

public interface LoginDao {

	/**
	 *  判断是否有该用户
	 * @param users
	 * @return
	 */
	public boolean UserLogin(Users users);
	
	/**
	 * 查找员工/用户
	 */
	public Object selEmpOrCus(String mark,int id);
	
	/**
	 * 待办事项提醒，根据审核流程表得到对象
	 * @param hql
	 * @return
	 */
	public List<AuditingOrderTab> getAuditingOrder(String hql );
	
	public List getObjectList(String hql);

	public List executionSql(String sql);

	
	public String executeSql(String sql);

}
