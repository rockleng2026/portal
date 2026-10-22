package com.fuao.fajxc.dao.message;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.hql.ast.SqlASTFactory;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;

public class NoticeDaoImpl extends BaseDaoImpl implements NoticeDao{

	public List getNotice(String hql) {
		return this.getHibernateTemplate().find(hql);
	}

	public void addNotice(Object obj) {
		this.getHibernateTemplate().save(obj);
	}

	public Object getObjectById(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	
	public void updateNotice(String hql){
		Session session = this.getSession();
		Query query = session.createQuery(hql);
		int a = query.executeUpdate();
		System.out.println(a);
		//this.getHibernateTemplate().update(obj);
	}
	
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
}
