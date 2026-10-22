package com.fuao.fajxc.vo;

public class cdnType {
	private int id;
	private String typeName;
	private int mark;
	private int del;
	
	
	
	public cdnType() {
		super();
	}
	public cdnType(int id, String typeName, int mark, int del) {
		super();
		this.id = id;
		this.typeName = typeName;
		this.mark = mark;
		this.del = del;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
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
