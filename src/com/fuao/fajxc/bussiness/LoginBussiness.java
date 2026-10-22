package com.fuao.fajxc.bussiness;

import java.util.List;

import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Users;

public interface LoginBussiness {

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
	

	/**
	 * 执行sql语句
	 * @param sql
	 * @return
	 */


	public List executionSql(String sql);


	public String executeSql(String sql);
	
	public List executeHql(String hql);

}
