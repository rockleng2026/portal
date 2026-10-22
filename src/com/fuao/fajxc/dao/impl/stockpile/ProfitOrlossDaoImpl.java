package com.fuao.fajxc.dao.impl.stockpile;

import java.io.Serializable;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.stockpile.ProfitOrlossDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Ruin;
import com.fuao.fajxc.vo.RuinInfo;

public class ProfitOrlossDaoImpl extends BaseDaoImpl implements ProfitOrlossDao {

	private static Logger logger = Logger.getLogger(ProfitOrlossDaoImpl.class);
	
	public boolean addPorLoss(Ruin ruin) {
		boolean flag=false;
		try
		{
			super.getHibernateTemplate().save(ruin);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加报损/报溢单出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean addPorLossInfo(RuinInfo rinfo) {
		boolean flag=false;
		try
		{
			super.getHibernateTemplate().save(rinfo);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加报损/报溢详单出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delPorLoss(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update Ruin set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除报损/报溢单时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean editPorLoss(Ruin ruin) {
		boolean flag=false;
		try
		{
			super.getHibernateTemplate().update(ruin);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改报损/报溢单出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delPorLossInfo(String addhql) {
		boolean flag=false;
		try
		{
			String hql="delete from RuinInfo where 1=1"+addhql;
			Query query=super.getSession().createQuery(hql);
			int i=query.executeUpdate();
			if(1>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除报损/报溢详单出错",ex);
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
			System.out.println(pages);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("分页时出错",ex);
		}
		return pages;
	}

	public List somePorLoss(String addhql) {
		String hql="from Ruin where delflag!=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public List somePorLossInfo(String addhql) {
		String hql="from RuinInfo where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	
	

}
