package com.fuao.fajxc.action.server;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.server.UpserverBussiness;
import com.opensymphony.xwork2.ActionSupport;

public class OnlineServerCount extends ActionSupport implements ServletRequestAware,ServletResponseAware{
    
	private UpserverBussiness upbbus;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public UpserverBussiness getUpbbus() {
		return upbbus;
	}
	public void setUpbbus(UpserverBussiness upbbus) {
		this.upbbus = upbbus;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		response=arg0;
	}
    public String serverCounts(){
    	
    	return SUCCESS;
    }
}
