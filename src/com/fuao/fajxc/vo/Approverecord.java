package com.fuao.fajxc.vo;

/*****
 * ÉóÅú¼ÇÂ¼±í
 * @author Administrator
 *
 */
public class Approverecord  implements java.io.Serializable{
	
	private int id;
	private String projectname;
	private String approveemp;
	private String applypeople;
	private String apptime;
	private String approveinfo;
	private int ispass;
	
	public Approverecord() {
		super();
	}
	public Approverecord(int id, String projectname, String approveemp,
			String applypeople, String apptime, String approveinfo, int ispass) {
		super();
		this.id = id;
		this.projectname = projectname;
		this.approveemp = approveemp;
		this.applypeople = applypeople;
		this.apptime = apptime;
		this.approveinfo = approveinfo;
		this.ispass = ispass;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProjectname() {
		return projectname;
	}
	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	public String getApproveemp() {
		return approveemp;
	}
	public void setApproveemp(String approveemp) {
		this.approveemp = approveemp;
	}
	public String getApplypeople() {
		return applypeople;
	}
	public void setApplypeople(String applypeople) {
		this.applypeople = applypeople;
	}
	public String getApptime() {
		return apptime;
	}
	public void setApptime(String apptime) {
		this.apptime = apptime;
	}
	public String getApproveinfo() {
		return approveinfo;
	}
	public void setApproveinfo(String approveinfo) {
		this.approveinfo = approveinfo;
	}
	public int getIspass() {
		return ispass;
	}
	public void setIspass(int ispass) {
		this.ispass = ispass;
	}
	

}
