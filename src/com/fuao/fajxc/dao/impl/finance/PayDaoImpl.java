package com.fuao.fajxc.dao.impl.finance;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.finance.PayDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PaymentLog;

public class PayDaoImpl extends BaseDaoImpl implements PayDao {

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	@SuppressWarnings("unchecked")
	public List selPurOrder(String hql) {
		List list=super.execHQL(hql);
		return list;
	}

	public boolean add(PaymentLog plog) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(plog);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delpay(Object[] ids) {
		boolean flag=false;
		String hql="update PaymentLog e set del=1 where e.id in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}

	public List selPay(String hql) {
		List list=super.execHQL(hql);
		return list;
	}

	public boolean updatePay(PaymentLog pml) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(pml);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public Object getobjid(Class clazz, Integer id) {
		return this.getHibernateTemplate().get(clazz, id);
	}
}
