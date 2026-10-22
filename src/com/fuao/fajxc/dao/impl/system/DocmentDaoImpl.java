package com.fuao.fajxc.dao.impl.system;

import java.util.List;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.system.DocumentDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Docmark;

public class DocmentDaoImpl extends BaseDaoImpl implements DocumentDao  {

	public boolean addDoc(Docmark docm) {
		boolean flag=false;
		try{
			this.getHibernateTemplate().save(docm);
			flag=true;
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delDoc(Docmark docm) {
		boolean flag=false;
		try{
			this.getHibernateTemplate().delete(docm);
			flag=true;
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return flag;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
			 System.out.println("page:"+page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public List selDocmark(String hql) {
		List list=super.execHQL(hql);
		return list;
	}

	public boolean updateDoc(Docmark docm) {
		boolean flag=false;
		try{
			this.getHibernateTemplate().update(docm);
			flag=true;
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return flag;
	}
	
	/*******
	 * 得到集合
	 * @param hql
	 * @return
	 */
	public List exHql(String hql) {
		return this.getHibernateTemplate().find(hql);
	}

}
