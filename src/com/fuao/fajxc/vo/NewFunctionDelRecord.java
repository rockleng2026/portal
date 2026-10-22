package com.fuao.fajxc.vo;

import java.util.Date;

public class NewFunctionDelRecord implements java.io.Serializable{
	/**
	 * 删除任务记录表
	 */
	private Integer id;
	private NewFunction function;
	private Integer flag;
	private Date deldate;
	
	public NewFunctionDelRecord() {
		super();
	}
	public NewFunctionDelRecord(Integer id, NewFunction function, Integer flag) {
		super();
		this.id = id;
		this.function = function;
		this.flag = flag;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public NewFunction getFunction() {
		return function;
	}
	public void setFunction(NewFunction function) {
		this.function = function;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public Date getDeldate() {
		return deldate;
	}
	public void setDeldate(Date deldate) {
		this.deldate = deldate;
	}
	
	
}
