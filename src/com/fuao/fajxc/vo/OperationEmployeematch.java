package com.fuao.fajxc.vo;

import java.util.Date;

public class OperationEmployeematch {
	private int id;
	private double money;
	private String creatTime;
	private String explain;
	private int temp;//员工业务标识 ---- -1为直接员工业务添加   其他数字为部门业务转过来的别且为该部门id

	private Missiontype type;
	private Employee employee;
	
	public OperationEmployeematch(int id,Missiontype type,Employee employee, double money,
			String creatTime, String explain,int temp) {
		super();
		this.id = id;
		this.type = type;
		this.employee = employee;
		this.money = money;
		this.creatTime = creatTime;
		this.explain = explain;
		this.temp=temp;
	}
	public OperationEmployeematch(){
		
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
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public int getTemp() {
		return temp;
	}
	public void setTemp(int temp) {
		this.temp = temp;
	}
	
}
