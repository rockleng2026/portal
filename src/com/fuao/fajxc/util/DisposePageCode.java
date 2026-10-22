package com.fuao.fajxc.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DisposePageCode extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String page_code = request.getParameter("code");// 获取前台的输入的验证�?
		String code = request.getSession().getAttribute("pageValidateCode")
				.toString();// 存在session里的验证�?
		// 判断前后是否�?��
		if (code.equalsIgnoreCase(page_code)) {
			response.getWriter().write("true");
		} else {
			response.getWriter().write("false");
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
