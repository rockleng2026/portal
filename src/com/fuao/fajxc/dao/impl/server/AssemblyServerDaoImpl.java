package com.fuao.fajxc.dao.impl.server;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.server.AssemblyServerDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AssemblyServer;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;

public class AssemblyServerDaoImpl extends BaseDaoImpl implements AssemblyServerDao {
	
	private static Logger logger = Logger.getLogger(AssemblyServerDaoImpl.class);

	public boolean addassemblyServer(AssemblyServer assS) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(assS);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加组装服务器记录时出错Dao",ex);
		}
		return flag;
	}

	public boolean delassemblyServer(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update AssemblyServer set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("组装服务器记录删除时出错Dao",ex);
		}
		return flag;
	}

	public boolean editassemblyServer(AssemblyServer assS) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(assS);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改组装服务器记录时出错Dao",ex);
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
			logger.error("组装服务器记录分页时出错Dao",ex);
		}
		return pages;
	}

	public List someassemblyServer(String addhql) {
		String hql="from AssemblyServer where delflag=0"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public boolean updateProduct(Object[] ids,int parentId) {
		boolean flag=false;
		try
		{
			String hql="update Product set parentId=? where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameter(0, parentId);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("改变配件状态时出错Dao",ex);
		}
		return flag;
	}

	public boolean addServer(Product pro) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(pro);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public Property selPro(int modelId) {
		String hql="from Property where modelId=?";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, modelId);
		Property pro=(Property) query.list().get(0);
		return pro;
	}

	public boolean editServer(Product pro) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(pro);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean updateparentId(int parentId) {
		boolean flag=false;
		try
		{
			String hql="update Product set parentId=2 where parentId=?";
			Query query=this.getSession().createQuery(hql);
			query.setParameter(0, parentId);
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

	public List selProduct(String addhql) {
		String hql="from Product where delflag=0"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

}
