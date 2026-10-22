/**
 * 
 */
package com.fuao.fajxc.dao.commodity;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Batch;
import com.fuao.fajxc.vo.Batchexp;

/**
 * @author 蔡亚俊
 *
 * 2011-8-2
 */
public interface BatchDao {

	/**
	 * 添加新购商品入库到批次表
	 * @param batchexp
	 * @return
	 */
	public int saveBatch(Batch batch);
	
	/**
	 * 添加新购商品入库到批次详细表
	 * @param batchexp
	 * @return
	 */
	public int addBatchexp(Batchexp batchexp);
	
	/**
	 * 获得批次列表
	 * @param hql
	 * @return
	 */
	public List getObjectList(String hql);
	
	/**
	 * 修改批次表
	 * @param batch
	 * @return
	 */
	public int updateBatch(Batch batch);
	
	/**
	 * 修改批次详细表
	 * @param batchexp
	 * @return
	 */
	public int updateBatchexp(Batchexp batchexp);
	
	/**
	 * 分页查询批次
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}
