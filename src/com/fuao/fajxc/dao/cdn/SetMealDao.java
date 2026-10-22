package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.SetMeal;

public interface SetMealDao extends BaseDao {
	/**
	 * ���idѰ��һ���ײ�
	 * **/
	public SetMeal findSetMealById(Integer id);
	
	public int updataObjectByHQL(String hql);

	public SetMeal updateSetMeal(SetMeal setMeal);
}
