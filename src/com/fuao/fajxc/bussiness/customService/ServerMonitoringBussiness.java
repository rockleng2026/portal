package com.fuao.fajxc.bussiness.customService;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.ServerMonitor;

/**
 * 服务器监控BIZ层
 * @author 14012
 *
 */
public interface ServerMonitoringBussiness {
	 
	/**
	 * 添加记录
	 */
	public boolean add(ServerMonitor sm);
	
	/**
	 * 查询记录
	 */
	
	public Pages select(final String hql, final int pageNo,
			final int pageSize, final Object... values);
	/**
	 * 删除记录
	 */
	public boolean del(ServerMonitor sm);
	
	/**
	 * 查询服务器列表
	 */
	
	public List getlist(String sql);
	
	/**
	 * 根据登录名称查询用户
	 */
	public Employee getemp(String loginName);
	
	/**
	 *  查询产品
	 */
	public Object getpr(Class cls,String id);

}
