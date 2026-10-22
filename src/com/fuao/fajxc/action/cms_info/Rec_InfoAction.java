package com.fuao.fajxc.action.cms_info;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.opensymphony.xwork2.ModelDriven;

public class Rec_InfoAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Fa_Cms_Rec_Info rec_info;
	private CommonBiz commonbiz;
	
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public Object getModel() {
		return null;
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
	public Fa_Cms_Rec_Info getRec_info() {
		return rec_info;
	}
	public void setRec_info(Fa_Cms_Rec_Info recInfo) {
		rec_info = recInfo;
	}
	public CommonBiz getCommonbiz() {
		return commonbiz;
	}
	public void setCommonbiz(CommonBiz commonbiz) {
		this.commonbiz = commonbiz;
	}
	
}
