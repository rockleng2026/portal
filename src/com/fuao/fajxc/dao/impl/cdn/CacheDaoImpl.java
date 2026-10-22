package com.fuao.fajxc.dao.impl.cdn;

import com.fuao.fajxc.dao.cdn.CacheDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.Cache;

public class CacheDaoImpl extends BaseDaoImpl implements CacheDao {

	public Cache findCacheById(Integer id) {
		try {
			return (Cache)super.select(Cache.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
