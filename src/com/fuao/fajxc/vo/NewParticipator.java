package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class NewParticipator implements java.io.Serializable{
	/**
	 * 参与人
	 */
	private Integer id;
//	private Integer pid; //项目编号
	private String invitetime; //邀请时间
	private String content; //邀请内容
	private Integer isagree; //是否同意
	private Employee employee;//邀请人
	private NewProject project;
	private Set newquestion = new HashSet(0);
	private NewProject newProject;//所属项目
	
	public NewParticipator(){}
	public NewParticipator(Integer id, String invitetime,
			String content, Integer isagree,Set newquestion,Employee employee) {

		this.id = id;
		this.invitetime = invitetime;
		this.content = content;
		this.isagree = isagree;
		this.employee = employee;
		this.newProject = newProject;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}


	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getIsagree() {
		return isagree;
	}
	public void setIsagree(Integer isagree) {
		this.isagree = isagree;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public NewProject getProject() {
		return project;
	}
	public void setProject(NewProject project) {
		this.project = project;
	}
	public String getInvitetime() {
		return invitetime;
	}
	public void setInvitetime(String invitetime) {
		this.invitetime = invitetime;
	}

	public NewProject getNewProject() {
		return newProject;
	}
	public void setNewProject(NewProject newProject) {
		this.newProject = newProject;
	}
	public Set getNewquestion() {
		return newquestion;
	}
	public void setNewquestion(Set newquestion) {
		this.newquestion = newquestion;
	}

	
}
