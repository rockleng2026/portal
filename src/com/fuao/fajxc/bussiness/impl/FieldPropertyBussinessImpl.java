package com.fuao.fajxc.bussiness.impl;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.bussiness.FieldPropertyBussiness;
import com.fuao.fajxc.dao.FieldPropertyDao;
import com.fuao.fajxc.vo.FieldProperty;

public class FieldPropertyBussinessImpl implements FieldPropertyBussiness{
	private FieldPropertyDao fieldPropertyDao;
	
	public FieldPropertyDao getFieldPropertyDao() {
		return fieldPropertyDao;
	}
	public void setFieldPropertyDao(FieldPropertyDao fieldPropertyDao) {
		this.fieldPropertyDao = fieldPropertyDao;
	}
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int addFieldProperty(FieldProperty entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   ---> setFieldPropertyDao  --->   parameter is null");
			return 0;
		}
		return fieldPropertyDao.addFieldProperty(entity);
	}
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int deleteFieldProperty(FieldProperty entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   ---> deleteFieldProperty(FieldProperty entity)   --->   parameter is null");
			return 0;
		}
		return fieldPropertyDao.deleteFieldProperty(entity);
	}
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 */
	public int deleteFieldPropertyById(Class<FieldProperty> entityName, String primaryKey) {
		if(null==entityName||entityName.equals(null)||"".equals(primaryKey)||null==primaryKey){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  deleteFieldPropertyById(Class<FieldProperty> entityName, String primaryKey)   --->   parameter is null");
			return 0;
		}
		return fieldPropertyDao.deleteFieldPropertyById(entityName, primaryKey);
	}
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateFieldProperty(FieldProperty entity)  {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   ---> updateFieldProperty(FieldProperty entity) --->   parameter is null");
			return 0;
		}
		return fieldPropertyDao.updateFieldProperty(entity);
	}
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateOrSaveFieldProperty(FieldProperty entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  updateOrSaveFieldProperty(FieldProperty entity)  --->   parameter is null");
			return 0;
		}
		return fieldPropertyDao.updateOrSaveFieldProperty(entity);
	}
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return FieldProperty
	 */
	public FieldProperty getFieldPropertyById(Class<FieldProperty> entityClass, Serializable primaryKey)  {
		if(null==entityClass||entityClass.equals(null)||"".equals(primaryKey)||null==primaryKey){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  getFieldPropertyById(Class<FieldProperty> entityClass, Serializable primaryKey)   --->   parameter is null");
			return null;
		}
		return fieldPropertyDao.getFieldPropertyById(entityClass, primaryKey);
	}
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return FieldPropertyList
	 */
	public List<FieldProperty> getFieldPropertyAll(final String strHql) {
		if(null==strHql||strHql==""){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   ---> getFieldPropertyAll(final String strHql)  --->   parameter is null");
			return null;
		}
		return fieldPropertyDao.getFieldPropertyAll(strHql);
	}
	/**
	 * 查询具体类的 具体类型集合
	 * @param entityName 实体类名
	 * @param strTypeName 类型名称
	 * @return list集合
	 */
	public List<FieldProperty> getFieldPropertyByName(Object entityName, String strTypeName) {
		if(null==entityName||entityName.equals(null)||"".equals(strTypeName)||strTypeName.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  getFieldPropertyByName(Object entityName, String strTypeName)  --->   parameter is null");
			return null;
		}
		return fieldPropertyDao.getFieldPropertyByName(entityName, strTypeName);
	}
	/**
	 * 查询具体类的 具体类型集合
	 * @param strEntityName实体类名
	 * @param strUuid UUID
	 * @param strTypeName 类型名
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByTypeNameAndEntity(String strEntityName, String strUuid, String strTypeName) {
		if(null==strEntityName||strEntityName.equals(null)||null==strUuid||strUuid.equals(null)||"".equals(strTypeName)||strTypeName.equals(null)||strEntityName.equals(null)||"".equals(strEntityName)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  getFieldPropertyByTypeNameAndEntity(Object entityName,String strEntityName, String strTypeName)   --->   parameter is null");
			System.out.println("entityname = "+strEntityName + "   uuid = "+ strUuid + "    typeName = "+strTypeName);
			return null;
		}
		return fieldPropertyDao.getFieldPropertyByTypeNameAndEntity(strEntityName, strUuid, strTypeName);
	}
	/**
	 * 聊表查询 获得FieldProperty集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByEntityNameUUIDTypeId(String strEntity, String strUuid, String strTypeId){
		if(null==strEntity||strEntity.equals(null)||null==strUuid||strUuid.equals(null)||"".equals(strTypeId)||strTypeId.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  getFieldPropertyByEntityNameUUIDTypeId  --->   parameter is null");
			System.out.println("strEntity = "+strEntity + "   uuid = "+ strUuid + "    strTypeId = "+strTypeId);
			return null;
		}
		return fieldPropertyDao.getFieldPropertyByEntityNameUUIDTypeId(strEntity, strUuid, strTypeId);
	}
	/**
	 * 聊表查询 获得FieldProperty集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByEntityNameUUID(String strEntity, String strUuid){
		if(null==strEntity||strEntity.equals(null)||null==strUuid||strUuid.equals(null)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  getFieldPropertyByEntityNameUUIDTypeId  --->   parameter is null");
			System.out.println("strEntity = "+strEntity + "   uuid = "+ strUuid + "  ");
			return null;
		}
		return fieldPropertyDao.getFieldPropertyByEntityNameUUID(strEntity, strUuid);
	}
	/**
	 * 查询具体类的所有数据
	 * @param strEntityName实体类名
	 * @param strUuid UUID
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByBeanAndBeanName(String strEntityName, String strUuid) {
		if(null==strUuid||strUuid.equals(null)||strEntityName.equals(null)||"".equals(strEntityName)){
			System.out.println("Debugging MC --->  FieldPropertyBussinessImpl   --->  getFieldPropertyByTypeNameAndEntity(Object entityName,String strEntityName, String strTypeName)   --->   parameter is null");
			return null;
		}
		return fieldPropertyDao.getFieldPropertyByBeanAndBeanName(strEntityName, strUuid);
	}
}
