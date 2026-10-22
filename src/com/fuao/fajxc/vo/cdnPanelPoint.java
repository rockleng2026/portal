package com.fuao.fajxc.vo;

public class cdnPanelPoint {
	private int id;
	private String panelPointIp;
	private cdnArea cdnAreaID;
	private cdnType cdnTypeID;
	private int mark;
	private int del;
	private String address;
	private int duankou;
	
	
	public cdnPanelPoint() {
		super();
	}
	public cdnPanelPoint(int id, String panelPointIp, cdnArea cdnAreaID,
			cdnType cdnTypeID, int mark, int del,String address,int duankou) {
		super();
		this.id = id;
		this.panelPointIp = panelPointIp;
		this.cdnAreaID = cdnAreaID;
		this.cdnTypeID = cdnTypeID;
		this.mark = mark;
		this.del = del;
		this.address=address;
		this.duankou=duankou;
	}
	
	public int getDuankou() {
		return duankou;
	}
	public void setDuankou(int duankou) {
		this.duankou = duankou;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPanelPointIp() {
		return panelPointIp;
	}
	public void setPanelPointIp(String panelPointIp) {
		this.panelPointIp = panelPointIp;
	}
	public cdnArea getCdnAreaID() {
		return cdnAreaID;
	}
	public void setCdnAreaID(cdnArea cdnAreaID) {
		this.cdnAreaID = cdnAreaID;
	}
	public cdnType getCdnTypeID() {
		return cdnTypeID;
	}
	public void setCdnTypeID(cdnType cdnTypeID) {
		this.cdnTypeID = cdnTypeID;
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
