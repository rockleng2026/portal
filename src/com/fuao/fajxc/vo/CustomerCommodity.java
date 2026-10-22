package com.fuao.fajxc.vo;

/**
 * CustomerCommodity entity. @author MyEclipse Persistence Tools
 */

public class CustomerCommodity implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Customer customer;
	private String commodityName;
	private String time;
	private String isSendBack;
	private String commodityInfo;
	private String remark;
	private String delflag;
	private String barCode;
	private String sendBacktime;

	// Constructors

	/** default constructor */
	public CustomerCommodity() {
	}

	/** full constructor */
	public CustomerCommodity(Employee employee, Customer customer,
			String commodityName, String time, String isSendBack,
			String commodityInfo, String remark, String delflag,
			String barCode, String sendBacktime) {
		this.employee = employee;
		this.customer = customer;
		this.commodityName = commodityName;
		this.time = time;
		this.isSendBack = isSendBack;
		this.commodityInfo = commodityInfo;
		this.remark = remark;
		this.delflag = delflag;
		this.barCode = barCode;
		this.sendBacktime = sendBacktime;
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

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getCommodityName() {
		return this.commodityName;
	}

	public void setCommodityName(String commodityName) {
		this.commodityName = commodityName;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getIsSendBack() {
		return this.isSendBack;
	}

	public void setIsSendBack(String isSendBack) {
		this.isSendBack = isSendBack;
	}

	public String getCommodityInfo() {
		return this.commodityInfo;
	}

	public void setCommodityInfo(String commodityInfo) {
		this.commodityInfo = commodityInfo;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getBarCode() {
		return this.barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public String getSendBacktime() {
		return this.sendBacktime;
	}

	public void setSendBacktime(String sendBacktime) {
		this.sendBacktime = sendBacktime;
	}

}