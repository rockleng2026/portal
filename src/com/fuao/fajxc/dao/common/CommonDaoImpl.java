package com.fuao.fajxc.dao.common;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
/**
 * 表单操作共用实现类
 * @author 14012
 *
 */
public class CommonDaoImpl extends BaseDaoImpl implements CommonDao {

	private static Logger logger = Logger.getLogger(CommonDaoImpl.class);
	/**
	 * 添加表单saveOrUpdate
	 * @param entity 要添加或者更新表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addForm(Object entity) {
		try{
			System.out.println("------------------"+entity);
		//调用Spring为hibernet提供的的添加或者修改方法添加表单实体
		 super.getHibernateTemplate().saveOrUpdate(entity);
		 super.getSession().flush();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		}
		//返回添加后的实体
		 return entity;
	}
	
	/**
	 * 添加表单附表
	 * @param entity 要添加的表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addObject(Object entity) {
		try{
		//调用Spring为hibernet提供的的添加或者修改方法添加表单实体
		 super.getHibernateTemplate().save(entity);
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		}
		//返回添加后的实体
		 return entity;
	}
	
	/**
	 * @param hql 根据hql语句修改相应的对象
	 * @return rowcount 返回执行成功的条数
	 */
	public int updateBills(String hql)
	{
		int rowcount = 0;
		System.out.println(hql );
		try
		{
			System.out.println("****");
			Query query = this.getSession().createQuery(hql);
			rowcount = query.executeUpdate();
			System.out.println("rowcount : "+rowcount);
		}
		catch(Exception e)
		{
			logger.error(e);
		}
		return rowcount;
	}
	
	
	
	/**
	 * 根据表名和条件查询相应列表集合
	 * @param tableName  表名
	 * @param andhql     条件
	 * @return
	 */
	public List getForm(String tableName ,String andhql)
	{
		String hql = " from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		List list = new ArrayList();
		try
		{
			Query query = this.getSession().createQuery(hql);
			list = query.list();
		}
		catch(Exception e)
		{
			logger.error(e);
		}
		return list;
	}
	
	/**
	 * 删除附表信息
	 * @param tableName 实体bean名称
	 * @param andhql 条件sql 
	 * 组合sql hql = " delete from "+tableName+" where 1=1 "+andhql;
	 */
	public int delObjectByAndhql(String tableName ,String andhql)
	{
		String hql = " delete from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		int i = 0;
		try
		{
			Query query = this.getSession().createQuery(hql);
			 i = query.executeUpdate();
		}
		catch(Exception e)
		{
			logger.error(e);
		}
		return i;
	}
	
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) 
	{
		System.out.println(3333);
		Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}
    
	@SuppressWarnings("unchecked")
	public static void main(String[] arg)
	{
		
//		String url = "http://localhost:8080/SWSystem/form/afterform/nsrjmsqkbab.jsp";
//		System.out.println(url.indexOf("afterform"));
//		
//		System.out.println((int)((Math.random()*9+1)*100000*100000*100));
//		FormManipulateDaoImpl impl = new FormManipulateDaoImpl();
//		System.out.println(impl.getClass().getSimpleName());
//		String paths[] = {"applicationContext.xml","applicationContext-system.xml","applicationContext-basic.xml","applicationContext-form.xml","applicationContext-login.xml"};
//		ApplicationContext context = new ClassPathXmlApplicationContext(paths);
//		CommonDao impl = (CommonDao)context.getBean("formdao");
//		tring hql = "update Auditingorder set swjgEmployeeByEmpId.id = 2,  auditingFlag = 1 , log = '@@@@@@@@@@@@@#' , auditingTime = '2011-09-27 10:36:01.0'  where orderNo = 'SWDJDW2011092100001' and swjg.id = 6";
//		String hql = "update BizSwdjDw set gsJbrQz = '#@#@#@###@#@#',shzt = 1 where lsh='SWDJDW2011100800004'";
//		String rid = "2,3,";
		
		//System.out.println(list.size());
//		int i = impl.delfb("BizBgswdjBgdjsx", "and bizBgswdj.id=62");
//		System.out.println(i);
		CommonDao dao = new CommonDaoImpl();
		System.out.println(dao.countData());
		
	}


	public boolean updateForm(String hql) {
		Query query=this.getSession().createQuery(hql);
		int i=query.executeUpdate();
		if(i>0)
		{
			return true;
		}
		return false;
	}
/**
 * 获得查询对象
 */
	public Object getForm(Class cls, Serializable primaryKey) {
			return this.getSession().get(cls, primaryKey);
	}

	/**
	 *  查询文章的总记录数
	 */
public int countData() {
    Session session = (Session) super.getSessionFactory().getCurrentSession();
    System.out.println(session);
    Query query = session.createQuery("select count(*) from Fa_Cms_News");
    int count = Integer.parseInt(query.uniqueResult().toString());
    System.out.println(count);
	return count;
}
  /**
   * 文章列表分页
   */
@SuppressWarnings("unchecked")
public List splitPages(int current,int row) {
	Session session = (Session)super.getSessionFactory().getCurrentSession();
	Query query = session.createQuery("from Fa_Cms_News order by cid desc");
	query.setFirstResult(current);
	query.setMaxResults(row);
	return query.list();
}

public String executeSql(String sql) {
	Query query = this.getSession().createSQLQuery(sql);
	String returnValue = "";
	List list =query.list();
      if(list != null && list.size()>0){
    	  returnValue= list.get(0).toString();
    	  returnValue = returnValue.substring(1);
      }
      
	return returnValue;
}

public List executeHql(String hql) {
	return super.getHibernateTemplate().find(hql);
}
}
