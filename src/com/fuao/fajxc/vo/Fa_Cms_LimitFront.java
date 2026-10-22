package com.fuao.fajxc.vo;

import java.io.Serializable;

public class Fa_Cms_LimitFront implements Serializable{
  
	private static final long serialVersionUID = 1L;
	private String modelname;
	private String modelalias;
	private String modelurl;
	private String modelico;
	
	public String getModelico() {
		return modelico;
	}
	public void setModelico(String modelico) {
		this.modelico = modelico;
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
	public String getModelurl() {
		return modelurl;
	}
	public void setModelurl(String modelurl) {
		this.modelurl = modelurl;
	}
}
