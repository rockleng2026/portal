package com.fuao.fajxc.bussiness.basic;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;

public interface CustomerBussiness {
		
		/*
		 * 客户基本资料
		 */
		public boolean addData(Customer data)throws Exception;
		
		/*
		 * 客户基本资料
		 */
		public Customer addCustomer(Customer data)throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(Customer data);
		public void doupdata(Object ob);
		
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
		 * 执行hql
		 * @param hql
		 * @return
		 */
		public int updateConkout(String hql);
		
		public String executeSql(String sql);

		public void sqlupdate(String hql);

		public List exhql(String sql);
}
