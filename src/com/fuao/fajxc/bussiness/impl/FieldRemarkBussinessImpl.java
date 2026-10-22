package com.fuao.fajxc.bussiness.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.FieldRemarkBussiness;
import com.fuao.fajxc.dao.FieldRemarkDao;
import com.fuao.fajxc.vo.FieldRemark;

public class FieldRemarkBussinessImpl implements FieldRemarkBussiness {
	private FieldRemarkDao fieldRemarkDao;
	
	public FieldRemarkDao getFieldRemarkDao() {
		return fieldRemarkDao;
	}
	public void setFieldRemarkDao(FieldRemarkDao fieldRemarkDao) {
		this.fieldRemarkDao = fieldRemarkDao;
	}
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int addFieldRemark(FieldRemark entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   --->  addFieldRemark(FieldRemark entity)  --->   parameter is null");
			return 0;
		}
		
		return fieldRemarkDao.addFieldRemark(entity);
	}
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int deleteFieldRemark(FieldRemark entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   ---> deleteFieldRemark(FieldRemark entity)  --->   parameter is null");
			return 0;
		}
		return fieldRemarkDao.deleteFieldRemark(entity);
	}
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 */
	public int deleteFieldRemarkById(Class<FieldRemark> entityName, String primaryKey) {
		if(null==entityName||entityName.equals(null)||"".equals(primaryKey)||null==primaryKey){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   --->  deleteFieldRemarkById(Class<FieldRemark> entityName, String primaryKey)  --->   parameter is null");
			return 0;
		}
		return fieldRemarkDao.deleteFieldRemarkById(entityName, primaryKey);
	}
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateFieldRemark(FieldRemark entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   ---> updateFieldRemark(FieldRemark entity) --->   parameter is null");
			return 0;
		}
		return fieldRemarkDao.updateFieldRemark(entity);
	}
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateOrSaveFieldRemark(FieldRemark entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   --->  updateOrSaveFieldRemark(FieldRemark entity)  --->   parameter is null");
			return 0;
		}
		return fieldRemarkDao.updateOrSaveFieldRemark(entity);
	}
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return FieldRemark
	 */
	public FieldRemark getFieldRemarkById(Class<FieldRemark> entityClass, Serializable primaryKey) {
		if(null==entityClass||entityClass.equals(null)||"".equals(primaryKey)||null==primaryKey){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   --->  getFieldRemarkById(Class<FieldRemark> entityClass, Serializable primaryKey)   --->   parameter is null");
			return null;
		}
		return fieldRemarkDao.getFieldRemarkById(entityClass, primaryKey);
	}
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return FieldRemarkList
	 */
	public List<FieldRemark> getFieldRemarkAll(final String strHql){
		if(null==strHql||strHql==""){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   ---> getFieldRemarkAll(final String strHql)  --->   parameter is null");
			return null;
		}
		return fieldRemarkDao.getFieldRemarkAll(strHql);
	}
	/**
	 * 聊表查询 获得FieldRemark集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	public List<FieldRemark> getFieldRemarkByEntityNameUUIDTypeId(String strEntity, String strUuid, String strTypeId){
		if(null==strEntity||strEntity==""||null==strUuid||strUuid==""||strTypeId==""||null==strTypeId){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   ---> getFieldRemarkAll(final String strHql)  --->   parameter is null");
			return null;
		}
		return fieldRemarkDao.getFieldRemarkByEntityNameUUIDTypeId(strEntity, strUuid, strTypeId);
	}
	/**
	 * 根据类型名称查询所有
	 * @param strTypeName 类型名称
	 * @return List集合
	 */
	public List<FieldRemark> getFieldRemarkByName(String strTypeName) {
		if(null==strTypeName||strTypeName.equals(null)){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   --->  getFieldRemarkByName(String strTypeName)  --->   parameter is null");
			return null;
		}
		return fieldRemarkDao.getFieldRemarkByName(strTypeName);
	}
	/**
	 * 根据实体类名查询所有
	 * @param strEntityName实体类名
	 * @return List集合
	 */
	public List<FieldRemark> getFieldRemarkByEntityName(String strEntityName){
		if(null==strEntityName||"".equals(strEntityName)){
			System.out.println("Debugging MC --->  FieldRemarkBussinessImpl.java   --->  getFieldRemarkByName(String strTypeName)  --->   parameter is null");
			return null;
		}
		return fieldRemarkDao.getFieldRemarkByEntityName(strEntityName);
	}
//	/**
//	 * main方法
//	 */
//	public static void main(String[] args) throws Exception{
//		ApplicationContext ac=new FileSystemXmlApplicationContext("/src/applicationContext*.xml");
//		FieldRemarkBussiness frb = (FieldRemarkBussinessImpl)ac.getBean("fieldRemarkBussiness");
//		List<FieldRemark> listFieldRemark = frb.getFieldRemarkByName("工作经验");
//		FieldRemark fr = null;
//		if(listFieldRemark.size()<1){
//			System.out.println("没有数据");
//		}else{
//			for(int i = 0 ; i < listFieldRemark.size(); i++){
//				fr = listFieldRemark.get(i);
//				System.out.println("类型名称："+fr.getName());
//				System.out.println("描          述："+fr.getRemark());
//				System.out.println("字       段1： "+fr.getTemp1());
//				System.out.println("字       段2： "+fr.getTemp2());
//				System.out.println("字       段3： "+fr.getTemp3());
//			}
//		}
//	}
}
