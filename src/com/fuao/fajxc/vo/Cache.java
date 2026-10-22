package com.fuao.fajxc.vo;

/**
 * Cache entity. @author MyEclipse Persistence Tools
 */

public class Cache implements java.io.Serializable {

	// Fields

	private Integer id;
	private Type type;
	private CDNsaleOrder CDNsaleorder;
	private String typename;
	private Integer cacheflag;
	private String cachecontent;
	private String contentime;
	private String timeunit;
	private Integer delflag;

	// Constructors

	/** default constructor */
	public Cache() {
	}

	/** full constructor */
	public Cache(Type type, CDNsaleOrder CDNsaleorder, String typename,
			Integer cacheflag, String cachecontent, String contentime,
			String timeunit, Integer delflag) {
		this.type = type;
		this.CDNsaleorder = CDNsaleorder;
		this.typename = typename;
		this.cacheflag = cacheflag;
		this.cachecontent = cachecontent;
		this.contentime = contentime;
		this.timeunit = timeunit;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Type getType() {
		return this.type;
	}

	public void setType(Type type) {
		this.type = type;
	}



	public CDNsaleOrder getCDNsaleorder() {
		return CDNsaleorder;
	}

	public void setCDNsaleorder(CDNsaleOrder cDNsaleorder) {
		CDNsaleorder = cDNsaleorder;
	}

	public String getTypename() {
		return this.typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public Integer getCacheflag() {
		return this.cacheflag;
	}

	public void setCacheflag(Integer cacheflag) {
		this.cacheflag = cacheflag;
	}

	public String getCachecontent() {
		return this.cachecontent;
	}

	public void setCachecontent(String cachecontent) {
		this.cachecontent = cachecontent;
	}

	public String getContentime() {
		return this.contentime;
	}

	public void setContentime(String contentime) {
		this.contentime = contentime;
	}

	public String getTimeunit() {
		return this.timeunit;
	}

	public void setTimeunit(String timeunit) {
		this.timeunit = timeunit;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

}