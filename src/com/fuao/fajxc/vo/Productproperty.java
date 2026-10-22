package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Productproperty entity. @author MyEclipse Persistence Tools
 */

public class Productproperty implements java.io.Serializable {

	// Fields

	private Integer id;
	private Ordertype ordertype;
	private Product product;
	private String name;
	private Float price;
	private Float flow;
	private Float bandwidth;
	private Integer hitnum;
	private String temp1;
	private String temp2;
	private String temp3;
	private Integer delflag;
	private Set cdnprices = new HashSet(0);
	private Set saleordercenters = new HashSet(0);
	private Set setmealcenters = new HashSet(0);

	// Constructors

	/** default constructor */
	public Productproperty() {
	}

	/** full constructor */
	public Productproperty(Ordertype ordertype,Product product, String name, Float price,
			Float flow, Float bandwidth, Integer hitnum, String temp1,
			String temp2, String temp3, Integer delflag, Set cdnprices,
			Set saleordercenters, Set setmealcenters) {
		this.ordertype = ordertype;
		this.product = product;
		this.name = name;
		this.price = price;
		this.flow = flow;
		this.bandwidth = bandwidth;
		this.hitnum = hitnum;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.delflag = delflag;
		this.cdnprices = cdnprices;
		this.saleordercenters = saleordercenters;
		this.setmealcenters = setmealcenters;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	public Ordertype getOrdertype() {
		return this.ordertype;
	}

	public void setOrdertype(Ordertype ordertype) {
		this.ordertype = ordertype;
	}
	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Float getPrice() {
		return this.price;
	}

	public void setPrice(Float price) {
		this.price = price;
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

	public Integer getHitnum() {
		return this.hitnum;
	}

	public void setHitnum(Integer hitnum) {
		this.hitnum = hitnum;
	}

	public String getTemp1() {
		return this.temp1;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}

	public String getTemp2() {
		return this.temp2;
	}

	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}

	public String getTemp3() {
		return this.temp3;
	}

	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public Set getCdnprices() {
		return this.cdnprices;
	}

	public void setCdnprices(Set cdnprices) {
		this.cdnprices = cdnprices;
	}

	public Set getSaleordercenters() {
		return this.saleordercenters;
	}

	public void setSaleordercenters(Set saleordercenters) {
		this.saleordercenters = saleordercenters;
	}

	public Set getSetmealcenters() {
		return this.setmealcenters;
	}

	public void setSetmealcenters(Set setmealcenters) {
		this.setmealcenters = setmealcenters;
	}

}