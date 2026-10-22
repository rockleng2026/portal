package com.fuao.fajxc.vo;

import java.io.Serializable;

public class Freeze implements Serializable{
	private Integer id;
	private Product product;
	private Integer freezeFlag;
	private String upNo;
	public Freeze(){}
	public Freeze(Integer id,Product product,Integer freezeFlag){
		this.id = id;
		this.product = product;
		this.freezeFlag = freezeFlag;
		this.upNo = upNo;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Integer getFreezeFlag() {
		return freezeFlag;
	}
	public void setFreezeFlag(Integer freezeFlag) {
		this.freezeFlag = freezeFlag;
	}
	public String getUpNo() {
		return upNo;
	}
	public void setUpNo(String upNo) {
		this.upNo = upNo;
	}
	
}
