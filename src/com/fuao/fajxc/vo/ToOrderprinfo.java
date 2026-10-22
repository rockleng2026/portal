package com.fuao.fajxc.vo;

/**
 * ToOrderprinfo entity. @author MyEclipse Persistence Tools
 */

public class ToOrderprinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private ToOrder toOrder;
	private PurOrderInfo purOrderInfo;
	private String realitynum;
	private String character;
	private String remark;

	// Constructors

	/** default constructor */
	public ToOrderprinfo() {
	}

	/** full constructor */
	public ToOrderprinfo(ToOrder toOrder, PurOrderInfo purOrderInfo,
			String realitynum, String character, String remark) {
		this.toOrder = toOrder;
		this.purOrderInfo = purOrderInfo;
		this.realitynum = realitynum;
		this.character = character;
		this.remark = remark;
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

	public PurOrderInfo getPurOrderInfo() {
		return this.purOrderInfo;
	}

	public void setPurOrderInfo(PurOrderInfo purOrderInfo) {
		this.purOrderInfo = purOrderInfo;
	}

	public String getRealitynum() {
		return this.realitynum;
	}

	public void setRealitynum(String realitynum) {
		this.realitynum = realitynum;
	}

	public String getCharacter() {
		return this.character;
	}

	public void setCharacter(String character) {
		this.character = character;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}