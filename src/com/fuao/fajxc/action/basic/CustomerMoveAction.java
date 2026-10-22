package com.fuao.fajxc.action.basic;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.CustomerMoveBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Employee;
import com.opensymphony.xwork2.ModelDriven;

public class CustomerMoveAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	private CustomerMoveBussiness customerMoveBussiness;
	private EmployeeBussiness employeeBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CustomerMove customerMove;
	private CustomerBussiness customerBussiness;// 客户信息表

	public CustomerMoveBussiness getCustomerMoveBussiness() {
		return customerMoveBussiness;
	}

	public void setCustomerMoveBussiness(
			CustomerMoveBussiness customerMoveBussiness) {
		this.customerMoveBussiness = customerMoveBussiness;
	}

	public CustomerBussiness getCustomerBussiness() {
		return customerBussiness;
	}

	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}

	public EmployeeBussiness getEmployeeBussiness() {
		return employeeBussiness;
	}

	public void setEmployeeBussiness(EmployeeBussiness employeeBussiness) {
		this.employeeBussiness = employeeBussiness;
	}

	public Object getModel() {
		customerMove = new CustomerMove();
		return customerMove;
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
	 * 添加客户交接信息信息对象
	 */
	public String add() {
		try {
			// 从数据库获取以前未更改过的客户对象
			Customer data = customerBussiness.getCustomerdata(customerMove
					.getCustomer().getCustomerId().toString());
			Employee oldemployee = data.getEmployee();
			customerMove.setEmployeeByOldPrincipal(oldemployee);
			data.setEmployee(customerMove.getEmployeeByNewPrincipal());
			customerBussiness.updateData(data);
			customerMove.setDelflag("0");
			boolean thing = customerMoveBussiness.addData(customerMove);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.getpage();
	}

	/*
	 * 删除客户交接信息信息对象
	 */
	public void del() {
		try {
			String id = request.getParameter("id");
			CustomerMove data = customerMoveBussiness.getCustomerMovedata(id);
			data.setDelflag("1");
			customerMoveBussiness.updateData(data);
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
	 * 更改客户交接信息信息对象
	 */
	public String update() {
		try {
			String CustomerMoveId = request.getParameter("CustomerMoveId");// 客户交接信息主键编号
			customerMoveBussiness.updateData(customerMove);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.getpage();
	}

	/*
	 * 根据条件进行筛选查询客户交接信息信息
	 */
	public String getpage() {
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String CustomerMoveId = request.getParameter("CustomerMoveId");// 客户交接信息主键编号
		String customerId = request.getParameter("customerId");// 客户交接信息主键编号
		String timeb = request.getParameter("timeb");// 客户交接信息就建立开始时间
		String timee = request.getParameter("timee");// 客户交接信息就建立开始时间
		String hql = "from CustomerMove as tb where 1=1 and delflag !='1'";
		if (CustomerMoveId != null && !"".equals(CustomerMoveId)) {
			hql += (" and tb.CustomerMoveId =" + CustomerMoveId);
		}
		if (customerId != null && !"".equals(customerId)) {
			hql += (" and tb.customer.customerId =" + customerId);
		}
		hql += " order by tb.id desc";
		System.out.println("hql is" + hql);
		Pages pages = customerMoveBussiness.exHqlPages(hql, Integer
				.parseInt(pageNo), 25, null);
		request.setAttribute("pages", pages);
		return "listCustomerMove";
	}

	/*
	 * 获取单个客户交接信息信息对象
	 */
	public String get() {
		try {
			String id = request.getParameter("id");
			CustomerMove data = customerMoveBussiness.getCustomerMovedata(id);
			request.setAttribute("data", data);
			request.setAttribute("isShow", "1");
		} catch (Exception e) {
		}
		return "showMove";
	}
	
	
	
	

}



