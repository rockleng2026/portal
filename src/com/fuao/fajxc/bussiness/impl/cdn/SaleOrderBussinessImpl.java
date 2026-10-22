package com.fuao.fajxc.bussiness.impl.cdn;


import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.cdn.SaleOrderBussiness;
import com.fuao.fajxc.dao.cdn.SaleOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Ordertype;
import com.fuao.fajxc.vo.SaleOrder;

public class SaleOrderBussinessImpl implements SaleOrderBussiness {
	private static Logger logger = Logger.getLogger(SaleOrder.class);
	private SaleOrderDao saleorderdao;

	
	public SaleOrderDao getsaleorderdao() {
		return saleorderdao;
	}
	public void setsaleorderdao(SaleOrderDao saleorderdao) {
		this.saleorderdao = saleorderdao;
	}

	/**
	 * 添加
	 */
	public Object addObject(Object obj) {
		try {
			return saleorderdao.addReturnObject(obj);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 硬删除
	 */
	public boolean delObject(Object obj) {
		try {
			saleorderdao.delete(obj);
			return true;
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 硬删除
	 */
	public boolean del(Class c,String id){
		try {
			saleorderdao.del(c,id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 更新对象
	 * ***/
	public Object updateObject(Object obj) {
		obj=saleorderdao.updateObject(obj);
		return obj;
	}
	
	/**
	 * 根据hql语句，查找列表
	 * **/
	public List findObjectListByHQL(String hql) {
		try {
			return saleorderdao.execHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改更新，hql语句
	 * **/
	public int updataByHQL(String hql) {
		try {
			return saleorderdao.updataObjectByHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	 * 根据实体类名，id号    查找对象
	 * **/
	public Object findObjectById(Class c, String id) {
		try {
				return saleorderdao.select(c, Integer.parseInt(id));
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 执行分页查询
	 * **/
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values){
		Pages page = null;
		try {
			 page = saleorderdao.paginationQuery(hql, pageNo, pageSize, values);
			 return page;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 软删除
	 */
	public Ordertype delete(String id){
		Ordertype ordertype = null;
		ordertype = (Ordertype) this.findObjectById(Ordertype.class, id);
		ordertype.setDelflag(1);
		
		ordertype = (Ordertype) this.updateObject(ordertype);
		
		return ordertype;
	}
}