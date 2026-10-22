package com.fuao.fajxc.action.cdn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.mission.MissionBussiness;
import com.fuao.fajxc.bussiness.mission.MissionreceiverBussiness;
import com.fuao.fajxc.bussiness.mission.MissiontypeBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Messageremind;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.MissionEmp;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.Questioncategory;
import com.opensymphony.xwork2.ModelDriven;
public class CDNAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
    private static Logger  logger = Logger.getLogger(CDNAction.class);
		private HttpServletRequest request;
		private HttpServletResponse response;
		private CommonBiz formbiz;
		
		public Object getModel() {
			return null;
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
		
		
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss ");
		
		//获得当前时间
		Date now = new Date();
	    String str3 = dateFormat.format(now);
		
		/*
		 * 添加任务
		 */
		public String add(){
			return null;
		}
		
		public CommonBiz getFormbiz() {
			return formbiz;
		}
		public void setFormbiz(CommonBiz formbiz) {
			this.formbiz = formbiz;
		}
		
		
		
}
