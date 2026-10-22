package com.fuao.fajxc.dao.impl.basic;

import java.util.List;


import com.fuao.fajxc.dao.basic.CustomerAuditingDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerAuditing;

public class CustomerAuditingDaoImpl extends BaseDaoImpl implements CustomerAuditingDao{

	public boolean addData(CustomerAuditing data) throws Exception {
		super.add(data);
		return true;
	}

	public List<CustomerAuditing> exHql(String hql) {
		List<CustomerAuditing> datas=null;
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

	public CustomerAuditing getCustomerAuditingdata(String id) {
		try {
			return (CustomerAuditing) super.select(CustomerAuditing.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(CustomerAuditing data)throws Exception  {
			super.update(data);
			return true;
	}
	
}
