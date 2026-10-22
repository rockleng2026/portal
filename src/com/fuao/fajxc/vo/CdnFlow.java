package com.fuao.fajxc.vo;


public class CdnFlow implements java.io.Serializable {

	private int id;
	private String domain;//域名
	private String dateTime;//时间戳
	private int traffic;//流量单位字节
	private CdnUser cdnUser;//对应的用户
	
	
	public CdnFlow() {
		super();
	}
	public CdnFlow(String domain,String dateTime,int traffic,CdnUser cdnUser)
	{
		this.domain=domain;
		this.dateTime=dateTime;
		this.traffic=traffic;
		this.cdnUser=cdnUser;
	}
	
	public CdnUser getCdnUser() {
		return cdnUser;
	}
	public void setCdnUser(CdnUser cdnUser) {
		this.cdnUser = cdnUser;
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

	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	public int getTraffic() {
		return traffic;
	}
	public void setTraffic(int traffic) {
		this.traffic = traffic;
	}
	
	
	
}