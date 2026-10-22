package com.fuao.fajxc.vo;

/**
 * UserGroupInfo entity. @author MyEclipse Persistence Tools
 */

public class UserGroupInfo implements java.io.Serializable {

	// Fields

	private Integer userGroupId;
	private Users users;
	private String supergroupIds;
	private String groupIds;
	private String resourcePermission;

	// Constructors

	/** default constructor */
	public UserGroupInfo() {
	}

	/** minimal constructor */
	public UserGroupInfo(Users users, String groupIds) {
		this.users = users;
		this.groupIds = groupIds;
	}

	/** full constructor */
	public UserGroupInfo(Users users, String supergroupIds, String groupIds) {
		this.users = users;
		this.supergroupIds = supergroupIds;
		this.groupIds = groupIds;
	}

	// Property accessors

	public Integer getUserGroupId() {
		return this.userGroupId;
	}

	public void setUserGroupId(Integer userGroupId) {
		this.userGroupId = userGroupId;
	}

	public Users getUsers() {
		return this.users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

	public String getSupergroupIds() {
		return this.supergroupIds;
	}

	public void setSupergroupIds(String supergroupIds) {
		this.supergroupIds = supergroupIds;
	}

	public String getGroupIds() {
		return this.groupIds;
	}

	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}

	public String getResourcePermission() {
		return resourcePermission;
	}

	public void setResourcePermission(String resourcePermission) {
		this.resourcePermission = resourcePermission;
	}

}