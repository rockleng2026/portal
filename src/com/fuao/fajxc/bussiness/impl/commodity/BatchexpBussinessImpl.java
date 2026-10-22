package com.fuao.fajxc.bussiness.impl.commodity;

import java.util.List;

import com.fuao.fajxc.bussiness.commodity.BatchexpBussiness;
import com.fuao.fajxc.dao.commodity.BatchexpDao;

public class BatchexpBussinessImpl implements BatchexpBussiness {
	
	private BatchexpDao batchexpDao;

	public BatchexpDao getBatchexpDao() {
		return batchexpDao;
	}

	public void setBatchexpDao(BatchexpDao batchexpDao) {
		this.batchexpDao = batchexpDao;
	}

	public List findBatchexpByToOrderId(String toOrderIdAdd) {
		
		return batchexpDao.findBatchexpByToOrderId(toOrderIdAdd);
	}
	
}
