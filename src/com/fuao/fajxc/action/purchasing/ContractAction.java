package com.fuao.fajxc.action.purchasing;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ModelDriven;
/**
 * ²É¹ººÏÍ¬Action
 * @author 14012
 *
 */
public class ContractAction implements ModelDriven, ServletRequestAware,ServletResponseAware {

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub

	}

	public void setServletResponse(HttpServletResponse arg0) {
		

	}

	public void requestDestroyed(ServletRequestEvent arg0) {
		// TODO Auto-generated method stub

	}

	public void requestInitialized(ServletRequestEvent arg0) {
		// TODO Auto-generated method stub

	}

	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	public String get()
	{
		return "success";
	}

}
