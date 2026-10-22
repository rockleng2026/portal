package com.fuao.fajxc.vo;

public class NewPrjtresource {

	// 项目消费记录
	private Integer id;
	private NewTask task;// 任务外键
	private Employee empsubmit;// 提交人
	private Employee emp;// 审批人
	private Integer tplan;// 任务进度
	private String subtime;// 办理任务提交的时间
	private String nfj;// 附件
	private String remakes;// 描述
	private double nmoney;// 提交金额
	private Integer appstatus;//审批状态
	private String temp1;// 备用字段1
	private String temp2;// 备用字段2
	private String temp3;// 备用字段3

	public NewPrjtresource() {

	}

	public NewPrjtresource(Integer id, NewTask task,
			Employee empsubmit, Employee emp, Integer tplan, String subtime,
			String nfj,String remakes,double nmoney,String temp1,String temp2,String temp3)
	{
		this.id= id;
		this.task=task;
		this.empsubmit = empsubmit;
		this.emp = emp;
		this.tplan = tplan;
		this.subtime=subtime;
		this.nfj = nfj;
		this.remakes = remakes;
		this.nmoney = nmoney;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public NewTask getTask() {
		return task;
	}

	public void setTask(NewTask task) {
		this.task = task;
	}

	public Employee getEmpsubmit() {
		return empsubmit;
	}

	public void setEmpsubmit(Employee empsubmit) {
		this.empsubmit = empsubmit;
	}

	public Employee getEmp() {
		return emp;
	}

	public void setEmp(Employee emp) {
		this.emp = emp;
	}

	public Integer getTplan() {
		return tplan;
	}

	public void setTplan(Integer tplan) {
		this.tplan = tplan;
	}

	public String getSubtime() {
		return subtime;
	}

	public void setSubtime(String subtime) {
		this.subtime = subtime;
	}

	public String getNfj() {
		return nfj;
	}

	public void setNfj(String nfj) {
		this.nfj = nfj;
	}

	public String getRemakes() {
		return remakes;
	}

	public void setRemakes(String remakes) {
		this.remakes = remakes;
	}

	public double getNmoney() {
		return nmoney;
	}

	public void setNmoney(double nmoney) {
		this.nmoney = nmoney;
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

	public String getTemp3() {
		return temp3;
	}

	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}

	public Integer getAppstatus() {
		return appstatus;
	}

	public void setAppstatus(Integer appstatus) {
		this.appstatus = appstatus;
	}
	
	

}
