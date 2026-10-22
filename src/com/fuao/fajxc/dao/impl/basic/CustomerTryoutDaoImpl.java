package com.fuao.fajxc.dao.impl.basic;
import java.util.List;
import com.fuao.fajxc.dao.basic.CustomerTryoutDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerTryout;

public class CustomerTryoutDaoImpl extends BaseDaoImpl implements CustomerTryoutDao{

	public boolean addData(CustomerTryout data) throws Exception {
		super.add(data);
		return true;
	}

	public List<CustomerTryout> exHql(String hql) {
		List<CustomerTryout> datas=null;
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

	public CustomerTryout getCustomerTryoutdata(String id) {
		try {
			return (CustomerTryout) super.select(CustomerTryout.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(CustomerTryout data)throws Exception  {
			super.update(data);
			return true;
	}
	
}
