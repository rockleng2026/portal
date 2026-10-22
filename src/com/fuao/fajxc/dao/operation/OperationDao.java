package com.fuao.fajxc.dao.operation;

import java.util.List;

import org.hibernate.dialect.IngresDialect;

import com.fuao.fajxc.dao.BaseDao;

public interface OperationDao extends BaseDao{
	public List operationlist(String hql);
	
	public List getAllMissiontype(String hql);
	
	public List getAllDept(String hql);
	
	public List getAllEmp(String hql);
	
	public Object getMissiontypeById(Class clazz,Integer id);
	
	public Object getDeptById(Class clazz,Integer id);
	
	public void add(Object obj);
}
