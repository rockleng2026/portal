package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class ProjectEmp implements Serializable{
	private Integer id; //主键
	private String  prjrw;// 项目任务
	private Date prjbegintime;// 开始时间
	private Date prjendtime; // 结束时间
	private Date prjyjendtime;// 预计结束时间
	private Integer isinvite; //是否邀请(0没有  1为邀请)
	private String invite; //发送邀请原因
	private int prjempplan;// 每个人员完成的项目任务进度
	private int warn; // 预警级别
	private String leadname;// 领导名称
	private String leadevaluate;// 领导评价
	private String jobdes;// 任务描述	
	private Project prj;
	private Employee employee; 
	private Date prjuptime;// 获得修改项目的时间
	private Date prjvitetime;// 邀请参与人员的时间	
	private Set emplead = new HashSet(0);// 员工任务评价表
	
	public Set getEmplead() {
		return emplead;
	}
	public void setEmplead(Set emplead) {
		this.emplead = emplead;
	}
	public Date getPrjuptime() {
		return prjuptime;
	}
	public void setPrjuptime(Date prjuptime) {
		this.prjuptime = prjuptime;
	}
	public Date getPrjvitetime() {
		return prjvitetime;
	}
	public void setPrjvitetime(Date prjvitetime) {
		this.prjvitetime = prjvitetime;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Project getPrj() {
		return prj;
	}
	public void setPrj(Project prj) {
		this.prj = prj;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getPrjrw() {
		return prjrw;
	}
	public void setPrjrw(String prjrw) {
		this.prjrw = prjrw;
	}
	public Date getPrjbegintime() {
		return prjbegintime;
	}
	public void setPrjbegintime(Date prjbegintime) {
		this.prjbegintime = prjbegintime;
	}
	public Date getPrjendtime() {
		return prjendtime;
	}
	public void setPrjendtime(Date prjendtime) {
		this.prjendtime = prjendtime;
	}
	public Date getPrjyjendtime() {
		return prjyjendtime;
	}
	public void setPrjyjendtime(Date prjyjendtime) {
		this.prjyjendtime = prjyjendtime;
	}
	public Integer getIsinvite() {
		return isinvite;
	}
	public void setIsinvite(Integer isinvite) {
		this.isinvite = isinvite;
	}
	public String getInvite() {
		return invite;
	}
	public void setInvite(String invite) {
		this.invite = invite;
	}
	public int getPrjempplan() {
		return prjempplan;
	}
	public void setPrjempplan(int prjempplan) {
		this.prjempplan = prjempplan;
	}
	public int getWarn() {
		return warn;
	}
	public void setWarn(int warn) {
		this.warn = warn;
	}
	public String getLeadname() {
		return leadname;
	}
	public void setLeadname(String leadname) {
		this.leadname = leadname;
	}
	public String getLeadevaluate() {
		return leadevaluate;
	}
	public void setLeadevaluate(String leadevaluate) {
		this.leadevaluate = leadevaluate;
	}
	public String getJobdes() {
		return jobdes;
	}
	public void setJobdes(String jobdes) {
		this.jobdes = jobdes;
	}
	
	
	
}
