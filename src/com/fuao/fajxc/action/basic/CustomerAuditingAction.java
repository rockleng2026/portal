package com.fuao.fajxc.action.basic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.fuao.fajxc.bussiness.basic.CustomerAuditingBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CustomerAuditing;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
public class CustomerAuditingAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private CustomerAuditingBussiness customerAuditingBussiness;
		private HttpServletRequest request;
		private HttpServletResponse response;
		private CustomerAuditing customerAuditing;
		public CustomerAuditingBussiness getCustomerAuditingBussiness() {
			return customerAuditingBussiness;
		}

		public void setCustomerAuditingBussiness(CustomerAuditingBussiness customerAuditingBussiness) {
			this.customerAuditingBussiness = customerAuditingBussiness;
		}

		public Object getModel() {
			customerAuditing =new CustomerAuditing();
			return customerAuditing;
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
		
		/*
		 * 添加客户审核记录信息对象
		 */
		public String add(){
			try {
				boolean thing= customerAuditingBussiness.addData(customerAuditing);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return	this.getpage();
		}
		
		/*
		 * 删除客户审核记录信息对象
		 */
		public void del(){
			try {
				String id=request.getParameter("id");
				CustomerAuditing data=customerAuditingBussiness.getCustomerAuditingdata(id);
				customerAuditingBussiness.updateData(data);
				response.getWriter().print(1);
			} catch (Exception e) {
				try {
					response.getWriter().print(0);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		}
		
		/*
		 * 更改客户审核记录信息对象
		 */
		public String update(){
			try {
				String CustomerAuditingId=request.getParameter("CustomerAuditingId");//客户审核记录主键编号
				customerAuditingBussiness.updateData(customerAuditing);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return this.getpage();	
		}
		
		/*
		 * 根据条件进行筛选查询客户审核记录信息
		 */
		public String getpage(){
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String customerId=request.getParameter("customerId");//客户审核记录信息主键编号
			String hql="from CustomerAuditing as tb where 1=1 and del!='1'";
			if(customerId!=null &&!"".equals(customerId)){
				hql+=( " and tb.customer.customerId ="+ customerId);
			}
			hql+="order by tb.id desc";
			System.out.println("hql is"+hql);
			Pages pages=customerAuditingBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 25, null);
			request.setAttribute("pages", pages);
			return "listCustomerAuditing";
		}
		
		/*
		 * 获取单个客户审核记录信息对象
		 */
		public String get(){
			try {
				String id=request.getParameter("id");
				CustomerAuditing data=customerAuditingBussiness.getCustomerAuditingdata(id);
				request.setAttribute("data", data);
			} catch (Exception e) {
				return "will";
			}
			return "addCustomerAuditing";
		}
		
}
