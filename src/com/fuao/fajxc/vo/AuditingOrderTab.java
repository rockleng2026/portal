package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * Auditingordertab entity. @author MyEclipse Persistence Tools
 */

public class AuditingOrderTab implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employeeByInceptemp;
	private Employee employeeByEmpId;
	private Department department;
	private VerifyOrder verifyOrder;
	private String orderNo;
	private Timestamp auditingtime;
	private Integer auditingFlag;
	private Integer auditingOrder;
	private Integer handlestate;
	private String employees;
	private String tmp;
	private String sbh;
	private String mark;
	private Timestamp incepttime;
	private Double grade;  //上级评分
	private String rvid;//资源核实单编号
	private String empOrdept;// 标识部门审核还是员工审核。
	private Double price;
    private Integer deldate;
	// Constructors

	

	/** default constructor */
	public AuditingOrderTab() {
	}

	public Integer getDeldate() {
		return deldate;
	}

	public void setDeldate(Integer deldate) {
		this.deldate = deldate;
	}

	public Double getGrade() {
		return grade;
	}

	public void setGrade(Double grade) {
		this.grade = grade;
	}

	/** full constructor */
	public AuditingOrderTab(Employee employeeByInceptemp,
			Employee employeeByEmpId, Department department, String orderNo,
			Timestamp auditingtime, Integer auditingFlag,
			Integer auditingOrder,  Integer handlestate,
			String employees, String tmp, Timestamp incepttime,String sbh,String mark,String rvid) {
		this.employeeByInceptemp = employeeByInceptemp;
		this.employeeByEmpId = employeeByEmpId;
		this.department = department;
		this.orderNo = orderNo;
		this.auditingtime = auditingtime;
		this.auditingFlag = auditingFlag;
		this.auditingOrder = auditingOrder;
		this.handlestate = handlestate;
		this.employees = employees;
		this.tmp = tmp;
		this.incepttime = incepttime;
		this.sbh=sbh;
		this.mark = mark;
		this.rvid = rvid;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployeeByInceptemp() {
		return this.employeeByInceptemp;
	}

	public void setEmployeeByInceptemp(Employee employeeByInceptemp) {
		this.employeeByInceptemp = employeeByInceptemp;
	}

	public Employee getEmployeeByEmpId() {
		return this.employeeByEmpId;
	}

	public void setEmployeeByEmpId(Employee employeeByEmpId) {
		this.employeeByEmpId = employeeByEmpId;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getOrderNo() {
		return this.orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Timestamp getAuditingtime() {
		return this.auditingtime;
	}

	public void setAuditingtime(Timestamp auditingtime) {
		this.auditingtime = auditingtime;
	}

	public Integer getAuditingFlag() {
		return this.auditingFlag;
	}

	public void setAuditingFlag(Integer auditingFlag) {
		this.auditingFlag = auditingFlag;
	}

	public Integer getAuditingOrder() {
		return this.auditingOrder;
	}

	public void setAuditingOrder(Integer auditingOrder) {
		this.auditingOrder = auditingOrder;
	}



	public Integer getHandlestate() {
		return this.handlestate;
	}

	public void setHandlestate(Integer handlestate) {
		this.handlestate = handlestate;
	}

	public String getEmployees() {
		return this.employees;
	}

	public void setEmployees(String employees) {
		this.employees = employees;
	}

	public String getTmp() {
		return this.tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

	public Timestamp getIncepttime() {
		return this.incepttime;
	}

	public void setIncepttime(Timestamp incepttime) {
		this.incepttime = incepttime;
	}

	public VerifyOrder getVerifyOrder() {
		return verifyOrder;
	}

	public void setVerifyOrder(VerifyOrder verifyOrder) {
		this.verifyOrder = verifyOrder;
	}

	public String getSbh() {
		return sbh;
	}

	public void setSbh(String sbh) {
		this.sbh = sbh;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getRvid() {
		return rvid;
	}

	public void setRvid(String rvid) {
		this.rvid = rvid;
	}

	public String getEmpOrdept() {
		return empOrdept;
	}

	public void setEmpOrdept(String empOrdept) {
		this.empOrdept = empOrdept;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	

}