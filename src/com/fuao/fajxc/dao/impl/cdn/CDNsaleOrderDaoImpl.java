package com.fuao.fajxc.dao.impl.cdn;

import java.util.List;

import javax.jms.Session;

import com.fuao.fajxc.dao.cdn.CDNsaleOrderDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.CDNsaleOrder;

public class CDNsaleOrderDaoImpl extends BaseDaoImpl implements CDNsaleOrderDao {

	public CDNsaleOrder findCDNsalOrderById(Integer id) {
		try {
			return (CDNsaleOrder) super.select(CDNsaleOrder.class,id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


	
}
