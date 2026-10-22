package com.fuao.fajxc.vo;

/**
 * ProductType entity. @author MyEclipse Persistence Tools
 */

public class ProductType implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String delflag;

	// Constructors

	/** default constructor */
	public ProductType() {
	}

	/** full constructor */
	public ProductType(String name, String delflag) {
		this.name = name;
		this.delflag = delflag;
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

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}