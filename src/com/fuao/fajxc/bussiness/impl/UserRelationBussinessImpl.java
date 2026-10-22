package com.fuao.fajxc.bussiness.impl;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.bussiness.UserRelationBussiness;
import com.fuao.fajxc.dao.UserRelationDao;
import com.fuao.fajxc.vo.UserRelation;

public class UserRelationBussinessImpl implements UserRelationBussiness {
	private UserRelationDao userRelationDao;

	public UserRelationDao getUserRelationDao() {
		return userRelationDao;
	}
	public void setUserRelationDao(UserRelationDao userRelationDao) {
		this.userRelationDao = userRelationDao;
	}
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int addUserRelation(UserRelation entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("传入的参数(UserBasic对象)不正确或者为空。失败");
			return 0;
		}
		return userRelationDao.addUserRelation(entity);
	}
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int deleteUserRelation(UserRelation entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("传入的参数(UserBasic对象)不正确或者为空。失败");
			return 0;
		}
		return userRelationDao.deleteUserRelation(entity);
	}
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int deleteUserRelationById(Class<UserRelation> entityName, String primaryKey){
		if(null==entityName||entityName.equals(null)){
			System.out.println("传入的参数(UserBasic对象)不正确或者为空。失败");
			return 0;
		}if(null==primaryKey||"".equals(primaryKey)){
			System.out.println("传入的参数(UserBasic对象中的primaryKey)不正确或者为空。失败");
			return 0;
		}
		return userRelationDao.deleteUserRelationById(entityName, primaryKey);
	}
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int updateUserRelation(UserRelation entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("传入的参数(UserBasic对象)不正确或者为空。失败");
			return 0;
		}
		return userRelationDao.updateUserRelation(entity);
	}
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int updateOrSaveUserRelation(UserRelation entity) {
		if(null==entity||entity.equals(null)){
			System.out.println("传入的参数(UserBasic对象)不正确或者为空。失败");
			return 0;
		}
		return userRelationDao.updateOrSaveUserRelation(entity);
	}
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return UserRelation
	 * @throws Exception
	 */
	public UserRelation getUserRelationById(Class<UserRelation> entityClass, Serializable primaryKey)  {
		if(null==entityClass||entityClass.equals(null)){
			System.out.println("传入的参数(UserBasic对象)不正确或者为空。失败");
			return null;
		}if(null==primaryKey||"".equals(primaryKey)){
			System.out.println("传入的参数(UserBasic对象中的primaryKey)不正确或者为空。失败");
			return null;
		}
		return userRelationDao.getUserRelationById(entityClass, primaryKey);
	}
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return UserRelationList
	 * @throws Exception
	 */
	public List<UserRelation> getUserRelationAll(final String strHql) {
		if(null==strHql||strHql.equals("")){
			System.out.println("传入的参数(strHql语句)不正确或者为空。失败");
		}
		return userRelationDao.getUserRelationAll(strHql);
	}
}
