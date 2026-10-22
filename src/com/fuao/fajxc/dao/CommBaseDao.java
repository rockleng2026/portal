package com.fuao.fajxc.dao;
import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Users;
public interface CommBaseDao {
	public void add(Object data)throws Exception;
	public void update(Object data)throws Exception;
	public void delete(Object data)throws Exception;
	public void updateSaleorder(String  slaeOrderNo) throws Exception ;
	public Object select(Class cls,Serializable primaryKey)throws Exception;
	
	/**
 	 * 添加数据  返回对象
 	 */
 	public Object addReturnObject(Object data); 
 	
 	
 	
 	/**
 	 * 根据客户的姓名查找单据
 	 * @param sql
 	 * @return
 	 */
	public List selectOrder(String hql);
	
	
	public List execSQL(String sql);
	
	/**
	 * 
	 * @param hql 需要执行的hql语句
	 * @return  返回执行后的对象list集合
	 */
	public List execHQL( final String hql) ;
	
	/**
	 * 硬性删除
	 * @param cs 要执行的类
	 * @param primaryKey 要删除对象的标识
	 * @return  null
	 */
	public void del(Class cs,String primaryKey);
	
	/**
	 * 
	 * @param sql 需要执行的sql语句
	 * @param offset 
	 * @param pagesize 每页显示数据的数量
	 * @return  返回执行后的对象list集合
	 */
	public List execSQLByPage( final String sql,final int offset,final int pagesize) ;
	

	public List findByDetachedCriteriaPage(final DetachedCriteria detachedCriteria,final int offset, final int length) ;
	
	/**
	 * 
	 * @param 需要执行的sql语句
	 * @return  返回执行后的数据库受影响的行数
	 */
	public int execSQLUpdate( final String sql) ;
	
	public Integer findByDetachedCriteria(final DetachedCriteria detachedCriteria) ;
	
	/**
	 * 分页查询
	 * @param 需要执行的hql语句
	 * @param 当前页数
	 * @param 需要查询返回的个数
	 * @return  返回执行后的对象page对象集合
	 */
	public Pages paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values);
	
	/**
	 * 
	 * @param 需要执行的hql语句
	 * @param 当前页数
	 * @param 需要查询返回的个数
	 * @return  返回执行后的对象list集合
	 */
	public Pages paginationQuery(final int pageNo, final int pageSize,final Class _persistentClass, final Criterion... criterion);
	
	public Pages paginationQuery(final int pageNo, final int pageSize,final Criteria fc,Class _persistentClass);

	/**
	 * 根据表名以及条件，获取对象列表
	 * @param tableName
	 * @param andhql
	 * @return
	 */
	public List getObject(String tableName,String andhql);
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password);
	
	/**
	 * 根据用户id查询该用户是否存在访问权限
	 * @param userid
	 * @return
	 */
	public RoleFunctionInfo isExistsPermissionByUserId(int userid);

}
