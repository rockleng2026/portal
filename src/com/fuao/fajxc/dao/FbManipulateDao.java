package com.fuao.fajxc.dao;

import java.util.List;

import com.fuao.fajxc.util.Pages;



/**
 * 表单操作共用接口
 * @author 14012
 *
 */
public interface FbManipulateDao{
	
	/**
	 * 添加表单附表
	 * @param entity 要添加的表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addFb(Object entity);
	
	/**
	 * 添加表单
	 * @param entity 要添加的表单对象
	 * @return Object 添加后的表单对象
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
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) ;

	/**
	 * 删除附表信息
	 */
	public int delfb(String tableName ,String andhql);
	
	/**
	 * 根据beanName查询busID
	 */
	public int getBusid(String beanName);
	
	/**
	 * 修改表单状态为重新申请
	 */
	public boolean updateForm(String hql);
}
