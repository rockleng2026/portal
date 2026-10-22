package com.fuao.fajxc.action.commodity;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.fuao.fajxc.bussiness.commodity.CommodityTypeBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import com.fuao.fajxc.util.TimePattern;

public class CommodityTpyeAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	private CommodityTypeBussiness commodityTypeBussinessao;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Field field;
	//动态记录
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public Field getField() {
		return field;
	}

	public void setField(Field field) {
		this.field = field;
	}

	public CommodityTypeBussiness getCommodityTypeBussinessao() {
		return commodityTypeBussinessao;
	}

	public void setCommodityTypeBussinessao(
			CommodityTypeBussiness commodityTypeBussinessao) {
		this.commodityTypeBussinessao = commodityTypeBussinessao;
	}
	
	public Object getModel() {
		field= new Field ();
		return field;
	}

	public void setServletRequest(HttpServletRequest arg) {
		this.request=arg;
		
	}

	public void setServletResponse(HttpServletResponse arg) {
		this.response=arg;
		
	}
	/**
	 * 查询商品类型
	 * 跟型号做级联菜单
	 * @return
	 * @throws IOException
	 */
	public String select() throws IOException
	{
		response.setContentType("text/html;charset=GBK");
		 String str="";
		 PrintWriter pw = response.getWriter();
		List<CommodityTpye>  alldept=commodityTypeBussinessao.getCommoditTypes();
		str+="<option value=''>请选择</option>";
		for (CommodityTpye data : alldept) {
			 str += "<option value='"+data.getId()+"'>"+data.getTypeName()+"</option>";
		}
		if(alldept.size() > 0){
			pw.write(str);
		}else{
			pw.write("<option value=''></option>");
		}	 
		return null;
	}
	/**
	 * 添加或者删除商品类型
	 * 在给商品类型添加字段属性
	 */
	public String add()
	{
		String fid = request.getParameter("fid");
		String ctid = request.getParameter("ctid");
		String typeName = request.getParameter("typeName");
		String time = request.getParameter("time");
		String ischeckbox = request.getParameter("ischeckbox");
		String ico = request.getParameter("ico");
		String superid = request.getParameter("superid");
		CommodityTpye ctype = new CommodityTpye();
		if(fid != null &&  !fid.equals(""))
		{
			field.setId(Integer.parseInt(fid));
		}
		 Field fieleid = commodityTypeBussinessao.addobj(field);
		 if(fieleid != null)
		 {
			String loginname = request.getSession().getAttribute("loginName").toString();
			Users user = new Users();
			 Employee emp = new Employee();
			if (loginname != null || !loginname.equals(""))
			{
				 user = commodityTypeBussinessao.getUsers(loginname);
				  emp = commodityTypeBussinessao.getEmp(user.getCustomerOrEmployeeId());
			}
			if(ctid != null && !ctid .equals("")){
				ctype.setId(Integer.parseInt(ctid));
			}
			if(superid != null && !superid.equals(""))
			{
				CommodityTpye c = new CommodityTpye();
				c.setId(Integer.parseInt(superid));
				ctype.setSuperid(c);
			}else{
				ctype.setSuperid(null);
			}
			
			ctype.setTypeName(typeName);
			ctype.setIco(ico);
			ctype.setIscheckbox(ischeckbox);
			
			ctype.setTime(time);
			ctype.setEmployee(emp);
			ctype.setField(fieleid);
			ctype.setDel("0");
			CommodityTpye commod = commodityTypeBussinessao.addReturn(ctype);
		
			/*阙超强 14015   添加记录动态信息*/
			if(null != commod){
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加/修改了一个商品类型。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(ctype.getId().toString());
					executerecord.setEntityName("CommodityTpye");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
			}
		 }
		return "select";
	}
	/**
	 * 分页查询商品类型信息
	 * @return
	 */
	public String selectPage()
	{
		String hql = "from CommodityTpye where del = 0";
		String dpage=request.getParameter("pageNo");
		int pageNo=1;
		String name = request.getParameter("tname");
		if(name !=null && !name.equals(""))
		{
			hql +=" and typeName like '%"+name+"%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
		hql += " order by id desc";
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages=commodityTypeBussinessao.getCommodityType(hql, pageNo, 10, null);
		Map map = (Map)ActionContext.getContext().get("map");
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("option", map);
		return "success";
	}
	/**
	 * 跳转到修改商品类型页面
	 */
	public String updatePage()
	{
		String id = request.getParameter("id");
		CommodityTpye ct =commodityTypeBussinessao. getCommodityTpye(id);
		request.setAttribute("ct", ct);
		return "add";
	}

	/**
	 * 删除商品类型
	 * @throws IOException 
	 */
	public void del() throws IOException
	{
		String id = request.getParameter("id");
		CommodityTpye ct =commodityTypeBussinessao. getCommodityTpye(id);
		ct.setDel("1");
		boolean b =commodityTypeBussinessao.del(ct);
		if(b)
		{
			response.getWriter().println(0);
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一个商品类型。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(id);
				executerecord.setEntityName("CommodityTpye");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		}else
			response.getWriter().println(1);
		
	}
	public String info()
	{
		String id = request.getParameter("id");
		CommodityTpye ct =commodityTypeBussinessao. getCommodityTpye(id);
		request.setAttribute("ct", ct);
		return "info";
	}
	
	public String field()
	{
		String id = request.getParameter("id");
		CommodityTpye ct =commodityTypeBussinessao. getCommodityTpye(id);
		
		 Field field = commodityTypeBussinessao.getObj(ct.getField().getId());
         request.setAttribute("ct", ct);
		try {
			response.getWriter().print(field);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		return "";
	}
	public String getcom() throws IOException{
	//	List<CommodityTpye> list = commodityTypeBussinessao.getCommoditTypes();
		List<CommodityTpye> functionlist = commodityTypeBussinessao.getCommoditTypes();
		List<CommodityTpye> childlist = new ArrayList<CommodityTpye>();
//		CategoryAction action = new CategoryAction();
		for(CommodityTpye f : functionlist)
		{
//			System.out.println("111   "   +f.getSuperId());
//			System.out.println(f.getSuperId().equals(0));
			if(f.getSuperid().getId()==61)
			{
				CommodityTpye type = new CommodityTpye();
				type.setId(f.getId());
				type.setSuperid(f.getSuperid());
				type.setTypeName(f.getTypeName());
//				type.setChild(action.buildNode(f.getId(),functionlist));
				childlist.add(type);
				response.getWriter().print(childlist);
			}
		}
		
//		System.out.println(childlist.size());
//		
//		
//		System.out.println(childlist.size());
//		String straction = "";
//		for(CommodityTpye node : childlist)
//		{
//			String str = "";
////			System.out.println(node.getId()+"   "+node.getSuperid()+"   "+node.getTypeName());
//			if(node.getSuperid().getId()==61)
//			{
//				System.out.println("<option>"+node.getTypeName()+"</option>");
//				action.bulidNode(1,node.getChild());
////				System.out.println("<option value='"+node.getId()+"'>"+node.getTypeName()+"</option>");
////				str = "<option value='"+node.getId()+"'>"+node.getTypeName()+"</option>";
//				str += action.getStr(1, node.getChild());
//				System.out.println("begin : "+str);
//			}
//			straction += str;
//			str = "";
//		}
//		System.out.println("straction:"+straction);
		return null;
	}
}
