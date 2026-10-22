package com.fuao.fajxc.bussiness;

import java.io.Serializable;
import java.util.List;

import com.fuao.fajxc.vo.UserRelation;

public interface UserRelationBussiness {
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int addUserRelation(UserRelation entity) ;
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int deleteUserRelation(UserRelation entity) ;
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int deleteUserRelationById(Class<UserRelation> entityName, String primaryKey) ;
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int updateUserRelation(UserRelation entity) ;
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int updateOrSaveUserRelation(UserRelation entity) ;
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return UserRelation
	 * @throws Exception
	 */
	public UserRelation getUserRelationById(Class<UserRelation> entityClass, Serializable primaryKey) ;
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return UserRelationList
	 * @throws Exception
	 */
	public List<UserRelation> getUserRelationAll(final String strHql) ;
}
