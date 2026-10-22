package com.fuao.fajxc.dao.impl.commodity;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.commodity.BatchexpDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.Batchexp;

public class BatchexpDaoImpl extends BaseDaoImpl implements BatchexpDao {

	public List findBatchexpByToOrderId(String toOrderIdAdd) {
		Query query=this.getSession().createQuery("from Batchexp where 1 = 1 and delflag = 0 and  toOrderId = "+toOrderIdAdd);
		return query.list();
	}

}
