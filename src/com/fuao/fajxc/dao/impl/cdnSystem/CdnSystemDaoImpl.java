package com.fuao.fajxc.dao.impl.cdnSystem;

import org.hibernate.Query;

import com.fuao.fajxc.dao.cdnSystem.CdnSystemDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.RealmType;

public class CdnSystemDaoImpl extends BaseDaoImpl implements CdnSystemDao {


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
