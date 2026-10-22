package com.fuao.fajxc.bussiness.finance;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PaymentLog;

public interface PayBussiness {

	/**
	 *执行分页查询客户基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查询采购单
	 */
	public List selPurOrder(String addhql);
	
	/**
	 * 添加付款单
	 * @return
	 */
	public boolean add(PaymentLog plog);
	
	/**
	 * 添加付款单
	 * 返回对象
	 */
	public PaymentLog addReturnPaymentLog(PaymentLog plog);
	
	/**
	 *删除付款单 
	 */
	public boolean delpay(Object[] ids);
	/**
	 * 根据条件查找付款单
	 */
	public List selPay(String addhql);
	/**
	 * 更新付款单
	 */
	public boolean updatePay(PaymentLog pml);
	
	public Object getobjid(Class clazz,Integer id);
	
	public int updateVerif(String sql);
}
