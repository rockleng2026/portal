package com.fuao.fajxc.vo;

/**
 * IncomeInfo entity. @author MyEclipse Persistence Tools
 */

public class IncomeInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Model model;
	private Income income;
	private Integer count;
	private Double price;
	private Double sum;

	// Constructors

	/** default constructor */
	public IncomeInfo() {
	}

	/** full constructor */
	public IncomeInfo(Model model, Income income, Integer count, Double price,
			Double sum) {
		this.model = model;
		this.income = income;
		this.count = count;
		this.price = price;
		this.sum = sum;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Income getIncome() {
		return this.income;
	}

	public void setIncome(Income income) {
		this.income = income;
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

	public Double getSum() {
		return this.sum;
	}

	public void setSum(Double sum) {
		this.sum = sum;
	}

}