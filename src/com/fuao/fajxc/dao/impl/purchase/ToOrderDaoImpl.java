package com.fuao.fajxc.dao.impl.purchase;
import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.purchase.ToOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ToOrder;

public class ToOrderDaoImpl extends BaseDaoImpl implements ToOrderDao{

	public boolean addData(ToOrder data) throws Exception {
		super.add(data);
		return true;
	}

	public List<ToOrder> exHql(String hql) {
		List<ToOrder> datas=null;
		try {
		datas=super.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public ToOrder getToOrderdata(String id) {
		try {
			return (ToOrder) super.select(ToOrder.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(ToOrder data)throws Exception  {
			super.update(data);
			return true;
	}
	
	/**
	 * 获得tableName对象列表
	 * @param hql
	 * @return
	 */
	public List getObjectList(String hql)
	{
		List list =	super.getSession().createQuery(hql).list();
		if(list.size()>0)
		{
			return list;
		}
		return null;
	}
	
	
	public boolean updateToOrderByVerify(String addhql){
		boolean flag=false;
		try
		{
			String hql="update from ToOrder where 1=1 "+addhql;
			Query query=this.getSession().createQuery(hql);
			int i=query.executeUpdate();
			if(i>0){
				flag=true;
			}
		}
		catch(Exception ex)
		{
			logger.error("删除入库单详细出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}
	
}
