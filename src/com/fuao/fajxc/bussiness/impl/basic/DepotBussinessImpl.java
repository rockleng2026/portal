package com.fuao.fajxc.bussiness.impl.basic;

import java.util.ArrayList;
import java.util.List;

import com.fuao.fajxc.bussiness.basic.DepotBussiness;
import com.fuao.fajxc.dao.basic.DepotDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.PageUtil;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Supplier;
import com.fuao.fajxc.vo.Users;

public class DepotBussinessImpl implements DepotBussiness {

	/**
	 * 注入DepotDao
	 */
	DepotDao depotDao;
	
	public DepotDao getDepotDao() {
		return depotDao;
	}

	public void setDepotDao(DepotDao depotDao) {
		this.depotDao = depotDao;
	}
	
	/**
	 * 添加仓库信息
	 */
	public boolean addDepot(Depot depot) {
		try {
			depotDao.add(depot);
			return true;
		} catch (Exception e) {
			return false;
		}
		 
	}
	/**
	 * 添加仓库信息 返回对象
	 */
	public Depot addReturnDepot(Depot depot) {
		Depot depot2 = null;
		try {
			depot2 = (Depot) depotDao.addReturnObject(depot);
		} catch (Exception e) {
			return null;
		}
		return depot2;
	}
	
	/**
	 * 
	 * 查询仓库信息
	 * @param id
	 * @return
	 */
	public Object getObj(Class cs,int id) {
		
		try {
			return depotDao.select(cs, id);
		} catch (Exception e) {
		
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 更改仓库信息
	 */
	public boolean updateDepot(Depot depot) {
		try{
		depotDao.update(depot);
		return true;
		}catch (Exception e) {
			return false;
		}
	}

	/**
	 * 删除仓库信息
	 */
	public boolean delDepot(int id) {
		Depot depot=(Depot)this.getObj(Depot.class,id);
		depot.setDel("1");
		return this.updateDepot(depot);
	}
	
	/**
	 * 查询单个员工信息
	 */
	public Employee getEmpOme(int id)
	{
		try {
			return (Employee)depotDao.select(Employee.class, id);
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * 查询所有员工信息
	 */
	
	public List getEmp() {
		String hql="from Employee";
		return this.depotDao.execHQL(hql);
	}

	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		
		return depotDao.paginationQuery(hql, pageNo, pageSize, values);
	}

	/**
	 * 根据登录名查找员工ID
	 */
	public Object getUsers(String loginName) {
		return depotDao.getObj(loginName);
	}

	public List someDepot(String addhql) {
		List list=new ArrayList();
		String hql="from Depot where del=0"+addhql;
		try
		{
			list=depotDao.execHQL(hql);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}


}
