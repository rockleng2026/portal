package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * StorageInfo entity. @author MyEclipse Persistence Tools
 */

public class StorageInfo implements java.io.Serializable {

	// Fields  入库详细

	private Integer storageInfoId;//入库详细ID
	private ToOrder toOrder;//报益单ID
	private Storage storage;//到货单ID
	private PurOrder purorder;//采购表ID，新增


	private Income income; //入库ID
	private Set products = new HashSet();

	// Constructors

	/** default constructor */
	public StorageInfo() {
	}

	/** minimal constructor */
	public StorageInfo(Storage storage) {
		this.storage = storage;
	}
	public PurOrder getPurorder() {
		return purorder;
	}

	public void setPurorder(PurOrder purorder) {
		this.purorder = purorder;
	}
	/** full constructor */
	public StorageInfo(ToOrder toOrder, PurOrder purorder,Storage storage, Income income) {
		this.toOrder = toOrder;
		this.storage = storage;
		this.purorder=purorder;
		this.income = income;
	}

	// Property accessors

	
	
	public Integer getStorageInfoId() {
		return this.storageInfoId;
	}

	public void setStorageInfoId(Integer storageInfoId) {
		this.storageInfoId = storageInfoId;
	}

	public ToOrder getToOrder() {
		return this.toOrder;
	}

	public void setToOrder(ToOrder toOrder) {
		this.toOrder = toOrder;
	}

	public Storage getStorage() {
		return this.storage;
	}

	public void setStorage(Storage storage) {
		this.storage = storage;
	}

	public Income getIncome() {
		return this.income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

	public Set getProducts() {
		return products;
	}

	public void setProducts(Set products) {
		this.products = products;
	}

}