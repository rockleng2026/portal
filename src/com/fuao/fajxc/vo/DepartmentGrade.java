package com.fuao.fajxc.vo;

/**
 * DepartmentGrade entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DepartmentGrade implements java.io.Serializable {

	// Fields

	private Integer id;
	private Short dgNum;
	private String dgName;
	private String dgDesc;
	
	// Constructors

	/** default constructor */
	public DepartmentGrade() {
	}

	/** full constructor */
	public DepartmentGrade(short dgNum, String dgName, String dgDesc) {
		this.dgNum = dgNum;
		this.dgName = dgName;
		this.dgDesc = dgDesc;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public short getDgNum() {
		return this.dgNum;
	}

	public void setDgNum(short dgNum) {
		this.dgNum = dgNum;
	}

	public String getDgName() {
		return this.dgName;
	}

	public void setDgName(String dgName) {
		this.dgName = dgName;
	}

	public String getDgDesc() {
		return this.dgDesc;
	}

	public void setDgDesc(String dgDesc) {
		this.dgDesc = dgDesc;
	}

}