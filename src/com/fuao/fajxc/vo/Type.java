package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Type entity. @author MyEclipse Persistence Tools
 */

public class Type implements java.io.Serializable {

	// Fields

	private Integer id;
	private String typename;
	private String temp;
	private String temp1;
	private Integer delflag;
	private Set caches = new HashSet(0);

	// Constructors

	/** default constructor */
	public Type() {
	}

	/** full constructor */
	public Type(String typename, String temp, String temp1, Integer delflag,
			Set caches) {
		this.typename = typename;
		this.temp = temp;
		this.temp1 = temp1;
		this.delflag = delflag;
		this.caches = caches;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTypename() {
		return this.typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
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

	public Set getCaches() {
		return this.caches;
	}

	public void setCaches(Set caches) {
		this.caches = caches;
	}

}