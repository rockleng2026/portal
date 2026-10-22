package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * State entity. @author MyEclipse Persistence Tools
 */

public class State implements java.io.Serializable {

	// Fields

	private Integer id;
	private String statedeail;
	private String temp1;
	private String temp2;
	private String temp3;
	private Integer delflag;
	private Set saleordersForPaytypeid = new HashSet(0);
	private Set saleordersForAutidingstateid = new HashSet(0);
	private Set saleordersForPaystateid = new HashSet(0);

	// Constructors

	/** default constructor */
	public State() {
	}

	/** full constructor */
	public State(String statedeail, String temp1, String temp2, String temp3,
			Integer delflag, Set saleordersForPaytypeid,
			Set saleordersForAutidingstateid, Set saleordersForPaystateid) {
		this.statedeail = statedeail;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.delflag = delflag;
		this.saleordersForPaytypeid = saleordersForPaytypeid;
		this.saleordersForAutidingstateid = saleordersForAutidingstateid;
		this.saleordersForPaystateid = saleordersForPaystateid;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStatedeail() {
		return this.statedeail;
	}

	public void setStatedeail(String statedeail) {
		this.statedeail = statedeail;
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

	public Set getSaleordersForPaytypeid() {
		return this.saleordersForPaytypeid;
	}

	public void setSaleordersForPaytypeid(Set saleordersForPaytypeid) {
		this.saleordersForPaytypeid = saleordersForPaytypeid;
	}

	public Set getSaleordersForAutidingstateid() {
		return this.saleordersForAutidingstateid;
	}

	public void setSaleordersForAutidingstateid(Set saleordersForAutidingstateid) {
		this.saleordersForAutidingstateid = saleordersForAutidingstateid;
	}

	public Set getSaleordersForPaystateid() {
		return this.saleordersForPaystateid;
	}

	public void setSaleordersForPaystateid(Set saleordersForPaystateid) {
		this.saleordersForPaystateid = saleordersForPaystateid;
	}

}