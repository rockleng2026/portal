package com.fuao.fajxc.dao.cms_website;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;

public class EnderWebSiteDAOImpl extends BaseDao  implements WebSiteDAO{

	public List getRecPartList(int sitekey, int mid) {
		
//		Session session = super.getSessionFactory().getCurrentSession();
		//组合查询条件
		String hql="from  Fa_Cms_Rec_Part rp where rp.typeid="+sitekey+" and rp.mid="+mid;
//		Fa_Cms_Rec_Part 
		return this.getHibernateTemplate().find(hql);
	}

	public List<Fa_Cms_Rec_Info> getRecInfoList(String andhql,int topnum) {
		//Session sess
		String hql = "from Fa_Cms_Rec_Info where 1=1 "+andhql+" order by id desc limit 0,"+topnum;
		return super.getHibernateTemplate().find(hql);
		
		
	}

	
	
	
	
	
}
