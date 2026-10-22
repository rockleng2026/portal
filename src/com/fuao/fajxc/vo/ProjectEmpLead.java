package com.fuao.fajxc.vo;

/****
 * 员工任务领导评价表
 */
import java.io.Serializable;
import java.util.Date;

public class ProjectEmpLead implements Serializable{
	private Integer id; //主键
	private String leadname;// 领导名称
	private String leadevaluate;// 领导评价
	private Date pjtime;// 评价时间
	private ProjectEmp prjemp; //项目跟踪领导
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLeadname() {
		return leadname;
	}
	public void setLeadname(String leadname) {
		this.leadname = leadname;
	}
	public String getLeadevaluate() {
		return leadevaluate;
	}
	public void setLeadevaluate(String leadevaluate) {
		this.leadevaluate = leadevaluate;
	}
	public Date getPjtime() {
		return pjtime;
	}
	public void setPjtime(Date pjtime) {
		this.pjtime = pjtime;
	}
	public ProjectEmp getPrjemp() {
		return prjemp;
	}
	public void setPrjemp(ProjectEmp prjemp) {
		this.prjemp = prjemp;
	}
	
	
	
	
}
