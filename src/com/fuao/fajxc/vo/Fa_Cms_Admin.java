package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.sun.org.apache.bcel.internal.generic.NEW;

public class Fa_Cms_Admin {
	private Integer user_id;
	private String username;
	private String admin_password;
	private Integer flag;
	private Integer admin_status;
	private String righttree;
	private String email;
	private Date regdate;

	private String admCode;  //验证码

	private Integer deptid;

	//管理员对部门  多对一
	private Department depts;
	//中间表
	private Set Tadminright = new HashSet(0);
	public Set getTadminright() {
		return Tadminright;
	}
	public void setTadminright(Set tadminright) {
		Tadminright = tadminright;
	}
	public Fa_Cms_Admin(){}
	public Fa_Cms_Admin(Integer user_id,String username,String admin_password,Integer flag,
			Integer admin_status,String righttree,String email,Date regdate){
		this.user_id=user_id;
		this.username=username;
		this.admin_password=admin_password;
		this.flag=flag;
		this.admin_status=admin_status;
		this.righttree=righttree;
		this.email=email;
		this.regdate=regdate;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public String getAdmCode() {
		return admCode;
	}
	public void setAdmCode(String admCode) {
		this.admCode = admCode;
	}
	public void setUser_id(Integer userId) {
		user_id = userId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAdmin_password() {
		return admin_password;
	}
	public void setAdmin_password(String adminPassword) {
		admin_password = adminPassword;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public Integer getAdmin_status() {
		return admin_status;
	}
	public void setAdmin_status(Integer adminStatus) {
		admin_status = adminStatus;
	}
	public String getRighttree() {
		return righttree;
	}
	public void setRighttree(String righttree) {
		this.righttree = righttree;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	public Integer getDeptid() {
		return deptid;
	}
	public void setDeptid(Integer deptid) {
		this.deptid = deptid;
	}
	public Department getDepts() {
		return depts;
	}
	public void setDepts(Department depts) {
		this.depts = depts;
	}
	
	
}
