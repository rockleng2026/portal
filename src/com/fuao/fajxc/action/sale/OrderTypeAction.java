package com.fuao.fajxc.action.sale;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.fuao.fajxc.bussiness.cdn.SaleOrderBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;

import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Ordertype;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.RenewLog;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.SetMeal;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.VerifyOrder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 销售订单类型
 * 

 */
public class OrderTypeAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
    private static Logger logger = Logger.getLogger(OrderTypeAction.class);
	private static final long serialVersionUID = 1L;

	private HttpServletRequest request;
	private HttpServletResponse response;
	private Ordertype ordertype;

	private ExecuteRecordBussiness executeRecordBussiness;
	private SaleOrderBussiness saleOrderBussiness;
	public SaleOrderBussiness getSaleOrderBussiness() {
		return saleOrderBussiness;
	}
	public void setSaleOrderBussiness(SaleOrderBussiness saleOrderBussiness) {
		this.saleOrderBussiness = saleOrderBussiness;
	}
	/*request*/
	public HttpServletRequest getRequest() {
		return request;
	}
	/*response*/
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	/*属性封装*/
	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public Ordertype getOrdertype() {
		return ordertype;
	}
	public void setOrdertype(Ordertype ordertype) {
		this.ordertype = ordertype;
	}

	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	/*模型驱动*/
	public Object getModel() {

		ordertype = new Ordertype();
		return ordertype;
	}

	/*request*/
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	/*response*/
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * 跳转至类型列表
	 * 
	 */
	public String goList(){
		//拿到当前第几页
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if(null != strPageNo && !"".equals(strPageNo)){
			pageNo = Integer.parseInt(strPageNo);
		}
		
		String hql = "from Ordertype where delflag = 0 ";
		
		Pages pages = saleOrderBussiness.exePagesList(hql, pageNo, 20, null);
		
		request.setAttribute("pages", pages);
		return "goList";
	}
	/**
	 * 跳转至类型列表
	 * 
	 */
	public String chanpin(){
	
		return "chanpin";
	}
	
	/**
	 * 跳转至添加类型页面
	 */
	public String goAdd(){
		
		return "goAdd";
	}
	
	/**
	 * 跳转至添加类型页面
	 */
	public String goUpdate(){
		
		String id = request.getParameter("id");
		Ordertype ordertype = (Ordertype) saleOrderBussiness.findObjectById(Ordertype.class, id);
		request.setAttribute("data", ordertype);
		
		return "goUpdate";
	}
	
	/**
	 * 添加类型
	 */
	public String add(){
		ordertype.setDelflag(0);
		Ordertype type  = (Ordertype) saleOrderBussiness.addObject(ordertype);
		if(null == type){
			request.setAttribute("errorMsg", "添加类型出错，请重试！");
			return "no";
		}
		return "success";
	}
	
	/**
	 * 修改类型
	 */
	public String update(){
		ordertype.setDelflag(0);
		Ordertype type  = (Ordertype) saleOrderBussiness.addObject(ordertype);
		if(null == type){
			request.setAttribute("errorMsg", "修改类型出错，请重试！");
			return "no";
		}
		return "success";
	}
	
	/**
	 * 删除类型（软）
	 * @throws IOException
	 */
	public void del() throws IOException{
		String id = request.getAttribute("id").toString();
		Ordertype type  = saleOrderBussiness.delete(id);
		if(null == type){
			request.setAttribute("errorMsg", "修改类型出错，请重试！");
			response.getWriter().print(0);
		}
		response.getWriter().print(1);
	}

	
	/**
	 * 查看详细
	 */
	public String goInfo(){
		String id = request.getAttribute("id").toString();
		Ordertype ordertype = (Ordertype) saleOrderBussiness.findObjectById(Ordertype.class, id);
		request.setAttribute("data", ordertype);
		return "goInfo";
	}
}
