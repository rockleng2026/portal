package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Income entity. @author MyEclipse Persistence Tools
 */

public class Income implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Timestamp itime;
	private String incomeNo;
	private Integer auditingState;
	private Double allSum;
	private Integer inmark;
	private String remark;
	private Integer delflag;
	private Set incomeInfos = new HashSet(0);
	private Set storageInfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Income() {
	}

	/** full constructor */
	public Income(Employee employee, Timestamp itime, String incomeNo,
			Integer auditingState, Double allSum, Integer inmark,
			String remark, Integer delflag, Set incomeInfos, Set storageInfos) {
		this.employee = employee;
		this.itime = itime;
		this.incomeNo = incomeNo;
		this.auditingState = auditingState;
		this.allSum = allSum;
		this.inmark = inmark;
		this.remark = remark;
		this.delflag = delflag;
		this.incomeInfos = incomeInfos;
		this.storageInfos = storageInfos;
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

	public Timestamp getItime() {
		return this.itime;
	}

	public void setItime(Timestamp itime) {
		this.itime = itime;
	}

	public String getIncomeNo() {
		return this.incomeNo;
	}

	public void setIncomeNo(String incomeNo) {
		this.incomeNo = incomeNo;
	}

	public Integer getAuditingState() {
		return this.auditingState;
	}

	public void setAuditingState(Integer auditingState) {
		this.auditingState = auditingState;
	}

	public Double getAllSum() {
		return this.allSum;
	}

	public void setAllSum(Double allSum) {
		this.allSum = allSum;
	}

	public Integer getInmark() {
		return this.inmark;
	}

	public void setInmark(Integer inmark) {
		this.inmark = inmark;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public Set getIncomeInfos() {
		return this.incomeInfos;
	}

	public void setIncomeInfos(Set incomeInfos) {
		this.incomeInfos = incomeInfos;
	}

	public Set getStorageInfos() {
		return this.storageInfos;
	}

	public void setStorageInfos(Set storageInfos) {
		this.storageInfos = storageInfos;
	}

}