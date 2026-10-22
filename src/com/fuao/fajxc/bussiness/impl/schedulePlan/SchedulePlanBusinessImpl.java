package com.fuao.fajxc.bussiness.impl.schedulePlan;

import java.util.List;

import com.fuao.fajxc.bussiness.schedulePlan.SchedulePlanBusiness;
import com.fuao.fajxc.dao.schedulePlan.SchedulePlanDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Scheduleplan;

public class SchedulePlanBusinessImpl implements SchedulePlanBusiness {

	private SchedulePlanDao dao ;

	/**
	 * 根据实体名和条件，获取对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String entityName ,String condition)
	{
		String hql = " from "+entityName+" where 1=1 "+condition;
		return dao.ObjectList(hql);
	}
	
	/**
	 * 添加日程计划
	 * @param plan
	 * @return
	 */
	public boolean addSchedulePlan(Scheduleplan plan)
	{
		return dao.addSchedulePlan(plan);
	}
	
	/**
	 * 添加日程计划
	 * @param plan
	 * @return Scheduleplan
	 */
	public Scheduleplan addSchedule(Scheduleplan plan)
	{
		return dao.addSchedule(plan);
	}
	
	/**
	 * 根据id获取单个Schedule对象
	 * @author 阙超强
	 * 2011-11-24 17:54:09
	 */
	public Object getObjectById(int id){
		String hql = " from Scheduleplan where id = "+id;
		return dao.getObject(hql);
	}
	
	/**
	 * 修改日程计划
	 * @param plan
	 * @return
	 */
	public boolean updateSchedulePlan(Scheduleplan plan)
	{
		return dao.updateSchedulePlan(plan);
	}
	
	/**
	 * 删除日程计划
	 * @param plan
	 * @return
	 */
	public boolean deleteSchedulePlan(Scheduleplan plan)
	{
		return dao.deleteSchedulePlan(plan);
	}
	
	/**
	 * 日程计划分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values)
	{
		return dao.exHqlPages(hql, pageNo, pageSize, values);
	}
	
	public SchedulePlanDao getDao() {
		return dao;
	}
	public void setDao(SchedulePlanDao dao) {
		this.dao = dao;
	}
	
}
