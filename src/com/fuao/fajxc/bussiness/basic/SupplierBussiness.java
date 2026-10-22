package com.fuao.fajxc.bussiness.basic;
import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Supplier;

public interface SupplierBussiness {
	
	/**
	 * 获取所有供应商信息
	 * @return
	 */
	public List<Supplier> getAllSupplier();
	
	/**
	 * 添加供应商信息
	 */
	
	public boolean addSuplier(Supplier supplier);
	
	/**
	 * 添加供应商信息
	 * @return Supplier供应商对象
	 */
	public Supplier addReturnSuplier(Supplier supplier);
	
	/**
	 * 查询单个供应商信息
	 */
	public Supplier getSupplier(int id);
	
	/**
	 * 修改供应商信息
	 */
	public boolean updateSupplier(Supplier supplier);
	
	/**
	 * 分页查询
	 * @param page
	 * @return
	 */
	public Pages paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values);


	/**
	 * 获得供应商的集合
	 */
	public List selSupplier(String addhql);

}
