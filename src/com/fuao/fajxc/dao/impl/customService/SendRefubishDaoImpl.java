package com.fuao.fajxc.dao.impl.customService;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.customService.SendRefurbishDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.Sendmessage;

public class SendRefubishDaoImpl extends BaseDaoImpl implements SendRefurbishDao {

	public List someList(String hql) {
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	
	/**
	 * ÃÌº”œ˚œ¢
	 */
	public boolean addsendmess(Sendmessage senmes){
		boolean flag=false;
		try{
			this.getHibernateTemplate().save(senmes);
			flag=true;
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return flag;
	}

}
