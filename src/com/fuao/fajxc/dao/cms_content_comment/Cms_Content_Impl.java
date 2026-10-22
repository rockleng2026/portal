package com.fuao.fajxc.dao.cms_content_comment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.taglibs.standard.tag.el.sql.QueryTag;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Content_Comments;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;

public class Cms_Content_Impl extends BaseDao implements Cms_Content{
	
	/**
	 *  查询文章的总记录数
	 */
public int countData(String sql) {
    Session session = (Session) super.getSessionFactory().getCurrentSession();
    System.out.println(session);
    Query query = session.createQuery(sql);
    int count = Integer.parseInt(query.uniqueResult().toString());
    System.out.println(count);
	return count;
}
  /**
   * 文章列表分页
   */
@SuppressWarnings("unchecked")
public List splitPages(int current,int row,String sql) {
    System.out.println(current);
    System.out.println(row);
	Session session = (Session)super.getSessionFactory().getCurrentSession();
	Query query = session.createQuery(sql);
	query.setFirstResult(current);
	query.setMaxResults(row);	
	List list=query.list();
	System.out.println(list.size());
	return printList(list);
}

//组装数据
	@SuppressWarnings("unchecked")
	public List printList(List liss){
		System.out.println(""+liss.size());
		List list=new ArrayList();
		int count=1;
		for(int i=0;i<liss.size();i++){
			Fa_Cms_Content_Comments fcn=(Fa_Cms_Content_Comments)liss.get(i);			 
				Map m=new HashMap();
				m.put("conid", count++);
				m.put("pid",fcn.getId());
				m.put("menName",fcn.getNews().getClasses().getClassname());//信息类别
				m.put("pabase",fcn.getNews().getTitle());
				m.put("papayboty",fcn.getNews().getContents());
				String s="";
				String st="";
				if(fcn.getNews().getShowflag()==0){//显示
					s="隐藏";
					st="显示";
				}
				if(fcn.getNews().getShowflag()==1){//隐藏
					s="显示";
					st="隐藏";
				}
				m.put("psho",s);
				m.put("pshow", st);
				String str="";
				String wait="";
				String mid="";
				String pass="";
				if(fcn.getNews().getStatus()==0){  //待审核
					str="待审核";
				}
				else if(fcn.getNews().getStatus()==1){  //审核中
					str="审核中";
				}else{
					str="审核通过";
				}
				m.put("pareward",str);
				m.put("pawage",fcn.getSendtime());
				m.put("pOper","aa");
				list.add(m);
		}
			    return list;
	}
public void addDate(Fa_Cms_Content_Comments news) {
	this.getHibernateTemplate().save(news);
	
}
public void delDate(Fa_Cms_Content_Comments news) {
	this.getHibernateTemplate().delete(news);
	
}
public List getid(int id) {
	// TODO Auto-generated method stub
	return null;
}
public void updDate(Fa_Cms_Content_Comments news) {
	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
	session.beginTransaction();
	session.merge(news);
	session.getTransaction().commit();
}
public Fa_Cms_Content_Comments getById(int id) {
	return (Fa_Cms_Content_Comments) this.getHibernateTemplate().get(Fa_Cms_Content_Comments.class, id);
}

	

}
