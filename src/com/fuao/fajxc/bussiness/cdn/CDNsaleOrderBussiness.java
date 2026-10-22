package com.fuao.fajxc.bussiness.cdn;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CDNsaleOrder;



public interface CDNsaleOrderBussiness {
	/**
	 * 添加一个CDN订单/域名
	 * **/
	public CDNsaleOrder addCDNsaleOrder(CDNsaleOrder cdnsaleorder);
	
	/**
	 * 软删除一个CDN订单、域名
	 * **/
	public CDNsaleOrder delruanCDNsaleOrder(CDNsaleOrder cdnsaleorder);
	/**
	 * 硬删除一个CDN订单、域名
	 * **/
	public boolean delyingCDNsaleOrder(CDNsaleOrder cdnsaleorder);
	
	/**
	 * 修改一个CDN订单、域名
	 * **/
	public CDNsaleOrder updateCDNsaleOrder(CDNsaleOrder cdnsaleorder);
	
	/**
	 * 查询一个CDN订单、域名
	 * **/
	public CDNsaleOrder findCDNsaleOrderById(Integer id);
	
	/**
	 * 查询批量CDN订单、域名
	 * **/
	public List<CDNsaleOrder> findCDNsaleOrderList(String hql);
	
	/**
	 * 分页
	 * **/
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	
}
