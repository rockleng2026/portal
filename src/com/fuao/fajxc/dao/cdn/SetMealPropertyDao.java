package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.SetMealProperty;

public interface SetMealPropertyDao extends BaseDao {
	/**
	 * 根据id寻找一个套餐
	 * **/
	public SetMealProperty findSetMealPropertyById(Integer id);
	public int updataObjectByHQL(String hql);

}
