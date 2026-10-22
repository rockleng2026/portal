package com.fuao.fajxc.bussiness.server;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.UpServer;

public interface UpserverBussiness {

	/**
	 * 分页上架单
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加上架单
	 * @return
	 */
	public boolean addupServer(UpServer us);
	
	/**
	 * 增加上架单
	 * 
	 * 最后发现----增加上架单、修改上架单、删除上架单时，不需要相互绑定，只要设置使用状态
	 * 只有在----执行上架时，才进行相互绑定，
	 * */
	public UpServer addReturnUpServer(UpServer us);
	
	/**
	 * 删除上架单
	 * @return
	 */
	public boolean delupServer(Object[] ids);
	
	/**
	 * 修改上架单
	 * @return 
	 */
	public boolean editupServer(UpServer us);
	
	/**
	 * 根据条件查找上架单
	 * @return 
	 */
	public List someupServer(String addhql);
	
	/**
	 * 执行上架操作
	 * @return
	 */
	public boolean executeUpserver(String proId,String upId);
	/**
	 * 执行hql语句
	 * @param hql1
	 */
	public boolean executeHql(String hql);
	
    public List findByIPs(String hql);
    public void updIPs(IPConfiguration ipc);
	
    /**
     * 根据仓库id查询该仓库下的服务器 
     * @author 袁天龙
     * @param depotid
     * @return
     */
    public List getServersByDepotid(int depotid);
    
    /**
     * 根据机房id查询机柜信息
     * @author 袁天龙
     * 2012-12-12
     * @param cabinetid
     * @return
     */
    public List getCabinetByElecthouse(int cabinetid);
    
    public List getCustomers();
    
    public List getElectHouse();
    
    public List getSaleorderBySaleorderId(int saleorderId);
    
    public Object getCustomerByPK(Class clazz,int customerid);
    
    public void addUpserver(Object obj);
    
    public List getAll(String hql);
    
    public Object getObjectById(Class clazz,Integer id);
    
    public List getUpserverByServerId(int serverid);
    
    /**
     * 根据上架单号查询其对象
     */
    public List getUpserverByUpNo(String upNo);
    
    public void updateObj(Object obj);
    
    public boolean updObject(Object obj);

	public List exeHql(String prohql2);
}
