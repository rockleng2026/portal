package com.fuao.fajxc.bussiness.basic;



import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.fuao.fajxc.util.PageBean;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.FieldProperty;
import com.fuao.fajxc.vo.Leavesimple;
import com.fuao.fajxc.vo.UserRelation;
import com.fuao.fajxc.vo.UserRelationtypesb;

public interface EmployeeBussiness {

	/**
	 * 获得员工信息
	 * @return
	 */
	public PageBean selEmp(int pagesize,int page,String addhql);
	/**
	 * 添加员工
	 * @param emp
	 * @return
	 */
	public boolean addemp(Employee emp,List<FieldProperty> listFieldProperty, HttpServletRequest request);
	
	/**
	 * 添加员工
	 * @return Employee员工对象
	 */
	public Employee addReturnEmp(Employee emp,List<FieldProperty> listFieldProperty, HttpServletRequest request);
	
    /**
     * 根据Id查找员工
     * @param id
     * @return
     */
	public Employee oneEmp(int id);
	/**
	 * 更新员工信息
	 * @return
	 */
	public boolean updateEmp(Employee emp, HttpServletRequest request);
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
	 * 根据实体类名查询附表
	 * @param strEntityName 实体类名
	 * @param strHql HQL语句
	 * @return List集合
	 */
	public List getAllRelationfb(String strEntityName, String strHql);
	/**
	 * 查找所有员工
	 */
	public List selEmps(String addhql);
	/**
	 * 查找特殊员工
	 */
	public List<Employee> exHql(String hql);
	/**
	 * 分页查找员工
	 */
	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) ;
	
	// 获得附表类别，根据类别名称
	public UserRelationtypesb getAllByName(String strName);
	 
	
	// 获得user_relation表中的List，根据员工ID  和   附表类别
	public List getAllRelationByUuidAndTypeId(String strUuid, int iTypeId);
	
	public UserRelationtypesb getAllById(int iId);
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
	 * 根据条件和实体名，获取对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String entityName,String condition);
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
	 * 员工人员的绑定　
	 */
	public List setEmp();
	/******
	 * 得到这个员工下所参与的项目
	 */
	public List projectByEid(int empid);
	/*****
	 * 查找员工级别
	 * 
	 */
	public List emplevel();
	/**
	 * 修改员工的级别
	 * @param emplevel
	 * @param strId 
	 * @return
	 */
	public Boolean editempgrade(String emplevel, String strId);
   /**
    * 添加员工业务数据
    */
	public void addOperationDepart(int typeid, int empid, double money,String creatTime,String explain,int temp);
    public List selectObect(String hql);
    public void empworkposit(String empworkposition, String strId);
	/**
	 * 修改员工业务temp=-1
	 */
    public void addOperationEmployee(int typeid,int empid,double money,String creatTime,String explain,int temp);
	/**
	 * 删除员工业务数据
	 */
    public void DelOperationEmployee(int empid,int typeid,int temp);
	public Object updatesql(String sqla);
	public boolean add(String sql);
	public Object addemp(Employee emp);
}
