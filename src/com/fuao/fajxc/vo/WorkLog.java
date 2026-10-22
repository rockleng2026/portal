package com.fuao.fajxc.vo;

/**
 * WorkLog entity. @author MyEclipse Persistence Tools
 */

public class WorkLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employeeByReplier;
	private Employee employeeByEmpId;
	private String recordTime;
	private String logNo;
	private String content;
	private String workresult;
	private String selftemper;
	private String suggestion;
	private Integer type;
	private String replyTime;
	private String replyContent;
	private Integer isView;
	private String accessory;
	private String tsjyflag;

	// Constructors

	/** default constructor */
	public WorkLog() {
	}

	/** full constructor */
	public WorkLog(Employee employeeByReplier, Employee employeeByEmpId,
			String recordTime, String content, Integer type, String replyTime,
			String replyContent, Integer isView) {
		this.employeeByReplier = employeeByReplier;
		this.employeeByEmpId = employeeByEmpId;
		this.recordTime = recordTime;
		this.content = content;
		this.type = type;
		this.replyTime = replyTime;
		this.replyContent = replyContent;
		this.isView = isView;
		this.accessory=accessory;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public String getAccessory() {
		return accessory;
	}

	public void setAccessory(String accessory) {
		this.accessory = accessory;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployeeByReplier() {
		return this.employeeByReplier;
	}

	public void setEmployeeByReplier(Employee employeeByReplier) {
		this.employeeByReplier = employeeByReplier;
	}

	public Employee getEmployeeByEmpId() {
		return this.employeeByEmpId;
	}

	public void setEmployeeByEmpId(Employee employeeByEmpId) {
		this.employeeByEmpId = employeeByEmpId;
	}

	public String getRecordTime() {
		return this.recordTime;
	}

	public void setRecordTime(String recordTime) {
		this.recordTime = recordTime;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getReplyTime() {
		return this.replyTime;
	}

	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}

	public String getReplyContent() {
		return this.replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Integer getIsView() {
		return this.isView;
	}

	public void setIsView(Integer isView) {
		this.isView = isView;
	}

	public String getWorkresult() {
		return workresult;
	}

	public void setWorkresult(String workresult) {
		this.workresult = workresult;
	}

	public String getSelftemper() {
		return selftemper;
	}

	public void setSelftemper(String selftemper) {
		this.selftemper = selftemper;
	}

	public String getSuggestion() {
		return suggestion;
	}

	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}

	public String getLogNo() {
		return logNo;
	}

	public void setLogNo(String logNo) {
		this.logNo = logNo;
	}

	public String getTsjyflag() {
		return tsjyflag;
	}

	public void setTsjyflag(String tsjyflag) {
		this.tsjyflag = tsjyflag;
	}

}