package com.fuao.fajxc.bussiness.cdnSystem;

import java.util.List;

import com.fuao.fajxc.util.Pages;

public interface CdnSystemBussiness {
	
public Object addObject(Object obj);
	
	
	public int delObject(Object obj);
	
	public Object updataObject(Object obj);
	
	public int updataByHQL(String hql);
	
	public Object findObjectById(String classtype,Integer id);
	
	public List findObjectListByHQL(String hql);

	//÷¥––∑÷“≥≤È—Ø
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values);

}
