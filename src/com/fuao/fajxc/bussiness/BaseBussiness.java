package com.fuao.fajxc.bussiness;

import java.util.List;

import com.fuao.fajxc.util.Pages;

/**
 * 通用的业务父类接口
 * @author 阙超强 14015
 * @time 2012-02-27 11:41:07
 *
 */
public interface BaseBussiness {
	
	/**
	 * 添加
	 * @param object
	 * @return entity
	 */
	public Object add(Object object);
	
	/**
	 * 修改
	 * @param object
	 * @return Object
	 */
	public boolean update(Object object);
	
	/**
	 * 软删除
	 * @param object
	 * @return Object
	 */
	public boolean delSoft(Object object);

	/**
	 * 硬删除
	 * @param object
	 * @return Object
	 */
	public boolean delHard(Object object); 
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exeHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 根据单个标识查询对象
	 * @param id 单个对象的唯一标识
	 * @return Object 执行后返回的对象
	 */
	public Object getById(Class cls,int id);
	
	/**
	 * 执行HQL语句
	 * @return
	 */
	public List exeHql(String hql);
	
	/**
	 * 执行SQL语句
	 * @return
	 */
	public List executeSql(String sql);
	/**
	 * 
	 * 执行sql修改
	 */
	public int exeUpdateSql(String sql);
}
