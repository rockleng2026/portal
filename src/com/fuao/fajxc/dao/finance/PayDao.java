package com.fuao.fajxc.dao.finance;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PaymentLog;

public interface PayDao extends BaseDao {

	/**
	 *执行分页查询付款记录资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查询采购单
	 */
	public List selPurOrder(String hql);
	
	/**
	 * 添加付款单
	 * @return
	 */
	public boolean add(PaymentLog plog);
	/**
	 * 删除付款单
	 * @return
	 */
	public boolean delpay(Object[] ids);
	/**
	 * 根据条件查找付款单
	 */
	public List selPay(String hql);
	/**
	 * 更新付款单
	 */
	public boolean updatePay(PaymentLog pml);
	
	/*
	 * 根据主键的到一个实体
	 */
	public Object getobjid(Class clazz,Integer id);
	/*
	 * sql修改
	 */
}
