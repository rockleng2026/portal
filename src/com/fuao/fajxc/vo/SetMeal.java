package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Setmeal entity. @author MyEclipse Persistence Tools
 */

public class SetMeal implements java.io.Serializable {

	// Fields

	private Integer id;
	private Ordertype ordertype;
	private RealmType realmtype;
	private String name;
	private String starttime;
	private String endtime;
	private String usetime;
	private String describe;
	private Float price;
	private String chargeType;
	private Float payprice;
	private Integer delflag;
	private Set saleordercenters = new HashSet(0);
	private Set setmealcenters = new HashSet(0);

	// Constructors

	/** default constructor */
	public SetMeal() {
	}

	/** full constructor */
	public SetMeal(Ordertype ordertype,RealmType realmtype, String name, String starttime,
			String endtime, String usetime, String describe, Float price,
			String chargeType, Float payprice, Integer delflag,
			Set saleordercenters, Set setmealcenters) {
		this.ordertype = ordertype;
		this.realmtype = realmtype;
		this.name = name;
		this.starttime = starttime;
		this.endtime = endtime;
		this.usetime = usetime;
		this.describe = describe;
		this.price = price;
		this.chargeType = chargeType;
		this.payprice = payprice;
		this.delflag = delflag;
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
	public RealmType getRealmtype() {
		return this.realmtype;
	}

	public void setRealmtype(RealmType realmtype) {
		this.realmtype = realmtype;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStarttime() {
		return this.starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return this.endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getUsetime() {
		return this.usetime;
	}

	public void setUsetime(String usetime) {
		this.usetime = usetime;
	}

	public String getDescribe() {
		return this.describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public Float getPrice() {
		return this.price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public String getChargeType() {
		return this.chargeType;
	}

	public void setChargeType(String chargeType) {
		this.chargeType = chargeType;
	}

	public Float getPayprice() {
		return this.payprice;
	}

	public void setPayprice(Float payprice) {
		this.payprice = payprice;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
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