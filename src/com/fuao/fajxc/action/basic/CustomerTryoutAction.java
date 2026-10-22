package com.fuao.fajxc.action.basic;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.CustomerTryoutBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerTryout;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CustomerTryoutAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	private CustomerTryoutBussiness customerTryoutBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CustomerTryout customerTryout;
	private CustomerBussiness customerBussiness;
	//动态记录
	private ExecuteRecordBussiness executeRecordBussiness;

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public CustomerTryoutBussiness getCustomerTryoutBussiness() {
		return customerTryoutBussiness;
	}

	public void setCustomerTryoutBussiness(
			CustomerTryoutBussiness customerTryoutBussiness) {
		this.customerTryoutBussiness = customerTryoutBussiness;
	}

	public Object getModel() {
		customerTryout = new CustomerTryout();
		return customerTryout;
	}

	public CustomerBussiness getCustomerBussiness() {
		return customerBussiness;
	}

	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}
	/**
	 * 得到request
	 */
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;

	}

	/**
	 * 得到response
	 */
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}

	/*
	 * 添加客户信息对象
	 */
	public String add() {
		try {
			String cid=request.getParameter("cid").trim();
			customerTryout.setCustomer(customerBussiness.getCustomerdata(cid));
			customerTryout.setDelflag("0");
			customerTryout.setServercollocate(customerTryout.getServercollocate().trim());
			customerTryout.setRemark(customerTryout.getRemark().trim());
			customerTryout.setId(null);
			CustomerTryout result = customerTryoutBussiness.addReturnData(customerTryout);
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个客户试用记录。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(result.getId().toString());
				executerecord.setEntityName("CustomerTryout");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.getpage();
	}

	/*
	 * 删除客户信息对象
	 */
	public void del() {
		try {
			String id = request.getParameter("id");
			CustomerTryout data = customerTryoutBussiness
					.getCustomerTryoutdata(id);
			data.setDelflag("1");
			customerTryoutBussiness.updateData(data);
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一个客户试用记录。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(id);
				executerecord.setEntityName("CustomerTryout");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			response.getWriter().print(1);
		} catch (Exception e) {
			try {
				response.getWriter().print(0);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}

	/*
	 * 更改客户信息对象
	 */
	public String update() {
		try {
			String CustomerTryoutId = request.getParameter("CustomerTryoutId");// 客户主键编号
			String id = request.getParameter("ctid").trim();
			CustomerTryout custry=customerTryoutBussiness.getCustomerTryoutdata(id);
			custry.setIp(customerTryout.getIp());
			custry.setServercollocate(customerTryout.getServercollocate());
			custry.setBandwidth(customerTryout.getBandwidth());
			custry.setTryoutBeginDate(customerTryout.getTryoutBeginDate());
			custry.setTryoutEndDate(customerTryout.getTryoutEndDate());
			custry.setIsPurchase(customerTryout.getIsPurchase());
			custry.setRemark(customerTryout.getRemark());
			customerTryoutBussiness.updateData(custry);
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个客户试用记录。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(id);
				executerecord.setEntityName("CustomerTryout");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.getpage();
	}

	/*
	 * 根据条件进行筛选查询客户信息
	 */
	public String getpage() {
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String CustomerTryoutId = request.getParameter("CustomerTryoutId");// 客户主键编号
		String type = request.getParameter("type");// 客户类型，租用托管，百共等等
		String hql = "from CustomerTryout as tb where 1=1 and delflag!='1'  order by tb.id desc";
		Pages pages = customerTryoutBussiness.exHqlPages(hql, Integer
				.parseInt(pageNo), 25, null);
		request.setAttribute("pages", pages);
		return "listCustomerTryout";
	}

	/*
	 * 获取单个客户信息对象
	 */
	public String get() {
		try {
			String id = request.getParameter("id");
			CustomerTryout data = customerTryoutBussiness.getCustomerTryoutdata(id);
			request.setAttribute("data", data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "addCustomerTryout";
	}

}
