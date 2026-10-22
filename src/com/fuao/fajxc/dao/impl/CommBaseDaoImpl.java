package com.fuao.fajxc.dao.impl;
import java.io.Serializable;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.impl.CriteriaImpl;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.Assert;

import com.fuao.fajxc.dao.CommBaseDao;
import com.fuao.fajxc.util.BeanUtils;
import com.fuao.fajxc.util.PageBuilder;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Users;
public class CommBaseDaoImpl extends HibernateDaoSupport implements CommBaseDao{
	static Log log = LogFactory.getLog(BaseDaoImpl.class);
	
	/**
	 * 添加
	 */
 	public void add(Object data) throws Exception {
		super.getHibernateTemplate().save(data);
	}
 	
 	/**
 	 * 添加数据  返回对象
 	 */
 	public Object addReturnObject(Object data){
 		try {
 			super.getHibernateTemplate().saveOrUpdate(data);
 			return data;
		} catch (Exception e) {
			System.out.println("添加对象并返回对象时出错！");
			e.printStackTrace();
		}
		return null;
	}
 	
	public void delete(Object data) throws Exception {	
		super.getHibernateTemplate().delete(data);
	}
	/**
	 * 
	 * @param 硬性删除
	 * @return  返回执行后的对象list集合
	 */
	public void del(Class cs,String primaryKey)
	{
		super.getHibernateTemplate().delete(super.getHibernateTemplate().get(cs, Integer.parseInt(primaryKey)));
	}

	/**
	 * 更改对象
	 * 
	 */
	public void update(Object data) throws Exception {
		super.getHibernateTemplate().merge(data);
	}
	
	/**
	 * 根据单个标识查询对象
	 * @param cls 要操作的对象
	 * @param primaryKey 单个对象的唯一标识
	 * @return Object 执行后返回的对象
	 */
	public Object select(Class cls, Serializable primaryKey) throws Exception {
		return  super.getHibernateTemplate().get(cls, primaryKey);
	}
	
	/**
	 * 用sql语句查询
	 * @param sql 要执行的sql语句
	 * @return List 执行后的结果
	 */
	
