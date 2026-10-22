package com.fuao.fajxc.utilinterface;

import javax.servlet.http.HttpServletRequest;

/**
 * 通用类接口
 * @author 14012
 *
 */
public interface General {
	/**
	 * 发送邮件
	 * @param mark 需要发送邮件功能的标识符 用于查询该功能是否发送邮件提醒
	 * @param title 邮件标题
	 * @param email 接受者邮件地址
	 * @param content 邮件内容 
	 */
	public void sendEmail(String mark, String title, String email, String content);	
	/**
	 * 发送手机提醒
	 * 此功能暂未实现
	 */
	public void sendCellPhone();
	
	/**
	 * 添加审核流程
	 */
	public void addProcessRollingAudit();
	
	/**
	 * 发送内部短消息提醒
	 * @param request 
	 * @param mark1 是客户还是员工  1 员工  2客户
	 * @param mark 需要发送短消息功能的标识符 用于查询该功能是否发送短消息提醒
	 * @param title 消息标题
	 * @param content 消息内容
	 * @param receiverId 接受者id数组；
	 */
	public void sendMessage(HttpServletRequest request, String mark, String mark1, String title, String content, String[] receiverId);


}
