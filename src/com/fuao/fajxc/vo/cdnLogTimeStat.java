package com.fuao.fajxc.vo;

public class cdnLogTimeStat {
	
	private int id;
	private String stime;
	private String etime;
	private String rtime;
	private String wtime;
	private String ptime;
	private String nodestr;
	private String remark;
	
	
	
	public cdnLogTimeStat() {
		super();
	}



	public cdnLogTimeStat(int id, String stime, String etime, String rtime,
			String wtime, String ptime, String nodestr, String remark) {
		super();
		this.id = id;
		this.stime = stime;
		this.etime = etime;
		this.rtime = rtime;
		this.wtime = wtime;
		this.ptime = ptime;
		this.nodestr = nodestr;
		this.remark = remark;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getStime() {
		return stime;
	}



	public void setStime(String stime) {
		this.stime = stime;
	}



	public String getEtime() {
		return etime;
	}



	public void setEtime(String etime) {
		this.etime = etime;
	}



	public String getRtime() {
		return rtime;
	}



	public void setRtime(String rtime) {
		this.rtime = rtime;
	}



	public String getWtime() {
		return wtime;
	}



	public void setWtime(String wtime) {
		this.wtime = wtime;
	}



	public String getPtime() {
		return ptime;
	}



	public void setPtime(String ptime) {
		this.ptime = ptime;
	}



	public String getNodestr() {
		return nodestr;
	}



	public void setNodestr(String nodestr) {
		this.nodestr = nodestr;
	}



	public String getRemark() {
		return remark;
	}



	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
	

}
