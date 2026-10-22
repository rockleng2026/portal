package com.fuao.fajxc.bussiness.impl.basic;

import java.util.List;

import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.dao.basic.SupplierDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.PageUtil;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.vo.Supplier;
/**
 * 供应商信息biz实现
 * @author 14012
 *
 */
public class SupplierBussinessImpl implements SupplierBussiness {

	//供应商信息DAO注入
	private SupplierDao supplierDao;
	public SupplierDao getSupplierDao() {
		return supplierDao;
	}
	public void setSupplierDao(SupplierDao supplierDao) {
		this.supplierDao = supplierDao;
	}
	
	/**
	 * 获取所有供应商信息
	 * @return
	 */
	public List<Supplier> getAllSupplier()
	{
		List<Supplier> list = supplierDao.execHQL(" from Supplier s where s.del = 0");
		if(list.size()>0)
		{
			return list;
		}
		return null;
	}
	
	/**
	 * 添加供应商信息
	 */
	public boolean addSuplier(Supplier supplier) {
		try{
		 supplierDao.add(supplier);
		 return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 添加供应商信息
	 * @return Supplier供应商对象
	 */
	public Supplier addReturnSuplier(Supplier supplier) {
		try{
			Supplier supplier2 = (Supplier) supplierDao.addReturnObject(supplier);
		 	return supplier2;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	/**
	 * 查询供应商信息
	 * @param id
	 * @return
	 */
	public Supplier getSupplier(int id) {
		
		try {
			return (Supplier)supplierDao.select(Supplier.class,id);
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * 更改供应商信息
	 */
	public boolean updateSupplier(Supplier supplier) {
		
		try{
		supplierDao.update(supplier);
		return true;
		}catch (Exception e) {
			return false;
		}
	}
	/**
	 * 分页查询
	 */
	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		System.out.println(11111);
		return supplierDao.paginationQuery(hql, pageNo, pageSize, values);
	}
	
	/**
	 * 获得供应商集合
	 */
	public List selSupplier(String addhql) {
	    String hql="from Supplier where del=0"+addhql;
	    List list= supplierDao.execHQL(hql);
		return list;
	}
	
	




}
