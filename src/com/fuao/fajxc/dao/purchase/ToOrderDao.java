package com.fuao.fajxc.dao.purchase;


import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ToOrder;

public interface ToOrderDao extends BaseDao{

	/*
	 * 到货单基本资料
	 */
	public boolean addData(ToOrder data)throws Exception;
	
	/*
	 *修改 到货单基本资料
	 */
	public boolean updateData(ToOrder data)throws Exception ;
	
	
	public ToOrder getToOrderdata(String id);
	/*
	 *特殊查询到货单基本资料
	 */
	public List<ToOrder>  exHql(String hql);
	
	/*
	 *执行分页查询到货单基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	
	/**
	 * 获得tableName对象列表
	 * @param hql
	 * @return
	 */
	public List getObjectList(String hql);
	
	public boolean updateToOrderByVerify(String addhql);
	
}
