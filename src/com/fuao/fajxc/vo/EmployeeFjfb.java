package com.fuao.fajxc.vo;

/**
 * EmployeeFjfb entity. @author MyEclipse Persistence Tools
 */

public class EmployeeFjfb implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private String attachmentSerialNumber;
	private String attachmentName;
	private String attachmentSuffix;
	private String attachmentPath;
	private String uploadTime;
	private String examineVerifyTime;
	private String temp1;
	private String temp2;
	private String temp3;

	// Constructors

	/** default constructor */
	public EmployeeFjfb() {
	}

	/** full constructor */
	public EmployeeFjfb(Employee employee, String attachmentSerialNumber,
			String attachmentName, String attachmentSuffix,
			String attachmentPath, String uploadTime, String examineVerifyTime,
			String temp1, String temp2, String temp3) {
		this.employee = employee;
		this.attachmentSerialNumber = attachmentSerialNumber;
		this.attachmentName = attachmentName;
		this.attachmentSuffix = attachmentSuffix;
		this.attachmentPath = attachmentPath;
		this.uploadTime = uploadTime;
		this.examineVerifyTime = examineVerifyTime;
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

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getAttachmentSerialNumber() {
		return this.attachmentSerialNumber;
	}

	public void setAttachmentSerialNumber(String attachmentSerialNumber) {
		this.attachmentSerialNumber = attachmentSerialNumber;
	}

	public String getAttachmentName() {
		return this.attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAttachmentSuffix() {
		return this.attachmentSuffix;
	}

	public void setAttachmentSuffix(String attachmentSuffix) {
		this.attachmentSuffix = attachmentSuffix;
	}

	public String getAttachmentPath() {
		return this.attachmentPath;
	}

	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}

	public String getUploadTime() {
		return this.uploadTime;
	}

	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	public String getExamineVerifyTime() {
		return this.examineVerifyTime;
	}

	public void setExamineVerifyTime(String examineVerifyTime) {
		this.examineVerifyTime = examineVerifyTime;
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