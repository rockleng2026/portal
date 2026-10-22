package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;

import freemarker.log.Logger;

public class Fa_Cms_Member implements Serializable{
	private Integer userid; //用户ID
	private String username; //用户名
	private String password; //密码
	private String rnd;
	private String email; //邮箱
	private Date registertime;//注册时间
	private Integer groupid; //组ID
	private Integer userfen; //
	private Integer userdate; //用户创建时间
	private Float money; //金额
	private Integer havemsg; //是否有消息
	private Integer checked; //是否查看
	private String salt;
	
	public Fa_Cms_Member(){}
	public Fa_Cms_Member(Integer userid, String username, String password,
			String rnd, String email, Date registertime, Integer groupid,
			Integer userfen, Integer userdate, Float money, Integer havemsg,
			Integer checked, String salt) {
		this.userid = userid;
		this.username = username;
		this.password = password;
		this.rnd = rnd;
		this.email = email;
		this.registertime = registertime;
		this.groupid = groupid;
		this.userfen = userfen;
		this.userdate = userdate;
		this.money = money;
		this.havemsg = havemsg;
		this.checked = checked;
		this.salt = salt;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRnd() {
		return rnd;
	}

	public void setRnd(String rnd) {
		this.rnd = rnd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getRegistertime() {
		return registertime;
	}

	public void setRegistertime(Date registertime) {
		this.registertime = registertime;
	}

	public Integer getGroupid() {
		return groupid;
	}

	public void setGroupid(Integer groupid) {
		this.groupid = groupid;
	}

	public Integer getUserfen() {
		return userfen;
	}

	public void setUserfen(Integer userfen) {
		this.userfen = userfen;
	}

	public Integer getUserdate() {
		return userdate;
	}

	public void setUserdate(Integer userdate) {
		this.userdate = userdate;
	}

	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}

	public Integer getHavemsg() {
		return havemsg;
	}

	public void setHavemsg(Integer havemsg) {
		this.havemsg = havemsg;
	}

	public Integer getChecked() {
		return checked;
	}

	public void setChecked(Integer checked) {
		this.checked = checked;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

}
