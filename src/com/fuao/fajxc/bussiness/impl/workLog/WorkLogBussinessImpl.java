package com.fuao.fajxc.bussiness.impl.workLog;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.action.workLog.WorklogAction;
import com.fuao.fajxc.bussiness.workLog.WorkLogBussiness;
import com.fuao.fajxc.dao.stockpile.IncomeDao;
import com.fuao.fajxc.dao.workLog.WorkLogDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.WorkLog;

/**
 * 
 * @author 阙超强 14015
 * @time 2012-1-6 17:14:02
 *
 */
public class WorkLogBussinessImpl implements WorkLogBussiness{

	//注入dao层
	private WorkLogDao workLogDao;

	/**
	 * 添加日志 
	 * @param workLog
	 * @return WorkLog对象
	 */
	public WorkLog addReturn(WorkLog workLog){
		Object object = workLogDao.addReturnObject(workLog);
		if(null != object){
			return (WorkLog) object;
		}
		return null;
	}

	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exeHqlPages(String hql,int pageNo,int pageSize,Object... values){
		return workLogDao.paginationQuery(hql, pageNo, pageSize, values);
	}
	
	/**
	 * 根据单个标识查询对象
	 * @param id 单个对象的唯一标识
	 * @return Object 执行后返回的对象
	 */
	public WorkLog getById(int id) {
		try {
			return  (WorkLog) workLogDao.select(WorkLog.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加批注
	 * 
	 * @return
	 */
	public boolean addReply(WorkLog workLog){
		try {
			workLogDao.update(workLog);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/**
	 * 执行HQL语句
	 * @return
	 */
	public List exeHql(String hql){
		return workLogDao.execHQL(hql);
	}
	
	/**
	 * 执行HQL语句
	 * @return
	 */
	public List selectHql(String hql){
		return workLogDao.execHQL(hql);
	}

	/**
	 * 执行SQL语句
	 * @return
	 */
	public String executeSql(String sql){
		return workLogDao.executeSql(sql);
	}
	/****
	 * 根据存sql语句查找到集合
	 */
	public List exeWorksql(String now,String date,int deptid,int empno){
		return workLogDao.exeWorksql(now,date,deptid,empno);
	}
	/******
	 * 根据员工编号得到员工集合
	 */
	public Object getEmp(Class clazz, Integer id){
		return workLogDao.getEmp(clazz, id);
	}
	/**
	 * 执行sql语句
	 */
	public String exeDeptSql(String sql){
		return workLogDao.exeDeptSql(sql);
	}
	public List printList(List<Object[]> liss){
		return workLogDao.printList(liss);
	}
	
	public WorkLogDao getWorkLogDao() {
		return workLogDao;
	}

	public void setWorkLogDao(WorkLogDao workLogDao) {
		this.workLogDao = workLogDao;
	}
	
	public List exeSQLQuery(String sql){
		return workLogDao.exeSQLQuery(sql);
	}
	/******
	 * 根据员工ID得到这个员工今天有没有请假
	 */
	public List getLeavesimpleByEmpid(int empid,String time){
		return this.workLogDao.getLeavesimpleByEmpid(empid,time);
	}
	/******
	 * 根据员工ID得到这个员工这个月的未写日志天数。
	 */
	public List yueQjDate(int empid,int mon){
		return this.workLogDao.yueQjDate(empid,mon);
	}
	
	public boolean updateWorkLog(String replyContent,int empNo,String date,List workLogID) 
	{
		return this.workLogDao.updateWorkLog(replyContent.trim(), empNo, date, workLogID);
	}
	
	public WorkLog getLogById(int ID)
	{
		return workLogDao.getLogById(ID);
	}

	public List getByIds(Object[] ids)
	{
		return this.workLogDao.getByIds(ids);
	}

	public List getDepartment()
	{
		
		return workLogDao.getDepartment();
	}

	public List getEmployee(int id) 
	{
		
		return workLogDao.getEmployee(id);
	}

	public List getDepartmentIDs(int parentID) {
		return workLogDao.getGroup(parentID);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		return workLogDao.exHqlPages(hql, pageNo, pageSize, values);
	}
	
	/***
	 * 添加日程记事
	 */
	public void addSch(Object sch){
		workLogDao.addSch(sch);
	}
	/******
	 * 添加访问记录
	 */
	public void addRecord(Executerecord record){
		workLogDao.addRecord(record);
	}
	
	/********
	 * 修改对象
	 */
	public void updateObj(Object obj){
		workLogDao.updateObj(obj);
	}
	
}
