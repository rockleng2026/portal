package com.fuao.fajxc.serser.service;

import java.util.List;

import com.fuao.fajxc.util.IterfaceConmens;
import com.fuao.fajxc.vo.Product;

public interface StoreCountService{
    
	public List selAllDateList();
	//仓库
	public int getStoreSize(String sql);
	public List getStoreList(String sql,int current,int pagesize);
	public List getStoreList2(String sql);
	public String getSingleSelect(String st);
	public List differentCondition(String sect1, String sect2, String sect3, String sect4,String sels,int current,int pagesize);
	//不同条件统计
    public int diffrentCount(String sect1,String sect2,String sect3,String sect4,String sels);
    
    public List executeSql(String sql);
}
