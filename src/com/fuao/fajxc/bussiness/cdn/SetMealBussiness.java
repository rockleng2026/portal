package com.fuao.fajxc.bussiness.cdn;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.SetMeal;



public interface SetMealBussiness  {
	
	/**
	 * 
	 * **/
	public SetMeal addSetMeal(SetMeal setmeal);
	
	/**
	 * 
	 * **/
	public SetMeal delruanSetMeal(SetMeal setmeal);
	
	/**
	 * 
	 * **/
	public boolean delyingSetMeal(SetMeal setmeal);
	
	/**
	 * 
	 * ***/
	public SetMeal updateSetMeal(SetMeal setmeal);
	/**
	 * 
	 * **/
	public SetMeal findSetMealById(Integer id);
	/**
	 * 
	 * **/
	public List<SetMeal> findSetMealList(String hql);
	
	
	
	public Object addObject(Object obj);
	
	
	public int delObject(Object obj);
	
	public Object updataObject(Object obj);
	
	public int updataByHQL(String hql);
	
	public Object findObjectById(String classtype,Integer id);
	
	public List findObjectListByHQL(String hql);

	/*执行分页查询*/
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values);
	
	/*据ID获取对象*/
	public SetMeal getSetMealData(String id);
	/**
	 * 硬删除
	 */
	public boolean del(Class c,String id);
}
