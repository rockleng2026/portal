package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * Priceregulation entity. @author MyEclipse Persistence Tools
 */

public class Priceregulation implements java.io.Serializable {

	// Fields

	private Integer id;
	private Model model;
	private Employee employee;
	private Double importprice;
	private Double saleprice;
	private Timestamp rtime;
	private Integer delflag;
	private Integer auditingState;
	private String priceRegNo;

	// Constructors

	/** default constructor */
	public Priceregulation() {
	}

	/** full constructor */
	public Priceregulation(Model model, Employee employee, Double importprice,
			Double saleprice, Timestamp rtime, Integer delflag,Integer auditingState,String priceRegNo) {
		this.model = model;
		this.employee = employee;
		this.importprice = importprice;
		this.saleprice = saleprice;
		this.rtime = rtime;
		this.delflag = delflag;
		this.auditingState=auditingState;
		this.priceRegNo=priceRegNo;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Double getImportprice() {
		return this.importprice;
	}

	public void setImportprice(Double importprice) {
		this.importprice = importprice;
	}

	public Double getSaleprice() {
		return this.saleprice;
	}

	public void setSaleprice(Double saleprice) {
		this.saleprice = saleprice;
	}

	public Timestamp getRtime() {
		return this.rtime;
	}

	public void setRtime(Timestamp rtime) {
		this.rtime = rtime;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public Integer getAuditingState() {
		return auditingState;
	}

	public void setAuditingState(Integer auditingState) {
		this.auditingState = auditingState;
	}

	public String getPriceRegNo() {
		return priceRegNo;
	}

	public void setPriceRegNo(String priceRegNo) {
		this.priceRegNo = priceRegNo;
	}
	
	

}