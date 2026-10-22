package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Workposition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Workposition implements java.io.Serializable {

	// Fields

	private Integer id;
	private Workgrade workgrade;
	private Department department;
	private String name;
	private String shortname;
	private String workcontent;
	private String edittime;
	private Integer ispersonman;//是否主管岗
    private	String parpostionid; 
	private String functionIDs;//菜单集合
	private String permissions;//页面功能 集合
	private Set employees = new HashSet(0);
	private Set workpositionEmployees = new HashSet(0);

	// Constructors

	/** default constructor */
	public Workposition() {
	}

	/** full constructor */
	public Workposition(Workgrade workgrade, Department department,
			String name, String shortname, String workcontent, String edittime,
			Set employees, Set workpositionEmployees) {
		this.workgrade = workgrade;
		this.department = department;
		this.name = name;
		this.shortname = shortname;
		this.workcontent = workcontent;
		this.edittime = edittime;
		this.employees = employees;
		this.workpositionEmployees = workpositionEmployees;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Workgrade getWorkgrade() {
		return this.workgrade;
	}

	public void setWorkgrade(Workgrade workgrade) {
		this.workgrade = workgrade;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getShortname() {
		return this.shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}

	public String getWorkcontent() {
		return this.workcontent;
	}

	public void setWorkcontent(String workcontent) {
		this.workcontent = workcontent;
	}

	public String getEdittime() {
		return this.edittime;
	}

	public void setEdittime(String edittime) {
		this.edittime = edittime;
	}

	public Set getEmployees() {
		return this.employees;
	}

	public void setEmployees(Set employees) {
		this.employees = employees;
	}

	public Set getWorkpositionEmployees() {
		return this.workpositionEmployees;
	}

	public void setWorkpositionEmployees(Set workpositionEmployees) {
		this.workpositionEmployees = workpositionEmployees;
	}

	public String getFunctionIDs() {
		return functionIDs;
	}

	public void setFunctionIDs(String functionIDs) {
		this.functionIDs = functionIDs;
	}

	public String getPermissions() {
		return permissions;
	}

	public void setPermissions(String permissions) {
		this.permissions = permissions;
	}

	public void setParpostionid(String parpostionid) {
		this.parpostionid = parpostionid;
	}

	public String getParpostionid() {
		return parpostionid;
	}

	public void setIspersonman(Integer ispersonman) {
		this.ispersonman = ispersonman;
	}

	public Integer getIspersonman() {
		return ispersonman;
	}

	





}