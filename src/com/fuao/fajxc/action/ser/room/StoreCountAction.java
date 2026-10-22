package com.fuao.fajxc.action.ser.room;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.serser.service.StoreCountService;
import com.fuao.fajxc.util.ExportInfomations;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.StoreRoomInfos;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class StoreCountAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private Logger logs = Logger.getLogger(StoreCountAction.class);
	private HttpServletResponse response;
	private StoreCountService storeSers;
	private int flagValue;
	private int current;
	private int page;
	private int row;
	private int total;
	private List rows= new ArrayList();
    private String massagerString;
    private String flagString;
    private String propertyString;

	public String getFlagString() {
		return flagString;
	}
	public void setFlagString(String flagString) {
		this.flagString = flagString;
	}
	public String getPropertyString() {
		return propertyString;
	}
	public void setPropertyString(String propertyString) {
		this.propertyString = propertyString;
	}
	public String getMassagerString() {
		return massagerString;
	}
	public void setMassagerString(String massagerString) {
		this.massagerString = massagerString;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
	public void setCurrent(int current) {
		this.current = current;
	}
	public int getCurrent() {
		return (page-1)*row;
	}
	public int getFlagValue() {
		return flagValue;
	}
	public void setFlagValue(int flagValue) {
		this.flagValue = flagValue;
	}
	public void setStoreSers(StoreCountService storeSers) {
		this.storeSers = storeSers;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
		
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
		
	}
	//分页的
	public String stormRoomDateDeal(){
		if(request.getParameter("params").equals("all")){
			getAllDatas();
		}
		if(request.getParameter("params").equals("middle")){
			int storageid=Integer.parseInt(request.getParameter("stoid"));
			if(storageid==0){
				getAllDatas();
			}else{
				page=Integer.parseInt(request.getParameter("page"));
				this.row=Integer.parseInt(request.getParameter("rows"));
				logs.info("pr="+page+","+row);
				this.total = this.storeSers.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice  from Product p where p.depot.id="+storageid);
				rows =getListAll(this.storeSers.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.id="+storageid,this.getCurrent(), row));
				
			}
		}
		    logs.info("rows="+rows);
			request.getSession().setAttribute("DataLists", rows);
		    return SUCCESS;
	}
	public void getAllDatas(){
		page=Integer.parseInt(request.getParameter("page"));
		this.row=Integer.parseInt(request.getParameter("rows"));
		logs.info("pr="+page+","+row);
		this.total = this.storeSers.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice  from Product p");
		List lt=this.storeSers.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice  from Product p",this.getCurrent(),row);
		rows =getListAll(lt);
		
	}
	
	public void getAllDatas2() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String depotid = request.getParameter("depotid");
		int id = Integer.parseInt(depotid);
	//	String sql = "select DISTINCT p.id,p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.pprice,p.property.unit from Product p where p.depot.id="+id+" and p.isfreeze = 0 group by p.property.name";
		
		String sql = "select DISTINCT p.id,p.property.name,p.property.model.commodityTpye.typeName,p.depot.name from Product p where p.depot.id="+id+" and  usestate=2 group by p.property.name";
		System.out.print(sql);
	//	List list = this.storeSers.executeSql(sql);
	//	List lt=this.storeSers.getStoreList2("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice  from Product p where p.depot.id="+id);
		List lt = this.storeSers.getStoreList2(sql);
		String str = getListAll2(lt);
		System.out.println(str);
		out.print(str);
	}
	
	//封装数据
	@SuppressWarnings("unchecked")
	public String getListAll2(List li){
		String str = "";
		try {
			List ls=new ArrayList();
			Map sr = new HashMap();
			for (int j=0;j<li.size();j++) {
				Object []prot=(Object[])li.get(j);
				String hql = "from Product p where p.depot.name='"+prot[3]+"'  and usestate=2  and  p.property.name='"+prot[1]+"'" ;//and p.property.model.commodityTpye.typeName='"+prot[2]+"'
			//	int num=this.storeSers.getStoreSize("from Product p where p.depot.name='"+prot[3]+"' and p.property.model.commodityTpye.typeName='"+prot[2]+"' and  p.property.name='"+prot[1]+"' and p.property.pcord='"+prot[4]+"'  and p.property.unit='"+prot[6]+"' and p.property.pprice="+prot[5]);
				int num=this.storeSers.getStoreSize(hql);
				str += prot[0]+","+prot[1]+","+num+"|";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return str;
	}
	
	//封装数据
	@SuppressWarnings("unchecked")
	public List getListAll(List li){
		List ls=new ArrayList();
		for (int j=0;j<li.size();j++) {
			Object []prot=(Object[])li.get(j);
        	Map sr = new HashMap();
			sr.put("coding",prot[4]);
			sr.put("type",prot[2]);
			sr.put("name",prot[1]);
     		sr.put("house",prot[3]);
			sr.put("num",this.storeSers.getStoreSize("from Product p where p.depot.name='"+prot[3]+"' and p.property.model.commodityTpye.typeName='"+prot[2]+"' and  p.property.name='"+prot[1]+"' and p.property.pcord='"+prot[4]+"'  and p.property.unit='"+prot[5]+"' and p.property.pprice="+prot[6]));
			sr.put("price",prot[6]);
			sr.put("unit",prot[5]);
			ls.add(sr);
		}
		return ls;
	}
	//分仓管理查询单个选项
	public void getSingleSelect(){
		logs.info("进入单个选项");
		String strin=this.storeSers.getSingleSelect(flagString);
        try {
        	response.setCharacterEncoding("UTF-8");
			response.getWriter().write(strin);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//分条件查询
	public String storeSelectDate(){
	    String sect1="";
	    String sect2="";
	    String sect3="";
	    String sect4=request.getParameter("st4");
	    String sels="";
		try {
			sect1=new String(request.getParameter("st1").getBytes("ISO-8859-1"),"GBK");
			sect2=new String(request.getParameter("st2").getBytes("ISO-8859-1"),"GBK");
			sect3=new String(request.getParameter("st3").getBytes("ISO-8859-1"),"GBK");
			sels = new String(request.getParameter("st5").getBytes("ISO-8859-1"),"GBK");
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		logs.info("查询条件="+sels+","+sect2+","+sect3+","+sect1);
		page=Integer.parseInt(request.getParameter("page"));
		this.row=Integer.parseInt(request.getParameter("rows"));
		logs.info("pr="+page+","+row);
		this.total = this.storeSers.diffrentCount(sect1, sect2, sect3, sect4, sels);
	    rows =getListAll(this.storeSers.differentCondition(sect1, sect2, sect3, sect4, sels,this.getCurrent(), row));
		logs.info("rowslist="+rows);
	    return SUCCESS;
	}
	//仓库统计里的
	public void selectAll(){
		//request.getSession().removeAttribute("selectAll");
		String strin="";
		this.setMassagerString("");
		List<Depot> list=this.storeSers.selAllDateList();
		for (Depot depot : list) {
			strin="<option value="+depot.getId()+">"+depot.getName()+"</option>"+strin;
		}
		this.setMassagerString(strin);
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(massagerString);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void exports(){
		List<String> titles = new ArrayList<String>();
		titles.add("所属机房 ");
		titles.add("商品编码 ");
		titles.add("商品名称  ");
		titles.add("数量  ");
		titles.add("单位 ");
		titles.add("数量单价");
		titles.add("商品类型 ");
		List shows = new ArrayList();
		shows.add("house");
		shows.add("coding");
		shows.add("name");
		shows.add("num");
		shows.add("price");
		shows.add("unit");
		shows.add("type");
		ExportInfomations ex = new ExportInfomations(response,"storage",titles,(List<Map>) request.getSession().getAttribute("DataLists"),shows);
        ex.exported();
	}
}