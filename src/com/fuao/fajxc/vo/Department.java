package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.management.loading.PrivateClassLoader;

/**
 * Department entity. @author MyEclipse Persistence Tools
 */

public class Department implements java.io.Serializable {

	// Fields

	private Integer id;  //主键
	private Employee employee; 
	private String name; //部门名称
	private Timestamp time; //时间戳
	private Integer delflag;
	private String tel; //电话
	private String depNo; 
	private String orderNo;
	private Integer parentId;
	private String filialemark;
	private String fiiale;
	private Integer islevel;
	private Integer squnum;
	private Integer isbj;
	private Integer directorId;
	
	private DepartmentGrade deptgrade;
	
	private Set verifyOrderEmployees = new HashSet(0);
	private Set auditingOrderTabs = new HashSet(0);
	private Set returnOrders = new HashSet(0);
	private Set toOrders = new HashSet(0);
	private Set employees = new HashSet(0);
	private Set conkouts = new HashSet(0);
	private Set empassess = new HashSet(0);
	private Set admin = new HashSet(0);
	private List<Department> child = new ArrayList<Department>();
	//项目管理参与部门
	//private Set<NewPrjdept> prjdept = new HashSet<NewPrjdept>();
	/** default constructor */
	public Department() {
	}

	/** minimal constructor */
	public Department(String name) {
		this.name = name;
	}

	/** full constructor */
	public Department(Employee employee, String name, Timestamp time,
			Integer delflag, String tel, String depNo,
			Set verifyOrderEmployees, Set auditingOrderTabs, Set returnOrders,
			Set toOrders, Set employees,Set admin,Integer parentId,Set conkouts,String filialemark, Integer squnum,Integer id) {
		this.employee = employee;
		this.name = name;
		this.time = time;
		this.delflag = delflag;
		this.tel = tel;
		this.depNo = depNo;
		this.filialemark=filialemark;
		this.verifyOrderEmployees = verifyOrderEmployees;
		this.auditingOrderTabs = auditingOrderTabs;
		this.returnOrders = returnOrders;
		this.toOrders = toOrders;
		this.employees = employees;
		this.parentId=parentId;
		this.conkouts=conkouts;
		this.admin=admin;
		this.id=id;
		this.squnum=squnum;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}



	public String getDepNo() {
		return this.depNo;
	}

	public void setDepNo(String depNo) {
		this.depNo = depNo;
	}

	public Set getVerifyOrderEmployees() {
		return this.verifyOrderEmployees;
	}

	public void setVerifyOrderEmployees(Set verifyOrderEmployees) {
		this.verifyOrderEmployees = verifyOrderEmployees;
	}

	public Set getAuditingOrderTabs() {
		return this.auditingOrderTabs;
	}

	public void setAuditingOrderTabs(Set auditingOrderTabs) {
		this.auditingOrderTabs = auditingOrderTabs;
	}

	public Set getReturnOrders() {
		return this.returnOrders;
	}

	public void setReturnOrders(Set returnOrders) {
		this.returnOrders = returnOrders;
	}

	public Set getToOrders() {
		return this.toOrders;
	}

	public void setToOrders(Set toOrders) {
		this.toOrders = toOrders;
	}

	public Set getEmployees() {
		return this.employees;
	}

	public void setEmployees(Set employees) {
		this.employees = employees;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Set getConkouts() {
		return conkouts;
	}

	public void setConkouts(Set conkouts) {
		this.conkouts = conkouts;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Set getEmpassess() {
		return empassess;
	}

	public void setEmpassess(Set empassess) {
		this.empassess = empassess;
	}

	public List<Department> getChild() {
		return child;
	}

	public void setChild(List<Department> child) {
		this.child = child;
	}

	public String getFilialemark() {
		return filialemark;
	}

	public void setFilialemark(String filialemark) {
		this.filialemark = filialemark;
	}

	public String getFiiale() {
		return fiiale;
	}

	public void setFiiale(String fiiale) {
		this.fiiale = fiiale;
	}

	public Set getAdmin() {
		return admin;
	}

	public void setAdmin(Set admin) {
		this.admin = admin;
	}
//	public Set<NewPrjdept> getPrjdept() {
//		return prjdept;
//	}
//	public void setPrjdept(Set<NewPrjdept> prjdept) {
//		this.prjdept = prjdept;
//	}
	public Integer getIslevel() {
		return islevel;
	}

	public void setIslevel(Integer islevel) {
		this.islevel = islevel;
	}

	public void setSqunum(Integer squnum) {
		this.squnum = squnum;
	}

	public Integer getSqunum() {
		return squnum;
	}

	public void setIsbj(Integer isbj) {
		this.isbj = isbj;
	}

	public Integer getIsbj() {
		return isbj;
	}

	public DepartmentGrade getDeptgrade() {
		return deptgrade;
	}

	public void setDeptgrade(DepartmentGrade deptgrade) {
		this.deptgrade = deptgrade;
	}



	
}