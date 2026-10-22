package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * CustomerAuditing entity. @author MyEclipse Persistence Tools
 */

public class CustomerAuditing implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Customer customer;
	private String auditcontent;
	private Timestamp auditdate;
	private String isOk;
	private String auditresult;
	private String remark;
	private String delflag;

	// Constructors

	/** default constructor */
	public CustomerAuditing() {
	}

	/** full constructor */
	public CustomerAuditing(Employee employee, Customer customer,
			String auditcontent, Timestamp auditdate, String isOk,
			String auditresult, String remark, String delflag) {
		this.employee = employee;
		this.customer = customer;
		this.auditcontent = auditcontent;
		this.auditdate = auditdate;
		this.isOk = isOk;
		this.auditresult = auditresult;
		this.remark = remark;
		this.delflag = delflag;
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

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getAuditcontent() {
		return this.auditcontent;
	}

	public void setAuditcontent(String auditcontent) {
		this.auditcontent = auditcontent;
	}

	public Timestamp getAuditdate() {
		return this.auditdate;
	}

	public void setAuditdate(Timestamp auditdate) {
		this.auditdate = auditdate;
	}

	public String getIsOk() {
		return this.isOk;
	}

	public void setIsOk(String isOk) {
		this.isOk = isOk;
	}

	public String getAuditresult() {
		return this.auditresult;
	}

	public void setAuditresult(String auditresult) {
		this.auditresult = auditresult;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}