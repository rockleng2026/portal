package com.fuao.fajxc.vo;

import java.util.Date;

public class NewApprove implements java.io.Serializable{
	/**
	 * 项目审批表
	 */
	public Integer id;
	//private Integer pid; //需要审批的项目 
	private Date begintime; //开始时间
	private Date endtime; //结束时间
	private Integer appstatus; //审批状态
	private String approveinfo; //审批意见
	private NewProject newproject;// 审批的项目
	private Employee applypeople;//　申请人
	private Employee approveemp; //　项目审批人
	private String appLD;// 审批领导
	private String temp;
	
	public NewApprove(){}
	public NewApprove(Integer id,  Integer applypeople,
			Date begintime, Date endtime, Integer appstatus,
			String approveinfo,String temp) {
		this.id = id;
		this.begintime = begintime;
		this.endtime = endtime;
		this.appstatus = appstatus;
		this.approveinfo = approveinfo;
		this.temp=temp;
	}

	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Integer getAppstatus() {
		return appstatus;
	}

	public void setAppstatus(Integer appstatus) {
		this.appstatus = appstatus;
	}

	public String getApproveinfo() {
		return approveinfo;
	}

	public void setApproveinfo(String approveinfo) {
		this.approveinfo = approveinfo;
	}
	public NewProject getNewproject() {
		return newproject;
	}
	public void setNewproject(NewProject newproject) {
		this.newproject = newproject;
	}
	public Employee getApplypeople() {
		return applypeople;
	}
	public void setApplypeople(Employee applypeople) {
		this.applypeople = applypeople;
	}
	public Employee getApproveemp() {
		return approveemp;
	}
	public void setApproveemp(Employee approveemp) {
		this.approveemp = approveemp;
	}
	public String getAppLD() {
		return appLD;
	}
	public void setAppLD(String appLD) {
		this.appLD = appLD;
	}
	
	
}
