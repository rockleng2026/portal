package com.fuao.fajxc.vo;

/**
 * Executerecord entity. @author MyEclipse Persistence Tools
 */

public class Executerecord implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private String content;
	private String executeTime;
	private String entityId;
	private String entityName;
	private String seenEmpId;

	/** default constructor */
	public Executerecord() {
	}
	
	/** full constructor */
	public Executerecord(Employee employee, String content, String executeTime, String entityId, 
			String entityName, String seenEmpId ) {
		this.employee = employee;
		this.content = content;
		this.executeTime = executeTime;
		this.entityId = entityId;
		this.entityName = entityName;
		this.seenEmpId = seenEmpId;
	}
	// Constructors

	public String getEntityId() {
		return entityId;
	}

	public void setEntityId(String entityId) {
		this.entityId = entityId;
	}

	public String getEntityName() {
		return entityName;
	}
	
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getSeenEmpId() {
		return seenEmpId;
	}

	public void setSeenEmpId(String seenEmpId) {
		this.seenEmpId = seenEmpId;
	}


	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getExecuteTime() {
		return this.executeTime;
	}

	public void setExecuteTime(String executeTime) {
		this.executeTime = executeTime;
	}

}