package com.fuao.fajxc.vo;

/**
 * Cdnprice entity. @author MyEclipse Persistence Tools
 */

public class Cdnprice implements java.io.Serializable {

	// Fields

	private Integer id;
	private Productproperty productproperty;
	private RealmType realmtype;
	private Float flow;
	private Float bandwidth;
	private Float hitnum;
	private Integer delflag;

	// Constructors

	/** default constructor */
	public Cdnprice() {
	}

	/** full constructor */
	public Cdnprice(Productproperty productproperty, RealmType realmtype,
			Float flow, Float bandwidth, Float hitnum, Integer delflag) {
		this.productproperty = productproperty;
		this.realmtype = realmtype;
		this.flow = flow;
		this.bandwidth = bandwidth;
		this.hitnum = hitnum;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Productproperty getProductproperty() {
		return this.productproperty;
	}

	public void setProductproperty(Productproperty productproperty) {
		this.productproperty = productproperty;
	}

	public RealmType getRealmtype() {
		return this.realmtype;
	}

	public void setRealmtype(RealmType realmtype) {
		this.realmtype = realmtype;
	}

	public Float getFlow() {
		return this.flow;
	}

	public void setFlow(Float flow) {
		this.flow = flow;
	}

	public Float getBandwidth() {
		return this.bandwidth;
	}

	public void setBandwidth(Float bandwidth) {
		this.bandwidth = bandwidth;
	}

	public Float getHitnum() {
		return this.hitnum;
	}

	public void setHitnum(Float hitnum) {
		this.hitnum = hitnum;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

}