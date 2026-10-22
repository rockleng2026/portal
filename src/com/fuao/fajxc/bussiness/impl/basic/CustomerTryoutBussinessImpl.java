package com.fuao.fajxc.bussiness.impl.basic;
import java.util.List;

import com.fuao.fajxc.bussiness.basic.CustomerTryoutBussiness;
import com.fuao.fajxc.dao.basic.CustomerTryoutDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerTryout;
public class CustomerTryoutBussinessImpl implements CustomerTryoutBussiness{
		private  CustomerTryoutDao  customerTryoutDao;
		
		public CustomerTryoutDao getCustomerTryoutDao() {
			return customerTryoutDao;
		}

		public void setCustomerTryoutDao(CustomerTryoutDao CustomerTryoutDao) throws Exception{
			this.customerTryoutDao = CustomerTryoutDao;
		}

		//添加客户试用记录
		public boolean addData(CustomerTryout data) throws Exception {
				try {
					customerTryoutDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		/**
		 * 添加客户试用记录
		 * 返回对象
		 */
		public CustomerTryout addReturnData(CustomerTryout data) throws Exception {
				try {
					return (CustomerTryout) customerTryoutDao.addReturnObject(data);
				} catch (Exception e) {
					throw e;
				}
		}
		
		public List<CustomerTryout> exHql(String hql) {
			List<CustomerTryout> datas=null;
			try {
				datas=customerTryoutDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=customerTryoutDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(CustomerTryout data) {
			try {
				customerTryoutDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public CustomerTryout getCustomerTryoutdata(String id) {
			CustomerTryout data=null;
			try {
				data= (CustomerTryout) customerTryoutDao.getCustomerTryoutdata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
}
