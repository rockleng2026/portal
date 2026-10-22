package com.fuao.fajxc.vo;

import java.util.Date;

public class OperationDepartmentmatch {
	private int id;
	private double money;
	private String creatTime;
	private String explain;
	
	private Missiontype type;
	private Department dept;
	
	
	public OperationDepartmentmatch(int id,Missiontype type,Department dept,double money, String creatTime, String explain) {
		super();
		this.id = id;
		this.money = money;
		this.creatTime = creatTime;
		this.explain = explain;
		this.type=type;
		this.dept=dept;
	}
	public OperationDepartmentmatch() {
	
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public String getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public Missiontype getType() {
		return type;
	}
	public void setType(Missiontype type) {
		this.type = type;
	}
	public Department getDept() {
		return dept;
	}
	public void setDept(Department dept) {
		this.dept = dept;
	}
	
}
