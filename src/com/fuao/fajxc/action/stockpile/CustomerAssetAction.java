package com.fuao.fajxc.action.stockpile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.vo.CustomerCommodity;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 客户资产信息
 * @author 14012
 *
 */
public class CustomerAssetAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {
	private CustomerCommodity cc;

	public void setServletRequest(HttpServletRequest arg0) {
		

	}

	public void setServletResponse(HttpServletResponse arg0) {


	}

	public Object getModel() {
		cc = new CustomerCommodity();
		return cc;
	}
	public String get ()
	{
		return "success";
	}

}
