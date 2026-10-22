package com.fuao.fajxc.vo;

/**
 * Cdnip entity. @author MyEclipse Persistence Tools
 */

public class CDNip implements java.io.Serializable {

	// Fields

	private Integer id;
	private CDNsaleOrder CDNsaleorder;
	private String ip;
	private String port;
	private String address;
	private String tmoblie;
	private Integer delflag;

	// Constructors

	public CDNsaleOrder getCDNsaleorder() {
		return CDNsaleorder;
	}

	public void setCDNsaleorder(CDNsaleOrder cDNsaleorder) {
		CDNsaleorder = cDNsaleorder;
	}

	/** default constructor */
	public CDNip() {
	}

	/** full constructor */
	public CDNip(CDNsaleOrder cDNsaleorder, String ip, String port, String address,
			String tmoblie, Integer delflag) {
		this.CDNsaleorder = cDNsaleorder;
		this.ip = ip;
		this.port = port;
		this.address = address;
		this.tmoblie = tmoblie;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getPort() {
		return this.port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTmoblie() {
		return this.tmoblie;
	}

	public void setTmoblie(String tmoblie) {
		this.tmoblie = tmoblie;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

}