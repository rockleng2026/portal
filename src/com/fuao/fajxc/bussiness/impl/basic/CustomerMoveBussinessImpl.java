package com.fuao.fajxc.bussiness.impl.basic;
import java.util.List;
import com.fuao.fajxc.bussiness.basic.CustomerMoveBussiness;
import com.fuao.fajxc.dao.basic.CustomerMoveDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerMove;
public class CustomerMoveBussinessImpl implements CustomerMoveBussiness{
		private  CustomerMoveDao  customerMoveDao;
		
		public CustomerMoveDao getCustomerMoveDao() {
			return customerMoveDao;
		}

		public void setCustomerMoveDao(CustomerMoveDao customerMoveDao) throws Exception{
			this.customerMoveDao = customerMoveDao;
		}

		public boolean addData(CustomerMove data) throws Exception {
				try {
					customerMoveDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		public List<CustomerMove> exHql(String hql) {
			List<CustomerMove> datas=null;
			try {
				datas=customerMoveDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=customerMoveDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(CustomerMove data) {
			try {
				customerMoveDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public CustomerMove getCustomerMovedata(String id) {
			CustomerMove data=null;
			try {
				data= (CustomerMove) customerMoveDao.getCustomerMovedata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
}
 