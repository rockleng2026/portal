package com.fuao.fajxc.vo;

import java.util.Date;

public class NewProblem implements java.io.Serializable{
	/**
	 * 项目问题、领导评价
	 */
	private Integer id;
	private String contents; //评价内容
	private String time;//评价时间
	private Integer problemortask;//属于问题还是任务(1问题，2员工任务，默认是0)
	private Integer isend; //是否结贴(默认是0，1结贴)
	private Integer count;//评价次数
	private NewQuestion newQuestion;//所属问题
	private Employee employee;//评价人
	private Scheduleplan scheduleplan;//便签(项目的便签)
	private String temp1; //备1
	private String temp2;//备2
	
	public NewProblem(){}
	public NewProblem(Integer id, String contents, String time,
			Integer problemortask, Integer isend, Integer pid, Integer count,NewQuestion newQuestion,Employee employee,Scheduleplan scheduleplan,
			String temp1,String temp2
	) {
		this.id = id;
		this.contents = contents;
		this.time = time;
		this.problemortask = problemortask;
		this.isend = isend;
		this.count = count;
		this.newQuestion = newQuestion;
		this.employee = employee;
		this.scheduleplan = scheduleplan;
		this.temp1 = temp1;
		this.temp2 = temp2;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public Integer getProblemortask() {
		return problemortask;
	}
	public void setProblemortask(Integer problemortask) {
		this.problemortask = problemortask;
	}
	public Integer getIsend() {
		return isend;
	}
	public void setIsend(Integer isend) {
		this.isend = isend;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public NewQuestion getNewQuestion() {
		return newQuestion;
	}
	public void setNewQuestion(NewQuestion newQuestion) {
		this.newQuestion = newQuestion;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}
	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}	
	
}
