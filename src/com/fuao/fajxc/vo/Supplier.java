package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Supplier entity. @author MyEclipse Persistence Tools
 */

public class Supplier implements java.io.Serializable {

	// Fields

	private Integer id;
	private String supplierName;
	private String cardid;
	private String supplierCompany;
	private String supplierAddress;
	private String bankAccount;
	private String supplierOrigin;
	private String phone;
	private String mobilePhone;
	private String email;
	private String zipCode;
	private String date;
	private String admin;
	private String qq;
	private String facsimile;
	private String del;
	private Set returnOrders = new HashSet(0);
	private Set purOrders = new HashSet(0);

	// Constructors

	/** default constructor */
	public Supplier() {
	}

	/** full constructor */
	public Supplier(String supplierName, String cardid, String supplierCompany,
			String supplierAddress, String bankAccount, String supplierOrigin,
			String phone, String mobilePhone, String email, String zipCode,
			String date, String admin, String qq, String facsimile, String del,
			Set returnOrders, Set purOrders) {
		this.supplierName = supplierName;
		this.cardid = cardid;
		this.supplierCompany = supplierCompany;
		this.supplierAddress = supplierAddress;
		this.bankAccount = bankAccount;
		this.supplierOrigin = supplierOrigin;
		this.phone = phone;
		this.mobilePhone = mobilePhone;
		this.email = email;
		this.zipCode = zipCode;
		this.date = date;
		this.admin = admin;
		this.qq = qq;
		this.facsimile = facsimile;
		this.del = del;
		this.returnOrders = returnOrders;
		this.purOrders = purOrders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSupplierName() {
		return this.supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getCardid() {
		return this.cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getSupplierCompany() {
		return this.supplierCompany;
	}

	public void setSupplierCompany(String supplierCompany) {
		this.supplierCompany = supplierCompany;
	}

	public String getSupplierAddress() {
		return this.supplierAddress;
	}

	public void setSupplierAddress(String supplierAddress) {
		this.supplierAddress = supplierAddress;
	}

	public String getBankAccount() {
		return this.bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getSupplierOrigin() {
		return this.supplierOrigin;
	}

	public void setSupplierOrigin(String supplierOrigin) {
		this.supplierOrigin = supplierOrigin;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipCode() {
		return this.zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getDate() {
		return this.date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getAdmin() {
		return this.admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getFacsimile() {
		return this.facsimile;
	}

	public void setFacsimile(String facsimile) {
		this.facsimile = facsimile;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public Set getReturnOrders() {
		return this.returnOrders;
	}

	public void setReturnOrders(Set returnOrders) {
		this.returnOrders = returnOrders;
	}

	public Set getPurOrders() {
		return this.purOrders;
	}

	public void setPurOrders(Set purOrders) {
		this.purOrders = purOrders;
	}

}