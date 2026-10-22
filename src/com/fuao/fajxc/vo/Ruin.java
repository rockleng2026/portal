package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Ruin entity. @author MyEclipse Persistence Tools
 */

public class Ruin implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private String ruinNo;
	private Integer profitOrLoss;
	private Timestamp rtime;
	private Double sum;
	private Integer auditing;
	private Integer delflag;
	private String remark;
	private Set ruinInfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Ruin() {
	}

	/** full constructor */
	public Ruin(Employee employee, String ruinNo, Integer profitOrLoss,
			Timestamp rtime, Double sum, Integer auditing, Integer delflag,
			String remark, Set ruinInfos) {
		this.employee = employee;
		this.ruinNo = ruinNo;
		this.profitOrLoss = profitOrLoss;
		this.rtime = rtime;
		this.sum = sum;
		this.auditing = auditing;
		this.delflag = delflag;
		this.remark = remark;
		this.ruinInfos = ruinInfos;
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

	public String getRuinNo() {
		return this.ruinNo;
	}

	public void setRuinNo(String ruinNo) {
		this.ruinNo = ruinNo;
	}

	public Integer getProfitOrLoss() {
		return this.profitOrLoss;
	}

	public void setProfitOrLoss(Integer profitOrLoss) {
		this.profitOrLoss = profitOrLoss;
	}

	public Timestamp getRtime() {
		return this.rtime;
	}

	public void setRtime(Timestamp rtime) {
		this.rtime = rtime;
	}

	public Double getSum() {
		return this.sum;
	}

	public void setSum(Double sum) {
		this.sum = sum;
	}

	public Integer getAuditing() {
		return this.auditing;
	}

	public void setAuditing(Integer auditing) {
		this.auditing = auditing;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set getRuinInfos() {
		return this.ruinInfos;
	}

	public void setRuinInfos(Set ruinInfos) {
		this.ruinInfos = ruinInfos;
	}

}