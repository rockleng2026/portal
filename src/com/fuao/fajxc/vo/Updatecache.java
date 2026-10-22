package com.fuao.fajxc.vo;

/**
 * Updatecache entity. @author MyEclipse Persistence Tools
 */

public class Updatecache implements java.io.Serializable {

	// Fields

	private Integer id;
	private Customer customer;
	private String domain;
	private String content;
	private String result;
	private String time;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;

	// Constructors

	/** default constructor */
	public Updatecache() {
	}

	/** full constructor */
	public Updatecache(Customer customer, String domain, String content,
			String result, String time, String tmp, String tmp1, String tmp2,
			String tmp3) {
		this.customer = customer;
		this.domain = domain;
		this.content = content;
		this.result = result;
		this.time = time;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
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

	public String getDomain() {
		return this.domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getResult() {
		return this.result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
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

	public String getTmp3() {
		return this.tmp3;
	}

	public void setTmp3(String tmp3) {
		this.tmp3 = tmp3;
	}

}