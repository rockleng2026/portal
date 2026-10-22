package com.fuao.fajxc.action.cdnSystem;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.cdnSystem.CdnSystemBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CdnDirRefresh;
import com.fuao.fajxc.vo.CdnDomain;
import com.fuao.fajxc.vo.CdnFlow;
import com.fuao.fajxc.vo.CdnReferer;
import com.fuao.fajxc.vo.CdnUrlRefresh;
import com.fuao.fajxc.vo.CdnUser;
import com.fuao.fajxc.vo.cdnDay;
import com.fuao.fajxc.vo.cdnMonth;
import com.fuao.fajxc.vo.cdnToday;
import com.opensymphony.xwork2.ModelDriven;

public  class CdnSystemAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CdnSystemBussiness cdnSystemBussiness;
	private CdnUser cdnUser;
	
	
	public CdnUser getCdnUser() {
		return cdnUser;
	}

	public void setCdnUser(CdnUser cdnUser) {
		this.cdnUser = cdnUser;
	}

	public Object getModel() {
		cdnUser =new CdnUser();
		return cdnUser;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;

	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;

	}
	
	//增加
	public String addCdnDir()
	{
		int count =Integer.parseInt(request.getParameter("count"));
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		CdnDirRefresh cdr;
		for(int i=1;i<=count;i++)
		{
			cdr=new CdnDirRefresh();
			String url=request.getParameter("url"+i+"");
			String dateTime=request.getParameter("dateTime"+i+"");
			cdr.setUserName(cu);
			cdr.setUrl(url);
			cdr.setDateTime(dateTime);
			cdr.setDel(0);
			try {
				cdnSystemBussiness.addObject(cdr);
			} catch (Exception e) {
				return "no";
			}
			
		}
		
		return "addDir";
	}
	public String addCdnUrl()
	{
		int count =Integer.parseInt(request.getParameter("count"));
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		CdnUrlRefresh cur;
		for(int i=1;i<=count;i++)
		{
			cur=new CdnUrlRefresh();
			String url=request.getParameter("url"+i+"");
			String dateTime=request.getParameter("dateTime"+i+"");
			cur.setUserName(cu);
			cur.setUrl(url);
			cur.setDateTime(dateTime);
			cur.setDel(0);
			try {
				
				cdnSystemBussiness.addObject(cur);
			} catch (Exception e) {
				return "no";
			}
			
		}
		
		return "addurl";
	}
	//修改账户信息
	public String update()
	{
		String hql="update CdnUser set password='"+cdnUser.getPassword()+"',email='"+cdnUser.getEmail()+"', apiPassword='"+cdnUser.getApiPassword()+"' where id="+cdnUser.getId()+"";
		int mark= cdnSystemBussiness.updataByHQL(hql);
		if(mark>0)
		{
			return "cdnIndex";
		}
		return "no";
	}
	//修改用户信息
	public String updateUser()
	{
		String hql="update CdnUser set " +
						"userCompany='"+cdnUser.getUserCompany()+"'," +
						"userName='"+cdnUser.getUserName()+"'," +
						"userPost='"+cdnUser.getUserPost()+"'," +
						"phone="+cdnUser.getPhone()+"," +
						"email='"+cdnUser.getEmail()+"'," +
						"fax='"+cdnUser.getFax()+"'," +
						"QQ="+cdnUser.getQQ()+"," +
						"mark='"+cdnUser.getMark()+"' where id="+cdnUser.getId()+"";
		int mark= cdnSystemBussiness.updataByHQL(hql);
		if(mark>0)
		{
			return "cdnIndex";
		}
		return "no";
	}
	//修改url
	public String  updateUrl()
	{
		String id=request.getParameter("id");
		String url=request.getParameter("url");
		String dateTime=request.getParameter("dateTime");
		String hql="update CdnUrlRefresh set url='"+url+"',dateTime='"+dateTime+"' where id="+Integer.parseInt(id)+"";
		int mark= cdnSystemBussiness.updataByHQL(hql);
		if(mark>0)
			return "updateUrl";
		return null;
	}
	//修改url目录
	public String  updateDir()
	{
		String id=request.getParameter("id");
		String url=request.getParameter("url");
		String dateTime=request.getParameter("dateTime");
		String hql="update CdnDirRefresh set url='"+url+"',dateTime='"+dateTime+"' where id="+Integer.parseInt(id)+"";
		int mark= cdnSystemBussiness.updataByHQL(hql);
		if(mark>0)
			return "dirUrl";
		return "no";
	}
	//删除url
	public void delUrl() throws IOException
	{
		String delid=request.getParameter("delId");
		CdnFlow a=new CdnFlow();
		
		String hql="update CdnUrlRefresh set del=1 where id="+Integer.parseInt(delid)+"";
		int mark= cdnSystemBussiness.updataByHQL(hql);
		if(mark>0)
		{
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
		
	}
	//删除url目录
	public void delDir() throws IOException
	{
		String delid=request.getParameter("delId");
		
		String hql="update CdnDirRefresh set del=1 where id="+Integer.parseInt(delid)+"";
		int mark= cdnSystemBussiness.updataByHQL(hql);
		if(mark>0)
		{
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
		
	}
	//查询url集合
	public String selectUrl()
	{
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		
		String hql="from CdnUrlRefresh where  userName="+cu.getId()+" and del=0 order by id desc";
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		Pages pages=cdnSystemBussiness.exePagesList(hql, Integer.parseInt(pageNo), 20, null);
		
		request.setAttribute("pages", pages);
		return "urlList";
	}
	//查询url目录集合
	public String selectDir()
	{
		
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		
		String hql="from CdnDirRefresh where  userName="+cu.getId()+" and del=0 order by id desc";
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		Pages pages=cdnSystemBussiness.exePagesList(hql, Integer.parseInt(pageNo), 20, null);
		
		request.setAttribute("pages", pages);
		return "dirList";
	}
	//查询某一个实体
	public String selctInfo()
	{
		return "aa";
	}
	
	//用户登录
	public String userLogin() throws IOException
	{
		System.out.println("aaaa");
		String loginUserName=request.getParameter("loginUserName");
		String password=request.getParameter("password");
		
		String hql="from CdnUser where loginUserName='"+loginUserName+"' and password='"+password+"'";
		List<CdnUser> cdnUser=cdnSystemBussiness.findObjectListByHQL(hql);
		
		//域名结合
		String hql1="from  CdnDomain where  cdnUser="+cdnUser.get(0).getId()+" order by id desc";
		List<CdnDomain> cdnDomain=cdnSystemBussiness.findObjectListByHQL(hql1);
		
		request.getSession().setAttribute("cdnDomain", cdnDomain);
		
		//加载首页的图表值
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currTime = new java.util.Date();
		int year = currTime.getYear();//年
		int month = currTime.getMonth()+1;//月
		int week = currTime.getDay(); //星期几
		int day = currTime.getDate();//日
		int hours=currTime.getHours();//时
		int minutes=currTime.getMinutes();//分
		int seconds=currTime.getSeconds();//秒
		
		String month1;
		String day1;
		if(month<10)
		{
			month1="0"+month+"";
		}
		else
		{
			month1=""+month+"";
		}
		if(day<10)
		{
			day1="0"+day+"";
		}
		else
		{
			day1=""+day+"";
		}
		String dateTime=""+(year+1900)+""+month1+""+day1+"";
		
		//查找当前用户最后增加的域名流量
		cdnToday ct=new cdnToday();
		String hql2="from CdnFlow where domain='"+cdnDomain.get(0).getDomain()+"' and cdnUser="+cdnUser.get(0).getId()+"";
		List<CdnFlow> cdnFlow=cdnSystemBussiness.findObjectListByHQL(hql2);
		for(int i=0;i<cdnFlow.size();i++)
		{
			int dt=Integer.parseInt(cdnFlow.get(i).getDateTime());
			if(dt==Integer.parseInt(""+dateTime+"00"))
			{
				ct.setaHours(ct.getaHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"00")&&dt<=Integer.parseInt(""+dateTime+"02"))
			{
				ct.setbHours(ct.getbHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"02")&&dt<=Integer.parseInt(""+dateTime+"04"))
			{
				ct.setcHours(ct.getcHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"04")&&dt<=Integer.parseInt(""+dateTime+"06"))
			{
				ct.setdHours(ct.getdHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"06")&&dt<=Integer.parseInt(""+dateTime+"08"))
			{
				ct.seteHours(ct.geteHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"08")&&dt<=Integer.parseInt(""+dateTime+"10"))
			{
				ct.setfHours(ct.getfHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"10")&&dt<=Integer.parseInt(""+dateTime+"12"))
			{
				ct.setgHours(ct.getgHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"12")&&dt<=Integer.parseInt(""+dateTime+"14"))
			{
				ct.sethHours(ct.gethHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"14")&&dt<=Integer.parseInt(""+dateTime+"16"))
			{
				ct.setiHours(ct.getiHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"16")&&dt<=Integer.parseInt(""+dateTime+"18"))
			{
				ct.setjHours(ct.getjHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"18")&&dt<=Integer.parseInt(""+dateTime+"20"))
			{
				ct.setkHours(ct.getkHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"20")&&dt<=Integer.parseInt(""+dateTime+"22"))
			{
				ct.setlHours(ct.getlHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"22")&&dt<=Integer.parseInt(""+dateTime+"24"))
			{
				ct.setmHours(ct.getmHours()+cdnFlow.get(i).getTraffic());
			}
		}
		
		request.getSession().removeAttribute("ct");
		request.getSession().setAttribute("ct", ct);//每天流量返回
		if(cdnUser.size()>0)
		{
			request.getSession().setAttribute("user", cdnUser.get(0));
			response.getWriter().print("0");
			
			return null;
		}
		
		response.getWriter().print("1");
			
		return "no";
	}
	
	//查询今天流量
	public void selectFlowToday() throws IOException
	{
		String domain=request.getParameter("domain");
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currTime = new java.util.Date();
		int year = currTime.getYear();//年
		int month = currTime.getMonth()+1;//月
		int week = currTime.getDay(); //星期几
		int day = currTime.getDate();//日
		int hours=currTime.getHours();//时
		int minutes=currTime.getMinutes();//分
		int seconds=currTime.getSeconds();//秒
		
		
		String month1;
		String day1;
		if(month<10)
		{
			month1="0"+month+"";
		}
		else
		{
			month1=""+month+"";
		}
		if(day<10)
		{
			day1="0"+day+"";
		}
		else
		{
			day1=""+day+"";
		}
		String dateTime=""+(year+1900)+""+month1+""+day1+"";
		
		//查找当前用户最后增加的域名流量
		cdnToday ct=new cdnToday();
		String hql2="from CdnFlow where domain='"+domain+"' and cdnUser="+cu.getId()+"";
		List<CdnFlow> cdnFlow=cdnSystemBussiness.findObjectListByHQL(hql2);
		for(int i=0;i<cdnFlow.size();i++)
		{
			int dt=Integer.parseInt(cdnFlow.get(i).getDateTime());
			if(dt==Integer.parseInt(""+dateTime+"00"))
			{
				ct.setaHours(ct.getaHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"00")&&dt<=Integer.parseInt(""+dateTime+"02"))
			{
				ct.setbHours(ct.getbHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"02")&&dt<=Integer.parseInt(""+dateTime+"04"))
			{
				ct.setcHours(ct.getcHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"04")&&dt<=Integer.parseInt(""+dateTime+"06"))
			{
				ct.setdHours(ct.getdHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"06")&&dt<=Integer.parseInt(""+dateTime+"08"))
			{
				ct.seteHours(ct.geteHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"08")&&dt<=Integer.parseInt(""+dateTime+"10"))
			{
				ct.setfHours(ct.getfHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"10")&&dt<=Integer.parseInt(""+dateTime+"12"))
			{
				ct.setgHours(ct.getgHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"12")&&dt<=Integer.parseInt(""+dateTime+"14"))
			{
				ct.sethHours(ct.gethHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"14")&&dt<=Integer.parseInt(""+dateTime+"16"))
			{
				ct.setiHours(ct.getiHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"16")&&dt<=Integer.parseInt(""+dateTime+"18"))
			{
				ct.setjHours(ct.getjHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"18")&&dt<=Integer.parseInt(""+dateTime+"20"))
			{
				ct.setkHours(ct.getkHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"20")&&dt<=Integer.parseInt(""+dateTime+"22"))
			{
				ct.setlHours(ct.getlHours()+cdnFlow.get(i).getTraffic());
			}
			else if(dt>Integer.parseInt(""+dateTime+"22")&&dt<=Integer.parseInt(""+dateTime+"24"))
			{
				ct.setmHours(ct.getmHours()+cdnFlow.get(i).getTraffic());
			}
		}
		String aaa="<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='流量图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='MB' formatNumberScale='0'><categories>";
	    aaa+="<category label='0时' /><category label='12时' /><category label='4时' /><category label='6时' /><category label='8时' /><category label='10时' /><category label='12时' /><category label='14时' /><category label='16时' /><category label='18时' /><category label='20时' /><category label='22时' /><category label='24时' />";
	    aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量(今天流量2小时统计一次)'><set value='"+ct.getaHours()+"' /><set value='"+ct.getbHours()+"' /><set value='"+ct.getcHours()+"' /><set value='"+ct.getdHours()+"' /><set value='"+ct.geteHours()+"' /><set value='"+ct.getfHours()+"' /><set value='"+ct.getgHours()+"' /><set value='"+ct.gethHours()+"' /><set value='"+ct.getiHours()+"' /><set value='"+ct.getjHours()+"' /><set value='"+ct.getkHours()+"' /><set value='"+ct.getlHours()+"' /><set value='"+ct.getmHours()+"' /></dataset>";
	  	aaa+="</chart>";
	  	System.out.println(aaa);
	  	response.setContentType("text/html;charset=GBK");

		response.getWriter().print(aaa);
		
		
	}
	
	//查询7天流量
	public void selectFlowDay() throws IOException, ParseException
	{
		String domain=request.getParameter("domain");
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currTime = new java.util.Date();
		cdnDay cd=new cdnDay();
		String[] dataString=new String[7];
		    for(int i=1;i<8;i++)
		    {
		    	
		    	Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
		    	calendar.add(Calendar.DATE, -i); 
		    	int year=calendar.get(Calendar.YEAR);//年
		    	int month1=calendar.get(Calendar.MONTH);//月
		    	int date1=calendar.get(Calendar.DATE);//日
		    	System.out.println(Calendar.getInstance());
		    	String month;
		    	String date;
		    	if(date1<10)
		    	{
		    		date="0"+date1+"";
		    	}
		    	else
		    	{
		    		date=""+date1+"";
		    	}
		    	if(month1<9)
		    	{
		    		month="0"+(month1+1)+"";
		    	}
		    	else
		    	{
		    		month=""+(month1+1)+"";
		    	}
		    	
		    	//获取
		    	Calendar mcalendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
		    	if(i!=1)
		    	{
		    		int a=i-1;
		    		mcalendar.add(Calendar.DATE, -a); 
		    	}
		    	int myear=mcalendar.get(Calendar.YEAR);//年
		    	int mmonth1=mcalendar.get(Calendar.MONTH);//月
		    	int mdate1=mcalendar.get(Calendar.DATE);//日
		  
		    	
		    	String mmonth;
		    	String mdate;
		    	if(mdate1<10)
		    	{
		    		mdate="0"+mdate1+"";
		    	}
		    	else
		    	{
		    		mdate=""+mdate1+"";
		    	}
		    	if(month1<9)
		    	{
		    		mmonth="0"+(mmonth1+1)+"";
		    	}
		    	else
		    	{
		    		mmonth=""+(mmonth1+1)+"";
		    	}
		    	String dateTime=""+year+""+month+""+date+""+0+""+0+"";
		    	String mdateTime=""+myear+""+mmonth+""+mdate+""+0+""+0+"";
		    	dataString[i-1]=""+month+"-"+date+"";
		    	
		    	String hql="from CdnFlow where domain='"+domain+"' and cdnUser="+cu.getId()+" and (dateTime >= '"+dateTime+"' and dateTime < '"+mdateTime+"')";
				List<CdnFlow> cdnFlow=cdnSystemBussiness.findObjectListByHQL(hql);
				for(int j=0;j<cdnFlow.size();j++)
				{
					
					if(i==1)
					{
						cd.setgDay(cd.getgDay()+cdnFlow.get(j).getTraffic());
					}
					else if(i==2)
					{
						cd.setfDay(cd.getfDay()+cdnFlow.get(j).getTraffic());
					}
					else if(i==3)
					{
						cd.seteDay(cd.geteDay()+cdnFlow.get(j).getTraffic());
					}
					else if(i==4)
					{
						cd.setdDay(cd.getdDay()+cdnFlow.get(j).getTraffic());
					}
					else if(i==5)
					{
						cd.setcDay(cd.getcDay()+cdnFlow.get(j).getTraffic());
					}
					else if(i==6)
					{
						cd.setbDay(cd.getbDay()+cdnFlow.get(j).getTraffic());
					}
					else if(i==7)
					{
						cd.setaDay(cd.getaDay()+cdnFlow.get(j).getTraffic());
					}
				}
				
		    	
		    }
		
		
		
	
		
		    String aaa="<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='流量图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='MB' formatNumberScale='0'><categories>";
		    aaa+="<category label='0' /><category label='"+dataString[6]+"' /><category label='"+dataString[5]+"' /><category label='"+dataString[4]+"' /><category label='"+dataString[3]+"' /><category label='"+dataString[2]+"' /><category label='"+dataString[1]+"' /><category label='"+dataString[0]+"' />";
		    aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量(每天统计一次)'><set value='0' /><set value='"+cd.getaDay()+"' /><set value='"+cd.getbDay()+"' /><set value='"+cd.getcDay()+"' /><set value='"+cd.getdDay()+"' /><set value='"+cd.geteDay()+"' /><set value='"+cd.getfDay()+"' /><set value='"+cd.getgDay()+"' /></dataset>";
		  	aaa+="</chart>";
		  	
		  	response.setContentType("text/html;charset=GBK");

			response.getWriter().print(aaa);	
	}


	//查询一个月流量
	public void selectFlowTopMonth() throws IOException, ParseException
	{
		String domain=request.getParameter("domain");
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currTime = new java.util.Date();
	
		
		Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
		calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) -1);  
		//calendar.add(Calendar.DATE, -i); 
		int year=calendar.get(Calendar.YEAR);//年
		int month1=calendar.get(Calendar.MONTH);//月
		int date1=calendar.get(Calendar.DATE);//日
		
		int num=calendar.getActualMaximum(Calendar.DAY_OF_MONTH);//上月多少天
		String month;
    	String date;
    	if(date1<10)
    	{
    		date="0"+date1+"";
    	}
    	else
    	{
    		date=""+date1+"";
    	}
    	if(month1<9)
    	{
    		month="0"+(month1+1)+"";
    	}
    	else
    	{
    		month=""+(month1+1)+"";
    	}
    	
    	Calendar bcalendar = Calendar.getInstance();  
    	// 设置Calendar月份数为本个月  
    	bcalendar.set(Calendar.MONTH, bcalendar.get(Calendar.MONTH) -2);  
    	
    	int byear=bcalendar.get(Calendar.YEAR);//年
		int bmonth1=bcalendar.get(Calendar.MONTH);//月
		
		int bnum=bcalendar.getActualMaximum(Calendar.DAY_OF_MONTH);//上2个月多少天
		String bmonth;
    	
    	if(month1<9)
    	{
    		bmonth="0"+(bmonth1+1)+"";
    	}
    	else
    	{
    		bmonth=""+(bmonth1+1)+"";
    	}
    	
    	String benMonth=""+year+""+month+""+num+""+2+""+3+"";//本月最后一天的日期
    	String topMonth=""+byear+""+bmonth+""+bnum+""+2+""+3+"";//上月最后一天的日期
    	System.out.println(benMonth);
    	System.out.println(topMonth);
		
    	String hql="from CdnFlow where domain='"+domain+"' and cdnUser="+cu.getId()+" and (dateTime > '"+topMonth+"' and dateTime <= '"+benMonth+"')";
		List<CdnFlow> cdnFlow=cdnSystemBussiness.findObjectListByHQL(hql);
		
		cdnMonth cm=new cdnMonth();
		for(int i=0;i<cdnFlow.size();i++)
		{
			if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(topMonth)&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+1+""+0+""+0+""))
			{
				cm.setaMonth(cm.getaMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+1+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+2+""+0+""+0+""))
			{
				cm.setbMonth(cm.getbMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+2+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+3+""+0+""+0+""))
			{
				cm.setcMonth(cm.getcMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+3+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+4+""+0+""+0+""))
			{
				cm.setdMonth(cm.getdMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+4+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+5+""+0+""+0+""))
			{
				cm.seteMonth(cm.geteMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+5+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+6+""+0+""+0+""))
			{
				cm.setfMonth(cm.getfMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+6+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+7+""+0+""+0+""))
			{
				cm.setgMonth(cm.getgMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+7+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+8+""+0+""+0+""))
			{
				cm.sethMonth(cm.gethMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+8+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+9+""+0+""+0+""))
			{
				cm.setiMonth(cm.getiMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+9+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+10+""+0+""+0+""))
			{
				cm.setjMonth(cm.getjMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+10+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+11+""+0+""+0+""))
			{
				cm.setkMonth(cm.getkMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+11+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+12+""+0+""+0+""))
			{
				cm.setlMonth(cm.getlMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+12+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+13+""+0+""+0+""))
			{
				cm.setmMonth(cm.getmMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+13+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+14+""+0+""+0+""))
			{
				cm.setnMonth(cm.getnMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+14+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+15+""+0+""+0+""))
			{
				cm.setoMonth(cm.getoMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+15+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+16+""+0+""+0+""))
			{
				cm.setpMonth(cm.getpMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+16+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+17+""+0+""+0+""))
			{
				cm.setqMonth(cm.getqMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+17+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+18+""+0+""+0+""))
			{
				cm.setrMonth(cm.getrMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+18+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+19+""+0+""+0+""))
			{
				cm.setsMonth(cm.getsMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+19+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+20+""+0+""+0+""))
			{
				cm.settMonth(cm.gettMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+20+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+21+""+0+""+0+""))
			{
				cm.setuMonth(cm.getuMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+21+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+22+""+0+""+0+""))
			{
				cm.setvMonth(cm.getvMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+22+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+23+""+0+""+0+""))
			{
				cm.setwMonth(cm.getwMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+23+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+24+""+0+""+0+""))
			{
				cm.setxMonth(cm.getxMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+24+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+25+""+0+""+0+""))
			{
				cm.setyMonth(cm.getyMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+25+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+26+""+0+""+0+""))
			{
				cm.setzMonth(cm.getzMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+26+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+27+""+0+""+0+""))
			{
				cm.setAaMonth(cm.getAaMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+27+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+28+""+0+""+0+""))
			{
				cm.setAbMonth(cm.getAbMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+28+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+29+""+0+""+0+""))
			{
				cm.setAcMonth(cm.getAcMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+29+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+30+""+0+""+0+""))
			{
				cm.setAdMonth(cm.getAdMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+30+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+31+""+0+""+0+""))
			{
				cm.setAeMonth(cm.getAeMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+31+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+31+""+2+""+3+""))
			{
				cm.setAfMonth(cm.getAfMonth()+cdnFlow.get(i).getTraffic());
			}
			
			
		}
		
		 String aaa="<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='流量图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='MB' formatNumberScale='0'><categories>";
		 if(num==28)
		 {
			 

			 for(int i=0;i<29;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' />" +
					"</dataset>";
		 }
		 else if(num==29)
		 {
			 

			 for(int i=0;i<30;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' /><set value='"+cm.getAdMonth()+"' />" +
					"</dataset>";
		 }
		 else if(num==31)
		 {

			 for(int i=0;i<32;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' /><set value='"+cm.getAdMonth()+"' />" +
					"<set value='"+cm.getAeMonth()+"' /></dataset>";
		 }
		 else
		 {
			 for(int i=0;i<32;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' /><set value='"+cm.getAdMonth()+"' />" +
					"<set value='"+cm.getAeMonth()+"' /><set value='"+cm.getAfMonth()+"' /></dataset>";
		 }
		aaa+="</chart>";
		  	
		  	response.setContentType("text/html;charset=GBK");

			response.getWriter().print(aaa);	
		   		
	}

	//查询一个月流量
	public void selectFlowMonth() throws IOException, ParseException
	{
		String domain=request.getParameter("domain");
		CdnUser cu=(CdnUser) request.getSession().getAttribute("user");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currTime = new java.util.Date();
	
		
		Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
		//calendar.add(Calendar.DATE, -i); 
		int year=calendar.get(Calendar.YEAR);//年
		int month1=calendar.get(Calendar.MONTH);//月
		int date1=calendar.get(Calendar.DATE);//日
		
		int num=calendar.getActualMaximum(Calendar.DAY_OF_MONTH);//b月多少天
		String month;
    	String date;
    	if(date1<10)
    	{
    		date="0"+date1+"";
    	}
    	else
    	{
    		date=""+date1+"";
    	}
    	if(month1<9)
    	{
    		month="0"+(month1+1)+"";
    	}
    	else
    	{
    		month=""+(month1+1)+"";
    	}
    	
    	Calendar bcalendar = Calendar.getInstance();  
    	// 设置Calendar月份数为本个月  
    	bcalendar.set(Calendar.MONTH, bcalendar.get(Calendar.MONTH) -1);  
    	
    	int byear=bcalendar.get(Calendar.YEAR);//年
		int bmonth1=bcalendar.get(Calendar.MONTH);//月
		
		int bnum=bcalendar.getActualMaximum(Calendar.DAY_OF_MONTH);//上月多少天
		String bmonth;
    	
    	if(month1<9)
    	{
    		bmonth="0"+(bmonth1+1)+"";
    	}
    	else
    	{
    		bmonth=""+(bmonth1+1)+"";
    	}
    	
    	String benMonth=""+year+""+month+""+num+""+2+""+3+"";//本月最后一天的日期
    	String topMonth=""+byear+""+bmonth+""+bnum+""+2+""+3+"";//上月最后一天的日期
    	System.out.println(benMonth);
    	System.out.println(topMonth);
		
    	String hql="from CdnFlow where domain='"+domain+"' and cdnUser="+cu.getId()+" and (dateTime > '"+topMonth+"' and dateTime <= '"+benMonth+"')";
		List<CdnFlow> cdnFlow=cdnSystemBussiness.findObjectListByHQL(hql);
		
		cdnMonth cm=new cdnMonth();
		for(int i=0;i<cdnFlow.size();i++)
		{
			if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(topMonth)&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+1+""+0+""+0+""))
			{
				cm.setaMonth(cm.getaMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+1+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+2+""+0+""+0+""))
			{
				cm.setbMonth(cm.getbMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+2+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+3+""+0+""+0+""))
			{
				cm.setcMonth(cm.getcMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+3+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+4+""+0+""+0+""))
			{
				cm.setdMonth(cm.getdMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+4+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+5+""+0+""+0+""))
			{
				cm.seteMonth(cm.geteMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+5+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+6+""+0+""+0+""))
			{
				cm.setfMonth(cm.getfMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+6+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+7+""+0+""+0+""))
			{
				cm.setgMonth(cm.getgMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+7+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+8+""+0+""+0+""))
			{
				cm.sethMonth(cm.gethMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+8+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+0+""+9+""+0+""+0+""))
			{
				cm.setiMonth(cm.getiMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+0+""+9+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+10+""+0+""+0+""))
			{
				cm.setjMonth(cm.getjMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+10+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+11+""+0+""+0+""))
			{
				cm.setkMonth(cm.getkMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+11+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+12+""+0+""+0+""))
			{
				cm.setlMonth(cm.getlMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+12+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+13+""+0+""+0+""))
			{
				cm.setmMonth(cm.getmMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+13+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+14+""+0+""+0+""))
			{
				cm.setnMonth(cm.getnMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+14+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+15+""+0+""+0+""))
			{
				cm.setoMonth(cm.getoMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+15+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+16+""+0+""+0+""))
			{
				cm.setpMonth(cm.getpMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+16+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+17+""+0+""+0+""))
			{
				cm.setqMonth(cm.getqMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+17+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+18+""+0+""+0+""))
			{
				cm.setrMonth(cm.getrMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+18+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+19+""+0+""+0+""))
			{
				cm.setsMonth(cm.getsMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+19+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+20+""+0+""+0+""))
			{
				cm.settMonth(cm.gettMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+20+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+21+""+0+""+0+""))
			{
				cm.setuMonth(cm.getuMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+21+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+22+""+0+""+0+""))
			{
				cm.setvMonth(cm.getvMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+22+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+23+""+0+""+0+""))
			{
				cm.setwMonth(cm.getwMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+23+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+24+""+0+""+0+""))
			{
				cm.setxMonth(cm.getxMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+24+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+25+""+0+""+0+""))
			{
				cm.setyMonth(cm.getyMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+25+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+26+""+0+""+0+""))
			{
				cm.setzMonth(cm.getzMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+26+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+27+""+0+""+0+""))
			{
				cm.setAaMonth(cm.getAaMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+27+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+28+""+0+""+0+""))
			{
				cm.setAbMonth(cm.getAbMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+28+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+29+""+0+""+0+""))
			{
				cm.setAcMonth(cm.getAcMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+29+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+30+""+0+""+0+""))
			{
				cm.setAdMonth(cm.getAdMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+30+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+31+""+0+""+0+""))
			{
				cm.setAeMonth(cm.getAeMonth()+cdnFlow.get(i).getTraffic());
			}
			else if(Integer.parseInt(cdnFlow.get(i).getDateTime())>Integer.parseInt(""+year+""+month+""+31+""+0+""+0+"")&&Integer.parseInt(cdnFlow.get(i).getDateTime())<=Integer.parseInt(""+year+""+month+""+31+""+2+""+3+""))
			{
				cm.setAfMonth(cm.getAfMonth()+cdnFlow.get(i).getTraffic());
			}
			
			
		}
		
		 String aaa="aaaa<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='流量图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='MB' formatNumberScale='0'><categories>";
		 if(num==28)
		 {
			 

			 for(int i=0;i<29;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' />" +
					"</dataset>";
		 }
		 else if(num==29)
		 {
			 

			 for(int i=0;i<30;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' /><set value='"+cm.getAdMonth()+"' />" +
					"</dataset>";
		 }
		 else if(num==31)
		 {

			 for(int i=0;i<32;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' /><set value='"+cm.getAdMonth()+"' />" +
					"<set value='"+cm.getAeMonth()+"' /></dataset>";
		 }
		 else
		 {
			 for(int i=0;i<32;i++)
			 {
				 aaa+="<category label='"+i+"' />";
			 }
			aaa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量("+month+"月、每天统计一次)'><set value='0' />" +
					"<set value='"+cm.getaMonth()+"' /><set value='"+cm.getbMonth()+"' /><set value='"+cm.getcMonth()+"' /><set value='"+cm.getdMonth()+"' /><set value='"+cm.geteMonth()+"' /><set value='"+cm.getfMonth()+"' />" +
					"<set value='"+cm.getgMonth()+"' /><set value='"+cm.gethMonth()+"' /><set value='"+cm.getiMonth()+"' /><set value='"+cm.getjMonth()+"' /><set value='"+cm.getkMonth()+"' /><set value='"+cm.getlMonth()+"' />" +
					"<set value='"+cm.getmMonth()+"' /><set value='"+cm.getnMonth()+"' /><set value='"+cm.getoMonth()+"' /><set value='"+cm.getpMonth()+"' /><set value='"+cm.getqMonth()+"' /><set value='"+cm.getrMonth()+"' />" +
					"<set value='"+cm.getsMonth()+"' /><set value='"+cm.gettMonth()+"' /><set value='"+cm.getuMonth()+"' /><set value='"+cm.getvMonth()+"' /><set value='"+cm.getwMonth()+"' /><set value='"+cm.getxMonth()+"' />" +
					"<set value='"+cm.getyMonth()+"' /><set value='"+cm.getzMonth()+"' /><set value='"+cm.getAaMonth()+"' /><set value='"+cm.getAbMonth()+"' /><set value='"+cm.getAcMonth()+"' /><set value='"+cm.getAdMonth()+"' />" +
					"<set value='"+cm.getAeMonth()+"' /><set value='"+cm.getAfMonth()+"' /></dataset>";
		 }
		aaa+="</chart>";
		  	
		  	response.setContentType("text/html;charset=GBK");

			response.getWriter().print(aaa);	
		   		
	}
	public CdnSystemBussiness getCdnSystemBussiness() {
		return cdnSystemBussiness;
	}

	public void setCdnSystemBussiness(CdnSystemBussiness cdnSystemBussiness) {
		this.cdnSystemBussiness = cdnSystemBussiness;
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

	
	
}
