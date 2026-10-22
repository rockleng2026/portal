package com.fuao.fajxc.bussiness.basic;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerMove;

public interface CustomerMoveBussiness {
		
		/*
		 * 客户基本资料
		 */
		public boolean addData(CustomerMove data)throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(CustomerMove data);
		
		
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
