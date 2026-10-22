package com.fuao.fajxc.bussiness.customService;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RefundmentLog;

public interface ClientReturnOrderBussiness {

	/**
	 * 添加客户退单
	 * @param order
	 * @return
	 */
	public boolean addClientReturnOrder(RefundmentLog log) ;
	
	/**
	 * 删除客户退单
	 * @param order
	 * @return
	 */
	public boolean delClientReturnOrder(RefundmentLog log) ;

	/**
	 * 修改客户退单
	 * @param order
	 * @return
	 */
	public boolean editClientReturnOrder(RefundmentLog log) ;
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values);
	
	/**
	 * 根据表名，获得相应的列表
	 * @param hql
	 * @return
	 */
	public List getObject(String tableName,String andhql);
}
