package com.fuao.fajxc.dao.impl.stockpile;

import java.util.List;

import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.stockpile.IncomeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Income;
import com.fuao.fajxc.vo.IncomeInfo;

public class IncomeDaoImpl  extends BaseDaoImpl implements IncomeDao {

	public List someIncomeInfo(String addhql) {
		String hql="from IncomeInfo where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		List list=query.list();
		if(list!=null)
			return list;
		return null;
	}

	public boolean addIncome(Income income) {
		boolean flag=false;
	    try
	    {
	    	this.getHibernateTemplate().save(income);
	    	flag=true;
	    }
	    catch(Exception ex)
	    {
	    	ex.printStackTrace();
	    }
		return flag;
	}

	public boolean addIncomeInfo(IncomeInfo incomeInfo) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(incomeInfo);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delIncome(Object[] obj) {
		boolean flag=false;
		try
		{
			String hql="update Income set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",obj);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delIncomeInfo(String addhql) {
		String hql="delete from IncomeInfo where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		int i=query.executeUpdate();
		if(i>0)
			return true;
		return false;
	}

	public boolean editIncome(Income income) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(income);
			flag=true;
		}
		catch(Exception ex)
		{
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
			logger.error("·ÖÒ³Ê±³ö´í",ex);
		}
		return pages;
	}

	public List selIncome(String addhql) {
		String hql="from Income where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		List list=query.list();
		if(list!=null)
			return list;
		return null;
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		IncomeDao pb=(IncomeDao)ac.getBean("incomeDao");
		System.out.println(pb.selIncome(" and id=37"));
	}

}
