package com.fuao.fajxc.dao.impl.stockpile;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.stockpile.StatBussiness;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.impl.purchase.PurOrderDaoImpl;
import com.fuao.fajxc.dao.stockpile.StatDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Stat;
import com.fuao.fajxc.vo.StatInfo;

public class StatDaoImpl extends BaseDaoImpl implements StatDao {

	private static Logger logger = Logger.getLogger(StatDaoImpl.class);
	
	public boolean addStat(Stat stat) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(stat);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加盘点单时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean addStatInfo(StatInfo statinfo) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(statinfo);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加盘点详细时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delStat(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update Stat set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids", ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delStatInfo(String addhql) {
		boolean flag=false;
		try
		{
			String hql="delete from StatInfo where 1=1"+addhql;
			Query query=this.getSession().createQuery(hql);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除盘点单详细",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean editStat(Stat stat) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(stat);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改盘点单 时出错",ex);
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
			logger.error("盘点单分页时出错",ex);
		}
		return pages;
	}

	public List someStat(String addhql) {
		List list=new ArrayList();
		String hql="from Stat where delflag=0"+addhql;
		Query query=this.getSession().createQuery(hql);
		list=query.list();
		return list;
	}

	public List someStatInfo(String addhql) {
		String hql="from StatInfo where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		StatBussiness emd=(StatBussiness) ac.getBean("statBussiness");
		Stat stat=new Stat();
		stat.setDelflag("0");
		emd.addStat(stat);
	}

}
