package com.fuao.fajxc.dao.common;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.util.Pages;



/**
 * 表单操作共用接口
 * @author 14012
 *
 */
public interface CommonDao{
	
	/**
	 * 添加实体bean save方法
	 * @param entity 要添加的表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addObject(Object entity);
	
	/**
	 * 添加表单saveOrUpdate方法
	 * @param entity 要添加或者更新表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addForm(Object entity);
	
	/**
	 * @param hql 根据hql语句修改相应的对象
	 * @return rowcount 返回执行成功的条数
	 */
	public int updateBills(String hql);
	
	
	/**
	 * 根据表名和条件查询相应列表集合
	 * @param tableName  表名
	 * @param andhql     条件
	 * @return
	 */
	public List getForm(String tableName ,String andhql);
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return Pages对象
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) ;

	/**
	 * 根据条件删除实体bean
	 */
	public int delObjectByAndhql(String tableName ,String andhql);
	/**
	 * 根据对象和主键查询记录
	 * @param cls
	 * @param primaryKey
	 */
	public Object getForm(Class cls, Serializable primaryKey);
    
	public List splitPages(int current,int row);
	
	public int  countData();

	public String executeSql(String sql);

	public List executeHql(String hql);
}
