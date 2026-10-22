package com.fuao.fajxc.dao.impl.cdn;

import org.hibernate.Query;

import com.fuao.fajxc.dao.cdn.TypeDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.Type;

public class TypeDaoImpl extends BaseDaoImpl implements TypeDao {

	public Type findTypeById(Integer id) {
		try {
			return (Type)super.select(Type.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int updataObjectByHQL(String hql) {
		try {
			Query query = this.getSession().createQuery(hql);
			int a = query.executeUpdate();
			if(a>0)return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

}
