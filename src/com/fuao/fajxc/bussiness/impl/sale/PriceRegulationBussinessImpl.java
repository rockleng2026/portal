package com.fuao.fajxc.bussiness.impl.sale;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.sale.PriceRegulationBussiness;
import com.fuao.fajxc.dao.sale.PriceRegulationDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Priceregulation;

public class PriceRegulationBussinessImpl implements PriceRegulationBussiness {

	private PriceRegulationDao priceRegDao;
	
	
	/**
	 * @return the priceRegDao
	 */
	public PriceRegulationDao getPriceRegDao() {
		return priceRegDao;
	}

	/**
	 * @param priceRegDao the priceRegDao to set
	 */
	public void setPriceRegDao(PriceRegulationDao priceRegDao) {
		this.priceRegDao = priceRegDao;
	}

	public boolean addRegulation(Priceregulation reg) {
		// TODO Auto-generated method stub
		return priceRegDao.addRegulation(reg);
	}

	public boolean delRegulation(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return priceRegDao.delRegulation(obj);
	}

	public boolean editRegulation(Priceregulation reg) {
		// TODO Auto-generated method stub
		return priceRegDao.editRegulation(reg);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return priceRegDao.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List someRegulation(String addhql) {
		// TODO Auto-generated method stub
		return priceRegDao.someRegulation(addhql);
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		PriceRegulationBussiness pre=(PriceRegulationBussiness) ac.getBean("priceRegBussiness");
	    List list=pre.someRegulation(" and delflag=0 and modelId=11");
	    System.out.println(list.size());
	}

	public boolean updateModel(String addhql) {
		// TODO Auto-generated method stub
		return priceRegDao.updateModel(addhql);
	}

}
