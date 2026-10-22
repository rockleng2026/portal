package com.fuao.fajxc.vo;

/**
 * OutboundInfo entity. @author MyEclipse Persistence Tools
 */

public class OutboundInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Product product;
	private Outbound outbound;

	// Constructors

	/** default constructor */
	public OutboundInfo() {
	}

	/** full constructor */
	public OutboundInfo(Product product, Outbound outbound) {
		this.product = product;
		this.outbound = outbound;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Outbound getOutbound() {
		return this.outbound;
	}

	public void setOutbound(Outbound outbound) {
		this.outbound = outbound;
	}

}