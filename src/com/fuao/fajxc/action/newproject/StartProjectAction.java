package com.fuao.fajxc.action.newproject;

/*******
 * 立项审请Action
 */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.newproject.StartProject;
import com.opensymphony.xwork2.ActionSupport;

public class StartProjectAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private StartProject startdao;// 立项dao
	
	public StartProject getStartdao() {
		return startdao;
	}
	public void setStartdao(StartProject startdao) {
		this.startdao = startdao;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

}
