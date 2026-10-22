package com.fuao.fajxc.bussiness.commodity;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Property;

/**
 * 商品信息业务层接口
 * @author 14012
 *
 */
public interface CommodityBussiness {
	/**
	 * 添加商品信息字段
	 * 因为每个商品的属性有所不同，所以数据库用temp代替商品
	 * 的所有属性，用户可以自定义商品属性
	 * @param field 字段实体
	 * @return boolean true:添加成功  false：添加失败
	 */
	public boolean addField(Field field);
	
	/**
	 * 添加字段属性值
	 * @param property 字段属性实体
	 * @return boolean true:添加成功  false：添加失败
	 */
	public boolean addProperty(Property property);
 
	/**
	 * 查询商品信息
	 * @param hql 查询语句
	 * @param pageNo 当前页
	 * @param pageSize 每页大小
	 * @param values 
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values);

	/**
	 * 根据ID查询字段对象
	 * @return
	 */
	public Field getField ( int id);
	
	/**
	 * 插入Model对象返回ID
	 */
	public Model getModel(Model m);
	
	/**
	 * 根据商品属性ID查询商品信息
	 */
	public Property getProperty(int id);
	
	/**
	 * 删除商品信息
	 */
	public boolean del(Property p);
	
	/**
	 * 根据条件查找所有商品存放在List中
	 */
	public List someCommodity(String addhql);
	
	/**
	 * 根据型号ID查询属性
	 */
	 public Property getProperty(String id);
}

