package com.fuao.fajxc.vo;

/**
 * RenewLog entity. @author MyEclipse Persistence Tools
 */

public class RenewLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private SaleOrder saleOrder;
	private Employee employee;
	private String orderEndTime;
	private String renewTime;
	private Double renewMoner;
	private String nextRenewTime;
	private String financeaffirm;
	private String affirmemp;
	private String inputTime;

	// Constructors

	/** default constructor */
	public RenewLog() {
	}

	/** full constructor */
	public RenewLog(SaleOrder saleOrder, Employee employee,
			String orderEndTime, String renewTime, Double renewMoner,
			String nextRenewTime, String financeaffirm, String affirmemp,
			String inputTime) {
		this.saleOrder = saleOrder;
		this.employee = employee;
		this.orderEndTime = orderEndTime;
		this.renewTime = renewTime;
		this.renewMoner = renewMoner;
		this.nextRenewTime = nextRenewTime;
		this.financeaffirm = financeaffirm;
		this.affirmemp = affirmemp;
		this.inputTime = inputTime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SaleOrder getSaleOrder() {
		return this.saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getOrderEndTime() {
		return this.orderEndTime;
	}

	public void setOrderEndTime(String orderEndTime) {
		this.orderEndTime = orderEndTime;
	}

	public String getRenewTime() {
		return this.renewTime;
	}

	public void setRenewTime(String renewTime) {
		this.renewTime = renewTime;
	}

	public Double getRenewMoner() {
		return this.renewMoner;
	}

	public void setRenewMoner(Double renewMoner) {
		this.renewMoner = renewMoner;
	}

	public String getNextRenewTime() {
		return this.nextRenewTime;
	}

	public void setNextRenewTime(String nextRenewTime) {
		this.nextRenewTime = nextRenewTime;
	}

	public String getFinanceaffirm() {
		return this.financeaffirm;
	}

	public void setFinanceaffirm(String financeaffirm) {
		this.financeaffirm = financeaffirm;
	}

	public String getAffirmemp() {
		return this.affirmemp;
	}

	public void setAffirmemp(String affirmemp) {
		this.affirmemp = affirmemp;
	}

	public String getInputTime() {
		return this.inputTime;
	}

	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

}