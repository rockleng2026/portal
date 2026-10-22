package com.fuao.random;


import java.io.ByteArrayInputStream;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 获取验证码
 * 制作者：暴风一号
 * @author Administrator
 * 
 */
public class RandomAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;
	private Map<String, Object> session;
	private ByteArrayInputStream inputStream;

	@Override
	public String execute() throws Exception {
		RandomNumUtil rdnu = RandomNumUtil.Instance();
		this.setInputStream(rdnu.getImage());
		session.put("random", rdnu.getString());
		return SUCCESS;
	}

	@Override
	public void validate() {
		this.clearErrors();
		this.clearFieldErrors();
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}

	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
