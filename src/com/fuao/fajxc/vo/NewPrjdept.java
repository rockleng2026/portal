package com.fuao.fajxc.vo;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class NewPrjdept implements java.io.Serializable{
	private Integer id; 
	//部门
	private Department dept;
	//对项目
	private NewProject project;
	
	public NewPrjdept(){}
	public NewPrjdept(Integer id, Integer pid, Integer deptid) {
		this.id = id;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Department getDept() {
		return dept;
	}
	public void setDept(Department dept) {
		this.dept = dept;
	}
	
	public NewProject getProject() {
		return project;
	}
	public void setProject(NewProject project) {
		this.project = project;
	}

}
