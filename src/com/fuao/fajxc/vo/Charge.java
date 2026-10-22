package com.fuao.fajxc.vo;

/**
 * Charge entity. @author MyEclipse Persistence Tools
 */

public class Charge implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employeeByEmpId;
	private SaleOrder saleOrder;
	private Employee employeeByEmployeeId;
	private Double paymentAmount;
	private String payCode;
	private String collectionTime;
	private Integer isAuditing;
	private String defrayMode;
	private Double accountPayable;
	private String del;
	private String inputTime;
	private String chargeNo;
	private String payerName;//付款人姓名
	private String accountNumber;//收款账号
	private String remark;//备注
    private String payStat;//状态
    private Sale_orders orders;
	// Constructors
    
	/** default constructor */
	public Charge() {
	}

	public String getPayStat() {
		return payStat;
	}

	public void setPayStat(String payStat) {
		this.payStat = payStat;
	}

	/** full constructor */
	public Charge(Employee employeeByEmpId, SaleOrder saleOrder,
			Employee employeeByEmployeeId, Double paymentAmount,
			String payCode, String collectionTime, Integer isAuditing,
			String defrayMode, Double accountPayable, String del,
			String inputTime, String chargeNo,String payerName,String accountNumber,String remark,Sale_orders orders) {
		this.employeeByEmpId = employeeByEmpId;
		this.saleOrder = saleOrder;
		this.employeeByEmployeeId = employeeByEmployeeId;
		this.paymentAmount = paymentAmount;
		this.payCode = payCode;
		this.collectionTime = collectionTime;
		this.isAuditing = isAuditing;
		this.defrayMode = defrayMode;
		this.accountPayable = accountPayable;
		this.del = del;
		this.inputTime = inputTime;
		this.chargeNo = chargeNo;
		this.payerName = payerName;
		this.accountNumber = accountNumber;
		this.remark = remark;
		this.orders = orders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployeeByEmpId() {
		return this.employeeByEmpId;
	}

	public void setEmployeeByEmpId(Employee employeeByEmpId) {
		this.employeeByEmpId = employeeByEmpId;
	}

	public SaleOrder getSaleOrder() {
		return this.saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public Employee getEmployeeByEmployeeId() {
		return this.employeeByEmployeeId;
	}

	public void setEmployeeByEmployeeId(Employee employeeByEmployeeId) {
		this.employeeByEmployeeId = employeeByEmployeeId;
	}

	public Double getPaymentAmount() {
		return this.paymentAmount;
	}

	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public String getPayCode() {
		return this.payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public String getCollectionTime() {
		return this.collectionTime;
	}

	public void setCollectionTime(String collectionTime) {
		this.collectionTime = collectionTime;
	}

	public Integer getIsAuditing() {
		return this.isAuditing;
	}

	public void setIsAuditing(Integer isAuditing) {
		this.isAuditing = isAuditing;
	}

	public String getDefrayMode() {
		return this.defrayMode;
	}

	public void setDefrayMode(String defrayMode) {
		this.defrayMode = defrayMode;
	}

	public Double getAccountPayable() {
		return this.accountPayable;
	}

	public void setAccountPayable(Double accountPayable) {
		this.accountPayable = accountPayable;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getInputTime() {
		return this.inputTime;
	}

	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

	public String getChargeNo() {
		return this.chargeNo;
	}

	public void setChargeNo(String chargeNo) {
		this.chargeNo = chargeNo;
	}

	public String getPayerName() {
		return payerName;
	}

	public void setPayerName(String payerName) {
		this.payerName = payerName;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Sale_orders getOrders() {
		return orders;
	}

	public void setOrders(Sale_orders orders) {
		this.orders = orders;
	}
	

}