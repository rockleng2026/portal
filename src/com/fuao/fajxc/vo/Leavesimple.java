package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * 请假单的实体表。
 */

public class Leavesimple implements java.io.Serializable {

	private int id;
	private Date begintime;
	private Date endtime;
	private String content;
	private String manager;   // 经理签字
	private String superson;  // 主管签字
	private String admin;   //行政签字
	private int leavetype; // 请假类型
	private int empid;
	private String temp;
	
	public Leavesimple(int id, Date begintime, Date endtime, String content,
			String manager, String superson, String admin) {
		super();
		this.id = id;
		this.begintime = begintime;
		this.endtime = endtime;
		this.content = content;
		this.manager = manager;
		this.superson = superson;
		this.admin = admin;
	}
	public Leavesimple() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getSuperson() {
		return superson;
	}
	public void setSuperson(String superson) {
		this.superson = superson;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public int getEmpid() {
		return empid;
	}
	public void setEmpid(int empid) {
		this.empid = empid;
	}
	public int getLeavetype() {
		return leavetype;
	}
	public void setLeavetype(int leavetype) {
		this.leavetype = leavetype;
	}
	
}