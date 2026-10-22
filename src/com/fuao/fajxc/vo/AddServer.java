package com.fuao.fajxc.vo;

/**
 * AddServer entity. @author MyEclipse Persistence Tools
 */

public class AddServer implements java.io.Serializable {

	// Fields

	private Integer id;
	private SaleOrder saleOrder;
	private String proServerId;
	private String addProid;
	private Double price;
	private String time;
	private String employee;
	private String delflag;

	// Constructors

	/** default constructor */
	public AddServer() {
	}

	/** full constructor */
	public AddServer(SaleOrder saleOrder, String proServerId, String addProid,
			Double price, String time, String employee, String delflag) {
		this.saleOrder = saleOrder;
		this.proServerId = proServerId;
		this.addProid = addProid;
		this.price = price;
		this.time = time;
		this.employee = employee;
		this.delflag = delflag;
	}

	// Property accessors    

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SaleOrder getSaleOrder() {
		return this.saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public String getProServerId() {
		return this.proServerId;
	}

	public void setProServerId(String proServerId) {
		this.proServerId = proServerId;
	}

	public String getAddProid() {
		return this.addProid;
	}

	public void setAddProid(String addProid) {
		this.addProid = addProid;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getEmployee() {
		return this.employee;
	}

	public void setEmployee(String employee) {
		this.employee = employee;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}