package com.fuao.fajxc.bussiness.server;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AssemblyServer;
import com.fuao.fajxc.vo.Product;

public interface AssemblyServerBussiness {

	/**
	 * 分页组装服务器记录
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	
	
	/**
	 * 删除组装服务器记录
	 * @return
	 */
	public boolean delassemblyServer(Object[] ids);
	
	/**
	 * 修改组装服务器记录
	 * @return 
	 */
	public boolean editassemblyServer(AssemblyServer assS);
	
	/**
	 * 根据条件查找组装服务器记录
	 * @return 
	 */
	public List someassemblyServer(String addhql);
	
	
	
	/**
	 * 添加组装服务器控制
	 * @param pro
	 * @param assemb
	 * @param no
	 * @return
	 */
	public boolean addServerControl(AssemblyServer assemb,String no);
	
	
	/**
	 * 修改组装服务器控制
	 * @param pro
	 * @param assemb
	 * @param no
	 * @return
	 */
	public boolean editServerControl(AssemblyServer assemb);
}
