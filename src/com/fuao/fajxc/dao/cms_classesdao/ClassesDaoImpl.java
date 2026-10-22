package com.fuao.fajxc.dao.cms_classesdao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;

public class ClassesDaoImpl extends BaseDao implements ClassesDao{

	public void addClasses(Fa_Cms_Classes classes) {
		super.getHibernateTemplate().save(classes);
	}

	public void delClasses(Fa_Cms_Classes classes) {
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		String sql="update Fa_Cms_Classes set delflag=1 where classid="+classes.getClassid();
		 Query query = session.createQuery(sql);
		 query.executeUpdate();
	}

	public List getObjects(final String hql) {
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 得到member信息
	 */
	public List<Fa_Cms_Member> getMembers(){
		return super.getHibernateTemplate().find("from Fa_Cms_Member");
	}

	public Object getPartById(Class clazz, Integer id) {
		return super.getHibernateTemplate().get(clazz, id);
	}

	public void updateClasses(Fa_Cms_Classes classes) {
		super.getHibernateTemplate().update(classes);
		super.getHibernateTemplate().flush();
	}
	
	/**
	 *  查询文章的总记录数
	 */
public int countData() {
    Session session = (Session) super.getSessionFactory().getCurrentSession();
    System.out.println(session);
    Query query = session.createQuery("select count(*) from Fa_Cms_Classes where delflag=0");
    int count = Integer.parseInt(query.uniqueResult().toString());
    System.out.println(count);
	return count;
}
  /**
   * 文章列表分页
   */
@SuppressWarnings("unchecked")
public List splitPages(int current,int row) {
    System.out.println(current);
    System.out.println(row);
	Session session = (Session)super.getSessionFactory().getCurrentSession();
	Query query = session.createQuery("from Fa_Cms_Classes where delflag=0 order by classid desc");
	query.setFirstResult(current);
	query.setMaxResults(row);	
	List<Fa_Cms_Classes> list=(List<Fa_Cms_Classes>)query.list();
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
			Fa_Cms_Classes classes=(Fa_Cms_Classes)liss.get(i);			 
				Map m=new HashMap();
				m.put("pastaName", classes.getClassid());  //类别ID
				m.put("superid", classes.getSuperid());
				m.put("islastest", classes.getIslastest());
				m.put("cid", count++);
				m.put("menid",classes.getClassname());  //类别名称
				m.put("egName", classes.getEngname());
				int showflag = classes.getShowflag();
				if(showflag==1){
					m.put("menName", "隐藏");
					m.put("mid", "显示");
				}
				if(showflag==0){
					m.put("menName", "显示");
					m.put("mid", "隐藏");
				}
				int isout = classes.getIsout();
				if(isout==0){
					m.put("pabase", "不外链");
				}
				if(isout==1){
					m.put("pabase", "外链");
				}
				m.put("papayboty",classes.getOutpath()); //外链地址
				m.put("pOper", "aa");// 操作
				list.add(m);
		}
			    return list;
	}
	
	/**
	 * 点击隐藏、显示
	 */
	public void hiddenNews(int cid,int flag) {
		Session session = this.getSessionFactory().getCurrentSession();
		String hql = "update Fa_Cms_Classes set showflag="+flag+" "+"where classid="+cid;
		Query query=session.createQuery(hql);
		query.executeUpdate();
	}
/**
 * 
 * @param sql 父类id
 * @return 获得父类id 及符合条件的子类  1,2,4,5,6 eg..
 */
	public String getClassesIdStr(String superid) {
		String sql = "select getChildClassesLst("+  new Integer(superid) + ")";
		Query query = this.getSession().createSQLQuery(sql);
		String returnValue = "";
		List list =query.list();
	      if(list != null && list.size()>0){
	    	  returnValue= list.get(0).toString();
	    	  returnValue = returnValue.substring(1);
	      }
	      
		return returnValue;
	}
	/**
	 *  查询文章的总记录数
	 * andsql 带and的条件 默认条件 showflag = 1 delflag = 0
	 */
	public int countDataByAndsql(String andsql) {
	Session session = (Session) super.getSessionFactory().getCurrentSession();
	System.out.println(session);
	
	Query query = session.createQuery("select count(*) from Fa_Cms_Classes where delflag=0 "+andsql);
	int count = Integer.parseInt(query.uniqueResult().toString());
	System.out.println(count);
	return count;
	}
	
	/**
	 * 文章列表分页
	 */
	public List splitPagesByAndsql(int current,int row,String andsql) {
	    System.out.println(current);
	    System.out.println(row);
		Session session = (Session)super.getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Fa_Cms_Classes where delflag=0 "+andsql+") order by classid desc");
		query.setFirstResult(current);
		query.setMaxResults(row);	
		List<Fa_Cms_Classes> list=(List<Fa_Cms_Classes>)query.list();
		System.out.println(list.size());
		return printList(list);
	}
	
}
