package com.fuao.fajxc.bussiness.orderTemplate;

import java.util.List;

import com.fuao.fajxc.bussiness.BaseBussiness;
import com.fuao.fajxc.vo.SetmealComm;
import com.fuao.fajxc.vo.SetmealPropertyComm;

/**
 * 
 * @author ãÚ³¬Ç¿ 14015
 * @time 2012-1-6 17:14:02
 *
 */
public interface SetMealBussiness extends BaseBussiness{
	//Ìí¼ÓÌ×²Í
	public SetmealComm addSetMeal(Object setMeal,String[] pro);
	
	//ÐÞ¸ÄÌ×²Í
	public boolean updateSetMeal(Object setMeal,String[] pro,List<SetmealPropertyComm> oldPro);
	
	//É¾³ý
	public boolean delSoftSetMeal(Object setMeal,List<SetmealPropertyComm> pro);
}
