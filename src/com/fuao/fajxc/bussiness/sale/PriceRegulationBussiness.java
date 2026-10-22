package com.fuao.fajxc.bussiness.sale;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Priceregulation;

public interface PriceRegulationBussiness {

	/**
	 *执行分页查询价格调整记录
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加价格调整记录
	 */
	public boolean addRegulation(Priceregulation reg);
	
	/**
	 * 删除价格调整记录
	 */
	public boolean delRegulation(Object[] ids);
	
	/**
	 * 修改价格调整记录
	 */
	public boolean editRegulation(Priceregulation reg);
	
	/**
	 * 根据条件查找相应的价格调整记录
	 */
	public List someRegulation(String addhql);
	
	/**
	 * 根据型号将delflag改为1
	 */
	public boolean updateModel(String addhql);
}
