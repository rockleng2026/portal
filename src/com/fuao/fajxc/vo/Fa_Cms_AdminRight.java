package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Fa_Cms_AdminRight implements Serializable{
	private Integer rightid;
	private String menuid;
	private Date editdate;
	private Fa_Cms_AdminModel mods;
	private Fa_Cms_Admin admins;
	
	public Fa_Cms_AdminRight(){}
	public Fa_Cms_AdminRight(Integer rightid,
			String menuid, Date editdate) {
		this.rightid = rightid;
		this.menuid = menuid;
		this.editdate = editdate;
	}
	public Integer getRightid() {
		return rightid;
	}
	public void setRightid(Integer rightid) {
		this.rightid = rightid;
	}
	
	public String getMenuid() {
		return menuid;
	}
	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}
	public Fa_Cms_Admin getAdmins() {
		return admins;
	}
	public void setAdmins(Fa_Cms_Admin admins) {
		this.admins = admins;
	}
	public Fa_Cms_AdminModel getMods() {
		return mods;
	}
	public void setMods(Fa_Cms_AdminModel mods) {
		this.mods = mods;
	}
	public Date getEditdate() {
		return editdate;
	}
	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}

	
}
