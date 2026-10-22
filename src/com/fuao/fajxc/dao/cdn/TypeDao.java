package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Type;

public interface TypeDao extends BaseDao {
	/**
	 * 根据id查找模板
	 * **/
	public Type findTypeById(Integer id);
	
	public int updataObjectByHQL(String hql);

}
