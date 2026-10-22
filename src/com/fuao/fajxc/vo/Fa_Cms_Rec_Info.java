package com.fuao.fajxc.vo;

import java.util.Date;

public class Fa_Cms_Rec_Info {
	private Integer id; //PK
	private Integer info_seq; //推荐信息在某个部分的显示序号
	private Integer info_vid; //文章ID
	private Integer info_pid; //info_part ID
	private Integer is_img; //是否显示图片
	private String info_pname; //图片路径
	private String info_imgSrc; //图片路径
	private String info_recdate; //对应rec_info  推荐时间
	private String temp; //信息
	private Fa_Cms_News news;
	
	public Fa_Cms_News getNews() {
		return news;
	}
	public void setNews(Fa_Cms_News news) {
		this.news = news;
	}
	public Fa_Cms_Rec_Info(){}
	public Fa_Cms_Rec_Info(Integer id, Integer infoVid, Integer infoPid,
			Integer isImg, String infoImgSrc, String infoRecdate, String temp) {
		this.id = id;
		info_vid = infoVid;
		info_pid = infoPid;
		is_img = isImg;
		info_imgSrc = infoImgSrc;
		info_recdate = infoRecdate;
		this.temp = temp;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getInfo_vid() {
		return info_vid;
	}

	public void setInfo_vid(Integer infoVid) {
		info_vid = infoVid;
	}

	public Integer getInfo_pid() {
		return info_pid;
	}

	public void setInfo_pid(Integer infoPid) {
		info_pid = infoPid;
	}

	public Integer getIs_img() {
		return is_img;
	}

	public void setIs_img(Integer isImg) {
		is_img = isImg;
	}

	public String getInfo_imgSrc() {
		return info_imgSrc;
	}

	public void setInfo_imgSrc(String infoImgSrc) {
		info_imgSrc = infoImgSrc;
	}



	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getInfo_recdate() {
		return info_recdate;
	}
	public void setInfo_recdate(String info_recdate) {
		this.info_recdate = info_recdate;
	}
	public String getInfo_pname() {
		return info_pname;
	}
	public void setInfo_pname(String info_pname) {
		this.info_pname = info_pname;
	}
	public Integer getInfo_seq() {
		return info_seq;
	}
	public void setInfo_seq(Integer info_seq) {
		this.info_seq = info_seq;
	}
	
}
