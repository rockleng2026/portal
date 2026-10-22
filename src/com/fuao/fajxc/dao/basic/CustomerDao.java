package com.fuao.fajxc.dao.basic;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Customer;

public interface CustomerDao extends BaseDao{

	/*
	 * 客户基本资料
	 */
	public boolean addData(Customer data)throws Exception;
	
	/*
	 *修改 客户基本资料
	 */
	public boolean updateData(Customer data)throws Exception ;
	
	
	public Customer getCustomerdata(String id);
	/*
	 *特殊查询客户基本资料
	 */
	public List<Customer>  exHql(String hql);
	
	/*
	 *执行分页查询客户基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 执行更新
	 * @param hql
	 * @return
	 */
	public int exehqlupdate(String hql) ;
	
	public String executeSql(String sql);

	public void doupdata(Object ob);

	public void sqlupdate(String hql);

	public List exhql(String sql);
	

	
	
	
	
}
