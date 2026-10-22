package com.fuao.fajxc.dao.impl.schedulePlan;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.schedulePlan.SchedulePlanDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Scheduleplan;

public class SchedulePlanDaoImpl extends BaseDaoImpl implements SchedulePlanDao {

	private static Logger logger = Logger.getLogger(SchedulePlanDaoImpl.class);
	
	/**
	 * 根据hql，获取对象列表
	 * @param hql
	 * @return
	 */
	public List ObjectList(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	
	/**
	 * 根据hql获取单个对象
	 * @author 阙超强
	 * 2011-11-24 17:52:38
	 */
	public Object getObject(String hql){
		Object object = this.getSession().createQuery(hql).uniqueResult();
		return object;
	}
	
	/**
	 * 添加日程计划
	 * @param plan
	 * @return
	 */
	public boolean addSchedulePlan(Scheduleplan plan)
	{
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(plan);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加日程计划时出错",ex);
		}
		return flag;
	}
	
	/**
	 * 添加日程计划
	 * @param plan
	 * @return Scheduleplan
	 */
	public Scheduleplan addSchedule(Scheduleplan plan)
	{
		Scheduleplan scheduleplan = null;
		try
		{
			scheduleplan = (Scheduleplan) super.getHibernateTemplate().merge(plan);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加日程计划时出错",ex);
		}
		return scheduleplan;
	}
	
	/**
	 * 修改日程计划
	 * @param plan
	 * @return
	 */
	public boolean updateSchedulePlan(Scheduleplan plan)
	{
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(plan);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("修改日程计划时出错",ex);
		}
		return flag;
	}
	
	/**
	 * 删除日程计划
	 * @param plan
	 * @return
	 */
	public boolean deleteSchedulePlan(Scheduleplan plan)
	{
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().delete(plan);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error(" 删除日程计划时出错",ex);
		}
		return flag;
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
		Pages pages=null;
		try
		{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("日程计划分页时出错Dao",ex);
		}
		return pages;
	}
}
