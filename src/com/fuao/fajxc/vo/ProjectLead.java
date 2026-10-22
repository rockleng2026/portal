package com.fuao.fajxc.vo;

/****
 * 项目领导评价表
 */
import java.io.Serializable;
import java.util.Date;

public class ProjectLead implements Serializable{
	private Integer id; //主键
	private String leadname;// 领导名称
	private String leadevaluate;// 领导评价
	private Date pjtime;// 评价时间
	private Project prj; //项目跟踪领导
	
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
	public Project getPrj() {
		return prj;
	}
	public void setPrj(Project prj) {
		this.prj = prj;
	}
	
	
	
}
