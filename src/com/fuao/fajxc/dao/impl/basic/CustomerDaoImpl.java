package com.fuao.fajxc.dao.impl.basic;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


import com.fuao.fajxc.dao.basic.CustomerDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;

public class CustomerDaoImpl extends BaseDaoImpl implements CustomerDao{
     private CustomerDao customerDao;
	public CustomerDao getCustomerDao() {
		return customerDao;
	}

	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

	public boolean addData(Customer data) throws Exception {
		super.add(data);
		return true;
	}

	public List<Customer> exHql(String hql) {
		List<Customer> datas=null;
		try {
		datas=super.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public Customer getCustomerdata(String id) {
		try {
			return (Customer) super.select(Customer.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(Customer data)throws Exception  {
			super.update(data);
			return true;
	}
	
	public void doupdata(Object ob){
		this.getHibernateTemplate().update(ob);
	}
	
	public int exehqlupdate(String hql) {
		// TODO Auto-generated method stub
		int i=0;
		try{
			Query query=this.getSession().createQuery(hql);
			i=query.executeUpdate();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return i;
	}

	public String executeSql(String sql) {
		Query query = this.getSession().createSQLQuery(sql);
		
		String returnValue = "";
		
		List list =query.list();
		
          if(list != null && list.size()>0){
        	  
        	  returnValue= list.get(0).toString();
        	  
        	  returnValue = returnValue.substring(1);
          }
          
		return returnValue;
	}

	public void sqlupdate(String hql) {
		Session session=this.getSessionFactory().getCurrentSession();
		Query q=session.createSQLQuery(hql);
		q.executeUpdate();
		
	}

	public List exhql(String sql) {
		// TODO Auto-generated method stub
		return super.execHQL(sql);
	}
	
}
