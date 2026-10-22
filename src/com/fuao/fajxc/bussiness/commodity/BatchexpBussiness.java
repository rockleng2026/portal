package com.fuao.fajxc.bussiness.commodity;

import java.util.List;

public interface BatchexpBussiness {
	/**
	 *  根据到货单ID 查询批次详表数据List
	 */
	public List findBatchexpByToOrderId(String toOrderIdAdd);
}
