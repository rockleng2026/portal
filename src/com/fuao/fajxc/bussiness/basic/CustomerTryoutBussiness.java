package com.fuao.fajxc.bussiness.basic;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerTryout;

public interface CustomerTryoutBussiness {
		
		/*
		 * 客户基本资料
		 */
		public boolean addData(CustomerTryout data)throws Exception;
		
		/**
		 * 添加客户试用记录
		 * 返回对象
		 */
		public CustomerTryout addReturnData(CustomerTryout data) throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(CustomerTryout data);
		
		
		public CustomerTryout getCustomerTryoutdata(String id);
		/*
		 *特殊查询客户基本资料
		 */
		public List<CustomerTryout>  exHql(String hql);
		
		/*
		 *执行分页查询客户基本资料
		 */
		public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}
