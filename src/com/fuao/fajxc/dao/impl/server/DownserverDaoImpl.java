package com.fuao.fajxc.dao.impl.server;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.server.DownserverDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.DownServer;

public class DownserverDaoImpl extends BaseDaoImpl implements DownserverDao {

	private static Logger logger = Logger.getLogger(DownserverDaoImpl.class);
	
	public boolean adddownServer(DownServer ds) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().saveOrUpdate(ds);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加下架单时出错",ex);
		}
		return flag;
	}

	public boolean deldownServer(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update DownServer set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("下架单删除时出错Dao",ex);
		}
		return flag;
	}

	public boolean editdownServer(DownServer ds) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().saveOrUpdate(ds);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改下架单时出错Dao",ex);
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
			logger.error("下架单分页时出错Dao",ex);
		}
		return pages;
	}

	public List somedownServer(String addhql) {
		String hql="from DownServer where delflag=0"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public List someType(String addhql) {
		String hql=" from AllType where type=5 "+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	
	public boolean executeHql(String hql) {
		boolean flag=false;
		try
		{
			Query query=this.getSession().createQuery(hql);
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

}
