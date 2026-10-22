package com.fuao.fajxc.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.UserRelationDao;
import com.fuao.fajxc.vo.UserRelation;

public class UserRelationDaoImpl extends BaseDaoImpl implements UserRelationDao {
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int addUserRelation(UserRelation entity) {
		try {
			super.add(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int deleteUserRelation(UserRelation entity) {
		try {
			super.delete(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int deleteUserRelationById(Class<UserRelation> entityName, String primaryKey) {
		try {
			super.del(entityName, primaryKey);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int updateUserRelation(UserRelation entity) {
		try {
			super.update(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 * @throws Exception
	 */
	public int updateOrSaveUserRelation(UserRelation entity) {
		try {
			super.add(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return UserRelation
	 * @throws Exception
	 */
	public UserRelation getUserRelationById(Class<UserRelation> entityClass, Serializable primaryKey) {
		UserRelation UserRelation = null;
		try {
			UserRelation = (UserRelation)super.select(entityClass, primaryKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return UserRelation;
	}
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return UserRelationList
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<UserRelation> getUserRelationAll(final String strHql) {
		List<UserRelation> listUserRelation = new ArrayList<UserRelation>();
		try {
			Query q = super.getSession().createQuery(strHql);
			listUserRelation = (List<UserRelation>)q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listUserRelation;
	}
}
