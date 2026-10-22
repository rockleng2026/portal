package com.fuao.fajxc.dao.mission;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewTask;

public interface MissionDao extends BaseDao{


	/*
	 * 添加任务
	 */
	public boolean addData(Object data)throws Exception;
	
	/*
	 * 添加任务 返回对象
	 */
	public Object addReturn(Object data)throws Exception;
	/*
	 *修改 客户基本资料
	 */
	public boolean updateData(Mission data)throws Exception ;
	
	
	public Mission getMissiondata(String id);
	/*
	 *特殊查询客户基本资料
	 */
	public List<Object>  exHql(String hql);
	
	/*
	 *执行分页查询客户基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查询
	 * @param hql
	 * @return
	 */
	public List getObjectList(String hql );
	/**
	 * 删除信息
	 * @return
	 */
	public boolean delmission(Object[] ids);
	
	/**
	 * 读取信息
	 * @return
	 */
	public boolean duqumission(Object[] duqu);
	
	/**
	 * 删除信息Mission
	 * @return
	 */
	public boolean delsendmes(Object[] ids);
	
	/**
	 * 删除消息类型
	 * @param ids
	 * @return
	 */
	public boolean delmesstype(Object[] ids);
	/**
	 * 执行更新
	 * @param hql
	 * @return 受影响的条数
	 */
	public int exehqlupdate(String hql) ;
	
	/******
	 * 根据当前登录人去得到项目负责人
	 */
	public List projectlist(Employee emp);
	/**********
	 * 根据编号得到对象
	 */
	public Object getObj(Class cla,int id);
	/********
	 * 添加项目任务
	 */
	public void addproject(NewFunction function);
	/******
	 *  得到所有员工列表
	 */
	public List allEmp();
	/**********
	 * 给任务分配参与人员
	 */
	public void addtask(NewTask task);
	/****************
	 * 根据项目编号得到这个项目下面的所有参与人员
	 */
	public List functionByPid(int pid);
	/*********
	 * 修改我们的项目功能任务
	 */
	public void updateNewFunction(NewFunction function);
	/*******
	 * 查询类型
	 */
	public List alltype();
	
	/****************
	 * 根据项目编号得到这个项目下面的所有任务
	 */
	public List funByPid(int pid);
	
}
