package com.fuao.fajxc.vo;

public class cdnLogServer {
	
	private int id;
	private String nodestr;
	private String domain;
	private int bandwidth;
	private int flow;
	private String rqtime;
	private int rqnum;
	private String ipsstr;
	private int temp;
	private int hynum;
	
	
	
	public cdnLogServer() {
		super();
	}
	public cdnLogServer(int id, String nodestr, String domain, int bandwidth,
			int flow, String rqtime, int rqnum, String ipsstr,int temp,int hynum) {
		super();
		this.id = id;
		this.nodestr = nodestr;
		this.domain = domain;
		this.bandwidth = bandwidth;
		this.flow = flow;
		this.rqtime = rqtime;
		this.rqnum = rqnum;
		this.ipsstr = ipsstr;
		this.temp=temp;
		this.hynum=hynum;
	}
	
	public int getHynum() {
		return hynum;
	}
	public void setHynum(int hynum) {
		this.hynum = hynum;
	}
	public int getTemp() {
		return temp;
	}
	public void setTemp(int temp) {
		this.temp = temp;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNodestr() {
		return nodestr;
	}
	public void setNodestr(String nodestr) {
		this.nodestr = nodestr;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public int getBandwidth() {
		return bandwidth;
	}
	public void setBandwidth(int bandwidth) {
		this.bandwidth = bandwidth;
	}
	public int getFlow() {
		return flow;
	}
	public void setFlow(int flow) {
		this.flow = flow;
	}
	public String getRqtime() {
		return rqtime;
	}
	public void setRqtime(String rqtime) {
		this.rqtime = rqtime;
	}
	public int getRqnum() {
		return rqnum;
	}
	public void setRqnum(int rqnum) {
		this.rqnum = rqnum;
	}
	public String getIpsstr() {
		return ipsstr;
	}
	public void setIpsstr(String ipsstr) {
		this.ipsstr = ipsstr;
	}
	
	
	
	

}
