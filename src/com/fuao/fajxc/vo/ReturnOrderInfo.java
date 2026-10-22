package com.fuao.fajxc.vo;

/**
 * ReturnOrderInfo entity. @author MyEclipse Persistence Tools
 */

public class ReturnOrderInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Batchexp batchexp;
	private Model model;
	private ReturnOrder returnOrder;
	private Integer count;
	private Double returnprice;
	private Double discount;
	private Double sum;
	private String remark;

	// Constructors

	/** default constructor */
	public ReturnOrderInfo() {
	}

	/** full constructor */
	public ReturnOrderInfo(Batchexp batchexp, Model model,
			ReturnOrder returnOrder, Integer count, Double returnprice,
			Double discount, Double sum, String remark) {
		this.batchexp = batchexp;
		this.model = model;
		this.returnOrder = returnOrder;
		this.count = count;
		this.returnprice = returnprice;
		this.discount = discount;
		this.sum = sum;
		this.remark = remark;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Batchexp getBatchexp() {
		return this.batchexp;
	}

	public void setBatchexp(Batchexp batchexp) {
		this.batchexp = batchexp;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public ReturnOrder getReturnOrder() {
		return this.returnOrder;
	}

	public void setReturnOrder(ReturnOrder returnOrder) {
		this.returnOrder = returnOrder;
	}

	public Integer getCount() {
		return this.count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Double getReturnprice() {
		return this.returnprice;
	}

	public void setReturnprice(Double returnprice) {
		this.returnprice = returnprice;
	}

	public Double getDiscount() {
		return this.discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public Double getSum() {
		return this.sum;
	}

	public void setSum(Double sum) {
		this.sum = sum;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}