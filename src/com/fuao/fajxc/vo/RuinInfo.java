package com.fuao.fajxc.vo;

/**
 * RuinInfo entity. @author MyEclipse Persistence Tools
 */

public class RuinInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Ruin ruin;
	private Product product;
	private Double price;
	private String describes;
	private String disposeManner;

	// Constructors

	/** default constructor */
	public RuinInfo() {
	}

	/** full constructor */
	public RuinInfo(Ruin ruin, Product product, Double price, String describes,
			String disposeManner) {
		this.ruin = ruin;
		this.product = product;
		this.price = price;
		this.describes = describes;
		this.disposeManner = disposeManner;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Ruin getRuin() {
		return this.ruin;
	}

	public void setRuin(Ruin ruin) {
		this.ruin = ruin;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	

	public String getDescribes() {
		return describes;
	}

	public void setDescribes(String describes) {
		this.describes = describes;
	}

	public String getDisposeManner() {
		return this.disposeManner;
	}

	public void setDisposeManner(String disposeManner) {
		this.disposeManner = disposeManner;
	}

}