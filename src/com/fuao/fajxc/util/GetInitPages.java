package com.fuao.fajxc.util;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.opensymphony.xwork2.ActionContext;

public class GetInitPages implements ServletContextListener{

	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		
	}

	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		String mtt= sc.getInitParameter("pagesize");
		sc.setAttribute("psize", mtt);
		System.out.println("values="+mtt);
		
	}

}
