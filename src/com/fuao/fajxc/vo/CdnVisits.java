package com.fuao.fajxc.vo;



public class CdnVisits implements java.io.Serializable {

	private int id;
	private String domain;//域名
	private int rqTime;//时间戳
	private int click;//访问量
	
	public CdnVisits(){
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public int getClick() {
		return click;
	}
	public void setClick(int click) {
		this.click = click;
	}
	public int getRqTime() {
		return rqTime;
	}
	public void setRqTime(int rqTime) {
		this.rqTime = rqTime;
	}
	
	
	
	
}