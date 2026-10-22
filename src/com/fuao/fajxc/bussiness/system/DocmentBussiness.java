package com.fuao.fajxc.bussiness.system;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.Sale_orders;

public interface DocmentBussiness {

	/**
	 *执行分页查询单据类型记录资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查询单据类型
	 */
	public List selDocmark(String addhql);
	
	/**
	 * 添加单据类型
	 * @return
	 */
	public boolean addDoc(Docmark docm);
	/**
	 * 删除单据类型
	 * @return
	 */
	public boolean delDoc(Docmark docm);
	
	/**
	 * 更新单据类型
	 */
	public boolean updateDoc(Docmark docm);
	
	public boolean updateDoc(Object obj);
	
	public boolean saveRecharge(RechargeLog rech);
	
	public List selAllKinddatas(String sql);
	
	public void updtRecharge(RechargeLog rech);
	/*******
	 * 得到集合
	 * @param hql
	 * @return
	 */
	public List exHql(String hql);

	public void update(Sale_orders so);
}
