package com.fuao.fajxc.util;

public class PageBuilder {
	/**
	 * 返回pages空页对象
	 * 
	 * @return
	 */
	public static Pages createEmptyPage() {
		return new Pages();
	}

	/**
	 * 创建????页对??	 * 
	 * @param start
	 * @param totalRows
	 * @param pageSize
	 * @return
	 */
	public static Pages createPage(int pageNo, long totalRows, int pageSize) {
		return new Pages(pageNo,pageSize,Long.valueOf(totalRows).intValue());
	}
}
