package com.fuao.fajxc.action.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.CommonScfjb;
import com.opensymphony.xwork2.ModelDriven;

/**
 * \
 * @author lengzhiyong   mail to lengzhiyong@hotmail.com Nov 24, 2011
 * 附件通用action
 */
public class FJCommonAction  implements ModelDriven, ServletRequestAware,ServletResponseAware{

	private static Logger logger = Logger.getLogger(FJCommonAction.class); 
	private HttpServletRequest request;
	private HttpServletResponse response;
	//业务通用操作biz
	private CommonBiz formbiz;
	
	public CommonBiz getFormbiz() {
		return formbiz;
	}
	public void setFormbiz(CommonBiz formbiz) {
		this.formbiz = formbiz;
	}
	/**
	 *  转存sbh并跳转到添加附件页面
	 * @return
	 */
	public String goaddandeditfj(){
		String fbsbh = request.getParameter("sbh");
		if(StringUtil.isnull(fbsbh)){
			logger.error("goaddfj sbh为空");
			return "error";
		}
		List scfj = formbiz.getForm("CommonScfjb", " and fbsbh = '"+fbsbh+"'");
		request.setAttribute("fjlb", scfj);
		request.setAttribute("sbh", fbsbh);
		return "addfj";
	}
	/**
	 *  通过调用通用上传接口上传附件成功后-关联上传文件与附件表
	 * @return 成功跳转到我分配的任务列表页面
	 */
	public String addfj(){
		String fbsbh = request.getParameter("sbh");
		if(StringUtil.isnull(fbsbh)){
			logger.error("goaddfj sbh为空");
			return "addfjscuccess";
		}
		//获得附加附件
		formbiz.addFJ(fbsbh, "MissionEmp", request);
		return "addfjsuccess";
	}
	
	/**
	 * 核实是否有附件
	 */
	public String  ckfj(){
		String sbh = request.getParameter("sbh");//如果参数为多个sbh用,分割
		System.out.println("ckfj"+sbh);
		List list  = new ArrayList();
		List alllist  = new ArrayList();
		if(StringUtil.isnull(sbh)){
			logger.error("shb为空");
			return "error";
		}
		//分割字符串
		String[] str = StringUtil.splitStr(sbh);
	    if(str.length>0){
	    	for (int i = 0; i < str.length; i++) {
	    		list = formbiz.getForm("CommonScfjb", "and fbsbh='"+str[i]+"'");
	    		for (Iterator it = list.iterator(); it.hasNext();) {
					Object obj = (Object) it.next();
					alllist.add(obj);
				}
			}
	    }
	    
		String result = "-1";
		if(alllist.size()>0){
			result = "0";
		}
		 PrintWriter pw;
		try {
			pw = response.getWriter();
			pw.print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		 
		return null;
	}
	/**
	 * 得到表单附件列表
	 */
	public String  fjlist(){
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String sbh = request.getParameter("sbh");
		String isok = request.getParameter("isok");//是否可管理
		String sbhsession = (String)request.getSession().getAttribute("sbh");//如果参数为多个sbh用,分割
		String sisok = (String)request.getSession().getAttribute("isok");
		
		String hql = " from CommonScfjb where 1=1 ";
		System.out.println("fbsbh:"+sbh);
		if(StringUtil.isnull(isok) && StringUtil.isnull(sisok)){
			 isok = "0";
		}else if(StringUtil.isnull(isok)){
		     isok = sisok;
		}else{
			
		}
		if(StringUtil.isnull(sbh) && StringUtil.isnull(sbhsession)){
			
		}else if(StringUtil.isnull(sbh)){
			sbh = sbhsession;
			StringBuffer  sb= new StringBuffer();
			//分割字符串
			String[] str = StringUtil.splitStr(sbh);
			for (int i = 0; i < str.length; i++) {
				sb.append("'"+str[i]+"',");
			}
			
			hql += " and fbsbh in("+sb.subSequence(0, sb.length()-1)+") ";
		}else{
			StringBuffer  sb= new StringBuffer();
			//分割字符串
			String[] str = StringUtil.splitStr(sbh);
			for (int i = 0; i < str.length; i++) {
				sb.append("'"+str[i]+"',");
			}
			sb.subSequence(0, sb.length()-1);
			hql += " and fbsbh in("+sb.subSequence(0, sb.length()-1)+") ";
		}
		System.out.println(hql);
		Pages pages = formbiz.exHqlPages(hql, Integer.parseInt(pageNo), 25, null);
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("sbh", sbh);
		request.getSession().setAttribute("isok", isok);
		return "fjlist";
	}
	
	public Object getModel() {
		return null;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		request = arg0;
		
	}
	public void setServletResponse(HttpServletResponse arg0) {
		response = arg0;
		
	}

}
