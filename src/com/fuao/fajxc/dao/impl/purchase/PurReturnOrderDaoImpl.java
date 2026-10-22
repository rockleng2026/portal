/**
 * 
 */
package com.fuao.fajxc.dao.impl.purchase;

import java.io.Serializable;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.purchase.PurReturnOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.ReturnOrder;
import com.fuao.fajxc.vo.ReturnOrderInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-27
 */
public class PurReturnOrderDaoImpl extends BaseDaoImpl implements PurReturnOrderDao {

	private static Logger logger = Logger.getLogger(PurReturnOrderDaoImpl.class);
	
	/**
	 * 添加采购退货单
	 * @param order
	 * @return
	 */
	public boolean addPurOrder(ReturnOrder order) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(order);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购退货单添加出错",ex);
		}
		return flag;
	}
	
	
	/**
	 * 添加采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean addPurOrderInfo(ReturnOrderInfo order)
	{
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(order);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购退货单添加出错",ex);
		}
		return flag;
	}

	/**
	 * 修改采购退货单
	 * @param order
	 * @return
	 */
	public boolean editPurReturnOrder(ReturnOrder order) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(order);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购退货单修改时出错",ex);
		}
		return flag;
	}
	
	/**
	 * 修改采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean editPurReturnOrderInfo(ReturnOrderInfo order) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(order);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购退货单修改时出错",ex);
		}
		return flag;
	}
	
	/**
	 * 删除采购退货单
	 * @param order
	 * @return
	 */
	public boolean deletePurReturnOrder(ReturnOrder order) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().delete(order);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购退货单删除时出错",ex);
		}
		return flag;
	}
	
	/**
	 * 删除采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean deletePurReturnOrderInfo(ReturnOrderInfo order) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().delete(order);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购退货单详单删除时出错",ex);
		}
		return flag;
	}
	
	/**
	 * 获取列表
	 * @param andhql
	 * @return
	 */
	public List getObjectList (String andhql)
	{
		List list = null;
		try
		{
			Query query = this.getSession().createQuery(andhql);
			list = query.list();
			System.out.println(list.size());
			if(list.size()>0)
			{
				return list;
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("获取采购退货单列表出错",ex);
		}
		return null;
	}

	/**
	 * 获取采购退货单对象
	 * @param andhql
	 * @return
	 */
	public ReturnOrder getObject(String andhql)
	{
		System.out.println("~~~~~~~~~~~~~~~~~~~ hql = "+andhql);
		ReturnOrder order = new ReturnOrder();
		try
		{
			order = (ReturnOrder)this.getSession().createQuery(andhql).list().get(0);
			if(order.getId()>0)
			{
				return order;
			}
			else {
				order.setId(0);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("获取采购退货单对象出错",ex);
		}
		return order;
	}
}
