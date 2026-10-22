package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * IntentFollowUp entity. @author MyEclipse Persistence Tools
 */

public class IntentFollowUp implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Customer customer;
	private Timestamp date;
	private String detail;
	private String del;
	private String followtype;
	// Constructors

	/** default constructor */
	public IntentFollowUp() {
	}

	/** minimal constructor */
	public IntentFollowUp(Customer customer) {
		this.customer = customer;
	}

	/** full constructor */
	public IntentFollowUp(Employee employee, Customer customer, Timestamp date,
			String detail, String del) {
		this.employee = employee;
		this.customer = customer;
		this.date = date;
		this.detail = detail;
		this.del = del;
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

	public Timestamp getDate() {
		return this.date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public void setFollowtype(String followtype) {
		this.followtype = followtype;
	}

	public String getFollowtype() {
		return followtype;
	}

}