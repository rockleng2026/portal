package com.yeepay;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class UpserverDAOImpl extends HibernateDaoSupport implements IUpserverDAO{

	public List getAll(String hql) {
		return super.getHibernateTemplate().find(hql);
		
	}
	
	public static void main(String[] args) {
		IUpserverDAO dao = new UpserverDAOImpl();
		String hql="from UpServer";
		List list = dao.getAll(hql);
		for(Object obj:list){
			System.out.println(obj);
		}
	}

}
