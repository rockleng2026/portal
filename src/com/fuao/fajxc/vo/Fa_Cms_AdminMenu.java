package com.fuao.fajxc.vo;

import java.util.Date;

public class Fa_Cms_AdminMenu {
	private Integer menuid;
	private Integer superid;
	private Integer modelid;
	private String menuname;
	private String menuengname;
	private String menuico;
	private String menuurl;
	private String menutarget;
	private String memo;
	private String regdate;
	private Date editdate;
	public Fa_Cms_AdminMenu(){}
	public Fa_Cms_AdminMenu(Integer menuid, Integer superid, Integer modelid,
			String menuname, String menuengname, String menuico,
			String menuurl, String menutarget, String memo, String regdate,
			Date editdate) {
		this.menuid = menuid;
		this.superid = superid;
		this.modelid = modelid;
		this.menuname = menuname;
		this.menuengname = menuengname;
		this.menuico = menuico;
		this.menuurl = menuurl;
		this.menutarget = menutarget;
		this.memo = memo;
		this.regdate = regdate;
		this.editdate = editdate;
	}
	public Integer getMenuid() {
		return menuid;
	}
	public void setMenuid(Integer menuid) {
		this.menuid = menuid;
	}
	public Integer getSuperid() {
		return superid;
	}
	public void setSuperid(Integer superid) {
		this.superid = superid;
	}
	public Integer getModelid() {
		return modelid;
	}
	public void setModelid(Integer modelid) {
		this.modelid = modelid;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getMenuengname() {
		return menuengname;
	}
	public void setMenuengname(String menuengname) {
		this.menuengname = menuengname;
	}
	public String getMenuico() {
		return menuico;
	}
	public void setMenuico(String menuico) {
		this.menuico = menuico;
	}
	public String getMenuurl() {
		return menuurl;
	}
	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}
	public String getMenutarget() {
		return menutarget;
	}
	public void setMenutarget(String menutarget) {
		this.menutarget = menutarget;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public Date getEditdate() {
		return editdate;
	}
	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}
	
}
