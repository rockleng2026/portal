package com.fuao.fajxc.vo;

/**
 * Sendmessage entity. @author MyEclipse Persistence Tools
 */

public class Sendmessage implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private String sendtable;
	private Integer sendtableId;
	private Integer state;

	// Constructors

	/** default constructor */
	public Sendmessage() {
	}

	/** full constructor */
	public Sendmessage(Employee employee, String sendtable, Integer sendtableId,
			Integer state) {
		this.employee = employee;
		this.sendtable = sendtable;
		this.sendtableId = sendtableId;
		this.state = state;
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

	

	public String getSendtable() {
		return sendtable;
	}

	public void setSendtable(String sendtable) {
		this.sendtable = sendtable;
	}

	

	public Integer getSendtableId() {
		return sendtableId;
	}

	public void setSendtableId(Integer sendtableId) {
		this.sendtableId = sendtableId;
	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}