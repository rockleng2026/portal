package com.fuao.fajxc.dao.cms_news;

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
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;

public class NewsDaoImpl extends BaseDao implements NewsDao{
	
	/**
	 * 列表
	 */
	public List getList(String hql){
		
		return null;
	}
	
	public List getObjects(final String hql) {
		try
		{
			return (List)super.getHibernateTemplate().execute(new HibernateCallback(){
				public Object doInHibernate(Session session) throws HibernateException{
				    return session.createQuery(hql).list();
			    }
			},true);
		}catch(RuntimeException re){
			throw re;
		}
	}
	 
	/**
	 * 点击隐藏、显示
	 */
	public void hiddenNews(int cid,int flag) {
		Session session = this.getSessionFactory().getCurrentSession();
		String hql = "update Fa_Cms_News set showflag="+flag+" "+"where cid="+cid;
		Query query=session.createQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 模糊查询(标题、是否显示、审核状态、信息类别)
	 */
	public List selectNews(Fa_Cms_News news) {
		return null;
	}
	
	/**
	 * 点击修改,页面传id过来,根据传过来的id从数据库取到当前
	 */
	public Object getNewsById(Class clazz, Integer id) {
		return super.getHibernateTemplate().get(Fa_Cms_News.class, id);
	}
	
	/**
	 * 修改文章
	 */
	public void updNews(Fa_Cms_News news){
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.beginTransaction();
		session.saveOrUpdate(news);
		session.getTransaction().commit();
		
	}
	
	
	/**
	 * 新增文章
	 */
	public void addNews(Fa_Cms_News news){
		this.getHibernateTemplate().save(news);
	}
	
	
	/**
	 * 删除
	 */
	public void delNews(Fa_Cms_News news){
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		String sql="update Fa_Cms_News set delflag=1,showflag=0 where cid="+news.getCid();
		 Query query = session.createQuery(sql);
		 query.executeUpdate();
	}
	 
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
public List splitPages(int current,int row,String hql) {
    System.out.println(current);
    System.out.println(row);
	Session session = (Session)super.getSessionFactory().getCurrentSession();
//	Query query = session.createQuery("from Fa_Cms_News order by cid desc");
	Query query = session.createQuery(hql);
	query.setFirstResult(current);
	query.setMaxResults(row);	
	List<Fa_Cms_News> list=(List<Fa_Cms_News>)query.list();
	//System.out.println(list.size());
	return printList(list);
}

public List splitPagesNews(int current,int row) {
    System.out.println(current);
    System.out.println(row);
	Session session = (Session)super.getSessionFactory().getCurrentSession();
	Query query = session.createQuery("from Fa_Cms_News order by cid desc");
	query.setFirstResult(current);
	query.setMaxResults(row);	
	List<Fa_Cms_News> list=(List<Fa_Cms_News>)query.list();
	System.out.println("AAAAAA"+list.size());
	return printList(list);
}

public List splitPagesRecInfo(int current,int row,String andhql) {
    System.out.println(current);
    System.out.println(row);
	Session session = (Session)super.getSessionFactory().getCurrentSession();
	Query query = session.createQuery("from Fa_Cms_Rec_Info where 1=1 "+andhql+" order by id desc");
	query.setFirstResult(current);
	query.setMaxResults(row);	
	List<Fa_Cms_News> list=(List<Fa_Cms_News>)query.list();
	System.out.println("AAAAAABB"+list.size());
	return printRecInfoList(list);
}


//组装数据 袁天龙
//@SuppressWarnings("unchecked")
//public List printNewsList(List liss){			
//	System.out.println(""+liss.size());
//	List list=new ArrayList();
//	int count=1;
//	for(int i=0;i<liss.size();i++){
//
//		Fa_Cms_News news=(Fa_Cms_News)liss.get(i);			 
//
//			Map m=new HashMap();
//
//			m.put("menid", count++); //编号
//			m.put("cid", news.getCid()); //PK(用于推荐)
//			m.put("menName", news.getClasses().getClassname());//类别名称
//			m.put("pabase", news.getTitle());//标题
//			m.put("papayboty", news.getContents());//内容
//			if(news.getShowflag()==0){  //是否显示
//				m.put("paperMoney", "是");
//			}
//			if(news.getShowflag()==1){
//				m.put("paperMoney", "否");
//			}
//			if(news.getStatus()==0){ //审核状态
//				m.put("pareward", "未审核");
//			}
//			if(news.getStatus()==1){
//				m.put("pareward", "审核通过");
//			}
//			m.put("pawage", news.getSenddate()); //录入时间
//			m.put("pOper", "opera");
//			list.add(m);
//	}
//		    return list;
//}


//组装数据
	@SuppressWarnings("unchecked")
	public List printList(List liss){
		System.out.println(""+liss.size());
		List list=new ArrayList();
		int count=1;
		for(int i=0;i<liss.size();i++){
			   Fa_Cms_News fcn=(Fa_Cms_News)liss.get(i);		
				Map m=new HashMap();
//				m.put("id", f);
				m.put("id", fcn.getCid());
				m.put("sequence", fcn.getSequence());
				m.put("pid",fcn.getCid());
				if(fcn.getClasses() !=null){
					m.put("pst",fcn.getClasses().getClassname());
				}else{
					m.put("pst","无关联分类");
				}
				
				m.put("ptl",fcn.getTitle());
				m.put("pcot",fcn.getSmalltext());
				m.put("keys",fcn.getKeyboard());
				String s="";
				String st="";
				if(fcn.getShowflag()==0){
					s="显示";
					st="隐藏";
				}
				if(fcn.getShowflag()==1){
					s="隐藏";
					st="显示";
				}
				m.put("psho",s);
				m.put("psh", st);
				String str="";
				if(fcn.getStatus()==0){
					str="未审核";
				}else if(fcn.getStatus()==1){
					str="审核成功";
				}else{
					str="审核不通过";
				}
				m.put("psta",str);
				m.put("ptime",fcn.getSenddate());
				m.put("pOper","aa");
				list.add(m);
		}
			    return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public List printRecInfoList(List liss){
		System.out.println(""+liss.size());
		List list=new ArrayList();
		int count=1;
		for(int i=0;i<liss.size();i++){
			   Fa_Cms_Rec_Info info=(Fa_Cms_Rec_Info)liss.get(i);		
				Map m=new HashMap();
//				m.put("id", f);
				m.put("id", info.getId());
				if(info.getNews() !=null){
					m.put("vid",info.getNews().getCid());
					m.put("vtitle",info.getNews().getTitle());
				}else{
					m.put("vid",0);
					m.put("vtitle","文章不存在");
				}
				
				m.put("pid",info.getInfo_pid());
				m.put("pname",info.getInfo_pname());
				m.put("imgsrc",info.getInfo_imgSrc());
				m.put("recdate",info.getInfo_recdate());
				m.put("pOper","aa");
				list.add(m);
		}
			    return list;
	}
	
	/**
	 * 得到类型
	 */
	public List<Fa_Cms_Classes> getClasses(){
		String sql="from Fa_Cms_Classes where delflag=0";
		return this.getHibernateTemplate().find(sql);
	}
	
	/**
	 * 得到用户
	 */
	public List<Fa_Cms_Member> getMember(){
		String sql="from Fa_Cms_Member";
		return this.getHibernateTemplate().find(sql);
	}

	public void excuteHql(String hql) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.beginTransaction();
	    session.createQuery(hql).executeUpdate();
		session.getTransaction().commit();	
	}

}
