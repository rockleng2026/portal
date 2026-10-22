package com.fuao.fajxc.action.basic;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Supplier;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;


public class SupplierrAction implements ServletRequestAware,ModelDriven,ServletResponseAware  {
	private static Logger logger = Logger.getLogger(SupplierrAction.class);
	/**
	 * 
	 * 供应商信息
	 * @return
	 */
	private SupplierBussiness supplierBussiness;
	
	private HttpServletRequest request;
	
	private HttpServletResponse response;
	
	private Supplier supplier;
	
	//添加动态记录业务类
	private ExecuteRecordBussiness executeRecordBussiness;
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

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
	 * @throws IOException 
	 */
	public String select() throws IOException
	{
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		Map map = (Map)ActionContext.getContext().get("map");
		String hql="from Supplier where del = 0 ";
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id = "+sid;
		}
		
		String dpage=request.getParameter("pageNo");
		int pageNo=1;
/**********************字段查找***********************/
		if(null != supplier.getId()){
			hql +=" and id like '%" + supplier.getId() + "%' ";
		}
		if( null != supplier.getSupplierAddress() && "" != supplier.getSupplierAddress() && !"".equals(supplier.getSupplierAddress())){
			hql +=" and supplierAddress like '%" + URLDecoder.decode(supplier.getSupplierAddress(),"UTF-8")+"%' ";
		}
		if(null != supplier.getSupplierCompany() && "" != supplier.getSupplierCompany() && !"".equals(supplier.getSupplierCompany())){
			hql += " and supplierCompany like '%" + URLDecoder.decode(supplier.getSupplierCompany(),"UTF-8")+"%' ";
		}
		if(null != supplier.getSupplierOrigin() && "" != supplier.getSupplierOrigin() && !"".equals(supplier.getSupplierOrigin())){
			hql += " and supplierOrigin like '%" + URLDecoder.decode(supplier.getSupplierOrigin(),"UTF-8")+"%' ";
		}
		if(null != supplier.getSupplierName() && "" != supplier.getSupplierName() && !"".equals(supplier.getSupplierName())){
			hql += " and supplierName like '%" + URLDecoder.decode(supplier.getSupplierName(),"UTF-8")+"%' ";
		}
		if(null != supplier.getDate() && "" != supplier.getDate() && !"".equals(supplier.getDate())){
			hql += " and date like '%" + URLDecoder.decode(supplier.getDate(),"UTF-8")+"%' ";
		}
/**********************/
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
		Pages pages = supplierBussiness.paginationQuery(hql, pageNo, 10, null);
/******************字段的ajax查询***************/
		if(request.getParameter("tage") != null && request.getParameter("tage").equals("y"))
		{
			PropertyEditor property = new PropertyEditor();
			String strr="";
			String str="";
			if(null != pages.getPageList() && pages.getPageList().size()>0){
			for(int i=0; i<pages.getPageList().size(); i++){
				Supplier supplier = new Supplier();
				supplier = (Supplier)pages.getPageList().get(i);
				str = property.getID("selectsupplierr").toString();
			    str = str.replace("#id#", supplier.getId().toString());
				str = str.replace("#supplierCompany#", supplier.getSupplierCompany());
				str = str.replace("#supplierAddress#", supplier.getSupplierAddress());
				str = str.replace("#supplierOrigin#", supplier.getSupplierOrigin());
				str = str.replace("#supplierName#", supplier.getSupplierName());
				str = str.replace("#date#", supplier.getDate());
				strr +=str;		
			}
			pages.setUrl("selectsupplierr.do");
				strr+="#"+pages.getHtml("selectsupplierr");
			}
			   response.setCharacterEncoding("utf-8");
			   response.getWriter().print(strr);
			   System.out.println(strr);
			   return null;
		}
/************************/
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("tag", request.getParameter("order"));
		request.getSession().setAttribute("option", map);
		return "success";
	}
	/**
	 * 跳转到添加页面
	 * @return
	 */
	public String goadd(){
		return "goadd";
	}
	/**
	 * 添加供应商
	 */
	public String add()
	{
		logger.info("供应商添加");
		
		supplier.setDel("0");
		
		logger.error("供应商名称2:"+request.getParameter("supplierName"));
		
		Supplier sup = supplierBussiness.addReturnSuplier(supplier);
		if( null != sup){
			response.setCharacterEncoding("GBK");
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个供应商。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(sup.getId().toString());
				executerecord.setEntityName("Supplier");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
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

		boolean b=supplierBussiness.updateSupplier(supplier);
		if(b){
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个供应商的信息。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(supplier.getId().toString());
				executerecord.setEntityName("Supplier");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			return "select";
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
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个供应商。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("Supplier");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
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
//		String name2 = URLDecoder.decode( request.getParameter("name"),"GBK");
//		String name3 = URLDecoder.decode( request.getParameter("name"),"ISO-8859-1");
//		String name4 = URLDecoder.decode(request.getParameter("name"));
//		String name5 = StringUtil.decode(request.getParameter("name"));
//		System.out.println(request.getParameter("name"));
		System.out.println(name);
//		System.out.println(name2);
//		System.out.println(name3);
//		System.out.println(name4);
//		System.out.println(name5);
		//String name = request.getParameter("name");
		String andhql = "and supplierName ="+"'"+name+"'";
		logger.info(andhql);
		List list = supplierBussiness.selSupplier(andhql);
		if(list.size()>0)
		{
			response.getWriter().println(1);
		}else
			response.getWriter().println(0);
	}



}
