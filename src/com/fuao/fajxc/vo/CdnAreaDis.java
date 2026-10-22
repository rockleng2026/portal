package com.fuao.fajxc.vo;


public class CdnAreaDis implements java.io.Serializable {

	private int id;
	private String domain;//域名
	private int rqTime;//时间戳
	private String arear;//来源。。例如山东用SD表示，未识别用OT,
	private int no;//数量
	private int flow;//流量
	
	public CdnAreaDis(){
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

	public int getRqTime() {
		return rqTime;
	}

	public void setRqTime(int rqTime) {
		this.rqTime = rqTime;
	}

	public String getArear() {
		return arear;
	}
	public void setArear(String arear) {
		this.arear = arear;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}

	public int getFlow() {
		return flow;
	}

	public void setFlow(int flow) {
		this.flow = flow;
	}
	
	
	
}