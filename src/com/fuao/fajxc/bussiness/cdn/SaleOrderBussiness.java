package com.fuao.fajxc.bussiness.cdn;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Ordertype;



public interface SaleOrderBussiness  {

	/**
	 * 增加
	 * **/
	public Object addObject(Object obj);
	
	/**
	 * 删除
	 * **/
	public boolean delObject(Object obj);
	
	/**
	 * 删除
	 */
	public boolean del(Class c,String id);
	
	/**
	 * 更新对象
	 * ***/
	public Object updateObject(Object obj);
	
	/**
	 * 根据hql语句，查找列表
	 * **/
	public List findObjectListByHQL(String hql);

	/**
	 * 修改更新，hql语句
	 * **/
	public int updataByHQL(String hql);
	
	/**
	 * 根据实体类名，id号    查找对象
	 * **/
	public Object findObjectById(Class c,String id);
	
	/**
	 * 执行分页查询
	 * **/
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values);

	/**
	 * 软删除
	 */
	public Ordertype delete(String id);
	
}
