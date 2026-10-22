package com.fuao.fajxc.dao.impl.system;

import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.system.WorkorderconfigurDao;
import com.fuao.fajxc.vo.Empassess;
import com.fuao.fajxc.vo.Questioncategory;

public class WorkorderConfigurDaoImpl extends BaseDaoImpl implements WorkorderconfigurDao {

	public Empassess addempassess(Empassess empass) {
		super.getHibernateTemplate().saveOrUpdate(empass);
		return empass;
	}

	public Questioncategory addquestion(Questioncategory question) {
		super.getHibernateTemplate().saveOrUpdate(question);
		return question;
	}

	public void delassess(int id) {
		
		String hql = "delete Empassess e where e.questioncategory.id = ?";	
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, id);
		query.executeUpdate();
	}

	public void delqc(int id) {
		
		String hql = "delete Questioncategory q where q.id = ?";	
		
		Query query=this.getSession().createQuery(hql);
		
		query.setParameter(0, id);
		
		query.executeUpdate();
	}

}
