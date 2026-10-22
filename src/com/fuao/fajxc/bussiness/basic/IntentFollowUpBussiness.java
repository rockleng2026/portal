package com.fuao.fajxc.bussiness.basic;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IntentFollowUp;

public interface IntentFollowUpBussiness {
		
		/*
		 * 添加客户跟进记录
		 */
		public boolean addData(IntentFollowUp data)throws Exception;
		
		/**
		 * 添加客户跟进记录
		 * 返回对象
		 */
		public IntentFollowUp addReturnData(IntentFollowUp data) throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(IntentFollowUp data);
		
		
		public IntentFollowUp getIntentFollowUpdata(String id);
		/*
		 *特殊查询客户基本资料
		 */
		public List<IntentFollowUp>  exHql(String hql);
		
		/*
		 *执行分页查询客户基本资料
		 */
		public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}
