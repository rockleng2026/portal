package com.fuao.fajxc.vo;

/**
 * Contract entity. @author MyEclipse Persistence Tools
 */

public class Contract implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String contractState;
	private Employee employeeByRepliedEmp;
	private Employee employeeBySalesmanEmp;
	private Employee employeeByEmpId;
	private Customer customer;
	private String contractNo;
	private String contractName;
	private String signupTime;
	private String comeTime;
	private String endTime;
	private String contractContent;
	private String contractAccessory;
	private String contractMoney;
	private String isInvoice;
	private String gatheringTime;
	private String remark;
	private String repliedTime;
	private String auditState;
	private String delflag;
	private String temp;
	private String temp1;
	private String temp2;
	private String temp3;
	private String temp4;

	// Constructors

	/** default constructor */
	public Contract() {
	}

	/** full constructor */
	public Contract(String alltype, Employee employeeByRepliedEmp,
			Employee employeeBySalesmanEmp, Employee employeeByEmpId,
			Customer customer, String contractNo, String contractName,
			String signupTime, String comeTime, String endTime,
			String contractContent, String contractAccessory,
			String contractMoney, String isInvoice, String gatheringTime,
			String remark, String repliedTime, String auditState, String temp,
			String temp1, String temp2, String temp3, String temp4) {
		this.contractState = alltype;
		this.employeeByRepliedEmp = employeeByRepliedEmp;
		this.employeeBySalesmanEmp = employeeBySalesmanEmp;
		this.employeeByEmpId = employeeByEmpId;
		this.customer = customer;
		this.contractNo = contractNo;
		this.contractName = contractName;
		this.signupTime = signupTime;
		this.comeTime = comeTime;
		this.endTime = endTime;
		this.contractContent = contractContent;
		this.contractAccessory = contractAccessory;
		this.contractMoney = contractMoney;
		this.isInvoice = isInvoice;
		this.gatheringTime = gatheringTime;
		this.remark = remark;
		this.repliedTime = repliedTime;
		this.auditState = auditState;
		this.temp = temp;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.temp4 = temp4;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContractState() {
		return contractState;
	}

	public void setContractState(String contractState) {
		this.contractState = contractState;
	}

	public Employee getEmployeeByRepliedEmp() {
		return this.employeeByRepliedEmp;
	}

	public void setEmployeeByRepliedEmp(Employee employeeByRepliedEmp) {
		this.employeeByRepliedEmp = employeeByRepliedEmp;
	}

	public Employee getEmployeeBySalesmanEmp() {
		return this.employeeBySalesmanEmp;
	}

	public void setEmployeeBySalesmanEmp(Employee employeeBySalesmanEmp) {
		this.employeeBySalesmanEmp = employeeBySalesmanEmp;
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

	public String getContractNo() {
		return this.contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public String getContractName() {
		return this.contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getSignupTime() {
		return this.signupTime;
	}

	public void setSignupTime(String signupTime) {
		this.signupTime = signupTime;
	}

	public String getComeTime() {
		return this.comeTime;
	}

	public void setComeTime(String comeTime) {
		this.comeTime = comeTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getContractContent() {
		return this.contractContent;
	}

	public void setContractContent(String contractContent) {
		this.contractContent = contractContent;
	}

	public String getContractAccessory() {
		return this.contractAccessory;
	}

	public void setContractAccessory(String contractAccessory) {
		this.contractAccessory = contractAccessory;
	}

	public String getContractMoney() {
		return this.contractMoney;
	}

	public void setContractMoney(String contractMoney) {
		this.contractMoney = contractMoney;
	}

	public String getIsInvoice() {
		return this.isInvoice;
	}

	public void setIsInvoice(String isInvoice) {
		this.isInvoice = isInvoice;
	}

	public String getGatheringTime() {
		return this.gatheringTime;
	}

	public void setGatheringTime(String gatheringTime) {
		this.gatheringTime = gatheringTime;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRepliedTime() {
		return this.repliedTime;
	}

	public void setRepliedTime(String repliedTime) {
		this.repliedTime = repliedTime;
	}

	public String getAuditState() {
		return this.auditState;
	}

	public void setAuditState(String auditState) {
		this.auditState = auditState;
	}

	public String getTemp() {
		return this.temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

	public String getTemp1() {
		return this.temp1;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}

	public String getTemp2() {
		return this.temp2;
	}

	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}

	public String getTemp3() {
		return this.temp3;
	}

	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}

	public String getTemp4() {
		return this.temp4;
	}

	public void setTemp4(String temp4) {
		this.temp4 = temp4;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}