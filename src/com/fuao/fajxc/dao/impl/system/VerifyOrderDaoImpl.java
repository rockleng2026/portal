package com.fuao.fajxc.dao.impl.system;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.system.VerifyOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.VerifyOrderDepartment;
import com.fuao.fajxc.vo.VerifyOrderEmployee;

public class VerifyOrderDaoImpl extends BaseDaoImpl implements VerifyOrderDao {

	/**
	 * 获取对象列表
	 * @param hql
	 * @return
	 */
	public List getObject(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	
	/**
	 * 添加审核流程
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean addVerifyOrder(VerifyOrder verify) throws Exception
	{
		this.add(verify);
		return true;
	}
	
	/**
	 * 添加审核员工
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean addVerifyOrderEmployee(VerifyOrderEmployee employee) throws Exception
	{
		this.add(employee);
		return true;
	}
	
	/**
	 * 修改审核流程
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean editVerifyOrder(VerifyOrder verify) throws Exception
	{
		this.update(verify);
		return true;
	}
	
	/**
	 * 删除审核流程
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean delVerifyOrder(VerifyOrder verify) throws Exception
	{
		this.delete(verify);
		return true;
	}
	
	/**
	 * 删除审核流程员工
	 * @param verify
	 * @return
	 * @throws Exception 
	 */
	public boolean delVerifyOrderEmployee(VerifyOrderEmployee employee) throws Exception
	{
		this.delete(employee);
		return true;
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
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages1(String hql, int pageNo, int pageSize,Object... values) 
	{
		Pages page=null;
		try {
			 page=super.paginationQuery1(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}
	
	/*******
	 * 根据hql语句查找对象集合
	 */
	public List exHql(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	/*************
	 * 根据ID找到对象
	 */
	public Object getObjectById(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	
	/**
	 * 添加审核部门
	 * @param verify
	 * @return
	 * @throws Exception 
	 * @throws Exception 
	 */
	public boolean addVerifyOrderDepartment(VerifyOrderDepartment dept) throws Exception{
		this.add(dept);
		return true;
	}
	
}
