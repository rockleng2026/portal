package com.qq.sns.beans;

/**
 * 账户类
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */

public class Account {
	private String name = ""; // 帐号
	private String nick = ""; // 昵称
	private String head = ""; // 头像


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}


	@Override
	public String toString() {
		return "{name:\"" + name + "\", nick:\"" + nick + "\", head:\"" + head
				+ "\"}";
	}
}
