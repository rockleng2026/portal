package com.fuao.fajxc.dao.basic;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerMove;

public interface CustomerMoveDao extends BaseDao{

	/*
	 * 客户基本资料
	 */
	public boolean addData(CustomerMove data)throws Exception;
	
	/*
	 *修改 客户基本资料
	 */
	public boolean updateData(CustomerMove data)throws Exception ;
	
	
	public CustomerMove getCustomerMovedata(String id);
	/*
	 *特殊查询客户基本资料
	 */
	public List<CustomerMove>  exHql(String hql);
	
	/*
	 *执行分页查询客户基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	
	
	
}