	public List execSQL( final String sql) 
	{

		try
		{
			return (List)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
				    return session.createSQLQuery(sql).list();
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	
	
	/**
	 * 
	 * @param 需要执行的sql语句
	 * @param 
	 * @param 查询多少个
	 * @return  返回执行后的对象list集合
	 */
	public List execSQLByPage( final String sql,final int offset,final int pagesize) 
	{
		// TODO Auto-generated method stub
		try
		{
			return (List)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
				    SQLQuery query = session.createSQLQuery(sql);
				    query.setFirstResult(offset);
				    query.setMaxResults(pagesize);
				    
				    return query.list();
				    
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	
	
	/**
	 * 
	 * @param 需要执行的sql语句
	 * @return  返回执行后受影响的行数
	 * 
	 */
	public int execSQLUpdate( final String sql) 
	{
		try
		{
			return (Integer)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
				    return session.createSQLQuery(sql).executeUpdate();
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	
	/**
	 * 
	 * @param 需要执行的hql语句
	 * @return  返回执行后的对象list集合
	 */
	@SuppressWarnings({ "deprecation", "unchecked" })
	public List execHQL( final String hql) 
	{
		// TODO Auto-generated method stub
		try
		{
			return (List)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
				    return session.createQuery(hql).list();
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	@SuppressWarnings({ "deprecation", "unchecked" })
	public List findByDetachedCriteriaPage(final DetachedCriteria detachedCriteria,final int offset, final int length) 
	{
		// TODO Auto-generated method stub
		try
		{
			return (List)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
					Criteria criteria = detachedCriteria.getExecutableCriteria(session);
					criteria.setFirstResult(offset);
					criteria.setMaxResults(length);
					
				    return criteria.list();
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	public List findDetachedCriteria(final DetachedCriteria detachedCriteria) 
	{
		// TODO Auto-generated method stub
		try
		{
			return (List)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
					Criteria criteria = detachedCriteria.getExecutableCriteria(session);
				    return criteria.list();
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	public Integer findByDetachedCriteria(final DetachedCriteria detachedCriteria) 
	{
		// TODO Auto-generated method stub
		try
		{
			return (Integer)super.getHibernateTemplate().execute(new HibernateCallback()
		    {
				public Object doInHibernate(Session session) throws HibernateException
			    {
					Criteria criteria = detachedCriteria.getExecutableCriteria(session);
					criteria.setProjection(Projections.rowCount());
					//return (Integer) criteria.setProjection(Projections.rowCount()).uniqueResult();
				    return (Integer)criteria.uniqueResult();
			    }
			
		    },true);
		}
		catch(RuntimeException re)
		{
			throw re;
		}
	}
	
	/**
	 * 分页查询
	 */
	public Pages paginationQuery(final int pageNo, final int pageSize,
			final Class _persistentClass, final Criterion... criterion) {
		return (Pages) getHibernateTemplate().execute(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Criteria criteria = createCriteria(session,_persistentClass,criterion);
				return paginationQuery(pageNo, pageSize, criteria,_persistentClass);
			}
		});
	}


	public Pages paginationQuery(final int pageNo, final int pageSize,
			final Criteria fc,Class _persistentClass) {
		return paginationQuery(pageNo, pageSize, fc, true,_persistentClass);
	}
	public Pages paginationQuery(final int pageNo, final int pageSize,
			final Criteria fc, final boolean countRecord,final Class _persistentClass ) {

		return (Pages) getHibernateTemplate().execute(new HibernateCallback() {

			public Object doInHibernate(Session session) 
					throws HibernateException, SQLException {
				//log.debug("starting pagination query...");
				int thePageNo = pageNo;
				if (thePageNo < 1)
					thePageNo = 1;
				long interval = new Date().getTime();
				Criteria criteria = fc;
				if (criteria == null)
					criteria = session.createCriteria(_persistentClass);

				CriteriaImpl impl = (CriteriaImpl) criteria;

				if (impl.getSession() == null) {
					impl.setSession((SessionImplementor) session);
				}
				long totalCount = 0;
				if (countRecord) {
					Projection projection = impl.getProjection();
					List<CriteriaImpl.OrderEntry> orderEntries;
					try {
						orderEntries = (List<CriteriaImpl.OrderEntry>) BeanUtils
								.forceGetProperty(impl, "orderEntries");
						BeanUtils.forceSetProperty(impl, "orderEntries",
								new ArrayList<Object>());
					} catch (Exception e) {
						throw new InternalError(
								" Runtime Exception impossibility throw ");
					}
					criteria = criteria.setProjection(Projections.rowCount());
					Object obj = criteria.uniqueResult();
					if (obj instanceof Integer) {
						totalCount = ((Integer) obj).longValue();
					} else if (obj instanceof Long) {
						totalCount = ((Long) obj).longValue();
					}
					// long totalCount =
					// ((Integer)criteria.setProjection(Projections.rowCount()).
					// uniqueResult()).longValue();
					if (projection == null) {
						criteria
								.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
					}
					try {
						BeanUtils.forceSetProperty(impl, "orderEntries",
								orderEntries);
					} catch (Exception e) {
						throw new InternalError(
								" Runtime Exception impossibility throw ");
					}
				} else {
					totalCount = (thePageNo + 1) * pageSize;
				}

				if (totalCount < 1) {
					return PageBuilder.createEmptyPage();
				}
				Pages page = PageBuilder.createPage(thePageNo, totalCount,
						pageSize);

				int startIndex = page.getRecordStart();
				log.debug("pagination query prepared in "
						+ (new Date().getTime() - interval) + "ns.");
				log.debug("starting pagination query excecute...");

				List<Object> list = criteria.setFirstResult(startIndex)
						.setMaxResults(pageSize).list();
				if (!countRecord && list.size() < pageSize) {
					totalCount = (pageNo - 1) * pageSize + list.size();
					page = PageBuilder.createPage(thePageNo, totalCount,
							pageSize);
				}
				page.setPageList(list);
				log.debug("pagination query excecute in "
						+ (new Date().getTime() - interval) + "ns.");
				return page;
			}

		});

	}

	public Pages paginationQuery(int pageNo, int pageSize,
			DetachedCriteria detachedCriteria,Class _persistentClass) {
		return paginationQuery(pageNo, pageSize, detachedCriteria
				.getExecutableCriteria(getSession()),_persistentClass);
	}

	/**
	 * 
	 * @param 需要执行的hql语句
	 * @param 当前页数
	 * @param 需要查询返回的个数
	 * @return  返回执行后的对象page集合
	 */
	@SuppressWarnings( { "boxing", "unchecked" })
	public Pages paginationQuery(final String hql, final int pageNo,
			final int pageSize, final Object... values) {
		Assert.hasText(hql);
		return (Pages) getHibernateTemplate().execute(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				String countQueryString = " select count (*) "
						+ removeSelect(removeOrders(hql));
				List<?> countlist = getHibernateTemplate().find(
						countQueryString, values);
				long totalCount = (Long) countlist.get(0);

				if (totalCount < 1) {
					return PageBuilder.createEmptyPage();
				}
				Pages page = PageBuilder.createPage(pageNo, totalCount,
						pageSize);
				int startIndex = page.getRecordStart();

				System.out.println("hql:+++:"+hql);
				System.out.println("hql:+++:"+values);
				
				Query query = createQuery(session, hql, values);
				List<Object> list = query.setFirstResult(startIndex).setMaxResults(
						pageSize).list();
				if(list == null){
					list = new ArrayList();
				}
				page.setPageList(list);
				return page;
			}

		});
	}   

	public Criteria createCriteria(Session session,Class _persistentClass, Criterion... criterions) {
		Criteria criteria = session.createCriteria(_persistentClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}
	//b
	public static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, StringUtils.EMPTY);
		}
		m.appendTail(sb);
		return sb.toString();
	}
	//a
	public static String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
		return hql.substring(beginPos);
	}
	
	public Query createQuery(Session session, String hql, Object... values) {
		Assert.hasText(hql);
		Query query = session.createQuery(hql);
		if(values != null){
			for (int i = 0; i < values.length; i++) {
				System.out.println(hql+"参数i"+i+"----"+values[i]);
				query.setParameter(i, values[i]);
			}
		}
		return query;
	}
	
	//添加UUID到saleorder中
	public void updateSaleorder(String  slaeOrderNo) throws Exception {
		String s=UUID.randomUUID().toString();//UUID创建
		String sql="update auditingordertab set sbh='"+s+"' where orderNo='"+slaeOrderNo+"'";
		int q =  getSession().createSQLQuery(sql).executeUpdate();
	}

	public List selectOrder(String hql) {
		Query query=getSession().createQuery(hql);
		return query.list();
	}
	
	/**
	 * 传入表名与条件，获取对象列表
	 * @param tableName 要查询的表名
	 * @param andhql    where条件
	 * @return list 结果集
	 */
	public List getObject(String tableName,String andhql)
	{
		String hql = " from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password)
	{
		Users user = new Users();
		
		user.setLoginName(loginname);
		
		user.setPassword(password);
		String hql="from Users where loginName=? and password=? and delflag=0";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, user.getLoginName());
		query.setParameter(1, user.getPassword());
		Users users = new Users();
		
		if(query.list().size()>0)
		{
			users = (Users)query.list().get(0);
		}
		else {
			users.setUserId(0);
		}
		return users;
	}
	/**
	 * 根据用户id查询该用户是否存在访问权限
	 * @param userid
	 * @return
	 */
	public RoleFunctionInfo isExistsPermissionByUserId(int userid)
	{
		System.out.println("execute isExistsPermissionByUserId........");
		String hql = "from RoleFunctionInfo rff where rff.users.userId=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, userid);
		List list = query.list();
		System.out.println(list.size());
		
		if(list.size()>0)
		{
			RoleFunctionInfo rff=(RoleFunctionInfo)list.get(0);
			if(rff.getRoleFunctionId()>0)
			{
				return rff;
			}
		}
		RoleFunctionInfo rff = new RoleFunctionInfo();
		rff.setRoleFunctionId(0);
		
		return rff;
	}
}