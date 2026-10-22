package com.fuao.fajxc.util.paging;

import java.util.List;

public class Result {
	private Page page; //分页信息
	private List content; //每页显示的集合 

	//The default constructor 
	public Result() {
	super();
	} 

	//The constructor using fields 
	public Result(Page page, List content) {
	this.page = page;
	this.content = content;
	}


	public List getContent() {
	return content;
	}


	public Page getPage() {
	return page;
	}


	public void setContent(List content) {
	this.content = content;
	}


	public void setPage(Page page) {
	this.page = page;
	}
	}

