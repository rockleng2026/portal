package com.fuao.fajxc.dao.newproject;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewFunctionRecord;
import com.fuao.fajxc.vo.NewPrjtresource;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.Taskplan_saleorder;

/*******
 * 项目任务列表与任务分配
 * @author Administrator
 * 
 */

public interface TaskProject extends BaseDao {
	
	// 分配任务
	public  List prjtask(int pid);

	public List projectlist(int empid);
	
	// 得到所有项目
	public List getProject(int empid);
	
	/**
	 * 根据主键加载数据
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getObj(Class clazz,Integer id);
	/********
	 * 根据任务的执行时间与执行人与任务Id去查询这个人用没有日志
	 */
	public List logByTask(NewTask newtask);
	/****
	 * 通过功能ID得到这个功能下当前登录人的任务日志
	 */
	public NewTask functionByLog(Scheduleplan schel);
	/********
	 * 添加保存附件
	 */
	public void add(NewTask task);
	/******
	 * 根据任务ID 得到功能对象 ID
	 */
	public int getFun(int taskid);
	/********
	 * 保存日志
	 */
	public void addLog(Scheduleplan schel);
	/******
	 * 根据当前登录人去得到项目负责人
	 */
	public List projectlist(Employee emp);
	/****
	 * 根据任务功能编号得到这个任务下面的所有参与人员
	 */
	public List taskemp(int fid);
	/******
	 *  得到所有员工列表
	 */
	public List allEmp();
	/*****
	 * 根据执行与功能编号得到任务对象
	 */
	public NewTask getNewTask(int empid,int fid);
	/****
	 * 保存newtask对象
	 */
	public void addNewTas(NewTask task);
	/******
	 * 删除对象
	 */
	public void delTas(int empid,int fid);
	
	/****
	 *  保存任务记录
	 */
	public void addRecord(NewFunctionRecord record);
	/******
	 * 删除任务
	 */
	public void del(int fid);
	/*******
	 * 根据项目编号得到参与人
	 */
	public List cyrByPid(int pid);
	
	/******
	 * 根据功能编号得到这个功能下任务总进度，办理后的
	 */
	public double jdByFid(NewFunction function);
	
	/*****
	 * 项目进度的添加
	 */
	public void jdByPid(NewFunction function);
	
	/**
	 * 查询所有订单类型  袁天龙 2012-11-29
	 * @return
	 */
	public List getDomark();
	
	/**
	 * 向项目任务和订单的中间表写数据
	 */
	public void addPlan_Order(String sql);
	
	
	/**
	 * 取到所有订单类型
	 * 袁天龙 2012-12-3
	 */
	public List getDocmark();
	
	/*******
	 * 给任务审批与项目消费记录表添加数据。
	 * 胡宝林 2012-12-4
	 */
	public void addPrjresource(NewPrjtresource resource);
	
	/*******
	 * 修改记录
	 * 胡宝林 2012-12-5
	 */
	public void updateResource(NewPrjtresource resource);
	
	/******
	 * 根据项目负责人的名字得到员工对象
	 */
	public Employee getLauncher(String launcher);
	
	/******
	 * 移交记录根据任务ID修改消费记录
	 */
	public void updateSource(NewPrjtresource resource);
	/*********
	 * 修改task_saleorder表的状态
	 */
	public void updateTaskSaleorder(Taskplan_saleorder tso);

	
	public List getDepartment(String hql);
	
	//根据项目id去查询这个项目的参与部门
	public List getPrjdeptByPid(int pid);
	

	/***********
	 * 根据任务编号与执行人得到具体的任务 
	 */
	public List taskByFidAndExecute(int fid,int empid);
	/********
	 * 修改功能模块时间
	 */
	public void updateFunEndtime(NewFunction function);
	
	/***********
	 * 修改父类任务
	 */
	public void updateParentTask(int fid,Employee oldemp,Employee newemp);

}
