package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class NewTask implements java.io.Serializable{
	/**
	 * 项目任务
	 */
	private Integer id;
	private Date begintime; //任务分配开始时间
	private Date endtime; //任务分配结束时间
	private Integer schedule; //任务进度
	private String fj; //上传附件
	private Employee emp;// 任务执行人
	private NewFunction function;
	private String temp;// 备用字段，暂时备用日志名称。
	private String temp1;// 备用字段，暂时备用日志编号。
	private Integer flag;// 删除的标识字段
	private Set newprjtresource = new HashSet();
	
	public Integer getSchedule() {
		return schedule;
	}
	public void setSchedule(Integer schedule) {
		this.schedule = schedule;
	}
	public NewTask(){}
	public NewTask(Integer id, Integer fid, Date begintime,
			Date endtime, Integer schedul, String fj) {
		this.id = id;
		this.begintime = begintime;
		this.endtime = endtime;
		this.schedule = schedul;
		this.fj = fj;
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
	
	public String getFj() {
		return fj;
	}
	public void setFj(String fj) {
		this.fj = fj;
	}
	public Employee getEmp() {
		return emp;
	}
	public void setEmp(Employee emp) {
		this.emp = emp;
	}
	public NewFunction getFunction() {
		return function;
	}
	public void setFunction(NewFunction function) {
		this.function = function;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public Set getNewprjtresource() {
		return newprjtresource;
	}
	public void setNewprjtresource(Set newprjtresource) {
		this.newprjtresource = newprjtresource;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	
}
