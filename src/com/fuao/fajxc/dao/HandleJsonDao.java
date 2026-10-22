package com.fuao.fajxc.dao;

import java.util.List;

/**
 * 处理json  dao
 * @author 14011
 *
 */
public interface HandleJsonDao {

	/**
	 * 获得对象列表
	 * @param hql
	 * @return
	 */
	public List ObjectList(String hql);
}
