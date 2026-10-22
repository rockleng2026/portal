package com.fuao.fajxc.serser.dao;

import java.util.List;

import com.fuao.fajxc.util.IterfaceConmens;
import com.fuao.fajxc.vo.Product;

public interface StoreCountDao{
   
	public List selAllDateList();
	public int getStoreSize(String sql);
	public List getStoreList(String sql,int current,int pagesize);
	public List getStoreList2(String sql);
	public List getSingleSelect(String hsql);
	public List differentCondition(String sql);
	
	public List executeSql(String sql);
}
