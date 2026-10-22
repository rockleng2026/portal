package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Cache;

public interface CacheDao extends BaseDao{
	/**
	 * ¸ù¾Ýid²éÕÒ»º´æ
	 * **/
	public Cache findCacheById(Integer id);

}
