package com.fuao.fajxc.bussiness.impl.customService;

import java.util.List;

import com.fuao.fajxc.bussiness.customService.ClientReturnOrderBussiness;
import com.fuao.fajxc.dao.customService.ClientReturnOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RefundmentLog;

public class ClientReturnOrderBussinessImpl implements ClientReturnOrderBussiness {

	private ClientReturnOrderDao clientReturnOrderDao;

	
	/**
	 * 添加客户退单
	 * @param order
	 * @return
	 */
	public boolean addClientReturnOrder(RefundmentLog log)
	{
		return clientReturnOrderDao.addClientReturnOrder(log);
	}

	/**
	 * 删除客户退单
	 * @param order
	 * @return
	 */
	public boolean delClientReturnOrder(RefundmentLog log)
	{
		return clientReturnOrderDao.editClientReturnOrder(log);
	}
	
	/**
	 * 修改客户退单
	 * @param order
	 * @return
	 */
	public boolean editClientReturnOrder(RefundmentLog log) 
	{
		return clientReturnOrderDao.editClientReturnOrder(log);
	}
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values)
	{
		return clientReturnOrderDao.exHqlPages(hql, pageNo, pageSize, values);
	}
	
	/**
	 * 根据表名，获得相应的列表
	 * @param hql
	 * @return
	 */
	public List getObject(String tableName,String andhql)
	{
		String hql = "from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		return clientReturnOrderDao.getObject(hql);
	}
	
	
	
	
	
	public ClientReturnOrderDao getClientReturnOrderDao() {
		return clientReturnOrderDao;
	}

	public void setClientReturnOrderDao(ClientReturnOrderDao clientReturnOrderDao) {
		this.clientReturnOrderDao = clientReturnOrderDao;
	}

}
