package com.fuao.fajxc.dao.cms_loggin;

import java.util.List;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.Query;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_AdminRight;

public class LoginDaoImpl extends HibernateDaoSupport implements LoginDao{

	public boolean deleteDate(Object obj) {
		Fa_Cms_AdminRight adright=(Fa_Cms_AdminRight) obj;
		try{
			this.getSession().beginTransaction();
			this.getHibernateTemplate().delete(adright);
			this.getSession().getTransaction().commit();
		}catch (Exception e) {
			e.printStackTrace();
			this.getSession().getTransaction().rollback();
			return false;
		}
		return true;
	}

	public Object getObjDate(int id) {
		return null;
	}

	@SuppressWarnings("unchecked")
	public List getdateList(Object obj) {
		Fa_Cms_Admin admin=(Fa_Cms_Admin) obj;
		System.out.println("l1="+admin.getAdmin_password());
		System.out.println("l2="+admin.getUsername());
		Query query = this.getSession().createQuery("from Fa_Cms_Admin f WHERE f.username='"+admin.getUsername()+""+"' AND admin_password='"+admin.getAdmin_password()+"'");
     	List list=query.list();
		System.out.println("listuser="+list.size());
		return list;
	}

	public boolean saveDate(Object obj) {
		try{
		  Fa_Cms_AdminRight adright=(Fa_Cms_AdminRight) obj;
		  this.getSession().beginTransaction();
		  this.getSession().save(adright);
		  this.getSession().getTransaction().commit();
		}catch(Exception e){
			e.printStackTrace();
			this.getSession().getTransaction().rollback();
		   return false;
		}
		return true;
	}

	public boolean updateDate(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public List getByModelId(int id) {
		return this.getHibernateTemplate().find("from Fa_Cms_AdminRight f where f.admins.user_id="+id);
	}

}
