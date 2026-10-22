package com.fuao.fajxc.bussiness.common;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.fuao.fajxc.util.Pages;



public interface CommonBiz  {
	/**
	 * 添加表单
	 * @param obj 要添加或者修改的表单对象
	 * @return fb 附表列表 无则为null
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
	 * 根据实例类和序列化主键查找对象
	 * @param tableName  表名
	 * @param andhql     条件
	 * @return
	 */
	public Object getForm(Class cls,Serializable primaryKey);
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
	
	public boolean addFJ(String sbh, String beanName, HttpServletRequest request);
	/**
	 * 添加附件2--
	 * @param fbsbh
	 * @param beanName
	 * @param request
	 * @return
	 */
	public void addFJ2(String fjlj,String beanName,String fjmc,String fjhz, String functionid,HttpServletRequest request);

	public List splitPages(int current,int row);
	
	public int  countData();

	public String executeSql(String sql);

	public List executeHql(String string);
}
