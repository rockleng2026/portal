package com.fuao.fajxc.action.pagefunction;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.pageFunction.PageFunctionDAO;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.pagefunction;
import com.opensymphony.xwork2.ActionSupport;

/*
 * author:王雄
 * email:wangxiong@fuao.com
 */
		

public class PageFunctionAction  extends ActionSupport implements ServletRequestAware,ServletResponseAware {

	private Logger logger = Logger.getLogger(PageFunctionAction.class);
	
	private PageFunctionDAO functionDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	

	public PageFunctionDAO getFunctionDAO() {
		return functionDAO;
	}

	public void setFunctionDAO(PageFunctionDAO functionDAO) {
		this.functionDAO = functionDAO;
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

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	/*
	 * 添加请求
	 */
	public String addPG()
	{
		try {
			pagefunction pagefunction = new pagefunction();
			//页面功能名称
			String pagefunctionname = request.getParameter("linkFunctionName");
			//菜单外键表
			String functionid = request.getParameter("superId");
			//链接页面功能
			String linkFunctionPage = request.getParameter("linkFunctionPage");
			//描述
			String descriptions = request.getParameter("description");
			//唯一标识
			int onlyflag=Integer.parseInt(request.getParameter("onlyflag"));
			if(!pagefunctionname.equals(""))
			{
				String str = URLDecoder.decode(pagefunctionname, "utf-8");
				pagefunction.setName(str);
			}
			FunctionInfo functionInfo = new FunctionInfo();
			if(!functionid.equals(""))
			{
				functionInfo.setFunctionId(new Integer(functionid));
			}
			pagefunction.setFunction(functionInfo);
			if(!linkFunctionPage.equals(""))
			{
				pagefunction.setLinkFunctionPage(linkFunctionPage);
			}
			if(!descriptions.equals(""))
			{
				String str = URLDecoder.decode(pagefunctionname, "utf-8");
				pagefunction.setDescription(str);
			}
			//默认的删除标识
			pagefunction.setDelflag(0);
			pagefunction.setOnlyflag(onlyflag);
			
			boolean flag = this.functionDAO.addPageFunction(pagefunction);
			response.setCharacterEncoding("gbk");
			if(flag == true)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("");
			}
			
		} catch (Exception e) {
			logger.error("add pagefunction error"+PageFunctionAction.class.getName());
		}
		return null;
	}
	
	/*
	 * 删除请求
	 */
	public String delPF()
	{
		try {
			logger.info("delete pagefunction start");
			String fundid = request.getParameter("fundids");
			Integer fundids = 0;
			if(!fundid.equals(""))
			{
				fundids = new Integer(fundid);
			}
			
			boolean flag = this.functionDAO.delPF(fundids);
			if(flag == true)
			{
				response.getWriter().print("1");
				return null;
			}else
			{
				response.getWriter().print("2");
				return null;
			}
		} catch (Exception e) {
			logger.error("delete pagefunction for error"+PageFunctionAction.class.getName());
		}
		return null;
	}

}
