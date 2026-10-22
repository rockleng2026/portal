package com.fuao.fajxc.action.basic;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.vo.Supplier;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;


public class SupplierAction implements ModelDriven,ServletRequestAware,ServletResponseAware  {

	/**
	 * 
	 * 供应商信息
	 * @return
	 */
	private SupplierBussiness supplierBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Supplier supplier;



	/**
	 * 得到request
	 */
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
		
	}
	
	/**
	 * 得到response
	 */
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
		
	}

	public Object getModel() {
		 supplier = new Supplier();
		return supplier;
	}
	public SupplierBussiness getSupplierBussiness() {
		return supplierBussiness;
	}
	public void setSupplierBussiness(SupplierBussiness supplierBussiness) {
		this.supplierBussiness = supplierBussiness;
	}
	
	/**
	 * 查询供应商
	 * @return
	 */
	public String select()
	{
		
		Map map = (Map)ActionContext.getContext().get("map");
		String hql="from Supplier where del = 0 ";
		
		String dpage=request.getParameter("pageNo");
		int pageNo=1;
		
		String name = request.getParameter("name");
		if(name !=null && !name.equals(""))
		{
			hql +=" and supplierName like '%"+name+"%'";
		}
		if(dpage != null && !dpage.equals(""))
		{
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
			if(request.getParameter("order") != null)
			{
				hql += " order by "+request.getParameter("order")+" desc";
			}else
			{
		hql += " order by id desc";
			}
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages=supplierBussiness.paginationQuery(hql, pageNo, 10, null);
		request.getSession().setAttribute("pages", pages);
		request.getSession().setAttribute("tag", request.getParameter("order"));
		request.getSession().setAttribute("option", map);
		return "success";
	}
	
	/**
	 * 添加供应商
	 */
	public String add()
	{
		supplier.setDel("0");
		boolean b= supplierBussiness.addSuplier(supplier);
		if(b){
			response.setCharacterEncoding("GBK");
		return "select";
		}
		return "error";
	}
	
	/**
	 * 根据ID查询到供应商信息
	 * 跳转到修改供应商页面
	 */
	public String updatePage()
	{
		String trim = request.getParameter("trim");
		String id = request.getParameter("id");
		Supplier supplie=supplierBussiness.getSupplier(Integer.parseInt(id));
		request.setAttribute("supplier", supplie);
		if(null != trim && trim.equals("info"))
		{
			return "supplierInfo";
		}
		return"upSupplier";
		
		
	}
	
	/**
	 * 修改供应商信息
	 */
	public String update()
	{

		String email = request.getParameter("email");
		boolean b=supplierBussiness.updateSupplier(supplier);
		if(b){
		return this.select();
		}
		return "error";
	}
	
	/**
	 * 删除供应商信息
	 */
	public String del()
	{
		String id = request.getParameter("id");
		Supplier s=supplierBussiness.getSupplier(Integer.parseInt(id));
		s.setDel("1");
		boolean b=supplierBussiness.updateSupplier(s);
		if(b)
		{
			try {
				response.getWriter().print(1);
			    
			} catch (IOException e) {

				e.printStackTrace();
			}

			return null;
		}
		return null;
	}

	/**
	 * 检查供应商名称是否存在
	 * @throws IOException 
	 */
	public void checkname() throws IOException
	{
		String name = URLDecoder.decode( request.getParameter("name"),"UTF-8");
		String andhql = "and supplierName ="+"'"+name+"'";
		List list = supplierBussiness.selSupplier(andhql);
		if(list.size()>0)
		{
			response.getWriter().println(1);
		}else
			response.getWriter().println(0);
	}



}
