package com.fuao.fajxc.bussiness.cdn;

import java.util.List;



public interface TypeBussiness  {
	
    public Object addObject(Object obj);
	
	public int delObject(Object obj);
	
	public Object updataObject(Object obj);
	
	public int updataByHQL(String hql);
	
	public Object findObjectById(String classtype,Integer id);
	
	public List findObjectListByHQL(String hql);

}
