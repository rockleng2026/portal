package com.fuao.fajxc.vo;

/**
 * ServerMonitor entity. @author MyEclipse Persistence Tools
 */

public class ServerMonitor implements java.io.Serializable {

	// Fields

	private Integer id;
	private Product product;
	private Employee employee;
	private String serverIp;
	private String time;
	private String monitorLog;
	private String delflag;

	// Constructors

	/** default constructor */
	public ServerMonitor() {
	}

	/** minimal constructor */
	public ServerMonitor(Product product) {
		this.product = product;
	}

	/** full constructor */
	public ServerMonitor(Product product, Employee employee, String serverIp,
			String time, String monitorLog, String delflag) {
		this.product = product;
		this.employee = employee;
		this.serverIp = serverIp;
		this.time = time;
		this.monitorLog = monitorLog;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getServerIp() {
		return this.serverIp;
	}

	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getMonitorLog() {
		return this.monitorLog;
	}

	public void setMonitorLog(String monitorLog) {
		this.monitorLog = monitorLog;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}