package com.fuao.fajxc.dao.impl.sale;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.sale.PriceRegulationDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Priceregulation;
import com.fuao.fajxc.vo.Stat;

public class PriceRegulationDaoImpl extends BaseDaoImpl implements PriceRegulationDao {

	public boolean addRegulation(Priceregulation reg) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(reg);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加价格调整时出错Dao",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delRegulation(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update Priceregulation set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids", ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除价格调整时出错Dao",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean editRegulation(Priceregulation reg) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(reg);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改价格调整 时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages=null;
		try
		{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("价格调整分页时出错",ex);
		}
		return pages;
	}

	public List someRegulation(String addhql) {
		String hql="from Priceregulation where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public boolean updateModel(String addhql) {
		String hql="update Priceregulation set delflag=1 where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		int tes=query.executeUpdate();
		if(tes>0)
			return true;
		return false;
	}


}
