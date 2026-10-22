package com.fuao.fajxc.vo;


public class CdnDomain implements java.io.Serializable {

	private int id;
	private String domain;//”Ú√˚
	private CdnUser cdnUser;
	
	public CdnDomain(){
		super();
	}
	public CdnDomain(String domain,CdnUser cdnUser)
	{
		this.domain=domain;
		this.cdnUser=cdnUser;
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
	public CdnUser getCdnUser() {
		return cdnUser;
	}
	public void setCdnUser(CdnUser cdnUser) {
		this.cdnUser = cdnUser;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	
	
	
	
	
}