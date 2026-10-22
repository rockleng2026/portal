package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.RealmType;

public interface RealmTypeDao extends BaseDao {
	/**
	 * 
	 * **/
	public RealmType findRealmTypeById(Integer id);
	
	public int updataObjectByHQL(String hql);

}
