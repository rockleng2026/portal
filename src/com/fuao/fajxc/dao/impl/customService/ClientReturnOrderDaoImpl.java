package com.fuao.fajxc.dao.impl.customService;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.dao.customService.ClientReturnOrderDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RefundmentLog;

public class ClientReturnOrderDaoImpl extends BaseDaoImpl implements ClientReturnOrderDao {

	/**
	 * 添加客户退单
	 * @param order
	 * @return
	 */
	public boolean addClientReturnOrder(RefundmentLog log) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(log);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加客户退单出错",ex);
		}
		return flag;
	}
	
	/**
	 * 修改客户退单
	 * @param order
	 * @return
	 */
	public boolean editClientReturnOrder(RefundmentLog log) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(log);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("修改客户退单时出错",ex);
		}
		return flag;
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
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}
	
	/**
	 * 根据表名，获得相应的列表
	 * @param hql
	 * @return
	 */
	public List getObject(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
}
