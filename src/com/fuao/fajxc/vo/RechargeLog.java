package com.fuao.fajxc.vo;

/**
 * RechargeLog entity. @author MyEclipse Persistence Tools
 */

public class RechargeLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private Customer customer;
	private String rechargeTime;
	private String rechargemonery;
	private String orderno;
	private String balanc;
	private String tmp;
	private String tmp1;
	private String tmp2;

	// Constructors

	/** default constructor */
	public RechargeLog() {
	}

	/** full constructor */
	public RechargeLog(Customer customer, String rechargeTime,
			String rechargemonery, String orderno, String balanc, String tmp,
			String tmp1, String tmp2) {
		this.customer = customer;
		this.rechargeTime = rechargeTime;
		this.rechargemonery = rechargemonery;
		this.orderno = orderno;
		this.balanc = balanc;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
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

	public String getRechargeTime() {
		return this.rechargeTime;
	}

	public void setRechargeTime(String rechargeTime) {
		this.rechargeTime = rechargeTime;
	}

	public String getRechargemonery() {
		return this.rechargemonery;
	}

	public void setRechargemonery(String rechargemonery) {
		this.rechargemonery = rechargemonery;
	}

	public String getOrderno() {
		return this.orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getBalanc() {
		return this.balanc;
	}

	public void setBalanc(String balanc) {
		this.balanc = balanc;
	}

	public String getTmp() {
		return this.tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

	public String getTmp1() {
		return this.tmp1;
	}

	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}

	public String getTmp2() {
		return this.tmp2;
	}

	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}

}