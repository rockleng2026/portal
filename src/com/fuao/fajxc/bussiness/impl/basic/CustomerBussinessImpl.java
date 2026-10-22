package com.fuao.fajxc.bussiness.impl.basic;
import java.util.List;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.dao.basic.CustomerDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
public class CustomerBussinessImpl implements CustomerBussiness{
		private  CustomerDao  customerDao;
		
		public CustomerDao getCustomerDao() {
			return customerDao;
		}

		public void setCustomerDao(CustomerDao customerDao) throws Exception{
			this.customerDao = customerDao;
		}

		/**
		 * 添加客户
		 */
		public boolean addData(Customer data) throws Exception {
				try {
					customerDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		/**
		 * 添加客户 返回对象
		 */
		public Customer addCustomer(Customer data) throws Exception {
			Customer customer = (Customer) customerDao.addReturnObject(data);
			return customer;
		}
		
		public List<Customer> exHql(String hql) {
			List<Customer> datas=null;
			try {
				datas=customerDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=customerDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(Customer data) {
			try {
				customerDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		/*
		 * 修改
		 */
		public void doupdata(Object ob){
			customerDao.doupdata(ob);
		}

		public Customer getCustomerdata(String id) {
			Customer data=null;
			try {
				data= (Customer) customerDao.getCustomerdata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
		public int updateConkout(String hql)
		{
			int i=0;
			i=customerDao.exehqlupdate(hql);
			return i;
		}

		public String executeSql(String sql) {
			
			return customerDao.executeSql(sql);
		}

		public void sqlupdate(String hql) {
			// TODO Auto-generated method stub
			customerDao.sqlupdate(hql);
		}

		public List exhql(String sql) {
			// TODO Auto-generated method stub
			return customerDao.exhql(sql);
		}

	

		
}
