package com.fuao.fajxc.bussiness.basic;

import java.util.List;
import java.util.Map;

import com.fuao.fajxc.util.PageBean;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;



public interface DepartmentBussiness {

	/**
	 * 获得员工信息
	 * @return
	 */
	public PageBean selDepart(int pagesize,int page,String addhql);

	/**
	 * 查找所有员工
	 * @return
	 */
    public List selEmp();
    
    /**
     * 添加或更新部门信息
     * @param mark 1:添加 2：更新
     * @param dep
     * @return
     */
	public boolean addOrUpdateDepartment(int mark,Department dep);
	
	/**
     * 添加部门信息
     * @author 阙超强 14015
     * @param dep
     * @return Department
     */
	public Department addDepartment(Department dep);
	
	/**
	 * 根据条件查找部门
	 * @return
	 */
	public Department onedep(String addhql);
	
	/**
	 * 删除员工
	 * @return
	 */
	public boolean delEmp(Object[] ids);
	
	/**
	 * 获取全部的部门
	 * @return
	 */
	
	 public List<Department> getalldept(String addhql);
	 /**
		 * 获取全部的部门包含集团董事局
		 * @return
		 */
	 public List<Department> getalldept2(String addhql);
	 /**
	   *获取单个部门信息
	   *@return
	   */
	 public Department getDepartment(String id);
	 
	 /**
		 * 分页查找部门
		 */
	 public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	 
	 /**
		 * 获得部门所有子部门，包括本部门
		 * @param dept 实例化部门对象
		 * @return 部门及子部门id组成的用逗号分隔的字符串 eg1,2,3, 无则返回""
		 */
		public String getSonDepartment(Department dept);
	/**
	 * modifies 2013-05-21 
	 * 获取部门主管
	 * @param dept 部门对象
	 * @return Employee对象 没有主管 返回空对象 
	 */
	public Employee getDeptManager(Department dept);
	/**
	 * modifies 2013-05-21 
	 * 递归获取部门主管 部门主管存在获取当前部门主管 不存在获取父部门主管 如此递归
	 * 如果都不存在 则返回null
	 * @param dept 部门对象
	 * @return Employee对象 没有主管 返回空对象 
	 */
	public Employee getDeptManagerRecursive(Department dept);
	/**
	 * modifies 2013-05-21 
	 * 递归获取部门主管 部门主管存在获取当前部门主管 不存在获取父部门主管 如此递归
	 * 如果都不存在 则返回当前员工对象 
	 * @param emp 员工对象
	 * @return Employee对象 没有主管 则返回当前员工对象 
	 */
	public Employee getDeptManagerRecursive(Employee emp);
}
