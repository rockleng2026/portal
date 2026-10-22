package com.fuao.fajxc.bussiness.impl.basic;
import java.util.List;
import com.fuao.fajxc.bussiness.basic.CustomerAuditingBussiness;
import com.fuao.fajxc.dao.basic.CustomerAuditingDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerAuditing;
public class CustomerAuditingBussinessImpl implements CustomerAuditingBussiness{
		private  CustomerAuditingDao  customerAuditingDao;
		
		public CustomerAuditingDao getCustomerAuditingDao() {
			return customerAuditingDao;
		}

		public void setCustomerAuditingDao(CustomerAuditingDao customerAuditingDao) throws Exception{
			this.customerAuditingDao = customerAuditingDao;
		}

		public boolean addData(CustomerAuditing data) throws Exception {
				try {
					customerAuditingDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		public List<CustomerAuditing> exHql(String hql) {
			List<CustomerAuditing> datas=null;
			try {
				datas=customerAuditingDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=customerAuditingDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(CustomerAuditing data) {
			try {
				customerAuditingDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public CustomerAuditing getCustomerAuditingdata(String id) {
			CustomerAuditing data=null;
			try {
				data= (CustomerAuditing) customerAuditingDao.getCustomerAuditingdata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
}
