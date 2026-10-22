package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * PurOrder entity. @author MyEclipse Persistence Tools
 */

public class PurOrder implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Supplier supplier;
	private ApplyBuy applyBuy;
	private int auditingState;
	private String orderTime;
	private String deliveryTime;
	private Double price;
	private String delflag;
	private String purOrderNo;
	private String applyArray;
	private String remarks;//添加一行备注
	private String accountName;//账户名
	private String account;//账号
	private String accountType;//账号类别
	
	
	private Set purOrderInfos = new HashSet(0);
	private Set paymentLogs = new HashSet(0);
	private Set returnOrders = new HashSet(0);
	private Set toOrders = new HashSet(0);

	// Constructors

	/** default constructor */
	public PurOrder() {
	}

	/** full constructor */
	public PurOrder(Employee employee, Supplier supplier, ApplyBuy applyBuy,
			int auditingState, String orderTime, String deliveryTime,
			Double price, String delflag, String purOrderNo, String applyArray,
			String remarks, String accountName,String account,String accountType,
			Set purOrderInfos, Set paymentLogs, Set returnOrders, Set toOrders) {
		this.employee = employee;
		this.supplier = supplier;
		this.applyBuy = applyBuy;
		this.auditingState = auditingState;
		this.orderTime = orderTime;
		this.deliveryTime = deliveryTime;
		this.price = price;
		this.delflag = delflag;
		this.purOrderNo = purOrderNo;
		this.applyArray = applyArray;
		this.purOrderInfos = purOrderInfos;
		this.paymentLogs = paymentLogs;
		this.returnOrders = returnOrders;
		this.toOrders = toOrders;
		this.remarks=remarks;
		this.account=account;
		this.accountName=accountName;
		this.accountType=accountType;
	}

	// Property accessors

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

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

	public Supplier getSupplier() {
		return this.supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public ApplyBuy getApplyBuy() {
		return this.applyBuy;
	}

	public void setApplyBuy(ApplyBuy applyBuy) {
		this.applyBuy = applyBuy;
	}

	

	public int getAuditingState() {
		return auditingState;
	}

	public void setAuditingState(int auditingState) {
		this.auditingState = auditingState;
	}

	public String getOrderTime() {
		return this.orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getDeliveryTime() {
		return this.deliveryTime;
	}

	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getPurOrderNo() {
		return this.purOrderNo;
	}

	public void setPurOrderNo(String purOrderNo) {
		this.purOrderNo = purOrderNo;
	}

	public String getApplyArray() {
		return this.applyArray;
	}

	public void setApplyArray(String applyArray) {
		this.applyArray = applyArray;
	}

	public Set getPurOrderInfos() {
		return this.purOrderInfos;
	}

	public void setPurOrderInfos(Set purOrderInfos) {
		this.purOrderInfos = purOrderInfos;
	}

	public Set getPaymentLogs() {
		return this.paymentLogs;
	}

	public void setPaymentLogs(Set paymentLogs) {
		this.paymentLogs = paymentLogs;
	}

	public Set getReturnOrders() {
		return this.returnOrders;
	}

	public void setReturnOrders(Set returnOrders) {
		this.returnOrders = returnOrders;
	}

	public Set getToOrders() {
		return this.toOrders;
	}

	public void setToOrders(Set toOrders) {
		this.toOrders = toOrders;
	}

}