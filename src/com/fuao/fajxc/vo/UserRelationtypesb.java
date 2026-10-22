package com.fuao.fajxc.vo;

/**
 * UserRelationtypesb entity. @author MyEclipse Persistence Tools
 */

public class UserRelationtypesb implements java.io.Serializable {

	// Fields

	private Integer id;
	private String uuid;
	private String name;
	private String remark;
	private String temp1;
	private String temp2;
	private String temp3;

	// Constructors

	/** default constructor */
	public UserRelationtypesb() {
	}

	/** full constructor */
	public UserRelationtypesb(String uuid, String name, String remark,
			String temp1, String temp2, String temp3) {
		this.uuid = uuid;
		this.name = name;
		this.remark = remark;
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

	public String getUuid() {
		return this.uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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