/**
 * 
 */
package com.fuao.fajxc.dao.impl.commodity;

import java.util.ArrayList;
import java.util.List;

import com.fuao.fajxc.dao.commodity.BatchDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Batch;
import com.fuao.fajxc.vo.Batchexp;

/**
 * @author 蔡亚俊
 *
 * 2011-8-2
 */
public class BatchDaoImpl extends BaseDaoImpl  implements BatchDao {
	/**
	 * 分页查询批次
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values){
		
		System.out.println("cm:  ---> DAO ---> exHqlPages() ---> 分页查询" );
		Pages pages=null;
		try	{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
			System.out.println("cm:  ---> DAO ---> exHqlPages() ---> 分页查询 执行后， 打印pages 的值：" + pages);
		}
		catch(Exception ex) {
			ex.printStackTrace();
			logger.error("分页时出错",ex);
		}
		return pages;
	}

	/**
	 * 添加新购商品入库到批次表
	 * @param batchexp
	 * @return
	 */
	public int saveBatch(Batch batch)
	{
		System.out.println(" ````````````````  "+batch.getBatchId());
		if(batch!=null)
		{
			super.getSession().save(batch);
			return 1;
		}
		return 0;
	}
	
	/**
	 * 添加新购商品入库到批次详细表
	 * @param batchexp
	 * @return
	 */
	public int addBatchexp(Batchexp batchexp)
	{
		if(batchexp!=null)
		{
			super.getSession().save(batchexp);
			return 1;
		}
		return 0;
	}
	
	/**
	 * 获得批次列表
	 * @param hql
	 * @return
	 */
	public List getObjectList(String hql)
	{	List list=new ArrayList();
		list =	super.getSession().createQuery(hql).list();
		if(list.size()>0)
		{
			return list;
		}
		return list;
	}
	
	/**
	 * 修改批次表
	 * @param batch
	 * @return
	 */
	public int updateBatch(Batch batch)
	{
		if(batch!=null)
		{
			super.getSession().update(batch);
			return 1;
		}
		return 0;
	}
	
	/**
	 * 修改批次详细表
	 * @param batchexp
	 * @return
	 */
	public int updateBatchexp(Batchexp batchexp)
	{
		if(batchexp!=null)
		{
			super.getSession().update(batchexp);
			return 1;
		}
		return 0;
	}
}
