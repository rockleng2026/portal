package com.fuao.fajxc.action.cdn;


import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.cdn.CDNsaleOrderBussiness;
import com.fuao.fajxc.bussiness.cdn.CacheBussiness;
import com.fuao.fajxc.bussiness.cdn.DistrictBussiness;
import com.fuao.fajxc.bussiness.cdn.RealmTypeBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.basic.EmployeeDao;
import com.fuao.fajxc.util.Area;
import com.fuao.fajxc.util.ConvertFileSize;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.DNSPod;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.FileUtil;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.TimePattern1;

import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.CDNip;
import com.fuao.fajxc.vo.CDNsaleOrder;
import com.fuao.fajxc.vo.Cache;
import com.fuao.fajxc.vo.CdnAreaDis;
import com.fuao.fajxc.vo.CdnFlowDis;
import com.fuao.fajxc.vo.CdnIspDis;
import com.fuao.fajxc.vo.CdnLogs;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.District;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.RealmType;
import com.fuao.fajxc.vo.SetMeal;
import com.fuao.fajxc.vo.SetMealCenter;
import com.fuao.fajxc.vo.SetMealProperty;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.cdnArea;
import com.fuao.fajxc.vo.cdnDnsPod;
import com.fuao.fajxc.vo.cdnGroup;
import com.fuao.fajxc.vo.cdnLogServer;
import com.fuao.fajxc.vo.cdnPanelPoint;
import com.fuao.fajxc.vo.cdnRealmNameIP;
import com.fuao.fajxc.vo.cdnType;
import com.google.gson.JsonArray;
import com.ibm.icu.util.GregorianCalendar;
import com.platcenter.ipparse.IPSeeker;

public class CDNsaleOrderAction  implements ServletRequestAware,ServletResponseAware{	
    private static final String[] cusIpId = null;
	private static Logger  logger = Logger.getLogger(CDNsaleOrderAction.class);
		private HttpServletRequest request;
		private HttpServletResponse response;
		private CDNsaleOrder cdnsaleorder;
		private CDNsaleOrderBussiness cdnsaleorderbussiness;
		private CacheBussiness cachebussiness;   //缓存
		private DistrictBussiness districtbussiness;//IP回源，区域表
		private RealmTypeBussiness realmtypebussiness;  ////显示类型，如静态，动态，等(RealmType)
		private AuditingBussiness audBussiness;
		private EmployeeDao empDao;
		private DNSPod dnsp=new DNSPod();
		
		public EmployeeDao getEmpDao() {
			return empDao;
		}
		public void setEmpDao(EmployeeDao empDao) {
			this.empDao = empDao;
		}

		Cookies ck = new Cookies();
		
		public AuditingBussiness getAudBussiness() {
			return audBussiness;
		}
		public void setAudBussiness(AuditingBussiness audBussiness) {
			this.audBussiness = audBussiness;
		}
		public CDNsaleOrder getCdnsaleorder() {
			return cdnsaleorder;
		}
		public void setCdnsaleorder(CDNsaleOrder cdnsaleorder) {
			this.cdnsaleorder = cdnsaleorder;
		}
		public static Logger getLogger() {
			return logger;
		}
		public static void setLogger(Logger logger) {
			CDNsaleOrderAction.logger = logger;
		}
		public HttpServletRequest getRequest() {
			return request;
		}
		public void setRequest(HttpServletRequest request) {
			this.request = request;
		}
		public HttpServletResponse getResponse() {
			return response;
		}
		public void setResponse(HttpServletResponse response) {
			this.response = response;
		}
		public void setServletRequest(HttpServletRequest arg0) {
			this.request=arg0;
		}
		public void setServletResponse(HttpServletResponse arg0) {
			this.response=arg0;
		}
		public CDNsaleOrderBussiness getCdnsaleorderbussiness() {
			return cdnsaleorderbussiness;
		}
		public void setCdnsaleorderbussiness(CDNsaleOrderBussiness cdnsaleorderbussiness) {
			this.cdnsaleorderbussiness = cdnsaleorderbussiness;
		}
		public CacheBussiness getCachebussiness() {
			return cachebussiness;
		}
		public void setCachebussiness(CacheBussiness cachebussiness) {
			this.cachebussiness = cachebussiness;
		}
		public DistrictBussiness getDistrictbussiness() {
			return districtbussiness;
		}
		public void setDistrictbussiness(DistrictBussiness districtbussiness) {
			this.districtbussiness = districtbussiness;
		}
		
		public RealmTypeBussiness getRealmtypebussiness() {
			return realmtypebussiness;
		}
		public void setRealmtypebussiness(RealmTypeBussiness realmtypebussiness) {
			this.realmtypebussiness = realmtypebussiness;
		}
		public Object getModel() {
			CDNsaleOrder cdnsaleorder=new CDNsaleOrder();
			return cdnsaleorder;
		}
		/**
		 * 测试用
		 * @param args
		 * @throws Exception
		 */
		
		public void ceshi() throws Exception {
			
//			String hql="from cdnRealmNameIP where del=0";
//			List<cdnRealmNameIP> crni= realmtypebussiness.findObjectListByHQL(hql);
//			System.out.println(crni.size());
//			for(int i=0;i<crni.size();i++)
//			{
//				System.out.println(crni.get(i).getCustomerID().getCustomerName());
//				System.out.println(crni.get(i).getCuRealmName());
//				System.out.println(crni.get(i).getCdnPanelPointID().getPanelPointIp());
//				System.out.println(crni.get(i).getCdnPanelPointID().getCdnAreaID().getProvince());
//				System.out.println(crni.get(i).getCdnPanelPointID().getCdnTypeID().getTypeName());
//			}

//			DNSPod d=new DNSPod();
//			String aa=d.selectDengJiDNSPod("aa", "aaa");
//			System.out.println(aa);

			//DNSPod d=new DNSPod();
			//String aa=d.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");

//String xml=	dnsp.selectSubDomainDNSPod("248907", "client.leccnet.com");//获取ID
//
//			
//			Pattern pattern = Pattern.compile("<id>(.*?)</id>");//获取企业代理域名的ID
//			Matcher matcher = pattern.matcher(xml);
//			System.out.println(matcher.groupCount());
//			matcher.find();
//			System.out.println(matcher.groupCount());
//			while (matcher.find()) {
//				System.out.println(matcher.groupCount());
//				System.out.println(matcher.group(1));
//				
//			}
			
			String aa="aaa";
			String bb="bbb";
			System.out.println(aa+bb);
			
		}
		/**
		 * 查询客户有哪些域名
		 */
		public String selectRealmName()
		{
			String cusID=request.getParameter("cusID");
			
			String hql="from CDNsaleOrder where customer.customerId="+Integer.parseInt(cusID)+" and delFlag=0 order by id desc";
			List<CDNsaleOrder> cdnso=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("cdnso", cdnso);
			String mark="";
			if(cdnso.size()>0){
			for(int i=0;i<cdnso.size();i++)
			{
				mark+="'"+cdnso.get(i).getCuRealmName().replace(".", "_")+"',";
			}
			if(mark.length()>0)
			{
				mark=mark.substring(0, mark.length()-1);
			}
			String hql1="from cdnLogServer  where domain in("+mark+")  order by bandwidth desc";
			List<cdnLogServer> cdnLogServer=realmtypebussiness.findObjectListByHQL(hql1);
			List<cdnLogServer> cdnls=realmtypebussiness.findObjectListByHQL(hql1);
			 for ( int i = 0 ; i < cdnLogServer.size() - 1 ; i ++ ) {//去掉重复的数据
			     for ( int j = cdnLogServer.size() - 1 ; j > i; j -- ) {
			       if (cdnLogServer.get(j).getDomain().equals(cdnLogServer.get(i).getDomain())) {
			    	   cdnLogServer.remove(j);
			       } 
			      } 
			    }
			 if(cdnLogServer.size()>10)//取前10位
			 {
				 for(int i=10;i<cdnLogServer.size();i++)
				 {
					 cdnLogServer.remove(i);
				 }
			 }
			 for(int i=0;i<cdnLogServer.size();i++)//便利数据
			 {
				 cdnLogServer.get(i).setDomain(cdnLogServer.get(i).getDomain().replace("_", "."));
				 GregorianCalendar   calendar   =   new   GregorianCalendar();
				 calendar.setTimeInMillis(Long.parseLong(cdnLogServer.get(i).getRqtime()));
				 
				 if(calendar.get(Calendar.HOUR_OF_DAY)<10)
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
					 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
					 else
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 else
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
						 else
							 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 for(int j=0;j<cdnls.size();j++)
				 {
					 if(cdnLogServer.get(i).getDomain().equals(cdnls.get(j).getDomain()))
					 {
						 
						 cdnLogServer.get(i).setTemp(cdnLogServer.get(i).getTemp()+cdnls.get(j).getBandwidth());
					 }
				 }
			 }
			 request.setAttribute("cdnLogServer", cdnLogServer);
			}
			return "llt";
		}

		/**
		 * 获取所有加速域名并跳转到CDN流量监控页面
		 */
		public String CDNFlowControl()
		{
//			String cusID=request.getParameter("cusID");
			
//			String hql="from CDNsaleOrder where delFlag=0 and auditingState = 1 and writeflag = 1 order by id desc";
			String hql="from CDNsaleOrder where delFlag=0  order by id desc";
			List<CDNsaleOrder> cdnso=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("cdnso", cdnso);
			
			String hql1="from cdnLogServer  where 1=1 order by bandwidth desc";
			List<cdnLogServer> cdnLogServer=realmtypebussiness.findObjectListByHQL(hql1);
			List<cdnLogServer> cdnls=realmtypebussiness.findObjectListByHQL(hql1);
			 for ( int i = 0 ; i < cdnLogServer.size() - 1 ; i ++ ) {//去掉重复的数据
			     for ( int j = cdnLogServer.size() - 1 ; j > i; j -- ) {
			       if (cdnLogServer.get(j).getDomain().equals(cdnLogServer.get(i).getDomain())) {
			    	   cdnLogServer.remove(j);
			       } 
			      } 
			    }
			 if(cdnLogServer.size()>10)//取前10位
			 {
				 for(int i=10;i<cdnLogServer.size();i++)
				 {
					 cdnLogServer.remove(i);
				 }
			 }
			 for(int i=0;i<cdnLogServer.size();i++)//便利数据
			 {
				 cdnLogServer.get(i).setDomain(cdnLogServer.get(i).getDomain().replace("_", "."));
				 GregorianCalendar   calendar   =   new   GregorianCalendar();
				 calendar.setTimeInMillis(Long.parseLong(cdnLogServer.get(i).getRqtime()));
				 
				 if(calendar.get(Calendar.HOUR_OF_DAY)<10)
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
					 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
					 else
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 else
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
						 else
							 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 for(int j=0;j<cdnls.size();j++)
				 {
					 if(cdnLogServer.get(i).getDomain().equals(cdnls.get(j).getDomain()))
					 {
						 
						 cdnLogServer.get(i).setTemp(cdnLogServer.get(i).getTemp()+cdnls.get(j).getBandwidth());
					 }
				 }
			 }
			 request.setAttribute("cdnLogServer", cdnLogServer);
			return "cdnmonitor";
		}

		/**
		 * 获取所有加速域名并跳转到CDN请求统计页面
		 */
		public String CDNFlowControl2()
		{
//			String cusID=request.getParameter("cusID");
			
//			String hql="from CDNsaleOrder where delFlag=0 and auditingState = 1 and writeflag = 1 order by id desc";
			String hql="from CDNsaleOrder where delFlag=0  order by id desc";
			List<CDNsaleOrder> cdnso=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("cdnso", cdnso);
			
			String hql1="from cdnLogServer  where 1=1 order by bandwidth desc";
			List<cdnLogServer> cdnLogServer=realmtypebussiness.findObjectListByHQL(hql1);
			List<cdnLogServer> cdnls=realmtypebussiness.findObjectListByHQL(hql1);
			 for ( int i = 0 ; i < cdnLogServer.size() - 1 ; i ++ ) {//去掉重复的数据
			     for ( int j = cdnLogServer.size() - 1 ; j > i; j -- ) {
			       if (cdnLogServer.get(j).getDomain().equals(cdnLogServer.get(i).getDomain())) {
			    	   cdnLogServer.remove(j);
			       } 
			      } 
			    }
			 if(cdnLogServer.size()>10)//取前10位
			 {
				 for(int i=10;i<cdnLogServer.size();i++)
				 {
					 cdnLogServer.remove(i);
				 }
			 }
			 for(int i=0;i<cdnLogServer.size();i++)//便利数据
			 {
				 cdnLogServer.get(i).setDomain(cdnLogServer.get(i).getDomain().replace("_", "."));
				 GregorianCalendar   calendar   =   new   GregorianCalendar();
				 calendar.setTimeInMillis(Long.parseLong(cdnLogServer.get(i).getRqtime()));
				 
				 if(calendar.get(Calendar.HOUR_OF_DAY)<10)
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
					 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
					 else
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 else
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
						 else
							 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 for(int j=0;j<cdnls.size();j++)
				 {
					 if(cdnLogServer.get(i).getDomain().equals(cdnls.get(j).getDomain()))
					 {
						 
						 cdnLogServer.get(i).setTemp(cdnLogServer.get(i).getTemp()+cdnls.get(j).getBandwidth());
					 }
				 }
			 }
			 request.setAttribute("cdnLogServer", cdnLogServer);
			return "cdnmonitor2";
		}
		
