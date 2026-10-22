package com.fuao.fajxc.dao.cms_rec_part;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;
import com.sun.istack.internal.FinalArrayList;

public class Rec_PartDaoImpl extends BaseDao implements Rec_PartDao{


	public void addPart(Fa_Cms_Rec_Part part) {
		this.getHibernateTemplate().save(part);
	}

	public void delPart(Fa_Cms_Rec_Part part) throws Exception{
		System.out.println("pid="+part.getPid());
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.beginTransaction();
		session.delete(part);
		session.getTransaction().commit();
	}


	@SuppressWarnings("unchecked")
	public List getObjects(final String hql) {
		return this.getHibernateTemplate().find(hql);
	}



	public Object getPartById(Class clazz, Integer id) {
		return super.getHibernateTemplate().get(clazz, id);
	}

	public void updPart(Fa_Cms_Rec_Part part) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.beginTransaction();
		session.merge(part);
		session.getTransaction().commit();
	}

	  /*
	   * 文章列表分页
	   */
	@SuppressWarnings("unchecked")
	public List splitPages(int current,int row) {
	    System.out.println(current);
	    System.out.println(row);
		Session session = (Session)super.getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Fa_Cms_Rec_Part order by pid desc");
		query.setFirstResult(current);
		query.setMaxResults(row);	
		List<Fa_Cms_Rec_Part> list=(List<Fa_Cms_Rec_Part>)query.list();
		System.out.println("AAAAAA"+list.size());
		return printList(list);
	}
	
	@SuppressWarnings("unchecked")
	public List splitPages(int current,int row,String andhql) {
	    System.out.println(current);
	    System.out.println(row);
		Session session = (Session)super.getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Fa_Cms_Rec_Part where 1=1 "+andhql+" order by pid desc");
		query.setFirstResult(current);
		query.setMaxResults(row);	
		List<Fa_Cms_Rec_Part> list=(List<Fa_Cms_Rec_Part>)query.list();
		System.out.println("AAAAAA"+list.size());
		return printList(list);
	}
	
	    //组装数据
		@SuppressWarnings("unchecked")
		public List printList(List liss){			
			System.out.println(""+liss.size());
			List list=new ArrayList();
			int count=1;
			for(int i=0;i<liss.size();i++){

				    Fa_Cms_Rec_Part part=(Fa_Cms_Rec_Part)liss.get(i);			 

					Map m=new HashMap();

					m.put("pastaName", count++); //类别ID
					m.put("pid", part.getPid());
					m.put("menid",part.getPart_desc());  //参数位置
					m.put("menName",part.getEng_name());//英文名称
					
//					String[] arry=part.getTemp().split(",");
					m.put("pabase",part.getClasses().getClassname());//所属栏目(站点)
					int body=part.getMid();
					String pps="";
					if(body==1){
						pps="首页";
					}else if(body==2){
						pps="栏目页";
					}else if(body==3){
						pps="内容页";
					}else if(body==4){
						pps="最新页面";
					}else{
						pps="其它页面";
					}
					m.put("papayboty",pps);//所属模块
					m.put("paperMoney",part.getPart_num());//最大数量
					m.put("pareward","aa");//操作

					list.add(m);
			}
				    return list;
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
	 * 得到所有的推荐位置
	 */
	public List getAllPart(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 根据主键查询文章的标题
	 */
	public Fa_Cms_News getNewsById(Class clazz,Integer id){
		return (Fa_Cms_News)super.getHibernateTemplate().get(clazz, id);
	}
	
	/**
	 * 提交推荐
	 */
	public void addRec_info(Fa_Cms_Rec_Info info){
		super.getHibernateTemplate().save(info);
	}
	
}
