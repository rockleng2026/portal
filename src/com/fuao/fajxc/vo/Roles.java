package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Roles entity. @author MyEclipse Persistence Tools
 */

public class Roles implements java.io.Serializable {

	// Fields

	private Integer roleId;
	private Integer superId;
	private String roleName;
	private Integer roleFunctionId;
	private String createTime;
	private String roledescription;
	private String delflag;
	private String functionIds;
	private String permissions;
	private Set userses = new HashSet(0);

	// Constructors

	/** default constructor */
	public Roles() {
	}

	/** minimal constructor */
	public Roles(Integer superId, String roleName, Integer roleFunctionId,
			String createTime) {
		this.superId = superId;
		this.roleName = roleName;
		this.roleFunctionId = roleFunctionId;
		this.createTime = createTime;
	}

	/** full constructor */
	public Roles(Integer superId, String roleName, Integer roleFunctionId,
			String createTime, String roledescription, String delflag,
			String functionIds, String permissions, Set userses) {
		this.superId = superId;
		this.roleName = roleName;
		this.roleFunctionId = roleFunctionId;
		this.createTime = createTime;
		this.roledescription = roledescription;
		this.delflag = delflag;
		this.functionIds = functionIds;
		this.permissions = permissions;
		this.userses = userses;
	}

	// Property accessors

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getSuperId() {
		return this.superId;
	}

	public void setSuperId(Integer superId) {
		this.superId = superId;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getRoleFunctionId() {
		return this.roleFunctionId;
	}

	public void setRoleFunctionId(Integer roleFunctionId) {
		this.roleFunctionId = roleFunctionId;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getRoledescription() {
		return this.roledescription;
	}

	public void setRoledescription(String roledescription) {
		this.roledescription = roledescription;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
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

	public Set getUserses() {
		return this.userses;
	}

	public void setUserses(Set userses) {
		this.userses = userses;
	}

}