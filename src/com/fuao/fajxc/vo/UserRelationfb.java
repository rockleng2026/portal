package com.fuao.fajxc.vo;

/**
 * UserRelationfb entity. @author MyEclipse Persistence Tools
 */

public class UserRelationfb implements java.io.Serializable {

	// Fields

	private Integer id;
	private String uuid;
	private Integer relationTypeId;
	private String beanName;
	private String f;
	private String fname;
	private String ftype;
	private String fmyorder;
	private String fform;
	private String flen;
	private String fvalue;
	private String fformsize;
	private String temp1;
	private String temp2;
	private String temp3;

	// Constructors

	/** default constructor */
	public UserRelationfb() {
	}

	/** minimal constructor */
	public UserRelationfb(String f) {
		this.f = f;
	}

	/** full constructor */
	public UserRelationfb(String uuid, Integer relationTypeId, String beanName,
			String f, String fname, String ftype, String fmyorder,
			String fform, String flen, String fvalue, String fformsize,
			String temp1, String temp2, String temp3) {
		this.uuid = uuid;
		this.relationTypeId = relationTypeId;
		this.beanName = beanName;
		this.f = f;
		this.fname = fname;
		this.ftype = ftype;
		this.fmyorder = fmyorder;
		this.fform = fform;
		this.flen = flen;
		this.fvalue = fvalue;
		this.fformsize = fformsize;
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

	public Integer getRelationTypeId() {
		return this.relationTypeId;
	}

	public void setRelationTypeId(Integer relationTypeId) {
		this.relationTypeId = relationTypeId;
	}

	public String getBeanName() {
		return this.beanName;
	}

	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}

	public String getF() {
		return this.f;
	}

	public void setF(String f) {
		this.f = f;
	}

	public String getFname() {
		return this.fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getFtype() {
		return this.ftype;
	}

	public void setFtype(String ftype) {
		this.ftype = ftype;
	}

	public String getFmyorder() {
		return this.fmyorder;
	}

	public void setFmyorder(String fmyorder) {
		this.fmyorder = fmyorder;
	}

	public String getFform() {
		return this.fform;
	}

	public void setFform(String fform) {
		this.fform = fform;
	}

	public String getFlen() {
		return this.flen;
	}

	public void setFlen(String flen) {
		this.flen = flen;
	}

	public String getFvalue() {
		return this.fvalue;
	}

	public void setFvalue(String fvalue) {
		this.fvalue = fvalue;
	}

	public String getFformsize() {
		return this.fformsize;
	}

	public void setFformsize(String fformsize) {
		this.fformsize = fformsize;
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