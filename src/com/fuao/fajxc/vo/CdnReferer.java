package com.fuao.fajxc.vo;

public class CdnReferer implements java.io.Serializable{
	
	private int id;
	private String domain;//域名
	private int rqTime;//时间戳
	private String referer;//来源
	
	
	
	public CdnReferer() {
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
	public String getReferer() {
		return referer;
	}
	public void setReferer(String referer) {
		this.referer = referer;
	}
	public int getRqTime() {
		return rqTime;
	}
	public void setRqTime(int rqTime) {
		this.rqTime = rqTime;
	}
	
	

}
