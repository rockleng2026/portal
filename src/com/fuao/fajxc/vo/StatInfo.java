package com.fuao.fajxc.vo;

/**
 * StatInfo entity. @author MyEclipse Persistence Tools
 */

public class StatInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Stat stat;
	private Model model;
	private Integer factcount;
	private Integer datacount;
	private String remark;
	private Integer profitOrloss;

	// Constructors

	/** default constructor */
	public StatInfo() {
	}

	/** full constructor */
	public StatInfo(Stat stat, Model model, Integer factcount,
			Integer datacount, String remark, Integer profitOrloss) {
		this.stat = stat;
		this.model = model;
		this.factcount = factcount;
		this.datacount = datacount;
		this.remark = remark;
		this.profitOrloss = profitOrloss;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Stat getStat() {
		return this.stat;
	}

	public void setStat(Stat stat) {
		this.stat = stat;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Integer getFactcount() {
		return this.factcount;
	}

	public void setFactcount(Integer factcount) {
		this.factcount = factcount;
	}

	public Integer getDatacount() {
		return this.datacount;
	}

	public void setDatacount(Integer datacount) {
		this.datacount = datacount;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getProfitOrloss() {
		return this.profitOrloss;
	}

	public void setProfitOrloss(Integer profitOrloss) {
		this.profitOrloss = profitOrloss;
	}

}