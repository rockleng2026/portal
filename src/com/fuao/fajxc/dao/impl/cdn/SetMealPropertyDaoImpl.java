package com.fuao.fajxc.dao.impl.cdn;

import org.hibernate.Query;

import com.fuao.fajxc.dao.cdn.SetMealPropertyDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.SetMealProperty;

public class SetMealPropertyDaoImpl extends BaseDaoImpl implements
		SetMealPropertyDao {

	public SetMealProperty findSetMealPropertyById(Integer id) {
		try{
			return (SetMealProperty)super.select(SetMealProperty.class, id);
		}catch(Exception e)
		{
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
