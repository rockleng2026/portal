package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Empassess entity. @author MyEclipse Persistence Tools
 */

public class Empassess implements java.io.Serializable {

	// Fields

	private Integer id;
	private Questioncategory questioncategory;
	private Department department;
	private Integer duration;
	private String assess;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;
	private List durations = new ArrayList();
	private List assesss = new ArrayList();

	// Constructors

	/** default constructor */
	public Empassess() {
	}

	/** full constructor */
	public Empassess(Questioncategory questioncategory, Department department,
			Integer duration, String assess, String tmp, String tmp1,
			String tmp2, String tmp3) {
		this.questioncategory = questioncategory;
		this.department = department;
		this.duration = duration;
		this.assess = assess;
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

	public Questioncategory getQuestioncategory() {
		return this.questioncategory;
	}

	public void setQuestioncategory(Questioncategory questioncategory) {
		this.questioncategory = questioncategory;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getDuration() {
		return this.duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public String getAssess() {
		return this.assess;
	}

	public void setAssess(String assess) {
		this.assess = assess;
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

	public List getDurations() {
		return durations;
	}

	public void setDurations(List durations) {
		this.durations = durations;
	}

	public List getAssesss() {
		return assesss;
	}

	public void setAssesss(List assesss) {
		this.assesss = assesss;
	}

}