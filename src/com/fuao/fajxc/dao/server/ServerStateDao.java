package com.fuao.fajxc.dao.server;

import com.fuao.fajxc.dao.BaseDao;

public interface ServerStateDao extends BaseDao {

	/**
	 * 改变使用状态
	 * @return
	 */
	public boolean changeState(int state,int id);
	
	/**
	 * 上架时改变使用次数
	 */
	public boolean appenduseNum(int id);
}
