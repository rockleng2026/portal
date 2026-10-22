package com.fuao.fajxc.bussiness.impl.purchase;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.bussiness.purchase.RequisitioningBusssiness;
import com.fuao.fajxc.dao.purchase.RequisitioningDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ApplyBuy;
import com.fuao.fajxc.vo.ApplyBuyinfo;

public class RequisitioningBusssinessImpl implements RequisitioningBusssiness{
	private RequisitioningDao requisitioningDao;
	
	public RequisitioningDao getRequisitioningDao() {
		return requisitioningDao;
	}

	public void setRequisitioningDao(RequisitioningDao requisitioningDao) {
		this.requisitioningDao = requisitioningDao;
	}

	private Logger logger=Logger.getLogger(RequisitioningBusssinessImpl.class);
	public int adda(ApplyBuy applyBuy) {

		return requisitioningDao.adda(applyBuy);
	}

	/**
	 * 查询单个对象
	 */
	public Object getObj(Class cls,String field, String id) {

		String hql = "from "+cls.getName()+" o where o."+field+"="+id;
		List list=requisitioningDao.execHQL(hql);
		if(list.size()>0)
		{
			return list.get(0);
		}

		return null;
	}

	/**
	 * 插入请购单详细信息
	 */
	public boolean addApplyBuyInfo(ApplyBuyinfo applyBuyinfo) {
		try{
		requisitioningDao.add(applyBuyinfo);
		return true;
		}catch (Exception e) {
			logger.error(e);
			
		}
		return false;
	}

	/**
	 * 查询List 对象
	 * @param hql
	 * @return
	 */
	public List getObjList(String hql) {
		List list=requisitioningDao.execHQL(hql);
		if(list.size()>0)
		{
			return list;
		}
		
		return null;
	}
	
	public static void main(String[] args)
	{
		System.out.println(1111);
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		RequisitioningBusssiness pb=(RequisitioningBusssinessImpl)ac.getBean("requisitioningBusssiness");
		List list=pb.getObjList("from ApplyBuy where id in (80,85)");
		System.out.println("size:"+list.size());
		
	}


	/**
	 * 分页查询
	 * @param hql 查询语句
	 * @param pageNo 当前页
	 * @param pageSize 每页显示数量
	 */
	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		
		return requisitioningDao.paginationQuery(hql, pageNo, pageSize, values);
	}

	public List getappluInfo(String id) {
		String hql = "from ApplyBuyinfo where del=0 and pplyBuyNo = "+id;
		
		return requisitioningDao.execHQL(hql);
	}

	/**
	 * 修改请购单
	 */
	public boolean upApplyBuy(ApplyBuy applyBuy) {
		try{
		requisitioningDao.update(applyBuy);
		return true;
		}catch (Exception e) {
			logger.error(e);
		return false;
		}
	}
 
	/**
	 * 修改请购单详细信息
	 */
	public boolean upApplyBuyInfo(ApplyBuyinfo applyBuyinfo) {
		try{
			requisitioningDao.update(applyBuyinfo);
			return true;
			}catch (Exception e) {
				logger.error(e);
			return false;
			}
	}

	public ApplyBuy getApplyBuy(int id) {
		
		try {
			return (ApplyBuy)requisitioningDao.select(ApplyBuy.class, id);
		} catch (Exception e) {
			logger.error(e);
		return null;
		
		}
	}

	public int adda(ApplyBuyinfo applyBuy) {
		return requisitioningDao.adda(applyBuy);
	}
	


}
