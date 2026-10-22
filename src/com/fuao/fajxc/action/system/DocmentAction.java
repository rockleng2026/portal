package com.fuao.fajxc.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.system.DocmentBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.Docmark;
import com.opensymphony.xwork2.ModelDriven;

public class DocmentAction implements ServletRequestAware,ServletResponseAware,ModelDriven {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private Docmark docmark;
	private DocmentBussiness docbussiness;
	
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response=response;
	}

	public Object getModel() {
		docmark=new Docmark();
		return docmark;
	}

	public DocmentBussiness getDocbussiness() {
		return docbussiness;
	}

	public void setDocbussiness(DocmentBussiness docbussiness) {
		this.docbussiness = docbussiness;
	}
	
	/**
	 * 查找分页
	 * @return
	 */
	public String getpage(){
		String addhql="";
		String payNo=request.getParameter("payNo");
		System.out.println("payNo:"+payNo);
		if(payNo!=null&&payNo!="")
		{
			addhql+=" and mark like '%"+payNo+"%'";
		}
		System.out.println(11111);
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String hql="from Docmark where 1=1 "+addhql+" order by id desc";
		Pages pages=docbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages:::::::"+pages);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 * 跳转的添加页面
	 */
	public String addpage(){
		// 绑定业务类型
		int superid=PublicMissionType.operationtype;
		String hql="From Missiontype where superid="+superid;
		List typelist=docbussiness.exHql(hql);
		request.setAttribute("typelist", typelist);
		return "add";
	}
	
	/**
	 * 添加
	 */
	public String add(){
		boolean flag=docbussiness.addDoc(docmark);
		request.getSession().setAttribute("marks", docmark.getMark());
		if(flag)
			return "select";
		return null;
	}
	
	/**
	 * 跳转到修改页面
	 */
	public String skipupdate(){
		String id=request.getParameter("id");
		if(id!=null){
			List list=docbussiness.selDocmark(" and id="+id+"");
			if(list.size()>0){
				request.setAttribute("docshow", list.get(0));
			}
		}
		return "add";
	}
	
	/**
	 * 更新
	 */
	public String update(){
		System.out.println();
		boolean flag=docbussiness.updateDoc(docmark);
		if(flag)
			return "select";
		return null;
	}
	
	/**
	 * 删除
	 */
	public String del(){
		boolean flag=false;
		String id=request.getParameter("id");
		if(id!=null){
			List list=docbussiness.selDocmark(" and id="+id+"");
			if(list.size()>0){
				Docmark docm=(Docmark) list.get(0);
				flag=docbussiness.delDoc(docm);
			}
		}
		try{
			if(flag)
				response.getWriter().print(0);
			else
				response.getWriter().print(1);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	
	

}
