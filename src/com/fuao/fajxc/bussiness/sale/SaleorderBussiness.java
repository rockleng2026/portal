package com.fuao.fajxc.bussiness.sale;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RenewLog;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.SaledFlow;

/**
 * 销售订单业务逻辑层接口
 * @author Administrator
 *
 */
public interface SaleorderBussiness {
	/**
	 * 分页查询订单列表
	 * @param hql
	 * @param pageNo
	 * @param pagesize
	 * @param value
	 * @return
	 */
	public Pages select(String hql,int pageNo,int pagesize,Object... value);
	/**
	 * 添加活修改订单
	 * @param so
	 * @return
	 */
	public boolean addorup(SaleOrder so);
	
	/**
	 * 添加或者修改订单
	 * @return SaleOeder
	 */
	public SaleOrder addorupdate(SaleOrder so);
	
	/**
	 * 用ID查询对象
	 * @param id
	 * @return
	 */
	public Object getobj(String id);
	
	/**
	 * 标记删除订单对象
	 */
	public boolean del(SaleOrder so);
	
	/**
	 * 查询单个对象
	 */
	public Object getObj(Class cls,String id);
	
	/**
	 * 执行Hql语句返回列表
	 */
	public List getList(String hql);
	
	/**
	 * 订单续费
	 */
	public boolean addrenew(RenewLog rl);
	/**
	 * 
	 */
	public void updateSaleorder(String  slaeOrderNo);
	
	public String exSql(String sql);
	/**
	 * 根据客户ID查询客户单据
	 */
	public List exbySql(String sql);
	public List getOrderList(String tableName,String hql);
	
    public List getOrdersDate(String sql);
    
    public void saveFlowInfo(SaledFlow sfd);
    
    public void updtFlowInfo(SaledFlow sfd);
	public void update(String sql);
}
