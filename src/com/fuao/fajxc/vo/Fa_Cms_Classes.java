package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Fa_Cms_Classes implements Serializable{
	private Integer classid;
	private Integer userid; // 用户ID
	private Integer superid; //父ID
	private Integer isout; //是否外连
	private Integer showflag; //是否显示
	private String classname; //信息类别
	private String outpath; //外链路径
	private String engname; //英文名
	private String sonclass; //子类
	private String namedrules;// 态静文件命名规则
	private String fatherclass; //父类型类型
	private String fatherpath; //父类路径
	private String regdate; //注册日期
	private String editdate; //编辑日期
	private Integer islastest;//是否最新 默认为0 数值越大越靠前 定义位排序功能
	private Integer delflag; //是否删除
	private Integer ismember; //0 是否是客户发表
	//类别对文章  一对多
	private Set<Fa_Cms_News> news = new HashSet<Fa_Cms_News>();
	//classes 对 rec_part 一对多
	private Set<Fa_Cms_Rec_Part> parts = new HashSet<Fa_Cms_Rec_Part>();
	private Set<Fa_Cms_Template> template = new HashSet<Fa_Cms_Template>();
	
	public Fa_Cms_Classes(){}
	public Fa_Cms_Classes(Integer classid, Integer userid, Integer superid,
			Integer isout, Integer showflag, String classname, String outpath,
			String engname, String sonclass, String namedrules,
			String fatherclass, String fatherpath, String regdate,
			String editdate, Integer islastest, Integer delflag, Integer ismember) {
		this.classid = classid;
		this.userid = userid;
		this.superid = superid;
		this.isout = isout;
		this.showflag = showflag;
		this.classname = classname;
		this.outpath = outpath;
		this.engname = engname;
		this.sonclass = sonclass;
		this.namedrules = namedrules;
		this.fatherclass = fatherclass;
		this.fatherpath = fatherpath;
		this.regdate = regdate;
		this.editdate = editdate;
		this.islastest = islastest;
		this.delflag = delflag;
		this.ismember = ismember;
	}
	public Integer getClassid() {
		return classid;
	}
	public void setClassid(Integer classid) {
		this.classid = classid;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getSuperid() {
		return superid;
	}
	public void setSuperid(Integer superid) {
		this.superid = superid;
	}
	public Integer getIsout() {
		return isout;
	}
	public void setIsout(Integer isout) {
		this.isout = isout;
	}
	public Integer getShowflag() {
		return showflag;
	}
	public void setShowflag(Integer showflag) {
		this.showflag = showflag;
	}
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
	}
	public String getOutpath() {
		return outpath;
	}
	public void setOutpath(String outpath) {
		this.outpath = outpath;
	}
	public String getEngname() {
		return engname;
	}
	public void setEngname(String engname) {
		this.engname = engname;
	}
	public String getSonclass() {
		return sonclass;
	}
	public void setSonclass(String sonclass) {
		this.sonclass = sonclass;
	}
	public String getNamedrules() {
		return namedrules;
	}
	public void setNamedrules(String namedrules) {
		this.namedrules = namedrules;
	}
	public String getFatherclass() {
		return fatherclass;
	}
	public void setFatherclass(String fatherclass) {
		this.fatherclass = fatherclass;
	}
	public String getFatherpath() {
		return fatherpath;
	}
	public void setFatherpath(String fatherpath) {
		this.fatherpath = fatherpath;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	public String getEditdate() {
		return editdate;
	}
	public void setEditdate(String editdate) {
		this.editdate = editdate;
	}
	public Integer getIslastest() {
		return islastest;
	}
	public void setIslastest(Integer islastest) {
		this.islastest = islastest;
	}
	public Integer getDelflag() {
		return delflag;
	}
	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}
	public Integer getIsmember() {
		return ismember;
	}
	public void setIsmember(Integer ismember) {
		this.ismember = ismember;
	}
	public Set<Fa_Cms_News> getNews() {
		return news;
	}
	public void setNews(Set<Fa_Cms_News> news) {
		this.news = news;
	}
	public Set<Fa_Cms_Rec_Part> getParts() {
		return parts;
	}
	public void setParts(Set<Fa_Cms_Rec_Part> parts) {
		this.parts = parts;
	}
	public Set<Fa_Cms_Template> getTemplate() {
		return template;
	}
	public void setTemplate(Set<Fa_Cms_Template> template) {
		this.template = template;
	}
	
}
