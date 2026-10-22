package com.fuao.fajxc.utilinterface.impl;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.bussiness.message.MessagereceiverBussiness;
import com.fuao.fajxc.bussiness.message.MessagetypeBussiness;
import com.fuao.fajxc.bussiness.system.MessageremindBiz;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.utilinterface.General;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Messageremind;
import com.fuao.fajxc.vo.Messagetype;

public class GeneralImpl implements General {

	private MessageremindBiz messager;

	private MessagetypeBussiness messagetypeBussiness;

	private MessagereceiverBussiness messagereceiverBussiness;

	private MessageBussiness messageBussiness;

	public void addProcessRollingAudit() {
		// TODO Auto-generated method stub

	}

	public void sendCellPhone() {
		// TODO Auto-generated method stub

	}

	/**
	 * 发送邮件提醒
	 */
	public void sendEmail(String mark, String title, String email,
			String content) {

		Messageremind m = messager.getmr(mark);

		Email emails = new Email();

		if (null != m && null != m.getIsEmailRemind()&& 
				(m.getIsEmailRemind() == "yj" || m.getIsEmailRemind().equals("yj"))) {

			emails.sendEmail(email, title, content);
		}
	}

	/**
	 * 发送内部短消息提醒
	 */
	public void sendMessage(HttpServletRequest request, String mark,
			
			String mark1, String title, String content, String[] receiverId) {
		
		Messageremind m = messager.getmr(mark);
		
		if (null != m && null != m.getTemp()&& 
				(m.getTemp() == "dxx" || m.getTemp().equals("dxx"))){
		
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss ");

		// 获得当前时间
		Date now = new Date();
		String str3 = dateFormat.format(now);

		Message message = new Message();

		Cookies cookie = new Cookies();
		try {
			// 客户或员工id
			String eocid = cookie.getCookie(request, "employeeId");

			Customer c = (Customer) request.getSession().getAttribute(
					"customer");
			Messagetype mest = new Messagetype();
			if (mark1 == "1" || mark1.equals("1")) {
				
				mest.setMessagetypeid(1);
				
				message.setMessagetypeBySendertype(mest);
				
				mest.setMessagetypeid(19);
				
				message.setMessagetypeByMessagetype(mest);
				
				message.setSender(eocid);
				
			} else if (mark1 == "2" || mark1.equals("2")) {
				
				mest.setMessagetypeid(2);
				
				message.setMessagetypeBySendertype(mest);
				
                mest.setMessagetypeid(19);
				
				message.setMessagetypeByMessagetype(mest);
				
				message.setSender(c.getCustomerId().toString());
			}
			message.setReleasetime(Timestamp.valueOf(str3));
			
			message.setDelfalg("0");

 			message.setDraftfalg("0");

			message.setRepealfalg("0");

			message.setMessagecontent(content);

			message.setTitleweb(title);

			messageBussiness.addData(message);

			if (mark1 == "1" || mark1.equals("1")) {

				// 获取添加员工接收对象id
				for (int i = 0; i < receiverId.length; i++) {
					
					Messagereceiver receiver = new Messagereceiver();
					
					receiver.setMessage(message);
					// 接收人类型
					receiver.setMessagetype(messagetypeBussiness
							.getMessageTypedata("1"));
					
					receiver.setDelfalg("0");
					
					receiver.setReceiverer(receiverId[i]);
					
					receiver.setReadfalg("0");
					
					messagereceiverBussiness.addData(receiver);
				}
			}
			if (mark1 == "2" || mark1.equals("2")) {
				
				// 获取添加客户接受对象
				for (int i = 0; i < receiverId.length; i++) {
					
					Messagereceiver receiver = new Messagereceiver();
					
					receiver.setMessage(message);
					// 接收人类型
					receiver.setMessagetype(messagetypeBussiness
							.getMessageTypedata("2"));
					
					receiver.setDelfalg("0");
					
					receiver.setReceiverer(receiverId[i]);
					
					receiver.setReadfalg("0");
					
					messagereceiverBussiness.addData(receiver);
				}
			}

		} catch (Exception e) {
			
			e.printStackTrace();

		}

		}
	}

	public MessageremindBiz getMessager() {
		return messager;
	}

	public void setMessager(MessageremindBiz messager) {
		this.messager = messager;
	}

	public MessagetypeBussiness getMessagetypeBussiness() {
		return messagetypeBussiness;
	}

	public void setMessagetypeBussiness(MessagetypeBussiness messagetypeBussiness) {
		this.messagetypeBussiness = messagetypeBussiness;
	}

	public MessagereceiverBussiness getMessagereceiverBussiness() {
		return messagereceiverBussiness;
	}

	public void setMessagereceiverBussiness(
			MessagereceiverBussiness messagereceiverBussiness) {
		this.messagereceiverBussiness = messagereceiverBussiness;
	}

	public MessageBussiness getMessageBussiness() {
		return messageBussiness;
	}

	public void setMessageBussiness(MessageBussiness messageBussiness) {
		this.messageBussiness = messageBussiness;
	}

}
