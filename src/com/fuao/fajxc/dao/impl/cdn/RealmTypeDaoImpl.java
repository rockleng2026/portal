package com.fuao.fajxc.dao.impl.cdn;

import org.hibernate.Query;

import com.fuao.fajxc.dao.cdn.RealmTypeDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.RealmType;

public class RealmTypeDaoImpl extends BaseDaoImpl implements RealmTypeDao {

	public RealmType findRealmTypeById(Integer id) {
		try {
			return (RealmType)super.select(RealmType.class, id);
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
