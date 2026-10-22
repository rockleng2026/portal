package com.fuao.fajxc.vo;

/**
 * Permission entity. @author MyEclipse Persistence Tools
 */

public class Permission implements java.io.Serializable {

	// Fields

	private Integer permissionId;
	private String permissionName;
	private String permissionDescription;

	// Constructors

	/** default constructor */
	public Permission() {
	}

	/** minimal constructor */
	public Permission(String permissionName) {
		this.permissionName = permissionName;
	}

	/** full constructor */
	public Permission(String permissionName, String permissionDescription) {
		this.permissionName = permissionName;
		this.permissionDescription = permissionDescription;
	}

	// Property accessors

	public Integer getPermissionId() {
		return this.permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

	public String getPermissionName() {
		return this.permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public String getPermissionDescription() {
		return this.permissionDescription;
	}

	public void setPermissionDescription(String permissionDescription) {
		this.permissionDescription = permissionDescription;
	}

}