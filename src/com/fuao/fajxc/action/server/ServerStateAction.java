package com.fuao.fajxc.action.server;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.server.ServerStateBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;

public class ServerStateAction implements ServletRequestAware,ServletResponseAware {

	private ServerStateBussiness ssb;
	private HttpServletRequest request;
	private HttpServletResponse response;
	//声明置文件工具
	PropertyEditor proEdit=new PropertyEditor();
	

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

	public ServerStateBussiness getSsb() {
		return ssb;
	}

	public void setSsb(ServerStateBussiness ssb) {
		this.ssb = ssb;
	}
	
	

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}
	
	/**
	 * 查找所有服务器
	 * @return
	 */
	public String select()
	{
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找
		String name=request.getParameter("name");
		if(name !=null && !name.equals(""))
		{
			addhql +=" and property.name like '%"+name+"%'";
		}
		addhql+=" and usestate!=3 and property.model.commodityTpye.id="+proEdit.getID("server");
		String hql="from Product where  delflag=0"+addhql+" order by id desc";
		Pages pages=ssb.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 * 修改使用状态
	 * @return
	 */
	public String editstate()
	{
		String state=request.getParameter("state");
		String id=request.getParameter("id");
		try
		{
			if(state!=null&&id!=null){
				boolean flag=ssb.changeState(Integer.parseInt(state), Integer.parseInt(id));
				if(flag){
					return this.select();
				}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	
}
