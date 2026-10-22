package com.fuao.fajxc.bussiness.stockpile;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.StatInfo;

public interface OutboundBussiness {

	/**
	 * 分页查询出库单
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加出库单
	 * @return
	 */
	public boolean addOutBound(Outbound ob);
	
	/**
	 * 添加出库单
	 * 返回对象
	 */
	public Outbound addReturnOutBound(Outbound ob);
	
	/**
	 * 删除出库单
	 * @return
	 */
	public boolean delOutBound(Object[] ids);
	
	/**
	 * 修改出库单
	 * @return 
	 */
	public boolean editOutBound(Outbound ob);
	
	/**
	 * 根据条件查找出库单
	 * @return 
	 */
	public List someOutBound(String addhql);
	
	/**
	 * 添加出库单详细
	 */
	public boolean addOutInfo(OutboundInfo ob);
	
	/**
	 * 根据条件删除出库单详细
	 */
	public boolean delOutInfo(String addhql);
	
	/**
	 * 根据条件查找出库单详细
	 */
	public List someOutInfo(String addhql);
	/**
	 * 查询商品list
	 */
	public List selectInfo(String hql);
	/**
	 * 查找出库类型
	 */
	public List selType(String addhql);
	
	/**
	 * 执行审核成功后业务
	 * @return
	 */
	public boolean auditingPass(String orderNo);
}
