package com.fuao.fajxc.vo;

import java.util.Date;

public class NewWatch implements java.io.Serializable{
	private Integer id; //项目查看者
	//员工
	private Employee emp;
	//项目
	private NewProject project;
	private Integer suid;
	private Date wdate;
	
	public NewWatch(){}
	public NewWatch(Integer id,Integer pid,Integer empid){
		this.id=id;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Employee getEmp() {
		return emp;
	}
	public void setEmp(Employee emp) {
		this.emp = emp;
	}
	public NewProject getProject() {
		return project;
	}
	public void setProject(NewProject project) {
		this.project = project;
	}
	public Integer getSuid() {
		return suid;
	}
	public void setSuid(Integer suid) {
		this.suid = suid;
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	
}
