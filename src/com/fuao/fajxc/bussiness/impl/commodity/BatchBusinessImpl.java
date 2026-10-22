/**
 * 
 */
package com.fuao.fajxc.bussiness.impl.commodity;

import java.util.List;

import com.fuao.fajxc.bussiness.commodity.BatchBusiness;
import com.fuao.fajxc.dao.commodity.BatchDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Batch;
import com.fuao.fajxc.vo.Batchexp;
import com.sun.org.apache.regexp.internal.recompile;

/**
 * @author 蔡亚俊
 *
 * 2011-8-2
 */
public class BatchBusinessImpl implements BatchBusiness {

	private BatchDao batchDao;
	
	/**
	 * 添加新购商品入库到批次表
	 * @param batchexp
	 * @return
	 */
	public int saveBatch(Batch batch)
	{
		return batchDao.saveBatch(batch);
	}
	
	/**
	 * 添加新购商品入库到批次详细表
	 * @param batchexp
	 * @return
	 */
	public int addBatchexp(Batchexp batchexp)
	{
		return batchDao.addBatchexp(batchexp);
	}

	/**
	 * 获得批次列表
	 * @param hql
	 * @return
	 */
	public List getObjectList(String tableName ,String andhql)
	{
		String hql ="from "+tableName+" where 1=1 and delflag='0' "+andhql;
		System.out.println("hql : "+hql);
		return batchDao.getObjectList(hql);
	}
	
	
	/**
	 * 修改批次表
	 * @param batch
	 * @return
	 */
	public int updateBatch(Batch batch)
	{
		return batchDao.updateBatch(batch);
	}
	
	/**
	 * 修改批次详细表
	 * @param batchexp
	 * @return
	 */
	public int updateBatchexp(Batchexp batchexp)
	{
		return batchDao.updateBatchexp(batchexp);
	}
	
	public void setBatchDao(BatchDao batchDao) {
		this.batchDao = batchDao;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		return batchDao.exHqlPages(hql, pageNo, pageSize, values);
	}

}
