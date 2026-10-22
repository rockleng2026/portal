package com.fuao.fajxc.bussiness.impl.customService;

import java.util.List;

import com.fuao.fajxc.bussiness.customService.ServerMonitoringBussiness;
import com.fuao.fajxc.dao.customService.ServerMonitoringDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.ServerMonitor;

public class ServerMonitoringBussinessImpl implements ServerMonitoringBussiness {
	
	private ServerMonitoringDao smdao;

	public ServerMonitoringDao getSmdao() {
		return smdao;
	}

	public void setSmdao(ServerMonitoringDao smdao) {
		this.smdao = smdao;
	}

	/**
	 * 添加服务器监控记录
	 */
	public boolean add(ServerMonitor sm) {
		try {
			smdao.update(sm);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 删除服务器监控记录
	 */
	public boolean del(ServerMonitor sm) {
		try {
			smdao.update(sm);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 分页查询服务器监控信息
	 */
	public Pages select(String hql, int pageNo, int pageSize, Object... values) {
		
		return smdao.paginationQuery(hql, pageNo, pageSize, values);
	}

	public List getlist(String sql) {
		
		return smdao.execSQL(sql);
	}

	public Employee getemp(String loginName) {
		
		return (Employee)smdao.getObj(loginName);
	}

	public Object getpr(Class cls,String id) {
		

			try {
				return smdao.select(cls, Integer.parseInt(id));
			} catch (NumberFormatException e) {
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
	}

}
