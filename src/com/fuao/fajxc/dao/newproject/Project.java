package com.fuao.fajxc.dao.newproject;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.NewDocument;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewPrjdept;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewWatch;

/*******
 * 项目列表。
 * @author Administrator
 * 
 */

public interface Project extends BaseDao {
	
	// 我的项目。这方法只是测试我做的，自己要用到的时候可以改。
	public List myproject(int empid);
	/**
	 * 项目列表
	 * @param hql
	 * @return
	 */
	public List getAllProjects(String hql);
	
	/**
	 * 所有部门
	 */
	public List<Department> getAllDepts(String hql);
	/**
	 * 所有员工
	 */
	public List<Employee> getAllEmps(String hql);
	/**
	 * 立项
	 */
	public void addProject(Object obj);
	/**
	 * 添加参与部门
	 */
	public void addPrjdept(NewPrjdept obj);
	/**
	 * 添加项目查看者
	 */
	public void addPrjWatcher(NewWatch obj);
	/**
	 * 添加附件
	 */
	public void addFj(Object obj);
	/**
	 * 加载项目类别
	 */
	public List getPrjType(String hql);
	/**
	 * 添加参与人员
	 */
	public void addCyr(NewParticipator p);
	/**
	 * 加载审批人
	 */
	public List getPrjApprover(String hql);
	/**
	 * 删除
	 * @param obj
	 */
	public void delete(Object obj);
	/**
	 * 删除项目(假删除)
	 * @param project
	 */
	public void delproject(Integer id);
	/**
	 * 修改
	 * @param obj
	 */
	public void updateObj(Object obj);
	/**
	 * 根据ID查询对象
	 * @param id
	 * @return
	 */
	public Object getObjectById(Class clazz,Integer id);
	/**
	 * 根据项目ID查询项目的参与部门
	 * @param hql
	 * @return
	 */
	public List getPrjdept(int pid);

	/**
	 * 根据项目名称查询项目的id
	 * @param hql
	 * @return
	 */
	/**
	 * 根据项目ID查询查看者
	 */
	public List getPrjwatch(int pid);
	public void updateProject(NewPrjdept dept);
	/**
	 * 根据项目ID查询参与人
	 * @param pid
	 * @return
	 */
	public List getCyr(int pid);
	/**
	 * 删除参与部门
	 */
	public void deletePrjdept(Integer pid);
	/**
	 * 删除查看者
	 */
	public void deletePrjwatch(Integer pid);
	/**
	 * 删除参与人
	 * @param pid
	 */
	public void deleteCyr(int pid);
	/**
	 * 根据员工编号查询员工对象
	 * @param empNo
	 * @return
	 */
	public Employee getEmployeeByEmpNo(String empNo);
	/**
	 * 根据项目ID查询审批表
	 * @param pid
	 * @return
	 */
	public List getApproveByPid(int pid);
	
	/**
	 * 根据员工ID查询属于他的消息
	 * @param empid
	 * @return
	 */
	public List getMessagereceiver(String empid);
	/**
	 * 点击查看,显示属于这个员工消息详情,供员工办理
	 * @param sql
	 * @return
	 */
	public List empOfMessage(String empid);
	
	/**
	 * 根据员工ID和项目ID得到参与人记录
	 * @param empid
	 * @param pid
	 * @return
	 */
	public List getNewParticipatorByEmpidAndPid(int empid,int pid);
	
	/**
	 * 根据项目ID得到接收信息
	 * @param pid
	 * @return
	 */
	public List getMessreceiverByPid(String receiver,int pid);
	/********
	 * 根据审批人与项目编号
	 */
	public NewApprove appByPid(int pid,int empid);
	
	/**
	 * 项目变更,只能邀请新的参与人,原来的参与人不显示在层里
	 * @param pid
	 * @return
	 */
	public List getParticipatorByPid(int pid);
	
	/**
	 * 添加项目
	 * @param project
	 */
	public void add(NewProject project);
	
	/**
	 * 根据项目ID查询查看人
	 * @param pid
	 * @return
	 */
	public List getWatcherByPid(int pid);
	
	public List getWatch(String hql);
	public List getPar(String hql);
	
	/**
	 * 修改项目时,上传附件,先删除
	 */
	public void deleteDocument(int pid);
	
	/**
	 * 权限设置1,判断登陆人是否是参与人
	 * @param pid
	 * @param empid
	 * @return
	 */
	public List getNpByPidAndEmpid(int pid,int empid);
	
	/**
	 * 权限设置2,判断登陆人是否是项目查看者
	 * @param pid
	 * @param empid
	 * @return
	 */
	public List getWaByPidAndEmpid(int pid,int empid);
	
	/**
	 * 立项
	 */
	public int lx(NewProject project);
	
	/*********
	 * 添加附件
	 */
	public void addFj(NewDocument document);
	
	/**
	 * 添加附件2--
	 * @param fbsbh
	 * @param beanName
	 * @param request
	 * @return
	 */
	public void addFJ2(String fjlj,String beanName,String fjmc,String fjhz, String prid);
		
	// 项目下面的所有任务列表
	public  List prjtask(int pid);
	/****
	 * 根据项目ID查询这个项目下的功能并返回的是当前登录人执行的任务列表
	 */
	public List taskByFid(int fid);
	
	public List getDepartmentByEmp(int eid);
	
	public List getEmpByDept(int did);
}
