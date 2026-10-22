package com.fuao.fajxc.action.cms_member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.opensymphony.xwork2.ModelDriven;

public class MemberAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CommonBiz commonbiz;
	
	
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public Object getModel() {
		return null;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public CommonBiz getCommonbiz() {
		return commonbiz;
	}

	public void setCommonbiz(CommonBiz commonbiz) {
		this.commonbiz = commonbiz;
	}

}
