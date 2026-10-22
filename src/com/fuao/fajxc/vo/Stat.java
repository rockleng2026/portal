package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Stat entity. @author MyEclipse Persistence Tools
 */

public class Stat implements java.io.Serializable {

	// Fields

	private Integer id;
	private Depot depot;
	private Employee employee;
	private String statType;
	private Timestamp statTime;
	private String remark;
	private String delflag;
	private String statNo;
	private String auditingState;
	private Set statInfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Stat() {
	}

	/** full constructor */
	public Stat(Depot depot, Employee employee, String statType,
			Timestamp statTime, String remark, String delflag, String statNo,
			Set statInfos,String auditingState) {
		this.depot = depot;
		this.employee = employee;
		this.statType = statType;
		this.statTime = statTime;
		this.remark = remark;
		this.delflag = delflag;
		this.statNo = statNo;
		this.statInfos = statInfos;
		this.auditingState=auditingState;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public String getAuditingState() {
		return auditingState;
	}

	public void setAuditingState(String auditingState) {
		this.auditingState = auditingState;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Depot getDepot() {
		return this.depot;
	}

	public void setDepot(Depot depot) {
		this.depot = depot;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getStatType() {
		return this.statType;
	}

	public void setStatType(String statType) {
		this.statType = statType;
	}

	public Timestamp getStatTime() {
		return this.statTime;
	}

	public void setStatTime(Timestamp statTime) {
		this.statTime = statTime;
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

	public String getStatNo() {
		return this.statNo;
	}

	public void setStatNo(String statNo) {
		this.statNo = statNo;
	}

	public Set getStatInfos() {
		return this.statInfos;
	}

	public void setStatInfos(Set statInfos) {
		this.statInfos = statInfos;
	}

}