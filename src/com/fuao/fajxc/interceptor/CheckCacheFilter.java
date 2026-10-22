package com.fuao.fajxc.interceptor;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.fuao.fajxc.action.cdnSystem.CdnSystemAction;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.vo.Customer;

public class CheckCacheFilter implements Filter {
	private static Logger logger = Logger.getLogger(CheckCacheFilter.class);
	public void destroy() {

	}
	
	public static void main(String[] args) {
		String uri = "/gn_afs/litscloud/ucenter/u_login.jsp";
		System.out.println(uri.indexOf("/litscloud/ucenter/")>=0);
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain filterChain) throws IOException, ServletException {
		 HttpServletRequest request = (HttpServletRequest)req;   
	       try
	       {
	    	   System.out.println("*********** : "+request.getRequestURL());
	    	    HttpServletResponse response = (HttpServletResponse)res;   
		       System.out.println("111111");
		        
		        String scheme = request.getScheme();			//http
				String servername = request.getServerName();	//ip
				int port = request.getServerPort();				//port
				String path = request.getServletPath();			//uri
				String name = request.getSession().getServletContext().getRealPath("/");	//tomcat   项目路径
				String objectname = "";
				int webapps = name.indexOf("webapps");
				
				if(webapps>0)
				{
					objectname = name.substring(webapps+8, name.length()-1);  //tocmat
				}
				
				System.out.println(scheme+"://"+servername+":"+port+"/"+objectname+path);
				String uri = request.getRequestURI();
				logger.info("uri-l : "+uri);
				String str = "/checkFiledCustomerServer.Action";
				logger.info("test="+str.indexOf("/checkFiledCustomerServer.Action"));
				Cookies cookies = new Cookies();
				String loginName = cookies.getCookie(request,"loginName");				
				//前台的登录用户
				Customer c = (Customer)request.getSession().getAttribute("customer");
				int before = uri.indexOf("/foreGroundFolder/");
				int beforelogin = uri.indexOf("/beforelogin.jsp");
				int skip = uri.indexOf(".Action");
				int mtp = uri.indexOf("/IDCServ/");
				//前台过滤
				logger.info(before>=0||beforelogin>=0||skip>=0 || mtp>=0);
				
				if(uri.indexOf("/litscloud/ucenter/")>=0){
					if(c == null &&  uri.indexOf("/litscloud/ucenter/u_login.jsp")< 0 && uri.indexOf("/litscloud/ucenter/u_logon.jsp")< 0 && uri.indexOf("/litscloud/ucenter/bg_zhaopass.jsp")< 0){
						response.sendRedirect(""+scheme+"://"+servername+":"+port+"/"+objectname+"/litscloud/ucenter/u_login.jsp");
						return;
					}else{
						filterChain.doFilter(req, res);
						return ;
					}
				}
				if(uri.indexOf("/client/")>0 && uri.endsWith(".Action")){
					filterChain.doFilter(req, res);
					return;
				}
				if(before>=0||beforelogin>=0||skip>=0 || mtp>=0)
				{
					
					if(uri.indexOf("getbackPasswordByEmailCustomerServer.Action")>=0)
					{
						System.out.println("getbackPasswordByEmailCustomerServer.Action");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("customerIsActiveCustomerServer.Action")>=0)
					{
						System.out.println("customerIsActiveCustomerServer.Action");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("editpasswordCustomerServer.Action")>=0)
					{
						System.out.println("editpasswordCustomerServer.Action");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/customProscenium/login.jsp")>=0)
					{
						System.out.println("befor login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("customerLoginCustomerServer.Action")>=0)
					{
						System.out.println("befor .do login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}else if(uri.indexOf("/IDCServ/payMoney.jsp")>=0){
						filterChain.doFilter(req, res);
						return ;
					}else if(uri.indexOf("/paycheckOnlinepayment.Action")>=0){
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("customerLoginCustomerServerC.Action")>=0 || uri.indexOf("litscloudUserLoginCustomerServerC.Action")>=0)
					{
						System.out.println("befor .do login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}
				
					else if(uri.indexOf("/customProscenium/register.jsp")>=0)
					{
						System.out.println("register  .jsp ");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/customerRegisterCustReg.Action")>=0)
					{
						System.out.println("customerRegisterCustReg.do  .jsp ");
						filterChain.doFilter(req, res);
						return ;
					}
					else if (uri.indexOf("/beforelogin.jsp")>=0)
					{
						System.out.println("beforelogin.jsp .do login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}
					else if (uri.indexOf("/checkFiledCustomerServer.Action")>=0)
					{
						logger.info("checkFiledCustomerServer.do .do login.jsp");
						System.out.println(" 1. uri : "+uri);
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/sendpass")>=0)
					{
						System.out.println("sendpass .do login.jsp");
						System.out.println(" 1. uri : "+uri);
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/userLoginCdnSystemAction")>=0)
					{
						filterChain.doFilter(req, res);				
						return ;
					}

					else if(uri.indexOf("/updateCdnSystemAction")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/cdnSystem/")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/selectUrlCdnSystemAction")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("litscloudgetprodutCustomerServerC.Action")>=0){
                    	filterChain.doFilter(req, res);
                    	return ;
                    }
					else if(uri.indexOf("faEmailCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("yanZhengMaCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("zhaoHuiPasswordCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					
						else if(uri.indexOf("detailWarehousing.do")>=0)
						{
							
							filterChain.doFilter(req, res);
							return ;
						}	
						else if(uri.indexOf("detailWarehousing.do")>=0)
						{
							
							filterChain.doFilter(req, res);
							return ;
						}	
					else if(uri.indexOf("customerRegister1CustReg.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/customerRegister1CustReg.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("litscloudUserLogoutCustomerServerC.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("updatePhoneCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("updateEmailCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("yanZhengMaLogonCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectEmailCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("updateAuthorizationCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/updateAuthorizationCustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("yanZhengMa3CustomerServer.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("uploademp.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("uploademp1.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("listPayCustReg.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}


                	else if(uri.indexOf("(/newwarehousingInfoWarehousing.do")>=0)
{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/listPayCustReg.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("ceshiCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}else if(uri.indexOf("selectIP1CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("delGroup1CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("clearCache1mission.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("clearCache2mission.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectJieDian1mission.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("openServiceCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}else if(uri.indexOf("liuliangtu2CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("liuliangtu3CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
//					else if(uri.indexOf("CustomerServer.Action")>=0)
//					{
//						System.out.println("CustomerServer.do .do login.jsp");
//						System.out.println(" 1. CustomerServer.do : "+uri);
//						filterChain.doFilter(req, res);
//						return ;
//					}
//					else if (uri.indexOf("Jsontest.Action")>=0)
//					{
//						System.out.println("*Jsontest .do login.jsp");
//						System.out.println(" 1. CustomerServer.do : "+uri);
//						filterChain.doFilter(req, res);
//						return ;
//					}
					else
					{

						logger.info("the last else");
						if(c==null && uri.indexOf("/litscloud/web/")<0 && uri.indexOf("/cms/web")<0)
						{
							logger.info("the last else--1");
//							response.getWriter().print("<script type='text/javascript'>top.location.href('"+scheme+"://"+servername+":"+port+"/"+objectname+"/litscloud/ucenter/u_login.jsp"+"');</script>");//response.sendRedirect(scheme+"://"+servername+":"+port+"/"+objectname+"/beforelogin.jsp");
							response.sendRedirect(""+scheme+"://"+servername+":"+port+"/"+objectname+"/litscloud/ucenter/u_login.jsp");
							return ;
						}
						else
						{
							logger.info("the last else--2");
							filterChain.doFilter(req, res);
							return ;
						}
					}
				}
				else		//后台过滤
				{
                    if(uri.indexOf("/cms/")!=-1){
                    	filterChain.doFilter(req, res);
						return ;
                    }
                    else if(uri.indexOf("doUpload2upload.do")!=-1){
                    	filterChain.doFilter(req, res);
                    	return;
                    }
                    else if(uri.indexOf("potalsLogin.do")!=-1){
                    	filterChain.doFilter(req, res);
                    	return;
                    }
//                    else if(uri.indexOf("changeShowMenuLogin.do")!=-1){
//                    	filterChain.doFilter(req, res);
//                    	return;
//                    }
                    else if(uri.indexOf("closeSystemLogin.do")!=-1){
                    	filterChain.doFilter(req, res);
                    	return;
                    }else if(uri.indexOf("getempFault.do")!=-1){
                    	filterChain.doFilter(req, res);
                    	return;
                    }else if(uri.indexOf("returnForeLogin.do")!=-1){
                    	filterChain.doFilter(req, res);
                    	return;
                    }
                    else if(uri.indexOf("/pdm/")!=-1){
                    	filterChain.doFilter(req, res);
                    	return ;
                    }
               
                    else if(uri.indexOf("/FAJxc/showMessagenewProject.do")>=0){
    						filterChain.doFilter(req, res);
    						return ;
    					}
                    else if(uri.indexOf("getDeptllsposition.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}

                    else if(uri.indexOf("outSystemsCustomerServer.do")>=0){
                    	filterChain.doFilter(req, res);
                    	return ;
                    }
                    
                    else if(uri.indexOf("litscloudgetprodutCustomerServerC.Action")>=0){
                    	filterChain.doFilter(req, res);
                    	return ;
                    }
                    else if(uri.indexOf("checkEmployeeNumsCustomerServer.do")>=0){
                    	filterChain.doFilter(req, res);
                    	return ;
                    	
                    }else if(uri.indexOf("qrOrderCustomerServer.do")>=0){
                    	
                    	filterChain.doFilter(req, res);
                    	return ;
                    }
                    else if(uri.indexOf("editPersionDataCustomerServer.Action")>=0){
                    	filterChain.doFilter(req, res);
						return ;
                    }
               
                    else if(uri.indexOf("getQuestionCategoryListHandleJson.do")>=0){
                    	filterChain.doFilter(req, res);
						return ;
                    }
                    else if(uri.indexOf("/login.jsp")>=0)
					{
						System.out.println("after login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}
                    else if(uri.indexOf("qdorderCustomerServer.do")>=0){
                    	filterChain.doFilter(req, res);
						return ;
                    }
                    else if(uri.indexOf("defineorderCustomerServer.do")>=0)
					{
						System.out.println("after login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("UserLogin.do")>=0)
					{
						System.out.println("after .do login.jsp");
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("User2Login.do")>=0)
					{
						System.out.println("after .do login.jsp");
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selOrderCustomerServer.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}else if(uri.indexOf("customFlowCustomerServer.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}
						else if(uri.indexOf("selgrmessangeCustomerServer.do")>=0){
							filterChain.doFilter(req, res);
							return ;
						}
					else if(uri.indexOf("checkOrderCustomerServer.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("delWorkallsposition.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}

					else if(uri.indexOf("newwarehousingInfoWarehousing.do")>=0)

					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/FAJxc/selectallOtherDayWorkLogNewportal.do")>=0)

					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/FAJxc/selectallOtherMonthWorkLogNewportal.do")>=0)

					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/FAJxc/selectallOtherWeekWorkLogNewportal.do")>=0)

					{
						
						filterChain.doFilter(req, res);
						return ;
					}
                  
					else if(uri.indexOf("addoreditWorkallsposition.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}
                  
                    	 
					else if(uri.indexOf("checkOrderCustomerServer.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}	

					else if(uri.indexOf("gosubnoteMalfunctionDeclare.do")>=0)
					{
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("payMemberOnlinepayment.Action")>=0){
						filterChain.doFilter(req,res);
						return ;
					}else if(uri.indexOf("doUploadupload.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}else if(uri.indexOf("doUpload2upload.do")>=0){
						filterChain.doFilter(req, res);
						return ;
					}
					else if (uri.indexOf("/afterlogin.jsp")>=0)
					{
						System.out.println("afterlogin .do login.jsp");
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("uploademp.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("upload1emp.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}

					else if(uri.indexOf("listPayCustReg.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("/listPayCustReg.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("ceshiCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectIP1CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("delGroupCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
                    
                    	else if(uri.indexOf("waitapptaskTaskProject.do")>=0)
    					{
    						
    						filterChain.doFilter(req, res);
    						return ; 
    					}	
                    	else if(uri.indexOf("warehousingInfoWarehousing.do")>=0)
    					{
    						
    						filterChain.doFilter(req, res);
    						return ;
    					}	
					else if(uri.indexOf("addSelectGroup1CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("delGroup1CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("clearCache1mission.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("clearCache2mission.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectJieDian1mission.Action")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("openServiceCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("liuliangtu2CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("liuliangtu3CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectFlowTypeCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectFlowType1CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectISPTypeCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectFlowCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectFlowTypeTimeCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectISPTypeTimeCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectFlowTimeCDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("liuliangtu4CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("selectFlowType2CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else if(uri.indexOf("liuliangtu5CDNsaleOrderAction.do")>=0)
					{
						
						filterChain.doFilter(req, res);
						return ;
					}
					else
					{
						System.out.println(" after  else ");
						if(loginName==null||loginName.equals("") ||request.getSession() == null || request.getSession().getAttribute("emp") == null)		//为null，跳转到后台登录页面
						{
							response.getWriter().print("<script type='text/javascript'>top.location.href('"+scheme+"://"+servername+":"+port+"/"+objectname+"/login.jsp"+"');</script>");//(scheme+"://"+servername+":"+port+"/"+objectname+"/afterlogin.jsp");
//							response.sendRedirect(""+scheme+"://"+servername+":"+port+"/"+objectname+"/login.jsp");
							return ;
						}
						else 												//不为null，执行url
						{
							filterChain.doFilter(req, res);
							return ;
						}
					}
				}
	       }
	       catch(Exception e)
	       {
	    	   e.printStackTrace();
	       }
	}

	public void init(FilterConfig arg0) throws ServletException {

	}
//	public static void main(String[] args) {
//		String str = "/checkFiledCustomerServer.Action";
//		logger.info(str.indexOf("/checkFiledCustomerServer.Action"));
//	}
}
