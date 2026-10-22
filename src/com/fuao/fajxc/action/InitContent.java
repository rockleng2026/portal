package com.fuao.fajxc.action;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.jdom.Element;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.bussiness.common.CommonBizImpl;
import com.fuao.fajxc.dao.cms_classesdao.ClassesDao;
import com.fuao.fajxc.dao.cms_classesdao.ClassesDaoImpl;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.impl.FunctionInfoDaoImpl;
import com.fuao.fajxc.site.EnumStaticPath;
import com.fuao.fajxc.util.ObjXmlBuildParse;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Fa_Cms_Classes;


public class InitContent extends HttpServlet{
	private static Logger logger = Logger.getLogger(InitContent.class);
	private ClassesDao classdao;
	public ClassesDao getClassdao() {
		return classdao;
	}

	public void setClassdao(ClassesDao classdao) {
		this.classdao = classdao;
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		super.doPost(req, resp);
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		super.doGet(req, resp);
	}
	
	public void init(ServletConfig config) throws ServletException {
		
		logger.info("init....");
		
		
//		RecPartDao pdao = new RecPartDaoImpl();
//		ContentsDAO dao  = new ContentsDAOimpl();
//		TypeDAO tdao = new TypeDAOimpl();
		String xmlpath = config.getInitParameter("xmlpath");
		InitConfig.doInit(config.getServletContext());
		
	}
	
	public void destroy() {
		super.destroy();
	}
}