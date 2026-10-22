package com.fuao.fajxc.vo;

/**
 * WorkpositionEmployee entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class WorkpositionEmployee implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Workposition workposition;
	private String edittime;
	private Integer	positiontype;
	// Constructors

	/** default constructor */
	public WorkpositionEmployee() {
	}

	/** minimal constructor */
	public WorkpositionEmployee(Employee employee, Workposition workposition) {
		this.employee = employee;
		this.workposition = workposition;
	}

	/** full constructor */
	public WorkpositionEmployee(Employee employee, Workposition workposition,
			String edittime) {
		this.employee = employee;
		this.workposition = workposition;
		this.edittime = edittime;
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

	public Workposition getWorkposition() {
		return this.workposition;
	}

	public void setWorkposition(Workposition workposition) {
		this.workposition = workposition;
	}

	public String getEdittime() {
		return this.edittime;
	}

	public void setEdittime(String edittime) {
		this.edittime = edittime;
	}

	public void setPositiontype(Integer positiontype) {
		this.positiontype = positiontype;
	}

	public Integer getPositiontype() {
		return positiontype;
	}

}