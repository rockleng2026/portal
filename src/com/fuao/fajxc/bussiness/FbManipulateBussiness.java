package com.fuao.fajxc.bussiness;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.fuao.fajxc.util.Pages;


/**
 * 表单操作业务逻辑层接口
 * @author 14012
 *
 */
public interface FbManipulateBussiness {
	/**
	 * 添加
	 * @param obj 要添加或者修改的对象
	 * @return fb 附表列表
	 * @return Object 插入成功后的新对象
	 * @throws Exception 
	 */
	public Object addForm(Object obj, List fb,HttpServletRequest request) throws Exception;
	
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
	public List getForm(String tableName,String andhql);
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) ;

	
}
