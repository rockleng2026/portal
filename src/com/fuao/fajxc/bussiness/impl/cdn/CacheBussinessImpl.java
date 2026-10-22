package com.fuao.fajxc.bussiness.impl.cdn;

import com.fuao.fajxc.bussiness.cdn.CacheBussiness;
import com.fuao.fajxc.dao.cdn.CacheDao;
import com.fuao.fajxc.vo.Cache;



public class CacheBussinessImpl implements CacheBussiness {
	private CacheDao cachedao;

	public CacheDao getCachedao() {
		return cachedao;
	}

	public void setCachedao(CacheDao cachedao) {
		this.cachedao = cachedao;
	}

	public Cache addCache(Cache data) {
		data=(Cache)cachedao.addReturnObject(data);
		return data;
	}
	
	
	



}
