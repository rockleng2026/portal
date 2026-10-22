package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Realmtype entity. @author MyEclipse Persistence Tools
 */

public class RealmType implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String temp;
	private String temp1;
	private Integer delflag;
	private Set setmeals = new HashSet(0);
	private Set cdnprices = new HashSet(0);

	// Constructors

	/** default constructor */
	public RealmType() {
	}

	/** full constructor */
	public RealmType(String name, String temp, String temp1, 
			Integer delflag, Set setmeals, Set cdnprices) {
		this.name = name;
		this.temp = temp;
		this.temp1 = temp1;
		this.delflag = delflag;
		this.setmeals = setmeals;
		this.cdnprices = cdnprices;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTemp() {
		return this.temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

	public String getTemp1() {
		return this.temp1;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}



	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public Set getSetmeals() {
		return this.setmeals;
	}

	public void setSetmeals(Set setmeals) {
		this.setmeals = setmeals;
	}

	public Set getCdnprices() {
		return this.cdnprices;
	}

	public void setCdnprices(Set cdnprices) {
		this.cdnprices = cdnprices;
	}

}