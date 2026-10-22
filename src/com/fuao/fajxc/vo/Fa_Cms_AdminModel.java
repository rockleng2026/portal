package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Fa_Cms_AdminModel implements Serializable{
	private Integer modelid;
	private String modelname;
	private String modelalias;
	private String modelico;
	private String modelurl;
	private String regdate;
	private Date editdate;
	//ÖÐ¼ä±í
	private Set TadminModel = new HashSet(0);
	public Fa_Cms_AdminModel(){}

	public Set getTadminModel() {
		return TadminModel;
	}

	public void setTadminModel(Set tadminModel) {
		TadminModel = tadminModel;
	}

	public Fa_Cms_AdminModel(Integer modelid, String modelname,
			String modelalias, String modelico, String modelurl,
			String regdate, Date editdate) {
		this.modelid = modelid;
		this.modelname = modelname;
		this.modelalias = modelalias;
		this.modelico = modelico;
		this.modelurl = modelurl;
		this.regdate = regdate;
		this.editdate = editdate;
	}
	public Integer getModelid() {
		return modelid;
	}
	public void setModelid(Integer modelid) {
		this.modelid = modelid;
	}
	public String getModelname() {
		return modelname;
	}
	public void setModelname(String modelname) {
		this.modelname = modelname;
	}
	public String getModelalias() {
		return modelalias;
	}
	public void setModelalias(String modelalias) {
		this.modelalias = modelalias;
	}
	public String getModelico() {
		return modelico;
	}
	public void setModelico(String modelico) {
		this.modelico = modelico;
	}
	public String getModelurl() {
		return modelurl;
	}
	public void setModelurl(String modelurl) {
		this.modelurl = modelurl;
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
