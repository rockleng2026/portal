package com.fuao.fajxc.dao.basic;

import java.util.List;


import org.hibernate.Query;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Leavesimple;
import com.fuao.fajxc.vo.UserRelation;
import com.fuao.fajxc.vo.UserRelationtypesb;

public interface EmployeeDao extends BaseDao {
	
	/**
	 * 获得员工信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List selEmp(int first,int max,String addhql);
	/**
	 * 获得总的员工数
	 * @return
	 */
	public int selCount(String addhql);
	/**
	 * 添加员工
	 * @return 
	 */
	public boolean addEmp(Employee emp);
	
	/**
	 * 根据Id查找员工
	 * @return
	 */
	public Employee oneEmp(int id);
	/**
	 * 更新员工信息
	 * @return
	 */
	public boolean updateEmp(Employee emp);
	/**
	 * 删除员工
	 * @return
	 */
	public boolean delEmp(Object[] ids);
	/**
	 * 查找所有部门
	 * @return
	 */
	public List selDep(String hql);
	/**
	 * 查找所有员工
	 */
	public List selEmps(String hql);
  
	/*
	   * 查找特殊员工
	   */
	public List<Employee>  exHql(String hql);
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values);
	/**
	 * 删除用户
	 * @return
	 */
	public boolean delUser(Object[] ids);
	

	// 获得附表类别，根据类别名称
	public UserRelationtypesb getAllByName(String strName);
	
	public UserRelationtypesb getAllById(int iId);
	 
	
	// 获得user_relation表中的List，根据员工ID  和   附表类别
	public List getAllRelationByUuidAndTypeId(String strUuid, int iTypeId);
	
	/**
	 * 根据条件和实体名，获取对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String hql);
	/**
	 * 根据员工身份证号码查询员工信息
	 * @param strEmpIdentity
	 * @return
	 */
	public Employee getEmployeeByEmpIdentity(String strEmpIdentity);
	/**
	 * 根据员工工号查询员工对象
	 * @param strEmpNo
	 * @return
	 */
	public Employee getEmployeeByEmpNo(String strEmpNo);
	/**
	 * 删除UserRelation表
	 * 批量删除 根据ID集合
	 * @return
	 */
	public int delUserRelationByIds(String strBean, String strIds);
	/**
	 * 添加家庭成员
	 * @param userRelation
	 * @return 
	 */
	public int addUserRelation(UserRelation userRelation);
	/**
	 * 删除附件
	 * @param strUuid
	 * @return
	 */
	public int deleteFjById(int id);
	/***
	 * 员工离职
	 */
	public void emplz(int empid,String leavereason,String leavetime);
	/***
	 * 根据员工编号查询客户
	 */
	public List<Customer> customerByEid(int empid,String customerType);
	/******
	 * 客户移交负责人
	 */
	public void yjCustomer(int empid,int customerid);
	/******
	 * 根据客户编号得到客户信息
	 */
	public Object getCustomer(Class clazz, Integer id);
	/*****
	 * 添加任务移交记录
	 */
	public void saveYJ(CustomerMove cusmove);
	/********
	 * 查看移交记录
	 */
	public List<CustomerMove> customerJL(int cid);
	/******
	 * 添加请假单
	 */
	public void addLeavesimple(Leavesimple leave);
	/******
	 * 根据员工ID得到这个员工今天有没有请假
	 */
	public List getLeavesimpleByEmpid(int empid);
	/******
	 * 得到这个员工下所参与的项目
	 */
	public List projectByEid(int empid);
	/******
	 * 得到员工级别
	 */
	public List emplevel();
	
	public Boolean emplevel(String emplevel, String strid);
	/**
	 * 添加员工业务数据
	 */
	public void addOperationDeparts(int typeid, int empid, double money,
			String creatTime, String explain,int temp);
	/**
	 * 修改员工业务数据--temp=-1
	 * 
	 */
	public void addOperationEmployee(int id,int empid,double money,String creatTime,String explains,int temp);
	/**
	 * 删除员工业务数据
	 * @param empid
	 * @param typeid
	 * @param temp
	 */
	public void DelOperationEmployee(int empid, int typeid, int temp);
	public Object updatesql(String sqla);
	public boolean adda(String sql);
	public Object empDao(Employee emp);
}
