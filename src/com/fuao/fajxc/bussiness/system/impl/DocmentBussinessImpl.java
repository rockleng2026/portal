package com.fuao.fajxc.bussiness.system.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.system.DocmentBussiness;
import com.fuao.fajxc.dao.system.DocumentDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.Sale_orders;

public class DocmentBussinessImpl implements DocmentBussiness {

	private DocumentDao docDao;
	
	
	
	public DocumentDao getDocDao() {
		return docDao;
	}

	public void setDocDao(DocumentDao docDao) {
		this.docDao = docDao;
	}

	public boolean addDoc(Docmark docm) {
		// TODO Auto-generated method stub
		return docDao.addDoc(docm);
	}

	public boolean delDoc(Docmark docm) {
		// TODO Auto-generated method stub
		return docDao.delDoc(docm);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return docDao.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List selDocmark(String addhql) {
		String hql=" from Docmark where 1=1 "+addhql;
		return docDao.selDocmark(hql);
	}

	public boolean updateDoc(Docmark docm) {
		// TODO Auto-generated method stub
		return docDao.updateDoc(docm);
	}

	public boolean updateDoc(Object obj) {
		try {
			docDao.add(obj);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public boolean saveRecharge(RechargeLog rech) {
		return docDao.saveRecharge(rech);
	}

	public List selAllKinddatas(String sql) {
		return docDao.selAllKinddatas(sql);
	}

	public void updtRecharge(RechargeLog rech) {
		
		docDao.updtRecharge(rech);
		
	}
	
	/*******
	 * 得到集合
	 * @param hql
	 * @return
	 */
	public List exHql(String hql) {
		return docDao.execHQL(hql);
	}

	public void update(Sale_orders so) {
		try {
			docDao.update(so);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
