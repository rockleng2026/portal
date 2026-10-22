package com.fuao.fajxc.dao.impl.sale;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.sale.SaleorderDao;
import com.fuao.fajxc.vo.SaleOrder;

public class SaleorderDaoImpl extends BaseDaoImpl implements SaleorderDao {

	/*
	 * 添加或修改销售订单
	 * @see com.fuao.fajxc.dao.sale.SaleorderDao#addData(com.fuao.fajxc.vo.SaleOrder)
	 */
	public SaleOrder addData(SaleOrder saleOrder) {
		 super.getHibernateTemplate().saveOrUpdate(saleOrder);
		return saleOrder;
	}

}
