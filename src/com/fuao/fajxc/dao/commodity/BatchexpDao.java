package com.fuao.fajxc.dao.commodity;

import java.util.List;

import com.fuao.fajxc.vo.Batchexp;

/**
 * 批次详表（批次表已作废）
 * @author Administrator
 *
 */
public interface BatchexpDao {
	/**
	 *  根据到货单ID 查询批次详表数据List
	 */
	public List findBatchexpByToOrderId(String toOrderIdAdd);
}
