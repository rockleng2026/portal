package com.fuao.fajxc.bussiness;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.vo.FieldProperty;

public interface FieldPropertyBussiness {
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int addFieldProperty(FieldProperty entity) ;
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int deleteFieldProperty(FieldProperty entity) ;
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 */
	public int deleteFieldPropertyById(Class<FieldProperty> entityName, String primaryKey) ;
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateFieldProperty(FieldProperty entity) ;
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateOrSaveFieldProperty(FieldProperty entity) ;
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return FieldProperty
	 */
	public FieldProperty getFieldPropertyById(Class<FieldProperty> entityClass, Serializable primaryKey) ;
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return FieldPropertyList
	 */
	public List<FieldProperty> getFieldPropertyAll(final String strHql) ;
	/**
	 * 查询具体类的 具体类型集合
	 * @param entityName 实体类名
	 * @param strTypeName 类型名称
	 * @return list集合
	 */
	public List<FieldProperty> getFieldPropertyByName(Object entityName, String strTypeName) ;
	/**
	 * 查询具体类的 具体类型集合
	 * @param strEntityName实体类名
	 * @param strUuid UUID
	 * @param strTypeName 类型名
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByTypeNameAndEntity(String strEntityName, String strUuid, String strTypeName) ;
	/**
	 * 聊表查询 获得FieldProperty集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByEntityNameUUIDTypeId(String strEntity, String strUuid, String strTypeId);
	/**
	 * 聊表查询 获得FieldProperty集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FieldProperty> getFieldPropertyByEntityNameUUID(String strEntity, String strUuid);
	/**
	 * 查询具体类的所有数据
	 * @param strEntityName实体类名
	 * @param strUuid UUID
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByBeanAndBeanName(String strEntityName, String strUuid) ;
}
