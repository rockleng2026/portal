package com.fuao.fajxc.bussiness.impl.commodity;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.commodity.CommodityBussiness;
import com.fuao.fajxc.dao.commodity.CommodityDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Property;

    
public class CommodityBusssinessImpl implements CommodityBussiness {

	private static Logger logger = Logger.getLogger(CommodityBusssinessImpl.class);
	  private CommodityDao commodityDao;   //注入DAO
	  
	public CommodityDao getCommodityDao() {
		return commodityDao;
	}

	public void setCommodityDao(CommodityDao commodityDao) {
		this.commodityDao = commodityDao;
	}

	/**
	 * 添加商品表字段
	 */
	public boolean addField(Field field) {
		try{
		commodityDao.add(field);
		return true;
		}catch (Exception e) {
			logger.error(e);
			return false;
		}
		
	}

	/**
	 * 添加商品字段属性
	 */
	public boolean addProperty(Property property) {
		try {
			commodityDao.addReturnObject(property);
			return true;
		} catch (Exception e) {
			logger.error(e);
			return false;
			
		}
		
	}
	
	/**
	 * 查询商品信息
	 * 
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values){
		Pages pages=null;
		try {
			pages=commodityDao.paginationQuery(hql, pageNo, pageSize, values);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pages;
	}

	/**
	 * 根据id查询Field对象
	 */
	public Field getField( int id) {
		try {
			return (Field)commodityDao.select(Field.class, id);
		} catch (Exception e) {
			
			e.printStackTrace();
			return null;
		}
	}


	/**
	 * 添加或修改商品类型
	 * 并返回修改后的实体
	 */
	public Model getModel(Model m) {
		commodityDao.getObj(m);
		return (Model)commodityDao.getObj(m);
	}
	
	/**
	 * 根据条件查找所有商品存放在List中
	 * @return
	 */
	public List someCommodity(String addhql){
		List list=new ArrayList();
		String hql="from Product where delflag=0"+addhql;
		try
		{
			list=commodityDao.execHQL(hql);
		}
		catch(Exception ex)
		{
			logger.error("根据条件查找商品出错",ex);
			ex.printStackTrace();
		}
		return list;
	}
	
	

	public Property getProperty(int id) {
		try {
			return (Property)commodityDao.select(Property.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean del(Property p) {
		try {
			commodityDao.update(p);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return false;
	}

	public Property getProperty(String id) {
		String hql = "from Property where modelId = "+id;
		List list = commodityDao.execHQL(hql);
		if(list != null && list.size()>0)
		{
			return (Property)list.get(0);
		}
		return null;
	}

}
