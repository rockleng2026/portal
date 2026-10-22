package com.fuao.fajxc.vo;

/**
 * Docmark entity. @author MyEclipse Persistence Tools
 */

public class Docmark implements java.io.Serializable {

	// Fields

	private Integer id;
	private String aname;
	private String mark;
	private String otype;
	private String temp1;
	public String getTemp1() {
		return temp1;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}

	private String temp2;
	private String temp3;

	// Constructors

	/** default constructor */
	public Docmark() {
	}

	/** full constructor */
	public Docmark(String aname, String mark, String temp1, String temp2,
			String temp3) {
		this.aname = aname;
		this.mark = mark;
		this.otype = temp1;
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

	public String getAname() {
		return this.aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getMark() {
		return this.mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getOtype() {
		return otype;
	}

	public void setOtype(String otype) {
		this.otype = otype;
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