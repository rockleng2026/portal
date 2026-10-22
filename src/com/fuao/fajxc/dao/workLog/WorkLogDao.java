package com.fuao.fajxc.dao.workLog;


import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.WorkLog;

public interface WorkLogDao extends BaseDao{

	/**
	 * 执行sql语句
	 * @author 阙超强 14015
	 * @date 2011-12-23 10:52:52
	 */
	public String executeSql(String sql);
	/****
	 * 根据存sql语句查找到集合
	 */
	public List exeWorksql(String now,String date,int deptid,int empno);
	/******
	 * 根据员工编号得到员工集合
	 */
	public Object getEmp(Class clazz, Integer id); 
	/**
	 * 执行sql语句
	 */
	public String exeDeptSql(String sql);
	
	public List printList(List<Object[]> liss);
	
	public List exeSQLQuery(String sql);
	/******
	 * 根据员工ID得到这个员工今天有没有请假
	 */
	public List getLeavesimpleByEmpid(int empid,String time);
	/******
	 * 根据员工ID得到这个员工这个月的未写日志天数。
	 */
	public List yueQjDate(int empid,int mon);
	
	//修改日志
	public boolean updateWorkLog(String replyContent,int empNo,String date,List workLogID);
	
	/**
	 * 根据ID号得到日志
	 */
	public WorkLog getLogById(int ID);
	
	/**
	 * 根据数组ids来得到相关的worklog
	 */
	public List getByIds(Object[] ids);
	
	/**
	 * 得到的部门
	 */
	public List getDepartment();
	
	/**
	 * 根据组员ID得到组员
	 */
	public List getEmployee(int id);
	
	/**
	 * 
	 * 根据父ID得到它的子ID
	 */
	public List getGroup(int parentID);
	
	/*
	 * 分页Ip管理(查询)
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	/***
	 * 添加日程记事
	 */
	public void addSch(Object sch);
	/******
	 * 添加访问记录
	 */
	public void addRecord(Executerecord record);
	/********
	 * 修改对象
	 */
	public void updateObj(Object obj);
	
}
