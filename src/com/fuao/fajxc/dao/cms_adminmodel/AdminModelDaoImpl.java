package com.fuao.fajxc.dao.cms_adminmodel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;
import com.fuao.fajxc.vo.Fa_Cms_News;

public class AdminModelDaoImpl extends BaseDao implements AdminModelDao{

	// 新增
	public void addModel(Object obj) {
		super.getHibernateTemplate().save(obj);
	}

	//删除
	public void deleteModel(Fa_Cms_AdminModel model) {
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		String sql="delete from Fa_Cms_AdminModel where modelid="+model.getModelid();
		 Query query = session.createQuery(sql);
		 query.executeUpdate();
	}
	
	//根据主键加载
	public Fa_Cms_AdminModel getModelById(Class clazz, Integer id) {
		return (Fa_Cms_AdminModel)super.getHibernateTemplate().get(Fa_Cms_AdminModel.class, id);
	}
	
	//列表
	public List modelList(String hql) {
		return super.getHibernateTemplate().find(hql);
	}
	
	//修改
	public void updateModel(Fa_Cms_AdminModel model) {
		System.out.println(model.getModelname());
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.beginTransaction();		
		session.merge(model);
		session.getTransaction().commit();
	}
	
	/**
	 * 查询模块表总记录
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
	 * 模块列表分页
	 * @param current
	 * @param row
	 * @param sql
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List splitPages(int current,int row,String sql) {
	    System.out.println(current);
	    System.out.println(row);
		Session session = (Session)super.getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Fa_Cms_AdminModel order by modelid desc");
		query.setFirstResult(current);
		query.setMaxResults(row);	
		List<Fa_Cms_News> list=(List<Fa_Cms_News>)query.list();
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
			Fa_Cms_AdminModel model=(Fa_Cms_AdminModel)liss.get(i);		
				Map m=new HashMap();
				m.put("id", model.getModelid()); //主键
				m.put("mkmc", model.getModelname()); //模块名称
				m.put("mkywm", model.getModelalias()); //模块英文名
				m.put("tb", model.getModelico());  //模块图标
				m.put("lj", model.getModelurl()); //路径
				m.put("cz", "a");
				list.add(m);
		}
			    return list;
	}

	public List getObjects(String hql, Object[] params) {
		return super.getHibernateTemplate().find(hql,params);
	}
	public List getOneMenu(String sqlname) {
		Session session = (Session)super.getSessionFactory().getCurrentSession();
		Query query = session.createSQLQuery("select * from fa_cms_adminmodel where modelico like  '"+sqlname+"'");
		List<Fa_Cms_AdminModel> list= query.list();
		return list;
	}

      //显示在右边
	public List getAllModels(int m) {
        Query query = this.getSession().createQuery("from Fa_Cms_AdminRight t where t.admins.user_id="+m);
        List list=query.list();
        System.out.println("list="+list.size());
		return list;
	}

	@SuppressWarnings("unchecked")
	public List getOnTrees() {
		List list=this.getHibernateTemplate().find("from Fa_Cms_AdminModel f where f.modelico like '%0000'");
		System.out.println("one="+list.size());
		return list;
	}

	@SuppressWarnings("unchecked")
	public List getToTrees(String ca) {
	    List list=this.getHibernateTemplate().find("from Fa_Cms_AdminModel f where f.modelico like '"+ca+"%'   and SUBSTRING(f.modelico,5,2)= '00'  AND  SUBSTRING(f.modelico,3,4) <> '0000'");
	    System.out.println("two="+list.size()); 
		return list;
	}

	@SuppressWarnings("unchecked")
	public List getthTrees(String ca) {
		List list=this.getHibernateTemplate().find("from Fa_Cms_AdminModel f where f.modelico like '"+ca+"%'   and SUBSTRING(f.modelico,5,2) <> '00'");
		System.out.println("three="+list.size());
		return list;
	}

	@SuppressWarnings("unchecked")
	public List getbyObject(Object obj, Object ob) {
		Fa_Cms_Admin adm = (Fa_Cms_Admin) obj;
		Fa_Cms_AdminModel admod= (Fa_Cms_AdminModel) ob;
		System.out.println("adm="+adm.getUser_id());
		System.out.println("admod="+admod.getModelid());
		List list=this.getHibernateTemplate().find("from Fa_Cms_AdminRight f where f.admins.user_id="+adm.getUser_id()+" "+"and f.mods.modelico='"+admod.getModelico()+"'");
		System.out.println("four="+list.size());
		return list;
	}

	public List getByTwoGrade(Fa_Cms_Admin obj, Fa_Cms_AdminModel ob) {
		return null;
	}
}
