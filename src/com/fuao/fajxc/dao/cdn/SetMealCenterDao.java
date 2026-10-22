package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.SetMealCenter;

public interface SetMealCenterDao extends BaseDao {
	/**
	 * 根据id寻找一个套餐
	 * **/
	public SetMealCenter findSetMealCenterById(Integer id);

}
