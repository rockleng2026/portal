package com.fuao.fajxc.dao.sale;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.SaleOrder;

public interface SaleorderDao extends BaseDao {

	/*
	 * 添加或更改销售订单
	 * 阙超强 14015
	 */
	public SaleOrder addData(SaleOrder saleOrder);
}
