package com.fuao.fajxc.vo;

public class NoticeDept implements java.io.Serializable {
	private Integer id;
	private Notice notice;
	private Department dept;
	

	/** default constructor */
	public NoticeDept() {}
	public NoticeDept(Integer id, Notice notice, Department dept) {
		this.id = id;
		this.notice = notice;
		this.dept = dept;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Notice getNotice() {
		return notice;
	}
	public void setNotice(Notice notice) {
		this.notice = notice;
	}
	public Department getDept() {
		return dept;
	}
	public void setDept(Department dept) {
		this.dept = dept;
	}

}