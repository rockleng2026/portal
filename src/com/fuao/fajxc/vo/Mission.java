package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Mission entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Mission implements java.io.Serializable {

	// Fields

	private Integer taskId;
	private Missiontype missiontype;
	private Employee employee;
	private String name;
	private Date expStartTime;
	private Date expEndTime;
	private Date buildTime;
	private Integer isSingle;
	private String description;
	private String status;
	private Date endTime;
	private String sbh;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;
	private String dueTime; //到期时间
	private Integer cycleType;//周期类型 
	
	public Integer getCycleType() {
		return cycleType;
	}

	public void setCycleType(Integer cycleType) {
		this.cycleType = cycleType;
	}

	public String getDueTime() {
		return dueTime;
	}

	public void setDueTime(String dueTime) {
		this.dueTime = dueTime;
	}

	private Set planses = new HashSet(0);
	private Set missionEmps = new HashSet(0);

	// Constructors

	/** default constructor */
	public Mission() {
	}

	public Mission(Integer taskId) {
		super();
		this.taskId = taskId;
	}

	/** minimal constructor */
	public Mission(String name) {
		this.name = name;
	}

	/** full constructor */
	public Mission(Missiontype missiontype, String name, Date expStartTime,
			Date expEndTime, Date buildTime, Integer isSingle,
			String description, String tmp, String tmp1, String tmp2,
			String tmp3, Set planses, Set missionEmps, String dueTime, Integer cycleType) {
		this.missiontype = missiontype;
		this.name = name;
		this.expStartTime = expStartTime;
		this.expEndTime = expEndTime;
		this.buildTime = buildTime;
		this.isSingle = isSingle;
		this.description = description;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
		this.planses = planses;
		this.missionEmps = missionEmps;
		this.dueTime = dueTime;
		this.cycleType = cycleType;
	}

	// Property accessors

	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public Missiontype getMissiontype() {
		return this.missiontype;
	}

	public void setMissiontype(Missiontype missiontype) {
		this.missiontype = missiontype;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getExpStartTime() {
		return this.expStartTime;
	}

	public void setExpStartTime(Date expStartTime) {
		this.expStartTime = expStartTime;
	}

	public Date getExpEndTime() {
		return this.expEndTime;
	}

	public void setExpEndTime(Date expEndTime) {
		this.expEndTime = expEndTime;
	}

	public Date getBuildTime() {
		return this.buildTime;
	}

	public void setBuildTime(Date buildTime) {
		this.buildTime = buildTime;
	}

	public Integer getIsSingle() {
		return this.isSingle;
	}

	public void setIsSingle(Integer isSingle) {
		this.isSingle = isSingle;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Set getPlanses() {
		return this.planses;
	}

	public void setPlanses(Set planses) {
		this.planses = planses;
	}

	public Set getMissionEmps() {
		return this.missionEmps;
	}

	public void setMissionEmps(Set missionEmps) {
		this.missionEmps = missionEmps;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getSbh() {
		return sbh;
	}

	public void setSbh(String sbh) {
		this.sbh = sbh;
	}

}