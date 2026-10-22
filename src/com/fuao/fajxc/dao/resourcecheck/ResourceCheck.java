package com.fuao.fajxc.dao.resourcecheck;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Tresourcecheck;

public interface ResourceCheck {

	//查询所有
	public List find(String tableName);
	//添加资源核实单
	public void add(Tresourcecheck tresourcecheck);
	
	//多用hql语句查询
	public List findByObjhql(String hql);
	//多用sql语句查询
	public List findByObjsql(String sql);
	
	//分页
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values);
	
	//公用的boolean方法
	public boolean updateOrDeletesql(String sql);
	public boolean updateOrDeletehql(String hql);
	
	//修改
	public boolean updateRC(Tresourcecheck tresourcecheck);
	
	//回复
	public boolean returnupdateRC(Integer empid,String content,Integer rcid);
	
	
	
}
