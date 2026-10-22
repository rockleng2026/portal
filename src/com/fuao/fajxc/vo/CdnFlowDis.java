package com.fuao.fajxc.vo;


public class CdnFlowDis implements java.io.Serializable {

	private int id;
	private String domain;//域名
	private int rqTime;//时间戳
	private int source;//请求回源数
	private int cache;//请求CACHE数
	
	public CdnFlowDis() {
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
	public int getSource() {
		return source;
	}
	public void setSource(int source) {
		this.source = source;
	}
	public int getCache() {
		return cache;
	}
	public void setCache(int cache) {
		this.cache = cache;
	}

	public int getRqTime() {
		return rqTime;
	}

	public void setRqTime(int rqTime) {
		this.rqTime = rqTime;
	}
	
	
	
}