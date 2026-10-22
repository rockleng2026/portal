package com.fuao.fajxc.bussiness.system;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.VerifyOrderDepartment;
import com.fuao.fajxc.vo.VerifyOrderEmployee;

public interface VerifyOrderBussiness {

	/**
	 * 获取对象列表
	 * @param hql
	 * @return
	 */
	public List getObject(String tableName,String andhql);
	
	/**
	 * 添加审核流程
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean addVerifyOrder(VerifyOrder verify) ;
	
	/**
	 * 添加审核员工
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean addVerifyOrderEmployee(VerifyOrderEmployee employee);
	
	/**
	 * 修改审核流程
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean editVerifyOrder(VerifyOrder verify) ;
	
	/**
	 * 删除审核流程
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean delVerifyOrder(VerifyOrder verify) ;
	
	/**
	 * 删除审核流程员工
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean delVerifyOrderEmployee(VerifyOrderEmployee employee);
	
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
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages1(String hql, int pageNo, int pageSize,Object... values) ;
	/*******
	 * 根据hql语句查找对象集合
	 */
	public List exHql(String hql);
	/*************
	 * 根据ID找到对象
	 */
	public Object getObjectById(Class clazz,Integer id);
	/**
	 * 添加审核部门
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean addVerifyOrderDepartment(VerifyOrderDepartment dept);
}
