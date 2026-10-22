package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * PaymentLog entity. @author MyEclipse Persistence Tools
 */

public class PaymentLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private PurOrder purOrder;
	private String defrayMode;
	private Double paymentAmount;
	private String account;
	private String time;
	private String remark;
	private String del;
	private String payNo;
	private String inputTime;
	private Integer auditingState;
	private String gatheringName;// 收款名称
	private String bankName;// 开户行
	private String temp;
	private Customer customer;
	private Employee emps;
	private Missiontype missiontype;//付款类型

	// Constructors

	/** default constructor */
	public PaymentLog() {
	}

	/** full constructor */
	public PaymentLog(Employee employee, PurOrder purOrder, String defrayMode,
			Double paymentAmount, String account, String time, String remark,
			String del, String payNo, String inputTime,
			Integer auditingState, String gatheringName, String bankName,
			String temp,Customer customer,Employee emps,Missiontype missiontype) {
		this.employee = employee;
		this.purOrder = purOrder;
		this.defrayMode = defrayMode;
		this.paymentAmount = paymentAmount;
		this.account = account;
		this.time = time;
		this.remark = remark;
		this.del = del;
		this.payNo = payNo;
		this.inputTime = inputTime;
		this.auditingState = auditingState;
		this.gatheringName = gatheringName;
		this.bankName = bankName;
		this.temp = temp;
		this.customer = customer;
		this.emps = emps;
		this.missiontype = missiontype;
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

	public PurOrder getPurOrder() {
		return this.purOrder;
	}

	public void setPurOrder(PurOrder purOrder) {
		this.purOrder = purOrder;
	}

	public String getDefrayMode() {
		return this.defrayMode;
	}

	public void setDefrayMode(String defrayMode) {
		this.defrayMode = defrayMode;
	}

	public Double getPaymentAmount() {
		return this.paymentAmount;
	}

	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getPayNo() {
		return this.payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	

	public String getInputTime() {
		return inputTime;
	}

	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

	public Integer getAuditingState() {
		return auditingState;
	}

	public void setAuditingState(Integer auditingState) {
		this.auditingState = auditingState;
	}

	public String getGatheringName() {
		return gatheringName;
	}

	public void setGatheringName(String gatheringName) {
		this.gatheringName = gatheringName;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Employee getEmps() {
		return emps;
	}

	public void setEmps(Employee emps) {
		this.emps = emps;
	}

	public Missiontype getMissiontype() {
		return missiontype;
	}

	public void setMissiontype(Missiontype missiontype) {
		this.missiontype = missiontype;
	}
	
}