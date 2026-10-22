package com.fuao.fajxc.bussiness.commodity;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Users;

/**
 * 商品类型操作
 * 业务逻辑接口
 * @author 14012
 *
 */
public interface CommodityTypeBussiness {
	
	public List getCommoditTypes();
	
	/**
	 * 查询商品类型
	 * @param id
	 * @return
	 */
	public CommodityTpye getCommodityTpye(String id);
	
	/**
	 * 添加商品类型字段
	 */

	public Field addobj(Field obj);
	
	/**
	 * 删除商品类型
	 */
	public boolean del(CommodityTpye ct);
	
	/**
	 * 修改商品类型
	 */
	public boolean update(CommodityTpye ct);
	
	/**
	 * 用登录名查询登录用户信息
	 */
	public Users getUsers(String loginname);
	
	/**
	 * 添加商品类型
	 */
	public boolean add(CommodityTpye ct);
	
	/**
	 * 添加或者更行商品类型
	 * 返回对象
	 */
	public CommodityTpye addReturn(CommodityTpye ct);
	
	/**
	 * 查询商品类型
	 */
	public Pages getCommodityType(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查询员工信息
	 */
	public Employee getEmp(int id);
	/**
	 * 查询对象
	 * @param cls
	 * @param primaryKey
	 * @return
	 */
	public Field getObj (int id);
}
