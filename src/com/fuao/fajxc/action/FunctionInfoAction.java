package com.fuao.fajxc.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.FunctionInfoBussiness;
import com.fuao.fajxc.vo.FunctionInfo;
import com.opensymphony.xwork2.ModelDriven;

public class FunctionInfoAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	/**
	 * 日志记录
	 */
	private static Logger logger = Logger.getLogger(FunctionInfoAction.class);
	
	/**
	 * 登录Bussinesss注入
	 */
	private FunctionInfoBussiness functionInfobiz;
	
	
	public String getFunctionAction()
	{
		System.out.println("execute functionAction");
		List<FunctionInfo> list = functionInfobiz.getFunctionsList();
		if(list.size()>0)
		{
			System.out.println(list.size());
			logger.info("function size : "+list.size());
			ServletActionContext.getContext().getSession().put("infolist", list);
			return "success";
		}
		return "failure";
	}

	
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
	}
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
	}
	
	/**
	 * set方法
	 */
	public void setFunctionInfobiz(FunctionInfoBussiness functionInfobiz) {
		this.functionInfobiz = functionInfobiz;
	}
}
