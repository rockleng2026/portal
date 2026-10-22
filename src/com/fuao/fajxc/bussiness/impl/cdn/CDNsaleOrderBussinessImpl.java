package com.fuao.fajxc.bussiness.impl.cdn;

import java.util.List;

import com.fuao.fajxc.bussiness.cdn.CDNsaleOrderBussiness;
import com.fuao.fajxc.dao.cdn.CDNsaleOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CDNsaleOrder;



public class CDNsaleOrderBussinessImpl implements CDNsaleOrderBussiness {
	private CDNsaleOrderDao cdnsaleorderdao;

	public CDNsaleOrderDao getCdnsaleorderdao() {
		return cdnsaleorderdao;
	}

	public void setCdnsaleorderdao(CDNsaleOrderDao cdnsaleorderdao) {
		this.cdnsaleorderdao = cdnsaleorderdao;
	}

	/**
	 * 添加一个CDN订单/域名
	 * **/
	public CDNsaleOrder addCDNsaleOrder(CDNsaleOrder cdnsaleorder) {
		cdnsaleorder=(CDNsaleOrder)cdnsaleorderdao.addReturnObject(cdnsaleorder);
		return cdnsaleorder;
	}
	/**
	 * 软删除一个CDN订单、域名
	 * **/
	public CDNsaleOrder delruanCDNsaleOrder(CDNsaleOrder cdnsaleorder) {
		cdnsaleorder.setDelFlag("1");
		cdnsaleorder=(CDNsaleOrder)cdnsaleorderdao.addReturnObject(cdnsaleorder);
		return cdnsaleorder;
	}
	/**
	 * 硬删除一个CDN订单、域名
	 * **/
	public boolean delyingCDNsaleOrder(CDNsaleOrder cdnsaleorder) {
		boolean flag=false;
		try {
			cdnsaleorderdao.delete(cdnsaleorder);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
			flag=false;
		}
		return flag;
	}
	/**
	 * 查询一个CDN订单、域名
	 * **/
	public CDNsaleOrder findCDNsaleOrderById(Integer id) {
		CDNsaleOrder cdnsaleorder=null;
		cdnsaleorder=cdnsaleorderdao.findCDNsalOrderById(id);
		return cdnsaleorder;
	}
	/**
	 * 查询批量CDN订单、域名
	 * **/
	public List<CDNsaleOrder> findCDNsaleOrderList(String hql) {
		List<CDNsaleOrder> returnlist=null;
		try{
			returnlist=cdnsaleorderdao.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return returnlist;
	}
	/**
	 * 修改一个CDN订单、域名
	 * **/
	public CDNsaleOrder updateCDNsaleOrder(CDNsaleOrder cdnsaleorder) {
		cdnsaleorder=(CDNsaleOrder)cdnsaleorderdao.addReturnObject(cdnsaleorder);
		return cdnsaleorder;
	}

	/**
	 * 分页
	 * **/
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages page=null;
		try {
			 page=cdnsaleorderdao.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}


	
	


}
