package com.fuao.fajxc.dao.server;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class UpserverImp extends HibernateDaoSupport implements UpserverD{

	public List getUpserver(String hql) {
		return super.getHibernateTemplate().find(hql);
	}

}
