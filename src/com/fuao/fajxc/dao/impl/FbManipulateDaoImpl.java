package com.fuao.fajxc.dao.impl;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.dao.FbManipulateDao;
import com.fuao.fajxc.util.Pages;

/**
 * 表单操作共用实现类
 * @author 14012
 *
 */
public class FbManipulateDaoImpl extends BaseDaoImpl implements FbManipulateDao {

	private static Logger logger = Logger.getLogger(FbManipulateDaoImpl.class);
	/**
	 * 添加表单
	 * @param entity 要添加的表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addForm(Object entity) {
		try{
		//调用Spring为hibernet提供的的添加或者修改方法添加表单实体
		 super.getHibernateTemplate().saveOrUpdate(entity);
		}catch (Exception e) {
			e.printStackTrace();
			logger.debug(e);
		}
		//返回添加后的实体
		 return entity;
	}
	
	/**
	 * 添加附表
	 * @param entity 要添加的表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addFb(Object entity) {
		try{
		//调用Spring为hibernet提供的的添加或者修改方法添加表单实体
		 super.getHibernateTemplate().save(entity);
		}catch (Exception e) {
			e.printStackTrace();
			logger.debug(e);
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
			logger.debug(e);
		}
		return rowcount;
	}
	
	
	
	/**
	 * 根据表名和条件查询相应列表集合
	 * @param tableName  表名
	 * @param andhql     条件
	 * @return
	 */
	@SuppressWarnings("unchecked")
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
			logger.debug(e);
		}
		return list;
	}
	
	/**
	 * 删除附表信息
	 * 
	 */
	public int delfb(String tableName ,String andhql)
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
			logger.debug(e);
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
		Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public static void main(String[] arg){
		//String paths[] = {"applicationContext.xml","applicationContext-system.xml","applicationContext-basic.xml","applicationContext-form.xml","applicationContext-login.xml"};
		//ApplicationContext context = new ClassPathXmlApplicationContext(paths);
		//FbManipulateDao impl = (FbManipulateDao)context.getBean("formdao");
		//String rid = "2,3,";
		//List<SwjgEmployee> list = impl.getForm("SwjgEmployee", " and id= 74");
		//System.out.println("size : "+list.size());
		//List<Swjg> swjg =impl.getForm("Swjg", " and swjg.id = "+list.get(0).getSwjg().getId());
		//for(int i=0;i<list.size();i++){
		//	System.out.println("  "+list.get(i).getSwjg().getSwjgName());
		//}
		//System.out.println(list.size());
	}

	public int getBusid(String beanName) {
//		String hql = "from Businessform where remark = '"+beanName+"'";
//		List list = super.execHQL(hql);
//		if(null != list && list.size()>0)
//		{
//			Businessform businessform = (Businessform)list.get(0);
//			return businessform.getId();
//		}
		return 0;
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
}
