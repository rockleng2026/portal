package com.fuao.fajxc.action.stat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 季度统计
 * 包括盘点
 * 月统计
 * 年统计等
 * @author Administrator
 *
 */
public class UptoSnuffStatAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub

	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub

	}

	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 统计
	 */
	public String get()
	{
		return "success";
	}

}
