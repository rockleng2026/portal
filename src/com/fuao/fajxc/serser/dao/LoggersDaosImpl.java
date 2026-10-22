package com.fuao.fajxc.serser.dao;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.util.IterfaceConmens;
import com.fuao.fajxc.vo.LogTab;

public class LoggersDaosImpl extends HibernateDaoSupport implements LoggersDaos{

	public boolean deleteDate(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public Object getObjDate(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List getdateList(Object obj) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean saveDate(Object obj) {
		LogTab ltb=(LogTab) obj;
		try{
			this.getSession().beginTransaction();
			this.getSession().save(ltb);
			this.getSession().getTransaction().commit();
			return true;
		}catch (Exception e) {
			this.getSession().getTransaction().rollback();
			return false;
		}
		
	}

	public boolean updateDate(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

}
