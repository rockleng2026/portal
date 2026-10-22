package com.fuao.fajxc.dao.impl;

import java.io.Serializable;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.fuao.fajxc.dao.FieldRemarkDao;
import com.fuao.fajxc.vo.FieldProperty;
import com.fuao.fajxc.vo.FieldRemark;

public class FieldRemarkDaoImpl extends BaseDaoImpl implements FieldRemarkDao {
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int addFieldRemark(FieldRemark entity) {
		try {
			super.add(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	/**
	 * 删除
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int deleteFieldRemark(FieldRemark entity) {
		try {
			super.delete(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	/**
	 * 删除根据ID
	 * @param entityName 实体类
	 * @param primaryKey 实体类主键ID
	 * @return 1成功，0失败
	 */
	public int deleteFieldRemarkById(Class<FieldRemark> entityName, String primaryKey) {
		try {
			super.del(entityName, primaryKey);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	/**
	 * 更新
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateFieldRemark(FieldRemark entity) {
		try {
			super.update(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	/**
	 * 更新和保存
	 * @param entity 实体对象
	 * @return 1成功，0失败
	 */
	public int updateOrSaveFieldRemark(FieldRemark entity) {
		try {
			super.update(entity);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	/**
	 * 查询根据ID
	 * @param entityClass 实体类
	 * @param primaryKey 实体类主键ID
	 * @return FieldRemark
	 */
	public FieldRemark getFieldRemarkById(Class<FieldRemark> entityClass, Serializable primaryKey) {
		FieldRemark fieldRemark = null;
		try {
			super.select(entityClass, primaryKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fieldRemark;
	}
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return FieldRemarkList
	 */
	public List<FieldRemark> getFieldRemarkAll(final String strHql) {
		List<FieldRemark> listFieldRemark = null;
		try {
			listFieldRemark = super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldRemark;
	}
	/**
	 * 联表查询 获得FieldRemark集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FieldRemark> getFieldRemarkByEntityNameUUIDTypeId(String strEntity, String strUuid, String strTypeId){
		final String strSql = "select fr.*  from Field_Remark fr RIGHT JOIN Field_Property fp on fr.id = fp.fieldId where 1 = 1 and fr.id = "+strTypeId+" and "+
			"fp.beanUuid = (select uuid from "+strEntity+" e where 1 = 1 and e.uuid = '"+strUuid+"') ";
		return (List<FieldRemark>)super.getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return session.createSQLQuery(strSql).list();
			}
		});
	}
	/**
	 * 根据类型名称查询所有
	 * @param strTypeName 类型名称
	 * @return List集合
	 */
	public List<FieldRemark> getFieldRemarkByName(String strTypeName) {
		List<FieldRemark> listFieldRemark = null;
		try {
			String strHql = "from FieldRemark fr where 1 = 1 and fr.name like '%"+strTypeName+"%' ";
			listFieldRemark = super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldRemark;
	}
	/**
	 * 根据实体类名查询所有
	 * @param strEntityName实体类名
	 * @return List集合
	 */
	public List<FieldRemark> getFieldRemarkByEntityName(String strEntityName){
		List<FieldRemark> listFieldRemark = null;
		try {
			String strHql = "from FieldRemark fr where 1 = 1 and fr.beanNames like '%"+strEntityName+"%' ";
			listFieldRemark = super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldRemark;
	}
}
