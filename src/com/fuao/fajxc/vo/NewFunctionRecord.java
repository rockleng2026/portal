package com.fuao.fajxc.vo;

import java.util.Date;

public class NewFunctionRecord implements java.io.Serializable{
	/**
	 * 项目任务移交记录表
	 */
	private Integer id; 
	private NewFunction function;
	private Employee oldemp;// 旧负责人
	private Employee newemp;// 新负责人
	private Date turntime;// 移交的时间
	public NewFunctionRecord() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NewFunctionRecord(Integer id, NewFunction function, Employee oldemp,
			Employee newemp, Date turntime) {
		super();
		this.id = id;
		this.function = function;
		this.oldemp = oldemp;
		this.newemp = newemp;
		this.turntime = turntime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public NewFunction getFunction() {
		return function;
	}
	public void setFunction(NewFunction function) {
		this.function = function;
	}
	public Employee getOldemp() {
		return oldemp;
	}
	public void setOldemp(Employee oldemp) {
		this.oldemp = oldemp;
	}
	public Employee getNewemp() {
		return newemp;
	}
	public void setNewemp(Employee newemp) {
		this.newemp = newemp;
	}
	public Date getTurntime() {
		return turntime;
	}
	public void setTurntime(Date turntime) {
		this.turntime = turntime;
	}
	
}
