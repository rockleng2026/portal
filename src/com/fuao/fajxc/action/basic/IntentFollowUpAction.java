package com.fuao.fajxc.action.basic;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.IntentFollowUpBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.IntentFollowUp;
import com.opensymphony.xwork2.ModelDriven;
public class IntentFollowUpAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private IntentFollowUpBussiness intentFollowUpBussiness;
		private CustomerBussiness customerBussiness;
		private HttpServletRequest request;
		private HttpServletResponse response;
		private IntentFollowUp intentFollowUp;
		private Customer customer;
		//动态记录
		private ExecuteRecordBussiness executeRecordBussiness;
		
		public ExecuteRecordBussiness getExecuteRecordBussiness() {
			return executeRecordBussiness;
		}

		public void setExecuteRecordBussiness(
				ExecuteRecordBussiness executeRecordBussiness) {
			this.executeRecordBussiness = executeRecordBussiness;
		}

		public CustomerBussiness getCustomerBussiness() {
			return customerBussiness;
		}

		public void setCustomerBussiness(CustomerBussiness customerBussiness) {
			this.customerBussiness = customerBussiness;
		}
		
		public IntentFollowUpBussiness getIntentFollowUpBussiness() {
			return intentFollowUpBussiness;
		}

		public void setIntentFollowUpBussiness(IntentFollowUpBussiness intentFollowUpBussiness) {
			this.intentFollowUpBussiness = intentFollowUpBussiness;
		}

		public Object getModel() {
			intentFollowUp =new IntentFollowUp();
			return intentFollowUp;
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
		 * 添加跟进客户信息对象
		 */
		public String add(){
			try {
				intentFollowUp.setDel("0");
				String id=request.getParameter("customerId");
				customer=customerBussiness.getCustomerdata(id);
				//拿到登陆员工用户
				Employee employee=(Employee)request.getSession().getAttribute("emp");
				intentFollowUp.setCustomer(customer);
				intentFollowUp.setEmployee(employee);
				intentFollowUp.setId(null);
				IntentFollowUp inFollowUp = intentFollowUpBussiness.addReturnData(intentFollowUp);
				/*阙超强 14015   添加记录动态信息*/
				//添加记录到动态记录表
				if(null != employee){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(employee);
					executerecord.setContent("添加一个客户跟进记录。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(inFollowUp.getId().toString());
					executerecord.setEntityName("IntentFollowUp");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				return	this.getpage();
			} catch (Exception e) {
				e.printStackTrace();
				return "will";
			}
		}
		
		/*
		 * 删除跟进客户信息对象
		 */
		public void del(){
			try {
				String id=request.getParameter("inid");
				IntentFollowUp data=intentFollowUpBussiness.getIntentFollowUpdata(id);
				data.setDel("1");
				intentFollowUpBussiness.updateData(data);
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个客户跟进记录。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("IntentFollowUp");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
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
		 * 更改跟进客户信息对象
		 */
		public String update(){
			try {
//				String IntentFollowUpId=request.getParameter("IntentFollowUpId");//跟进客户主键编号
				String id=request.getParameter("cid").trim();
				IntentFollowUp inup=intentFollowUpBussiness.getIntentFollowUpdata(id);
//				IntentFollowUp.setIntentFollowUpId(Integer.parseInt(IntentFollowUpId));
				inup.setDate(intentFollowUp.getDate());
				inup.setDetail(intentFollowUp.getDetail());
				intentFollowUpBussiness.updateData(inup);
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个客户跟进记录。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("IntentFollowUp");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				return this.getpage();
			} catch (Exception e) {
				return "sess"; 
			}
		}
		
		/*
		 * 根据条件进行筛选查询跟进客户信息
		 */
		public String getpage(){
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
//			String IntentFollowUpId=request.getParameter("IntentFollowUpId");//跟进客户主键编号
			String customerId=request.getParameter("customerId");
			String hql="from IntentFollowUp as tb where 1=1 and del!='1'";
			if(customerId!=null &&!"".equals(customerId)){
				hql+=( "and tb.customer.customerId ="+ customerId);
			}
			hql+="order by tb.id desc";
			System.out.println("hql is"+hql);
			Pages pages=intentFollowUpBussiness.exHqlPages(hql, Integer.parseInt(pageNo.trim()), 10, null);
			request.setAttribute("pages", pages);
			return "listIntentFollowUp";
		}
		
		/*
		 * 获取单个跟进客户信息对象
		 */
		public String get(){
			try {
				String id=request.getParameter("id").trim();
				IntentFollowUp data=intentFollowUpBussiness.getIntentFollowUpdata(id);
				request.setAttribute("data", data);
				return "intentFollowUp";
			} catch (Exception e) {
				return "will";
			}
		}
		
}
