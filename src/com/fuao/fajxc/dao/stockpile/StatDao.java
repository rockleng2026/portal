package com.fuao.fajxc.dao.stockpile;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Stat;
import com.fuao.fajxc.vo.StatInfo;

public interface StatDao extends BaseDao {

	/**
	 *执行分页查询盘点单
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加盘点单
	 */
	public boolean addStat(Stat stat);
	
	/**
	 * 删除盘点单
	 */
	public boolean delStat(Object[] ids);
	
	/**
	 * 修改盘点单
	 */
	public boolean editStat(Stat stat);
	
	/**
	 * 根据条件查找相应的盘点单
	 */
	public List someStat(String addhql);
	
	/**
	 * 添加采购订单详细
	 */
	public boolean addStatInfo(StatInfo statinfo);
	
	/**
	 * 根据条件删除采购订单详细
	 */
	public boolean delStatInfo(String addhql);
	
	/**
	 * 根据条件查找采购订单详细
	 */
	public List someStatInfo(String addhql);
}
