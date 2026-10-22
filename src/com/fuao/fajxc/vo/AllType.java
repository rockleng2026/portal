package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * AllType entity. @author MyEclipse Persistence Tools
 */

public class AllType implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer type;
	private String typeName;
	private Set saleOrdersForPayStyle = new HashSet(0);
	private Set saleOrdersForPayStatus = new HashSet(0);
	private Set batchexps = new HashSet(0);
	private Set storages = new HashSet(0);
	private Set downServers = new HashSet(0);
	private Set outbounds = new HashSet(0);

	// Constructors

	/** default constructor */
	public AllType() {
	}

	/** minimal constructor */
	public AllType(Integer type) {
		this.type = type;
	}

	/** full constructor */
	public AllType(Integer type, String typeName, Set saleOrdersForPayStyle,
			Set saleOrdersForPayStatus, Set batchexps, Set storages,
			Set saleOrdersForOrdertype, Set downServers, Set outbounds) {
		this.type = type;
		this.typeName = typeName;
		this.saleOrdersForPayStyle = saleOrdersForPayStyle;
		this.saleOrdersForPayStatus = saleOrdersForPayStatus;
		this.batchexps = batchexps;
		this.storages = storages;
		this.downServers = downServers;
		this.outbounds = outbounds;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Set getSaleOrdersForPayStyle() {
		return this.saleOrdersForPayStyle;
	}

	public void setSaleOrdersForPayStyle(Set saleOrdersForPayStyle) {
		this.saleOrdersForPayStyle = saleOrdersForPayStyle;
	}

	public Set getSaleOrdersForPayStatus() {
		return this.saleOrdersForPayStatus;
	}

	public void setSaleOrdersForPayStatus(Set saleOrdersForPayStatus) {
		this.saleOrdersForPayStatus = saleOrdersForPayStatus;
	}

	public Set getBatchexps() {
		return this.batchexps;
	}

	public void setBatchexps(Set batchexps) {
		this.batchexps = batchexps;
	}

	public Set getStorages() {
		return this.storages;
	}

	public void setStorages(Set storages) {
		this.storages = storages;
	}

	public Set getDownServers() {
		return this.downServers;
	}

	public void setDownServers(Set downServers) {
		this.downServers = downServers;
	}

	public Set getOutbounds() {
		return this.outbounds;
	}

	public void setOutbounds(Set outbounds) {
		this.outbounds = outbounds;
	}

}