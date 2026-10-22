package com.fuao.fajxc.dao.impl.stockpile;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.impl.purchase.PurOrderDaoImpl;
import com.fuao.fajxc.dao.stockpile.OutboundDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.StatInfo;

public class OutBoundDaoImpl extends BaseDaoImpl implements OutboundDao {

	private static Logger logger = Logger.getLogger(OutBoundDaoImpl.class);
	
	public boolean addOutBound(Outbound ob) {
		System.out.println("No:"+ob.getOutboundNo());
		System.out.println("Dao");
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(ob);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加出库单出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delOutBound(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update Outbound set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除出库单时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean editOutBound(Outbound ob) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(ob);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改出库单时出错",ex);
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

	public List someOutBound(String addhql) {
		Query query=this.getSession().createQuery("from Outbound where delflag!=1"+addhql);
		System.out.println("queryList:"+query.list());
		return query.list();
	}

	public boolean addOutInfo(OutboundInfo ob) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(ob);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加出库详细时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delOutInfo(String addhql) {
		boolean flag=false;

			String hql="delete from OutboundInfo where 1=1"+addhql;
			Query query=this.getSession().createQuery(hql);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		return flag;
	}

	public List someOutInfo(String addhql) {
		String hql="from OutboundInfo where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public List selType(String addhql) {
		String hql="from AllType where type=0"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public boolean delProduct(Object[] obj) throws RuntimeException {
		boolean flag=false;
	
			String hql="update Product set delflag=1 where id in (:ids) or parentId in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids", obj);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
			return flag;
	}

	public boolean exeHql(String hql) {
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
	public List selectInfo(String hql)
	{
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	

}
