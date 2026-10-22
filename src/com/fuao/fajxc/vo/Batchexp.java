package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Batchexp entity. @author MyEclipse Persistence Tools
 */

public class Batchexp implements java.io.Serializable {

	// Fields

	private Integer id;
	private ToOrder toOrder;
	private AllType allType;
	private Model model;
	private CommodityTpye commodityTpye;
	private Double price;
	private Integer count;
	private Integer purcount;
	private Double discount;
	private Double sum;
	private Integer remark;
	private String audit;
	private String delflag;
	private Set storageInfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Batchexp() {
	}

	/** minimal constructor */
	public Batchexp(ToOrder toOrder, AllType allType,
			CommodityTpye commodityTpye) {
		this.toOrder = toOrder;
		this.allType = allType;
		this.commodityTpye = commodityTpye;
	}

	/** full constructor */
	public Batchexp(ToOrder toOrder, AllType allType, Model model,
			CommodityTpye commodityTpye, Double price, Integer count,
			Integer purcount, Double discount, Double sum, Integer remark,
			String audit, String delflag, Set storageInfos) {
		this.toOrder = toOrder;
		this.allType = allType;
		this.model = model;
		this.commodityTpye = commodityTpye;
		this.price = price;
		this.count = count;
		this.purcount = purcount;
		this.discount = discount;
		this.sum = sum;
		this.remark = remark;
		this.audit = audit;
		this.delflag = delflag;
		this.storageInfos = storageInfos;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ToOrder getToOrder() {
		return this.toOrder;
	}

	public void setToOrder(ToOrder toOrder) {
		this.toOrder = toOrder;
	}

	public AllType getAllType() {
		return this.allType;
	}

	public void setAllType(AllType allType) {
		this.allType = allType;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public CommodityTpye getCommodityTpye() {
		return this.commodityTpye;
	}

	public void setCommodityTpye(CommodityTpye commodityTpye) {
		this.commodityTpye = commodityTpye;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getCount() {
		return this.count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getPurcount() {
		return this.purcount;
	}

	public void setPurcount(Integer purcount) {
		this.purcount = purcount;
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

	public Integer getRemark() {
		return this.remark;
	}

	public void setRemark(Integer remark) {
		this.remark = remark;
	}

	public String getAudit() {
		return this.audit;
	}

	public void setAudit(String audit) {
		this.audit = audit;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public Set getStorageInfos() {
		return this.storageInfos;
	}

	public void setStorageInfos(Set storageInfos) {
		this.storageInfos = storageInfos;
	}

}