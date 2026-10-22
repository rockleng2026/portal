package com.fuao.fajxc.vo;

import java.util.Date;

/**
 * CommonScfjb entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class CommonScfjb implements java.io.Serializable {

	// Fields

	private Integer id;
	private String fjmc;
	private String fjhz;
	private Integer fjxh;
	private String fjlj;
	private String sbh;
	private String fbsbh;
	private Integer shzt;
	private Date buildTime;
	private Date shsj;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;

	// Constructors

	/** default constructor */
	public CommonScfjb() {
	}
	

	public CommonScfjb(Integer id) {
		super();
		this.id = id;
	}


	/** full constructor */
	public CommonScfjb(String fjmc, String fjhz, Integer fjxh, String fjlj,
			String sbh, Integer shzt, Date shsj, String tmp, String tmp1,
			String tmp2, String tmp3) {
		this.fjmc = fjmc;
		this.fjhz = fjhz;
		this.fjxh = fjxh;
		this.fjlj = fjlj;
		this.sbh = sbh;
		this.shzt = shzt;
		this.shsj = shsj;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFjmc() {
		return this.fjmc;
	}

	public void setFjmc(String fjmc) {
		this.fjmc = fjmc;
	}

	public String getFjhz() {
		return this.fjhz;
	}

	public void setFjhz(String fjhz) {
		this.fjhz = fjhz;
	}

	public Integer getFjxh() {
		return this.fjxh;
	}

	public void setFjxh(Integer fjxh) {
		this.fjxh = fjxh;
	}

	public String getFjlj() {
		return this.fjlj;
	}

	public void setFjlj(String fjlj) {
		this.fjlj = fjlj;
	}

	public String getSbh() {
		return this.sbh;
	}

	public void setSbh(String sbh) {
		this.sbh = sbh;
	}

	public Integer getShzt() {
		return this.shzt;
	}

	public void setShzt(Integer shzt) {
		this.shzt = shzt;
	}

	public Date getShsj() {
		return this.shsj;
	}

	public void setShsj(Date shsj) {
		this.shsj = shsj;
	}

	public String getTmp() {
		return this.tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

	public String getTmp1() {
		return this.tmp1;
	}

	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}

	public String getTmp2() {
		return this.tmp2;
	}

	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}

	public String getTmp3() {
		return this.tmp3;
	}

	public void setTmp3(String tmp3) {
		this.tmp3 = tmp3;
	}


	public String getFbsbh() {
		return fbsbh;
	}


	public void setFbsbh(String fbsbh) {
		this.fbsbh = fbsbh;
	}


	public Date getBuildTime() {
		return buildTime;
	}


	public void setBuildTime(Date buildTime) {
		this.buildTime = buildTime;
	}

}