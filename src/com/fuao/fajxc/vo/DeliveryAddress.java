package com.fuao.fajxc.vo;

public class DeliveryAddress implements java.io.Serializable{
	
	private int addressId;
	private String consignee;//收货人
	private String netherlands;//地区
	private String particularAddress;//详细地址
	private String mobile;//手机
	private String phones;//座机
	private String postalcode;//邮编
	private Customer customer;
	private String def;//是否为默认的地址
	

public DeliveryAddress(int addressId, String consignee, String netherlands,
			String particularAddress, String mobile, String phones,
			String postalcode, Customer customer , String def) {
		super();
		this.addressId = addressId;
		this.consignee = consignee;
		this.netherlands = netherlands;
		this.particularAddress = particularAddress;
		this.mobile = mobile;
		this.phones = phones;
		this.postalcode = postalcode;
		this.customer = customer;
		this.def = def;
	}



	
	public DeliveryAddress(){
		
	}




	public int getAddressId() {
		return addressId;
	}




	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}




	public String getConsignee() {
		return consignee;
	}




	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}




	public String getNetherlands() {
		return netherlands;
	}




	public void setNetherlands(String netherlands) {
		this.netherlands = netherlands;
	}




	public String getParticularAddress() {
		return particularAddress;
	}




	public void setParticularAddress(String particularAddress) {
		this.particularAddress = particularAddress;
	}




	public String getMobile() {
		return mobile;
	}




	public void setMobile(String mobile) {
		this.mobile = mobile;
	}




	public String getPhones() {
		return phones;
	}




	public void setPhones(String phones) {
		this.phones = phones;
	}




	public String getPostalcode() {
		return postalcode;
	}




	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}




	public Customer getCustomer() {
		return customer;
	}




	public void setCustomer(Customer customer) {
		this.customer = customer;
	}




	public String getDef() {
		return def;
	}




	public void setDef(String def) {
		this.def = def;
	}
	

}


