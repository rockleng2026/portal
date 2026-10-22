package com.fuao.fajxc.vo;


public class CdnIspDis implements java.io.Serializable {

	private int id;
	private String domain;//域名
	private int rqTime;//时间戳
	private int telecom;//联通
	private int unicom;//电信
	private int chinamobile;//移动
	private int chinatietong;//铁通
	private int edu;//教育网
	private int other;//其他
	
	
	
	
	public CdnIspDis() {
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

	public int getUnicom() {
		return unicom;
	}
	public void setUnicom(int unicom) {
		this.unicom = unicom;
	}
	public int getChinamobile() {
		return chinamobile;
	}
	public void setChinamobile(int chinamobile) {
		this.chinamobile = chinamobile;
	}
	public int getChinatietong() {
		return chinatietong;
	}
	public void setChinatietong(int chinatietong) {
		this.chinatietong = chinatietong;
	}
	public int getEdu() {
		return edu;
	}
	public void setEdu(int edu) {
		this.edu = edu;
	}
	public int getOther() {
		return other;
	}
	public void setOther(int other) {
		this.other = other;
	}

	public int getRqTime() {
		return rqTime;
	}

	public void setRqTime(int rqTime) {
		this.rqTime = rqTime;
	}

	public int getTelecom() {
		return telecom;
	}

	public void setTelecom(int telecom) {
		this.telecom = telecom;
	}

	
	
	
}