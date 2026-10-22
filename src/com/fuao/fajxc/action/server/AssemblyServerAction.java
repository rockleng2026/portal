package com.fuao.fajxc.action.server;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.server.AssemblyServerBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AssemblyServer;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.UpServer;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class AssemblyServerAction  implements ServletRequestAware,ServletResponseAware,ModelDriven {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private AssemblyServer assemb; 
	private AssemblyServerBussiness asb;
	private Object[] ids;
	//获得下架单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	Cookies ck = new Cookies();
	
	
	
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

	public AssemblyServerBussiness getAsb() {
		return asb;
	}

	public void setAsb(AssemblyServerBussiness asb) {
		this.asb = asb;
	}

	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public Object getModel() {
		assemb=new AssemblyServer();
		return assemb;
	}
	
	/**
	 * 分页显示组装服务器记录
	 * @return
	 */
	public String select()
	{
		String marker=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker);
		request.setAttribute("taskid", taskid);
		
		System.out.println("--------------------------");
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找
		String sjNo=request.getParameter("sjNo");
		if(sjNo!=null&&sjNo!=""){
			addhql+=" and assemblyNo like '%"+sjNo+"%'";
		}
		String hql="from AssemblyServer where delflag=0"+addhql;
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by id desc";
		
		Pages pages=asb.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 *跳转到添加服务器页面
	 */
	public String addShow()
	{
		//获得下架单号
		String ASNo="AS-"+serial.getSerialNumber();
		request.setAttribute("XJNo", ASNo);
		return "add";
	}
	
	/**
	 * 添加组装服务器记录
	 * @return
	 */
	public String add()
	{
		boolean flag=false;
		try
		{
			assemb.setRemark(new String(assemb.getRemark().getBytes("GBK"), "UTF-8"));
			flag=asb.addServerControl(assemb, "sd-"+serial.getSerialNumber());
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查看详细信息
	 * @return
	 */
	public String detailed()
	{
		String id=request.getParameter("cid");
		if(id!=null)
		{
			AssemblyServer ups=(AssemblyServer) asb.someassemblyServer(" and id="+Integer.parseInt(id)).get(0);
			request.setAttribute("oneAss", ups);
		}
		return "detail";
	}
	
	/**
	 * 修改显示页面
	 * @return
	 */
	public String updataShow()
	{
		String id=request.getParameter("cid");
		if(id!=null){
			AssemblyServer ups=(AssemblyServer) asb.someassemblyServer(" and id="+Integer.parseInt(id)).get(0);
			request.setAttribute("oneAss", ups);
		}
		return "add";
	}
	
	/**
	 * 修改组装服务器记录
	 * @return
	 */
	public String edit()
	{
		try
		{
			assemb.setRemark(new String(assemb.getRemark().getBytes("GBK"), "UTF-8"));
			boolean flag=asb.editServerControl(assemb);
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 删除
	 * @return
	 */
	public String del()
	{
		boolean flag=asb.delassemblyServer(ids);
		try
		{
			if(flag){
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	

}
