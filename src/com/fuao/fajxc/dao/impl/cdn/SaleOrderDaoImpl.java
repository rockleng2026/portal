package com.fuao.fajxc.dao.impl.cdn;


import org.hibernate.Query;

import com.fuao.fajxc.dao.cdn.SaleOrderDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;

public class SaleOrderDaoImpl extends BaseDaoImpl implements SaleOrderDao {

	
	public int updataObjectByHQL(String hql) {
		try {
			Query query = this.getSession().createQuery(hql);
			int a = query.executeUpdate();
			if(a>0)return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}


	public Object updateObject(Object obj) {
		try {
			return super.addReturnObject(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
