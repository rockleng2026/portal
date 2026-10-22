package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.SetMeal;

public interface SaleOrderDao extends BaseDao {
	
	/**
	 * 作修改执行hql语句
	 * **/
	public int updataObjectByHQL(String hql);

	/**
	 * 保存更新一个对象
	 * **/
	public Object updateObject(Object obj);
}
