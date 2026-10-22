package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Project implements Serializable{
	private Integer id; //主键
	private String prjname;  //项目名称
	private String prjmanager; //项目负责人
	private String prjtype; //项目类型
	private Date begintime; //开始时间
	private Date endtime; //结束时间
	private Date yjendtime; //预计结束时间
	private Integer prjplan; //进度
	private Integer deptid; //项目所属部门fd
	private String leadname; //领导名称
	private String leadevaluate;//领导评价
	private String prjdes; //项目描述
	private String prjfunction;//项目功能
	private Integer delflag; //是否删除 1删除 0未删除 默认0
	private Integer isapproval; //是否审批(1通过审批,0未通过 默认0)
	private String startperson;  //项目发起人
	private String annex; //附件
	private Set projectlead = new HashSet(0);
	private Set projectemp = new HashSet(0);
	
	private Department dept;
	
	public Project(){}
	public Project(Integer id, String prjname, String prjmanager,
			String prjtype, Date begintime, Date endtime, Date yjendtime,
			Integer prjplan, Integer deptid, String leadname,
			String leadevaluate, String prjdes, String prjfunction,
			Integer delflag, Integer isinvite, String invite, Integer isapproval,String startperson,String annex) {
		this.id = id;
		this.prjname = prjname;
		this.prjmanager = prjmanager;
		this.prjtype = prjtype;
		this.begintime = begintime;
		this.endtime = endtime;
		this.yjendtime = yjendtime;
		this.prjplan = prjplan;
		this.deptid = deptid;
		this.leadname = leadname;
		this.leadevaluate = leadevaluate;
		this.prjdes = prjdes;
		this.prjfunction = prjfunction;
		this.delflag = delflag;
		this.isapproval = isapproval;
		this.startperson=startperson;
		this.annex = annex;
	}
	
	
	public Set getProjectlead() {
		return projectlead;
	}
	public void setProjectlead(Set projectlead) {
		this.projectlead = projectlead;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPrjname() {
		return prjname;
	}
	public void setPrjname(String prjname) {
		this.prjname = prjname;
	}
	public String getPrjmanager() {
		return prjmanager;
	}
	public void setPrjmanager(String prjmanager) {
		this.prjmanager = prjmanager;
	}
	public String getPrjtype() {
		return prjtype;
	}
	public void setPrjtype(String prjtype) {
		this.prjtype = prjtype;
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
	public Date getYjendtime() {
		return yjendtime;
	}
	public void setYjendtime(Date yjendtime) {
		this.yjendtime = yjendtime;
	}
	public Integer getPrjplan() {
		return prjplan;
	}
	public void setPrjplan(Integer prjplan) {
		this.prjplan = prjplan;
	}
	public Integer getDeptid() {
		return deptid;
	}
	public void setDeptid(Integer deptid) {
		this.deptid = deptid;
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
	public String getPrjdes() {
		return prjdes;
	}
	public void setPrjdes(String prjdes) {
		this.prjdes = prjdes;
	}
	public String getPrjfunction() {
		return prjfunction;
	}
	public void setPrjfunction(String prjfunction) {
		this.prjfunction = prjfunction;
	}
	public Integer getDelflag() {
		return delflag;
	}
	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}
	public Integer getIsapproval() {
		return isapproval;
	}
	public void setIsapproval(Integer isapproval) {
		this.isapproval = isapproval;
	}
	public Department getDept() {
		return dept;
	}
	public void setDept(Department dept) {
		this.dept = dept;
	}
	public String getStartperson() {
		return startperson;
	}
	public void setStartperson(String startperson) {
		this.startperson = startperson;
	}
	public String getAnnex() {
		return annex;
	}
	public void setAnnex(String annex) {
		this.annex = annex;
	}
	public Set getProjectemp() {
		return projectemp;
	}
	public void setProjectemp(Set projectemp) {
		this.projectemp = projectemp;
	}
	
}
