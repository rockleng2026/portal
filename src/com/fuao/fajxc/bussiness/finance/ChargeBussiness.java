package com.fuao.fajxc.bussiness.finance;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.vo.Charge;
import com.fuao.fajxc.vo.CurrencyProcess;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;

public interface ChargeBussiness {

	/**
	 * 查询所有的收款单信息
	 * @return
	 */
	public List<Charge> getCharge() ;
	
	/**
	 * 添加收款单信息
	 */
	
	public boolean addCharge(Charge charge);
	
	/**
	 * 添加收款单信息
	 * 返回对象
	 */
	public Charge addReturnCharge(Charge charge);
	
	/**
	 * 查询单个收款单信息
	 */
	public Charge getCharge(String id);
	
	/**
	 * 修改收款单信息
	 */
	public boolean updateCharge(Charge charge);
	
	/**
	 * 删除收款单信息
	 */
	public boolean delCharge(String id);
	
	/**
	 * 分页查询
	 * @param page
	 * @return
	 */
	public Pages paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values);
	/**
	 * 得到收款单信息的总条数
	 */
	public int getCount();

	/**
	 * 查询员工信息
	 */
	public List getEmp();
	
	/**
	 *  查询订单信息
	 */
	public List getSaleOrder();
	
	/**
	 * 查询单个订单
	 */
	public SaleOrder getSaleOrderOne(int id);
	
	/**
	 * 根据登录名称查找登录用户信息
	 */
    public Object getObj(String loginName);
    
    /*
	 *查询部门
	 */
	public List getdepart(Integer id);
	/*
	 * 修改状态
	 */
	public int updateisAu(String sql);
	
	public Sale_orders getSaleOrderOnes(int id);
	
	public boolean updateSg(String hql);
	
	public List find(String hql);

	public void save(CurrencyProcess cp);
}
