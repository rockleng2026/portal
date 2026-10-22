package com.fuao.fajxc.dao;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.vo.FieldProperty;
import com.fuao.fajxc.vo.FieldRemark;

public interface FieldRemarkDao {
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int addFieldRemark(FieldRemark entity) ;
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int deleteFieldRemark(FieldRemark entity) ;
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 */
	public int deleteFieldRemarkById(Class<FieldRemark> entityName, String primaryKey) ;
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateFieldRemark(FieldRemark entity) ;
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateOrSaveFieldRemark(FieldRemark entity) ;
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return FieldRemark
	 */
	public FieldRemark getFieldRemarkById(Class<FieldRemark> entityClass, Serializable primaryKey) ;
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return FieldRemarkList
	 */
	public List<FieldRemark> getFieldRemarkAll(final String strHql) ;
	/**
	 * 聊表查询 获得FieldRemark集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	public List<FieldRemark> getFieldRemarkByEntityNameUUIDTypeId(String strEntity, String strUuid, String strTypeId);
	/**
	 * 根据类型名称查询所有
	 * @param strTypeName 类型名称
	 * @return List集合
	 */
	public List<FieldRemark> getFieldRemarkByName(String strTypeName) ;
	/**
	 * 根据实体类名查询所有
	 * @param strEntityName实体类名
	 * @return List集合
	 */
	public List<FieldRemark> getFieldRemarkByEntityName(String strEntityName);
}
