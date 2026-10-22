package com.fuao.fajxc.bussiness.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.BaseBussiness;
import com.fuao.fajxc.dao.CommBaseDao;
import com.fuao.fajxc.util.Pages;

/**
 * 通用的业务父类
 * @author 阙超强 14015
 * @time 2012-02-27 11:41:07
 *
 */
public class BaseBussinessImpl implements BaseBussiness{

	/**
	 * 注入DAO
	 */
	private CommBaseDao commBaseDao;


	public CommBaseDao getCommBaseDao() {
		return commBaseDao;
	}

	public void setCommBaseDao(CommBaseDao commBaseDao) {
		this.commBaseDao = commBaseDao;
	}

	/**
	 * 添加
	 */
	public Object add(Object object) {
		return commBaseDao.addReturnObject(object);
	}

	/**
	 * 硬删除
	 */
	public boolean delHard(Object object) {
		try {
			commBaseDao.delete(object);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 软删除
	 */
	
	public boolean delSoft(Object object) {
		try {
			commBaseDao.update(object);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 执行hql语句
	 */
	@SuppressWarnings("unchecked")
	public List exeHql(String hql) {
		
		return commBaseDao.execHQL(hql);
	}

	/**
	 * 执行分页
	 */
	public Pages exeHqlPages(String hql, int pageNo, int pageSize, Object... values) {
		return commBaseDao.paginationQuery(hql, pageNo, pageSize, values);
	}

	/**
	 * 执行sql语句
	 */
	@SuppressWarnings("unchecked")
	public List executeSql(String sql) {
		return commBaseDao.execSQL(sql);
	}

	/**
	 * 据ID获得对象
	 */
	@SuppressWarnings("unchecked")
	public Object getById(Class cls,int id) {
		try {
			return commBaseDao.select(cls, id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 修改
	 */
	public boolean update(Object object) {
		try {
			commBaseDao.update(object);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public int exeUpdateSql(String sql) {
		
		return commBaseDao.execSQLUpdate(sql);
	}
	
}
