package com.fuao.fajxc.bussiness.schedulePlan;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Scheduleplan;

public interface SchedulePlanBusiness {


	/**
	 * 根据实体名和条件，获取对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String entityName ,String condition);

	/**
	 * 根据id获取单个Schedule对象
	 * @author 阙超强
	 * 2011-11-24 17:54:09
	 */
	public Object getObjectById(int id);
	
	/**
	 * 添加日程计划
	 * @param plan
	 * @return
	 */
	public boolean addSchedulePlan(Scheduleplan plan);
	
	/**
	 * 添加日程计划
	 * @param plan
	 * @return Scheduleplan
	 */
	public Scheduleplan addSchedule(Scheduleplan plan);
	
	/**
	 * 修改日程计划
	 * @param plan
	 * @return
	 */
	public boolean updateSchedulePlan(Scheduleplan plan);
	
	/**
	 * 删除日程计划
	 * @param plan
	 * @return
	 */
	public boolean deleteSchedulePlan(Scheduleplan plan);
	
	/**
	 * 日程计划分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}
