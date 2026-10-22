package com.fuao.fajxc.dao.server;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AssemblyServer;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;


public interface AssemblyServerDao extends BaseDao {

	/**
	 * 分页组装服务器记录
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加组装服务器记录
	 * @return
	 */
	public boolean addassemblyServer(AssemblyServer assS);
	
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
	 * 改变产品配件parentId
	 * @return
	 */
	public boolean updateProduct(Object[] ids,int parentId);
	
	/**
	 * 将服务器入库
	 * @return
	 */
	public boolean addServer(Product pro);
	
	/**
	 * 修改服务器信息
	 * @return
	 */
	public boolean editServer(Product pro);
	
	/**
	 * 根据型号查找属性
	 */
	public Property selPro(int modelId);
	
	/**
	 * 将指定服务器的配件parentId改为0
	 */
	public boolean updateparentId(int parentId);
	
	/**
	 * 根据条件查找产品
	 * @return
	 */
	public List selProduct(String addhql);
	
}
