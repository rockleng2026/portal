package com.fuao.fajxc.dao.purchase;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;

/**
 * 采购订单接口
 * @author Administrator
 *
 */
public interface PurOrderDao extends BaseDao {

	/**
	 *执行分页查询采购订单
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加采购订单
	 * @return
	 */
	public boolean addPurOrder(PurOrder purO);
	
	/**
	 * 添加采购单 返回对象
	 * @author 阙超强 14015
	 * @param purO
	 * @return PurOrder
	 */
	public PurOrder addPurOrderReturn(PurOrder purO);
	
	/**
	 * 删除采购订单
	 */
	public boolean delPurOrder(Object[] ids);
	
	/**
	 * 更新采购订单
	 * @return
	 */
	public boolean editPurOrder(PurOrder purO);
	/**
	 * 根据条件查找采购订单
	 * @return
	 */
	public List selSomePurOrder(String addhql);
	
	/**
	 *添加采购订单详细记录
	 *@return
	 */
	public boolean addPurOrderInfo(PurOrderInfo poi);
	
	/**
	 *根据条件删除采购订单详细
	 * @return
	 */
	public boolean delPurOrderInfo(String addhql);
	
	/**
	 * 更新采购订单详细
	 * @return
	 */
	public boolean updatePurOrderInfo(PurOrderInfo poinfo);
	/**
	 * 删除采购一览表里的记录（软）
	 */
	public boolean delPurOrderInfo(Object[] ids);
	
	/**
	 * 根据purid获取purOrderInfo表中列表
	 * @return
	 */
	public List getPurOrderInfoById(String addhql);
	
	/**
	 * 查找指定条数的采购详细记录
	 */
	public List selsomePurOrderinfo(int num,int modelId);
	
}
