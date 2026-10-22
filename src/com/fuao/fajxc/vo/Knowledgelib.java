package com.fuao.fajxc.vo;

/**
 * Knowledgelib entity. @author MyEclipse Persistence Tools
 */

public class Knowledgelib implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private String libType;
	private String libTitle;
	private String libContent;
	private String libAccessory;
	private String tmp;

	// Constructors

	/** default constructor */
	public Knowledgelib() {
	}

	/** full constructor */
	public Knowledgelib(Employee employee, String libType, String libTitle,
			String libContent, String libAccessory, String tmp) {
		this.employee = employee;
		this.libType = libType;
		this.libTitle = libTitle;
		this.libContent = libContent;
		this.libAccessory = libAccessory;
		this.tmp = tmp;
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

	public String getLibType() {
		return this.libType;
	}

	public void setLibType(String libType) {
		this.libType = libType;
	}

	public String getLibTitle() {
		return this.libTitle;
	}

	public void setLibTitle(String libTitle) {
		this.libTitle = libTitle;
	}

	public String getLibContent() {
		return this.libContent;
	}

	public void setLibContent(String libContent) {
		this.libContent = libContent;
	}

	public String getLibAccessory() {
		return this.libAccessory;
	}

	public void setLibAccessory(String libAccessory) {
		this.libAccessory = libAccessory;
	}

	public String getTmp() {
		return this.tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

}