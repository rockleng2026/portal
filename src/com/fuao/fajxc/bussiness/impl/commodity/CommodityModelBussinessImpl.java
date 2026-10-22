package com.fuao.fajxc.bussiness.impl.commodity;

import java.util.List;

import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityModelBussiness;
import com.fuao.fajxc.dao.commodity.CommodityModelDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Model;

public class CommodityModelBussinessImpl implements CommodityModelBussiness {

	/**
	 * 注入商品型号Dao
	 */
	CommodityModelDao cmDao;
	
	public CommodityModelDao getCmDao() {
		return cmDao;
	}

	public void setCmDao(CommodityModelDao cmDao) {
		this.cmDao = cmDao;
	}

	public List select(String id) {
		String hql="from Model m where typeID="+id;
		return cmDao.execHQL(hql);
	}

	/**
	 * 根据商品型号ID查询商品型号
	 */
	public Model getModel(String id) {
		if(id == null || id.equals(""))
		{
			return null;
		}
		try {
			return (Model)cmDao.select(Model.class, Integer.parseInt(id));
		} catch (Exception e) {
			
			e.printStackTrace();
			return null;
		}
	}

	public int selsomeModel(int modelId,int depId) {
		String hql="select count(p.id) from Product p where p.property.model.model="+modelId+" and p.depot.id="+depId+"";
		int count=Integer.parseInt(cmDao.execHQL(hql).get(0).toString());
		return count;
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		CommodityModelBussiness emd=(CommodityModelBussiness) ac.getBean("commodityModelBussinessImpl");
        System.out.print("count"+emd.selsomeModel(14, 22));
	}

	/**
	 * 查询机柜的型号列表
	 * HQL语句中的commodityTpye是机柜在commodityTpye表里面的ID
	 */
	public List getCabinetList() {

			String hql = "from Model where commodityTpye = 62 and delflag = 0 ";

		return cmDao.execHQL(hql);
	}

	public Pages getList(String hql, int pageNo, int pageSize, Object... value) {
		
		return cmDao.paginationQuery(hql, pageNo, pageSize, value);
	}

}
