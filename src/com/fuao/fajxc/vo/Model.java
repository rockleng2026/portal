
package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Model entity. @author MyEclipse Persistence Tools
 */

public class Model implements java.io.Serializable {

	// Fields

	private Integer model;
	private CommodityTpye commodityTpye;
	private String name;
	private String delflag;
	private Set returnOrderInfos = new HashSet(0);
	private Set priceregulations = new HashSet(0);
	private Set incomeInfos = new HashSet(0);
	private Set assemblyServers = new HashSet(0);
	private Set applyBuyinfos = new HashSet(0);
	private Set purOrderInfos = new HashSet(0);
	private Set statInfos = new HashSet(0);
	private Set batchexps = new HashSet(0);
	private Set properties = new HashSet(0);

	// Constructors

	/** default constructor */
	public Model() {
	}

	/** full constructor */
	public Model(CommodityTpye commodityTpye, String name, String delflag,
			Set returnOrderInfos, Set priceregulations, Set incomeInfos,
			Set assemblyServers, Set applyBuyinfos, Set purOrderInfos,
			Set statInfos, Set batchexps, Set properties) {
		this.commodityTpye = commodityTpye;
		this.name = name;
		this.delflag = delflag;
		this.returnOrderInfos = returnOrderInfos;
		this.priceregulations = priceregulations;
		this.incomeInfos = incomeInfos;
		this.assemblyServers = assemblyServers;
		this.applyBuyinfos = applyBuyinfos;
		this.purOrderInfos = purOrderInfos;
		this.statInfos = statInfos;
		this.batchexps = batchexps;
		this.properties = properties;
	}

	// Property accessors

	public Integer getModel() {
		return this.model;
	}

	public void setModel(Integer model) {
		this.model = model;
	}

	public CommodityTpye getCommodityTpye() {
		return this.commodityTpye;
	}

	public void setCommodityTpye(CommodityTpye commodityTpye) {
		this.commodityTpye = commodityTpye;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public Set getReturnOrderInfos() {
		return this.returnOrderInfos;
	}

	public void setReturnOrderInfos(Set returnOrderInfos) {
		this.returnOrderInfos = returnOrderInfos;
	}

	public Set getPriceregulations() {
		return this.priceregulations;
	}

	public void setPriceregulations(Set priceregulations) {
		this.priceregulations = priceregulations;
	}

	public Set getIncomeInfos() {
		return this.incomeInfos;
	}

	public void setIncomeInfos(Set incomeInfos) {
		this.incomeInfos = incomeInfos;
	}

	public Set getAssemblyServers() {
		return this.assemblyServers;
	}

	public void setAssemblyServers(Set assemblyServers) {
		this.assemblyServers = assemblyServers;
	}

	public Set getApplyBuyinfos() {
		return this.applyBuyinfos;
	}

	public void setApplyBuyinfos(Set applyBuyinfos) {
		this.applyBuyinfos = applyBuyinfos;
	}

	public Set getPurOrderInfos() {
		return this.purOrderInfos;
	}

	public void setPurOrderInfos(Set purOrderInfos) {
		this.purOrderInfos = purOrderInfos;
	}

	public Set getStatInfos() {
		return this.statInfos;
	}

	public void setStatInfos(Set statInfos) {
		this.statInfos = statInfos;
	}

	public Set getBatchexps() {
		return this.batchexps;
	}

	public void setBatchexps(Set batchexps) {
		this.batchexps = batchexps;
	}

	public Set getProperties() {
		return this.properties;
	}

	public void setProperties(Set properties) {
		this.properties = properties;
	}

}