package com.fuao.fajxc.bussiness.basic;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Users;

public interface DepotBussiness {

	/**
	 * 添加仓库信息
	 */
	
	public boolean addDepot(Depot depot);
	
	/**
	 * 添加仓库信息 返回对象
	 */
	public Depot addReturnDepot(Depot depot);
	
	/**
	 * 根据ID
	 * 查询单个对象信息
	 */
	public Object getObj( Class cs,int id);
	
	/**
	 * 修改仓库信息
	 */
	public boolean updateDepot(Depot depot);
	
	/**
	 * 删除仓库信息
	 */
	public boolean delDepot(int id);
	
	
	/**
	 * 查询全部员工信息
	 */
	public List getEmp();
	
    /**
     * 查询单个员工信息
     * 
     */
	public Employee getEmpOme(int id);
	
	/**
	 * 分页查询仓库信息
	 * @param page
	 * @return
	 */
	public Pages paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values);

	/**
	 * 用登录名查询员工ID
	 */
	public Object getUsers(String loginName);
	
	/**
	 * 根据条件查询仓库
	 */
	public List someDepot(String addhql);
}
