package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * ApplyBuy entity. @author MyEclipse Persistence Tools
 */

public class ApplyBuy implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employeeByApproveEmp;
	private Employee employeeByEmployeeId;
	private String time;
	private String approve;
	private String delflag;
	private String applyBuy;
	private String approveTime;
	private String remark;
	private Set applyBuyinfos = new HashSet(0);
	private Set purOrders = new HashSet(0);

	// Constructors

	/** default constructor */
	public ApplyBuy() {
	}

	/** full constructor */
	public ApplyBuy(Employee employeeByApproveEmp,
			Employee employeeByEmployeeId, String time, String approve,
			String delflag, String applyBuy, String approveTime, String remark,
			Set applyBuyinfos, Set purOrders) {
		this.employeeByApproveEmp = employeeByApproveEmp;
		this.employeeByEmployeeId = employeeByEmployeeId;
		this.time = time;
		this.approve = approve;
		this.delflag = delflag;
		this.applyBuy = applyBuy;
		this.approveTime = approveTime;
		this.remark = remark;
		this.applyBuyinfos = applyBuyinfos;
		this.purOrders = purOrders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployeeByApproveEmp() {
		return this.employeeByApproveEmp;
	}

	public void setEmployeeByApproveEmp(Employee employeeByApproveEmp) {
		this.employeeByApproveEmp = employeeByApproveEmp;
	}

	public Employee getEmployeeByEmployeeId() {
		return this.employeeByEmployeeId;
	}

	public void setEmployeeByEmployeeId(Employee employeeByEmployeeId) {
		this.employeeByEmployeeId = employeeByEmployeeId;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getApprove() {
		return this.approve;
	}

	public void setApprove(String approve) {
		this.approve = approve;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getApplyBuy() {
		return this.applyBuy;
	}

	public void setApplyBuy(String applyBuy) {
		this.applyBuy = applyBuy;
	}

	public String getApproveTime() {
		return this.approveTime;
	}

	public void setApproveTime(String approveTime) {
		this.approveTime = approveTime;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set getApplyBuyinfos() {
		return this.applyBuyinfos;
	}

	public void setApplyBuyinfos(Set applyBuyinfos) {
		this.applyBuyinfos = applyBuyinfos;
	}

	public Set getPurOrders() {
		return this.purOrders;
	}

	public void setPurOrders(Set purOrders) {
		this.purOrders = purOrders;
	}

}