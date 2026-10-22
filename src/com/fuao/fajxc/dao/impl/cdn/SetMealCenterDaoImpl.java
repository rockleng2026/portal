package com.fuao.fajxc.dao.impl.cdn;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.dao.cdn.SetMealCenterDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.SetMealCenter;

public class SetMealCenterDaoImpl extends BaseDaoImpl implements SetMealCenterDao {

	public SetMealCenter findSetMealCenterById(Integer id) {
		try{
			return  (SetMealCenter)super.select(SetMealCenter.class, id);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}



}
