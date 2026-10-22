package com.fuao.fajxc.vo;

public class SaledFlow {
   
	private int dfId;
	private SaleOrder Tsaleorders;
	private String dfContent;
	private String dftime;
	private String dfstat;
	
	public String getDfstat() {
		return dfstat;
	}
	public void setDfstat(String dfstat) {
		this.dfstat = dfstat;
	}
	public String getDftime() {
		return dftime;
	}
	public void setDftime(String dftime) {
		this.dftime = dftime;
	}
	public int getDfId() {
		return dfId;
	}
	public void setDfId(int dfId) {
		this.dfId = dfId;
	}
	public SaleOrder getTsaleorders() {
		return Tsaleorders;
	}
	public void setTsaleorders(SaleOrder tsaleorders) {
		Tsaleorders = tsaleorders;
	}
	public String getDfContent() {
		return dfContent;
	}
	public void setDfContent(String dfContent) {
		this.dfContent = dfContent;
	}
	
	
}
