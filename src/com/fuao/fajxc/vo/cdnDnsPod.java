package com.fuao.fajxc.vo;

import java.util.List;

public class cdnDnsPod {
	
	private String id;//id的字符串
	private String typeName;//地域线路的名称
	private String yuming;//域名
	private String ip;//ip的结合
	private String mark;
	
	
	
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public cdnDnsPod() {
		super();
	}
	public cdnDnsPod(String id, String typeName, String yuming, String ip,String mark) {
		super();
		this.id = id;
		this.typeName = typeName;
		this.yuming = yuming;
		this.ip = ip;
		this.mark=mark;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getYuming() {
		return yuming;
	}
	public void setYuming(String yuming) {
		this.yuming = yuming;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	

}
