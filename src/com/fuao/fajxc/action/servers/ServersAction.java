package com.fuao.fajxc.action.servers;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;



import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.record.formula.functions.If;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.mapping.Array;
import org.springframework.beans.factory.config.CustomEditorConfigurer;

import com.fuao.fajxc.dao.servers.ServerDao;

import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;


import com.fuao.fajxc.serser.dao.SerajaxDao;
import com.fuao.fajxc.vo.Cabinet;

import com.fuao.fajxc.serser.service.SerajaxService;
import com.fuao.fajxc.util.ThreadGetSessions;
import com.fuao.fajxc.vo.Cabinet;

import com.fuao.fajxc.vo.City;
import com.fuao.fajxc.vo.ElectHouse;

import com.fuao.fajxc.vo.UpServer;

import com.fuao.fajxc.vo.Users;

import com.opensymphony.xwork2.ModelDriven;

public class ServersAction implements ModelDriven, ServletRequestAware,
ServletResponseAware{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ServerDao serversDao;
	private City city;
	private int sizespage=1;
	private ElectHouse house;

	private Cabinet cabinet;
	private String strNameString;
    private Logger logs = Logger.getLogger(ServersAction.class);
    
	public Cabinet getCabinet() {
		return cabinet;
	}
	public void setCabinet(Cabinet cabinet) {
		this.cabinet = cabinet;
	}
	public String getStrNameString() {
		return strNameString;
	}
	public void setStrNameString(String strNameString) {
		this.strNameString = strNameString;
	}

	private List provincelist;
	private List citylist;
	private List electlist;
	private List chlist;
	private String cityname;
	private List provinceList;


	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public Object getModel() {
		
		return null;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
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
	public ServerDao getServersDao() {
		return serversDao;
	}
	public void setServersDao(ServerDao serversDao) {
		this.serversDao = serversDao;
	}
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
	}	
	public List getChlist() {
		return chlist;
	}
	public void setChlist(List chlist) {
		this.chlist = chlist;
	}
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	//获取机房
	public void getElectProperty(){
		int mid = Integer.parseInt(strNameString);
		house=(ElectHouse) serversDao.getElectHouseDaos(mid);
		String strins = house.getElectName()+","+house.getElectPosition()+","+house.getElectTel()+","+house.getElectAdmin()+","+house.getElectAdmPhone();
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(strins);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//获取机柜
	public void getCabitProperty(){
		int cid=Integer.parseInt(strNameString);
		cabinet=(Cabinet) serversDao.getCabinetDaos(cid);
		String strincab = cabinet.getTelecthouse().getElectName()+","+cabinet.getCaname()+","+cabinet.getCasz()+","+cabinet.getBwmax()+","+cabinet.getPmax()+","+cabinet.getMaches()+","+cabinet.getUseSize();
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(strincab);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public ElectHouse getHouse() {
		return house;
	}
	public void setHouse(ElectHouse house) {
		this.house = house;
	}
	public List getProvincelist() {
		return provincelist;
	}
	public void setProvincelist(List provincelist) {
		this.provincelist = provincelist;
	}
	public List getCitylist() {
		return citylist;
	}
	public void setCitylist(List citylist) {
		this.citylist = citylist;
	}	
	/**
	 * 显示内容
	 */
	public String showselctContent(){
		 int eleid=Integer.parseInt(request.getParameter("eltID"));
		 logs.info("show"+eleid);
		 ElectHouse ehs=this.serversDao.getElectHouseDaos(eleid);
		 logs.info(ehs.getElectCode().substring(0,2));
		 List<ElectHouse> lit=this.serversDao.selElects("from ElectHouse e where substring(e.electCode,1,2)='"+ehs.getElectCode().substring(0,2)+"'");
		 this.showAllElect(lit);
		 if(request.getParameter("suces").equals("yes")){
				return "reList";
		 }else{
			  return "reLoadHs";
	      }
		 //return "reList";
	}
	/**
	 * 处理分页
	 */
	public void dealSplitPage(){
		int pages = Integer.parseInt(request.getParameter("pags"));
		logs.info("单击了..."+pages);
		// 请求得到字段
		String zdm=request.getParameter("condits");
		// 请求得到要查找的内容
		String content=request.getParameter("cotents");
		String pmtStr = null;
		try {
			//pmtStr =new String(content.getBytes("GBK"),"utf-8");
			pmtStr=URLDecoder.decode(content,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str="";
		if(zdm.equals("jfm")){
			List list=serversDao.getProvinceAndCity(pmtStr,(pages-1)*sizespage,sizespage);
			// 遍历所有的数据，并显示到前台中
			for(int i=0;i<list.size();i++){
				ElectHouse elhouse=(ElectHouse)list.get(i);///fajxc/WebRoot/serm/pager/innit.jsp
				// 得到这个机房下的机柜id
			    str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
			    		"<a href='"+request.getContextPath()+"/cms/showselctContentServers.do?eltID="+elhouse.getElectId()+"&suces=no' target='loadhouses' id='"+elhouse.getElectId()+"'>所属城市:"+elhouse.getCity().getName()+"<br>机房名称:"+elhouse.getElectName()+"<br>机房所在地:"+elhouse.getElectPosition()+"</br>管理员:"+elhouse.getElectAdmin()+"<br><span style='margin-left:30px;'>机房坐机:"+elhouse.getElectTel()+"</span></a>"+
			    		"</div></div></br><hr width='100%' color='green' size='5'>";
			}
		}
		if(zdm.equals("khm")){
			List list=serversDao.customer(content);
			for(int i=0;i<list.size();i++){
				Customer c= (Customer)list.get(i);
				// 根据客户对象得到上架单
				List uplist=serversDao.customerByKh(c.getCustomerId(),(pages-1)*sizespage,sizespage);
				for(int j=0;j<uplist.size();j++){
					UpServer up=(UpServer)uplist.get(j);
					if(up.getTupcabs()!=null){
						int caid=up.getTupcabs().getCaid();
						Cabinet cab= (Cabinet)serversDao.getObj(Cabinet.class, caid);
						str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
			    		"<a href='"+request.getContextPath()+"/serm/pager/innit.jsp?caid="+cab.getCaid()+"'>客户名称:"+c.getRealName()+"</br>机柜名:"+cab.getCaname()+"</br>所属机房:"+cab.getTelecthouse().getElectName()+"</br>机房地址:"+cab.getTelecthouse().getElectPosition()+"</a>"+
			    		"</div></div></br><hr width='100%' color='green' size='5'>";
					}
				}
			}
		}
		if(zdm.equals("dz")){
			// 得到匹配模糊
			List citylist=serversDao.cityByname(pmtStr,(pages-1)*sizespage,sizespage);
			for(int i=0;i<citylist.size();i++){
				ElectHouse elhouse=(ElectHouse)citylist.get(i);///fajxc/WebRoot/serm/pager/innit.jsp
				// 得到这个机房下的机柜id
			    str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
			    		"<a href='"+request.getContextPath()+"/cms/showselctContentServers.do?eltID="+elhouse.getElectId()+"&suces=no' target='loadhouses' id='"+elhouse.getElectId()+"'>管理员:"+elhouse.getElectAdmin()+"<br>机房坐机:"+elhouse.getElectTel()+"<br>管理员手机:"+elhouse.getElectAdmPhone()+"<br>机房名称:"+elhouse.getElectName()+"<br><span style='margin-left:30px;'>机房所在地:"+elhouse.getElectPosition()+"</span></a>"+
			    		"</div></div></br><hr width='100%' color='green' size='5'>";
			}
		}
		int iplen=3;
		if(zdm.equals("ip")){
			String[] iparr=content.split("\\.");
			iplen=iparr.length;
			if(iparr.length>2){
				// 根据ip内容得到机房地址
				String stri=null;
				List list=serversDao.ipByupserver(content,(pages-1)*sizespage,sizespage);
				for(int i=0;i<list.size();i++){
					UpServer up=(UpServer)list.get(i);
					if(up.getTupcabs()!=null){
						if(up.getUpFlag()==0){
							stri="下架";
						}else if(up.getUpFlag()==1){
							stri="上架";
						}else if(up.getUpFlag()==2){
							stri="故障";
						}else{
							stri="未知原因";
						}
						str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1' style='overflow:auto;'>" +
				    		"<a href='"+request.getContextPath()+"/serm/pager/innit.jsp?caid="+up.getTupcabs().getCaid()+"'>IP号:<span style='word-break:break-all;'>"+up.getServerIp()+"</span></br>机柜名称:"+up.getTupcabs().getCaname()+"</br>所属机房:"+up.getTupcabs().getTelecthouse().getElectName()+"</br>机房地址:"+up.getTupcabs().getTelecthouse().getElectPosition()+"</br>状态:"+stri+"</a>"+
				    		"</div></div></br><hr width='100%' color='green' size='5'>";
						
					}
				}

			}
	
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
	/******
	 * 根据页面上传过来的字段判断是什么 查询？
	 */
	public String searchByZd(){
		// 请求得到字段
		int flag=0;
		String zdm=request.getParameter("zdm");
		// 请求得到要查找的内容
		String content=request.getParameter("content");
		if(content.trim().length()<=0){
			content="''";
		}
		// 乱码问题
		try {
			content=URLDecoder.decode(content,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// 判断得到的 字段名是什么类型
		List list=new ArrayList();
		String str="";
		if(zdm.equals("jfm")){
			list=serversDao.getProvinceAndCity(content,0,sizespage);
			// 遍历所有的数据，并显示到前台中
			for(int i=0;i<list.size();i++){
				flag=1;
				ElectHouse elhouse=(ElectHouse)list.get(i);///fajxc/WebRoot/serm/pager/innit.jsp
				// 得到这个机房下的机柜id
			    str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
			    		"<a href='"+request.getContextPath()+"/cms/showselctContentServers.do?eltID="+elhouse.getElectId()+"&suces=no' target='loadhouses' id='"+elhouse.getElectId()+"'>所属城市:"+elhouse.getCity().getName()+"<br>机房名称:"+elhouse.getElectName()+"<br>机房所在地:"+elhouse.getElectPosition()+"</br>管理员:"+elhouse.getElectAdmin()+"<br><span style='margin-left:30px;'>机房坐机:"+elhouse.getElectTel()+"</span></a>"+
			    		"</div></div></br><hr width='100%' color='green' size='5'>";
			}
			int cot=serversDao.countSql("select count(*) from ElectHouse where electName like '%"+content+"%' and superid=0");
			str+="^"+spages(cot)+"^"+cot;
		}
		// 根据IP 查
		// 标识ip 输入的合法性
		int iplen=3;
		if(zdm.equals("ip")){
			String[] iparr=content.split("\\.");
			iplen=iparr.length;
			if(iparr.length>2){
				// 根据ip内容得到机房地址
				String stri=null;
				list=serversDao.ipByupserver(content,0,sizespage);
				for(int i=0;i<list.size();i++){
					UpServer up=(UpServer)list.get(i);
					if(up.getTupcabs()!=null){
						flag=1;
						if(up.getUpFlag()==0){
							stri="下架";
						}else if(up.getUpFlag()==1){
							stri="上架";
						}else if(up.getUpFlag()==2){
							stri="故障";
						}else{
							stri="未知原因";
						}
						str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
				    		"<a href='"+request.getContextPath()+"/serm/pager/innit.jsp?caid="+up.getTupcabs().getCaid()+"'>IP号:<span style='word-break:break-all;'>"+up.getServerIp()+"</span></br>机柜名称:"+up.getTupcabs().getCaname()+"</br>所属机房:"+up.getTupcabs().getTelecthouse().getElectName()+"</br>机房地址:"+up.getTupcabs().getTelecthouse().getElectPosition()+"</br><span style='margin-left:30px;'>状态:"+stri+"</span></a>"+
				    		"</div></div></br><hr width='100%' color='green' size='5'>";
						
					}
				}
			int cot=serversDao.countSql("select count(*) from UpServer where serverIp like '"+content+"%'");
			str+="^"+spages(cot)+"^"+cot;
			}
	
		}
		boolean bool=false;
		// 根据客户姓名查
		if(zdm.equals("khm")){
			int cuid=0;
			list=serversDao.customer(content);
			for(int i=0;i<list.size();i++){
				Customer c= (Customer)list.get(i);
				cuid=c.getCustomerId();
				// 根据客户对象得到上架单
				List uplist=serversDao.customerByKh(c.getCustomerId(),0,sizespage);
				for(int j=0;j<uplist.size();j++){
					UpServer up=(UpServer)uplist.get(j);
					if(up.getTupcabs()!=null){
						bool=true;
						flag=1;
						int caid=up.getTupcabs().getCaid();
						// 得到这个机房下的机柜id
						// 根据机柜ID 得到机柜
						Cabinet cab= (Cabinet)serversDao.getObj(Cabinet.class, caid);
						str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
			    		"<a href='"+request.getContextPath()+"/serm/pager/innit.jsp?caid="+cab.getCaid()+"'>客户名称:"+c.getRealName()+"</br>机柜名:"+cab.getCaname()+"</br>所属机房:"+cab.getTelecthouse().getElectName()+"</br>机房地址:"+cab.getTelecthouse().getElectPosition()+"</a>"+
			    		"</div></div></br><hr width='100%' color='green' size='5'>";
					
					}
				}
			}
			int cot=serversDao.countSql("select count(*) from UpServer where customer.customerId="+cuid);
			str+="^"+spages(cot)+"^"+cot;
		}
		// 根据管理员
		if(zdm.equals("dz")){
			// 得到匹配模糊
			List citylist=serversDao.cityByname(content,0,sizespage);
			for(int i=0;i<citylist.size();i++){
				ElectHouse elhouse=(ElectHouse)citylist.get(i);///fajxc/WebRoot/serm/pager/innit.jsp
				// 得到这个机房下的机柜id
				flag=1;
			    str+="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
			    		"<a href='"+request.getContextPath()+"/cms/showselctContentServers.do?eltID="+elhouse.getElectId()+"&suces=no' target='loadhouses' id='"+elhouse.getElectId()+"'>管理员:"+elhouse.getElectAdmin()+"<br>机房坐机:"+elhouse.getElectTel()+"<br>管理员手机:"+elhouse.getElectAdmPhone()+"<br>机房名称:"+elhouse.getElectName()+"<br><span style='margin-left:30px;'>机房所在地:"+elhouse.getElectPosition()+"</span></a>"+
			    		"</div></div></br><hr width='100%' color='green' size='5'>";
			}
			int cot=serversDao.countSql("select count(*) from ElectHouse where electAdmin like '%"+content+"%'  and superid=0");
			str+="^"+spages(cot)+"^"+cot;
		}
		System.out.println(zdm+content);
		System.out.println(list.size());
		try {
			if(flag==0){
				str+="<div style='color:red;margin-top: 20px;'>没有相关信息!</div>";
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return null;
	}
	
   //模糊查
   public void fuzzyAllCondition(){
	   if(request.getSession().getAttribute("allsplitdata")!="" || request.getSession().getAttribute("allsplitdata")!=null){
		   request.getSession().removeAttribute("allsplitdata");
		   //request.getSession().removeAttribute("allCount");
	   }
	   String contented="";
	   String str="";
	   //String condition="";
	   int flag=0;
	   int cot=0;
	   List<String> lts= new  ArrayList<String>();
	try {
		if(request.getParameter("contents")!=null){
			request.setCharacterEncoding("GBK");
			contented=URLDecoder.decode(request.getParameter("contents"),"utf-8");
		}
		//contented = new String(request.getParameter("contents").getBytes("GBK"),"UTF-8");
	} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	logs.info("contented="+contented);
	List list1=serversDao.getHousefromnames(contented);
	if(list1.size()!=0){
		for(int i=0;i<list1.size();i++){
			flag=1;
			ElectHouse elhouse=(ElectHouse)list1.get(i);///fajxc/WebRoot/serm/pager/innit.jsp
			// 得到这个机房下的机柜id
		    str="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
		    		"<a href='"+request.getContextPath()+"/cms/showselctContentServers.do?eltID="+elhouse.getElectId()+"&suces=no' target='loadhouses' id='"+elhouse.getElectId()+"'>所属城市:"+elhouse.getCity().getName()+"<br>机房名称:"+elhouse.getElectName()+"<br>机房所在地:"+elhouse.getElectPosition()+"</br>管理员:"+elhouse.getElectAdmin()+"<br><span style='margin-left:30px;'>机房坐机:"+elhouse.getElectTel()+"</span></a>"+
		    		"</div></div></br><hr width='100%' color='green' size='5'>";
		    lts.add(str);
		}
		int coty=serversDao.countSql("select count(*) from ElectHouse where electName like '%"+contented+"%' and superid=0");
        cot+=coty;
		//str+=spages(cot)+"^"+cot;
	}
	//ip
	String pattern ="\\b((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\b|\\b((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\b";
	Pattern p = Pattern.compile(pattern);
	Matcher m = p.matcher(contented);
	String result = null;
	String stri=null;
    if(m.matches()){
    	List list2=serversDao.getIpByupservers(contented);
		for(int i=0;i<list2.size();i++){
			UpServer up=(UpServer)list2.get(i);
			if(up.getTupcabs()!=null){
				flag=1;
				if(up.getUpFlag()==0){
					stri="下架";
				}else if(up.getUpFlag()==1){
					stri="上架";
				}else if(up.getUpFlag()==2){
					stri="故障";
				}else{
					stri="未知原因";
				}
				str="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
		    		"<a href='"+request.getContextPath()+"/serm/pager/innit.jsp?caid="+up.getTupcabs().getCaid()+"'>IP号:<span style='word-break:break-all;'>"+up.getServerIp()+"</span></br>机柜名称:"+up.getTupcabs().getCaname()+"</br>所属机房:"+up.getTupcabs().getTelecthouse().getElectName()+"</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机房地址:"+up.getTupcabs().getTelecthouse().getElectPosition()+"</br><span style='margin-left:35px;'>状态:"+stri+"</span></a>"+
		    		"</div></div></br><br></br><br><hr width='100%' color='green' size='5'>";
				lts.add(str);
			}
		}
		int coty=serversDao.countSql("select count(*) from UpServer where serverIp like '"+contented+"%'");
		cot+=coty;
		//str+="^"+spages(cot)+"^"+cot;
	}
    //按客户名
    List list3=serversDao.customer(contented);
    if(list3.size()!=0){
    int cuid=0;
	for(int i=0;i<list3.size();i++){
		Customer c= (Customer)list3.get(i);
		cuid=c.getCustomerId();
		// 根据客户对象得到上架单
		List uplist=serversDao.getCustomerByKHs(c.getCustomerId());
		for(int j=0;j<uplist.size();j++){
			UpServer up=(UpServer)uplist.get(j);
			if(up.getTupcabs()!=null){
				flag=1;
				int caid=up.getTupcabs().getCaid();
				// 得到这个机房下的机柜id
				// 根据机柜ID 得到机柜
				Cabinet cab= (Cabinet)serversDao.getObj(Cabinet.class, caid);
				str="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
	    		"<a href='"+request.getContextPath()+"/serm/pager/innit.jsp?caid="+cab.getCaid()+"'>客户名称:"+c.getRealName()+"</br>机柜名:"+cab.getCaname()+"</br>所属机房:"+cab.getTelecthouse().getElectName()+"</br>机房地址:"+cab.getTelecthouse().getElectPosition()+"</a>"+
	    		"</div></div></br><hr width='100%' color='green' size='5'>";
				lts.add(str);
			}
		}
	}
	int coty=serversDao.countSql("select count(*) from UpServer where customer.customerId="+cuid);
	//str+="^"+spages(cot)+"^"+cot;
	cot+=coty;
    }
    //管理员
    List list4=serversDao.getCityByNames(contented);
    if(list4.size()!=0){
	for(int i=0;i<list4.size();i++){
		ElectHouse elhouse=(ElectHouse)list4.get(i);///fajxc/WebRoot/serm/pager/innit.jsp
		// 得到这个机房下的机柜id
		flag=1;
	    str="<div class='list list_NoBg' id='list1'><div class='Show_Bi'>"+(i+1)+"</div></br><div id='comment1'>" +
	    		"<a href='"+request.getContextPath()+"/cms/showselctContentServers.do?eltID="+elhouse.getElectId()+"&suces=no' target='loadhouses' id='"+elhouse.getElectId()+"'>管理员:"+elhouse.getElectAdmin()+"<br>机房坐机:"+elhouse.getElectTel()+"<br>管理员手机:"+elhouse.getElectAdmPhone()+"<br>机房名称:"+elhouse.getElectName()+"<br><span style='margin-left:30px;'>机房所在地:"+elhouse.getElectPosition()+"</span></a>"+
	    		"</div></div></br><hr width='100%' color='green' size='5'>";
	    lts.add(str);
	}
	int coty=serversDao.countSql("select count(*) from ElectHouse where electAdmin like '%"+contented+"%'  and superid=0");
	cot+=coty;
    }
    String allstr="";
    int t1=0;
    logs.info("lts1="+lts.size());
    for(String stg : lts){
    	if(t1<sizespage){
    	   logs.info("stg1="+stg);
    	   allstr+=stg;
    	}
    	t1++;
    }
    request.getSession().setAttribute("allsplitdata",lts);
    //request.getSession().setAttribute("allCount", cot);
    allstr+="^"+spages(cot)+"^"+cot;
    try{
    if(flag==0){
    	allstr="休息一下，未找到你想要的信息。";
    }
	response.setCharacterEncoding("utf-8");
	response.getWriter().print(allstr);
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
	
   }//结束
  
	//模糊查时的分页
	public String fuzzyByZd(){
		// 请求得到字段
		int flag=0;
		int pn=0;
		List lts= new ArrayList();
		//所有的分页数据
		List<String> arrList=(List<String>) request.getSession().getAttribute("allsplitdata");
		//int arrcount = (Integer) request.getSession().getAttribute("allCount");
		logs.info("arrlist="+arrList.size());
		int pages = Integer.parseInt(request.getParameter("pags"));
		logs.info("单击了..."+pages);
		String str="";
		//List citylist=serversDao.cityByname(pmtStr,(pages-1)*sizespage,sizespage);
        for (int i=0;i<arrList.size();i++) {
			if(i>=(pages-1)*sizespage && i<(pages-1)*sizespage+sizespage){
				str+=arrList.get(i);
			}
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return null;
	}
	 public String spages(int cot){
		   String srt="";
			int sizes=0;
			if(cot%sizespage==0){
				sizes=cot/sizespage;
			}else{
				sizes=cot/sizespage+1;
			}
			if(sizes<=5){
			for(int j=0;j<sizes;j++){
				if(j==0){
					srt+="<div>";
					srt+="<a href='javascript:splitpag("+(j+1)+","+sizes+");'  style='color:green;font-size:14px;' id='pg"+(j+1)+"'>["+(j+1)+"]</a>&nbsp;&nbsp;"; 
				}else{
					srt+="<a href='javascript:splitpag("+(j+1)+","+sizes+");' id='pg"+(j+1)+"'>["+(j+1)+"]</a>&nbsp;&nbsp;"; 
				}
			}
			srt+="</div>";
			}else{
				for(int j=0;j<5;j++){
					if(j==0){
						srt+="<div>";
						srt+="<a href='javascript:splitpag("+(j+1)+","+sizes+");' style='color:green;font-size:14px;' id='pg"+(j+1)+"'>["+(j+1)+"]</a>&nbsp;&nbsp;"; 
					}else{
						srt+="<a href='javascript:splitpag("+(j+1)+","+sizes+");' id='pg"+(j+1)+"'>["+(j+1)+"]</a>&nbsp;&nbsp;"; 
					}
				}
				srt+="</div>";
			}
			return srt;
	   }
		public List getElectlist() {
			return electlist;
		}
		public void setElectlist(List electlist) {
			this.electlist = electlist;
		}
	//根据前台传过来的城市名字查其ID
	public void getCityID(){
		response.setContentType("utf-8");
		try {
		 int cid = city.getId();
		 System.out.println(cid);
		 List list = serversDao.getElectByCityid(cid);
		 PrintWriter out = response.getWriter();
		 if(list.size()>0){
			out.print(list.size());
		 }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public void showCity(){
		this.request.getSession().removeAttribute("houseList");
		this.request.getSession().removeAttribute("cabList");
		String cname="";
		int pid=city.getId();
		int superid=city.getSuperid();
		if(superid==-1){
			showElect();
		}
		if(superid==0){
		  List clist = serversDao.getCityBySuperid(pid);
		   
		  for(int i=0;i<clist.size();i++){
			  City c = (City)clist.get(i);
			  cname= "<a href='"+request.getContextPath()+"/cms/creteLeftMenuServers.do?city.id="+c.getId()+"&suces=no' target='loadhouses'>"+c.getName()+"</a>"+","+cname;
		  }
	      
		}
		
		  try {
			    response.setContentType("text/html;charset=GBK");
				response.getWriter().write(cname);
			} catch (Exception e) {
				e.printStackTrace();
			}
	
	}

	public String loadCity() {
//		request.getSession().setAttribute("loginName","14001");  //获取登录名，在使用时去掉.
		List<ElectHouse> list = serversDao.getElectByCityid(15);  //一进来默认的地区。
		request.getSession().setAttribute("ctids", 17);
		String loginEmp = (String) request.getSession().getAttribute("loginName");
		if(null == loginEmp|| loginEmp==""){
			request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
			return "no";
		}
		System.out.println("listca=" + list.size());
		List li = new ArrayList();
		List lims = new ArrayList();
		List rlist =new ArrayList();
		for (ElectHouse cabt : list) {
			Map map = new HashMap();
			map.put("houseName", cabt.getElectName());
			map.put("houid", cabt.getElectId());//!!!!!!!!!!!!!!!
			map.put("supID", cabt.getSuperid());
			map.put("houseRoom",cabt.getElectCode());
			map.put("showcode", cabt.getShowcode());
			li.add(map);
			rlist.add(map);
			System.out.println(cabt.getElectId());
			//根据机房查机柜信息
			List peletList = serversDao.get(cabt.getElectId());
		//	List peletList = serversDao.getCabinetByHouse(cabt.getElectId()); //!!!!!
		//	List peletList = serversDao.getElectByCity(city.getName());
			System.out.println("lism=" + peletList.size());
			for (Iterator ite = peletList.iterator(); ite.hasNext();) {
				Cabinet cat = (Cabinet) ite.next();
				Map mp = new HashMap();
				mp.put("cabName", cat.getCaname());
				mp.put("cabID", cat.getCaid());
				//mp.put("elehouse", cat.getElehouse());
				mp.put("elehid", cat.getTelecthouse().getElectId());
				mp.put("description", cat.getDescription());
				lims.add(mp);
			}
			
		}
		this.request.getSession().setAttribute("houseList", li);
		this.request.getSession().setAttribute("cabList", lims);
		this.request.getSession().setAttribute("roomList",rlist);

		System.out.println("li=" + li);
		System.out.println("lims=" + lims);
		
		// 得到所有省份
		List allList=serversDao.getSuper();
		// 封装省，市的集合
		List<Object[]> cityList=new ArrayList<Object[]>();
		for(int i=0;i<allList.size();i++){
			City city=(City)allList.get(i);
			int cityid=city.getId();
			int superid=city.getSuperid();
			List list1= serversDao.getCityBySuperid(cityid);// 父类下的市级城市
			if(list1.size()>0){
				for(int j=0;j<list1.size();j++){
					Object[] obj=new Object[3];
					City city1=(City)list1.get(j);
					// obj[0]省，obj[1]省下面的市
					obj[0]=city;
					obj[1]=city1;
					obj[2]=city1.getId();
					cityList.add(obj);
					allList.remove(city1);
				}
			}
			if(superid==0&&list1.size()<=0){
				Object[] obj=new Object[3];
				// superid=0代表当前的城市就是省。那么添加的时候省市都一样的
				obj[0]=city;
				obj[1]=city;
				obj[2]=city.getId();
				cityList.add(obj);
			}
			if(superid==-1){
				Object[] obj=new Object[3];
				// superid=-1代表当前的城市是一个直辖市。那么添加的时候省市都一样的
				obj[0]=city;
				obj[1]=city;
				obj[2]=city.getId();
				cityList.add(obj);
			}
		}
		for(int i=0;i<cityList.size();i++){
			Object[] objects=(Object[])cityList.get(i);
			City city1=(City)objects[0];
			City city2=(City)objects[1];
			//System.out.println(city1.getName()+"省,"+city2.getName()+"市"+city2.getId());
		}
		// 得到所有省和是直辖市的城市
		List sList=serversDao.getAllSheng();
		request.getSession().setAttribute("city", cityList);
		request.getSession().setAttribute("slist", sList);
		
		return "reList";
	}
	
	/////////////////机房   机柜
	@SuppressWarnings("unchecked")
	public String creteLeftMenu() {
		System.out.println("I COME");
		if(city.getId()!=0){
		    showElect();
		}
		if(request.getParameter("suces").equals("yes")){
			return "reList";
		}else{
		  return "reLoadHs";
		}
	}
	
	public void showElect(){
		request.getSession().removeAttribute("ctids");
		this.request.getSession().removeAttribute("houseList");
		this.request.getSession().removeAttribute("cabList");
		 int cid = city.getId();
		 request.getSession().setAttribute("ctids", cid);
		 this.request.getSession().removeAttribute("houseList");
		 this.request.getSession().removeAttribute("cabList");	
		 System.out.println(cid);
		List<ElectHouse> list = serversDao.getElectByCityid(cid);
		showAllElect(list);
	}
	public void showAllElect(List<ElectHouse> lts){
		System.out.println("listca=" + lts.size());
		List li = new ArrayList();
		List lims = new ArrayList();
		List rlist =new ArrayList();
		for (ElectHouse cabt : lts) {
			Map map = new HashMap();
			map.put("houseName", cabt.getElectName());
			map.put("houid", cabt.getElectId());//!!!!!!!!!!!!!!!
			map.put("supID", cabt.getSuperid());
			map.put("houseRoom",cabt.getElectCode());
			map.put("showcode", cabt.getShowcode());
			li.add(map);
			rlist.add(map);
			System.out.println(cabt.getElectId());
			//根据机房查机柜信息
			List peletList = serversDao.get(cabt.getElectId());
			System.out.println("lism=" + peletList.size());
			for (Iterator ite = peletList.iterator(); ite.hasNext();) {
				Cabinet cat = (Cabinet) ite.next();
				Map mp = new HashMap();
				mp.put("cabName", cat.getCaname());
				mp.put("cabID", cat.getCaid());
				mp.put("elehid", cat.getTelecthouse().getElectId());
				mp.put("description", cat.getDescription());
				lims.add(mp);
			}
			
		}
		this.request.getSession().setAttribute("houseList", li);
		this.request.getSession().setAttribute("cabList", lims);
		this.request.getSession().setAttribute("roomList",rlist);

		System.out.println("li=" + li);
		System.out.println("lims=" + lims);
		
	}
 
	
}
