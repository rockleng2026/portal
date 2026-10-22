package com.fuao.fajxc.vo;

import java.util.Date;

/**
 * MissionEmp entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionEmp implements java.io.Serializable {

	// Fields

	// Fields

	private Integer id;
	private Mission mission;
	private Employee employee;
	private Date buildTime;
	private Date receiveTime;
	private Date completeTime;
	private String completeDescribe;
	private String status;
	private String sbh;
	private String completeFjbs;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;

	// Constructors

	/** default constructor */
	public MissionEmp() {
	}
	
	public MissionEmp(Integer id) {
		super();
		this.id = id;
	}


	/** full constructor */
	public MissionEmp(Integer taskId, Mission mission, Employee employee,
			Date receiveTime, Date completeTime, String status, String tmp,
			String tmp1, String tmp2, String tmp3) {
		this.id = taskId;
		this.mission = mission;
		this.employee = employee;
		this.receiveTime = receiveTime;
		this.completeTime = completeTime;
		this.status = status;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
	}

	// Property accessors

	

	public Mission getMission() {
		return this.mission;
	}

	public void setMission(Mission mission) {
		this.mission = mission;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Date getReceiveTime() {
		return this.receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}

	public Date getCompleteTime() {
		return this.completeTime;
	}

	public void setCompleteTime(Date completeTime) {
		this.completeTime = completeTime;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTmp() {
		return this.tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

	public String getTmp1() {
		return this.tmp1;
	}

	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}

	public String getTmp2() {
		return this.tmp2;
	}

	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}

	public String getTmp3() {
		return this.tmp3;
	}

	public void setTmp3(String tmp3) {
		this.tmp3 = tmp3;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getBuildTime() {
		return buildTime;
	}

	public void setBuildTime(Date buildTime) {
		this.buildTime = buildTime;
	}

	public String getCompleteDescribe() {
		return completeDescribe;
	}

	public void setCompleteDescribe(String completeDescribe) {
		this.completeDescribe = completeDescribe;
	}

	public String getSbh() {
		return sbh;
	}

	public void setSbh(String sbh) {
		this.sbh = sbh;
	}

	public String getCompleteFjbs() {
		return completeFjbs;
	}

	public void setCompleteFjbs(String completeFjbs) {
		this.completeFjbs = completeFjbs;
	}

}