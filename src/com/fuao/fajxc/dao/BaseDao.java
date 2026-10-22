package com.fuao.fajxc.dao;
import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.SaledFlow;
import com.fuao.fajxc.vo.UpServer;

public interface BaseDao {
	public void add(Object data)throws Exception;
	public boolean update(Object data)throws Exception;
	public void delete(Object data)throws Exception;
	public void updateSaleorder(String  slaeOrderNo) throws Exception ;
	public Object select(Class cls,Serializable primaryKey)throws Exception;
	public int countSql(String sql);
	public List getUpserver(String hql);
	
	/**
 	 * 添加数据  返回对象
 	 */
 	public Object addReturnObject(Object data); 
 	
 	public void  updateIPs(IPConfiguration ipc);
 	
 	/**
 	 * 根据客户的姓名查找单据
 	 * @param sql
 	 * @return
 	 */
	public List selectOrder(String hql);
	
	
	public List execSQL(String sql);
	/**
	 * 根据登录名称查找登录用户信息
	 * @param loginName
	 * @return
	 */
	public Object getObj(String loginName);
	
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
    
	public UpServer upmerger(UpServer upser);
	
	public void saveFlowInfo(SaledFlow sfd);
	public void updtFlowInfo(SaledFlow sfd);
	
	public boolean saveRecharge(RechargeLog rech);
	public void updtRecharge(RechargeLog rech);
	public List selAllKinddatas(String sql);
	
	
}
