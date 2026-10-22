package com.fuao.fajxc.dao.impl.purchase;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.purchase.RequisitioningDao;
import com.fuao.fajxc.vo.ApplyBuy;
import com.fuao.fajxc.vo.ApplyBuyinfo;

/**
 * 请购单Dao实现类
 * 继承了BaseDaoImpl通用类
 * @author 14012
 *
 */
public class RequisitioningDaoImpl extends BaseDaoImpl implements RequisitioningDao {

	public int adda(ApplyBuy applyBuy) {
		super.getHibernateTemplate().save(applyBuy);
		
		return applyBuy.getId();
	}
	

	public int adda(ApplyBuyinfo applyBuy) {
		super.getHibernateTemplate().save(applyBuy);
		
		return applyBuy.getId();
	}

}
