package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * RefundmentLog entity. @author MyEclipse Persistence Tools
 */

public class RefundmentLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employeeByFinancingId;
	private Employee employeeByApprovePresonId;
	private Employee employeeByEmpId;
	private Customer customer;
	private SaleOrder saleOrder;
	private String clientOrderNum;
	private String account;
	private String returnReason;
	private Timestamp returnTime;
	private Timestamp returnLimitTime;
	private Double money;
	private Timestamp approveTime;
	private Integer approveState;
	private Integer financingState;
	private String delflag;

	// Constructors

	/** default constructor */
	public RefundmentLog() {
	}

	/** full constructor */
	public RefundmentLog(Employee employeeByFinancingId,
			Employee employeeByApprovePresonId, Employee employeeByEmpId,
			Customer customer, SaleOrder saleOrder, String clientOrderNum,
			String account, String returnReason, Timestamp returnTime,
			Timestamp returnLimitTime, Double money, Timestamp approveTime,
			Integer approveState, Integer financingState, String delflag) {
		this.employeeByFinancingId = employeeByFinancingId;
		this.employeeByApprovePresonId = employeeByApprovePresonId;
		this.employeeByEmpId = employeeByEmpId;
		this.customer = customer;
		this.saleOrder = saleOrder;
		this.clientOrderNum = clientOrderNum;
		this.account = account;
		this.returnReason = returnReason;
		this.returnTime = returnTime;
		this.returnLimitTime = returnLimitTime;
		this.money = money;
		this.approveTime = approveTime;
		this.approveState = approveState;
		this.financingState = financingState;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployeeByFinancingId() {
		return this.employeeByFinancingId;
	}

	public void setEmployeeByFinancingId(Employee employeeByFinancingId) {
		this.employeeByFinancingId = employeeByFinancingId;
	}

	public Employee getEmployeeByApprovePresonId() {
		return this.employeeByApprovePresonId;
	}

	public void setEmployeeByApprovePresonId(Employee employeeByApprovePresonId) {
		this.employeeByApprovePresonId = employeeByApprovePresonId;
	}

	public Employee getEmployeeByEmpId() {
		return this.employeeByEmpId;
	}

	public void setEmployeeByEmpId(Employee employeeByEmpId) {
		this.employeeByEmpId = employeeByEmpId;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public SaleOrder getSaleOrder() {
		return this.saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public String getClientOrderNum() {
		return this.clientOrderNum;
	}

	public void setClientOrderNum(String clientOrderNum) {
		this.clientOrderNum = clientOrderNum;
	}

	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getReturnReason() {
		return this.returnReason;
	}

	public void setReturnReason(String returnReason) {
		this.returnReason = returnReason;
	}

	public Timestamp getReturnTime() {
		return this.returnTime;
	}

	public void setReturnTime(Timestamp returnTime) {
		this.returnTime = returnTime;
	}

	public Timestamp getReturnLimitTime() {
		return this.returnLimitTime;
	}

	public void setReturnLimitTime(Timestamp returnLimitTime) {
		this.returnLimitTime = returnLimitTime;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Timestamp getApproveTime() {
		return this.approveTime;
	}

	public void setApproveTime(Timestamp approveTime) {
		this.approveTime = approveTime;
	}

	public Integer getApproveState() {
		return this.approveState;
	}

	public void setApproveState(Integer approveState) {
		this.approveState = approveState;
	}

	public Integer getFinancingState() {
		return this.financingState;
	}

	public void setFinancingState(Integer financingState) {
		this.financingState = financingState;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}