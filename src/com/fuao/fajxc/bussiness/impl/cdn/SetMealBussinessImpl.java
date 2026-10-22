package com.fuao.fajxc.bussiness.impl.cdn;


import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.cdn.SetMealBussiness;
import com.fuao.fajxc.dao.cdn.SetMealDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.SetMeal;

public class SetMealBussinessImpl implements SetMealBussiness {
	private static Logger logger = Logger.getLogger(SetMeal.class);
	private SetMealDao setmealdao;

	public SetMealDao getSetmealdao() {
		return setmealdao;
	}

	public void setSetmealdao(SetMealDao setmealdao) {
		this.setmealdao = setmealdao;
	}
	/**
	 * 
	 * **/
	public SetMeal addSetMeal(SetMeal setmeal) {
		
		return null;
	}
	/**
	 * 
	 * **/
	public SetMeal delruanSetMeal(SetMeal setmeal) {
		return null;
	}
	/**
	 * 
	 * **/
	public boolean delyingSetMeal(SetMeal setmeal) {
		return false;
	}
	/**
	 *
	 * **/
	public SetMeal findSetMealById(Integer id) {
		return null;
	}
	/**
	 * 
	 * **/
	public List<SetMeal> findSetMealList(String hql) {
		return null;
	}
	/**
	 *修改套餐
	 * ***/
	public SetMeal updateSetMeal(SetMeal setmeal) {
		try {
			return setmealdao.updateSetMeal(setmeal);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 添加
	 */
	public Object addObject(Object obj) {
		try {
			return setmealdao.addReturnObject(obj);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public int delObject(Object obj) {
		try {
			setmealdao.delete(obj);
			return 1;
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}

	public Object findObjectById(String classtype, Integer id) {
		try {
			String hql=" from "+classtype+" where id="+id;
			List list= setmealdao.execHQL(hql);
			if(list!=null&&list.size()>0)
				return list.get(0);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public List findObjectListByHQL(String hql) {
		try {
			return setmealdao.execHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public int updataByHQL(String hql) {
		try {
			return setmealdao.updataObjectByHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}

	public Object updataObject(Object obj) {
		try {
			setmealdao.update(obj);
			return obj;
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}
	
	//执行分页查询
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values){
		Pages page = null;
		try {
			 page = setmealdao.paginationQuery(hql, pageNo, pageSize, values);
			 return page;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//据ID获取对象
	public SetMeal getSetMealData(String id){
		try {
			SetMeal setMeal = (SetMeal) setmealdao.select(SetMeal.class, Integer.parseInt(id));
			return setMeal;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 硬删除
	 */
	public boolean del(Class c,String id){
		try {
			setmealdao.del(c,id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
