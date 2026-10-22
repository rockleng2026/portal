package com.fuao.fajxc.bussiness.impl.cdn;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.cdn.SetMealPropertyBussiness;
import com.fuao.fajxc.dao.cdn.SetMealPropertyDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.SetMealProperty;

public class SetMealPropertyBussinessImpl implements SetMealPropertyBussiness {
	private static Logger logger = Logger.getLogger(SetMealProperty.class);
	private SetMealPropertyDao setmealpropertydao;
	

	public SetMealPropertyDao getSetmealpropertydao() {
		return setmealpropertydao;
	}

	public void setSetmealpropertydao(SetMealPropertyDao setmealpropertydao) {
		this.setmealpropertydao = setmealpropertydao;
	}

	public SetMealProperty addSetMealProperty(SetMealProperty setmealproperty) {
		setmealproperty = (SetMealProperty)setmealpropertydao.addReturnObject(setmealproperty);
		return setmealproperty;
	}

	public SetMealProperty delruanSetMealProperty(SetMealProperty setmealproperty) {
		try {
			setmealproperty.setDelflag(1);
			setmealpropertydao.update(setmealproperty);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
			return null;
		}
		return setmealproperty;
	}

	public boolean delyingSetMealProperty(SetMealProperty setmealproperty) {
		try {
			setmealpropertydao.delete(setmealproperty);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
			return false;
		}
		return true;
	}

	//执行分页查询
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values){
		Pages page = null;
		try {
			 page = setmealpropertydao.paginationQuery(hql, pageNo, pageSize, values);
			 return page;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//据ID获得单个对象
	public SetMealProperty findSetMealPropertyById(Integer id) {
		try {
			String hql=" from SetMealProperty where id="+id;
			List list= setmealpropertydao.execHQL(hql);
			if(list != null && list.size()>0){
				return (SetMealProperty) list.get(0);
			}else{
				return null;
			}
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}
	public int updataByHQL(String hql) {
		try {
			return setmealpropertydao.updataObjectByHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}
	public List<SetMealProperty> findSetMealPropertyListByHQL(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

	public SetMealProperty updataSetMealProperty(SetMealProperty setmealproperty) {
		try {
			setmealpropertydao.update(setmealproperty);
			return setmealproperty;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
