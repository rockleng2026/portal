package com.fuao.fajxc.vo;

public class cdnRealmNameIP {
	
	private int id;
	private Customer customerID;
	private String cuRealmName;
	private cdnPanelPoint cdnPanelPointID;
	private int mark;
	private int del;
	
	
	public cdnRealmNameIP() {
		super();
	}
	public cdnRealmNameIP(int id, Customer customerID, String cuRealmName,
			cdnPanelPoint cdnPanelPointID, int mark, int del) {
		super();
		this.id = id;
		this.customerID = customerID;
		this.cuRealmName = cuRealmName;
		this.cdnPanelPointID = cdnPanelPointID;
		this.mark = mark;
		this.del = del;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Customer getCustomerID() {
		return customerID;
	}
	public void setCustomerID(Customer customerID) {
		this.customerID = customerID;
	}
	public String getCuRealmName() {
		return cuRealmName;
	}
	public void setCuRealmName(String cuRealmName) {
		this.cuRealmName = cuRealmName;
	}
	public cdnPanelPoint getCdnPanelPointID() {
		return cdnPanelPointID;
	}
	public void setCdnPanelPointID(cdnPanelPoint cdnPanelPointID) {
		this.cdnPanelPointID = cdnPanelPointID;
	}
	public int getMark() {
		return mark;
	}
	public void setMark(int mark) {
		this.mark = mark;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	
	
}
