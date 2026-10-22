package com.fuao.fajxc.vo;


public class CdnLogs implements java.io.Serializable {

	private int id;
	private String domain;//域名
	private int dateTime;//时间戳
	private String logfile;//日志文件
	
	
	
	public CdnLogs() {
		super();
	}
	public CdnLogs(String domain,int dateTime,String logfile)
	{
		this.domain=domain;
		this.dateTime=dateTime;
		this.logfile=logfile;
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
	public int getDateTime() {
		return dateTime;
	}
	public void setDateTime(int dateTime) {
		this.dateTime = dateTime;
	}
	public String getLogfile() {
		return logfile;
	}
	public void setLogfile(String logfile) {
		this.logfile = logfile;
	}
	
	
	
}