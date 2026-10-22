package com.fuao.fajxc.bussiness.server;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.DownServer;

public interface DownserverBussiness {

	/**
	 * 分页下架单
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加下架单
	 * @return
	 */
	public boolean adddownServer(DownServer ds);
	public DownServer addReturndownServer(DownServer ds);
	
	/**
	 * 删除下架单
	 * @return
	 */
	public boolean deldownServer(Object[] ids);
	
	/**
	 * 修改下架单
	 * @return 
	 */
	public boolean editdownServer(DownServer ds);
	
	/**
	 * 根据条件查找下架单
	 * @return 
	 */
	public List somedownServer(String addhql);
	
	/**
	 * 查找下架类型
	 */
	public List someType(String addhql);
	
	/**
	 * 执行下架操作
	 * @param proId
	 * @param downId
	 * @return
	 */
	public boolean executeUpserver(String proId,String downId);
}
