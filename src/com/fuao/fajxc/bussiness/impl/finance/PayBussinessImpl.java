package com.fuao.fajxc.bussiness.impl.finance;

import java.util.List;

import com.fuao.fajxc.bussiness.finance.PayBussiness;
import com.fuao.fajxc.dao.finance.PayDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PaymentLog;

public class PayBussinessImpl implements PayBussiness {
	
	private PayDao paydao;

	public PayDao getPaydao() {
		return paydao;
	}

	public void setPaydao(PayDao paydao) {
		this.paydao = paydao;
	}






	public Pages exHqlPages(String hql, int pageNo, int pageSize, Object... values) {
		Pages pages=null;
		try {
			pages=paydao.exHqlPages(hql, pageNo, pageSize, values);	
			return pages;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}






	public List selPurOrder(String addhql) {
		// TODO Auto-generated method stub
		String hql="from PurOrder where delflag=0"+addhql;
		return paydao.selPurOrder(hql);
	}



	/**
	 * 添加付款单
	 */
	public boolean add(PaymentLog plog) {
		
		return paydao.add(plog);
	}

	/**
	 * 添加付款单
	 * 返回对象
	 */
	public PaymentLog addReturnPaymentLog(PaymentLog plog) {
	System.out.println("aaaa");	
		try {
			return (PaymentLog) paydao.addReturnObject(plog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}




	public boolean delpay(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return paydao.delpay(obj);
	}






	public List selPay(String addhql) {
		String hql="from PaymentLog where del=0"+addhql;
		return paydao.selPay(hql);
	}



	public boolean updatePay(PaymentLog pml) {
		// TODO Auto-generated method stub
		return paydao.updatePay(pml);
	}

	public Object getobjid(Class clazz, Integer id) {
		return this.paydao.getobjid(clazz, id);
	}

	public int updateVerif(String sql) {
		
		return this.paydao.execSQLUpdate(sql);
	}
	
}
