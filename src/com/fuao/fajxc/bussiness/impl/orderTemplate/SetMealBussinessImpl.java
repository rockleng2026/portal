package com.fuao.fajxc.bussiness.impl.orderTemplate;


import java.util.List;

import com.fuao.fajxc.bussiness.impl.BaseBussinessImpl;
import com.fuao.fajxc.bussiness.orderTemplate.SetMealBussiness;
import com.fuao.fajxc.dao.orderTemplate.SetMealDao;
import com.fuao.fajxc.vo.SetmealComm;
import com.fuao.fajxc.vo.SetmealPropertyComm;


/**
 * 
 * @author 阙超强 14015
 * @time 2012-1-6 17:14:02
 *
 */
public class SetMealBussinessImpl extends BaseBussinessImpl implements SetMealBussiness{

	/**
	 * 添加套餐，同时属性绑定
	 */
	public SetmealComm addSetMeal(Object setMeal, String[] pro) {
		//添加套餐 
		SetmealComm setmealComm = (SetmealComm) super.add(setMeal);
		if(null == setmealComm){
			return null;
		}
		//设置属性绑定到套餐
		for(int i = 0; i < pro.length; i++){
			//拿到属性的当前ID
			String strId = pro[i];
			//拿出属性
			SetmealPropertyComm setmealPropertyComm = (SetmealPropertyComm) super.getById(SetmealPropertyComm.class, Integer.parseInt(strId));
			//设置属性的属于当前这个套餐
			setmealPropertyComm.setSetmealComm(setmealComm);
			//然后修改
			boolean result = super.update(setmealPropertyComm);
			if(false == result){
				return null;
			}
		}
		return setmealComm;
	}

	/**
	 * 修改套餐
	 */
	public boolean updateSetMeal(Object setMeal, String[] pro,List<SetmealPropertyComm> oldPro) {
		//修改套餐
		boolean result = super.update(setMeal);
		if(false == result){
			return false;
		}

		//先把之前的属性清除绑定
		int oldCount = oldPro.size();
		for(int j = 0;j < oldCount;j++){
			SetmealPropertyComm setmealPropertyComm = oldPro.get(j);
			setmealPropertyComm.setSetmealComm(null);
			boolean bool = super.update(setmealPropertyComm);
			if(false == bool){
				return false;
			}
		}

		//判断是否有值
		if(null != pro){
			//设置属性绑定到套餐
			int count = pro.length;
			for(int i = 0; i < count; i++){
				//拿到属性的当前ID
				String strId = pro[i];
				//拿出属性
				SetmealPropertyComm setmealPropertyComm = (SetmealPropertyComm) super.getById(SetmealPropertyComm.class, Integer.parseInt(strId));
				//设置属性的属于当前这个套餐
				setmealPropertyComm.setSetmealComm((SetmealComm)setMeal);
				//然后修改
				boolean rt = super.update(setmealPropertyComm);
				if(false == rt){
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * 软删除套餐，同时取消属性对其的绑定
	 */
	public boolean delSoftSetMeal(Object setMeal, List<SetmealPropertyComm> pro) {
		//删除
		boolean result = super.delSoft(setMeal);
		if(false == result){
		        return false;
		}
		
		//先把之前的属性清除绑定
		int proCount = pro.size();
		for(int j = 0;j < proCount;j++){
			SetmealPropertyComm setmealPropertyComm = pro.get(j);
			setmealPropertyComm.setSetmealComm(null);
			boolean bool = super.update(setmealPropertyComm);
			if(false == bool){
			        return false;
			}
		}
		return true;
	}

	//注入dao层
	private SetMealDao smdao;

	public SetMealDao getSmdao() {
		return smdao;
	}

	public void setSmdao(SetMealDao smdao) {
		this.smdao = smdao;
	}

	
}
