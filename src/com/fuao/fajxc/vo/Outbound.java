package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Outbound entity. @author MyEclipse Persistence Tools
 */

public class Outbound implements java.io.Serializable {

	// Fields

	private Integer id;
	private Depot depot;
	private AllType allType;
	private Employee employee;
	private String time;
	private String delflag;
	private String outboundNo;
	private String remark;
	private Integer auditingState;
	private Set outboundInfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Outbound() {
	}

	/** full constructor */
	public Outbound(Depot depot, AllType allType, Employee employee,
			String time, String delflag, String outboundNo, String remark,
			Set outboundInfos,Integer auditingState) {
		this.depot = depot;
		this.allType = allType;
		this.employee = employee;
		this.time = time;
		this.delflag = delflag;
		this.outboundNo = outboundNo;
		this.remark = remark;
		this.outboundInfos = outboundInfos;
		this.auditingState=auditingState;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
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

	public AllType getAllType() {
		return this.allType;
	}

	public void setAllType(AllType allType) {
		this.allType = allType;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getOutboundNo() {
		return this.outboundNo;
	}

	public void setOutboundNo(String outboundNo) {
		this.outboundNo = outboundNo;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set getOutboundInfos() {
		return this.outboundInfos;
	}

	public void setOutboundInfos(Set outboundInfos) {
		this.outboundInfos = outboundInfos;
	}

	public Integer getAuditingState() {
		return auditingState;
	}

	public void setAuditingState(Integer auditingState) {
		this.auditingState = auditingState;
	}
	
	

}