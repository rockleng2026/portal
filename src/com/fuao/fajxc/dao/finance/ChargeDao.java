package com.fuao.fajxc.dao.finance;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.vo.Charge;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;

public interface ChargeDao extends BaseDao {
	
	/**
	 * 查询所有收款记录
	 * @return
	 */
	public List<Charge> getCharge();
	
	/**
	 * 添加收款记录
	 */
	
	public boolean addCharge(Charge charge);
	
	/**
	 * 用收款记录ID查询收款记录信息
	 */
	
	public Charge getCharge(String id);
	
	/**
	 * 修改收款记录信息
	 */
	public boolean updaCharge(Charge charge);
	
	/**
	 * 删除收款记录信息
	 */
	public boolean delCharge(String id);
	
	/**
	 * 分页查询收款记录信息
	 */
	public List getProductByPage(Page page ,String hql); 

	/**
	 * 查询收款记录信息总条数
	 */
	public int getProductCount(); //返回数据的总数
	
	/**
	 * 查询员工信息
	 * 
	 */
	public List getEmp();
	
	/**
	 * 查询订单信息
	 */
	public List getSaleOrder();
	
	/**
	 * 查询单张订单
	 */
	public SaleOrder getSaleOrderOne(int id);

	public Sale_orders getSaleOrderOnes(int id);

	public boolean updateSg(String hql);
	
	public List find(String hql);
	
}
