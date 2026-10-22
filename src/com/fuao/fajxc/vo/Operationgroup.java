package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Operationgroup {
	private int id;
	private String empids;
	private String empnames;
	private String creatdate;
	private Missiontype missiontype;
	public Operationgroup(int id,String empids,String empnames, String creatdate) {
		this.id = id;
		this.empids=empids;
		this.creatdate = creatdate;
		this.empnames=empnames;
	}
	public Operationgroup() {
		
	}
	
	public String getEmpnames() {
		return empnames;
	}
	public void setEmpnames(String empnames) {
		this.empnames = empnames;
	}
	public Missiontype getMissiontype() {
		return missiontype;
	}
	public void setMissiontype(Missiontype missiontype) {
		this.missiontype = missiontype;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getCreatdate() {
		return creatdate;
	}
	public void setCreatdate(String creatdate) {
		this.creatdate = creatdate;
	}
	public String getEmpids() {
		return empids;
	}
	public void setEmpids(String empids) {
		this.empids = empids;
	}
	
	
    
	
}
