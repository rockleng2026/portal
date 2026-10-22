package com.fuao.fajxc.vo;

public class cdnArea {
	private int id;
	private String province;
	private int mark;
	private int del;
	
	
	
	
	public cdnArea() {
		super();
	}
	public cdnArea(int id, String province, int mark, int del) {
		super();
		this.id = id;
		this.province = province;
		this.mark = mark;
		this.del = del;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public int getMark() {
		return mark;
	}
	public void setMark(int mark) {
		this.mark = mark;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	
	

}
