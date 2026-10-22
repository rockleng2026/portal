package com.fuao.fajxc.util;

import java.io.File;


import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import org.apache.log4j.*;

import javax.mail.internet.MimeMessage;



import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

public class Email {
	private Logger logger = Logger.getLogger(Email.class);
	/**
	 * 发送html邮件
	 * 
	 * @param host
	 * @param username
	 * @param password
	 * @param to
	 * @param title
	 * @param content
	 * @return
	 */
	public boolean sendEmail(String to, String title, String content) {
		try {
			JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
			// 设定mail server
			senderImpl.setHost(FinalConfig.FTP_STRING);
			senderImpl.setPort(FinalConfig.EMAIL_PORT);
			senderImpl.setUsername(FinalConfig.EMAIL);
			senderImpl.setPassword(FinalConfig.EMAIL_PASSWORD);

			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			senderImpl.setJavaMailProperties(props);

			// 建立邮件消息,发送html邮件 发送带附件的邮件可以使用MimeMessage+MimeMessageHelper
			MimeMessage mailmessage = senderImpl.createMimeMessage();

			MimeMessageHelper messagehelper = new MimeMessageHelper(
					mailmessage, true, "utf-8");

			logger.info("t:"+title);
			// 设定收件人、寄件人、主题与内文
			messagehelper.setTo(to);
			messagehelper.setFrom(FinalConfig.EMAIL);
			messagehelper.setSubject(title);
			// 发送html格式的内容，MimeMessageHelper中的方法setText("需要发送的html格式的内容",true)
			messagehelper.setText(content, true);

			// 传送邮件
			senderImpl.send(mailmessage);
			logger.info("邮件传送OK..");
			return true;
		} catch (Exception e) {
			logger.error("send email error",e);
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 发送带附件的html邮件
	 * 
	 * @param path
	 * @param host
	 * @param username
	 * @param password
	 * @param to
	 * @param title
	 * @param content
	 * @param imgmap
	 * @return
	 */
	public boolean sendEmail(String path, String host, String username,
			String password, String to, String title, String content,
			Map<String, String> imgmap) {
		try {
			JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
			// 设定mail server
			senderImpl.setHost(host);
			senderImpl.setUsername(username);
			senderImpl.setPassword(password);

			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			senderImpl.setJavaMailProperties(props);

			// 建立邮件消息,发送html邮件 发送带附件的邮件可以使用MimeMessage+MimeMessageHelper
			MimeMessage mailmessage = senderImpl.createMimeMessage();

			MimeMessageHelper messagehelper = new MimeMessageHelper(
					mailmessage, true, "utf-8");

			// 发送到哪儿
			messagehelper.setTo(to);
			messagehelper.setFrom(username);
			messagehelper.setSubject(title);
			messagehelper.setText(content, false);

			// 发送带附件的邮件
			for (String key : imgmap.keySet()) {
				//messagehelper.addInline(key, new File(path + imgmap.get(key)));
				messagehelper.addAttachment(key, new File(path + imgmap.get(key)));
			}
			
			// 传送邮件
			senderImpl.send(mailmessage);
			logger.info("邮件传送OK!");
			return true;
		} catch (Exception e) {
			logger.error("send email error",e);
			e.printStackTrace();
		}
		return false;
	}
	

	public static void main(String[] args) throws UnsupportedEncodingException {
		
//		String aa = "http://localhost:8080/FAJxc/customService/customProscenium/customerRegisterCustomerServer.do";
//		String aaa = aa.substring(0,aa.indexOf("FAJxc"));
//		System.out.println(aaa+"FAJxc");
		Email email=new Email();
		boolean chengong=email.sendEmail("419728185@qq.com", "服务提醒", "服务在线局长信箱来件");
		boolean chengong2=email.sendEmail("lengzhiyong@hotmail.com", "服务提醒", "服务在线局长信箱来件");
		boolean chengong3=email.sendEmail("408072153@qq.com", "服务提醒", "服务在线局长信箱来件");
		System.out.println(""+chengong+chengong2+chengong3);
		
//		Map<String, String> files = new HashMap<String, String>();
//		files.put("JAVA中URL链接中文参数乱码的处理方法.txt", "JAVA中URL链接中文参数乱码的处理方法.txt");
//		files.put("JAVA处理日期时间常用方法.doc", "JAVA处理日期时间常用方法.doc");
//		Email sendemail = new Email();
////		sendemail.sendEmail("G:\\java\\", "smtp.163.com",
////				"xy2_qp7711@163.com", "1802030", "381315758@qq.com",
////				"服务在线局长信箱来件", "<a href='www.baidu.com'>有东西</a>！", files);
//		
//		sendemail.sendEmail( "smtp.163.com",0,"xy2_qp7711@163.com", "1802030", "381315758@qq.com",
//				"服务在线局长信箱来件", "<a href = http://192.168.1.23:8080/FAJxc/customService/customProscenium/login.jsp/>有东西</a>！");
//		
	}
}
