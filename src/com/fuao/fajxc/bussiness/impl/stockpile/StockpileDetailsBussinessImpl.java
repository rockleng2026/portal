/**
 * 
 */
package com.fuao.fajxc.bussiness.impl.stockpile;

import java.util.List;

import com.fuao.fajxc.bussiness.stockpile.StockpileDetailsBussiness;
import com.fuao.fajxc.dao.stockpile.StockpileDetailsDao;
import com.fuao.fajxc.util.Pages;

/**
 * @author 蔡亚俊
 *
 * 2011-7-29
 */
public class StockpileDetailsBussinessImpl implements StockpileDetailsBussiness {

	private StockpileDetailsDao stockpileDetailsDao;
	/**
	 * 根据条件查询产品信息列表，也可以不传条件
	 * @param andhql
	 * @return
	 */
	public List getProductList(String andhql)
	{
		String hql = "from Product where delflag = 0 "+andhql;
		return stockpileDetailsDao.getProductList(hql);
	}
	
	/**
	 * 查询仓库中产品列表
	 * @param hql
	 * @return
	 */
	public List getProductByDepot(String andhql)
	{
		String hql = "select depot.id,property.id,count(property.id) as tmp from Product where 1=1 "+andhql+" group by depot.id,property.id";
		System.out.println("hql : "+hql);
		return stockpileDetailsDao.getProductByDepot(hql);
	}
	
	/**
	 * 查询商品数量
	 * @param andhql
	 * @return
	 */
	public int getCount(String tableName,String andhql)
	{
		String hql = "from "+tableName+" where delflag = 0 "+andhql;
		System.out.println("hql : "+hql);
		return stockpileDetailsDao.getCount(hql);
	}
	
	/**
	 * 遍历对象分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlObjectPages(String hql,int pageNo,int pageSize,
			Object... values) 
	{
		Pages pages=null;
		try {
			pages=stockpileDetailsDao.exHqlObjectPages(hql, pageNo, pageSize, values);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pages;
	}
	
	/**
	 * 遍历字段分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values){
		Pages pages=null;
		try {
			pages=stockpileDetailsDao.exHqlPages(hql, pageNo, pageSize, values);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pages;
	}
	
	/**
	 * 获取对象
	 * @param andhql
	 * @return
	 */
	public Object getObject(String tableName,String andhql)
	{
		String hql = "from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		return stockpileDetailsDao.getObject(hql);
	}
	
	public List getObject(String tableName)
	{
		String hql = "from "+tableName+" where 1=1 ";
		System.out.println("hql : "+hql);
		return stockpileDetailsDao.getObject1(hql);
	}
	
	public void setStockpileDetailsDao(StockpileDetailsDao stockpileDetailsDao) {
		this.stockpileDetailsDao = stockpileDetailsDao;
	}
	
	
}
