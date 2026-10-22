package com.fuao.fajxc.action.server;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.fuao.fajxc.bussiness.server.IpServer;
import com.fuao.fajxc.bussiness.stockpile.StockpileDetailsBussiness;
import com.fuao.fajxc.bussiness.stockpile.WarehousingBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.UpServer;
import com.opensymphony.xwork2.ModelDriven;

public class IpManagerAction implements ModelDriven , ServletRequestAware, ServletResponseAware {
	
	
	private static final Logger logger = Logger.getLogger(IpManagerAction.class);
	
	
	/*
	 * 注入server
	 */
	private IpServer server;
	private IPConfiguration configuration;
	private StockpileDetailsBussiness stockpileDetailsBussiness;
	private WarehousingBussiness warehousingBussiness;
	private Object [] ids;
	private Property property;
	
	private String ipaddress;
	private String ipname;
	
	
	
	
	
	public String getIpaddress() {
		return ipaddress;
	}

	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}

	public String getIpname() {
		return ipname;
	}

	public void setIpname(String ipname) {
		this.ipname = ipname;
	}

	public IPConfiguration getConfiguration() {
		return configuration;
	}

	public void setConfiguration(IPConfiguration configuration) {
		this.configuration = configuration;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public WarehousingBussiness getWarehousingBussiness() {
		return warehousingBussiness;
	}

	public void setWarehousingBussiness(WarehousingBussiness warehousingBussiness) {
		this.warehousingBussiness = warehousingBussiness;
	}

	public StockpileDetailsBussiness getStockpileDetailsBussiness() {
		return stockpileDetailsBussiness;
	}

	public void setStockpileDetailsBussiness(
			StockpileDetailsBussiness stockpileDetailsBussiness) {
		this.stockpileDetailsBussiness = stockpileDetailsBussiness;
	}

	public IpServer getServer() {
		return server;
	}

	public void setServer(IpServer server) {
		this.server = server;
	}

	private HttpServletRequest request;
	private HttpServletResponse response;
	

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
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}
	
	/*
	 * 分页(默认请求)
	 */
	
	public String selectIp()
	{
		String hql = "from IPConfiguration as ip where 1=1 and ip.isblack = '0' ";
		
		if(ipname !=null && !ipname.equals(""))
		{
			hql+=" and ip.ipcname like '%"+ipname+"%'";
			request.setAttribute("ipcnames",ipname);
		}
		if(ipaddress != null && !ipaddress.equals(""))
		{
			hql +=" and ip.ipcaddress like '%"+ipaddress+"%'";
			request.setAttribute("ipcaddresss", ipaddress);
		}
		hql +=" order by ipcID desc";
		
		System.out.println("hql1"+hql);
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		Pages page = this.server.exHqlPages(hql, new Integer(pageNo), 25, null);
		List ipList = page.getPageList();
		List ippageList = new ArrayList();
//		for(int i =0 ; i < ipList.size() ;i++)
//		{
//			//得到单个的IP根据IP判断商品和仓库有没有
//			IPConfiguration configuration = (IPConfiguration) ipList.get(i);
//			//得到商品
//			List propertyList = this.server.getObject("Property", configuration.getTproperty().getId());
//			//入库
//			List storageList = this.server.getObject1("StorageInfo", configuration.getTstorageInfo().getStorageInfoId());
//			List upserver = new ArrayList();
//			if(configuration.getUpNo() !=null)
//			{
//				upserver = this.server.getObject1("UpServer", configuration.getUpNo().getId());
//			}
//			if(propertyList.size()>0 && propertyList != null && storageList.size() >0 && storageList != null && upserver.size()>0 && upserver !=null)
//			{
//				ippageList.add(configuration);
//			}
//		}
//		page.setPageList(ippageList);
		request.setAttribute("pages", page);
		
		return "success";
	}
	/*
	 * 添加请求
	 */
	public String addIp() throws Exception
	{
		String deptid = request.getParameter("deptid");
//		String storid = request.getParameter("storid");
		String properid = request.getParameter("properid");
		
		Depot depot = new Depot();
		depot.setId(new Integer(deptid));
		this.configuration.setTdepot(depot);
		
		Property property = new Property();
		property.setId(new Integer(properid));
		this.configuration.setTproperty(property);
		
//		StorageInfo storageInfo = new StorageInfo();
//		storageInfo.setStorageInfoId(new Integer(storid));
//		this.configuration.setTstorageInfo(storageInfo);
		
		this.configuration.setIpcstate("0");
		this.configuration.setIsblack("0");
		boolean flag = this.server.addIp(configuration);
		if(flag)
		{
			System.out.println("success! ");
		}
		return "add";
	}
	/*
	 * 删除请求
	 */
	public String delIp() throws Exception
	{
		String demo = "";
		String str = "";
		Object [] obj =  new Object[ids.length];
		for(int i = 0;i<obj.length;i++)
		{
			Integer id = new Integer(ids[i].toString());
			IPConfiguration configuration = this.server.find(id);
			if(configuration.getUpNo() != null)
			{
				Integer id1 = configuration.getUpNo().getUpFlag();
				if(id1 ==2 || id1==1)
				{
					obj[i] = "0";
					str += "1";
					demo += configuration.getUpNo().getUpNo()+",";
					logger.error("不可能删除的"+configuration.getIpcId()+configuration.getIpcname());
				}
				else
				{
					obj[i] =  new Integer(ids[i].toString());
				}
			}
			else
			{
				obj[i] = new Integer(ids[i].toString());
			}
		}
		System.out.println(obj);
		response.setCharacterEncoding("utf-8");
		boolean flag = this.server.delIp(obj);
		
		if(flag==true 	&& str != null && !str.equals(""))
		{
			response.getWriter().print("部分删除成功,"+demo+"服务器未下架，请下架后在做删除!");
		}
		else if(flag==false &&str != null && !str.equals(""))
		{
			response.getWriter().print(demo+"服务器未下架，请下架后在做删除!");
		}else
		{
			response.getWriter().print("删除成功!");
		}
		return null;
	}
	/*
	 * 修改请求
	 */
	public String updateipUI() throws Exception
	{
		System.out.println("update----->comm in");
		String deptid = request.	getParameter("deptid");
		String storid = "1";
		String properid = request.getParameter("properid");
		Integer ipcid = new Integer(request.getParameter("ipcid")); 
		IPConfiguration configuration1 = this.server.find(ipcid);
		Depot depot1 = new Depot();
		if(!deptid.equals(""))
		{
			depot1.setId(new Integer(deptid));
			this.configuration.setTdepot(depot1);
		}else
		{
			depot1.setId(new Integer(configuration1.getTdepot().getId()));
			this.configuration.setTdepot(depot1);
		}
	
		Property property1 = new Property();
		if(!properid.equals(""))
		{
			property1.setId(new Integer(properid));
			this.configuration.setTproperty(property1);
		}
		else
		{
			property1.setId(new Integer(configuration1.getTproperty().getId()));
			this.configuration.setTproperty(property1);
		}
//		StorageInfo storageInfo1 = new StorageInfo();
//		if(storid !="")
//		{
//			storageInfo1.setStorageInfoId(new Integer(storid));
//			this.configuration.setTstorageInfo(storageInfo1);
//		}
//		else
//		{
//			storageInfo1.setStorageInfoId(new Integer(configuration1.getTstorageInfo().getStorageInfoId()));
//			this.configuration.setTstorageInfo(storageInfo1);
//		}
		
		UpServer server1 =  configuration1.getUpNo();
		if(server1 != null)
		{
			server1 = configuration1.getUpNo();
		}
		else
		{
			server1 = null;
		}
		this.configuration.setUpNo(server1);
		this.configuration.setIpcstate(configuration1.getIpcstate());
		this.configuration.setIpcId(ipcid);
		this.configuration.setIsblack(configuration1.getIsblack());
		
		this.server.updateIp(configuration);
		return "update";
	}
	//添加请求
	public String addUI() throws Exception
	{
		System.out.println("55555555555555555555555");
		//仓库信息
		List listdepo = this.stockpileDetailsBussiness.getObject("Depot"); 
		//入库信息
		String hql = "from StorageInfo where 1=1";
		List liststoc = this.warehousingBussiness.select(hql);
		//商品
	    String hql1 = "from Property where 1=1";
	    List listproperty = this.warehousingBussiness.select(hql1);
	    
	    //str值
	    
	    request.setAttribute("listdepo",listdepo);
	    request.setAttribute("liststoc", liststoc);
	    request.setAttribute("listproperty",listproperty);
	    request.setAttribute("str1", "1");
		return "addUI";
	}
	
	//查询ip地址是否存在
	public String selectName() throws Exception
	{
		System.out.println("------>Comm in");
		String name = request.getParameter("address");
		String str = null;
		
		boolean flag = false;
		flag = this.server.selectName(name);
		if(flag ==true)
		{
			str = "1";
		}
		else
		{
			str = "2";
		}
		System.out.println(str);
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(str);
		return null;
	}
	
	//修改

	public String updateUI() throws Exception
	{
		//仓库信息
		List listdepo = this.stockpileDetailsBussiness.getObject("Depot"); 
		//入库信息
		String hql = "from StorageInfo where 1=1";
		List liststoc = this.warehousingBussiness.select(hql);
		//商品
	    String hql1 = "from Property where 1=1";
	    List listproperty = this.warehousingBussiness.select(hql1);
	    
	    request.setAttribute("listdepo",listdepo);
	    request.setAttribute("liststoc", liststoc);
	    request.setAttribute("listproperty",listproperty);
		Integer ipcid = new Integer(request.getParameter("ipcid"));
		IPConfiguration configuration = this.server.find(ipcid);
		System.out.println(configuration.getTproperty().getId()+","+configuration.getTproperty().getName());
		request.setAttribute("ipconfig", configuration);
		 request.setAttribute("str2", "2");
		return "addUI";
	}

	public Object getModel() {
		return null;
	}
	
	/*
	 * 使用该为禁用请求
	 */
	public String updateState0() throws Exception
	{
		boolean flag = this.server.updateState0(ids);
		
		if(flag == true)
		{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("禁用成功!");
		}

		return null;
	}
	
	/*
	 * 改禁用为使用
	 */
	public String updateState1() throws Exception
	{
		boolean flag = this.server.updateState1(ids);
		if(flag)
		{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("启用成功!");	
		}
		return null;
	}
	/*
	 * 根据ID修改Ip状态请求
	 */
	public String updateById() throws Exception
	{
		Integer ipcid = new Integer(request.getParameter("ipcid"));
		String ipcstate = request.getParameter("ipcstate");
		String str = null;
		if(ipcstate =="0")
		{
			boolean flag = this.server.updateById(ipcid, "1");
			str = "<a href='#'  onclick='onclickState('${data.ipcId}');' >已使用</a>";
		}
		if(ipcstate =="1")
		{
			boolean flag = this.server.updateById(ipcid, "0");
			str = "<a href='#'  onclick='onclickState('${data.ipcId}');' >已使用</a>";
		}
		
		return null;
	}
	
	/*
	 *批量的查询是否有IP地址相同的 
	 */
	public String selectByaddress() throws Exception
	{
		String address = request.getParameter("address1");
		Integer minnum = new Integer(request.getParameter("minnum"));
		Integer maxnum = new Integer(request.getParameter("maxnum"));

		String str = "";
		for(int i = 0 ;i<=(maxnum-minnum);i++)
		{
			int num = minnum+i;
			String ipcaddress = address +"."+num;
			System.out.println(ipcaddress);
			
			boolean falg = this.server.selectName(ipcaddress);
			
			if(falg == true)
			{
				str +=ipcaddress+"、";
			}
		}
		if(!str.equals(""))
		{
			response.setCharacterEncoding("utf-8");
			String temp = "<div style='font-size: 12px;color: red;'>(Ip不可用,重复Ip"+str+")</div>";
			response.getWriter().print(temp);
		}
		if(str =="")
		{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("1");
		}
		
		return null;
	}
	
	/*
	 *  批量添加
	 */
	public String addIpconfigs() throws Exception
	{
		String deptid = request.getParameter("deptid");
//		String storid = request.getParameter("storid");
		String properid = request.getParameter("properid");
		Integer minnum = new Integer(request.getParameter("minnum"));
		Integer maxnum = new Integer(request.getParameter("maxnum"));
		
		Depot depot = new Depot();
		depot.setId(new Integer(deptid));
		this.configuration.setTdepot(depot);
		
		Property property = new Property();
		property.setId(new Integer(properid));
		this.configuration.setTproperty(property);
		
//		StorageInfo storageInfo = new StorageInfo();
//		storageInfo.setStorageInfoId(new Integer("1"));
//		this.configuration.setTstorageInfo(storageInfo);
		
		this.configuration.setIpcstate("0");
		this.configuration.setIsblack("0");
		String str = this.configuration.getIpcaddress();
		for(int i =0 ; i <=(maxnum-minnum);i++ )
		{
			Integer num = minnum +i;
			System.out.println(num);
			String address = str + "." +num ;
			System.out.println(address);
			this.configuration.setIpcaddress(address);
			
			boolean falg = this.server.addIp(configuration);
			if(falg==true)
			{
				System.out.println("success");
			}
		}
		return "add";
	}
	//批量添加请求UI
	public String addUI1() throws Exception
	{
		//仓库信息
		List listdepo = this.stockpileDetailsBussiness.getObject("Depot"); 
		//入库信息
		String hql = "from StorageInfo where 1=1";
		List liststoc = this.warehousingBussiness.select(hql);
		//商品
	    String hql1 = "from Property where 1=1";
	    List listproperty = this.warehousingBussiness.select(hql1);
	    
	    //str值
	    String str = request.getParameter("str");
	    request.setAttribute("listdepo",listdepo);
	    request.setAttribute("liststoc", liststoc);
	    request.setAttribute("listproperty",listproperty);
	    request.setAttribute("str",str);
		return "addUI";
	}
	
	//demo
	public String fusionChartinfo() throws Exception
	{
		List proList = this.stockpileDetailsBussiness.getObject("Project"); 
		System.out.println("aa");
		request.setAttribute("proList",proList);
		
		return "fusion";
	}
	
	public String selectFusionChart() throws Exception
	{
		String str = "80%";
		Integer num = new Integer(str.substring(0, str.length()-1).toString());
		System.out.println(num);
		int num1 = num/4;
		System.out.println(num1);
		List dataList = new ArrayList();
		dataList.add(0,0);
		for(int i = 1;i<4;i++)
		{
			dataList.add(i, num1*i);
		}
		dataList.add(4,79);
		for(int i=0;i<dataList.size();i++)
		{
			System.out.println(dataList.get(i));
		}
		
		List dataList1 = new ArrayList();
		//在原有的时间上加上天数
		SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
		try {
			sm.format(new Date());
			Date data1 = sm.parse("2012-10-05");
			Date data2 = sm.parse(sm.format(new Date()).toString());
			long day = data2.getTime() - data1.getTime();
			long day1 = day/(24*60*60*1000);
			Integer num2 = new Integer((int) day1);
			Integer num3 = num2/4;
			System.out.println("aaa"+day1);
			

			Calendar c = Calendar.getInstance();
			Calendar c1 = Calendar.getInstance();
			c.setTime(data1);
			c1.setTime(data2);
			dataList1.add(0,sm.format(c.getTime()));
			
			for(int i = 1;i<4;i++)
			{
				c.set(Calendar.DATE,c.get(Calendar.DATE)+num3);
				Date data  = sm.parse(sm.format(c.getTime()));
				c.setTime(data);
				dataList1.add(i,sm.format(c.getTime()));
			}
			dataList1.add(4,sm.format(c1.getTime()));
			
			for(int i = 0 ; i<dataList.size();i++)
			{
				System.out.println(dataList1.get(i));
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		request.setAttribute("dataList", dataList);
		request.setAttribute("dataList1",dataList1);
		request.setAttribute("endTime", "2012-10-27");
		
		return "fusionchart";
	}
}
