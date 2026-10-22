package com.fuao.fajxc.vo;

import java.util.Date;

public class Notice implements java.io.Serializable {
	private Integer id;
	private String noticeNo;
	private String title;    //标题
	private Integer typeid;  //类型
	private Date sendTime;  //发布时间
	private String content;  //内容
	private Integer audtitingFlag; //审核标识
	private Integer draftFlag;   //是否存入草稿箱  0-不存入  1-存入
	private Integer isRead;  //是否读取  0未读取  1读取
	private Department startDept;
	
	public Notice(){}

	public Notice(Integer id, String noticeNo,Department dept,Integer audtitingFlag, String title, Integer typeid,
			String content) {
		this.id = id;
		this.title = title;
		this.typeid = typeid;
		this.content = content;
		this.audtitingFlag = audtitingFlag;
		this.draftFlag = draftFlag;
		this.isRead = isRead;
		this.sendTime = sendTime;
		this.startDept = startDept;
		this.noticeNo = noticeNo;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getTypeid() {
		return typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Integer getAudtitingFlag() {
		return audtitingFlag;
	}

	public void setAudtitingFlag(Integer audtitingFlag) {
		this.audtitingFlag = audtitingFlag;
	}

	public Integer getDraftFlag() {
		return draftFlag;
	}

	public void setDraftFlag(Integer draftFlag) {
		this.draftFlag = draftFlag;
	}

	public Integer getIsRead() {
		return isRead;
	}

	public void setIsRead(Integer isRead) {
		this.isRead = isRead;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Department getStartDept() {
		return startDept;
	}

	public void setStartDept(Department startDept) {
		this.startDept = startDept;
	}

	public String getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}
	
}