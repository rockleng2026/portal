package com.fuao.fajxc.vo;

/**
 * Messageremind entity. @author MyEclipse Persistence Tools
 */

public class Messageremind implements java.io.Serializable {

	// Fields

	private Integer id;
	private String typeName;
	private String isEmailRemind;
	private String isPhoneRemind;
	private String mark;
	private String temp;
	private String temp1;
	private String temp2;
	private String temp3;

	// Constructors

	/** default constructor */
	public Messageremind() {
	}

	/** full constructor */
	public Messageremind(String typeName, String isEmailRemind,
			String isPhoneRemind, String mark, String temp, String temp1,
			String temp2, String temp3) {
		this.typeName = typeName;
		this.isEmailRemind = isEmailRemind;
		this.isPhoneRemind = isPhoneRemind;
		this.mark = mark;
		this.temp = temp;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getIsEmailRemind() {
		return this.isEmailRemind;
	}

	public void setIsEmailRemind(String isEmailRemind) {
		this.isEmailRemind = isEmailRemind;
	}

	public String getIsPhoneRemind() {
		return this.isPhoneRemind;
	}

	public void setIsPhoneRemind(String isPhoneRemind) {
		this.isPhoneRemind = isPhoneRemind;
	}

	public String getMark() {
		return this.mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
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

}