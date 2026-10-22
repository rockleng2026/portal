package com.fuao.fajxc.vo;

/**
 * EmployeeGrade entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class EmployeeGrade implements java.io.Serializable {

	// Fields

	private Integer id;
	private Short gradeNum;
	private String gradeName;
	private String gradeDesc;

	// Constructors

	/** default constructor */
	public EmployeeGrade() {
	}

	/** full constructor */
	public EmployeeGrade(short gradeNum, String gradeName, String gradeDesc) {
		this.gradeNum = gradeNum;
		this.gradeName = gradeName;
		this.gradeDesc = gradeDesc;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public short getGradeNum() {
		return this.gradeNum;
	}

	public void setGradeNum(short gradeNum) {
		this.gradeNum = gradeNum;
	}

	public String getGradeName() {
		return this.gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getGradeDesc() {
		return this.gradeDesc;
	}

	public void setGradeDesc(String gradeDesc) {
		this.gradeDesc = gradeDesc;
	}

}