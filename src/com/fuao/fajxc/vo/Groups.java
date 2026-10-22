package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Groups entity. @author MyEclipse Persistence Tools
 */

public class Groups implements java.io.Serializable {

	// Fields

	private Integer groupId;
	private String groupName;
	private Integer superGroupId;
	private String permissionGrade;
	private Double grade;
	private String startTime;
	private String description;
	private String delflag;
	private List<Groups> child = new ArrayList<Groups>();

	// Constructors

	/** default constructor */
	public Groups() {
	}

	/** minimal constructor */
	public Groups(String groupName, Integer superGroupId, String permissionGrade) {
		this.groupName = groupName;
		this.superGroupId = superGroupId;
		this.permissionGrade = permissionGrade;
	}

	/** full constructor */
	public Groups(String groupName, Integer superGroupId,
			String permissionGrade, Double grade, String startTime,
			String description, String delflag) {
		this.groupName = groupName;
		this.superGroupId = superGroupId;
		this.permissionGrade = permissionGrade;
		this.grade = grade;
		this.startTime = startTime;
		this.description = description;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getGroupId() {
		return this.groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return this.groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getSuperGroupId() {
		return this.superGroupId;
	}

	public void setSuperGroupId(Integer superGroupId) {
		this.superGroupId = superGroupId;
	}

	public String getPermissionGrade() {
		return this.permissionGrade;
	}

	public void setPermissionGrade(String permissionGrade) {
		this.permissionGrade = permissionGrade;
	}

	public Double getGrade() {
		return this.grade;
	}

	public void setGrade(Double grade) {
		this.grade = grade;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public List<Groups> getChild() {
		return child;
	}

	public void setChild(List<Groups> child) {
		this.child = child;
	}

}