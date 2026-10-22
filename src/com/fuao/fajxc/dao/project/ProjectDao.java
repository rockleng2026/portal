package com.fuao.fajxc.dao.project;

import java.util.List;
import java.util.Map;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Project;
import com.fuao.fajxc.vo.ProjectEmp;
import com.fuao.fajxc.vo.ProjectEmpLead;
import com.fuao.fajxc.vo.ProjectLead;

public interface ProjectDao {

	// 项目管理列表查询
	public Pages getAllPrj(String hql, int pageNo, int pageSize, Object values);
	//　发起项目
	public void savePrj(Project prj);
	// 项目跟进
	public void updatePrj(Project prj);
	// 绑定部门表
	public List<Department> getAllDept();
	// 根据项目编号得到对象
	public Object getPrjById(Class clazz, Integer id); 
	// 根据项目编号得到参与人员
	public List<Map<String, String>> getEmpByPrjid(int prjid); 
	// 添加参与人员信息
	public void savePrjEmp(ProjectEmp prjemp);
	 /******
	 * 根据员工编号获取员工进度条显示
	 */
	public ProjectEmp empPlan(int empid);

	/*****
	 * 根据登录的用户名得到 employee对象
	 */
	public Employee getEmp(String empno);
	//修改员工任务
	public void updateMission(ProjectEmp prjemp);

	
	/***
	 * 根据员工编号与邀请级别得到任务对象
	 */
	public ProjectEmp inviteEmp(int empid);
	/******
	 * 改变邀请状态
	 */
	public void changeIsvite(int prjempid,int isvite);
	// 根据项目编号得到获取员工任务
	public List<ProjectEmp> prjEmp(int prjid);
	// 获取这一周内的所有员工项目进度的动态消息
	public List<ProjectEmp> updatePrjmsg(String zd,int prjid);
	
	/**
	 * 根据当前登陆者empno查询其信息
	 */
	public Employee getEmployeeByEmpNo(String empno);
	public ProjectEmp getProjectEmpByEmpid(Integer empid);	
	public void updateIsvite(ProjectEmp prjemp);
	// 查询当前时间项目详细信息
	public List<ProjectEmp> getProcessByTime(String zd,int prjid,String time);
	// 查询月份的项目详细信息
	public List<ProjectEmp> getProcessByYue(String zd,int prjid,String yue);
	// 查询今年的项目详细信息
	public List<ProjectEmp> getProcessByYear(String zd,int prjid);
	//查询领导最新动态信息
	public List getLeadMsg(String zd);
	// 添加人员领导信息表数据
	public void addEmpLead(ProjectEmpLead emplead);
	//得到所有部门
	public List<Department> getAllDept(String hql);
	// 领导跟进项目
	public void leadGj(ProjectLead prjlead);
	// 根据员工任务编号得到其对应的领导评价
	public List<ProjectEmpLead> leadPJByEmpid(int prjempid);
	// 根据项目编号得到其对应的领导评价
	public List<ProjectLead> leadPJByPrjid(int prjid);
	// 根据员工编号与项目编号得到员工的具体任务
	public List<ProjectEmp> proempByPidAndEid(int empid,int prjid);
	// 根据员工编号与项目编号得到员工的具体任务，当天的时间
	public List<ProjectEmp> proempByTime(int empid,int prjid,String time);
	// 我的地盘查询月份的详细信息
	public List<ProjectEmp> myProcessByYue(int empid,int prjid,String yue);
	// 查询今年的项目详细信息
	public List<ProjectEmp> getmyProcessByYear(int empid,int prjid);
	// 根据部门编号得到部门信息
	public Department getdeptById(int deptid);	
	
	
	
	//根据项目负责人查询其信息
	public Project getPrjByManager(String manager);
	//根据领导查询其信息
	public Project getPrjByLeadname(String leadname);
	//根据项目发起人查询其信息
	public Project getPrjByStartperson(String startpersonname);
}
