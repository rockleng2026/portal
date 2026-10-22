package com.fuao.fajxc.bussiness.impl.cdn;

import java.util.List;

import com.fuao.fajxc.bussiness.cdn.SetMealCenterBussiness;
import com.fuao.fajxc.dao.cdn.SetMealCenterDao;
import com.fuao.fajxc.vo.SetMealCenter;

public class SetMealCenterBussinessImpl implements SetMealCenterBussiness {
	private SetMealCenterDao setmealcenterdao;
	
	
	
	public SetMealCenterDao getSetmealcenterdao() {
		return setmealcenterdao;
	}

	public void setSetmealcenterdao(SetMealCenterDao setmealcenterdao) {
		this.setmealcenterdao = setmealcenterdao;
	}

	public SetMealCenter addMealCenter(SetMealCenter setmealcenter) {
		// TODO Auto-generated method stub
		return null;
	}

	public SetMealCenter delruanSetMealCenter(SetMealCenter setmealcenter) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean delyingSetMealCenter(SetMealCenter setmealcenter) {
		// TODO Auto-generated method stub
		return false;
	}

	public SetMealCenter findSetMealCenterById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<SetMealCenter> findSetMealCenterListByHQL(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

	public SetMealCenter updataSetMealCenter(SetMealCenter setmealcenter) {
		// TODO Auto-generated method stub
		return null;
	}

}
