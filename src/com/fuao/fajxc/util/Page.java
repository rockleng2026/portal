package com.fuao.fajxc.util;

import java.util.List;

/**
 * 分页工具�?
 * @version 1.0 2008-04-21
 * @author ok
 * 更新日志�?
 *  *   
 */

public class Page {
	private int nowPage;//当前�?
	private int rowPage;//每页多少�?
	private int totallyRow;//�?��有多少条	
	private int totallyPage;//总页�?
	private int totalNum;
	private int currentPage;
	private List pageList;

	public int getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public List getPageList() {
		return pageList;
	}

	public void setPageList(List pageList) {
		this.pageList = pageList;
	}

	public int getTotallyPage() {
		return totallyPage;
	}

	public void setTotallyPage(int totallyPage) {
		this.totallyPage = totallyPage;
	}

	public int getNowPage() {
		return nowPage;
	}
	
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getRowPage() {
		return rowPage;
	}
	public void setRowPage(int rowPage) {
		this.rowPage = rowPage;
	}
	public int getTotallyRow() {
		return totallyRow;
	}
	public void setTotallyRow(int totallyRow) {
		this.totallyRow = totallyRow;
	}
	
}
