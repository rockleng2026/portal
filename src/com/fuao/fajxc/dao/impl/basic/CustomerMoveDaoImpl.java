package com.fuao.fajxc.dao.impl.basic;
import java.util.List;
import com.fuao.fajxc.dao.basic.CustomerMoveDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerMove;

public class CustomerMoveDaoImpl extends BaseDaoImpl implements CustomerMoveDao{

	public boolean addData(CustomerMove data) throws Exception {
		super.add(data);
		return true;
	}

	public List<CustomerMove> exHql(String hql) {
		List<CustomerMove> datas=null;
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

	public CustomerMove getCustomerMovedata(String id) {
		try {
			return (CustomerMove) super.select(CustomerMove.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(CustomerMove data)throws Exception  {
			super.update(data);
			return true;
	}
	
}
