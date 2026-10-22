package com.fuao.fajxc.dao.server;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.UpServer;


public interface UpserverDao extends BaseDao {

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
	 * 执行HQl
	 */
	public boolean executeHql(String hql);
	/**
	 * 查询IP
	 */
	
    public List findByIPs(String hql);
    public void updIPs(IPConfiguration ipc);
    
    public List getServersByDepotid(int depotid);
    
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
}
