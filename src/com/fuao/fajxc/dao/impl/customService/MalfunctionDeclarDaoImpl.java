package com.fuao.fajxc.dao.impl.customService;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.impl.SessionImpl;

import com.fuao.fajxc.dao.customService.MalfunctionDeclarDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Sendmessage;
import com.jspsmart.upload.Request;

public class MalfunctionDeclarDaoImpl extends BaseDaoImpl implements MalfunctionDeclarDao{

	public int exehqlupdate(String hql) {
		// TODO Auto-generated method stub
		int i=0;
		try{
			Query query=this.getSession().createQuery(hql);
			i=query.executeUpdate();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return i;
	}

	public Conkoutask addCoa(Conkoutask coa) {
		super.getHibernateTemplate().saveOrUpdate(coa);
		return coa;
	}

	public ConkOut addconkOut(ConkOut co) {
		super.getHibernateTemplate().saveOrUpdate(co);
		return co;
	}
	
	public Object getObj(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	public void updObj(Object obj){
		try{
			super.getSession().beginTransaction();
			super.getSession().update(obj);
			super.getSession().getTransaction().commit();
		}catch(Exception e){
			super.getSession().getTransaction().rollback();
		}
	}
	
	public void addObje(Object obj){
		this.getHibernateTemplate().save(obj);
	}
	
	public void addBySQL(String sql){
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
	}
	
	public List queryBySQL(String sql){
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		return query.list();
	}
	
	public void exeSQL(String sql){
		Session session = this.getSession();
	
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
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
