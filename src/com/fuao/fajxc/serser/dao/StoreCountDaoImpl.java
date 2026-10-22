package com.fuao.fajxc.serser.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.SaleOrder;

public class StoreCountDaoImpl extends HibernateDaoSupport implements StoreCountDao {
    
	public List selAllDateList() {
		return this.getHibernateTemplate().find("from Depot");
	}

	public List getStoreList(String sql,int current,int pagesize) {
		Query query = this.getSession().createQuery(sql);
		query.setFirstResult(current);
		query.setMaxResults(pagesize);
		List list = query.list();
		System.out.println("rows="+ list.size());
		return list;
	}
	
	public List getStoreList2(String sql){
		Query query = this.getSession().createQuery(sql);
		List list = query.list();
		return list;
	}

	public int getStoreSize(String sql) {
		System.out.println(sql);
		Query query = this.getSession().createQuery(sql);
		int m =query.list().size();
		return m;
	}

	public List getSingleSelect(String hsql) {
		Query query = this.getSession().createQuery(hsql);
		return query.list();
	}

	public List differentCondition(String sql) {
		Query query = this.getSession().createQuery(sql);
		return query.list();
	}
	
	public List executeSql(String sql){
		Session session = this.getSessionFactory().getCurrentSession();
		Query query = session.createQuery(sql);
		List list = query.list();
		return list;
	}

}
