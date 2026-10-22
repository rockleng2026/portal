package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;

public class Fa_Cms_Template implements Serializable{
	private Integer id; //主键
	private String name; //名字
	private String contents; //内容
	private Date editdate; //编辑日期
	private String temp; // 模板风格
	private Integer delflag; //是否删除
	private String fdir; //  文件路径
	private String fname; //  文件名称
	private String do_action; // 文件对应的Action 的访问路径
	private Integer mid; //1-首页引用 2-栏目页 3-内容页引用 4-最新页面 5-全局引用
	//文章对类别  多对一
	private Fa_Cms_Classes classes;
	
	public Fa_Cms_Classes getClasses() {
		return classes;
	}
	public void setClasses(Fa_Cms_Classes classes) {
		this.classes = classes;
	}
	public Fa_Cms_Template(){}
	public Fa_Cms_Template(Integer id, String name,
			String contents, Date editdate, String temp, Integer delflag,
			String fdir, String fname, String doAction, Integer mid) {
		this.id = id;
		this.name = name;
		this.contents = contents;
		this.editdate = editdate;
		this.temp = temp;
		this.delflag = delflag;
		this.fdir = fdir;
		this.fname = fname;
		do_action = doAction;
		this.mid = mid;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getEditdate() {
		return editdate;
	}
	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public Integer getDelflag() {
		return delflag;
	}
	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}
	public String getFdir() {
		return fdir;
	}
	public void setFdir(String fdir) {
		this.fdir = fdir;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getDo_action() {
		return do_action;
	}
	public void setDo_action(String doAction) {
		do_action = doAction;
	}
	public Integer getMid() {
		return mid;
	}
	public void setMid(Integer mid) {
		this.mid = mid;
	}

}
