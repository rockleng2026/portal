/**
 * 
 */
package com.fuao.fajxc.bussiness.impl.purchase;

import java.util.List;

import com.fuao.fajxc.bussiness.purchase.PurReturnOrderBussiness;
import com.fuao.fajxc.dao.purchase.PurReturnOrderDao;
import com.fuao.fajxc.vo.ReturnOrder;
import com.fuao.fajxc.vo.ReturnOrderInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-27
 */
public class PurReturnOrderBussinessImpl implements PurReturnOrderBussiness {

	private PurReturnOrderDao purReturnOrderDao;

	/**
	 * 添加采购退货单
	 * @param order
	 * @return
	 */
	public boolean addPurOrder(ReturnOrder order)
	{
		return purReturnOrderDao.addPurOrder(order);
	}
	
	/**
	 * 添加采购退货单 返回对象
	 * @param order
	 * @return ReturnOrder对象
	 */
	public ReturnOrder addReturnPurOrder(ReturnOrder order)
	{
		ReturnOrder returnOrder = null;
		try {
			returnOrder = (ReturnOrder) purReturnOrderDao.addReturnObject(order);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return returnOrder;
	}
	
	/**
	 * 修改采购退货单
	 * @param order
	 * @return
	 */
	public boolean editPurReturnOrder(ReturnOrder order)
	{
		return purReturnOrderDao.editPurReturnOrder(order);
	}
	
	/**
	 * 获取列表
	 * @param andhql
	 * @return
	 */
	public List getObjectList (String andhql)
	{
		String hql = "from ReturnOrder where delflag = 0 "+andhql;
		System.out.println("hql : "+hql);
		return purReturnOrderDao.getObjectList(hql);
	}
	
	/**
	 * 获取采购退货单对象
	 * @param andhql
	 * @return
	 */
	public ReturnOrder getObject(String andhql)
	{
		String hql = "from ReturnOrder where delflag = 0 "+andhql;
		System.out.println("hql : "+hql);
		return purReturnOrderDao.getObject(hql);
	}
	
	/**
	 * 添加采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean addPurOrderInfo(ReturnOrderInfo order)
	{
		return purReturnOrderDao.addPurOrderInfo(order);
	}
	/**
	 * 修改采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean editPurReturnOrderInfo(ReturnOrderInfo order)
	{
		return purReturnOrderDao.editPurReturnOrderInfo(order);
	}
	
	/**
	 * 删除采购退货单
	 * @param order
	 * @return
	 */
	public boolean deletePurReturnOrder(ReturnOrder order)
	{
		return purReturnOrderDao.deletePurReturnOrder(order);
	}
	
	/**
	 * 删除采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean deletePurReturnOrderInfo(ReturnOrderInfo order)
	{
		return purReturnOrderDao.deletePurReturnOrderInfo(order);
	}
	
	public void setPurReturnOrderDao(PurReturnOrderDao purReturnOrderDao) {
		this.purReturnOrderDao = purReturnOrderDao;
	}
}
