package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * PurOrderInfo entity. @author MyEclipse Persistence Tools
 */

public class PurOrderInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private PurOrder purOrder;
	private Model model;
	private Integer count;
	private Double price;
	private Double discount;
	private Double sum;
	private Integer priceDelflag;
	private Integer actualcounnt;
	private Set toOrderprinfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public PurOrderInfo() {
	}

	/** full constructor */
	public PurOrderInfo(PurOrder purOrder, Model model, Integer count,
			Double price, Double discount, Double sum, Integer priceDelflag,
			Integer actualcounnt, Set toOrderprinfos) {
		this.purOrder = purOrder;
		this.model = model;
		this.count = count;
		this.price = price;
		this.discount = discount;
		this.sum = sum;
		this.priceDelflag = priceDelflag;
		this.actualcounnt = actualcounnt;
		this.toOrderprinfos = toOrderprinfos;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public PurOrder getPurOrder() {
		return this.purOrder;
	}

	public void setPurOrder(PurOrder purOrder) {
		this.purOrder = purOrder;
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

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
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

	public Integer getPriceDelflag() {
		return this.priceDelflag;
	}

	public void setPriceDelflag(Integer priceDelflag) {
		this.priceDelflag = priceDelflag;
	}

	public Integer getActualcounnt() {
		return this.actualcounnt;
	}

	public void setActualcounnt(Integer actualcounnt) {
		this.actualcounnt = actualcounnt;
	}

	public Set getToOrderprinfos() {
		return this.toOrderprinfos;
	}

	public void setToOrderprinfos(Set toOrderprinfos) {
		this.toOrderprinfos = toOrderprinfos;
	}

}