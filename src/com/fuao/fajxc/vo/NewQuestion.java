package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class NewQuestion implements java.io.Serializable{
	/**
	 * 项目问题
	 */
	private Integer id;
	private String questionname; //问题名称
	private Integer pid; //问题所属项目
	private String lastdate; //最后处理期限
	private String questioninfo; //问题描述
	private Integer handlestatus; //处理状态
	private Employee employee;//问题提出人
	private Integer indexdemos;//所属问题(索引)
	private String fj;//附件上传
	private String temp1;//备用字段1
	private String temp2;//备用字段2
	private String temp3;//备用字段3
	private Set newproblem = new HashSet(0);
	
	public NewQuestion(){}
	public NewQuestion(Integer id, String questionname,Integer pid, String lastdate, String questioninfo,
			Integer hanlepeople, Integer handlestatus,Employee employee,Integer indexdemos,Set newproblem,String fj,String temp1,String temp2,String temp3) {
		this.id = id;
		this.questionname = questionname;
		this.pid = pid;
		this.lastdate = lastdate;
		this.questioninfo = questioninfo;
		this.handlestatus = handlestatus;
		this.employee = employee;
		this.indexdemos = indexdemos;
		this.newproblem = newproblem;
		this.fj=fj;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getQuestionname() {
		return questionname;
	}

	public void setQuestionname(String questionname) {
		this.questionname = questionname;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getLastdate() {
		return lastdate;
	}

	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}

	public String getQuestioninfo() {
		return questioninfo;
	}

	public void setQuestioninfo(String questioninfo) {
		this.questioninfo = questioninfo;
	}

	public Integer getHandlestatus() {
		return handlestatus;
	}

	public void setHandlestatus(Integer handlestatus) {
		this.handlestatus = handlestatus;
	}

	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Set getNewproblem() {
		return newproblem;
	}
	public void setNewproblem(Set newproblem) {
		this.newproblem = newproblem;
	}
	public Integer getIndexdemos() {
		return indexdemos;
	}
	public void setIndexdemos(Integer indexdemos) {
		this.indexdemos = indexdemos;
	}
	public String getFj() {
		return fj;
	}
	public void setFj(String fj) {
		this.fj = fj;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	public String getTemp3() {
		return temp3;
	}
	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}
	
	
}
