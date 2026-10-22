package com.fuao.fajxc.vo;

/**
 * ApplyBuyinfo entity. @author MyEclipse Persistence Tools
 */

public class ApplyBuyinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private ApplyBuy applyBuy;
	private CommodityTpye commodityTpye;
	private Model model;
	private Integer count;
	private String del;

	// Constructors

	/** default constructor */
	public ApplyBuyinfo() {
	}

	/** minimal constructor */
	public ApplyBuyinfo(ApplyBuy applyBuy) {
		this.applyBuy = applyBuy;
	}

	/** full constructor */
	public ApplyBuyinfo(ApplyBuy applyBuy, CommodityTpye commodityTpye,
			Model model, Integer count, String del) {
		this.applyBuy = applyBuy;
		this.commodityTpye = commodityTpye;
		this.model = model;
		this.count = count;
		this.del = del;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ApplyBuy getApplyBuy() {
		return this.applyBuy;
	}

	public void setApplyBuy(ApplyBuy applyBuy) {
		this.applyBuy = applyBuy;
	}

	public CommodityTpye getCommodityTpye() {
		return this.commodityTpye;
	}

	public void setCommodityTpye(CommodityTpye commodityTpye) {
		this.commodityTpye = commodityTpye;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Integer getCount() {
		return this.count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

}