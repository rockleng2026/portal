package com.fuao.fajxc.bussiness.cdn;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.SetMealProperty;

public interface SetMealPropertyBussiness {
	/**
	 * 添加一个套餐商品属性
	 * **/
	public SetMealProperty addSetMealProperty(SetMealProperty setmealproperty);
	
	/**
	 * 软删除一个套餐商品属性
	 * **/
	public SetMealProperty delruanSetMealProperty(SetMealProperty setmealproperty);
	
	/**
	 * 硬除一个套餐商品属性
	 * **/
	public boolean delyingSetMealProperty(SetMealProperty setmealproperty);
	
	/**
	 * 修改一个套餐商品属性
	 * **/
	public SetMealProperty updataSetMealProperty(SetMealProperty setmealproperty);
	
	/**
	 * 查看一个套餐商品属性
	 * **/
	public SetMealProperty findSetMealPropertyById(Integer id);
	/**
	 * 执行hql
	 */
	public int updataByHQL(String hql);
	/**
	 * 根据hql语句，查看套餐商品属性列表  
	 * **/
	public List<SetMealProperty> findSetMealPropertyListByHQL(String hql);
	
	/**
	 * 执行分页查询
	 * */
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values);
	
}
