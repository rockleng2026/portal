package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class NewFunction implements java.io.Serializable{
	/**
	 * 项目功能
	 */
	private Integer id; 
	private String functionname;//功能名称
	//private Integer pid; 
	private Date begintime;//功能创建时间
	private Date endtime; // 功能结束时间
	private String functioninfo; //功能描述
	private String fj; //上传附件
	private Integer fstate;
	private NewProject newProject;//功能所属项目
	private Integer finishtasktype;// 任务完成类型,分协同完成任务（0）与独立完成任务（1）两种状态
	private Integer parentid;// 父类ID
	private Integer flag; // 删除的标识字段
	private Set task=new HashSet();// 任务
	private Set schedulplan=new HashSet(); // 日程计划表
	private Set functionrecord=new HashSet();
	private Set delrecord=new HashSet();// 删除任务记录表
	
	public NewFunction(){}
	public NewFunction(Integer id, String functionname,
			Date begintime, String functioninfo, String fj) {
		this.id = id;
		this.functionname = functionname;
		this.begintime = begintime;
		this.functioninfo = functioninfo;
		this.fj = fj;
	}

	public Integer getFstate() {
		return fstate;
	}
	public void setFstate(Integer fstate) {
		this.fstate = fstate;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFunctionname() {
		return functionname;
	}

	public void setFunctionname(String functionname) {
		this.functionname = functionname;
	}
	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public String getFunctioninfo() {
		return functioninfo;
	}

	public void setFunctioninfo(String functioninfo) {
		this.functioninfo = functioninfo;
	}

	public String getFj() {
		return fj;
	}

	public void setFj(String fj) {
		this.fj = fj;
	}

	public NewProject getNewProject() {
		return newProject;
	}
	public void setNewProject(NewProject newProject) {
		this.newProject = newProject;
	}
	public Set getTask() {
		return task;
	}
	public void setTask(Set task) {
		this.task = task;
	}
	public Set getSchedulplan() {
		return schedulplan;
	}
	public void setSchedulplan(Set schedulplan) {
		this.schedulplan = schedulplan;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public Set getFunctionrecord() {
		return functionrecord;
	}
	public void setFunctionrecord(Set functionrecord) {
		this.functionrecord = functionrecord;
	}
	public Integer getFinishtasktype() {
		return finishtasktype;
	}
	public void setFinishtasktype(Integer finishtasktype) {
		this.finishtasktype = finishtasktype;
	}
	public Integer getParentid() {
		return parentid;
	}
	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}
	public Set getDelrecord() {
		return delrecord;
	}
	public void setDelrecord(Set delrecord) {
		this.delrecord = delrecord;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	
}
