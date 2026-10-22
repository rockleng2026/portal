package com.fuao.fajxc.action.system;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.system.MessageremindBiz;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messageremind;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class MessageremindAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private Messageremind mr;
	private MessageremindBiz mb;
	
	/**
	 * 添加或者修改
	 * @return
	 */
	public String add(){
		
		boolean flag=mb.addorupmessageremind(mr);
		
		return "succeed";
	}
	
	/**
	 * 跳转到修改页面
	 */
	public String upda()
	{
		String id = request.getParameter("id");
		
		Messageremind messa = mb.getmessa(id);
		
		request.setAttribute("messageremind", messa);
		
		return "add";
	}
	/**
	 * 删除
	 * @return
	 * @throws IOException 
	 */
	public String del() throws IOException{
		
		String id = request.getParameter("id");
		try{
		mb.delmessageremin(id);
		response.getWriter().print(0);
		}catch (Exception e) {
			response.getWriter().print(1);
		}
		return null;
	}
	
	/**
	 * 分页查询
	 */
	public String get(){
		
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		
		String name = request.getParameter("name");
		
		String hql="from Messageremind as tb where 1=1";
		
		if(name != null && name !="" && !name.equals(""))
		{
			hql += " and tb.typeName like '%"+name+"%'";
		}
		hql+=" order by tb.id desc";
		Pages pages=mb.exHqlObjectPages(hql, Integer.parseInt(pageNo), 25, null);
		request.setAttribute("pages", pages);
        Map map = (Map)ActionContext.getContext().get("map");
		
        ServletActionContext.getRequest().setAttribute("option", map);
		return "list";
	}
	
	public Object getModel() {
		
		mr = new Messageremind();
		
		return mr;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		
	}

	public MessageremindBiz getMb() {
		return mb;
	}

	public void setMb(MessageremindBiz mb) {
		this.mb = mb;
	}

	/**
	 * 检查标识是否存在
	 * @throws IOException 
	 */
	public String checkMark() throws IOException{
		
		String mark = request.getParameter("name");
		
		if(null == mb.getmr(mark))
		{
			response.getWriter().print(0);
		}else
			response.getWriter().print(1);
		
		
		return null;
	}
	
}
