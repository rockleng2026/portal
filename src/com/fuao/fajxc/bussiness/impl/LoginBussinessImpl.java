package com.fuao.fajxc.bussiness.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.dao.LoginDao;
import com.fuao.fajxc.dao.impl.LoginDaoImpl;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Users;

public class LoginBussinessImpl implements LoginBussiness {

	/**
	 * 登录Dao注入
	 */
	private LoginDao loginDao;	
	
	/**
	 * @return the loginDao
	 */
	public LoginDao getLoginDao() {
		return loginDao;
	}

	/**
	 * @param loginDao the loginDao to set
	 */
	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}

	public boolean UserLogin(Users users) {
		boolean flag=loginDao.UserLogin(users);
		return flag;
	}


	public Object selEmpOrCus(String mark, int id) {
		// TODO Auto-generated method stub
		return loginDao.selEmpOrCus(mark, id);
	}
	
	/**
	 * 待办事项提醒，根据审核流程表得到对象
	 * @param hql
	 * @return
	 */
	public List<AuditingOrderTab> getAuditingOrder(String hql )
	{
		return loginDao.getAuditingOrder(hql);
	}


	@SuppressWarnings("unchecked")
	public List executionSql(String sql) {
		return loginDao.executionSql(sql);
	}

	/**
	 * 执行sql语句
	 * @author 阙超强 14015
	 * @date 2011-12-23 10:52:52
	 */
	public String executeSql(String sql) {
		
		return loginDao.executeSql(sql);
	}

	public List executeHql(String hql) {
		
		return loginDao.getObjectList(hql);
	}

}
