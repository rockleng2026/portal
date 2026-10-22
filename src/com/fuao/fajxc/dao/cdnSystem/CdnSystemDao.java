package com.fuao.fajxc.dao.cdnSystem;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.RealmType;

public interface CdnSystemDao extends BaseDao {
	
	//public RealmType findRealmTypeById(Integer id);
	
	public int updataObjectByHQL(String hql);

}
