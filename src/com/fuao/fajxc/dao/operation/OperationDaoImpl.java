package com.fuao.fajxc.dao.operation;

import java.util.List;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;

public class OperationDaoImpl extends BaseDaoImpl implements OperationDao{
	public List operationlist(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	public List getAllMissiontype(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	public List getAllDept(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	public List getAllEmp(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	public Object getMissiontypeById(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	
	public Object getDeptById(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	
	public void add(Object obj){
		this.getHibernateTemplate().save(obj);
	}
}
