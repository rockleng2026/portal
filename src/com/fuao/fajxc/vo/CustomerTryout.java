package com.fuao.fajxc.vo;

/**
 * CustomerTryout entity. @author MyEclipse Persistence Tools
 */

public class CustomerTryout implements java.io.Serializable {

	// Fields

	private Integer id;
	private Customer customer;
	private String ip;
	private String servercollocate;
	private String bandwidth;
	private String tryoutBeginDate;
	private String tryoutEndDate;
	private String isPurchase;
	private String remark;
	private String delflag;

	// Constructors

	/** default constructor */
	public CustomerTryout() {
	}

	/** minimal constructor */
	public CustomerTryout(Customer customer) {
		this.customer = customer;
	}

	/** full constructor */
	public CustomerTryout(Customer customer, String ip, String servercollocate,
			String bandwidth, String tryoutBeginDate, String tryoutEndDate,
			String isPurchase, String remark, String delflag) {
		this.customer = customer;
		this.ip = ip;
		this.servercollocate = servercollocate;
		this.bandwidth = bandwidth;
		this.tryoutBeginDate = tryoutBeginDate;
		this.tryoutEndDate = tryoutEndDate;
		this.isPurchase = isPurchase;
		this.remark = remark;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getServercollocate() {
		return this.servercollocate;
	}

	public void setServercollocate(String servercollocate) {
		this.servercollocate = servercollocate;
	}

	public String getBandwidth() {
		return this.bandwidth;
	}

	public void setBandwidth(String bandwidth) {
		this.bandwidth = bandwidth;
	}

	public String getTryoutBeginDate() {
		return this.tryoutBeginDate;
	}

	public void setTryoutBeginDate(String tryoutBeginDate) {
		this.tryoutBeginDate = tryoutBeginDate;
	}

	public String getTryoutEndDate() {
		return this.tryoutEndDate;
	}

	public void setTryoutEndDate(String tryoutEndDate) {
		this.tryoutEndDate = tryoutEndDate;
	}

	public String getIsPurchase() {
		return this.isPurchase;
	}

	public void setIsPurchase(String isPurchase) {
		this.isPurchase = isPurchase;
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

}