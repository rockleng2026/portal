package com.fuao.fajxc.vo;

/**
 * RoleFunctionInfo entity. @author MyEclipse Persistence Tools
 */

public class RoleFunctionInfo implements java.io.Serializable {

	// Fields

	private Integer roleFunctionId;
	private Users users;
	private String functionIds;
	private String permissions;
	private String delflag;

	// Constructors

	/** default constructor */
	public RoleFunctionInfo() {
	}

	/** minimal constructor */
	public RoleFunctionInfo(Users users, String functionIds, String permissions) {
		this.users = users;
		this.functionIds = functionIds;
		this.permissions = permissions;
	}

	/** full constructor */
	public RoleFunctionInfo(Users users, String functionIds,
			String permissions, String delflag) {
		this.users = users;
		this.functionIds = functionIds;
		this.permissions = permissions;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getRoleFunctionId() {
		return this.roleFunctionId;
	}

	public void setRoleFunctionId(Integer roleFunctionId) {
		this.roleFunctionId = roleFunctionId;
	}

	public Users getUsers() {
		return this.users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

	public String getFunctionIds() {
		return this.functionIds;
	}

	public void setFunctionIds(String functionIds) {
		this.functionIds = functionIds;
	}

	public String getPermissions() {
		return this.permissions;
	}

	public void setPermissions(String permissions) {
		this.permissions = permissions;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}