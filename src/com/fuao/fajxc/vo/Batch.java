package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * Batch entity. @author MyEclipse Persistence Tools
 */

public class Batch implements java.io.Serializable {

	// Fields

	private String batchId;
	private Double price;
	private Timestamp time;
	private String delflag;

	// Constructors

	/** default constructor */
	public Batch() {
	}

	/** full constructor */
	public Batch(Double price, Timestamp time, String delflag) {
		this.price = price;
		this.time = time;
		this.delflag = delflag;
	}

	// Property accessors

	public String getBatchId() {
		return this.batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}