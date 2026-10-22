package com.fuao.fajxc.dao.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.fuao.fajxc.dao.FieldPropertyDao;
import com.fuao.fajxc.vo.FieldProperty;

public class FieldPropertyDaoImpl extends BaseDaoImpl implements FieldPropertyDao {
	/**
	 * 添加
	 * @param entity 实体类对象
	 * @return 1成功，0失败
	 */
	public int addFieldProperty(FieldProperty entity) {
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
	public int deleteFieldProperty(FieldProperty entity)  {
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
	public int deleteFieldPropertyById(Class<FieldProperty> entityName, String primaryKey) {
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
	public int updateFieldProperty(FieldProperty entity)  {
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
	public int updateOrSaveFieldProperty(FieldProperty entity) {
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
	 * @return FieldProperty
	 */
	public FieldProperty getFieldPropertyById(Class<FieldProperty> entityClass, Serializable primaryKey)  {
		FieldProperty fieldProperty = null;
		try {
			super.select(entityClass, primaryKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fieldProperty;
	}
	/**
	 * 查询所有
	 * @param strHql HQL语句 或 SQL语句
	 * @return FieldPropertyList
	 */
	public List<FieldProperty> getFieldPropertyAll(final String strHql)  {
		List<FieldProperty> listFieldProperty = null;
		try {
			super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldProperty;
	}

	/**
	 * 查询具体类的 具体类型集合
	 * @param entityName 实体类名
	 * @param strTypeName 类型名称
	 * @return list集合
	 */
	public List<FieldProperty> getFieldPropertyByName(Object entityName, String strTypeName) {
		List<FieldProperty> listFieldProperty = null;
		FieldProperty fieldProperty = (FieldProperty)entityName;
		String strHql = "from FieldProperty fp where 1 = 1 and " +
				"fieldId = (select id from FieldRemark fr where 1 = 1 and fr.name like '%"+strTypeName+"%' ) and " +
				"fp.beanName = '"+entityName.toString()+"' and fp.beanUuid = '"+fieldProperty.getUuid()+"'";
		try {
			super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldProperty;
	}
	/**
	 * 查询具体类的 具体类型集合
	 * @param strEntityName实体类名
	 * @param strUuid UUID
	 * @param strTypeName 类型名
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByTypeNameAndEntity(String strEntityName, String strUuid, String strTypeName) {
		List<FieldProperty> listFieldProperty = null;
		String strHql = "from FieldProperty fp where 1 = 1 and " +
				"fieldId = (select id from FieldRemark fr where 1 = 1 and fr.name like '%"+strTypeName+"%' ) and " +
				"fp.beanName = '"+strEntityName+"' and fp.beanUuid = '"+strUuid+"'";
		try {
			listFieldProperty = super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldProperty;
	}
	
	/**
	 * 联表查询 获得FieldProperty集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FieldProperty> getFieldPropertyByEntityNameUUIDTypeId(String strEntity, String strUuid, String strTypeId){
		final String strSql = "select fp.*  from Field_Remark fr RIGHT JOIN Field_Property fp on fr.id = fp.fieldId where 1 = 1 and fr.id = "+strTypeId+" and "+
			"fp.beanUuid = (select uuid from "+strEntity+" e where 1 = 1 and e.uuid = '"+strUuid+"') ";
		return (List<FieldProperty>)super.getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return session.createSQLQuery(strSql).list();
			}
		});
	}
	/**
	 * 联表查询 获得FieldProperty集合
	 * @param strEntity实体类名
	 * @param strUuid实体类中具体数据的UUID
	 * @param strTypeId字段表的类型ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FieldProperty> getFieldPropertyByEntityNameUUID(String strEntity, String strUuid){
		final String strSql = "select fp.*  from Field_Remark fr RIGHT JOIN Field_Property fp on fr.id = fp.fieldId where 1 = 1 and  "+
			"fp.beanUuid = (select uuid from "+strEntity+" e where 1 = 1 and e.uuid = '"+strUuid+"') ";
		return (List<FieldProperty>)super.getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return session.createSQLQuery(strSql).list();
			}
		});
	}
	/**
	 * 查询具体类的所有数据
	 * @param strEntityName实体类名
	 * @param strUuid UUID
	 * @return
	 */
	public List<FieldProperty> getFieldPropertyByBeanAndBeanName(String strEntityName, String strUuid){
		List<FieldProperty> listFieldProperty = null;
		String strHql = "from FieldProperty fp where 1 = 1 and " +
			"fp.beanName = '"+strEntityName+"' and fp.beanUuid = '"+strUuid+" '";
		try {
			listFieldProperty = super.execHQL(strHql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFieldProperty;
	}
}
