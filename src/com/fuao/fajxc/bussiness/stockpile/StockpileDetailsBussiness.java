/**
 * 
 */
package com.fuao.fajxc.bussiness.stockpile;

import java.util.List;

import com.fuao.fajxc.util.Pages;

/**
 * @author 蔡亚俊
 *
 * 2011-7-29
 */
public interface StockpileDetailsBussiness {

	/**
	 * 根据条件查询产品信息列表，也可以不传条件
	 * @param andhql
	 * @return
	 */
	public List getProductList(String andhql);
	
	/**
	 * 查询仓库中产品列表
	 * @param hql
	 * @return
	 */
	public List getProductByDepot(String andhql);
	
	/**
	 * 查询商品数量
	 * @param andhql
	 * @return
	 */
	public int getCount(String tableName,String andhql);
	
	/**
	 * 获取对象
	 * @param andhql
	 * @return
	 */
	public Object getObject(String tableName,String andhql);
	
	public List getObject(String tableName);
	
	/**
	 *遍历字段分页
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 遍历对象分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlObjectPages(String hql,int pageNo,int pageSize,
			Object... values) ;
}
