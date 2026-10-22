package com.fuao.fajxc.dao.cdn;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.CDNsaleOrder;

public interface CDNsaleOrderDao extends BaseDao {
	/**
	 * 查询一个具体单据
	 * */
	public CDNsaleOrder findCDNsalOrderById(Integer id);
	
}
