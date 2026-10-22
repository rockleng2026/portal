package com.fuao.fajxc.vo;

import java.util.Date;

public class NewHistoryQuestion implements java.io.Serializable{
	/**
	 * 问题历史记录
	 */
	private Integer id;
	private Integer qid; //问题编号
	private Integer solver; //解决人
	private String solveresult; //解决结果
	private String fj; //上传附件
	private Date solvetime;//解决时间
	
	public NewHistoryQuestion(){}

	public NewHistoryQuestion(Integer id, Integer qid, Integer solver,
			String solveresult, String fj, Date solvetime) {
		this.id = id;
		this.qid = qid;
		this.solver = solver;
		this.solveresult = solveresult;
		this.fj = fj;
		this.solvetime = solvetime;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getQid() {
		return qid;
	}
	public void setQid(Integer qid) {
		this.qid = qid;
	}
	public Integer getSolver() {
		return solver;
	}
	public void setSolver(Integer solver) {
		this.solver = solver;
	}
	public String getSolveresult() {
		return solveresult;
	}
	public void setSolveresult(String solveresult) {
		this.solveresult = solveresult;
	}
	public String getFj() {
		return fj;
	}
	public void setFj(String fj) {
		this.fj = fj;
	}
	public Date getSolvetime() {
		return solvetime;
	}
	public void setSolvetime(Date solvetime) {
		this.solvetime = solvetime;
	}
	
}
