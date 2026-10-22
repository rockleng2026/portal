package com.fuao.fajxc.action.newproject;

/*******
 * 问题讨论和领导评价Action
 */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.newproject.TalkProject;
import com.opensymphony.xwork2.ActionSupport;

public class TalkProjectAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private TalkProject talkdao;
	
	public TalkProject getTalkdao() {
		return talkdao;
	}
	public void setTalkdao(TalkProject talkdao) {
		this.talkdao = talkdao;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

}
