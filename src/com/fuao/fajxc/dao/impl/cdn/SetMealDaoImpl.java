package com.fuao.fajxc.dao.impl.cdn;

import org.hibernate.Query;

import com.fuao.fajxc.dao.cdn.SetMealDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.SetMeal;

public class SetMealDaoImpl extends BaseDaoImpl implements SetMealDao {

	public SetMeal findSetMealById(Integer id) {
		try {
			return (SetMeal) super.select(SetMeal.class,id);
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
	
	public SetMeal updateSetMeal(SetMeal setMeal) {
		super.getHibernateTemplate().update(setMeal);
		return setMeal;
	}
}
