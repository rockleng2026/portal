package com.fuao.fajxc.action.customService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.customService.ServerMonitoringBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.ServerMonitor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 *  服务器监控记录
 * @author 14012
 *
 */
public class ServerMonitoringAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	private ServerMonitoringBussiness smbiz;
	private HttpServletResponse response;
	private HttpServletRequest request;
	private ServerMonitor sm;
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;

	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}

	public Object getModel() {
	    sm = new ServerMonitor();
		return sm;
	}


	public ServerMonitoringBussiness getSmbiz() {
		return smbiz;
	}

	public void setSmbiz(ServerMonitoringBussiness smbiz) {
		this.smbiz = smbiz;
	}

	/**
	 * 服务器监控记录查询
	 */
	public String get()
	{
		return "success";
	}
	
    /**
     * 跳转到添加页面
     */
	public String addpage()
	{
		return "add";
	}

	
	/**
	 * 添加或修改
	 */
	public String addorup()
	{
		String serverid = request.getParameter("productid");
		String loginName = request.getSession().getAttribute("loginName").toString();
		Product product = (Product)smbiz.getpr(Product.class,serverid);
		Employee emp = smbiz.getemp(loginName);
		sm.setProduct(product);
		sm.setEmployee(emp);
		sm.setDelflag("0");
		smbiz.add(sm);
		return this.select();
	}
	
	/**
	 * 查询监控记录列表
	 */
	public String select()
	{
		String hql="from ServerMonitor where delflag = 0 ";
		String dpage = request.getParameter("pageNo");
		String name = request.getParameter("cname");

		int pageNo = 1;
		if(name !=null && !name.equals(""))
		{
			hql +=" and name like '%"+name+"%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
			if(null != request.getParameter("order"))
			{
				hql += " order by "+request.getParameter("order")+" desc";
			}else
			{
		hql += " order by id desc";
			}
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages = smbiz.select(hql, pageNo, 10, null);
		Map map = (Map)ActionContext.getContext().get("map");
		request.getSession().setAttribute("pages", pages);
		request.getSession().setAttribute("tag", request.getParameter("order"));
		request.getSession().setAttribute("option", map);
		
		return "success";
	}
	
	/**
	 * 跳转到修改页面
	 */
	public String uppage()
	{
		String id = request.getParameter("id");
		
		ServerMonitor sm = (ServerMonitor)smbiz.getpr(ServerMonitor.class, id);
		request.setAttribute("sm", sm);
		return this.addpage();
	}
	/**
	 * 删除记录
	 * @throws IOException 
	 */
	public String del() throws IOException
	{
        String id = request.getParameter("id");
		ServerMonitor sm = (ServerMonitor)smbiz.getpr(ServerMonitor.class, id);
		sm.setDelflag("1");
		boolean b = smbiz.del(sm);
		if(b)
		{
			response.getWriter().println(1);
			return null;
		}else
		response.getWriter().println(0);
		return null;
	}
}
