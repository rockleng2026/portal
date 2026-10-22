/**
 * 
 */
package com.fuao.fajxc.util;

/**
 * @author liqingsheng
 *
 */
public class UserActionBean {
  
	
	private  int serviceid;
	private String servicename;
	private String userid;
	private String typename;//业务所属的大小版本类别
	private String addtime;
	private String mobile;
	private String phoneType;
	
	private String ua;
	
	private int usertotal;//使用人数
	private int counttotal;//使用总次数
	private float pinci;//使用频次
	
	private int downtotal;//下载次数
	private int usetotal;//使用次数
	
	private String str;//备用
	
	
	
	
	public String getStr() {
		return str;
	}
	public void setStr(String str) {
		this.str = str;
	}
	public int getDowntotal() {
		return downtotal;
	}
	public void setDowntotal(int downtotal) {
		this.downtotal = downtotal;
	}
	public int getUsetotal() {
		return usetotal;
	}
	public void setUsetotal(int usetotal) {
		this.usetotal = usetotal;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getUa() {
		return ua;
	}
	public void setUa(String ua) {
		this.ua = ua;
	}
	public float getPinci() {
		return pinci;
	}
	public void setPinci(float pinci) {
		this.pinci = pinci;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public int getCounttotal() {
		return counttotal;
	}
	public void setCounttotal(int counttotal) {
		this.counttotal = counttotal;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPhoneType() {
		return phoneType;
	}
	public void setPhoneType(String phoneType) {
		this.phoneType = phoneType;
	}

	public void setPinci(int pinci) {
		this.pinci = pinci;
	}
	public int getServiceid() {
		return serviceid;
	}
	public void setServiceid(int serviceid) {
		this.serviceid = serviceid;
	}
	public String getServicename() {
		return servicename;
	}
	public void setServicename(String servicename) {
		this.servicename = servicename;
	}
	public int getUsertotal() {
		return usertotal;
	}
	public void setUsertotal(int usertotal) {
		this.usertotal = usertotal;
	}
	
	
	
	
}
