package com.fuao.fajxc.bussiness.impl.commodity;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.bussiness.commodity.CommodityTypeBussiness;
import com.fuao.fajxc.dao.commodity.CommodityTypeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Users;
/**
 * 商品类型模块的BIZ实现类
 * @author 14012
 *
 */
public class CommodityTypeBussinessImpl implements CommodityTypeBussiness {

	/**注入CommodityTypeDao接口*/
	CommodityTypeDao ctdao;
	public CommodityTypeDao getCtdao() {
		return ctdao;
	}
	public void setCtdao(CommodityTypeDao ctdao) {
		this.ctdao = ctdao;
	}
	
	/**
	 * 查询所有商品类型
	 */
	public List getCommoditTypes() {
		String hql="from CommodityTpye where del=0 and id !=1";
		return ctdao.execHQL(hql);
	}
	/**
	 * 查询单个商品类型
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	public CommodityTpye getCommodityTpye(String id) {
		if(id ==null || id .equals(""))
		{
			return null;
		}
		
		try {
			return (CommodityTpye)ctdao.select(CommodityTpye.class, Integer.parseInt(id));
		} catch (Exception e) {
			
			e.printStackTrace();
			return null;
		}
	}
	public Field addobj(Field field) {
		
		return ctdao.addobj(field);
	}
	public boolean del(CommodityTpye ct) {
		try {
			ctdao.update(ct);
			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return false;
	}
	public boolean update(CommodityTpye ct) {
		// TODO Auto-generated method stub
		return false;
	}
	/**
	 * 用登录名查询登录用户信息
	 */
	public Users getUsers(String loginname) {
		String hql = "from Users u where u.loginName="+"'"+loginname+"'";
		Users us = (Users)ctdao.execHQL(hql).get(0);
		return us;
	}
	/**
	 * 添加或者更行商品类型
	 */
	public boolean add(CommodityTpye ct) {
		try{
			ctdao.update(ct);
			return true;
			
		}catch (Exception e) {
			
		}
		return false;
	}
	
	/**
	 * 添加或者更行商品类型
	 * 返回对象
	 */
	public CommodityTpye addReturn(CommodityTpye ct) {
		try{
			CommodityTpye commodityTpye = (CommodityTpye) ctdao.addReturnObject(ct);
			return commodityTpye;
			
		}catch (Exception e) {
			
		}
		return null;
	}
	
	/**
	 * 查询商品类型
	 */
	public Pages getCommodityType(String hql,int pageNo,int pageSize,Object... values)
	{
		
		return ctdao.paginationQuery(hql, pageNo, pageSize, values);
	}
	/**
	 * 查询员工信息
	 */
	public Employee getEmp(int id) {
		
		try {
			return (Employee)ctdao.select(Employee.class, id);
		} catch (Exception e) {
			return null;
			
		}
	}
	public Field getObj (int id){
		
		
		try {
			return (Field)ctdao.select(Field.class, id);
		} catch (Exception e) {
			return null;
			
		}
	}
	


}
