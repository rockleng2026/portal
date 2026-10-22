package com.fuao.fajxc.vo;


public class CdnDirRefresh implements java.io.Serializable {

	private int id;
	private CdnUser userName;//用户名
	private String url;//目录url
	private String dateTime;//刷新时间
	private int del;//删除标记
	
	
	public CdnDirRefresh(){
		super();
	}
	public CdnDirRefresh(CdnUser userName,String url,String dateTime,int del)
	{
		this.userName=userName;
		this.url=url;
		this.dateTime=dateTime;
		this.del=del;
	}
	
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public CdnUser getUserName() {
		return userName;
	}
	public void setUserName(CdnUser userName) {
		this.userName = userName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	
	
	
	
	
}