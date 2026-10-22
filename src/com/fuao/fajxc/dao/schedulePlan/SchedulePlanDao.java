package com.fuao.fajxc.dao.schedulePlan;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Scheduleplan;

public interface SchedulePlanDao extends BaseDao {

	/**
	 * 根据hql，获取对象列表
	 * @param hql
	 * @return
	 */
	public List ObjectList(String hql);
	/**
	 * 根据hql获取单个对象
	 * @author 阙超强
	 * 2011-11-24 17:52:38
	 */
	public Object getObject(String hql);
	
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
