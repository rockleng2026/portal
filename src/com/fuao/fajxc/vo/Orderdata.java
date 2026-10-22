package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Orderdata entity. @author MyEclipse Persistence Tools
 */

public class Orderdata implements java.io.Serializable {

	// Fields

	private Integer id;
	private Ordertype ordertype;
	private String temp1;
	private String temp2;
	private String temp3;
	private String temp4;
	private String temp5;
	private String temp6;
	private String temp7;
	private String temp8;
	private String temp9;
	private String temp10;
	private String temp11;
	private String temp12;
	private String temp13;
	private String temp14;
	private String temp15;
	private Integer delflag;
	private Set cdnips = new HashSet(0);
	private Set districts = new HashSet(0);
	private Set caches = new HashSet(0);
	private Set saleordercenters = new HashSet(0);

	// Constructors

	/** default constructor */
	public Orderdata() {
	}

	/** full constructor */
	public Orderdata(Ordertype ordertype, String temp1, String temp2,
			String temp3, String temp4, String temp5, String temp6,
			String temp7, String temp8, String temp9, String temp10,
			String temp11, String temp12, String temp13, String temp14,
			String temp15, Integer delflag, Set cdnips, Set districts,
			Set caches, Set saleordercenters) {
		this.ordertype = ordertype;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.temp4 = temp4;
		this.temp5 = temp5;
		this.temp6 = temp6;
		this.temp7 = temp7;
		this.temp8 = temp8;
		this.temp9 = temp9;
		this.temp10 = temp10;
		this.temp11 = temp11;
		this.temp12 = temp12;
		this.temp13 = temp13;
		this.temp14 = temp14;
		this.temp15 = temp15;
		this.delflag = delflag;
		this.cdnips = cdnips;
		this.districts = districts;
		this.caches = caches;
		this.saleordercenters = saleordercenters;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Ordertype getOrdertype() {
		return this.ordertype;
	}

	public void setOrdertype(Ordertype ordertype) {
		this.ordertype = ordertype;
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

	public String getTemp4() {
		return this.temp4;
	}

	public void setTemp4(String temp4) {
		this.temp4 = temp4;
	}

	public String getTemp5() {
		return this.temp5;
	}

	public void setTemp5(String temp5) {
		this.temp5 = temp5;
	}

	public String getTemp6() {
		return this.temp6;
	}

	public void setTemp6(String temp6) {
		this.temp6 = temp6;
	}

	public String getTemp7() {
		return this.temp7;
	}

	public void setTemp7(String temp7) {
		this.temp7 = temp7;
	}

	public String getTemp8() {
		return this.temp8;
	}

	public void setTemp8(String temp8) {
		this.temp8 = temp8;
	}

	public String getTemp9() {
		return this.temp9;
	}

	public void setTemp9(String temp9) {
		this.temp9 = temp9;
	}

	public String getTemp10() {
		return this.temp10;
	}

	public void setTemp10(String temp10) {
		this.temp10 = temp10;
	}

	public String getTemp11() {
		return this.temp11;
	}

	public void setTemp11(String temp11) {
		this.temp11 = temp11;
	}

	public String getTemp12() {
		return this.temp12;
	}

	public void setTemp12(String temp12) {
		this.temp12 = temp12;
	}

	public String getTemp13() {
		return this.temp13;
	}

	public void setTemp13(String temp13) {
		this.temp13 = temp13;
	}

	public String getTemp14() {
		return this.temp14;
	}

	public void setTemp14(String temp14) {
		this.temp14 = temp14;
	}

	public String getTemp15() {
		return this.temp15;
	}

	public void setTemp15(String temp15) {
		this.temp15 = temp15;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public Set getCdnips() {
		return this.cdnips;
	}

	public void setCdnips(Set cdnips) {
		this.cdnips = cdnips;
	}

	public Set getDistricts() {
		return this.districts;
	}

	public void setDistricts(Set districts) {
		this.districts = districts;
	}

	public Set getCaches() {
		return this.caches;
	}

	public void setCaches(Set caches) {
		this.caches = caches;
	}

	public Set getSaleordercenters() {
		return this.saleordercenters;
	}

	public void setSaleordercenters(Set saleordercenters) {
		this.saleordercenters = saleordercenters;
	}

}