		/**
		 * 前端 获取所有加速域名并跳转到CDN请求统计页面
		 */
		public String CDNFlowControl2a()
		{
			String cusID=request.getParameter("cusID");
			
//			String hql="from CDNsaleOrder where delFlag=0 and auditingState = 1 and writeflag = 1 order by id desc";
			String hql="from CDNsaleOrder where delFlag=0 and customer.customerId="+Integer.parseInt(cusID)+" order by id desc";
			List<CDNsaleOrder> cdnso=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("cdnso", cdnso);
			if(cdnso.size()>0){
			String hql1="from cdnLogServer  where 1=1 order by bandwidth desc";
			List<cdnLogServer> cdnLogServer=realmtypebussiness.findObjectListByHQL(hql1);
			List<cdnLogServer> cdnls=realmtypebussiness.findObjectListByHQL(hql1);
			 for ( int i = 0 ; i < cdnLogServer.size() - 1 ; i ++ ) {//去掉重复的数据
			     for ( int j = cdnLogServer.size() - 1 ; j > i; j -- ) {
			       if (cdnLogServer.get(j).getDomain().equals(cdnLogServer.get(i).getDomain())) {
			    	   cdnLogServer.remove(j);
			       } 
			      } 
			    }
			 if(cdnLogServer.size()>10)//取前10位
			 {
				 for(int i=10;i<cdnLogServer.size();i++)
				 {
					 cdnLogServer.remove(i);
				 }
			 }
			 for(int i=0;i<cdnLogServer.size();i++)//便利数据
			 {
				 cdnLogServer.get(i).setDomain(cdnLogServer.get(i).getDomain().replace("_", "."));
				 GregorianCalendar   calendar   =   new   GregorianCalendar();
				 calendar.setTimeInMillis(Long.parseLong(cdnLogServer.get(i).getRqtime()));
				 
				 if(calendar.get(Calendar.HOUR_OF_DAY)<10)
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
					 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
					 else
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 else
				 {
					 if(calendar.get(Calendar.MINUTE)<10)
						 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
						 else
							 cdnLogServer.get(i).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
				 }
				 for(int j=0;j<cdnls.size();j++)
				 {
					 if(cdnLogServer.get(i).getDomain().equals(cdnls.get(j).getDomain()))
					 {
						 
						 cdnLogServer.get(i).setTemp(cdnLogServer.get(i).getTemp()+cdnls.get(j).getBandwidth());
					 }
				 }
			 }
			 request.setAttribute("cdnLogServer", cdnLogServer);
			}
			return "cdnmonitor2a";
		}
		/**
		 * 跳转到流量统计页面
		 */
		public String CDNFlowControl1()
		{
//			String cusID=request.getParameter("cusID");
			
//			String hql="from CDNsaleOrder where delFlag=0 and auditingState = 1 and writeflag = 1 order by id desc";
			String hql="from CDNsaleOrder where delFlag=0  order by id desc";
			List<CDNsaleOrder> cdnso=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("cdnso", cdnso);
			
			String hql1="from CdnAreaDis  where 1=1 ";
			List<CdnAreaDis> cdnAreaDis=realmtypebussiness.findObjectListByHQL(hql1);
			List<CdnAreaDis> cdnad=realmtypebussiness.findObjectListByHQL(hql1);
			 for ( int i = 0 ; i < cdnAreaDis.size() - 1 ; i ++ ) {//去掉重复的数据
			     for ( int j = cdnAreaDis.size() - 1 ; j > i; j -- ) {
			       if (cdnAreaDis.get(j).getArear().equals(cdnAreaDis.get(i).getArear())) {
			    	   cdnAreaDis.remove(j);
			       } 
			      } 
			    }
			 int a=0;
			 for(int i=0;i<cdnAreaDis.size();i++)
			 {
				 a=cdnAreaDis.get(i).getFlow();
				 for(int j=0;j<cdnad.size();j++)
				 {
					 if(cdnAreaDis.get(i).getArear().equals(cdnad.get(j).getArear()))
					 {
						 cdnAreaDis.get(i).setFlow(cdnAreaDis.get(i).getFlow()+cdnad.get(j).getFlow());
					 }
				 }
				 cdnAreaDis.get(i).setFlow(cdnAreaDis.get(i).getFlow()-a);//减去他第一次相加的
			 }
			 
			   for (int i = 0; i < cdnAreaDis.size() -1; i++){    //便利数据排序  大到小
				    for(int j = 0 ;j <  cdnAreaDis.size() - i - 1; j++){   
				         if(cdnAreaDis.get(j).getFlow() < cdnAreaDis.get(j+1).getFlow()){    //把小的值交换到后面
				             int temp = cdnAreaDis.get(j).getFlow() ;
				             cdnAreaDis.get(j).setFlow(cdnAreaDis.get(j+1).getFlow());
				             cdnAreaDis.get(j+1).setFlow(temp);
				                  }
				               }
			   }
			   if(cdnAreaDis.size()>10)//取前10条数据
			   {
				   for(int i=10;i<cdnAreaDis.size();i++)
				   {
					   cdnAreaDis.remove(i);
				   }
			   }
			   int mark=0;
			   for(int i=0;i<cdnAreaDis.size();i++)//获取所有流量 用来判断比例
			   {
				   mark=mark+cdnAreaDis.get(i).getFlow();
			   }
			   Area area=new Area();
			   String[] flowBilI=new String[cdnAreaDis.size()];
			   for(int i=0;i<cdnAreaDis.size();i++)
			   {
				   
				   //获取在前10所占有的比例
				   flowBilI[i] = String.valueOf((float)Math.round(Float.parseFloat(cdnAreaDis.get(i).getFlow()*100.0/mark+"") * Math.pow(10,2))/Math.pow(10,2));//小数点第2位后四舍五入
				   cdnAreaDis.get(i).setArear(area.selevtArea(Integer.parseInt(cdnAreaDis.get(i).getArear())));//获取地区
			   }
			   request.setAttribute("flowBilI", flowBilI);
			  request.setAttribute("cdnAreaDis", cdnAreaDis);
			 
			return "cdnmonitor1";
		}
		/**
		 * 前端流量统计
		 */
		public String CDNFlowControl1a()
		{
			String cusID=request.getParameter("cusID");
			
//			String hql="from CDNsaleOrder where delFlag=0 and auditingState = 1 and writeflag = 1 order by id desc";
			String hql="from CDNsaleOrder where delFlag=0 and customer.customerId="+Integer.parseInt(cusID)+" order by id desc";
			List<CDNsaleOrder> cdnso=realmtypebussiness.findObjectListByHQL(hql);
			
			request.setAttribute("cdnso", cdnso);
			if(cdnso.size()>0){
			String mark1="";
			for(int i=0;i<cdnso.size();i++)
			{
				mark1+="'"+cdnso.get(i).getCuRealmName().replace(".", "_")+"',";
			}
			if(mark1.length()>0)
			{
				mark1=mark1.substring(0, mark1.length()-1);
			}
			String hql1="from CdnAreaDis  where domain in ("+mark1+") ";
			List<CdnAreaDis> cdnAreaDis=realmtypebussiness.findObjectListByHQL(hql1);
			List<CdnAreaDis> cdnad=realmtypebussiness.findObjectListByHQL(hql1);
			 for ( int i = 0 ; i < cdnAreaDis.size() - 1 ; i ++ ) {//去掉重复的数据
			     for ( int j = cdnAreaDis.size() - 1 ; j > i; j -- ) {
			       if (cdnAreaDis.get(j).getArear().equals(cdnAreaDis.get(i).getArear())) {
			    	   cdnAreaDis.remove(j);
			       } 
			      } 
			    }
			 int a=0;
			 for(int i=0;i<cdnAreaDis.size();i++)
			 {
				 a=cdnAreaDis.get(i).getFlow();
				 for(int j=0;j<cdnad.size();j++)
				 {
					 if(cdnAreaDis.get(i).getArear().equals(cdnad.get(j).getArear()))
					 {
						 cdnAreaDis.get(i).setFlow(cdnAreaDis.get(i).getFlow()+cdnad.get(j).getFlow());
					 }
				 }
				 cdnAreaDis.get(i).setFlow(cdnAreaDis.get(i).getFlow()-a);//减去他第一次相加的
			 }
			 
			   for (int i = 0; i < cdnAreaDis.size() -1; i++){    //便利数据排序  大到小
				    for(int j = 0 ;j <  cdnAreaDis.size() - i - 1; j++){   
				         if(cdnAreaDis.get(j).getFlow() < cdnAreaDis.get(j+1).getFlow()){    //把小的值交换到后面
				             int temp = cdnAreaDis.get(j).getFlow() ;
				             cdnAreaDis.get(j).setFlow(cdnAreaDis.get(j+1).getFlow());
				             cdnAreaDis.get(j+1).setFlow(temp);
				                  }
				               }
			   }
			   if(cdnAreaDis.size()>10)//取前10条数据
			   {
				   for(int i=10;i<cdnAreaDis.size();i++)
				   {
					   cdnAreaDis.remove(i);
				   }
			   }
			   int mark=0;
			   for(int i=0;i<cdnAreaDis.size();i++)//获取所有流量 用来判断比例
			   {
				   mark=mark+cdnAreaDis.get(i).getFlow();
			   }
			   Area area=new Area();
			   String[] flowBilI=new String[cdnAreaDis.size()];
			   for(int i=0;i<cdnAreaDis.size();i++)
			   {
				   
				   //获取在前10所占有的比例
				   flowBilI[i] = String.valueOf((float)Math.round(Float.parseFloat(cdnAreaDis.get(i).getFlow()*100.0/mark+"") * Math.pow(10,2))/Math.pow(10,2));//小数点第2位后四舍五入
				   cdnAreaDis.get(i).setArear(area.selevtArea(Integer.parseInt(cdnAreaDis.get(i).getArear())));//获取地区
			   }
			   request.setAttribute("flowBilI", flowBilI);
			  request.setAttribute("cdnAreaDis", cdnAreaDis);
			  
			  String hqlls="from cdnLogServer where domain in("+mark1+")  order by flow desc";
			  List<cdnLogServer> cls=realmtypebussiness.findObjectListByHQL(hqlls);
			  if(cls.size()>0)
			  {
				  GregorianCalendar   calendar   =   new   GregorianCalendar();
					 calendar.setTimeInMillis(Long.parseLong(cls.get(0).getRqtime()));
					 cls.get(0).setDomain(cls.get(0).getDomain().replace("_", "."));
					 if(calendar.get(Calendar.HOUR_OF_DAY)<10)
					 {
						 if(calendar.get(Calendar.MINUTE)<10)
							 cls.get(0).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
						 else
							 cls.get(0).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  0"+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
					 }
					 else
					 {
						 if(calendar.get(Calendar.MINUTE)<10)
							 cls.get(0).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":0"+calendar.get(Calendar.MINUTE));
							 else
								 cls.get(0).setRqtime(DateFormat.getDateInstance().format(calendar.getTime())+"  "+calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE));
					 }
				  request.setAttribute("cls", cls.get(0));
			  }
			}
			return "cdnmonitor1a";
		}
		
		/**
		 * 查询流量和回源流量
		 */
		public void selectFlowType()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			if(realmName!=null&&realmName!="")
			{
			String hql="from CdnFlowDis where domain='"+realmName+"'";
			List<CdnFlowDis> cfd=realmtypebussiness.findObjectListByHQL(hql);
			int source=0;
			int cache=0;
			for(int i=0;i<cfd.size();i++)
			{
				source+=cfd.get(i).getSource();
				cache+=cfd.get(i).getCache();
			}
			String mark=source+","+cache;
			try {
				response.getWriter().print(mark);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
		}
		/**
		 * 查询流量和回源  请求次数
		 */
		public void selectFlowType1()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			if(realmName!=null&&realmName!="")
			{
			String hql="from cdnLogServer where domain='"+realmName+"'";
			List<cdnLogServer> cfd=realmtypebussiness.findObjectListByHQL(hql);
			int source=0;
			int cache=0;
			for(int i=0;i<cfd.size();i++)
			{
				source+=cfd.get(i).getHynum();
				cache+=cfd.get(i).getRqnum();
			}
			int num=source+cache;
			
			String mark=source+","+cache+"!"+String.valueOf((float)Math.round(Float.parseFloat(source*100.0/num+"") * Math.pow(10,2))/Math.pow(10,2))+"!"+String.valueOf((float)Math.round(Float.parseFloat(cache*100.0/num+"") * Math.pow(10,2))/Math.pow(10,2));//四舍五入得到小数点后2位
			try {
				response.getWriter().print(mark);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
		}
		/**
		 * 查询流量和回源  请求次数
		 */
		public void selectFlowType2()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			if(realmName!=null&&realmName!="")
			{
			String[] rn=realmName.split(",");
			String markrn="";
			for(int i=0;i<rn.length;i++)//in 查询需要格式是in （'sds','sdasd'）  域名是字符串不转换会报错
			{
				if(i+1!=rn.length)
				markrn+="'"+rn[i]+"',";
				else
					markrn+="'"+rn[i]+"'";	
			}
			
			String startTime=request.getParameter("startTime");//开始时间
			String endTime=request.getParameter("endTime");//结束时间
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			Date dd = TimePattern1.doStringTime(startTime);//开始时间转换为好秒
			calendar.setTime(dd);
			btime = calendar.getTimeInMillis();
			
			Calendar calendar1 = Calendar.getInstance();//结束时间转换为毫秒
			Date dd1 = TimePattern1.doStringTime(endTime);
			calendar1.setTime(dd1);
			calendar1.add(Calendar.DATE, +1);
			etime = calendar1.getTimeInMillis();
			
			String hql="from cdnLogServer where domain in("+markrn+")  and (rqtime>='"+(btime/1000)+"' and rqtime<'"+(etime/1000)+"')";//转换为秒所以除以1000
			List<cdnLogServer> cfd=realmtypebussiness.findObjectListByHQL(hql);
			int source=0;
			int cache=0;
			for(int i=0;i<cfd.size();i++)
			{
				source+=cfd.get(i).getHynum();
				cache+=cfd.get(i).getRqnum();
			}
			int num=source+cache;
			
			String mark=source+","+cache+"!"+String.valueOf((float)Math.round(Float.parseFloat(source*100.0/num+"") * Math.pow(10,2))/Math.pow(10,2))+"!"+String.valueOf((float)Math.round(Float.parseFloat(cache*100.0/num+"") * Math.pow(10,2))/Math.pow(10,2));//四舍五入得到小数点后2位
			try {
				response.getWriter().print(mark);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
		}
		/**
		 * 根据域名  时间查询
		 */
		public void selectFlowTypeTime()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			
			String[] rn=realmName.split(",");
			String markrn="";
			for(int i=0;i<rn.length;i++)//in 查询需要格式是in （'sds','sdasd'）  域名是字符串不转换会报错
			{
				if(i+1!=rn.length)
				markrn+="'"+rn[i]+"',";
				else
					markrn+="'"+rn[i]+"'";	
			}
			
			String startTime=request.getParameter("startTime");//开始时间
			String endTime=request.getParameter("endTime");//结束时间
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			Date dd = TimePattern1.doStringTime(startTime);//开始时间转换为好秒
			calendar.setTime(dd);
			btime = calendar.getTimeInMillis();
			
			Calendar calendar1 = Calendar.getInstance();//结束时间转换为毫秒
			Date dd1 = TimePattern1.doStringTime(endTime);
			calendar1.setTime(dd1);
			calendar1.add(Calendar.DATE, +1);
			etime = calendar1.getTimeInMillis();
			
			String hql="from CdnFlowDis where domain in("+markrn+")  and (rqTime>='"+(btime/1000)+"' and rqTime<'"+(etime/1000)+"')";//转换为秒（所以除以100）
			List<CdnFlowDis> cfd=realmtypebussiness.findObjectListByHQL(hql);
			int source=0;
			int cache=0;
			for(int i=0;i<cfd.size();i++)
			{
				source+=cfd.get(i).getSource();
				cache+=cfd.get(i).getCache();
			}
			String mark=source+","+cache;
			try {
				response.getWriter().print(mark);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/**
		 * 更具域名  时间查询流量按天显示
		 * @throws ParseException
		 */
		public void selectFlowTime()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			
			String[] rn=realmName.split(",");
			String markrn="";
			for(int i=0;i<rn.length;i++)//in 查询需要格式是in （'sds','sdasd'）  域名是字符串不转换会报错
			{
				if(i+1!=rn.length)
				markrn+="'"+rn[i]+"',";
				else
					markrn+="'"+rn[i]+"'";	
			}
			
			String startTime=request.getParameter("startTime");//开始时间
			String endTime=request.getParameter("endTime");//结束时间
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			Date dd = TimePattern1.doStringTime(startTime);//开始时间转换为好秒
			calendar.setTime(dd);
			btime = calendar.getTimeInMillis();
			
			Calendar calendar1 = Calendar.getInstance();//结束时间转换为毫秒
			Date dd1 = TimePattern1.doStringTime(endTime);
			calendar1.setTime(dd1);
			calendar1.add(Calendar.DATE, +1);
			etime = calendar1.getTimeInMillis();
			long numDate=(etime-btime)/1000/60/60/24;
			int num=Integer.parseInt(numDate+"");
			
			String hql="from cdnLogServer where domain in ("+markrn+") and (rqtime>='"+btime+"' and rqtime<'"+etime+"')";
			List<cdnLogServer> cls=realmtypebussiness.findObjectListByHQL(hql);
			long numM=1000*60*60*24;
			String sb="";
			long num1=0;
			for(int i=0;i<num;i++)
			{
				
				int num2=0;
				if(i==0)
				{
					num1=btime;
				}
				else
				{
					num1=num1+numM;
				}
				for(int j=0;j<cls.size();j++)
				{
					if(Long.parseLong(cls.get(j).getRqtime())>=num1&&Long.parseLong(cls.get(j).getRqtime())<(num1+numM))
					{
						num2=num2+cls.get(j).getFlow();
					}
				}
				sb+=num1+":"+num2/86400+",";
			}
			
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				try {
					response.getWriter().print(sb.substring(0, sb.length()-1));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		}
		/**
		 * 查询ISP每个类型的请求次数
		 */
		public void selectISPTypeTime()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			
			String[] rn=realmName.split(",");
			String markrn="";
			for(int i=0;i<rn.length;i++)//in 查询需要格式是in （'sds','sdasd'）  域名是字符串不转换会报错
			{
				if(i+1!=rn.length)
				markrn+="'"+rn[i]+"',";
				else
					markrn+="'"+rn[i]+"'";	
			}
			
			String startTime=request.getParameter("startTime");//开始时间
			String endTime=request.getParameter("endTime");//结束时间
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			Date dd = TimePattern1.doStringTime(startTime);//开始时间转换为好秒
			calendar.setTime(dd);
			btime = calendar.getTimeInMillis();
			
			Calendar calendar1 = Calendar.getInstance();//结束时间转换为毫秒
			Date dd1 = TimePattern1.doStringTime(endTime);
			calendar1.setTime(dd1);
			calendar1.add(Calendar.DATE, +1);
			etime = calendar1.getTimeInMillis();
			
			String hql="from CdnIspDis where domain in("+markrn+")  and (rqTime>='"+(btime/1000)+"' and rqTime<'"+(etime/1000)+"')";//转换为秒所以除以1000
			List<CdnIspDis> cfd=realmtypebussiness.findObjectListByHQL(hql);
			 int telecom=0;//联通
			 int unicom=0;//电信
			 int chinamobile=0;//移动
			 int chinatietong=0;//铁通
			 int edu=0;//教育网
			 int other=0;//其他
			for(int i=0;i<cfd.size();i++)
			{
				telecom+=cfd.get(i).getTelecom();
				unicom+=cfd.get(i).getUnicom();
				chinamobile+=cfd.get(i).getChinamobile();
				chinatietong+=cfd.get(i).getChinatietong();
				edu+=cfd.get(i).getEdu();
				other+=cfd.get(i).getOther();
			}
			String mark=telecom+","+unicom+","+chinamobile+","+chinatietong+","+edu+","+other;
			try {
				response.getWriter().print(mark);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
		/**
		 * 根据域名  时间查询isp的访问次数
		 */
		/**
		 * 查询ISP每个类型的请求次数
		 */
		public void selectISPType()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			if(realmName!=null&&realmName!="")
			{
			String hql="from CdnIspDis where domain='"+realmName+"'";
			List<CdnIspDis> cfd=realmtypebussiness.findObjectListByHQL(hql);
			 int telecom=0;//联通
			 int unicom=0;//电信
			 int chinamobile=0;//移动
			 int chinatietong=0;//铁通
			 int edu=0;//教育网
			 int other=0;//其他
			for(int i=0;i<cfd.size();i++)
			{
				telecom+=cfd.get(i).getTelecom();
				unicom+=cfd.get(i).getUnicom();
				chinamobile+=cfd.get(i).getChinamobile();
				chinatietong+=cfd.get(i).getChinatietong();
				edu+=cfd.get(i).getEdu();
				other+=cfd.get(i).getOther();
			}
			String mark=telecom+","+unicom+","+chinamobile+","+chinatietong+","+edu+","+other;
			try {
				response.getWriter().print(mark);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
		
		}
		/**
		 * amcharts  data
		 * @throws ParseException
		 */
		public  void liuliangtu2() throws ParseException
		{
			String realmName1=request.getParameter("realmName");
			String realmName=realmName1.replace(".", "_");//www_litscloud_com
			String dataTime=request.getParameter("time");//2013-05-08
//			dataTime="2013-05-03";
//			realmName = "www_litscloud_com";
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			if(dataTime==null||dataTime=="")
			{

				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);

			}else{
				
				Date dd = TimePattern1.doStringTime(dataTime);
				calendar.setTime(dd);
				
			}
			btime = calendar.getTimeInMillis();
			calendar.add(Calendar.DATE, +1);
			etime = calendar.getTimeInMillis();
			
			if(realmName!=null&&realmName!="")
			{
			String hql="from cdnLogServer where domain='"+realmName+"' and (rqtime>='"+btime+"' and rqtime<'"+etime+"')";
			List<cdnLogServer> cls=realmtypebussiness.findObjectListByHQL(hql);

			//从时间(X轴)遍历 每隔5分钟打点
			//tongji 五分钟的值放进set中
			long total = 24*60*60*1000;
			double hz = 5*60*1000.0;//打点频率 用于除法预算 
			long   hz2 = 5*60*1000; //用于获得打点的次数 total/hz2 
			HashMap<Integer, Double> map = new HashMap<Integer, Double>();
			for (Iterator it = cls.iterator(); it.hasNext();) {
				cdnLogServer log = (cdnLogServer) it.next();
				log.getBandwidth();
				long yushu =  Long.parseLong(log.getRqtime())- btime;//得到该记录的访问时间与初始时间差
				int key =(int)Math.ceil(yushu/hz);//进位取余 将时间差与频率之商 用作map的key保存 将这个频率间隔内的带宽都放到value中
				if(map.containsKey(key)){//将hz时间内的带宽累加在一起
					map.put(key, map.get(key)+log.getBandwidth());
					
				}else{
					double value = log.getBandwidth();
					map.put(key, value);
				}
			}
			
			StringBuffer sb = new StringBuffer();
			long num = total/hz2;
			//组合amcharts数据字符串
			
			for(int i=0;i<num;i++)
			{
				
				if(map.containsKey(i)){
//					BigDecimal bd = new BigDecimal(map.get(i));  //数字超过一定长度 变成科学计数法  前台不识别此一个bug 需要转换成普通类型
					sb.append(""+(btime+i*hz2)+":"+ConvertFileSize.convertFileByMB(map.get(i))+",");
				}else{
					sb.append(""+(btime+i*hz2)+":0,");
				}
			}
			logger.info(sb.toString());
			try {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.getWriter().print(sb.substring(0, sb.length()-1));
			} catch (IOException e) {
				e.printStackTrace();
			}
			}
		}
		
		/**
		 * amcharts  data
		 * @throws ParseException
		 */
		public  void liuliangtu4() throws ParseException
		{
			String realmName1=request.getParameter("realmName");
			String realmName=realmName1.replace(".", "_");//www_litscloud_com
			if(realmName!=null&&realmName!="")
			{
			String dataTime=request.getParameter("startTime");//2013-05-08
			//dataTime="2013-05-07";
//			realmName = "www_litscloud_com";
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			if(dataTime==null||dataTime=="")
			{

				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);

			}else{
				
				Date dd = TimePattern1.doStringTime(dataTime);
				calendar.setTime(dd);
				
			}
			btime = calendar.getTimeInMillis();
			calendar.add(Calendar.DATE, +1);
			etime = calendar.getTimeInMillis();
			
			if(realmName!=null&&realmName!="")
			{
			String hql="from CdnAreaDis where domain='"+realmName+"' and (rqTime>='"+(btime/1000)+"' and rqTime<'"+(etime/1000)+"')";
			List<CdnAreaDis> cls=realmtypebussiness.findObjectListByHQL(hql);
				
			//从时间(X轴)遍历 每隔5分钟打点
			//tongji 五分钟的值放进set中
			long total = 24*60*60*1000;//数据库保存的是秒
			double hz = 5*60*1000.0;//打点频率 用于除法预算 
			long   hz2 = 5*60*1000; //用于获得打点的次数 total/hz2 
			HashMap<Integer, Double> map = new HashMap<Integer, Double>();
			for (Iterator it = cls.iterator(); it.hasNext();) {
				CdnAreaDis log = (CdnAreaDis) it.next();
				log.getFlow();
				long yushu =  Long.parseLong(log.getRqTime()+"000")- btime;//得到该记录的访问时间与初始时间差
				int key =(int)Math.ceil(yushu/hz);//进位取余 将时间差与频率之商 用作map的key保存 将这个频率间隔内的带宽都放到value中
				if(map.containsKey(key)){//将hz时间内的带宽累加在一起
					map.put(key, map.get(key)+log.getFlow());
					
				}else{
					double value = log.getFlow();
					map.put(key, value);
				}
			}
			
			StringBuffer sb = new StringBuffer();
			long num = total/hz2;
			//组合amcharts数据字符串
			
			for(int i=0;i<num;i++)
			{
				
				if(map.containsKey(i)){
//					BigDecimal bd = new BigDecimal(map.get(i));  //数字超过一定长度 变成科学计数法  前台不识别此一个bug 需要转换成普通类型
					sb.append(""+(btime+i*hz2)+":"+map.get(i)+",");
				}else{
					sb.append(""+(btime+i*hz2)+":0,");
				}
			}
			logger.info(sb.toString());
			try {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.getWriter().print(sb.substring(0, sb.length()-1));
			} catch (IOException e) {
				e.printStackTrace();
			}
			}
			}
		}
		
		/**
		 * 更具域名  时间查询流量按天显示
		 * @throws ParseException
		 */
		public void liuliangtu5()
		{
			String realmName=request.getParameter("realmName");
			realmName=realmName.replace(".", "_");
			
			String[] rn=realmName.split(",");
			String markrn="";
			for(int i=0;i<rn.length;i++)//in 查询需要格式是in （'sds','sdasd'）  域名是字符串不转换会报错
			{
				if(i+1!=rn.length)
				markrn+="'"+rn[i]+"',";
				else
					markrn+="'"+rn[i]+"'";	
			}
			
			String startTime=request.getParameter("startTime");//开始时间
			String endTime=request.getParameter("endTime");//结束时间
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			Date dd = TimePattern1.doStringTime(startTime);//开始时间转换为好秒
			calendar.setTime(dd);
			btime = calendar.getTimeInMillis();
			
			Calendar calendar1 = Calendar.getInstance();//结束时间转换为毫秒
			Date dd1 = TimePattern1.doStringTime(endTime);
			calendar1.setTime(dd1);
			calendar1.add(Calendar.DATE, +1);
			etime = calendar1.getTimeInMillis();
			long numDate=(etime-btime)/24/60/60/1000*24;//获取天数
			int num=Integer.parseInt(numDate+"");//获取打点数(没小时打一次点)
			
			String hql="from CdnAreaDis where domain in ("+markrn+") and (rqTime>='"+btime/1000+"' and rqTime<'"+etime/1000+"')";
			List<CdnAreaDis> cls=realmtypebussiness.findObjectListByHQL(hql);
			long numM=1000*60*60;//获取每小时的毫秒
			String sb="";
			long num1=0;
			for(int i=0;i<num;i++)
			{
				
				int num2=0;
				if(i==0)
				{
					num1=btime;
				}
				else
				{
					num1=num1+numM;
				}
				for(int j=0;j<cls.size();j++)
				{
					if(Long.parseLong(cls.get(j).getRqTime()+"000")>=num1&&Long.parseLong(cls.get(j).getRqTime()+"000")<(num1+numM))
					{
						num2=num2+cls.get(j).getFlow();
					}
				}
				sb+=num1+":"+num2+",";
			}
			
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				try {
					response.getWriter().print(sb.substring(0, sb.length()-1));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		}
		
		/**
		 * amcharts  data
		 * @throws ParseException
		 */
		public  void liuliangtu3() throws ParseException
		{
			String realmName1=request.getParameter("realmName");//域名
			String realmName=realmName1.replace(".", "_");
			if(realmName!=null&&realmName!="")
			{
			realmName=realmName.substring(0, realmName.length()-1);
			String[] rn=realmName.split(",");
			String markrn="";
			for(int i=0;i<rn.length;i++)//in 查询需要格式是in （'sds','sdasd'）  域名是字符串不转换会报错
			{
				if(i+1!=rn.length)
				markrn+="'"+rn[i]+"',";
				else
					markrn+="'"+rn[i]+"'";	
			}
			
			String startTime=request.getParameter("startTime");//开始时间
			String endTime=request.getParameter("endTime");//结束时间
//			dataTime="2013-05-03";
//			realmName = "www_litscloud_com";
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			
			Date dd = TimePattern1.doStringTime(startTime);//开始时间转换为好秒
			calendar.setTime(dd);
			btime = calendar.getTimeInMillis();
			
			Calendar calendar1 = Calendar.getInstance();//结束时间转换为毫秒
			Date dd1 = TimePattern1.doStringTime(endTime);
			calendar1.setTime(dd1);
			calendar1.add(Calendar.DATE, +1);
			etime = calendar1.getTimeInMillis();
			
			
			String hql="from cdnLogServer where domain in ("+markrn+") and (rqtime>='"+btime+"' and rqtime<'"+etime+"')";
			List<cdnLogServer> cls=realmtypebussiness.findObjectListByHQL(hql);

			//从时间(X轴)遍历 每隔5分钟打点
			//tongji 五分钟的值放进set中
			long total = 24*60*60*1000;
			double hz = 5*60*1000.0;//打点频率 用于除法预算 
			long   hz2 = 5*60*1000; //用于获得打点的次数 total/hz2 
			HashMap<Integer, Double> map = new HashMap<Integer, Double>();
			for (Iterator it = cls.iterator(); it.hasNext();) {
				cdnLogServer log = (cdnLogServer) it.next();
				log.getBandwidth();
				long yushu =  Long.parseLong(log.getRqtime())- btime;//得到该记录的访问时间与初始时间差
				int key =(int)Math.ceil(yushu/hz);//进位取余 将时间差与频率之商 用作map的key保存 将这个频率间隔内的带宽都放到value中
				if(map.containsKey(key)){//将hz时间内的带宽累加在一起
					map.put(key, map.get(key)+log.getBandwidth());
					
				}else{
					double value = log.getBandwidth();
					map.put(key, value);
				}
			}
			StringBuffer sb = new StringBuffer();
			long num = total/hz2;
			//组合amcharts数据字符串
			long sj=etime-btime;//获取查询开始到结束的毫秒数差
			
			long num1=sj/hz2;//获取查询所以天数的打点
			for(int i=0;i<num1;i++)
			{
				
				if(map.containsKey(i)){
//					BigDecimal bd = new BigDecimal(map.get(i));  //数字超过一定长度 变成科学计数法  前台不识别此一个bug 需要转换成普通类型
					sb.append(""+(btime+i*hz2)+":"+ConvertFileSize.convertFileByMB(map.get(i))+",");
				}else{
					sb.append(""+(btime+i*hz2)+":0,");
				}
			}
			System.out.println(sb.toString());
			logger.info(sb.toString());
			try {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.getWriter().print(sb.substring(0, sb.length()-1));
			} catch (IOException e) {
				e.printStackTrace();
			}
			}
		}
		/**
		 * 查询流量按天显示
		 * @throws ParseException
		 */
		public void selectFlow()
		{
			String realmName1=request.getParameter("realmName");//域名
			String realmName=realmName1.replace(".", "_");
			if(realmName!=null&&realmName!="")
			{
			
			String dataTime=request.getParameter("startTime");//开始时间
			//String dataTime="2013-05-07";//开始时间
//			dataTime="2013-05-03";
//			realmName = "www_litscloud_com";
//			dataTime="2013-05-03";
//			realmName = "www_litscloud_com";
			Calendar calendar = Calendar.getInstance();
			long btime = 0;
			long etime = 0;
			if(dataTime==null||dataTime=="")
			{

				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);

			}else{
				
				Date dd = TimePattern1.doStringTime(dataTime);
				calendar.setTime(dd);
				
			}
			btime = calendar.getTimeInMillis();
			calendar.add(Calendar.DATE, +1);
			etime = calendar.getTimeInMillis();
			
			if(realmName!=null&&realmName!="")
			{
			String hql="from cdnLogServer where domain='"+realmName+"' and (rqtime>='"+btime+"' and rqtime<'"+etime+"')";
			List<cdnLogServer> cls=realmtypebussiness.findObjectListByHQL(hql);
			int num=0;
			for(int i=0;i<cls.size();i++)
			{
				num+=cls.get(i).getFlow();
			}
			StringBuffer sb = new StringBuffer();
			sb.append(""+(etime-1000)+":"+num/86400+",");
			logger.info(sb.toString());
			try {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.getWriter().print(sb.substring(0, sb.length()-1));
			} catch (IOException e) {
				e.printStackTrace();
			}
			}
			}
		}
		public  void liuliangtu() throws ParseException
		{
			String realmName1=request.getParameter("realmName");
			String realmName=realmName1.replace(".", "_");
			String dataTime=request.getParameter("time");
			if(dataTime==null||dataTime=="")
			{
			 Calendar calendar = Calendar.getInstance(); //当前时间
			 calendar.add(Calendar.MONTH, +1);
			 int year=calendar.get(Calendar.YEAR);//年 
			 int month1=calendar.get(Calendar.MONTH);//月 
			 int date1=calendar.get(Calendar.DATE);//日
			 String date="";
			 String month="";
			 if(date1<10)
		    	{
		    		date="0"+date1+"";
		    	}
				 else
				 {
					date=date1+""; 
				 }
		    if(month1<9)
		    	{
		    		month="0"+(month1)+"";
		    	}
		    else
		    {
		    	month=month1+"";
		    }
			
		     dataTime=year+month+date+"000000";//以上获取当前时间k开始的时间
			}
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			 Date d = sdf.parse(dataTime);
			Calendar c = Calendar.getInstance();
			c.setTime(d);
			String kaishi=c.getTimeInMillis()+"";//开始时间的毫秒数
			String jieshu=c.getTimeInMillis()+86400000+"";//结束时间的毫秒数
			
			
			String hql="from cdnLogServer where domain='"+realmName+"' and (rqtime>='"+kaishi+"' and rqtime<'"+jieshu+"')";
			List<cdnLogServer> cls=realmtypebussiness.findObjectListByHQL(hql);
			/*
	
    aa+="<set value='"+${ct.aHours}+"' /><set value='"+${ct.bHours}+"' /><set value='"+${ct.cHours}+"' /><set value='"+${ct.dHours}+"' /><set value='"+${ct.eHours}+"' /><set value='"+${ct.fHours}+"' /><set value='"+${ct.gHours}+"' /><set value='"+${ct.hHours}+"' /><set value='"+${ct.iHours}+"' /><set value='"+${ct.jHours}+"' /><set value='"+${ct.kHours}+"' /><set value='"+${ct.lHours}+"' /><set value='"+${ct.mHours}+"' /></dataset>";
  	aa+="</chart>";
			 */
			String aa="<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='流量图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='kb' formatNumberScale='0'><categories>";
			aa+="<category label='0时0分' /><category label='0时05分' /><category label='0时10分' /><category label='0时15分' /><category label='0时20分' /><category label='0时25分' /><category label='0时30分' /><category label='0时35分' /><category label='0时40分' /><category label='0时45分' /><category label='0时50分' /><category label='0时55分' /><category label='1时0分' /><category label='1时05分' /><category label='1时10分' /><category label='1时15分' /><category label='1时20分' /><category label='1时25分' /><category label='1时30分' /><category label='1时35分' /><category label='1时40分' /><category label='1时45分' /><category label='1时50分' /><category label='1时55分' />" ;
			aa+="<category label='2时0分' /><category label='2时05分' /><category label='2时10分' /><category label='2时15分' /><category label='2时20分' /><category label='2时25分' /><category label='2时30分' /><category label='2时35分' /><category label='2时40分' /><category label='2时45分' /><category label='2时50分' /><category label='2时55分' /><category label='3时0分' /><category label='3时05分' /><category label='3时10分' /><category label='3时15分' /><category label='3时20分' /><category label='3时25分' /><category label='3时30分' /><category label='3时35分' /><category label='3时40分' /><category label='3时45分' /><category label='3时50分' /><category label='3时55分' />" +
					"<category label='4时0分' /><category label='4时05分' /><category label='4时10分' /><category label='4时15分' /><category label='4时20分' /><category label='4时25分' /><category label='4时30分' /><category label='4时35分' /><category label='4时40分' /><category label='4时45分' /><category label='4时50分' /><category label='4时55分' /><category label='5时0分' /><category label='5时05分' /><category label='5时10分' /><category label='5时15分' /><category label='5时20分' /><category label='5时25分' /><category label='5时30分' /><category label='5时35分' /><category label='5时40分' /><category label='5时45分' /><category label='5时50分' /><category label='5时55分' />"+
					"<category label='6时0分' /><category label='6时05分' /><category label='6时10分' /><category label='6时15分' /><category label='6时20分' /><category label='6时25分' /><category label='6时30分' /><category label='6时35分' /><category label='6时40分' /><category label='6时45分' /><category label='6时50分' /><category label='6时55分' /><category label='7时0分' /><category label='7时05分' /><category label='7时10分' /><category label='7时15分' /><category label='7时20分' /><category label='7时25分' /><category label='7时30分' /><category label='7时35分' /><category label='7时40分' /><category label='7时45分' /><category label='7时50分' /><category label='7时55分' />"+
					"<category label='8时0分' /><category label='8时05分' /><category label='8时10分' /><category label='8时15分' /><category label='8时20分' /><category label='8时25分' /><category label='8时30分' /><category label='8时35分' /><category label='8时40分' /><category label='8时45分' /><category label='8时50分' /><category label='8时55分' /><category label='9时0分' /><category label='9时05分' /><category label='9时10分' /><category label='9时15分' /><category label='9时20分' /><category label='9时25分' /><category label='9时30分' /><category label='9时35分' /><category label='9时40分' /><category label='9时45分' /><category label='9时50分' /><category label='9时55分' />" +
					"<category label='10时0分' /><category label='10时05分' /><category label='10时10分' /><category label='10时15分' /><category label='10时20分' /><category label='10时25分' /><category label='10时30分' /><category label='10时35分' /><category label='10时40分' /><category label='10时45分' /><category label='10时50分' /><category label='10时55分' /><category label='11时0分' /><category label='11时05分' /><category label='11时10分' /><category label='11时15分' /><category label='11时20分' /><category label='11时25分' /><category label='11时30分' /><category label='11时35分' /><category label='11时40分' /><category label='11时45分' /><category label='11时50分' /><category label='11时55分' />" +
					"<category label='12时0分' /><category label='12时05分' /><category label='12时10分' /><category label='12时15分' /><category label='12时20分' /><category label='12时25分' /><category label='12时30分' /><category label='12时35分' /><category label='12时40分' /><category label='12时45分' /><category label='12时50分' /><category label='12时55分' /><category label='13时0分' /><category label='13时05分' /><category label='13时10分' /><category label='13时15分' /><category label='13时20分' /><category label='13时25分' /><category label='13时30分' /><category label='13时35分' /><category label='13时40分' /><category label='13时45分' /><category label='13时50分' /><category label='13时55分' />" +
					"<category label='14时0分' /><category label='14时05分' /><category label='14时10分' /><category label='14时15分' /><category label='14时20分' /><category label='14时25分' /><category label='14时30分' /><category label='14时35分' /><category label='14时40分' /><category label='14时45分' /><category label='14时50分' /><category label='14时55分' /><category label='15时0分' /><category label='15时05分' /><category label='15时10分' /><category label='15时15分' /><category label='15时20分' /><category label='15时25分' /><category label='15时30分' /><category label='15时35分' /><category label='15时40分' /><category label='15时45分' /><category label='15时50分' /><category label='15时55分' />" +
					"<category label='16时0分' /><category label='16时05分' /><category label='16时10分' /><category label='16时15分' /><category label='16时20分' /><category label='16时25分' /><category label='16时30分' /><category label='16时35分' /><category label='16时40分' /><category label='16时45分' /><category label='16时50分' /><category label='16时55分' /><category label='17时0分' /><category label='17时05分' /><category label='17时10分' /><category label='17时15分' /><category label='17时20分' /><category label='17时25分' /><category label='17时30分' /><category label='17时35分' /><category label='17时40分' /><category label='17时45分' /><category label='17时50分' /><category label='17时55分' />" +
					"<category label='18时0分' /><category label='18时05分' /><category label='18时10分' /><category label='18时15分' /><category label='18时20分' /><category label='18时25分' /><category label='18时30分' /><category label='18时35分' /><category label='18时40分' /><category label='18时45分' /><category label='18时50分' /><category label='18时55分' /><category label='19时0分' /><category label='19时05分' /><category label='19时10分' /><category label='19时15分' /><category label='19时20分' /><category label='19时25分' /><category label='19时30分' /><category label='19时35分' /><category label='19时40分' /><category label='19时45分' /><category label='19时50分' /><category label='19时55分' />" +
					"<category label='20时0分' /><category label='20时05分' /><category label='20时10分' /><category label='20时15分' /><category label='20时20分' /><category label='20时25分' /><category label='20时30分' /><category label='20时35分' /><category label='20时40分' /><category label='20时45分' /><category label='20时50分' /><category label='20时55分' /><category label='21时0分' /><category label='21时05分' /><category label='21时10分' /><category label='21时15分' /><category label='21时20分' /><category label='21时25分' /><category label='21时30分' /><category label='21时35分' /><category label='21时40分' /><category label='21时45分' /><category label='21时50分' /><category label='21时55分' />" +
					"<category label='22时0分' /><category label='22时05分' /><category label='22时10分' /><category label='22时15分' /><category label='22时20分' /><category label='22时25分' /><category label='22时30分' /><category label='22时35分' /><category label='22时40分' /><category label='22时45分' /><category label='22时50分' /><category label='22时55分' /><category label='23时0分' /><category label='23时05分' /><category label='23时10分' /><category label='23时15分' /><category label='23时20分' /><category label='23时25分' /><category label='23时30分' /><category label='23时35分' /><category label='23时40分' /><category label='23时45分' /><category label='23时50分' /><category label='23时55分' /><category label='24时' />";
			
			aa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量(今天流量5分钟统计一次)'><set value='0' />";
			
			int[] num=new int[288];
			for(int i=0;i<cls.size();i++)
			{
				for(int j=0;j<num.length;j++)
				{
					long aaa=Long.parseLong(cls.get(i).getRqtime());
					long aaa1=Long.parseLong(c.getTimeInMillis()+(300000*(j))+"");
					long aaa2=Long.parseLong(c.getTimeInMillis()+(300000*(j+1))+"");
					if(aaa>=aaa1&&aaa<aaa2)
					{
						num[j]=num[j]+cls.get(i).getFlow();
					}
				}
			}
			for(int i=0;i<num.length;i++)
			{
				aa+="<set value='"+num[i]/1024+"' />";
			}
			aa+="</dataset></chart>";
			System.out.println(aa);
			try {
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(aa);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/**
		 * 分组列表
		 */
		public String selectGroup()
		{
			String pageNo=request.getParameter("pageNo");
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			String hql="from cdnGroup where del=0";
			Pages pages=cdnsaleorderbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 20, 0);
			for(int i=0;i<pages.getAllCount();i++)
			{
				String id=((cdnGroup)pages.getPageList().get(i)).getPanelPointId();
				String ipString="";
				if(!id.equals("")&&id!=null)
				{
				String[] ipId=id.split(",");
				
				for(int j=0;j<ipId.length;j++)
				{
					String hql1="from cdnPanelPoint where id="+Integer.parseInt(ipId[j])+" and del=0";
					List<cdnPanelPoint> cpp= realmtypebussiness.findObjectListByHQL(hql1);
					if(cpp.size()>0)
					{
					if((j+1)%3==0)
					ipString+=cpp.get(0).getPanelPointIp()+"</br>";
					else
						ipString+=cpp.get(0).getPanelPointIp()+",";
					}
				}
				}
				cdnGroup cg=new cdnGroup();
				cg.setId(((cdnGroup)pages.getPageList().get(i)).getId());
				cg.setGroupName(((cdnGroup)pages.getPageList().get(i)).getGroupName());
				cg.setPanelPointId(ipString);
				cg.setMark(((cdnGroup)pages.getPageList().get(i)).getMark());
				cg.setDel(((cdnGroup)pages.getPageList().get(i)).getDel());
				
				pages.getPageList().set(i, cg);
			}
			
			request.setAttribute("pages", pages);
			return "groupList";
			
		}
		/**
		 * 添加分组页面
		 * @return
		 */
		public String addAreaType()
		{
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);
			

			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);
			

			request.setAttribute("cdnArea", cdnArea);
			request.setAttribute("cdnType", cdnType);
			return "addAreaType";
		}
		/**
		 * 添加分组
		 * @throws IOException 
		 */
		public void addGroupName() throws IOException
		{
			String love=request.getParameter("love");
			String groupName1=request.getParameter("groupName");
			String groupName = URLDecoder.decode(groupName1, "UTF-8");
			cdnGroup cg=new cdnGroup();
			cg.setDel(0);
			cg.setGroupName(groupName);
			cg.setMark("0");
			cg.setPanelPointId(love);
			Object obiect=realmtypebussiness.addObject(cg);
			if(obiect!=null)
			{
				cdnGroup cdng=(cdnGroup) obiect;
				response.getWriter().print(cdng.getId());
			}
			else
			{
				response.getWriter().print("0");
			}
			
		}
		/**
		 * 修改显示
		 * @return
		 */
		public String addSelectGroup()
		{
			String id=request.getParameter("id");
			String hql="from cdnGroup where id="+Integer.parseInt(id)+"  and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hql);
			cdnGroup cg=new cdnGroup();
			if(cdnGroup.size()>0)
			{
				String ipString="";
				String PanelPointId=cdnGroup.get(0).getPanelPointId();
				if(!PanelPointId.equals("")&&PanelPointId!=null)
				{
				String[] ipId=PanelPointId.split(",");
				for(int j=0;j<ipId.length;j++)
				{
					String hql1="from cdnPanelPoint where id="+Integer.parseInt(ipId[j])+" and del=0";
					List<cdnPanelPoint> cpp= realmtypebussiness.findObjectListByHQL(hql1);
					if(cpp.size()>0)
					{
					if((j+1)%3==0)
					ipString+=cpp.get(0).getPanelPointIp()+"</br>";
					else
						ipString+=cpp.get(0).getPanelPointIp()+",";
					}
				}
				}
				cg.setDel(0);
				cg.setMark(cdnGroup.get(0).getMark());
				cg.setId(cdnGroup.get(0).getId());
				cg.setGroupName(cdnGroup.get(0).getGroupName());
				cg.setPanelPointId(ipString);
				
			}
			
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);
			

			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);
			
			request.setAttribute("cdnGroup", cg);
			request.setAttribute("cdnArea", cdnArea);
			request.setAttribute("cdnType", cdnType);
			return "addAreaType";
		}
		
		public String addSelectGroup1()
		{
			String id=request.getParameter("id");
			String hql="from cdnGroup where id="+Integer.parseInt(id)+"  and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hql);
			cdnGroup cg=new cdnGroup();
			if(cdnGroup.size()>0)
			{
				String ipString="";
				String PanelPointId=cdnGroup.get(0).getPanelPointId();
				if(!PanelPointId.equals("")&&PanelPointId!=null)
				{
				String[] ipId=PanelPointId.split(",");
				for(int j=0;j<ipId.length;j++)
				{
					String hql1="from cdnPanelPoint where id="+Integer.parseInt(ipId[j])+" and del=0";
					List<cdnPanelPoint> cpp= realmtypebussiness.findObjectListByHQL(hql1);
					if(cpp.size()>0)
					ipString+="<input type='checkbox' name='groupIP' value='"+cpp.get(0).getId()+"' />"+cpp.get(0).getPanelPointIp()     +""+cpp.get(0).getCdnAreaID().getProvince()+"  "+cpp.get(0).getCdnTypeID().getTypeName()+"</br>";
					
						
				}
				}
				cg.setDel(0);
				cg.setMark(cdnGroup.get(0).getMark());
				cg.setId(cdnGroup.get(0).getId());
				cg.setGroupName(cdnGroup.get(0).getGroupName());
				cg.setPanelPointId(ipString);
				
			}
			
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);
			

			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);
			request.setAttribute("cdnGroup", cg);
			request.setAttribute("cdnArea", cdnArea);
			request.setAttribute("cdnType", cdnType);
			return "updateAreaType";
		}
		/**
		 * 修改分组节点
		 * @throws IOException 
		 */
		public void addgroupJieDian() throws IOException
		{
			String id=request.getParameter("id");
			String love=request.getParameter("love");
			String hql="from cdnGroup where id="+Integer.parseInt(id)+"  and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hql);
			if(cdnGroup.size()>0)
			{
				String hql1="update cdnGroup set panelPointId='"+cdnGroup.get(0).getPanelPointId()+""+love+"' where id="+Integer.parseInt(id)+"";
				int aa=realmtypebussiness.updataByHQL(hql1);
				if(aa>0)
				{
					response.getWriter().print(id);
					return;
				}
				
			}
			response.getWriter().print(0);
		}
		/**
		 * 查询IP
		 * @throws IOException 
		 * 
		 */
		public void selectIP1() throws IOException
		{
			String province=request.getParameter("province");
			String typeName=request.getParameter("typeName");
			String cuRealmName=request.getParameter("cuRealmName");
			String id=request.getParameter("id");
			String aa="";
			String hql="from cdnPanelPoint where cdnAreaID.id="+Integer.parseInt(province)+" and cdnTypeID.id="+Integer.parseInt(typeName)+" and del=0 and mark=0";
			List<cdnPanelPoint> cp=realmtypebussiness.findObjectListByHQL(hql);
			
			
			String hqlIp="from cdnGroup where id="+Integer.parseInt(id)+" and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hqlIp);
			String[] cg=null;
			if(cdnGroup.size()>0)
			{
				if(!cdnGroup.get(0).getPanelPointId().equals("")&&cdnGroup.get(0).getPanelPointId()!=null)
				cg=cdnGroup.get(0).getPanelPointId().split(",");
			}
			int flag = 0 ;//默认是不等的
			for(int i=0;i<cp.size();i++)
			{
				if(cg!=null)
				{
				
				for(int j=0;j<cg.length;j++)
				{
					
					if(cp.get(i).getId()==Integer.parseInt(cg[j]))
					{
						flag = 1;
						break;
					}
					
					}
				}
				if( flag ==1){
					if((i+1)%3==0){
						{
								aa+="<input type='checkbox'checked='checked' disabled='disabled' name='IP1' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a><br />";
						}
					}else
						{
							aa+="<input type='checkbox' checked='checked' disabled='disabled' name='IP1' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a>";
						}
				}
				else
				{
					if((i+1)%3==0)
					{
						
							aa+="<input type='checkbox'  name='IP' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a><br />";
					}
						else
						{
							aa+="<input type='checkbox'  name='IP' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a>";
						
						}
				}
				flag= 0;
			}
			aa.getBytes("utf-8");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(aa);
			
		}
		/**
		 * 删除分组
		 * @throws IOException 
		 */
		public void delGroup() throws IOException
		{
			String id=request.getParameter("id");
			String hqlIp="from cdnGroup where id="+Integer.parseInt(id)+" and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hqlIp);
			if(cdnGroup.size()>0)
			{
				int aa=realmtypebussiness.delObject(cdnGroup.get(0));
				if(aa>0)
				{
					response.getWriter().print("0");
					return;
				}
			}
		}
		/**
		 * 删除分组里面的节点
		 * @throws IOException 
		 */
		public void delGroup1() throws IOException
		{
			String id=request.getParameter("id");
			String love=request.getParameter("love");
			String hqlIp="from cdnGroup where id="+Integer.parseInt(id)+" and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hqlIp);
			
			String[] ppId=cdnGroup.get(0).getPanelPointId().split(",");
			String[] ppId1=love.split(",");
			String ppid="";
			for(int i=0;i<ppId.length;i++)
			{
				int mark=0;
				for(int j=0;j<ppId1.length;j++)
				{
					if(ppId[i].equals(ppId1[j]))
					{
						mark=1;
						break;
					}
				}
				if(mark==0)
				{
					ppid+=ppId[i]+",";
				}
			}
			String hql="update cdnGroup set panelPointId='"+ppid+"' where id="+Integer.parseInt(id)+"";
			int aa=realmtypebussiness.updataByHQL(hql);
			if(aa>0)
			{
				response.getWriter().print("0");
			}
		}
		/**
		 * 用户加速域名的设置_节点加速
		 */
		public String cdnRealmNameIP()
		{
			System.out.println("aaaa");
			String cusid=request.getParameter("cusid");
			String realmName=request.getParameter("realmName");
			
			
			
			System.out.println("1234::"+cusid+"____"+realmName);
			
			String hql="from cdnRealmNameIP where cuRealmName='"+realmName+"'and customerID.customerId="+Integer.parseInt(cusid)+" and del=0 order by id desc";
			List<cdnRealmNameIP> crni= realmtypebussiness.findObjectListByHQL(hql);
			
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);
			

			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);

			request.setAttribute("cusid",cusid);
			request.setAttribute("realmName",realmName);

			request.setAttribute("crni", crni);
			request.setAttribute("cdnArea", cdnArea);
			request.setAttribute("cdnType", cdnType);
			
			return "custcdnlist";
		}
		/**
		 * 用户加速域名的设置--地域加速
		 * @return
		 */
		public String cdnRealmNameIP_2()
		{
			System.out.println("aaaa");
			String cusid=request.getParameter("cusid");
			String realmName=request.getParameter("realmName");
		
			System.out.println("_2:"+cusid+"-----"+realmName);
			String hql="from cdnRealmNameIP where cuRealmName='"+realmName+"'and customerID.customerId="+Integer.parseInt(cusid)+" and del=0 order by id desc";
			List<cdnRealmNameIP> crni= realmtypebussiness.findObjectListByHQL(hql);
			
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);
			
			

			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);
			
			List list=new ArrayList<String>();
			
			for(int i=0;i<crni.size();i++)//拿出地域线路的id
			{
				list.add(i,crni.get(i).getCdnPanelPointID().getCdnAreaID().getId()+""+crni.get(i).getCdnPanelPointID().getCdnTypeID().getId());
				
			}
			//去掉重复
			   for ( int i = 0 ; i < list.size() - 1 ; i ++ ) {
				     for ( int j = list.size() - 1 ; j > i; j -- ) {
				       if (list.get(j).equals(list.get(i))) {
				         list.remove(j);
				       } 
				      } 
				    } 
			   List<cdnDnsPod> cdp=new ArrayList<cdnDnsPod>();
			   for(int j=0;j<list.size();j++)
			   {
				   String id="";
				   String ip="";
				   String typeName="";
				   String mark="";
				   for(int i=0;i<crni.size();i++)
				   {
					   String areaTypeId=crni.get(i).getCdnPanelPointID().getCdnAreaID().getId()+""+crni.get(i).getCdnPanelPointID().getCdnTypeID().getId();
					   if(areaTypeId.equals(list.get(j)))//判断线路list里面的id和crni里面的线路ID有哪些相等
					   {
						   id=id+crni.get(i).getId()+",";//相等就放到一起用,号分隔
						   ip=ip+crni.get(i).getCdnPanelPointID().getPanelPointIp()+",";//ip
						   typeName=crni.get(i).getCdnPanelPointID().getCdnAreaID().getProvince()+crni.get(i).getCdnPanelPointID().getCdnTypeID().getTypeName();//省份线路
						   mark = mark+crni.get(i).getMark()+","; //状态
					   }
				   }
				   cdnDnsPod cd=new cdnDnsPod();
				   String [] markArray = mark.split(",");//分割后的mark值
				   String [] ipArray = ip.split(",");//分割后的ip数组
				   String ip1="";
				   for(int i = 0;i<markArray.length;i++){//遍历mark数组
					   if(markArray[i].equals("0"))
					   {
						   ip1 +="<font color='green'>"+ipArray[i]+"</font>,";//个ip设置样式
					   }else if(markArray[i].equals("2"))
					   {
						   ip1 +="<font color='red'>"+ipArray[i]+"</font>,";//个ip设置样式
					   }
				   }
				   cd.setId(id);
//				   if(ipMark.equals("0")){
//					   ip ="<font color='green'>192.168.2.22</font>";
//				   }else if(ipMark.equals("2")){
//					   ip ="<font color='red'>192.168.2.22</font>";
//				   }
//				   ip ="<font color='red'>192.168.2.22</font>";
				   cd.setIp(ip1);
				   System.out.println(ip1);
				   cd.setTypeName(typeName);
				   cd.setYuming(realmName);
				   cd.setMark(mark);
				   cdp.add(j, cd);//放到cdplist里面输出到页面
			   }

			request.setAttribute("cdp",cdp);
			request.setAttribute("cusid", cusid);
			request.setAttribute("realmName",realmName);

			request.setAttribute("crni", crni);
			request.setAttribute("cdnArea", cdnArea);
			request.setAttribute("cdnType", cdnType);
			
			return "custcdnlist_2";
		}
		
		/**
		 * 线路列表
		 */
		public String cdnTypeList()
		{
			String hql="from cdnType where  del=0";
			List<cdnType> cp=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("cdnType", cp);
			
			return "cdnTypeList";
		}
		/**
		 * 线路对接
		 * @throws Exception 
		 */
		public void updateTypeName() throws Exception
		{
			String xml=dnsp.selectDengJiDNSPod("", "");
			
			Pattern pattern = Pattern.compile("<item><!\\[CDATA\\[(.*?)]]></item>");
			Matcher matcher = pattern.matcher(xml);
			List<String> typeName=new ArrayList<String>();
			int num=1;
			while (matcher.find()) {
				typeName.add(num-1, matcher.group(num));
				
			}
			String hql="from cdnType where  del=0";
			List<cdnType> cp=realmtypebussiness.findObjectListByHQL(hql);
			
			for(int i=0;i<typeName.size();i++)
			{
				int mark=0;
				for(int j=0;j<cp.size();j++)
				{
					if(typeName.get(i).equals(cp.get(j).getTypeName()))
					{
						mark=1;
						break;
					}
				}
				if(mark==0)
				{
					cdnType  ct=new cdnType();
					ct.setDel(0);
					ct.setMark(0);
					ct.setTypeName(typeName.get(i));
					
					realmtypebussiness.addObject(ct);
				}
			}
			response.getWriter().append("1");
		}
		/**
		 * 删除线路
		 * @throws IOException 
		 */
		public void delTypeName() throws IOException
		{
			String id=request.getParameter("id");
			String hql="update cdnType set del=1 where id="+Integer.parseInt(id)+" ";
			int aa=realmtypebussiness.updataByHQL(hql);
			if(aa>0)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
		}
		/**
		 * 查询IP
		 * @throws IOException 
		 * 
		 */
		public void selectIP() throws IOException
		{
			String province=request.getParameter("province");
			String typeName=request.getParameter("typeName");
			String cuRealmName=request.getParameter("cuRealmName");
			String aa="";
			String hql="from cdnPanelPoint where cdnAreaID.id="+Integer.parseInt(province)+" and cdnTypeID.id="+Integer.parseInt(typeName)+" and del=0 and mark=0";
			List<cdnPanelPoint> cp=realmtypebussiness.findObjectListByHQL(hql);
			
			String hql1="from cdnRealmNameIP where cuRealmName='"+cuRealmName+"' and cdnPanelPointID.cdnAreaID.id="+Integer.parseInt(province)+" and cdnPanelPointID.cdnTypeID.id="+Integer.parseInt(typeName)+" and del=0";
			List<cdnRealmNameIP> crni=realmtypebussiness.findObjectListByHQL(hql1);
			
			int flag = 0 ;//默认是不等的
			for(int i=0;i<cp.size();i++)
			{
				
				for(int j=0;j<crni.size();j++)
				{
				if(cp.get(i).getId()==crni.get(j).getCdnPanelPointID().getId())
				{
					flag = 1;
					break;
				}
				
				}
				if( flag ==1){
					if((i+1)%3==0){
						aa+="<input type='checkbox'checked='checked'  name='IP' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a><br />";
					}else
						{
							aa+="<input type='checkbox' checked='checked' name='IP' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a>";
						}
				}
				else
				{
					if((i+1)%3==0)
						aa+="<input type='checkbox'  name='IP' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a><br />";
						else
						{
							aa+="<input type='checkbox'  name='IP' value='"+cp.get(i).getId()+"' /><a style='text-decoration:none;' href='javascript:void(0)' title='"+cp.get(i).getAddress()+"' >"+cp.get(i).getPanelPointIp()+"</a>";
						}
				}
				flag= 0;
			}
			aa.getBytes("utf-8");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(aa);
			
		}
		/**
		 * 增加IP
		 * @throws Exception 
		 */
		public void addIP() throws Exception 
		{
			String cusID=request.getParameter("cusID");
			String cuRealmName=request.getParameter("cuRealmName");
			String love=request.getParameter("love");
			String love1=request.getParameter("love1");
			String[] l=love.split(",");
			String[] l1=love1.split(",");
			int nummark=0;
			String hql="from Customer where customerId="+Integer.parseInt(cusID)+" and del='0'";
			List<Customer> cu= realmtypebussiness.findObjectListByHQL(hql);
			
			String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
			
			Pattern patternId = Pattern.compile("<id>(.*?)</id>");
			Matcher matcherId = patternId.matcher(xml);
			
			List patternNameList=new ArrayList<String>();
			int num1=1;
			while (matcherId.find()) {
				patternNameList.add(num1-1, matcherId.group(num1));
				num1++;
			}
			
			Pattern patternName=Pattern.compile("<name>(.*?)</name>");
			Matcher matcherName=patternName.matcher(xml);
			
			List patternIdList=new ArrayList<String>();
			int num2=1;
			while (matcherName.find()) {
				patternIdList.add(num2-1, matcherName.group(num2));
				num2++;
				
			}
			String DNSPodId="";
			
			for(int i=0;i<patternIdList.size();i++)
			{
				if(patternIdList.get(i).equals("fuao2008.com"))
				{
					DNSPodId=(String) patternNameList.get(i);
					break;
				}
			}
			String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, cuRealmName);//获取返回过来的IPId
			Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
			Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
		
			List<String> cuRealmNameIdList=new ArrayList<String>();
			int num3=1;
			while (cuRealmNameId.find()) {
				cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
				
			}
			
			Pattern cuName=Pattern.compile("<name>(.*?)</name>");
			Matcher cuurName=cuName.matcher(customerIP);//获取客户域名
			List<String> cuNameList=new ArrayList<String>();
			int num4=1;
			while (cuurName.find()) {
				cuNameList.add(num4-1,cuurName.group(num4));
				
			}
			
			Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
			Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
			
			List<String> cuRNvalue=new ArrayList<String>();
			int num5=1;
			while (cuRealmNameIP.find()) {
				cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
				
			}
		
			for(int i=0;i<l1.length;i++)
			{
				String hql1="from cdnRealmNameIP where cuRealmName='"+cuRealmName+"' and  cdnPanelPointID.id="+Integer.parseInt(l1[i])+" ";
				List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
				
				if(c.size()>0)
				{
					realmtypebussiness.delObject(c.get(0));
					//dnsp.delDNSPod(domainId, recordId)
//					for(int j=1;j<cuRealmNameIP.groupCount()+1;j++)
//					{
//						System.out.println(cuRealmNameIP.group(j));
//						System.out.println(c.get(0).getCdnPanelPointID().getPanelPointIp());
//						if(cuRealmNameIP.group(j).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))
//						{
//							dnsp.delDNSPod(DNSPodId, cuRealmNameId.group(j+1));
//						}
//					}
							for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
							{
								if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
								{
									if(cuNameList.get(q).equals(c.get(0).getCuRealmName()))//判断要删除的域名和dnspod的域名是否相等
									{
										String aa=dnsp.delDNSPod(DNSPodId,cuRealmNameIdList.get(q));//如果域名下的IP是对的就进行删除
										System.out.println(aa);
									}
								}
							
					}
				}
				
				
			}
			for(int i=0;i<l.length;i++)
			{
				System.out.println(l[i]);
				String hql1="from cdnPanelPoint where id="+Integer.parseInt(l[i])+" and del=0";
				List<cdnPanelPoint> cupl=realmtypebussiness.findObjectListByHQL(hql1);
				String hql11="from cdnRealmNameIP where  cuRealmName='"+cuRealmName+"' and cdnPanelPointID.id="+Integer.parseInt(l[i])+" ";
				List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql11);
				if(c.size()==0)
				{
				cdnRealmNameIP crni=new cdnRealmNameIP();
				crni.setCuRealmName(cuRealmName);
				crni.setCustomerID(cu.get(0));
				crni.setDel(0);
				crni.setMark(0);
				crni.setCdnPanelPointID(cupl.get(0));
				
				
				realmtypebussiness.addObject(crni);
				nummark=1;
				String xianlu="";
				
				String aa=dnsp.addDNSPod(DNSPodId, cuRealmName, "A", cupl.get(0).getCdnTypeID().getTypeName(), cupl.get(0).getPanelPointIp(),"600");
				System.out.println(aa);
				}
				
			}
			if(nummark==0)
			{
				response.getWriter().print("3");
				return;
			}
			try {
				response.getWriter().print("0");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		/**
		 * 选择组增加IP
		 * @throws Exception 
		 */
		public void addGroupIP() throws Exception 
		{
			String cusID=request.getParameter("cusId");
			String cuRealmName=request.getParameter("cuRealmName");
			String groupId=request.getParameter("groupId");
			
			String hqlGroup="from cdnGroup where id="+Integer.parseInt(groupId)+" and del=0";
			List<cdnGroup> cdnGroup=realmtypebussiness.findObjectListByHQL(hqlGroup);
			
			String[] l=cdnGroup.get(0).getPanelPointId().split(",");
			String hql="from Customer where customerId="+Integer.parseInt(cusID)+" and del='0'";
			List<Customer> cu= realmtypebussiness.findObjectListByHQL(hql);
			
			String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
			
			Pattern patternId = Pattern.compile("<id>(.*?)</id>");
			Matcher matcherId = patternId.matcher(xml);
			
			List patternNameList=new ArrayList<String>();
			int num1=1;
			while (matcherId.find()) {
				patternNameList.add(num1-1, matcherId.group(num1));
				num1++;
			}
			
			Pattern patternName=Pattern.compile("<name>(.*?)</name>");
			Matcher matcherName=patternName.matcher(xml);
			
			List patternIdList=new ArrayList<String>();
			int num2=1;
			while (matcherName.find()) {
				patternIdList.add(num2-1, matcherName.group(num2));
				num2++;
				
			}
			String DNSPodId="";
			
			for(int i=0;i<patternIdList.size();i++)
			{
				if(patternIdList.get(i).equals("fuao2008.com"))
				{
					DNSPodId=(String) patternNameList.get(i);
					break;
				}
			}
			String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, cuRealmName);//获取返回过来的IPId
			Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
			Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
		
			List<String> cuRealmNameIdList=new ArrayList<String>();
			int num3=1;
			while (cuRealmNameId.find()) {
				cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
				
			}
			
			Pattern cuName=Pattern.compile("<name>(.*?)</name>");
			Matcher cuurName=cuName.matcher(customerIP);//获取客户域名
			List<String> cuNameList=new ArrayList<String>();
			int num4=1;
			while (cuurName.find()) {
				cuNameList.add(num4-1,cuurName.group(num4));
				
			}
			
			Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
			Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
			
			List<String> cuRNvalue=new ArrayList<String>();
			int num5=1;
			while (cuRealmNameIP.find()) {
				cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
				
			}
		
		
			for(int i=0;i<l.length;i++)
			{
				System.out.println(l[i]);
				String hql1="from cdnPanelPoint where id="+Integer.parseInt(l[i])+" and del=0";
				List<cdnPanelPoint> cupl=realmtypebussiness.findObjectListByHQL(hql1);
				String hql11="from cdnRealmNameIP where  cuRealmName='"+cuRealmName+"' and cdnPanelPointID.id="+Integer.parseInt(l[i])+" ";
				List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql11);
				if(c.size()==0&&cupl.size()>0)
				{
				cdnRealmNameIP crni=new cdnRealmNameIP();
				crni.setCuRealmName(cuRealmName);
				crni.setCustomerID(cu.get(0));
				crni.setDel(0);
				crni.setMark(0);
				crni.setCdnPanelPointID(cupl.get(0));
				
				
				realmtypebussiness.addObject(crni);
				String xianlu="";
				
				String aa=dnsp.addDNSPod(DNSPodId, cuRealmName, "A", cupl.get(0).getCdnTypeID().getTypeName(), cupl.get(0).getPanelPointIp(),"600");
				System.out.println(aa);
				}
				
			}
			try {
				response.getWriter().print("0");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		/**
		 * 删除IP
		 * @throws Exception 
		 */
		public void delIP() throws Exception
		{
			String id=request.getParameter("id");
			
			String hql1="from cdnRealmNameIP where id="+Integer.parseInt(id)+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
			int aa=realmtypebussiness.delObject(c.get(0));
			if(aa>0)
			{
				response.getWriter().print("0");
				//删除dnspod的数据
				
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int i=0;i<patternIdList.size();i++)
				{
					if(patternIdList.get(i).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(i);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(0).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				Pattern cuName=Pattern.compile("<name>(.*?)</name>");
				Matcher cuurName=cuName.matcher(customerIP);//获取客户域名
				List<String> cuNameList=new ArrayList<String>();
				int num4=1;
				while (cuurName.find()) {
					cuNameList.add(num4-1,cuurName.group(num4));
					
				}
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						if(cuNameList.get(q).equals(c.get(0).getCuRealmName()))//判断要删除的域名和dnspod的域名是否相等
						{
							String aaa=dnsp.delDNSPod(DNSPodId,cuRealmNameIdList.get(q));//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						}
					}
				}
			}
			else
			{
			response.getWriter().print("1");
			}
			
		}
		/**
		 * 
		 * 暂停IP
		 * @throws Exception 
		 */
		public void suspendIP() throws Exception
		{
			String id=request.getParameter("id");
			
			String hql1="from cdnRealmNameIP where id="+Integer.parseInt(id)+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
			String hql="update cdnRealmNameIP set mark=2 where id="+Integer.parseInt(id)+" ";
			int aa=realmtypebussiness.updataByHQL(hql);
			if(aa>0)
			{
				
				//暂停
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int i=0;i<patternIdList.size();i++)
				{
					if(patternIdList.get(i).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(i);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(0).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				Pattern cuName=Pattern.compile("<name>(.*?)</name>");
				Matcher cuurName=cuName.matcher(customerIP);//获取客户域名
				List<String> cuNameList=new ArrayList<String>();
				int num4=1;
				while (cuurName.find()) {
					cuNameList.add(num4-1,cuurName.group(num4));
					
				}
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						if(cuNameList.get(q).equals(c.get(0).getCuRealmName()))//判断要删除的域名和dnspod的域名是否相等
						{
							String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"disable");//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						}
					}
				}
				
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		
		/**
		 * 恢复IP
		 * @throws Exception 
		 */
		public void resumeIP() throws Exception
		{
			
			String id=request.getParameter("id");
			String hql1="from cdnRealmNameIP where id="+Integer.parseInt(id)+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
			String hql="update cdnRealmNameIP set mark=0 where id="+Integer.parseInt(id)+" ";
			int aa=realmtypebussiness.updataByHQL(hql);
			if(aa>0)
			{
				response.getWriter().print("0");
				
				//暂停
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int i=0;i<patternIdList.size();i++)
				{
					if(patternIdList.get(i).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(i);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(0).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				Pattern cuName=Pattern.compile("<name>(.*?)</name>");
				Matcher cuurName=cuName.matcher(customerIP);//获取客户域名
				List<String> cuNameList=new ArrayList<String>();
				int num4=1;
				while (cuurName.find()) {
					cuNameList.add(num4-1,cuurName.group(num4));
					
				}
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						if(cuNameList.get(q).equals(c.get(0).getCuRealmName()))//判断要删除的域名和dnspod的域名是否相等
						{
							String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"enable");//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						}
					}
				}
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		
		
		/**
		 * 批量暂停IP
		 * @throws Exception 
		 */
		public  void suspendBatchIP() throws Exception
		{
			String id=request.getParameter("id");
			String[] ip=id.split(",");
			System.out.println(id+"是否出来了呢"+ip);
			for(int i=0;i<ip.length;i++)
			{
				String hql1="from cdnRealmNameIP where id="+Integer.parseInt(ip[i])+" ";
				List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
				String hql="update cdnRealmNameIP set mark=2 where id="+Integer.parseInt(ip[i])+" ";
				int aa=realmtypebussiness.updataByHQL(hql);
				
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
				if(c.size()>0){
				//暂停
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int ii=0;i<patternIdList.size();ii++)
				{
					if(patternIdList.get(ii).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(ii);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(0).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						
							String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"disable");//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						
					}
				}
				}
			}
			response.getWriter().print("0");
			
			
		}
		/**
		 * 批量恢复
		 * @throws Exception 
		 */
		public  void resumeBatchIP() throws Exception
		{
			String id=request.getParameter("id");
			String[] ip=id.split(",");
			for(int i=0;i<ip.length;i++)
			{	String hql1="from cdnRealmNameIP where id="+Integer.parseInt(ip[i])+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
				String hql="update cdnRealmNameIP set mark=0 where id="+Integer.parseInt(ip[i])+" ";
				int aa=realmtypebussiness.updataByHQL(hql);
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
				if(c.size()>0){
					//暂停
					String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
					
					Pattern patternId = Pattern.compile("<id>(.*?)</id>");
					Matcher matcherId = patternId.matcher(xml);
					
					List patternNameList=new ArrayList<String>();
					int num1=1;
					while (matcherId.find()) {
						patternNameList.add(num1-1, matcherId.group(num1));
						num1++;
						
					}
					
					Pattern patternName=Pattern.compile("<name>(.*?)</name>");
					Matcher matcherName=patternName.matcher(xml);
					
					List patternIdList=new ArrayList<String>();
					int num2=1;
					while (matcherName.find()) {
						patternIdList.add(num2-1, matcherName.group(num2));
						num2++;
						
					}
					String DNSPodId="";
					
					for(int ii=0;i<patternIdList.size();ii++)
					{
						if(patternIdList.get(ii).equals("fuao2008.com"))
						{
							DNSPodId=(String) patternNameList.get(ii);
							break;
						}
					}
					String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(0).getCuRealmName());//获取返回过来的IPId
					Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
					Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
				
					List<String> cuRealmNameIdList=new ArrayList<String>();
					int num3=1;
					while (cuRealmNameId.find()) {
						cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
						
					}
					
					
					
					Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
					Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
					
					List<String> cuRNvalue=new ArrayList<String>();
					int num5=1;
					while (cuRealmNameIP.find()) {
						cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
						
					}
					
					for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
					{
						if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
						{
							
								String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"enable");//如果域名下的IP是对的就进行删除
								System.out.println(aaa);
							
						}
					}
					}
			}
			response.getWriter().print("0");
			
			
		}
		
		/**
		 * 批量删除
		 * @throws Exception 
		 */
		public  void delBatchIP() throws Exception
		{
			String id=request.getParameter("id");
			String[] ip=id.split(",");
			for(int i=0;i<ip.length;i++)
			{
				String hql1="from cdnRealmNameIP where id="+Integer.parseInt(ip[i])+" ";
				List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
				if(c.size()>0)
				{
				int aa=realmtypebussiness.delObject(c.get(0));
				//暂停
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int ii=0;i<patternIdList.size();ii++)
				{
					if(patternIdList.get(ii).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(ii);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(0).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(0).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						
						String aaa=dnsp.delDNSPod(DNSPodId,cuRealmNameIdList.get(q));//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						
					}
				}
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
				}
			}
			response.getWriter().print("0");
			
			
			
			
		}
		/**
		 * 模糊查询
		 */
		public void dimSelectIP()
		{
			String dimIP=request.getParameter("dimIP");
			String cusID=request.getParameter("cusID");
			String cuRealmName=request.getParameter("cuRealmName");
			String ipList="<table  border='0' width='440px;' class='tb tb2'>";
			
			String hql="from cdnRealmNameIP where cdnPanelPointID.panelPointIp like'%"+dimIP+"%' and customerID.customerId="+Integer.parseInt(cusID)+" and cuRealmName='"+cuRealmName+"' and del=0 order by id desc ";
			List<cdnRealmNameIP> crni=realmtypebussiness.findObjectListByHQL(hql);
			for(int i=0;i<crni.size();i++)
			{
				ipList+="<tr align='left'><td style='font: 10pt;' width='20%'><input type='checkbox' name='batchIP' value='"+crni.get(i).getId()+"' />" +
						"<a style='text-decoration:none;' href='javascript:void(0)' title='"+crni.get(i).getCdnPanelPointID().getAddress()+"' >"+crni.get(i).getCdnPanelPointID().getPanelPointIp()+"</a>" +
						"</td><td  style='font: 10pt;'  width='20%'>"+crni.get(i).getCdnPanelPointID().getCdnAreaID().getProvince()+""+crni.get(i).getCdnPanelPointID().getCdnTypeID().getTypeName()+"</td>" +
						"<td style='font: 10pt;'  width='20%'>"+crni.get(i).getCuRealmName()+"</td><td  width='20%'><b>";
				if(crni.get(i).getMark()==0)
				{
					ipList+="正常使用";
				}
				else if(crni.get(i).getMark()==1)
				{
					ipList+="损坏";
				}
				else if(crni.get(i).getMark()==2)
				{
					ipList+="暂停";
				}
				ipList+="</b></td><td style='font: 10pt;'  width='20%'>";
				if(crni.get(i).getMark()==1)
				{
					ipList+="<a class='faq' title='该IP损坏' href='javascript:void(0)' >损坏</a>&nbsp;&nbsp; ";
				}
				else if(crni.get(i).getMark()==0)
				{
					ipList+="<a class='faq' onclick='suspendIP("+crni.get(i).getId()+")' title='暂停该IP加速' >暂停</a>&nbsp;&nbsp; ";
				}
				else if(crni.get(i).getMark()==2)
				{
					ipList+="<a class='faq' title='恢复该IP加速' onclick='resumeIP("+crni.get(i).getId()+")'>恢复</a>&nbsp;&nbsp; ";
				}
				ipList+="<a class='faq' title='去掉该加速节点IP' onclick='delIP("+crni.get(i).getId()+")'>删除</a></td></tr>";
			}
			ipList+="</table>";
			response.setCharacterEncoding("UTF-8");
			try {
				response.getWriter().print(ipList);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(ipList);
		}
		
		/**
		 * 节点管理
		 * @return
		 * @throws IOException
		 */
		public String selectIpAreaType()
		{
			
			String hql="from cdnPanelPoint where  del=0 order by id desc";
			String pageNo=request.getParameter("pageNo");
			
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);
			
			

			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			Pages pages=cdnsaleorderbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);//返回所有节点的结合
			request.setAttribute("cdnArea", cdnArea);//返回省份
			request.setAttribute("cdnType", cdnType);//返回线路
			return "selectIpAreaType";
		}
		
		/**
		 * 节点管理地域线路显示
		 * @return
		 * @throws IOException
		 */
		public String selectIpdiyu()
		{
			
			String hql="from cdnPanelPoint where   del=0 ";
			List<cdnPanelPoint> cpp=realmtypebussiness.findObjectListByHQL(hql);//查询所有节点
			List<cdnDnsPod>  cdp=new ArrayList<cdnDnsPod>();
			String pageNo=request.getParameter("pageNo");
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			
			String hql1="from cdnArea where del=0";
			List<cdnArea> cdnArea= realmtypebussiness.findObjectListByHQL(hql1);//查询所有地域
			
			String hql11="from cdnType where del=0";
			List<cdnType> cdnType= realmtypebussiness.findObjectListByHQL(hql11);//查询所有线路
			
			int num=Integer.parseInt(pageNo)*10;//拿出本页要显示的数据
			int num1;
			int num2=0;
			if(num>cdnType.size())//判断是否大于list的长度
			{
				num=cdnType.size();
			}
			for(num1=(Integer.parseInt(pageNo)-1)*10;num1<num;num1++)//num1当前页开始的值 num结束的值
			{
				String id="";
				String  ip="";
				String mark="";
				int aaaa=0;
				for(int i=0;i<cpp.size();i++)
				{
					if(cdnType.get(num1).getId()==cpp.get(i).getCdnTypeID().getId())
					{
						id+=cpp.get(i).getId()+",";
						
						if(cpp.get(i).getMark()==0)
						{
							ip+="<font color='green'>"+cpp.get(i).getPanelPointIp()+"</font>  <font color='red'> 端口："+cpp.get(i).getDuankou()+"</font>,";
							
								ip+="<br />";
						}
						else if(cpp.get(i).getMark()==2)
						{
							ip+="<font color='red'>"+cpp.get(i).getPanelPointIp()+"</font><font color='red'> 端口："+cpp.get(i).getDuankou()+"</font>,";
							
								ip+="<br />";
						}
						
					}
				}
				cdnDnsPod cdpod=new cdnDnsPod();
				cdpod.setId(id);
				cdpod.setIp(ip);
				cdpod.setTypeName(cdnType.get(num1).getTypeName());
				
				cdp.add(num2, cdpod);
				
				num2++;
			}
			System.out.println(cdp.size());
			Pages pages=cdnsaleorderbussiness.exHqlPages(hql11, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);//返回所有节点的结合
			request.setAttribute("cdnArea", cdnArea);//返回省份
			request.setAttribute("cdnType", cdnType);//返回线路
			request.setAttribute("cdp", cdp);//根据地域显示列表
			return "selectIpAreaType1";
		}
		
		/**
		 * 查询线路对应的ip节点
		 * 
		 */
		public void selectLikexianluIp()
		{
			String id=request.getParameter("id");
			String hql="from cdnPanelPoint where cdnTypeID.id="+Integer.parseInt(id)+" and del=0";
			List<cdnPanelPoint> cpp=realmtypebussiness.findObjectListByHQL(hql);
			
			String hql1="from cdnType where id="+Integer.parseInt(id)+" and del=0";
			List<cdnType> ct=realmtypebussiness.findObjectListByHQL(hql1);
			String cppId="";
			String cppIp="";
			for(int i=0;i<cpp.size();i++)
			{
				cppId+=cpp.get(i).getId()+",";
				if(cpp.get(i).getMark()==0)
				{
					cppIp+="<font color='green'>"+cpp.get(i).getPanelPointIp()+"</font><font color='red'> 端口："+cpp.get(i).getDuankou()+"</font>,";
					
						cppIp+="<br />";
					
					
				}
				else 
				{
					cppIp+="<font color='red'>"+cpp.get(i).getPanelPointIp()+"</font><font color='red'> 端口："+cpp.get(i).getDuankou()+"</font>,";
					
						cppIp+="<br />";
					
				}
			}
			
			String aa="<table width='100%' ><tr id='czl_tr' onmouseover=\"fs('czl_tr')\" onmouseout=\"lk('czl_tr')\" class='likai'>";
			aa+="<td width='5%'> </td><td style='font: 10pt;'  width='20%'>"+ct.get(0).getTypeName()+"</td>";
			aa+="<td style='font: 10pt;'  width='20%'>";
			if(cppIp.equals("")||cppIp==null)
			{
				aa+="该线路没有覆盖节点";
			}
			else
			{
				aa+=cppIp;
			}
			aa+="</td><td style='font: 10pt;'  width='25%'>红色该节点暂停<br />绿色该节点正在使用</td>";
			aa+="<td style='font: 10pt; text-align:center;'  width='30%'>";
			if(cpp.size()>0)
			{
			aa+="<a class='faq' title='停止该IP加速' href='javascript:void(0)' onclick=\"suspendIP('"+cppId+"')\">暂停</a>&nbsp;&nbsp;";
			aa+="<a class='faq' title='恢复该IP加速' href='javascript:coid(0)' onclick=\"resumeIP('"+cppId+"')\">恢复</a>&nbsp;&nbsp;";
			aa+="<a class='faq' title='去掉该加速节点IP' href='javascript:coid(0)' onclick=\"delIP('"+cppId+"')\">删除</a>";
			}
			else
			{
				aa+="该线路没有覆盖节点";
			}
			aa+="</td></tr></table>";
			
			response.setCharacterEncoding("UTF-8");
			try {
				response.getWriter().print(aa);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		/**
		 * 恢复节点
		 * @throws Exception 
		 */
		public void huifujiedianxianlu() throws Exception
		{
			String id1=request.getParameter("id");
			String[] id=id1.split(",");
			for(int j=0;j<id.length;j++)
			{
			String hql11="update cdnPanelPoint set mark=0 where id="+Integer.parseInt(id[j])+" ";
			int aa1=realmtypebussiness.updataByHQL(hql11);
				String hql1="from cdnRealmNameIP where cdnPanelPointID.id="+Integer.parseInt(id[j])+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
			for(int i=0;i<c.size();i++)
			{
				String hql="update cdnRealmNameIP set mark=0 where id="+c.get(i).getId()+" ";
				int aa=realmtypebussiness.updataByHQL(hql);
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
					//暂停
					String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
					
					Pattern patternId = Pattern.compile("<id>(.*?)</id>");
					Matcher matcherId = patternId.matcher(xml);
					
					List patternNameList=new ArrayList<String>();
					int num1=1;
					while (matcherId.find()) {
						patternNameList.add(num1-1, matcherId.group(num1));
						num1++;
						
					}
					
					Pattern patternName=Pattern.compile("<name>(.*?)</name>");
					Matcher matcherName=patternName.matcher(xml);
					
					List patternIdList=new ArrayList<String>();
					int num2=1;
					while (matcherName.find()) {
						patternIdList.add(num2-1, matcherName.group(num2));
						num2++;
						
					}
					String DNSPodId="";
					
					for(int ii=0;i<patternIdList.size();ii++)
					{
						if(patternIdList.get(ii).equals("fuao2008.com"))
						{
							DNSPodId=(String) patternNameList.get(ii);
							break;
						}
					}
					String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
					Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
					Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
				
					List<String> cuRealmNameIdList=new ArrayList<String>();
					int num3=1;
					while (cuRealmNameId.find()) {
						cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
						
					}
					
					
					
					Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
					Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
					
					List<String> cuRNvalue=new ArrayList<String>();
					int num5=1;
					while (cuRealmNameIP.find()) {
						cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
						
					}
					
					for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
					{
						if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
						{
							
								String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"enable");//如果域名下的IP是对的就进行删除
								System.out.println(aaa);
							
						}
					}
					
			}
			}
			response.getWriter().print("0");
		}
		/**
		 * 暂停节点
		 * @throws Exception 
		 */
		public void zhantingjiedianxianlu() throws Exception
		{
			String id1=request.getParameter("id");//获取要暂停的节点的ip
			
			String[] id=id1.split(",");
			for(int j=0;j<id.length;j++)
			{
			String hql11="update cdnPanelPoint set mark=2 where id="+Integer.parseInt(id[j])+" ";
			int aa1=realmtypebussiness.updataByHQL(hql11);
				String hql1="from cdnRealmNameIP where cdnPanelPointID.id="+Integer.parseInt(id[j])+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);//查询那些用到该节点的 并循环暂停
			for(int i=0;i<c.size();i++)
			{
				String hql="update cdnRealmNameIP set mark=2 where id="+c.get(i).getId()+" ";
				int aa=realmtypebussiness.updataByHQL(hql);
				
				
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
					//暂停
					String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
					
					Pattern patternId = Pattern.compile("<id>(.*?)</id>");
					Matcher matcherId = patternId.matcher(xml);
					
					List patternNameList=new ArrayList<String>();
					int num1=1;
					while (matcherId.find()) {
						patternNameList.add(num1-1, matcherId.group(num1));
						num1++;
						
					}
					
					Pattern patternName=Pattern.compile("<name>(.*?)</name>");
					Matcher matcherName=patternName.matcher(xml);
					
					List patternIdList=new ArrayList<String>();
					int num2=1;
					while (matcherName.find()) {
						patternIdList.add(num2-1, matcherName.group(num2));
						num2++;
						
					}
					String DNSPodId="";
					
					for(int ii=0;i<patternIdList.size();ii++)
					{
						if(patternIdList.get(ii).equals("fuao2008.com"))
						{
							DNSPodId=(String) patternNameList.get(ii);
							break;
						}
					}
					String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
					Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
					Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
				
					List<String> cuRealmNameIdList=new ArrayList<String>();
					int num3=1;
					while (cuRealmNameId.find()) {
						cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
						
					}
					
					
					
					Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
					Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
					
					List<String> cuRNvalue=new ArrayList<String>();
					int num5=1;
					while (cuRealmNameIP.find()) {
						cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
						
					}
					
					for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
					{
						if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
						{
							
								String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"disable");//如果域名下的IP是对的就进行删除
								System.out.println(aaa);
							
						}
					}
					
			}
			}
			response.getWriter().print("0");
		}
		
		/**
		 * 删除节点
		 */
		
		public  void deljidianxianlu() throws Exception
		{
			String id1=request.getParameter("id");
			String[] id=id1.split(",");
			for(int j=0;j<id.length;j++)
			{
				String hql="update cdnPanelPoint set del=1 where id="+Integer.parseInt(id[j])+"";
				int aa=realmtypebussiness.updataByHQL(hql);
				
				
			String hql1="from cdnRealmNameIP where cdnPanelPointID.id="+Integer.parseInt(id[j])+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);//查询那些用到该节点的 并循环暂停
			for(int i=0;i<c.size();i++)
			{
				//暂停
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int ii=0;i<patternIdList.size();ii++)
				{
					if(patternIdList.get(ii).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(ii);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						
						String aaa=dnsp.delDNSPod(DNSPodId,cuRealmNameIdList.get(q));//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						
					}
				}
				if(aa==0)
				{
					response.getWriter().print("0");
					return;
				}
				
			}
			}
			response.getWriter().print("1");
			
			
			
			
		}
		
		/**
		 * 恢复节点
		 * @throws Exception 
		 */
		public void huifujiedian() throws Exception
		{
			String id=request.getParameter("id");
			String hql11="update cdnPanelPoint set mark=0 where id="+Integer.parseInt(id)+" ";
			int aa1=realmtypebussiness.updataByHQL(hql11);
				String hql1="from cdnRealmNameIP where cdnPanelPointID.id="+Integer.parseInt(id)+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);
			for(int i=0;i<c.size();i++)
			{
				String hql="update cdnRealmNameIP set mark=0 where id="+c.get(i).getId()+" ";
				int aa=realmtypebussiness.updataByHQL(hql);
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
					//暂停
					String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
					
					Pattern patternId = Pattern.compile("<id>(.*?)</id>");
					Matcher matcherId = patternId.matcher(xml);
					
					List patternNameList=new ArrayList<String>();
					int num1=1;
					while (matcherId.find()) {
						patternNameList.add(num1-1, matcherId.group(num1));
						num1++;
						
					}
					
					Pattern patternName=Pattern.compile("<name>(.*?)</name>");
					Matcher matcherName=patternName.matcher(xml);
					
					List patternIdList=new ArrayList<String>();
					int num2=1;
					while (matcherName.find()) {
						patternIdList.add(num2-1, matcherName.group(num2));
						num2++;
						
					}
					String DNSPodId="";
					
					for(int ii=0;i<patternIdList.size();ii++)
					{
						if(patternIdList.get(ii).equals("fuao2008.com"))
						{
							DNSPodId=(String) patternNameList.get(ii);
							break;
						}
					}
					String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
					Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
					Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
				
					List<String> cuRealmNameIdList=new ArrayList<String>();
					int num3=1;
					while (cuRealmNameId.find()) {
						cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
						
					}
					
					
					
					Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
					Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
					
					List<String> cuRNvalue=new ArrayList<String>();
					int num5=1;
					while (cuRealmNameIP.find()) {
						cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
						
					}
					
					for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
					{
						if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
						{
							
								String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"enable");//如果域名下的IP是对的就进行删除
								System.out.println(aaa);
							
						}
					}
					
			}
			response.getWriter().print("0");
		}
		/**
		 * 暂停节点
		 * @throws Exception 
		 */
		public void zhantingjiedian() throws Exception
		{
			String id=request.getParameter("id");//获取要暂停的节点的ip
			String hql11="update cdnPanelPoint set mark=2 where id="+Integer.parseInt(id)+" ";
			int aa1=realmtypebussiness.updataByHQL(hql11);
				String hql1="from cdnRealmNameIP where cdnPanelPointID.id="+Integer.parseInt(id)+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);//查询那些用到该节点的 并循环暂停
			for(int i=0;i<c.size();i++)
			{
				String hql="update cdnRealmNameIP set mark=2 where id="+c.get(i).getId()+" ";
				int aa=realmtypebussiness.updataByHQL(hql);
				
				
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
					//暂停
					String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
					
					Pattern patternId = Pattern.compile("<id>(.*?)</id>");
					Matcher matcherId = patternId.matcher(xml);
					
					List patternNameList=new ArrayList<String>();
					int num1=1;
					while (matcherId.find()) {
						patternNameList.add(num1-1, matcherId.group(num1));
						num1++;
						
					}
					
					Pattern patternName=Pattern.compile("<name>(.*?)</name>");
					Matcher matcherName=patternName.matcher(xml);
					
					List patternIdList=new ArrayList<String>();
					int num2=1;
					while (matcherName.find()) {
						patternIdList.add(num2-1, matcherName.group(num2));
						num2++;
						
					}
					String DNSPodId="";
					
					for(int ii=0;i<patternIdList.size();ii++)
					{
						if(patternIdList.get(ii).equals("fuao2008.com"))
						{
							DNSPodId=(String) patternNameList.get(ii);
							break;
						}
					}
					String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
					Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
					Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
				
					List<String> cuRealmNameIdList=new ArrayList<String>();
					int num3=1;
					while (cuRealmNameId.find()) {
						cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
						
					}
					
					
					
					Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
					Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
					
					List<String> cuRNvalue=new ArrayList<String>();
					int num5=1;
					while (cuRealmNameIP.find()) {
						cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
						
					}
					
					for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
					{
						if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
						{
							
								String aaa=dnsp.updateDNSPod(DNSPodId,cuRealmNameIdList.get(q),"disable");//如果域名下的IP是对的就进行删除
								System.out.println(aaa);
							
						}
					}
					
			}
			response.getWriter().print("0");
		}
		
		/**
		 * 删除节点
		 */
		
		public  void deljidian() throws Exception
		{
			String id=request.getParameter("id");
			String hql1="from cdnRealmNameIP where cdnPanelPoint.id="+Integer.parseInt(id)+" ";
			List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);//查询那些用到该节点的 并循环暂停
			for(int i=0;i<c.size();i++)
			{
				
				int aa=realmtypebussiness.delObject(c.get(i));
				//暂停
				String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
				
				Pattern patternId = Pattern.compile("<id>(.*?)</id>");
				Matcher matcherId = patternId.matcher(xml);
				
				List patternNameList=new ArrayList<String>();
				int num1=1;
				while (matcherId.find()) {
					patternNameList.add(num1-1, matcherId.group(num1));
					num1++;
					
				}
				
				Pattern patternName=Pattern.compile("<name>(.*?)</name>");
				Matcher matcherName=patternName.matcher(xml);
				
				List patternIdList=new ArrayList<String>();
				int num2=1;
				while (matcherName.find()) {
					patternIdList.add(num2-1, matcherName.group(num2));
					num2++;
					
				}
				String DNSPodId="";
				
				for(int ii=0;i<patternIdList.size();ii++)
				{
					if(patternIdList.get(ii).equals("fuao2008.com"))
					{
						DNSPodId=(String) patternNameList.get(ii);
						break;
					}
				}
				String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
				Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
				Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
			
				List<String> cuRealmNameIdList=new ArrayList<String>();
				int num3=1;
				while (cuRealmNameId.find()) {
					cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
					
				}
				
				
				
				Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
				Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
				
				List<String> cuRNvalue=new ArrayList<String>();
				int num5=1;
				while (cuRealmNameIP.find()) {
					cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
					
				}
				
				for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
				{
					if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
					{
						
						String aaa=dnsp.delDNSPod(DNSPodId,cuRealmNameIdList.get(q));//如果域名下的IP是对的就进行删除
							System.out.println(aaa);
						
					}
				}
				if(aa==0)
				{
					response.getWriter().print("1");
					return;
				}
				
			}
			response.getWriter().print("0");
			
			
			
			
		}
		
		/**
		 * 删除节点  dnspod上面的所有数据都删除
		 * @throws IOException
		 */
		public void delIpAreaType() throws Exception
		{
			String id=request.getParameter("id");//获取ID
			String hql="update cdnPanelPoint set del=1 where id="+Integer.parseInt(id)+"";
			int aa=realmtypebussiness.updataByHQL(hql);
			if(aa>0)
			{
				response.getWriter().print("1");//删除成功返回1
				
				String hql1="from cdnRealmNameIP where cdnPanelPointID.id="+Integer.parseInt(id)+" ";
				List<cdnRealmNameIP> c=realmtypebussiness.findObjectListByHQL(hql1);//查询那些用到该节点的 并循环暂停
				for(int i=0;i<c.size();i++)
				{
					//暂停
					String xml=dnsp.selectUserDNSPod("yanyinhua@fuaotech.com","utemyan");//获取ID
					
					Pattern patternId = Pattern.compile("<id>(.*?)</id>");
					Matcher matcherId = patternId.matcher(xml);
					
					List patternNameList=new ArrayList<String>();
					int num1=1;
					while (matcherId.find()) {
						patternNameList.add(num1-1, matcherId.group(num1));
						num1++;
						
					}
					
					Pattern patternName=Pattern.compile("<name>(.*?)</name>");
					Matcher matcherName=patternName.matcher(xml);
					
					List patternIdList=new ArrayList<String>();
					int num2=1;
					while (matcherName.find()) {
						patternIdList.add(num2-1, matcherName.group(num2));
						num2++;
						
					}
					String DNSPodId="";
					
					for(int ii=0;i<patternIdList.size();ii++)
					{
						if(patternIdList.get(ii).equals("fuao2008.com"))
						{
							DNSPodId=(String) patternNameList.get(ii);
							break;
						}
					}
					String customerIP=dnsp.selectSubDomainDNSPod(DNSPodId, c.get(i).getCuRealmName());//获取返回过来的IPId
					Pattern cuRNId=Pattern.compile("<id>(.*?)</id>");
					Matcher cuRealmNameId=cuRNId.matcher(customerIP);//获取客户域名的Id
				
					List<String> cuRealmNameIdList=new ArrayList<String>();
					int num3=1;
					while (cuRealmNameId.find()) {
						cuRealmNameIdList.add(num3-1,cuRealmNameId.group(num3));
						
					}
					
					
					
					Pattern cuRNIp=Pattern.compile("<value>(.*?)</value>");
					Matcher cuRealmNameIP=cuRNIp.matcher(customerIP);//获取客户域名的IP
					
					List<String> cuRNvalue=new ArrayList<String>();
					int num5=1;
					while (cuRealmNameIP.find()) {
						cuRNvalue.add(num5-1,cuRealmNameIP.group(num5));
						
					}
					
					for(int q=0;q<cuRNvalue.size();q++)//循环域名对应的ip
					{
						if(cuRNvalue.get(q).equals(c.get(i).getCdnPanelPointID().getPanelPointIp()))//判断要删除的IP在dnspod里面是否存在
						{
							
							String aaa=dnsp.delDNSPod(DNSPodId,cuRealmNameIdList.get(q));//如果域名下的IP是对的就进行删除
								System.out.println(aaa);
							
						}
					}
				}	
			}
			else
			{
				response.getWriter().print("0");//删除失败返回0
			}
		}
		/**
		 * 添加节点管理
		 * @throws IOException 
		 */
		public String addIpAreaType() throws IOException
		{
			
			String areaId=request.getParameter("province");//获取省份的ID可以没有 
			String typeName=request.getParameter("typeName");//获取线路的ID  
			
			String panelPointIp=request.getParameter("ip");//获取节点
			String address=request.getParameter("address");//获取机房位置
			String duankou=request.getParameter("duankou");//获取端口
			
			
			String hql="from cdnArea where id="+Integer.parseInt(areaId)+" and del=0 ";
			List<cdnArea> caList=realmtypebussiness.findObjectListByHQL(hql);//根据ID查询省份
			
			String hql1="from cdnType where id="+Integer.parseInt(typeName)+" and del=0";
			List<cdnType> ctList=realmtypebussiness.findObjectListByHQL(hql1);//根据ID查询显线路
			if(caList.size()>0&&ctList.size()>0)
			{
			cdnPanelPoint cp= new cdnPanelPoint();
			cp.setAddress(address);
			cp.setCdnAreaID(caList.get(0));
			cp.setCdnTypeID(ctList.get(0));
			cp.setMark(0);
			cp.setDel(0);
			cp.setPanelPointIp(panelPointIp);
			cp.setDuankou(Integer.parseInt(duankou));
			Object objest=realmtypebussiness.addObject(cp);
			}
			return "addipAreaType";
			
			
			
		}
		public String addIpAreaType1() throws IOException
		{
			
			String areaId=request.getParameter("province");//获取省份的ID可以没有 
			String typeName=request.getParameter("typeName");//获取线路的ID  
			
			String panelPointIp=request.getParameter("ip");//获取节点
			String address=request.getParameter("address");//获取机房位置
			String duankou=request.getParameter("duankou");//获取端口
			
			String hql="from cdnArea where id="+Integer.parseInt(areaId)+" and del=0 ";
			List<cdnArea> caList=realmtypebussiness.findObjectListByHQL(hql);//根据ID查询省份
			
			String hql1="from cdnType where id="+Integer.parseInt(typeName)+" and del=0";
			List<cdnType> ctList=realmtypebussiness.findObjectListByHQL(hql1);//根据ID查询显线路
			if(caList.size()>0&&ctList.size()>0)
			{
			cdnPanelPoint cp= new cdnPanelPoint();
			cp.setAddress(address);
			cp.setCdnAreaID(caList.get(0));
			cp.setCdnTypeID(ctList.get(0));
			cp.setMark(0);
			cp.setDel(0);
			cp.setPanelPointIp(panelPointIp);
			cp.setDuankou(Integer.parseInt(duankou));
			
			Object objest=realmtypebussiness.addObject(cp);
			}
			return "addipAreaType1";
			
			
			
		}
		/**
		 * 判断ip是否存在
		 * @throws IOException 
		 */
		public void isokIp() throws IOException
		{
			String ip=request.getParameter("ip");//获取需要判断的ip
			String hql="from cdnPanelPoint where  panelPointIp='"+ip+"'and  del=0 and mark=0";
			
			List<cdnPanelPoint> cpp= realmtypebussiness.findObjectListByHQL(hql);
			if(cpp.size()>0)
			{
				response.getWriter().print("1");//返回1表示数据存在
			}
			else
			{
				response.getWriter().print("0");//返回0表示数据不存在可以添加
			}
			
		}
		/**
		 * 模糊查询节点
		 */
		public void selectLikeIp()
		{
			String ip=request.getParameter("ip");//获取传过来的值
			String hql="from cdnPanelPoint where  panelPointIp like '%"+ip+"%'  and  del=0 ";
			String aa="<table width='100%'>";
			List<cdnPanelPoint> cpp= realmtypebussiness.findObjectListByHQL(hql);
			if(cpp.size()>25){
				for(int i=25;i<cpp.size();i++)
				{
					cpp.remove(i);
				}
			}
			if(cpp.size()>0)
			{
				
				for(int i=0;i<cpp.size();i++)
				{
					aa+="<tr id='czl_tr"+i+"' onmouseover=\"fs('czl_tr"+i+"')\" onmouseout=\"lk('czl_tr"+i+"')\" class='likai'>";
					aa+="<td width='5%'> </td><td style='font: 10pt;'  width='15%'>"+cpp.get(i).getPanelPointIp()+"<font color='red'> 端口："+cpp.get(i).getDuankou()+"</font></td>";
					aa+="<td style='font: 10pt;'  width='15%'>";
					if(cpp.get(i).getCdnAreaID().getId()==1)
					{
						aa+=cpp.get(i).getCdnTypeID().getTypeName();
					}
					else
					{
						aa+=cpp.get(i).getCdnAreaID().getProvince()+"   "+cpp.get(i).getCdnTypeID().getTypeName();
					}
					aa+="</td><td style='font: 10pt;'  width='20%'>"+cpp.get(i).getAddress()+"</td>";
					aa+="<td  width='15%'>";
					if(cpp.get(i).getMark()==0)
					{
						aa+="正常使用";
					}
					else
					{
						aa+="该节点已暂停";
					}
					aa+="</td>	<td style='font: 10pt; text-align:center;'  width='30%'>";
					if(cpp.get(i).getMark()==0)
					{
						aa+="<a class='faq' title='暂停该IP加速' href='javascript:void(0)' onclick='suspendIP("+cpp.get(i).getId()+")'>暂停</a>　　";
					}
					else
					{
						aa+="<a class='faq' title='恢复该IP加速' href='javascript:void(0)' onclick='resumeIP("+cpp.get(i).getId()+")'>恢复</a>　　";
					}
					aa+="<a class='faq' title='去掉该加速节点IP' onclick='delIP("+cpp.get(i).getId()+")'>删除</a></td></tr>";
					
				}
			}
			aa+="</table>";
			response.setCharacterEncoding("UTF-8");
			try {
				response.getWriter().print(aa);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//得到前面25条数据        
			
		}

		/**
		 *
		 * 添加cdn订单的显示页面
		 * @throws IOException 
		 * **/
		public String showOrderadd1() throws IOException
		{
			
//			Customer customer=(Customer) request.getSession().getAttribute("customer");
//		
//			System.out.println(customer.getCustomerId());
//			Customer co=(Customer)realmtypebussiness.findObjectListByHQL("from Customer where customerId="+customer.getCustomerId()).get(0);
//			if(co.getCustomerName()==null||co.getCustomerName().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getCardid()==null||co.getCardid().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getZipCode()==null||co.getZipCode().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getMobilePhone()==null||co.getMobilePhone().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			
//			if(co.getEmail()==null||co.getEmail().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getCustomerAddress()==null||co.getCustomerAddress().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			System.out.println(co.getCustomerName());
			
			//显示类型，如静态，动态，等(RealmType)
			String hql=" from RealmType where delflag=0 ";
			List realmtypelist=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("realmtypelist", realmtypelist);
			//显示大地址
			FindXMLMake xml=new FindXMLMake();
			String path ="/xml/DistrictAddress.xml";	
			List<String> disname=xml.ReadDistrictAddress1(path);
			request.setAttribute("disname", disname);
			return "showorderadd1";
		}
		
		/**
		 *
		 * 添加cdn订单的显示页面
		 * @throws IOException 
		 * **/
		public String showOrderadd() throws IOException
		{
			
			Customer customer=(Customer) request.getSession().getAttribute("customer");
		
			System.out.println(customer.getCustomerId());
			Customer co=(Customer)realmtypebussiness.findObjectListByHQL("from Customer where customerId="+customer.getCustomerId()).get(0);
			if(co.getCustomerName()==null||co.getCustomerName().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
			if(co.getCardid()==null||co.getCardid().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
			if(co.getZipCode()==null||co.getZipCode().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
			if(co.getMobilePhone()==null||co.getMobilePhone().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
			
			if(co.getEmail()==null||co.getEmail().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
			if(co.getCustomerAddress()==null||co.getCustomerAddress().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
			System.out.println(co.getCustomerName());
			
			//显示类型，如静态，动态，等(RealmType)
			String hql=" from RealmType where delflag=0 ";
			List realmtypelist=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("realmtypelist", realmtypelist);
			//显示大地址
			FindXMLMake xml=new FindXMLMake();
			String path ="/xml/DistrictAddress.xml";	
			List<String> disname=xml.ReadDistrictAddress1(path);
			request.setAttribute("disname", disname);
			return "showorderadd";
		}
		/**
		 *
		 * 添加cdn订单的显示页面-litscouod
		 * @throws IOException 
		 * **/
		public String showOrderadd3() throws IOException
		{
			
			Customer customer=(Customer) request.getSession().getAttribute("customer");
		
			System.out.println(customer.getCustomerId());
			Customer co=(Customer)realmtypebussiness.findObjectListByHQL("from Customer where customerId="+customer.getCustomerId()).get(0);
			if(co.getCustomerName()==null||co.getCustomerName().equals(""))
			{
				request.setAttribute("biaoshi","1");
				return "myData";
			}
//			if(co.getCardid()==null||co.getCardid().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getZipCode()==null||co.getZipCode().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getMobilePhone()==null||co.getMobilePhone().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			
//			if(co.getEmail()==null||co.getEmail().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
//			if(co.getCustomerAddress()==null||co.getCustomerAddress().equals(""))
//			{
//				request.setAttribute("biaoshi","1");
//				return "myData";
//			}
			System.out.println(co.getCustomerName());
			
			//显示类型，如静态，动态，等(RealmType)
			String hql=" from RealmType where delflag=0 ";
			List realmtypelist=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("realmtypelist", realmtypelist);
			//显示大地址
			FindXMLMake xml=new FindXMLMake();
			String path ="/xml/DistrictAddress.xml";	
			path = CDNsaleOrderAction.class.getResource("/xml/DistrictAddress.xml").getPath();
			path =path.replace("%20", " ");
			List<String> disname=xml.ReadDistrictAddress1(path);
			request.setAttribute("disname", disname);
			return "litsshoworderadd";
		}
		/**
		 * 取得页面传来的大地址，根据大地址，取得所对应的小地址
		 * **/
		public String getsmAddress()
		{
			response.setCharacterEncoding("UTF-8");
			String path = "/xml/DistrictAddress.xml";
			String getname=request.getParameter("dat");
			try {
				getname = URLDecoder.decode(getname, "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
			FindXMLMake xml=new FindXMLMake();
			String str=xml.ReadDistrictAddress2(path,getname);
			try {
				String sa[]=str.split(",");
				StringBuffer s=new StringBuffer();
				for(int i=0;i<sa.length;i++)
					s.append("<option value='"+sa[i]+"'>"+sa[i]+"</option>");
				
				response.getWriter().print(s.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		/**
		 * 添加CDN订单
		 * **/
		public String Orderadd()
		{
			Object ob=request.getSession().getAttribute("customer");
			Customer customer=null;
			if(ob!=null)
				customer=(Customer)ob;
			else{
				///不是客户登录，没有客户信息
			}
			FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
			String no=serial.getSerialNumber();
			cdnsaleorder.setSaleOrderNo("CDN"+no); //订单编号
			cdnsaleorder.setCustomer(customer); //客户
												//没有接收人（员工）
			SetMeal setmeal=null;    //套餐
			String setmealId=request.getParameter("setmealId");
			
			
			cdnsaleorder.setAuditingState("1");//设置审核状态
			
			///保存域名/订单
			cdnsaleorder=cdnsaleorderbussiness.addCDNsaleOrder(cdnsaleorder);
			
			////获得缓存规则，并存储
			for(int i=1;;i++)
			{
				String cacheflag=request.getParameter("cacheflag"+i);
				if(cacheflag==null||"0".equals(cacheflag))
					break;
				String cachecontent=request.getParameter("cachecontent"+i);
				String contentTime=request.getParameter("contentTime"+i);
				String timetype=request.getParameter("timetype"+i);
				Cache ca=new Cache();
				///有没有模板  Type  ?  没有？？
				ca.setType(null);      //找
//				ca.setTypeName(null);  //找
//				ca.setCacheflag(cacheflag);
				ca.setCachecontent(cachecontent);
				String ty="";
				if("0".equals(timetype))ty="n";///没有选择时间类型
				if("1".equals(timetype))ty="h";//小时
				if("2".equals(timetype))ty="d";//天
				if("3".equals(timetype))ty="m";//月
//				ca.setContentTime(contentTime+ty);
//				ca.setSsosyRealmName(null); ///找
				ca.setDelflag(0);
				
				//保存缓存规则
				cachebussiness.addCache(ca);
			}
			
			///获得区域表，并存储
			for(int i=1;;i++)
			{
				String tmoblie=request.getParameter("tmoblie"+i);///运营商
				if(tmoblie==null||"".equals(tmoblie))
					break;
				String districtName=request.getParameter("districtName"+i);//大地区
				String smdisName=request.getParameter("smdisName"+i);//小地区
				String IP=request.getParameter("IP"+i);
				
				District district=new District();
				district.setDelflag(0);
				district.setTmoblie(tmoblie);
				district.setDistrictName(districtName);
				district.setIp(IP);
				//保存区域表，回源IP
				districtbussiness.addDistrict(district);
			}
			
			
			//跳到订单域名列表去
			return "reallist";
		}
		
		public String taocan() throws IOException
		{
			String taocanType=request.getParameter("taocan");
			String yumingType=request.getParameter("yuming");
			int yuming=Integer.parseInt(yumingType);
		
			String hql="from SetMeal where delFlag=0 and  realmtype.id="+yuming+" and chargeType='"+taocanType+"'";
			List<SetMeal> SM=realmtypebussiness.findObjectListByHQL(hql);
			String aa="";
			if(SM.size()>0)
			{
				for(int i=0;i<SM.size();i++)
				{
				SetMeal setMeal=SM.get(i);
				
				//String type=setMeal.getRealmtype().getName()+","+setMeal.getStarttime()+","+
				//			setMeal.getEndtime()+","+setMeal.getDescribe()+","+setMeal.getChargeType()+","+
				//			setMeal.getPayprice()+","+setMeal.getPrice();
				//System.out.println(setMeal.getRealmtype());
				
				
				aa+="<tr id='tr"+setMeal.getId()+"'><TD  width='10%' id='td1' class=category>"+setMeal.getName()+"</TD>"
				+"<TD  width='10%'id='td2' class=category>"+setMeal.getRealmtype().getName()+"</TD>"
				+"<TD with='1%' id='td3' class=category>"+setMeal.getStarttime()+"</TD>"
				+"<TD with='1%' id='td4' class=category>"+setMeal.getEndtime()+"</TD>"	
				+"<td with='25%' id='td5' class=category>"+setMeal.getDescribe()+"</td>"
				+"<TD with='10%' id='td6' class=category>"+setMeal.getUsetime()+"</TD>"
				+"<TD with='10%' id='td7' class=category>"+setMeal.getPayprice()+"</TD>"
				+"<TD with='10%' id='td8' class=category>"+setMeal.getPrice()+"</TD>"
				+"<td with='5%' id='td9' ><input id='' name='a'  type='radio' value="+setMeal.getId()+" /><td></tr>";
				
			}
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(aa);
			}
			else{
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print("<tr align='center' id='taocanNo'><td colspan='9'><input id='taocanId' type='hidden' name='' value='aa'/>没有此类型的套餐请重新选择！！！<td></tr>");
			}
			return null;
		}
		/**
		 * taocan litscloud
		 * @return
		 * @throws IOException
		 */
		public String taocan3() throws IOException
		{
			String taocanType=request.getParameter("taocan");
			String yumingType=request.getParameter("yuming");
			int yuming=Integer.parseInt(yumingType);
		
			String hql="from SetMeal where delFlag=0 and  realmtype.id="+yuming+" and chargeType='"+taocanType+"'";
			List<SetMeal> SM=realmtypebussiness.findObjectListByHQL(hql);
			String aa="";
			String bb="";
			if(SM.size()>0)
			{
				for(int i=0;i<SM.size();i++)
				{
				SetMeal setMeal=SM.get(i);
				
				//String type=setMeal.getRealmtype().getName()+","+setMeal.getStarttime()+","+
				//			setMeal.getEndtime()+","+setMeal.getDescribe()+","+setMeal.getChargeType()+","+
				//			setMeal.getPayprice()+","+setMeal.getPrice();
				//System.out.println(setMeal.getRealmtype());
				if(setMeal.getDescribe() == null)setMeal.setDescribe("");
					
				bb+="<tr id='tr"+setMeal.getId()+"'><td class='dcn_td dcn_tcen'>"+setMeal.getName()+"</td><td class='dcn_td dcn_tcen'>"+setMeal.getRealmtype().getName()+"</td><td class='dcn_td dcn_tcen'>"+setMeal.getStarttime()+"</td><td class='dcn_td dcn_tcen'>"+setMeal.getEndtime()+"</td>" +
						"<td class='dcn_td dcn_tcen'>"+setMeal.getDescribe()+"</td><td class='dcn_td dcn_tcen'>"+setMeal.getUsetime()+"</td><td class='dcn_td dcn_tcen'>"+setMeal.getPayprice()+"</td><td class='dcn_td dcn_tcen'>"+setMeal.getPrice()+"</td><td class='dcn_td dcn_tcen'><input id='' name='a'  type='radio' value="+setMeal.getId()+" /></td></tr>";
//				aa+="<tr id='tr"+setMeal.getId()+"'><TD  width='10%' id='td1' class=category>"+setMeal.getName()+"</TD>"
//				+"<TD  width='10%'id='td2' class=category>"+setMeal.getRealmtype().getName()+"</TD>"
//				+"<TD with='1%' id='td3' class=category>"+setMeal.getStarttime()+"</TD>"
//				+"<TD with='1%' id='td4' class=category>"+setMeal.getEndtime()+"</TD>"	
//				+"<td with='25%' id='td5' class=category>"+setMeal.getDescribe()+"</td>"
//				+"<TD with='10%' id='td6' class=category>"+setMeal.getUsetime()+"</TD>"
//				+"<TD with='10%' id='td7' class=category>"+setMeal.getPayprice()+"</TD>"
//				+"<TD with='10%' id='td8' class=category>"+setMeal.getPrice()+"</TD>"
//				+"<td with='5%' id='td9' ><input id='' name='a'  type='radio' value="+setMeal.getId()+" /><td></tr>";
				
			}
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.getWriter().print(bb);
			}
			else{
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print("<tr align='center' id='taocanNo'><td colspan='9'><input id='taocanId' type='hidden' name='' value='aa'/>没有此类型的套餐请重新选择！！！<td></tr>");
			}
			return null;
		}
		
		/*
		 * 添加CDN
		 */
		public String addtaocan() throws IOException{
			
			
			request.setCharacterEncoding("utf-8");
			String cuRealmName=request.getParameter("cuRealmName");//客户的域名
			String taocanId=request.getParameter("taocanId");//套餐ID
			String switchOpen=request.getParameter("switchOpen");//是否开启网站
			String huancun=request.getParameter("huancun");//是否缓存
			String test1=request.getParameter("test");//缓存内容
			String time=request.getParameter("time");//缓存时间
			String timedanwei=request.getParameter("timedanwei");//缓存单位
			String oper=request.getParameter("operator");//运营商
			String daddress=request.getParameter("daaddress");//大地址
			String huiyuan=request.getParameter("huiyuan");//回源
			
			String address=request.getParameter("address");//国内或者国外加速
			String beianhao=request.getParameter("beianhao");//备案号
			

			String IPqujian1=request.getParameter("IPqujian");//IP区间数
			String PVqujian1=request.getParameter("PVqujian");//PV区间数
			String fujiandaxiao1=request.getParameter("fujiandaxiao");//附件平均大小
			String wenjiandaxiao1=request.getParameter("wenjiandaxiao");//多数文件大小
			
			String IPqujian = URLDecoder.decode(IPqujian1, "UTF-8");
			String PVqujian = URLDecoder.decode(PVqujian1, "UTF-8");
			String fujiandaxiao = URLDecoder.decode(fujiandaxiao1, "UTF-8");
			String wenjiandaxiao = URLDecoder.decode(wenjiandaxiao1, "UTF-8");
			
			String address1 = URLDecoder.decode(address, "UTF-8");
			String beianhao1 = URLDecoder.decode(beianhao, "UTF-8");
			
			String test = URLDecoder.decode(test1, "UTF-8");
			String daaddress = URLDecoder.decode(daddress, "UTF-8");
			String operator = URLDecoder.decode(oper, "UTF-8");
			String ip=request.getParameter("IP");//ip
			String yunyingshang=request.getParameter("yunyingshang");//运营商
			String ipdizhi=request.getParameter("IPaddress");//ip地址
			String duankou=request.getParameter("duankou");//端口
			
			String ip1 = URLDecoder.decode(ip, "UTF-8");
			String yys = URLDecoder.decode(yunyingshang, "UTF-8");
			String ipdz = URLDecoder.decode(ipdizhi, "UTF-8");
			boolean flag1=false;
			boolean flag2=false;
			boolean flag3=false;
			
			Object ob=request.getSession().getAttribute("customer");
			Customer customer=null;
			if(ob!=null)
				customer=(Customer)ob;
			else{
			}
			
			List<CDNsaleOrder> CDNso=realmtypebussiness.findObjectListByHQL(" from CDNsaleOrder where delflag=0  and  customer.customerId="+customer.getCustomerId());
			if(CDNso.size()>0)
			{
				for(int i=0;i<CDNso.size();i++)
				{
					if(CDNso.get(i).getCuRealmName().equals(cuRealmName))
					{
						response.getWriter().print("0");
						return null;
					}
				}
			}
			CDNsaleOrder cdn=new CDNsaleOrder();
			FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
			
				if(customer.getCustomerId()!=null)
				{
					String hql=" from CDNsaleOrder where  delFlag=0 and setmeal.id="+taocanId+" and customer.customerId="+customer.getCustomerId();
					List<CDNsaleOrder> cdnlist=realmtypebussiness.findObjectListByHQL(hql);
					
					for(int i=0;i<cdnlist.size();i++)
					{
						
						System.out.println(cdnlist.get(i).getSetmeal().getId());
						String hql1=" from SetMeal where  delFlag=0 and id="+cdnlist.get(i).getSetmeal().getId();
						SetMeal st=(SetMeal) realmtypebussiness.findObjectListByHQL(hql1).get(0);
						System.out.println(st.getId());
						if(st.getChargeType().equals("0"))
						{
							response.getWriter().print("3");
							return null;
						}
						if(st.getChargeType().equals("1"))
						{
							response.getWriter().print("4");
							return null;
						}
					}
				}
				String no=serial.getSerialNumber();
				
				String hql="from SetMeal where id="+taocanId+"";
				SetMeal setMeal=(SetMeal) realmtypebussiness.findObjectListByHQL(hql).get(0);
				
				java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
				Date now = new Date();
				String strDate = dateFormat.format(now);//当前日期
				
				
				cdn.setSaleOrderNo("CDN"+no); 
				cdn.setCustomer(customer);
				cdn.setSetmeal(setMeal);
				cdn.setTime(strDate);
				cdn.setCuRealmName(cuRealmName);
				cdn.setServerFlag(switchOpen);
			//	cdn.setAuditingState("0");
				cdn.setDelFlag("0");
				cdn.setRecordsNO(beianhao1);
//				cdn.setIP(IP);
//				cdn.setIPAddress(IPaddress1);
				cdn.setIPinterval(IPqujian);
				cdn.setPVinterval(PVqujian);
				cdn.setAccessoryfile(fujiandaxiao);
				cdn.setMostfile(wenjiandaxiao);
				cdn.setWriteflag(0);
				String hqll="from Docmark where mark='CDN'";
				List<Docmark> doc=realmtypebussiness.findObjectListByHQL(hqll);
				if(doc!=null){
					String hqlll="from VerifyOrder where ordertype="+doc.get(0).getId()+"";
					List<VerifyOrder> vorder=realmtypebussiness.findObjectListByHQL(hqlll);
					if(vorder.size()==0)
					{
						cdn.setAuditingState("1");
					}
					else
					{
						cdn.setAuditingState("0");
					}
				}
				else{
					cdn.setAuditingState("1");
				}
			CDNsaleOrder cso=(CDNsaleOrder) realmtypebussiness.addObject(cdn);	
				if(cso!=null)
					flag1=true;
				else
				{
					flag1=false;
					response.getWriter().print("2");
					return null;
				}
				if(cso!=null)
				{
					String[] ipip=ip1.split("/");
					String[] yys1=yys.split(",");
					String[] ipdiz=ipdz.split("/");
					String[] duank=duankou.split("/");
					for(int i=0;i<ipip.length;i++)
					{
						CDNip cdnip=new CDNip();
						cdnip.setDelflag(0);
						cdnip.setIp(ipip[i]);
						cdnip.setAddress(ipdiz[i]);
						cdnip.setTmoblie(yys1[i]);
						cdnip.setPort(duank[i]);
						cdnip.setCDNsaleorder(cso);
						CDNip Cdnip=(CDNip) realmtypebussiness.addObject(cdnip);
						if(Cdnip!=null)
							flag2=true;
						else
						{
							flag2=false;
							response.getWriter().print("2");
							return null;
						}
					}
					
					String[] hc=huancun.split(",");
					String[] t=test.split(",");
					String[] tm=time.split(",");
					String[] hcdw=timedanwei.split(",");
					for(int i=0;i<hc.length;i++)
					{
						
						
						Cache ch=new Cache();
						String ContentTime="";
						if(hcdw[i].equals("h"))
						{
							ContentTime=tm[i]+"h";
						}
						if(hcdw[i].equals("d"))
						{
							ContentTime=tm[i]+"d";
						}
						if(hcdw[i].equals("m"))
						{
							ContentTime=tm[i]+"m";
						}
						if(hc[i]!=null&&(hc[i].equals("")==false)){
							ch.setCacheflag(Integer.parseInt(hc[i]));
							ch.setCachecontent(t[i]);
							ch.setContentime(ContentTime);
//							ch.setSsosyRealmName(cuRealmName);
							ch.setDelflag(0);
							ch.setCDNsaleorder(cso);
							Cache cache=(Cache) realmtypebussiness.addObject(ch);	
							if(cache!=null)
								flag2=true;
							else
							{
								flag2=false;
								response.getWriter().print("2");
								return null;
							}
							
						}
					
					}
					String[] o=operator.split(",");
					String[] da=daaddress.split(",");
					String[] hyIP=huiyuan.split(",");
					
					
					for(int i=0;i<o.length;i++)
					{
						if(o[i]!=null&&(o[i].equals("")==false))
						{
							District district=new District();
//							district.setCdnsaleorder(cdn);
							district.setTmoblie(o[i]);
							district.setDistrictName(da[i]);
							district.setIp(hyIP[i]);
							district.setDelflag(0);
							district.setCDNsaleorder(cso);
							District d=(District)realmtypebussiness.addObject(district);
							if(d!=null)
								flag3=true;
							else
							{
								flag3=false;
								response.getWriter().print("2");
								return null;
							}
						}
					}
					
				}
				int aa=audBussiness.addAuditingOrder2("CDN",cso.getSaleOrderNo(),"CDNsaleOrder",customer.getCustomerId().toString());//添加审核流程
				System.out.println(aa);
				
				if(flag1)
				{
					
				}
				else
				{
					response.getWriter().print("2");
					return null;
				}

		        response.getWriter().print("1");
			return null;
		}
		/**
		 * 显示cdn订单列表-litscloud
		 * */
		public String showcdnlist3()
		{
			Object obj=request.getSession().getAttribute("customer");
			if(obj==null)
			{
				return "no";
			}
			Customer cus=(Customer)obj;
			String hql=" from CDNsaleOrder where  delFlag=0 and customer.customerId="+cus.getCustomerId()+" order by id desc ";
//			List<CDNsaleOrder> cdnlist=realmtypebussiness.findObjectListByHQL(hql);
//			request.setAttribute("cdnlist", cdnlist);
			
			String pageNo=request.getParameter("pageNo");
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			Pages pages=cdnsaleorderbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			
			return "litsshowcdnlist";
		}
		
		/**
		 * 显示cdn订单列表
		 * */
		public String showcdnlist()
		{
			Object obj=request.getSession().getAttribute("customer");
			if(obj==null)
			{
				return "no";
			}
			Customer cus=(Customer)obj;
			String hql=" from CDNsaleOrder where  delFlag=0 and customer.customerId="+cus.getCustomerId()+" order by id desc ";
//			List<CDNsaleOrder> cdnlist=realmtypebussiness.findObjectListByHQL(hql);
//			request.setAttribute("cdnlist", cdnlist);
			
			String pageNo=request.getParameter("pageNo");
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			Pages pages=cdnsaleorderbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			
			return "showcdnlist";
		}
		
		/**
		 * 显示一个详细cdn订单-litscloud 2013-05-4
		 * **/
		public String showOrder3()
		{
			String id=request.getParameter("id");
			CDNsaleOrder cdn=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(id));
			request.setAttribute("cdnsale", cdn);
			System.out.println(cdn.getRecordsNO());
			if(cdn.getRecordsNO()==null||cdn.getRecordsNO().equals(""))
			{
				request.setAttribute("jiasu","国外加速");
			}
			if(cdn.getRecordsNO()!=null&&(cdn.getRecordsNO().equals("")==false))
			{
				request.setAttribute("jiasu","国内加速");
			}
			//根据订单编号查询地址的详细信息
			List<CDNip> cdnip=realmtypebussiness.findObjectListByHQL(" from CDNip where delflag=0  and  CDNsaleorder.id="+id);
			if(cdnip!=null&&cdnip.size()>0)
				{
					request.setAttribute("cdnlist", cdnip);
				}
			
			List<SetMealCenter> centerlist=realmtypebussiness.findObjectListByHQL(" from SetMealCenter where delflag=0  and  setmeal.id="+cdn.getSetmeal().getId());
			System.out.println(cdn.getSetmeal().getId());
			List<SetMealProperty> propertylist=new ArrayList<SetMealProperty>();
			for(SetMealCenter smc:centerlist)
			{
				propertylist.add(smc.getSetMealProperty());
			}
			request.setAttribute("property", propertylist);
			List<Cache> cachelist=realmtypebussiness.findObjectListByHQL(" from Cache where delFlag='0' and  CDNsaleorder.id="+id);
			if(cachelist!=null&&cachelist.size()>0)
			{
				for(int i=0;i<cachelist.size();i++)
				{
					String contenTime=cachelist.get(i).getContentime();
					if(contenTime!=null&&(contenTime.equals("")==false))
					{
						String ct=contenTime.substring(contenTime.length()-1,contenTime.length());
						String ct1=contenTime.substring(0,contenTime.length()-1);
						if(ct.equals("h"))
						{
							cachelist.get(i).setContentime(ct1+"小时");
						}
						else if(ct.equals("d"))
						{
							cachelist.get(i).setContentime(ct1+"天");
						}
						else if(ct.equals("m"))
						{
							cachelist.get(i).setContentime(ct1+"月");
						}
					}
				}
				request.setAttribute("cachelist", cachelist);
			}
			
			List<District> districtlist=realmtypebussiness.findObjectListByHQL(" from District where delFlag='0' and CDNsaleorder.id="+id);
		if(districtlist!=null&&districtlist.size()>0)
				request.setAttribute("districtlist", districtlist);
//			
//			List<CDNsaleorderf> list = uploadbiz.selectEmpById(id+"");//获得附件List
//			if(null!=list&&list.size()>0){
//				request.setAttribute("fjlb", list);
//				request.setAttribute("zdfj", 1);
//			}else{
//				request.setAttribute("detailfj", 0);
//			}
//			
			return "litsshoworder";
		}
		/**
		 * 显示一个详细cdn订单
		 * **/
		public String showOrder()
		{
			String id=request.getParameter("id");
			CDNsaleOrder cdn=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(id));
			request.setAttribute("cdnsale", cdn);
			System.out.println(cdn.getRecordsNO());
			if(cdn.getRecordsNO()==null||cdn.getRecordsNO().equals(""))
			{
				request.setAttribute("jiasu","国外加速");
			}
			if(cdn.getRecordsNO()!=null&&(cdn.getRecordsNO().equals("")==false))
			{
				request.setAttribute("jiasu","国内加速");
			}
			//根据订单编号查询地址的详细信息
			List<CDNip> cdnip=realmtypebussiness.findObjectListByHQL(" from CDNip where delflag=0  and  CDNsaleorder.id="+id);
			if(cdnip!=null&&cdnip.size()>0)
				{
					request.setAttribute("cdnlist", cdnip);
				}
			
			List<SetMealCenter> centerlist=realmtypebussiness.findObjectListByHQL(" from SetMealCenter where delflag=0  and  setmeal.id="+cdn.getSetmeal().getId());
			System.out.println(cdn.getSetmeal().getId());
			List<SetMealProperty> propertylist=new ArrayList<SetMealProperty>();
			for(SetMealCenter smc:centerlist)
			{
				propertylist.add(smc.getSetMealProperty());
			}
			request.setAttribute("property", propertylist);
			List<Cache> cachelist=realmtypebussiness.findObjectListByHQL(" from Cache where delFlag='0' and  CDNsaleorder.id="+id);
			if(cachelist!=null&&cachelist.size()>0)
			{
				for(int i=0;i<cachelist.size();i++)
				{
					String contenTime=cachelist.get(i).getContentime();
					if(contenTime!=null&&(contenTime.equals("")==false))
					{
						String ct=contenTime.substring(contenTime.length()-1,contenTime.length());
						String ct1=contenTime.substring(0,contenTime.length()-1);
						if(ct.equals("h"))
						{
							cachelist.get(i).setContentime(ct1+"小时");
						}
						else if(ct.equals("d"))
						{
							cachelist.get(i).setContentime(ct1+"天");
						}
						else if(ct.equals("m"))
						{
							cachelist.get(i).setContentime(ct1+"月");
						}
					}
				}
				request.setAttribute("cachelist", cachelist);
			}
			
			List<District> districtlist=realmtypebussiness.findObjectListByHQL(" from District where delFlag='0' and CDNsaleorder.id="+id);
		if(districtlist!=null&&districtlist.size()>0)
				request.setAttribute("districtlist", districtlist);
//			
//			List<CDNsaleorderf> list = uploadbiz.selectEmpById(id+"");//获得附件List
//			if(null!=list&&list.size()>0){
//				request.setAttribute("fjlb", list);
//				request.setAttribute("zdfj", 1);
//			}else{
//				request.setAttribute("detailfj", 0);
//			}
//			
			return "showorder";
		}
		
		/**
		 * 显示cdn订单列表
		 * */
		public String showcdnlist1()
		{
			
			request.getSession().removeAttribute("markfanhui");
			String hql=" from CDNsaleOrder where  delFlag=0 order by id desc ";
//			List<CDNsaleOrder> cdnlist=realmtypebussiness.findObjectListByHQL(hql);
//			request.setAttribute("cdnlist", cdnlist);
//			System.out.println(cdnlist.size());
			String pageNo=request.getParameter("pageNo");
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			Pages pages=cdnsaleorderbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("pages", pages);
			
			return "showcdnlist1";
		}
		
		public String showOrder1()
		{
			
			String id=request.getParameter("id");
			CDNsaleOrder cdn=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(id));
			request.setAttribute("cdnsale", cdn);
			request.setAttribute("cusid", cdn.getCustomer().getCustomerId());
			request.setAttribute("realmName", cdn.getCuRealmName());
			System.out.println(cdn.getRecordsNO());
			if(cdn.getRecordsNO()==null||cdn.getRecordsNO().equals(""))
			{
				request.setAttribute("jiasu","国外加速");
			}
			if(cdn.getRecordsNO()!=null&&(cdn.getRecordsNO().equals("")==false))
			{
				request.setAttribute("jiasu","国内加速");
			}
			//根据订单编号查询地址的详细信息
			List<CDNip> cdnip=realmtypebussiness.findObjectListByHQL(" from CDNip where delflag=0  and  CDNsaleorder.id="+id);
			if(cdnip!=null&&cdnip.size()>0)
				{
					request.setAttribute("cdnlist", cdnip);
				}
	
			List<SetMealCenter> centerlist=realmtypebussiness.findObjectListByHQL(" from SetMealCenter where delflag=0  and  setmeal.id="+cdn.getSetmeal().getId());
			System.out.println(cdn.getSetmeal().getId());
			List<SetMealProperty> propertylist=new ArrayList<SetMealProperty>();
			for(SetMealCenter smc:centerlist)
			{
				propertylist.add(smc.getSetMealProperty());
			}
			request.setAttribute("property", propertylist);
			List<Cache> cachelist=realmtypebussiness.findObjectListByHQL(" from Cache where delFlag='0' and  CDNsaleorder.id="+id);
			if(cachelist!=null&&cachelist.size()>0)
			{
				for(int i=0;i<cachelist.size();i++)
				{
					String contenTime=cachelist.get(i).getContentime();
					if(contenTime!=null&&(contenTime.equals("")==false))
					{
						String ct=contenTime.substring(contenTime.length()-1,contenTime.length());
						String ct1=contenTime.substring(0,contenTime.length()-1);
						if(ct.equals("h"))
						{
							cachelist.get(i).setContentime(ct1+"小时");
						}
						else if(ct.equals("d"))
						{
							cachelist.get(i).setContentime(ct1+"天");
						}
						else if(ct.equals("m"))
						{
							cachelist.get(i).setContentime(ct1+"月");
						}
					}
				}
				request.setAttribute("cachelist", cachelist);
			}
			
			List<District> districtlist=realmtypebussiness.findObjectListByHQL(" from District where delFlag='0' and CDNsaleorder.id="+id);
		if(districtlist!=null&&districtlist.size()>0)
				request.setAttribute("districtlist", districtlist);
			
			
			
			//审核
				if(cdn.getSaleOrderNo()!=null){
					String addhql2=" and orderNo='"+cdn.getSaleOrderNo()+"'";
					List audList=audBussiness.someauditingOrder(addhql2);
					request.setAttribute("auditingList", audList);
					if(null != audList && audList.size()>0){
						
						String empid = ck.getCookie(request, "employeeId");
						
						for(int i=0; i<audList.size(); i++){
							
							AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
							
							if((aot.getEmployees() == empid ||aot.getEmployees().equals(empid)) && aot.getAuditingFlag() ==0 ){
								
								//表示未审核
								request.setAttribute("flage", 0);
								
							}else if((aot.getEmployees() == empid || aot.getEmployees().equals(empid) )&&
									(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2)){
								
								//表示已经审核
								request.setAttribute("flage", 1);
								
								request.setAttribute("aot", aot);
								
							}
						}
						
					}				
				}
		
			
			String empid=ck.getCookie(request, "employeeId");
			System.out.println("ck::::"+empid);
			boolean flag=audBussiness.checkemp(cdn.getSaleOrderNo(), empid);
			System.out.println("saleActionflag:::::"+flag);
			if(flag){
				request.setAttribute("mark", "mark");
			}
			boolean flag1=audBussiness.checkemp1(cdn.getSaleOrderNo(), empid);
			if(flag1)
			{
				request.setAttribute("quanxian", "quanxian");
			}
			
			String hqlGroup="from cdnGroup where del=0";
			List<cdnGroup> cdngroup=realmtypebussiness.findObjectListByHQL(hqlGroup);
			request.setAttribute("cdngroup", cdngroup);
			return "showorder1";
		}
		
		/**
		 * 开启CDN服务
		 * @return
		 * @throws IOException 
		 * @throws IOException
		 */
		public void openService() throws IOException
		{
			String id=request.getParameter("id");
			String num1=request.getParameter("num");
			Object object=realmtypebussiness.findObjectById("CDNsaleOrder", Integer.parseInt(id));
			CDNsaleOrder cdnso=(CDNsaleOrder) object;//查询cdn订单并转换
			
			String selecthql="from cdnRealmNameIP where customerID.customerId="+cdnso.getCustomer().getCustomerId()+" and cuRealmName='"+cdnso.getCuRealmName()+"' and del=0";
			List<cdnRealmNameIP> cdnipList=realmtypebussiness.findObjectListByHQL(selecthql);
			String RealmName1=request.getParameter("RealmName");
			String RealmName=RealmName1.replace(".", "_")+".conf";
			String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
			String mark="";
			int mark1=0;
			PurgeManager pm=PurgeManager.getInstance();
			System.out.println(cdnso.getStarttime());
			if(num1.equals("1"))//开启
			{
			if(cdnso.getStarttime()==null||cdnso.getStarttime().equals(""))//是否是第一次开启 是保存开始时间和套餐结束时间
			{
				
				Calendar calendar = Calendar.getInstance();
				
					calendar.set(Calendar.HOUR_OF_DAY, 0);
					calendar.set(Calendar.MINUTE, 0);
					calendar.set(Calendar.SECOND, 0);
				String btime = calendar.getTimeInMillis()+"";//当前时间的毫秒		
				
				calendar.add(Calendar.DATE, +Integer.parseInt(cdnso.getSetmeal().getUsetime()));
				String etime = calendar.getTimeInMillis()+"";//当前时间+套餐使用时长=结束时间
				
				String hqlupdateSetmeal="update CDNsaleOrder set starttime='"+btime+"' , endtime='"+etime+"' where id="+cdnso.getId()+"";
				realmtypebussiness.updataByHQL(hqlupdateSetmeal);
				
			}
			}
			
			if(id!=null&&!id.equals(""))
			{
				if(num1.equals("1"))//开启
				{
				//电信的文件
				String dianxing1=path+"file/dianxin/"+RealmName;
				String dianxing=path+"file/swap/dianxin/"+RealmName;
				File file = new File(dianxing1);
				FileUtil fu=new FileUtil();
				File to = new File(dianxing);
				 if (file.isFile()) {
			          // 复制文件
			         String type = file.getName().substring(file.getName().lastIndexOf(".") + 1);

			          if (type.equalsIgnoreCase("conf"))// 转码处理
			        	  fu.copyFile(file, new File(to.toString()));
			          else
			        	  fu.copyFile(file, new File(to.toString()));
			      }
				else
				{
					mark1=mark1+1;
				}
				 
				//联通的文件
				 String liantong1=path+"file/liantong/"+RealmName;
					String liantong=path+"file/swap/liantong/"+RealmName;
					File file1 = new File(liantong1);
					File to1 = new File(liantong);
					 if (file1.isFile()) {
				          // 复制文件
				         String type = file1.getName().substring(file1.getName().lastIndexOf(".") + 1);

				          if (type.equalsIgnoreCase("conf"))// 转码处理
				        	  fu.copyFile(file1, new File(to1.toString()));
				          else
				        	  fu.copyFile(file1, new File(to1.toString()));
				      }
					else
					{
						mark1=mark1+1;
					}
				}
				else if(num1.equals("2"))//关闭的时候删除复制的文件
				{
					String dianxing=path+"file/swap/dianxin/"+RealmName;
					File file = new File(dianxing);
					if(file.isFile())
					{
						file.delete();
					}
					String liantong=path+"file/swap/liantong/"+RealmName;
					File file1 = new File(liantong);
					if(file1.isFile())
					{
						file1.delete();
					}
				}
				String mark111="";
				
				 if(mark1==2)
				 {
					 response.getWriter().print("3");//没有配置文件存在
					 return ;
				 }
				 else{
					 
					 if(num1.equals("1"))
					 {
						 for(int i=0;i<cdnipList.size();i++)
						 {
							 if(cdnipList.get(i).getCdnPanelPointID().getDel()==0)
							 {
								 mark=pm.doOneSquid1(cdnipList.get(i).getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=siteconfig***ParamType=String***domain=http://"+cdnipList.get(i).getCuRealmName()+"***Parameter=startCDN***", cdnipList.get(i).getCdnPanelPointID().getDuankou())+"";
								  if(mark.equals("404"))//不存在缓存或者缓存已刷新
									{
									  mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("1"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("2"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("3"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("500"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}
									else if(mark.equals("403"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("400"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("999"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("-1"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}
									else if(mark.equals("-2"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"参数错误<br />";//参数错误
									}
									else if(mark.equals("-3"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"服务未开启<br />";//服务没有开启
									}
									else if(mark.equals("-4"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"服务错误<br />";//创建读写出错（服务出错）
									}else {
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"服务错误<br />";//服务错误
									}
									
							 }
						 }
					 }
					 if(num1.equals("2"))
					 {
						 for(int i=0;i<cdnipList.size();i++)
						 {
							 if(cdnipList.get(i).getCdnPanelPointID().getDel()==0)
							 {
								 mark=pm.doOneSquid1(cdnipList.get(i).getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=siteconfig***ParamType=String***domain=http://"+cdnipList.get(i).getCuRealmName()+"***Parameter=stopCDN***", cdnipList.get(i).getCdnPanelPointID().getDuankou())+"";
								 if(mark.equals("404"))//不存在缓存或者缓存已刷新
									{
									  mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("1"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("2"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("3"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("500"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}
									else if(mark.equals("403"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("400"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("999"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}else if(mark.equals("-1"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"网络错误<br />";//网络错误
									}
									else if(mark.equals("-2"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"参数错误<br />";//参数错误
									}
									else if(mark.equals("-3"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"服务未开启<br />";//服务没有开启
									}
									else if(mark.equals("-4"))
									{
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"服务错误<br />";//创建读写出错（服务出错）
									}else {
										mark111+="节点"+cdnipList.get(i).getCdnPanelPointID().getPanelPointIp()+"服务错误<br />";//服务错误
									}
							 }
						 }
					 }
					 request.getSession().setAttribute("markfanhui", mark111);
					String hql="update CDNsaleOrder set serverFlag="+Integer.parseInt(num1)+" where id="+Integer.parseInt(id)+"";
					int num=realmtypebussiness.updataByHQL(hql);
					if(num>0)
					{
						response.getWriter().print("0");
						return;
					}
					else
						response.getWriter().print("1");
					 }
				 
			}
			response.getWriter().print("1");
		}
		public void tixing()
		{
			String hql="from CDNsaleOrder where delFlag=0 and starttime !=''";
			List<CDNsaleOrder>  cdnsaleOrder=realmtypebussiness.findObjectListByHQL(hql);
			
			Calendar calendar = Calendar.getInstance();
			
			calendar.set(Calendar.HOUR_OF_DAY, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			String btime = calendar.getTimeInMillis()+"";//当前时间的毫秒		
			Calendar calendar7 = Calendar.getInstance();
			
			calendar7.set(Calendar.HOUR_OF_DAY, +7);
			calendar7.set(Calendar.MINUTE, 0);
			calendar7.set(Calendar.SECOND, 0);
			String btime7 = calendar7.getTimeInMillis()+"";//当前后7天时间的毫秒		
			
			for(int i=0;i<cdnsaleOrder.size();i++)
			{
				//86400000 每天的毫秒数    
					System.out.println(cdnsaleOrder.get(i).getEndtime());
					System.out.println(btime);
					System.out.println(cdnsaleOrder.get(i).getEndtime());
					System.out.println(btime7);
					if(Long.parseLong(cdnsaleOrder.get(i).getEndtime())>=Long.parseLong(btime)&&Long.parseLong(cdnsaleOrder.get(i).getEndtime())<(Long.parseLong(btime7)))
					{
						//今天就是到期时间 所以删除配置文件 结束时间等于当前时间
							if(Long.parseLong(cdnsaleOrder.get(i).getEndtime())==Long.parseLong(btime)){
							//删除文件  （暂停使用）
							String RealmName1=cdnsaleOrder.get(i).getCuRealmName();
							String RealmName=RealmName1.replace(".", "_")+".conf";
							String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
							String dianxing=path+"file/swap/dianxin/"+RealmName;
							File file = new File(dianxing);
							if(file.isFile())
							{
								file.delete();//删除电信文件
							}
							
							String jiaoyuewang=path+"file/swap/jiaoyuewang/"+RealmName;
							File file1 = new File(jiaoyuewang);
							if(file1.isFile())
							{
								file1.delete();//删除教育网文件
							}
							
							String liantong=path+"file/swap/liantong/"+RealmName;
							File file2 = new File(liantong);
							if(file2.isFile())
							{
								file2.delete();//删除联通文件
							}
							
							String tietong=path+"file/swap/tietong/"+RealmName;
							File file3 = new File(tietong);
							if(file3.isFile())
							{
								file3.delete();//删除铁通文件
							}
							String yidong=path+"file/swap/yidong/"+RealmName;
							File file4 = new File(yidong);
							if(file4.isFile())
							{
								file4.delete();//删除移动文件
							}
							
							
							//邮件提醒
							String msg = "亲爱的"
								+ cdnsaleOrder.get(i).getCustomer().getRealName()
								+ ": <br/><br/>这是立云订单到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的套餐已经到期给、你暂停使用<br/><br/>"
								+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
						Email sendemail = new Email();
						
						sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件到期提醒订单",msg);
						}
					
						else
						{
							//到期时间-当前时间 在除以每天的毫秒数获取还多少天
							long aa=(Long.parseLong(cdnsaleOrder.get(i).getEndtime())-Long.parseLong(btime))/86400000;
							//邮件提醒
							String msg = "亲爱的"
								+ cdnsaleOrder.get(i).getCustomer().getRealName()
								+ ": <br/><br/>这是立云订单快到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的套餐还剩下"+aa+"天使用时间<br/><br/>"
								+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
						Email sendemail = new Email();
						
						sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件快到期提醒订单",msg);
						}
					}
					
				
			}
			for(int i=0;i<cdnsaleOrder.size();i++)
			{
				
				
				String ym=cdnsaleOrder.get(i).getCuRealmName();
				String logserver="from cdnRealmNameIP where cuRealmName='"+ym+"'";
				List<cdnRealmNameIP> crn=realmtypebussiness.findObjectListByHQL(logserver);//获取域名对应的节点
				String  yidongjiedian="";
				String  dianxingjiedian="";
				String  wangtongjiedian="";
				String  liantongjiedian="";
				String  jiaoyuwangjiedian="";
				for(int j=0;j<crn.size();j++)
				{
					if(crn.get(j).getCdnPanelPointID().getCdnTypeID().getTypeName().equals("电信"))
					{
						dianxingjiedian+="'"+crn.get(j).getCdnPanelPointID().getPanelPointIp()+"',";
					}	
					if(crn.get(j).getCdnPanelPointID().getCdnTypeID().getTypeName().equals("联通"))
					{
						liantongjiedian+="'"+crn.get(j).getCdnPanelPointID().getPanelPointIp()+"',";
					}
					if(crn.get(j).getCdnPanelPointID().getCdnTypeID().getTypeName().equals("移动"))
					{
						yidongjiedian+="'"+crn.get(j).getCdnPanelPointID().getPanelPointIp()+"',";
					}
					if(crn.get(j).getCdnPanelPointID().getCdnTypeID().getTypeName().equals("铁通"))
					{
						wangtongjiedian+="'"+crn.get(j).getCdnPanelPointID().getPanelPointIp()+"',";
					}
					if(crn.get(j).getCdnPanelPointID().getCdnTypeID().getTypeName().equals("教育网"))
					{
						jiaoyuwangjiedian+="'"+crn.get(j).getCdnPanelPointID().getPanelPointIp()+"',";
					}	
				}
				String shangping="from SetMealCenter where setmeal.id="+cdnsaleOrder.get(i).getSetmeal().getId()+"";//获取套餐下面包含商品
				List<SetMealCenter> sm=realmtypebussiness.findObjectListByHQL(shangping);
				for(int z=0;z<sm.size();z++)
				{
					int daikuan=Integer.parseInt(sm.get(z).getSetMealProperty().getFlow());//记录套餐带宽多大
					int numdaikuan=0;
					if(sm.get(z).getSetMealProperty().getFlow2().equals("电信"))
					{	
						//daikuan=;//
						String ymmark=cdnsaleOrder.get(i).getCuRealmName().replace(".", "_");
						String hqllogServer="from cdnLogServer where nodestr in ("+dianxingjiedian.substring(0, dianxingjiedian.length()-1)+") and domain='"+ymmark+"'";
						List<cdnLogServer> logServer=realmtypebussiness.findObjectListByHQL(hqllogServer);
						for(int x=0;x<logServer.size();x++)
						{
							numdaikuan+=logServer.get(x).getBandwidth();
						}
						int daikuan1=(daikuan-1)*1024*1024*1024;//转换为B   -1是：减去1G后的带宽用来后面比较是否快用到期了
						if(numdaikuan>daikuan1||numdaikuan==daikuan1)//判断用了的带宽是否超过套餐商品带宽-1G超过就邮件提醒
						{
							int daikuan2=daikuan*1024*1024*1024;
							if(numdaikuan>daikuan2||numdaikuan==daikuan2)//如果用了的带宽大于或者套餐商品带宽就说明已经到期了给他停用掉并邮件提醒
							{
								//删除文件  （暂停使用）
								String RealmName1=cdnsaleOrder.get(i).getCuRealmName();
								String RealmName=RealmName1.replace(".", "_")+".conf";
								String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
								String dianxing=path+"file/swap/dianxin/"+RealmName;
								File file = new File(dianxing);
								if(file.isFile())
								{
									file.delete();
								}
								
								//邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的电信带宽已经到期给、你暂停使用<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件到期提醒订单",msg);
							
							
							}
							else
							{
								//快到期邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单快到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的电信带宽快到期   剩下不足1G的带宽<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件快到期提醒订单",msg);
							}
							
						}
					}
					if(sm.get(z).getSetMealProperty().getFlow2().equals("联通"))
					{	
						//daikuan=;//
						String ymmark=cdnsaleOrder.get(i).getCuRealmName().replace(".", "_");
						String hqllogServer="from cdnLogServer where nodestr in ("+liantongjiedian.substring(0, liantongjiedian.length()-1)+") and domain='"+ymmark+"'";
						List<cdnLogServer> logServer=realmtypebussiness.findObjectListByHQL(hqllogServer);
						for(int x=0;x<logServer.size();x++)
						{
							numdaikuan+=logServer.get(x).getBandwidth();
						}
						int daikuan1=(daikuan-1)*1024*1024*1024;//转换为B   -1是：减去1G后的带宽用来后面比较是否快用到期了
						if(numdaikuan>daikuan1||numdaikuan==daikuan1)//判断用了的带宽是否超过套餐商品带宽-1G超过就邮件提醒
						{
							int daikuan2=daikuan*1024*1024*1024;
							if(numdaikuan>daikuan2||numdaikuan==daikuan2)//如果用了的带宽大于或者套餐商品带宽就说明已经到期了给他停用掉并邮件提醒
							{
								//删除文件  （暂停使用）
								String RealmName1=cdnsaleOrder.get(i).getCuRealmName();
								String RealmName=RealmName1.replace(".", "_")+".conf";
								String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
								
								String liantong=path+"file/swap/liantong/"+RealmName;
								File file1 = new File(liantong);
								if(file1.isFile())
								{
									file1.delete();
								}
								
								//邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的联通带宽已经到期给、你暂停使用<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件到期提醒订单",msg);
							
							
							}
							else
							{
								//快到期邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单快到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的联通带宽快到期   剩下不足1G的带宽<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件快到期提醒订单",msg);
							}
							
						}
					}
					if(sm.get(z).getSetMealProperty().getFlow2().equals("移动"))
					{	
						//daikuan=;//
						String ymmark=cdnsaleOrder.get(i).getCuRealmName().replace(".", "_");
						String hqllogServer="from cdnLogServer where nodestr in ("+yidongjiedian.substring(0, yidongjiedian.length()-1)+") and domain='"+ymmark+"'";
						List<cdnLogServer> logServer=realmtypebussiness.findObjectListByHQL(hqllogServer);
						for(int x=0;x<logServer.size();x++)
						{
							numdaikuan+=logServer.get(x).getBandwidth();
						}
						int daikuan1=(daikuan-1)*1024*1024*1024;//转换为B   -1是：减去1G后的带宽用来后面比较是否快用到期了
						if(numdaikuan>daikuan1||numdaikuan==daikuan1)//判断用了的带宽是否超过套餐商品带宽-1G超过就邮件提醒
						{
							int daikuan2=daikuan*1024*1024*1024;
							if(numdaikuan>daikuan2||numdaikuan==daikuan2)//如果用了的带宽大于或者套餐商品带宽就说明已经到期了给他停用掉并邮件提醒
							{
								//删除文件  （暂停使用）
								String RealmName1=cdnsaleOrder.get(i).getCuRealmName();
								String RealmName=RealmName1.replace(".", "_")+".conf";
								String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
								String dianxing=path+"file/swap/yidong/"+RealmName;
								File file = new File(dianxing);
								if(file.isFile())
								{
									file.delete();
								}
								
								//邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的移动带宽已经到期给、你暂停使用<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件到期提醒订单",msg);
							
							
							}
							else
							{
								//快到期邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单快到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"移动带宽快到期   剩下不足1G的带宽<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件快到期提醒订单",msg);
							}
							
						}
					}
					if(sm.get(z).getSetMealProperty().getFlow2().equals("铁通"))
					{	
						//daikuan=;//
						String ymmark=cdnsaleOrder.get(i).getCuRealmName().replace(".", "_");
						String hqllogServer="from cdnLogServer where nodestr in ("+wangtongjiedian.substring(0, wangtongjiedian.length()-1)+") and domain='"+ymmark+"'";
						List<cdnLogServer> logServer=realmtypebussiness.findObjectListByHQL(hqllogServer);
						for(int x=0;x<logServer.size();x++)
						{
							numdaikuan+=logServer.get(x).getBandwidth();
						}
						int daikuan1=(daikuan-1)*1024*1024*1024;//转换为B   -1是：减去1G后的带宽用来后面比较是否快用到期了
						if(numdaikuan>daikuan1||numdaikuan==daikuan1)//判断用了的带宽是否超过套餐商品带宽-1G超过就邮件提醒
						{
							int daikuan2=daikuan*1024*1024*1024;
							if(numdaikuan>daikuan2||numdaikuan==daikuan2)//如果用了的带宽大于或者套餐商品带宽就说明已经到期了给他停用掉并邮件提醒
							{
								//删除文件  （暂停使用）
								String RealmName1=cdnsaleOrder.get(i).getCuRealmName();
								String RealmName=RealmName1.replace(".", "_")+".conf";
								String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
								String dianxing=path+"file/swap/tietong/"+RealmName;
								File file = new File(dianxing);
								if(file.isFile())
								{
									file.delete();
								}
								
								//邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的铁通带宽已经到期给、你暂停使用<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件到期提醒订单",msg);
							
							
							}
							else
							{
								//快到期邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单快到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的铁通带宽快到期   剩下不足1G的带宽<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件快到期提醒订单",msg);
							}
							
						}
					}
					if(sm.get(z).getSetMealProperty().getFlow2().equals("教育网"))
					{	
						//daikuan=;//
						String ymmark=cdnsaleOrder.get(i).getCuRealmName().replace(".", "_");
						String hqllogServer="from cdnLogServer where nodestr in ("+jiaoyuwangjiedian.substring(0, jiaoyuwangjiedian.length()-1)+")";
						List<cdnLogServer> logServer=realmtypebussiness.findObjectListByHQL(hqllogServer);
						for(int x=0;x<logServer.size();x++)
						{
							numdaikuan+=logServer.get(x).getBandwidth();
						}
						int daikuan1=(daikuan-1)*1024*1024*1024;//转换为B   -1是：减去1G后的带宽用来后面比较是否快用到期了
						if(numdaikuan>daikuan1||numdaikuan==daikuan1)//判断用了的带宽是否超过套餐商品带宽-1G超过就邮件提醒
						{
							int daikuan2=daikuan*1024*1024*1024;
							if(numdaikuan>daikuan2||numdaikuan==daikuan2)//如果用了的带宽大于或者套餐商品带宽就说明已经到期了给他停用掉并邮件提醒
							{
								//删除文件  （暂停使用）
								String RealmName1=cdnsaleOrder.get(i).getCuRealmName();
								String RealmName=RealmName1.replace(".", "_")+".conf";
								String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
								String dianxing=path+"file/swap/jiaoyuewang/"+RealmName;
								File file = new File(dianxing);
								if(file.isFile())
								{
									file.delete();
								}
								//邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的教育网带宽已经到期给、你暂停使用<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件到期提醒订单",msg);
							
							
							}
							else
							{
								//快到期邮件提醒
								String msg = "亲爱的"
									+ cdnsaleOrder.get(i).getCustomer().getRealName()
									+ ": <br/><br/>这是立云订单快到期提醒邮件<br/><br/>你的域名是："+cdnsaleOrder.get(i).getCuRealmName()+"的教育网带宽快到期   剩下不足1G的带宽<br/><br/>"
									+ "<br/><br/><br/><br/>---立云<br/><br/>（这是一封自动产生的email，请勿回复。） ";
							Email sendemail = new Email();
							
							sendemail.sendEmail(cdnsaleOrder.get(i).getCustomer().getEmail(), "立云客服系统--邮件快到期提醒订单",msg);
							}
							
						}
					}
				}
				
			}
				
 		}
		public String del() throws IOException
		{
			System.out.println("删除");
			String id=request.getParameter("id");
			CDNsaleOrder cdn=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(id));
			List<District> district=realmtypebussiness.findObjectListByHQL(" from District where delflag=0  and CDNsaleorder.id="+id);
			List<Cache> cache=realmtypebussiness.findObjectListByHQL(" from Cache where delFlag='0' and  CDNsaleorder.id="+id);
			List<CDNip> cdnip=realmtypebussiness.findObjectListByHQL(" from CDNip where delFlag='0' and  CDNsaleorder.id="+id);
			if(district!=null)
			{
				for(int i=0;i<district.size();i++)
				{
					int aa=realmtypebussiness.delObject(district.get(i));
					if(aa==0)
					{
						System.out.println("删除失败");
						response.getWriter().print("0");
						return null;
					}
				}
			}
			if(cdnip!=null)
			{
				for(int i=0;i<cdnip.size();i++)
				{
					int aa=realmtypebussiness.delObject(cdnip.get(i));
					if(aa==0)
					{
						System.out.println("删除失败");
						response.getWriter().print("0");
						return null;
					}
				}
			}
			if(cache!=null)
			{
				for(int i=0;i<cache.size();i++)
				{
					int aa=realmtypebussiness.delObject(cache.get(i));
					if(aa==0)
					{
						System.out.println("删除失败");
						response.getWriter().print("0");
						return null;
					}
				}
			}
			int aa=realmtypebussiness.delObject(cdn);
			if(aa==0)
			{
				System.out.println("删除失败");
				response.getWriter().print("0");
				return null;
			}
			response.getWriter().print("1");
			return null;
		}
		
		
		public String update()
		{
			
			String id=request.getParameter("id");///订单id
			
			//显示类型，如静态，动态，等(RealmType)
			String hql=" from RealmType where 1=1  ";
			List realmtypelist=realmtypebussiness.findObjectListByHQL(hql);
			request.setAttribute("realmtypelist", realmtypelist);
			
			List<CDNip> iplist=realmtypebussiness.findObjectListByHQL(" from CDNip where CDNsaleorder.id="+id);
			request.setAttribute("iplist", iplist);
			request.setAttribute("iplistsize", iplist.size()+01);
			
			//显示大地址
			FindXMLMake xml=new FindXMLMake();
			String path ="/xml/DistrictAddress.xml";	
			List<String> disname=xml.ReadDistrictAddress1(path);
			request.setAttribute("disname", disname);
			
			CDNsaleOrder cdn=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(id));
			request.setAttribute("cdnsale", cdn);
			System.out.println(cdn.getRecordsNO());
			if(cdn.getRecordsNO()==null||cdn.getRecordsNO().equals(""))
			{
				request.setAttribute("jiasu","国外加速");
			}
			if(cdn.getRecordsNO()!=null&&(cdn.getRecordsNO().equals("")==false))
			{
				request.setAttribute("jiasu","国内加速");
			}
			List<SetMealCenter> centerlist=realmtypebussiness.findObjectListByHQL(" from SetMealCenter where delflag=0  and  setmeal.id="+cdn.getSetmeal().getId());
			List<SetMealProperty> propertylist=new ArrayList<SetMealProperty>();
			for(SetMealCenter smc:centerlist)
			{
//				propertylist.add(smc.getSetmealproperty());
			}
			request.setAttribute("property", propertylist);
			List<Cache> cachelist=realmtypebussiness.findObjectListByHQL(" from Cache where delFlag='0' and  CDNsaleorder.id="+id);
			if(cachelist!=null&&cachelist.size()>0)
			{
				request.setAttribute("cachelist", cachelist);
			
			
			request.setAttribute("cachelistsize", (cachelist.size()+1));
			}
			String[] tianshu=new String[cachelist.size()];
			String[] danwei=new String[cachelist.size()];
			for(int i=0;i<cachelist.size();i++)
			{
				System.out.println(cachelist.get(i).getContentime());
				 String time=cachelist.get(i).getContentime();
				 if(time!=null&&!"".equals(time))
				 {
					 tianshu[i] =time.substring(0,time.length()-1);
					 danwei[i] =time.substring(time.length()-1,time.length());
				 }
			}
			request.setAttribute("tianshu", tianshu);
			request.setAttribute("danwei", danwei);
			List<District> districtlist=realmtypebussiness.findObjectListByHQL(" from District where delFlag='0' and CDNsaleorder.id="+id);
			if(districtlist!=null&&districtlist.size()>0){
				request.setAttribute("districtlist", districtlist);
			
			request.setAttribute("districtlistsize", (districtlist.size()+1));
			}
			SetMeal setMeal=cdn.getSetmeal();
			String aa="<tr id='tr"+setMeal.getId()+"'><TD  width='10%' id='td1' class=category>"+setMeal.getName()+"</TD>"
			+"<TD  width='10%'id='td2' class=category>"+setMeal.getRealmtype().getName()+"</TD>"
			+"<TD with='1%' id='td3' class=category>"+setMeal.getStarttime()+"</TD>"
			+"<TD with='1%' id='td4' class=category>"+setMeal.getEndtime()+"</TD>"	
			+"<td with='25%' id='td5' class=category>"+setMeal.getDescribe()+"</td>"
			+"<TD with='10%' id='td6' class=category>"+setMeal.getUsetime()+"</TD>"
			+"<TD with='10%' id='td7' class=category>"+setMeal.getPayprice()+"</TD>"
			+"<TD with='10%' id='td8' class=category>"+setMeal.getPrice()+"</TD>"
			+"<td with='5%' id='td9' ><input id='' name='a'  type='radio' value="+setMeal.getId()+" checked='checked' /><td></tr>";
			request.setAttribute("cdnsetmeal", aa);
			return "update";
		}
		
		
		public String update1() throws IOException
		{
			request.setCharacterEncoding("utf-8");
			String CDNid=request.getParameter("CDNid");  //cdnid
			String cuRealmName=request.getParameter("cuRealmName");//客户的域名
			String syRealmName=request.getParameter("syRealmName");//系统域名
			String switchOpen=request.getParameter("switch");//是否开启网站
			String IPinterval=request.getParameter("IPinterval");//月均IP区间数
			String PVinterval=request.getParameter("PVinterval");//月均PV区间数
			String starttime=request.getParameter("starttime");   //开始运行时间
			String endtime=request.getParameter("endtime");  /// 结束运行时间
			String accessoryfile=request.getParameter("accessoryfile"); //附件大小
			String mostfile=request.getParameter("mostfile");		// 文件大小
			String quickenaddress=request.getParameter("quickenaddress");//加速地区
			String recordsNo=request.getParameter("recordsNo"); //  备案号
			String realmtypeid=request.getParameter("realmtypeid");//加速类型 id
			String taocanleixing=request.getParameter("taocanleixing");//套餐类型，付费
			String setmealid=request.getParameter("a");//套餐id
			
			if(cuRealmName!=null)cuRealmName=URLDecoder.decode(cuRealmName, "UTF-8");
			if(syRealmName!=null)syRealmName=URLDecoder.decode(syRealmName,"UTF-8");
			if(IPinterval!=null)IPinterval=URLDecoder.decode(IPinterval, "UTF-8");
			if(PVinterval!=null)PVinterval=URLDecoder.decode(PVinterval, "UTF-8");
			if(starttime!=null)starttime=URLDecoder.decode(starttime, "UTF-8");
			if(endtime!=null)endtime=URLDecoder.decode(endtime, "UTF-8");
			if(accessoryfile!=null)accessoryfile=URLDecoder.decode(accessoryfile, "UTF-8");
			if(mostfile!=null)mostfile=URLDecoder.decode(mostfile, "UTF-8");
			if(quickenaddress!=null)quickenaddress=URLDecoder.decode(quickenaddress, "UTF-8");
			if(recordsNo!=null)recordsNo=URLDecoder.decode(recordsNo, "UTF-8");
			
			System.out.println("月均IP区间数            "+IPinterval);
			System.out.println("月均PV区间数            "+PVinterval);
			System.out.println("加速地区                      "+quickenaddress);
			System.out.println("备案号                           "+recordsNo);

			System.out.println("删除"+CDNid);
			CDNsaleOrder cdn=null;
			try{
			cdn=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(CDNid)); ///取得cdn订单
			}catch(Exception es){
				es.printStackTrace();
			}
			///取得IP列表
			List<CDNip> iplist=null;
			try{
			iplist=realmtypebussiness.findObjectListByHQL(" from  CDNip  where delflag=0 and CDNsaleorder.id="+CDNid);
			}catch(Exception e){
				e.printStackTrace();
				}
			if(iplist==null)
			{
				System.out.println("IP集合为空！");
			}
			///取得回源IP列表
			List<District> district=realmtypebussiness.findObjectListByHQL(" from District where delflag=0  and  CDNsaleorder.id="+CDNid);
			///取得缓存列表
			List<Cache> cache=realmtypebussiness.findObjectListByHQL(" from Cache where delFlag='0' and  CDNsaleorder.id="+CDNid);
			if(iplist!=null)
			{  ///删除ip
				for(int i=0;i<iplist.size();i++)
				{
					int aa=realmtypebussiness.delObject(iplist.get(i));
					if(aa==0)
					{
						System.out.println("删除失败");
						response.getWriter().print("0");
						return null;
					}
				}
			}
			if(district!=null)
			{///删除回源
				for(int i=0;i<district.size();i++)
				{
					int aa=realmtypebussiness.delObject(district.get(i));
					if(aa==0)
					{
						System.out.println("删除失败");
						response.getWriter().print("0");
						return null;
					}
				}
			}
			if(cache!=null)
			{///删除缓存
				for(int i=0;i<cache.size();i++)
				{
					int aa=realmtypebussiness.delObject(cache.get(i));
					if(aa==0)
					{
						System.out.println("删除失败");
						response.getWriter().print("0");
						return null;
					}
				}
			}
			
			///获得IP
			for(int i=1;;i++)
			{
				String IP=request.getParameter("ip"+i);    //IP
				String port=request.getParameter("port"+i);  //端口
				String ipaddress=request.getParameter("ipaddress"+i);  ///IP所在地
				String iptmoblie=request.getParameter("iptmoblie"+i);//运营商
				if(IP==null||"".equals(IP))
					break;
				if(IP!=null)IP=URLDecoder.decode(IP, "UTF-8");
				if(port!=null)port=URLDecoder.decode(port, "UTF-8");
				if(ipaddress!=null)ipaddress=URLDecoder.decode(ipaddress, "UTF-8");
				if(iptmoblie!=null)iptmoblie=URLDecoder.decode(iptmoblie, "UTF-8");
				CDNip cdip=new CDNip();
				cdip.setCDNsaleorder(cdn);
				cdip.setDelflag(0);
				cdip.setIp(IP);
				cdip.setPort(port);
				cdip.setAddress(ipaddress);
				cdip.setTmoblie(iptmoblie);
				cdip=(CDNip)realmtypebussiness.addObject(cdip);
				if(cdip==null)
				{
					System.out.println("IP保存出错！");
				}
			}
			
			///获得缓存
			for(int i=1;;i++)
			{
				String huancun=request.getParameter("huancun"+i);//  是否缓存，1缓存，2不缓存
				String test=request.getParameter("test"+i);  //  缓存规则
				String time=request.getParameter("time"+i);  //缓存时间
				String timedanwei=request.getParameter("timedanwei"+i);  //缓存时间单位
				System.out.println("缓存"+i+"  --> "+huancun);
				if(huancun==null||"".equals(huancun))
					break;
				if(huancun!=null)huancun=URLDecoder.decode(huancun, "UTF-8");
				if(test!=null)test=URLDecoder.decode(test, "UTF-8");
				if(time!=null)time=URLDecoder.decode(time, "UTF-8");
				if(timedanwei!=null)timedanwei=URLDecoder.decode(timedanwei, "UTF-8");
				System.out.println("转换后缓存"+i+"  --> "+huancun);
				Cache ca=new Cache();
				ca.setCachecontent(test);
				ca.setCacheflag(Integer.parseInt(huancun));
				ca.setCDNsaleorder(cdn);
				String dan="h";
				if(timedanwei!=null&&"2".equals(timedanwei))
					dan="d";
				if(timedanwei!=null&&"3".equals(timedanwei))
					dan="m";
			  ca.setContentime(time+dan);
				ca.setDelflag(0);
				ca=(Cache)realmtypebussiness.addObject(ca);
				if(ca==null)
				{
					System.out.println("缓存保存出错！");
				}
			}
			
			/// 获得回源IP】
			for(int i=1;;i++)
			{
				String tmoblie=request.getParameter("tmoblie"+i); // 运营商
				String daaddress=request.getParameter("daaddress"+i);  //地区
				String huiyuan=request.getParameter("huiyuan"+i);///回源IP
				System.out.println("回源IP---》"+i+"  "+huiyuan);
				if(huiyuan==null||"".equals(huiyuan))
					break;
				if(tmoblie!=null)tmoblie=URLDecoder.decode(tmoblie, "UTF-8");
				if(daaddress!=null)daaddress=URLDecoder.decode(daaddress, "UTF-8");
				if(huiyuan!=null)huiyuan=URLDecoder.decode(huiyuan, "UTF-8");
				System.out.println("111回源IP---》"+i+"  "+huiyuan);
				
				District dis=new District();
				dis.setCDNsaleorder(cdn);
				dis.setDelflag(0);
				dis.setIp(huiyuan);
				dis.setDistrictName(daaddress);
				dis.setTmoblie(tmoblie);
				dis=(District)realmtypebussiness.addObject(dis);
				if(dis==null)
				{
					System.out.println("回源IP保存出错！");
				}
			}
			SetMeal setm=(SetMeal)realmtypebussiness.findObjectById("SetMeal", Integer.parseInt(setmealid));
			///设置cdn订单,
			cdn.setCuRealmName(cuRealmName);
			cdn.setSyRealmName(syRealmName);
			cdn.setServerFlag(switchOpen);
			cdn.setIPinterval(IPinterval);
			cdn.setPVinterval(PVinterval);
			cdn.setStarttime(starttime);
			cdn.setEndtime(endtime);
			cdn.setAccessoryfile(accessoryfile);
			cdn.setMostfile(mostfile);
			if(quickenaddress.equals("国内加速"))
				cdn.setRecordsNO(recordsNo);
			cdn.setSetmeal(setm);
			cdn=(CDNsaleOrder)realmtypebussiness.updataObject(cdn);
			if(cdn==null)
			{
				System.out.println("cdn订单修改保存出错！");
				response.getWriter().print("0");
			}else
				response.getWriter().print("1");
			return null;
		}
		/**
		 * 查找要配置的内容，并显示在页面     showToFile
		 * **/
		public String showToFile()
		{
			
			
			String ipID=request.getParameter("id");
			//获取IP
			List<CDNip> cdniplist=realmtypebussiness.findObjectListByHQL(" from CDNip where id="+ipID);
			CDNip cdnip=cdniplist.get(0);//获取到为空
			
			CDNsaleOrder cdnsale=cdnip.getCDNsaleorder();
			
			String cdnID=cdnsale.getId()+"";
			request.setAttribute("cdnid", cdnID);
			FindXMLMake xml=new FindXMLMake();
			
			///1.先取得所有要写配置文件的数据
			List<Cache> cachelist=(List<Cache>)realmtypebussiness.findObjectListByHQL("from Cache where delFlag='0' and CDNsaleorder.id="+cdnID);///缓存列表					
			List<District> districtlist=(List<District>)realmtypebussiness.findObjectListByHQL("from District where delFlag='0' and CDNsaleorder.id="+cdnID);///回源IP列表
			//////(1).获得IP地址，域名      判断是电信还是联通， 写入到host文件中去,直接追加到最后
			String tmobil="";
			String tmobilname="";
			if(cdnip.getTmoblie().equals("电信"))///是电信的，
			{
				tmobil="dianxin";tmobilname="电信";
			}
			if(cdnip.getTmoblie().equals("联通"))///是联通的，
			{
				tmobil="liantong";tmobilname="联通";
			}
			if(cdnip.getTmoblie().equals("铁通"))///是联通的，
			{
				tmobil="tietong";tmobilname="铁通";
			}
			if(cdnip.getTmoblie().equals("其他"))///是联通的，
			{
				tmobil="qita";tmobilname="qita";
			}
			
			///**************  插入到host文件
			String hostPath="file/"+tmobil+"/hosts.conf";
			String content=cdnip.getIp()+"   "+cdnsale.getCuRealmName();
			request.setAttribute("hostpath", hostPath);
			request.setAttribute("hostcontent", content);

			
			///**************  插入到域名.conf文件
			String oldname="#cache_peer_name";
			String cache_peer_name="\ncache_peer "+cdnip.getIp()+" parent 80 0 no-query originserver no-digest name="+cdnsale.getCuRealmName();
			String cachePath="file/"+tmobil+"/"+cdnsale.getCuRealmName().replace(".", "_")+".conf";//合并下面的
			
			request.setAttribute("cachepath", cachePath);
			request.setAttribute("cachepeeroldname", oldname);
			request.setAttribute("cachepeername", cache_peer_name);
			

			oldname="#cache_peer_domain";
			String cache_peer_domain="\ncache_peer_domain "+cdnsale.getCuRealmName()+" "+cdnsale.getCuRealmName()+" "+ cdnsale.getSyRealmName();
			request.setAttribute("sourceFile", "file/"+tmobil+"/"+"template.conf");
			request.setAttribute("cachedomainoldname", oldname);
			request.setAttribute("cachedomainname", cache_peer_domain);
			
			
			//****************  插入到 域名conf文件
			String huancunflag="";
			String cachecontent="";
			String cuRealName=handleURL(cdnsale.getCuRealmName());
			System.out.println("curealName---->############---"+cuRealName);
			String aclPath="file/"+tmobil+"/acl.conf";//域名
			
			request.setAttribute("aclpath", aclPath);
			
			List<String[]> stt=new ArrayList<String[]>();
			for(Cache c:cachelist)
			{
				c.setCachecontent(c.getCachecontent().replace("/", "\\/"));
				if(c.getCacheflag().equals(1))//要缓存
				{
					huancunflag="#refresh_pattern";//要缓存
					String tf="";
					String time=c.getCachecontent();
					String st=time.substring(time.length()-1, time.length());
					if(st.equals("h"))//缓存单位小时
						tf=" 10 90% 60  ";
					else if(st.equals("d"))
						tf=" 60 90% 1440 ";
					else 
						tf=" 1440 90% 43200 ";
					cachecontent="refresh_pattern -i ^"+c.getCachecontent()+" "+tf+" reload-into-ims ignore-reload";	
				}else{///不缓存
					if(c.getCacheflag().equals(2))//判断    不 缓存目录
					{
						huancunflag="#Nocachehave?_path";///不缓存目录
						cachecontent="acl dy_cache urlpath_regex -i ^"
							+c.getCachecontent()+
							"/.*\\.(swf|html|htm|exe|css|js|cab|asp|aspx|php|jsp)?";
					}else{//  不缓存文件                      
						huancunflag="#Nocachehave?_path";//不缓存文件类型    纯静态1行，伪静态3行
						if(cdnsale.getSetmeal().getRealmtype().getName().equals("论坛伪静态"))
						{
							cachecontent="\nacl DIRECT url_regex -i ^"+c.getCachecontent()+"\\/$"+
										 "\nacl DIRECT url_regex -i ^"+c.getCachecontent()+"\\/.*$"+
										 "\nacl DIRECT url_regex -i ^"+c.getCachecontent()+"\\/index\\.html$";
						}else{
							cachecontent="\nacl DIRECT url_regex -i ^"+c.getCachecontent()+"\\/.("+c.getCachecontent()+")$";
						}
					}
				}
				String ss[]=new String[]{huancunflag,cachecontent};
				stt.add(ss);
			}
			request.setAttribute("callist", stt);
			
			
			return "showfile";
		}
		/**
		 * 
		 * **/
		public String savefile() throws Exception
		{
			String sourceFile=request.getParameter("sourceFile");//插入地址
			String cachepath=request.getParameter("cachepath");//插入地址
			String cachepeeroldname=request.getParameter("cachepeeroldname");//name标记名
			String cachepeername=request.getParameter("cachepeername");//插入内容
			String cachedomainoldname=request.getParameter("cachedomainoldname");//domain标记名
			String cachedomainname=request.getParameter("cachedomainname");//插入内容
			String path= getClass().getResource("/").getPath().substring(1).replace("%20", " ");
			response.setCharacterEncoding("UTF-8");
			FindXMLMake xml=new FindXMLMake();
			String cdnid=request.getParameter("cdnid");
			String message="";
			int f=0,fl=0;
			sourceFile=path+"file/template.conf";
			cachepath=path+cachepath;
			//host
			String hostpath=request.getParameter("hostpath");//插入地址
			String hostcontent=request.getParameter("hostcontent");//追加内容			
			
			File file = new File(sourceFile);
	        File file2= new File(cachepath);
	      //复制模板，生成域名对应的配置文件
			FileUtil.copyFile(file, file2,"UTF-8","UTF-8");//file2的文件路径跟名称根据域名的相关性来更改
			CDNsaleOrder cdnsale=cdnsaleorderbussiness.findCDNsaleOrderById(Integer.parseInt(cdnid));
			// 域名替换成例如"litscloud\.com"
			xml.updataFile(cachepath,"signcRealmName\\", cdnsale.getCuRealmName().replace("www.","").replace(".", "\\."));
			//替换生成后的配置文件中的通用信息
			xml.updataFile(cachepath,"cRealmName", cdnsale.getCuRealmName().replace("www.", ""));
			fl=xml.judgeStr(path+hostpath, hostcontent);//判断是否已经写入   0不存在，1已经存在
			if(fl==0)
			{
				f=xml.appendMethod(path+hostpath, hostcontent);
				if(f==1)
					System.out.println("插入"+path+hostpath+"文件成功！");
				else{
					message="0host文件插入失败！";
					response.getWriter().print(message);
					System.out.println("错误："+message);
					return null;
				}
			}		
			
			fl=xml.judgeStr(cachepath, cachepeername);//判断是否已经写入   0不存在，1已经存在
			if(fl==0)
			{							
				//找到对应的标签插入具体的内容
				f=xml.addNewCodeInBehind(file2.getPath(), cachepeeroldname, cachepeername);
				if(f==1)
					System.out.println("插入"+file2.getPath()+"文件"+cachepeeroldname+"成功！");
				else{
					message="域名.conf文件"+cachepeeroldname+"设置成功！";
					System.out.println("错误："+message);
					response.getWriter().print(message);
				}
			}						
			for(int i=0;;i++)
			{
				String huancunflag=request.getParameter("huancunflag"+i+"");//标记名
				String cachecontent=request.getParameter("cachecontent"+i+"");//插入内容
				
				
				if(huancunflag==null||"".equals(huancunflag))
					break;
				
				fl=xml.judgeStr(file2.getPath(), cachecontent);//判断是否已经写入   0不存在，1已经存在
				if(fl==0)
				{
					f=xml.addNewCodeInBehind(file2.getPath(), huancunflag, cachecontent);
					if(f==1)
						System.out.println("插入"+file2.getPath()+"文件"+huancunflag+"成功！");
					else{
						message="0acl.conf文件"+huancunflag+"插入失败！";
						System.out.println("错误："+message);
						response.getWriter().print(message);
						return null;
					}
				}
			}
			//获取到cdnasle 对象
			if(f==1)
			{								
				RealmType rety=cdnsale.getSetmeal().getRealmtype();
				rety.setTemp1(cdnsale.getSetmeal().getRealmtype().getTemp1()+" "+cdnsale.getCuRealmName());
				realmtypebussiness.updataObject(rety);
				
			}
			cdnsale.setWriteflag(1);
			realmtypebussiness.updataObject(cdnsale);
			message="所有文件插入成功！";
			System.out.println(message);
			response.getWriter().print(message);
			return null;
		}
		/**
		 * 网址处理   
		 * http://www.baidu.com/conf
		 * http:\/\/www\.baidu\.com\/conf
		 * **/
		public String handleURL(String url)
		{
			StringBuffer sb=new StringBuffer();
			int i=0;
			if(url.indexOf("/")>-1)
			{
				String st[]=url.split("/");
				for(i=0;i<st.length-1;i++)
					sb.append(st[i]+"\\\\/");
				sb.append(st[i]);
			}
			else
				sb.append(url);
			if(sb.indexOf(".")>-1)
			{
				String[] se=sb.toString().split(Pattern.quote("."));
				StringBuffer ses=new StringBuffer();
				for(i=0;i<se.length-1;i++)
				{
					if(se[i].substring(se[i].length()-1, se[i].length()).equals("/"))
						ses.append(se[i]+".");
					else ses.append(se[i]+"\\\\.");
				}
				ses.append(se[i]);
				return ses.toString();
			}
			return sb.toString();
		}
		
		
		//测试查询IP 地址
		public String ipselect() throws IOException {
			response.setCharacterEncoding("UTF-8");
			String ipaddress=request.getParameter("ip");
			String dir = IPSeeker.class.getResource("/").getPath()
			+ "qqwry";
			dir = dir.replace("%20", " ");
			IPSeeker ip = new IPSeeker("QQWry.Dat", dir);
			System.out.println((ip.getIPLocation(ipaddress).getCountry()));//地区名称
			System.out.println((ip.getIPLocation(ipaddress).getArea()));//运营商
			String address=ip.getIPLocation(ipaddress).getCountry();
			String area=ip.getIPLocation(ipaddress).getArea();
			if(area==null)
			{
				area="请选择！！";
			}
			response.getWriter().print(area+","+address);
			return null;
		}	
		//域名判断
		public String yuming() throws IOException
		{
			String cuRealmName=request.getParameter("cuRealmName");
			Customer customer=(Customer) request.getSession().getAttribute("customer");
		
			System.out.println(customer.getCustomerId());
			List<CDNsaleOrder> CDNso=realmtypebussiness.findObjectListByHQL(" from CDNsaleOrder where delFlag=0  and  customer.customerId="+customer.getCustomerId());
			if(CDNso.size()>0)
			{
				for(int i=0;i<CDNso.size();i++)
				{
					if(CDNso.get(i).getCuRealmName().equals(cuRealmName))
					{
						response.getWriter().print("0");
						return null;
					}
				}
			}
			response.getWriter().print("1");
			return null;
		}
		public static void main(String[] args) {
//			System.out.println(CDNsaleOrder.class.getResource("/file/template.conf").getPath());
//			String json1 = "{name=\"json\",bool:true,int:1,double:2.2,func:function(a){ return a; },array:[1,2]}";
//			JSONObject jsonObject1 = JSONObject.fromObject(json1);
//			Object bean1 = JSONObject.toBean(jsonObject1);
//			System.out.println(bean1);
//			String json2 = "{bool:true,integer:1,string:\"json\"}";
//			JSONObject jsonObject2 = JSONObject.fromObject(json1);
//			JSONArray  dd = JSONArray.fromObject(jsonObject1);
//			for (int i = 0; i < dd.size(); i++) {
//				System.out.println(dd.get(i));
//			}
//			BeanA bean2 = (BeanA) JSONObject.toBean(jsonObject2, BeanA.class);
//			System.out.println(bean2);
//			JsonArray ja = 
			
		   Calendar calendar = Calendar.getInstance(); //当前时间
		   calendar.set(Calendar.HOUR_OF_DAY, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
		   Long btime = calendar.getTimeInMillis();
		   calendar.add(Calendar.DATE, +1);
		   Long etime = calendar.getTimeInMillis();
			   String str = TimePattern1.doStringTime4(btime);
			   String str2 = TimePattern1.doStringTime4(etime);
			   System.out.println(btime);
			   System.out.println(etime);
			   System.out.println(etime-btime);
			   System.out.println((etime-btime)/288);
//			   Long ss = new Long(1368028800237);
//			   1368028800237
//			   86400000
//			   300000
			   
			   Long now = System.currentTimeMillis();
			   
			   
			   
			   
		}
}