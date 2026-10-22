package com.fuao.fajxc.bussiness.impl.purchase;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.dao.purchase.PurOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;

public class PurOrderBussinessImpl implements PurOrderBussiness {

	
	private Logger logger=Logger.getLogger(PurOrderBussinessImpl.class);
	private PurOrderDao purOrderDao;
	
	

	/**
	 * @return the purOrderDao
	 */
	public PurOrderDao getPurOrderDao() {
		return purOrderDao;
	}

	/**
	 * @param purOrderDao the purOrderDao to set
	 */
	public void setPurOrderDao(PurOrderDao purOrderDao) {
		this.purOrderDao = purOrderDao;
	}

	/**
	 * 添加采购单
	 */
	public boolean addPurOrder(PurOrder purO) {
		// TODO Auto-generated method stub
		return purOrderDao.addPurOrder(purO);
	}

	/**
	 * 添加采购单 返回对象
	 * @author 阙超强 14015
	 * @param purO
	 * @return PurOrder
	 */
	public PurOrder addPurOrderReturn(PurOrder purO) {
		// TODO Auto-generated method stub
		return purOrderDao.addPurOrderReturn(purO);
	}
	
	public boolean delPurOrder(Object[] ids) {
		// TODO Auto-generated method stub
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return purOrderDao.delPurOrder(obj);
	}

	public boolean editPurOrder(PurOrder purO) {
		// TODO Auto-generated method stub
		return purOrderDao.editPurOrder(purO);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		Pages pages=null;
		try
		{
			pages=purOrderDao.exHqlPages(hql, pageNo, pageSize, values);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购订单分页查找业务层出错",ex);
		}
		return pages;
	}

	public List selSomePurOrder(String addhql) {
		// TODO Auto-generated method stub
		return purOrderDao.selSomePurOrder(addhql);
	}

	public boolean addPurOrderInfo(PurOrderInfo poi) {
		boolean flag=purOrderDao.addPurOrderInfo(poi);
		return flag;
	}

	public boolean delPurOrderInfo(String addhql) {
		// TODO Auto-generated method stub
		return purOrderDao.delPurOrderInfo(addhql);
	}

	public boolean updatePurOrderInfo(PurOrderInfo poinfo) {
		// TODO Auto-generated method stub
		return purOrderDao.updatePurOrderInfo(poinfo);
	}

	public boolean delPurOrderInfos(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return purOrderDao.delPurOrderInfo(obj);
	}
	
	/**
	 * 根据purid获取purOrderInfo表中列表
	 * @return
	 */
	public List getPurOrderInfoById(String addhql)
	{
		return purOrderDao.getPurOrderInfoById(addhql);
	}

	public List selsomePurOrderinfo(int num, int modelId) {
		// TODO Auto-generated method stub
		return purOrderDao.selsomePurOrderinfo(num, modelId);
	}

}
