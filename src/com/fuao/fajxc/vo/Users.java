package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

import com.fuao.fajxc.util.MD5;

/**
 * Users entity. @author MyEclipse Persistence Tools
 */

public class Users implements java.io.Serializable {

	// Fields

	private Integer userId;
	private Roles roles;
	private String loginName;
	private String password;
	private String userName;
	private String mark;
	private Integer customerOrEmployeeId;
	private String startTime;
	private String loginTime;
	private String lastLoginTime;
	private Integer counts;
	private String ipPart;
	private String lastIpPart;
	private Integer status;
	private String delflag;
	private Set roleFunctionInfos = new HashSet(0);
	private Set userGroupInfos = new HashSet(0);
	MD5 test = new MD5();
	/** default constructor */
	public Users() {
	}

	/** minimal constructor */
	public Users(Roles roles, String loginName, String password,
			String userName, String mark, Integer customerOrEmployeeId,
			String loginTime, String lastLoginTime, Integer counts,
			String ipPart, String lastIpPart) {
		this.roles = roles;
		this.loginName = loginName;
		this.password = password;
		this.userName = userName;
		this.mark = mark;
		this.customerOrEmployeeId = customerOrEmployeeId;
		this.loginTime = loginTime;
		this.lastLoginTime = lastLoginTime;
		this.counts = counts;
		this.ipPart = ipPart;
		this.lastIpPart = lastIpPart;
	}

	/** full constructor */
	public Users(Roles roles, String loginName, String password,
			String userName, String mark, Integer customerOrEmployeeId,
			String startTime, String loginTime, String lastLoginTime,
			Integer counts, String ipPart, String lastIpPart, Integer status,
			String delflag, Set roleFunctionInfos, Set userGroupInfos) {
		this.roles = roles;
		this.loginName = loginName;
		this.password = password;
		this.userName = userName;
		this.mark = mark;
		this.customerOrEmployeeId = customerOrEmployeeId;
		this.startTime = startTime;
		this.loginTime = loginTime;
		this.lastLoginTime = lastLoginTime;
		this.counts = counts;
		this.ipPart = ipPart;
		this.lastIpPart = lastIpPart;
		this.status = status;
		this.delflag = delflag;
		this.roleFunctionInfos = roleFunctionInfos;
		this.userGroupInfos = userGroupInfos;
	}

	// Property accessors

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Roles getRoles() {
		return this.roles;
	}

	public void setRoles(Roles roles) {
		this.roles = roles;
	}

	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		
		return password;
	}

	public void setPassword(String password) {
		
		this.password = password;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMark() {
		return this.mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public Integer getCustomerOrEmployeeId() {
		return this.customerOrEmployeeId;
	}

	public void setCustomerOrEmployeeId(Integer customerOrEmployeeId) {
		this.customerOrEmployeeId = customerOrEmployeeId;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getLoginTime() {
		return this.loginTime;
	}

	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}

	public String getLastLoginTime() {
		return this.lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Integer getCounts() {
		return this.counts;
	}

	public void setCounts(Integer counts) {
		this.counts = counts;
	}

	public String getIpPart() {
		return this.ipPart;
	}

	public void setIpPart(String ipPart) {
		this.ipPart = ipPart;
	}

	public String getLastIpPart() {
		return this.lastIpPart;
	}

	public void setLastIpPart(String lastIpPart) {
		this.lastIpPart = lastIpPart;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public Set getRoleFunctionInfos() {
		return this.roleFunctionInfos;
	}

	public void setRoleFunctionInfos(Set roleFunctionInfos) {
		this.roleFunctionInfos = roleFunctionInfos;
	}

	public Set getUserGroupInfos() {
		return this.userGroupInfos;
	}

	public void setUserGroupInfos(Set userGroupInfos) {
		this.userGroupInfos = userGroupInfos;
	}

}