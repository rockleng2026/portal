/**
 * 
 */
package com.fuao.fajxc.bussiness.purchase;

import java.util.List;

import com.fuao.fajxc.vo.ReturnOrder;
import com.fuao.fajxc.vo.ReturnOrderInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-27
 */
public interface PurReturnOrderBussiness {

	/**
	 * 添加采购退货单
	 * @param order
	 * @return
	 */
	public boolean addPurOrder(ReturnOrder order);
	
	/**
	 * 添加采购退货单 返回对象
	 * @param order
	 * @return ReturnOrder对象
	 */
	public ReturnOrder addReturnPurOrder(ReturnOrder order);
	
	/**
	 * 修改采购退货单
	 * @param order
	 * @return
	 */
	public boolean editPurReturnOrder(ReturnOrder order);
	
	/**
	 * 获取列表
	 * @param andhql
	 * @return
	 */
	public List getObjectList (String andhql);
	
	/**
	 * 获取采购退货单对象
	 * @param andhql
	 * @return
	 */
	public ReturnOrder getObject(String andhql);
	
	/**
	 * 添加采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean addPurOrderInfo(ReturnOrderInfo order);
	
	/**
	 * 修改采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean editPurReturnOrderInfo(ReturnOrderInfo order);
	
	/**
	 * 删除采购退货单
	 * @param order
	 * @return
	 */
	public boolean deletePurReturnOrder(ReturnOrder order);
	
	/**
	 * 删除采购退货单详单
	 * @param order
	 * @return
	 */
	public boolean deletePurReturnOrderInfo(ReturnOrderInfo order);
}
