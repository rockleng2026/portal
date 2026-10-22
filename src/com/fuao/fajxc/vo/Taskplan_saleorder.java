package com.fuao.fajxc.vo;

public class Taskplan_saleorder {
	private Integer id;
	private Integer taskid;
	private Integer saleorderid;
	private String flag;
	private Integer status;
	
	public Taskplan_saleorder(){}

	public Taskplan_saleorder(Integer id, Integer taskid, Integer saleorderid,
			String flag) {
		this.id = id;
		this.taskid = taskid;
		this.saleorderid = saleorderid;
		this.flag = flag;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTaskid() {
		return taskid;
	}
	public void setTaskid(Integer taskid) {
		this.taskid = taskid;
	}
	public Integer getSaleorderid() {
		return saleorderid;
	}
	public void setSaleorderid(Integer saleorderid) {
		this.saleorderid = saleorderid;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
