package com.fuao.fajxc.action.purchasing;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.action.basic.EmployeeAction;
import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.util.Pages;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 采购价格一览表
 * @author 14012
 *
 */
public class ScheduleOfValuesAction implements ModelDriven,ServletRequestAware, ServletResponseAware {

	private static Logger logger = Logger.getLogger(EmployeeAction.class);
	private PurOrderBussiness purBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Object[] ids;

	
	
	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the purBussiness
	 */
	public PurOrderBussiness getPurBussiness() {
		return purBussiness;
	}

	/**
	 * @param purBussiness the purBussiness to set
	 */
	public void setPurBussiness(PurOrderBussiness purBussiness) {
		this.purBussiness = purBussiness;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}

	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 查看采购订单详细
	 * @return
	 */
	public String get()
	{
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		System.out.println("Sget");
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找的采购订单编号
//		String purNo=request.getParameter("purNo");
//		if(purNo!=null){
//			addhql+=" and purOrderNo like '%"+purNo+"%'";
//		}
		String hql="from PurOrderInfo where priceDelflag=0"+addhql+" order by id desc";
		Pages pages=purBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 * 删除采购价格记录
	 * @return 
	 */
	public String delete()
	{
		System.out.println("delete");
		boolean flag=purBussiness.delPurOrderInfos(ids);
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
			logger.error("采购订单详细删除时错误！",ex);
			ex.printStackTrace();
		}
		return null;
	}

}
