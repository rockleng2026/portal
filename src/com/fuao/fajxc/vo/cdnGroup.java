package com.fuao.fajxc.vo;

public class cdnGroup {
	
	private int id;
	private String groupName;
	private String panelPointId;
	private String mark;
	private int del;
	
	
	
	
	
	public cdnGroup() {
		super();
	}
	public cdnGroup(int id, String groupName, String panelPointId, String mark,
			int del) {
		super();
		this.id = id;
		this.groupName = groupName;
		this.panelPointId = panelPointId;
		this.mark = mark;
		this.del = del;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getPanelPointId() {
		return panelPointId;
	}
	public void setPanelPointId(String panelPointId) {
		this.panelPointId = panelPointId;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	
	
	

}
