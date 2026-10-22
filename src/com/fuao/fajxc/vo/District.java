package com.fuao.fajxc.vo;

/**
 * District entity. @author MyEclipse Persistence Tools
 */

public class District implements java.io.Serializable {

	// Fields

	private Integer id;
	private CDNsaleOrder CDNsaleorder;
	private String tmoblie;
	private String districtName;
	private String ip;
	private Integer delflag;

	// Constructors

	/** default constructor */
	public District() {
	}

	/** full constructor */
	public District(CDNsaleOrder CDNsaleorder, String tmoblie, String districtName,
			String ip, Integer delflag) {
		this.CDNsaleorder = CDNsaleorder;
		this.tmoblie = tmoblie;
		this.districtName = districtName;
		this.ip = ip;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}



	public CDNsaleOrder getCDNsaleorder() {
		return CDNsaleorder;
	}

	public void setCDNsaleorder(CDNsaleOrder cDNsaleorder) {
		CDNsaleorder = cDNsaleorder;
	}

	public String getTmoblie() {
		return this.tmoblie;
	}

	public void setTmoblie(String tmoblie) {
		this.tmoblie = tmoblie;
	}

	public String getDistrictName() {
		return this.districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

}