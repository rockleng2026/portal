package com.fuao.fajxc.dao.newproject;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Approverecord;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewWatch;

/*******
 * 审批项目
 * @author Administrator
 *
 */

public interface ApprovalProject extends BaseDao{
	
	// 审批列表
	public List<NewApprove> getApproveList();
	/**
	 * 根据主键加载数据
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getObjById(Class clazz,Integer id);
	
	// 根据审批对象修改审批信息
	public void updateApprove(NewApprove app);
	
	// 添加审批记录
	public void addRecord(Approverecord record);
	
	/***
	 * 根据名称模糊查询
	 */
	public List getProject(String projectname,Employee emp);
	/******
	 * 修改项目状态
	 */
	public void updatePrj(NewProject project);
	
	/*******
	 * 根据项目对象找到所有参与人员　
	 */
	public List cyrByPid(NewProject project);
	
	/****
	 * 保存参与人
	 */
	public void addcyr(NewWatch watch);
	
	/**
	 * 根据id查找员工方法二
	 *@return 
	 */
	public Employee getEmpByEId(int id);

	public void updateApprovemoney(Employee employee);
	
	/**
	 * 添加项目查看者
	 */
	public void addPrjWatcher(NewWatch obj);

	
}

