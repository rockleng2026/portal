package com.fuao.fajxc.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class SetCharacterEncodingFilter implements Filter {

	private String encoding;
	
	private FilterConfig filterConfig = null;
	
	public void destroy() 
	{
		// TODO Auto-generated method stub
		this.encoding = null;
		this.filterConfig = null;

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		arg0.setCharacterEncoding(this.encoding);
		arg2.doFilter(arg0, arg1);

	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
       this.encoding = arg0.getInitParameter("encoding");
	}

}
