package com.fuao.fajxc.bussiness.server;

import java.util.List;

import com.fuao.fajxc.util.Pages;

public interface ServerStateBussiness {

	/**
	 * 根据条件查找产品
	 * @param addhql
	 * @return
	 */
	public List selProduct(String addhql);
	
	/**
	 * 分页组装服务器记录
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 改变服务器使用状态
	 * @return
	 */
	public boolean changeState(int state,int id);
	
	
}
