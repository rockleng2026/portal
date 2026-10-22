package com.fuao.fajxc.bussiness.cdn;

import java.util.List;

import com.fuao.fajxc.vo.SetMealCenter;

public interface SetMealCenterBussiness {
	/**
	 * 添加一个中间表
	 * **/
	public SetMealCenter addMealCenter(SetMealCenter setmealcenter);
	
	/**
	 * 软删除一个中间表
	 * **/
	public SetMealCenter delruanSetMealCenter(SetMealCenter setmealcenter);
	
	/**
	 * 硬删除一个中间表
	 * **/
	public boolean delyingSetMealCenter(SetMealCenter setmealcenter);
	
	/**
	 * 修改
	 * **/
	public SetMealCenter updataSetMealCenter(SetMealCenter setmealcenter);
	
	/**
	 * 根据id查看一个中间表
	 * **/
	public SetMealCenter findSetMealCenterById(Integer id);
	
	/**
	 * 根据hql语句查看列表
	 * **/
	public List<SetMealCenter> findSetMealCenterListByHQL(String hql);

}
