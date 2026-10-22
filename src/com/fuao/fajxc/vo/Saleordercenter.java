package com.fuao.fajxc.vo;

/**
 * Saleordercenter entity. @author MyEclipse Persistence Tools
 */

public class Saleordercenter implements java.io.Serializable {

	// Fields

	private Integer id;
	private SetMeal setmeal;
	private Productproperty productproperty;
	private SaleOrder saleorder;
	private Orderdata orderdata;
	private String temp1;
	private String temp2;
	private String temp3;
	private Integer delflag;

	// Constructors

	/** default constructor */
	public Saleordercenter() {
	}

	/** full constructor */
	public Saleordercenter(SetMeal setmeal, Productproperty productproperty,
			SaleOrder saleorder, Orderdata orderdata, String temp1,
			String temp2, String temp3, Integer delflag) {
		this.setmeal = setmeal;
		this.productproperty = productproperty;
		this.saleorder = saleorder;
		this.orderdata = orderdata;
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
		return setmeal;
	}

	public void setSetmeal(SetMeal setmeal) {
		this.setmeal = setmeal;
	}

	public Productproperty getProductproperty() {
		return this.productproperty;
	}

	public void setProductproperty(Productproperty productproperty) {
		this.productproperty = productproperty;
	}

	public SaleOrder getSaleorder() {
		return saleorder;
	}

	public void setSaleorder(SaleOrder saleorder) {
		this.saleorder = saleorder;
	}

	public Orderdata getOrderdata() {
		return this.orderdata;
	}

	public void setOrderdata(Orderdata orderdata) {
		this.orderdata = orderdata;
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