package com.fuao.fajxc.dao.impl;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.HandleJsonDao;

public class HandleJsonDaoImpl extends BaseDaoImpl implements HandleJsonDao{

	/**
	 * 获得对象列表
	 * @param hql
	 * @return
	 */
	public List ObjectList(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
}
