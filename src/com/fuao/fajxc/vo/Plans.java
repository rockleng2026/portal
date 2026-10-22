package com.fuao.fajxc.vo;

import java.util.Date;

/**
 * Plans entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Plans implements java.io.Serializable {

	// Fields

	private Integer id;
	private Mission mission;
	private String name;
	private String status;
	private String isfeedback;
	private String feedback;
	private Date startTime;
	private Date expEndTime;
	private Date endTime;
	private String description;
	private String sbh;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;

	// Constructors

	/** default constructor */
	public Plans() {
	}

	/** minimal constructor */
	public Plans(String name) {
		this.name = name;
	}

	/** full constructor */
	public Plans(Mission mission, String name, String status,
			String isfeedback, String feedback, Date startTime,
			Date expEndTime, Date endTime, String description, String tmp,
			String tmp1, String tmp2, String tmp3) {
		this.mission = mission;
		this.name = name;
		this.status = status;
		this.isfeedback = isfeedback;
		this.feedback = feedback;
		this.startTime = startTime;
		this.expEndTime = expEndTime;
		this.endTime = endTime;
		this.description = description;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Mission getMission() {
		return this.mission;
	}

	public void setMission(Mission mission) {
		this.mission = mission;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsfeedback() {
		return this.isfeedback;
	}

	public void setIsfeedback(String isfeedback) {
		this.isfeedback = isfeedback;
	}

	public String getFeedback() {
		return this.feedback;
	}

	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getExpEndTime() {
		return this.expEndTime;
	}

	public void setExpEndTime(Date expEndTime) {
		this.expEndTime = expEndTime;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
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

	public String getSbh() {
		return sbh;
	}

	public void setSbh(String sbh) {
		this.sbh = sbh;
	}

}