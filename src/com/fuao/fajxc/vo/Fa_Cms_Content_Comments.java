package com.fuao.fajxc.vo;

import java.util.Date;

public class Fa_Cms_Content_Comments {
	private Integer id;
	private Integer cid;  //文章id
	private Integer sid; //用户id(发送者id)为空为匿名
	private String sname; //用户姓名
	private Integer is_self; //是否是对评论进行回复 默认 0 不是 1是
	private Integer tid; //目标id(默认是文章id,其次是评论id)
	private String content; //回复内容
	private Date sendtime; //发送时间
	private String ipaddress;//IP地址
	private Integer score; //评分
	private Integer status; //审核状态 些不合法的需要屏蔽 管理员操作 
	                      //默认0待审核(初始提交) 1 审核中(如有有接受功能的话)   2审核通过
	private String auditname; //审核人
	//评论对文章(news) 多对一
	private Fa_Cms_News news;
	
	public Fa_Cms_Content_Comments(){}
	public Fa_Cms_Content_Comments(Integer id, Integer cid, Integer sid,
			String sname, Integer isSelf, Integer tid, String content,
			Date sendtime, String ipaddress, Integer score, Integer status,
			String auditname) {
		this.id = id;
		this.cid = cid;
		this.sid = sid;
		this.sname = sname;
		is_self = isSelf;
		this.tid = tid;
		this.content = content;
		this.sendtime = sendtime;
		this.ipaddress = ipaddress;
		this.score = score;
		this.status = status;
		this.auditname = auditname;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public Integer getIs_self() {
		return is_self;
	}
	public void setIs_self(Integer isSelf) {
		is_self = isSelf;
	}
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getAuditname() {
		return auditname;
	}
	public void setAuditname(String auditname) {
		this.auditname = auditname;
	}
	public Fa_Cms_News getNews() {
		return news;
	}
	public void setNews(Fa_Cms_News news) {
		this.news = news;
	}

}
