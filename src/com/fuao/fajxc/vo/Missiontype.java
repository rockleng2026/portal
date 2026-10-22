package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * Missiontype entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Missiontype implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer superid;
	private String describes;
	private Date buildTime;
	private String sbh;
	private int isflag; // 标识是什么类型
	private String spellflag; // 拼音唯一标识
	private String tmp;
	private String tmp1;
	private String tmp2;
	private List<Missiontype> child = new ArrayList<Missiontype>();
	private String tmp3;
	private Set missions = new HashSet(0);
	//类型对项目 一对多
	private Set projects = new HashSet();
    private Set operationgroup=new HashSet();
    private Set paymentlog = new HashSet(0);
	// Constructors

	/** default constructor */
	public Missiontype() {
	}

	public Missiontype(Integer id) {
		super();
		this.id = id;
	}

	/** full constructor */
	public Missiontype(String name, Integer superid, String describes,
			Date buildTime, String tmp, String tmp1, String tmp2, String tmp3,
			Set missions) {
		this.name = name;
		this.superid = superid;
		this.describes = describes;
		this.buildTime = buildTime;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
		this.missions = missions;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}


	public Set getOperationgroup() {
		return operationgroup;
	}

	public void setOperationgroup(Set operationgroup) {
		this.operationgroup = operationgroup;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSuperid() {
		return this.superid;
	}

	public void setSuperid(Integer superid) {
		this.superid = superid;
	}

	public String getDescribes() {
		return this.describes;
	}

	public void setDescribes(String describes) {
		this.describes = describes;
	}

	public Date getBuildTime() {
		return this.buildTime;
	}

	public void setBuildTime(Date buildTime) {
		this.buildTime = buildTime;
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

	public Set getMissions() {
		return this.missions;
	}

	public void setMissions(Set missions) {
		this.missions = missions;
	}

	public List<Missiontype> getChild() {
		return child;
	}

	public void setChild(List<Missiontype> child) {
		this.child = child;
	}

	public String getSbh() {
		return sbh;
	}

	public void setSbh(String sbh) {
		this.sbh = sbh;
	}

	public int getIsflag() {
		return isflag;
	}

	public void setIsflag(int isflag) {
		this.isflag = isflag;
	}

	public String getSpellflag() {
		return spellflag;
	}

	public void setSpellflag(String spellflag) {
		this.spellflag = spellflag;
	}

	public Set getProjects() {
		return projects;
	}

	public void setProjects(Set projects) {
		this.projects = projects;
	}

	public Set getPaymentlog() {
		return paymentlog;
	}

	public void setPaymentlog(Set paymentlog) {
		this.paymentlog = paymentlog;
	}
	
}