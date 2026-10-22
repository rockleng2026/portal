package com.fuao.fajxc.dao.stockpile;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.StatInfo;

public interface OutboundDao extends BaseDao  {

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
	 * 查询返回List
	 */
	public List selectInfo(String hql);
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
	 * 查找出库类型
	 */
	public List selType(String addhql);
	
	/**
	 * 删除出库详细中的产品（删除产品表记录）
	 * @return
	 */
	public boolean delProduct(Object[] obj);
	
	/**
	 * 执行hql返回布尔值
	 */
	public boolean exeHql(String hql);
}
