package com.fuao.fajxc.bussiness.customService;

import java.util.List;

import com.fuao.fajxc.vo.Sendmessage;

public interface SendRefurbishBussiness {

	/**
	 * 获取相应list
	 * @param hql
	 * @return
	 */
	public List someList(String hql);
	
	/**
	 * 查找是否存在客服functionId
	 * 
	 */
	public boolean selrolufunction(int empId);
	
	/**
	 * 添加消息
	 */
	public boolean addsendmess(String sendtable,int sendtableId);
}
