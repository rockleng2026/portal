 package com.fuao.fajxc.vo;

/**
 * Setmealcenter entity. @author MyEclipse Persistence Tools
 */

public class SetMealCenter implements java.io.Serializable {

	// Fields

	private Integer id;
	private SetMeal setmeal;
	private SetMealProperty setMealProperty;
	private String temp1;
	private String temp2;
	private String temp3;
	private Integer delflag;

	// Constructors

	/** default constructor */
	public SetMealCenter() {
	}

	/** full constructor */
	public SetMealCenter(SetMeal setmeal, SetMealProperty setMealProperty,
			String temp1, String temp2, String temp3, Integer delflag) {
		this.setmeal = setmeal;
		this.setMealProperty = setMealProperty;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SetMeal getSetmeal() {
		return this.setmeal;
	}

	public void setSetmeal(SetMeal setmeal) {
		this.setmeal = setmeal;
	}


	public SetMealProperty getSetMealProperty() {
		return setMealProperty;
	}

	public void setSetMealProperty(SetMealProperty setMealProperty) {
		this.setMealProperty = setMealProperty;
	}

	public String getTemp1() {
		return this.temp1;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}

	public String getTemp2() {
		return this.temp2;
	}

	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}

	public String getTemp3() {
		return this.temp3;
	}

	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

}