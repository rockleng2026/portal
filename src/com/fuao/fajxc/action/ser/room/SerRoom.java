package com.fuao.fajxc.action.ser.room;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.json.annotations.JSON;
import org.aspectj.weaver.reflect.Java14GenericSignatureInformationProvider;
import org.jboss.cache.aop.annotation.Serializable;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import sun.util.logging.resources.logging;

import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.system.DocmentBussiness;
import com.fuao.fajxc.dao.servers.ServerDao;
import com.fuao.fajxc.serser.service.SerajaxService;
import com.fuao.fajxc.util.ThreadGetSessions;
import com.fuao.fajxc.util.ThreadupserveSave;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.City;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.LogTab;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.SaledFlow;
import com.fuao.fajxc.vo.SaveSelectInfomation;
import com.fuao.fajxc.vo.ServerChangers;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.UpServer;
import com.google.gson.JsonObject;
import com.ibm.icu.util.Calendar;
import com.sun.org.apache.bcel.internal.generic.NEW;


	public class SerRoom extends ActionSupport implements ServletRequestAware , ModelDriven,ServletResponseAware{
		
		private SerajaxService sersevice;
		private ServerDao serversDao;
		private HttpServletResponse response;
		private HttpServletRequest request;
		private String arrMessager;
		private String cabinetId;
		private Cabinet cabinet = new Cabinet();
		private ElectHouse electHouse;
		private String strinID;
		private String strinFlag;
		private int total;
	    private int current;
	    private int page;
	    private int row;
	    private String cassids;
	    private DownServer downse;
		private List rows = new ArrayList();
	    private SaveSelectInfomation uppserss;
		private UpServer upServer;
		private ServerChangers serchag;
		private String ctid;
		private String startIP;
		private String endIP;
		private Logger logs =Logger.getLogger(SerRoom.class);
		private String hsect;
		private String rsect;
		private String upcabitid;
		private String elehousn;
		private String updEleID;
		private SaleorderBussiness saleOrdBussiss;
		
		public SaleorderBussiness getSaleOrdBussiss() {
			return saleOrdBussiss;
		}
		public void setSaleOrdBussiss(SaleorderBussiness saleOrdBussiss) {
			this.saleOrdBussiss = saleOrdBussiss;
		}
		public String getCassids() {
			return cassids;
		}
		public void setCassids(String cassids) {
			this.cassids = cassids;
		}
		public String getUpdEleID() {
			return updEleID;
		}
		public void setUpdEleID(String updEleID) {
			this.updEleID = updEleID;
		}
		public String getElehousn() {
			return elehousn;
		}
		public void setElehousn(String elehousn) {
			this.elehousn = elehousn;
		}
		public String getUpcabitid() {
			return upcabitid;
		}
		public void setUpcabitid(String upcabitid) {
			this.upcabitid = upcabitid;
		}
		public String getHsect() {
			return hsect;
		}
		public void setHsect(String hsect) {
			this.hsect = hsect;
		}
		public String getRsect() {
			return rsect;
		}
		public void setRsect(String rsect) {
			this.rsect = rsect;
		}
		public String getStartIP() {
			return startIP;
		}
		public void setStartIP(String startIP) {
			this.startIP = startIP;
		}
		public String getEndIP() {
			return endIP;
		}
		public void setEndIP(String endIP) {
			this.endIP = endIP;
		}
		public void setServersDao(ServerDao serversDao) {
			this.serversDao = serversDao;
		}
	    public void setUppserss(SaveSelectInfomation uppserss) {
			this.uppserss = uppserss;
		}    
		public String getCtid() {
			return ctid;
		}

		public void setCtid(String ctid) {
			this.ctid = ctid;
		}

		public ServerChangers getSerchag() {
			return serchag;
		}

		public void setSerchag(ServerChangers serchag) {
			this.serchag = serchag;
		}

		@JSON(serialize=false)
	    public DownServer getDownse() {
			return downse;
		}
	    
		public void setDownse(DownServer downse) {
			this.downse = downse;
		}
	    @JSON(serialize=false)
		public UpServer getUpServer() {
			return upServer;
		}
	
		public void setUpServer(UpServer upServer) {
			this.upServer = upServer;
		}

		public SaveSelectInfomation getUppserss() {
			return uppserss;
		}
		public List getRows() {
			return rows;
		}
		public void setRows(List rows) {
			this.rows = rows;
		}
		public int getTotal() {
			return total;
		}
		public void setTotal(int total) {
			this.total = total;
		}
		public int getCurrent() {
			return (this.page-1)*this.row;
		}
		public void setCurrent(int current) {
			this.current = current;
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
		public String getStrinFlag() {
			return strinFlag;
		}
		public void setStrinFlag(String strinFlag) {
			this.strinFlag = strinFlag;
		}
		public String getStrinID() {
			return strinID;
       }

	public void setStrinID(String strinID) {
		this.strinID = strinID;
	}

	public Cabinet getCabinet() {
		return cabinet;
	}

	public void setCabinet(Cabinet cabinet) {
		this.cabinet = cabinet;
	}

	public ElectHouse getElectHouse() {
		return electHouse;
	}

	public void setElectHouse(ElectHouse electHouse) {
		this.electHouse = electHouse;
	}

	public String getCabinetId() {
		return cabinetId;
	}

	public void setCabinetId(String cabinetId) {
		this.cabinetId = cabinetId;
	}

	public String getArrMessager() {
		return arrMessager;
	}

	public void setArrMessager(String arrMessager) {
		this.arrMessager = arrMessager;
	}

	public void setSersevice(SerajaxService sersevice) {
		this.sersevice = sersevice;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	public Object getModel() {
		electHouse = new ElectHouse();
		return electHouse;
	}
    public String updthouse(){
    	int hid=Integer.parseInt(request.getParameter("idss"));
    	ElectHouse ehs=this.sersevice.getElehouseObj(hid);
    	JSONObject jb = new JSONObject();
    	try {
    		jb.put("ctidss", ehs.getCity().getId());
    		jb.put("supids", ehs.getSuperid());
			jb.put("hsid", ehs.getElectId());
			jb.put("hname",new String(ehs.getElectName().getBytes("GBK"),"GBK"));
			jb.put("hposit",new String(ehs.getElectPosition().getBytes("GBK"),"GBK"));
			jb.put("htel",new String(ehs.getElectTel().getBytes("GBK"),"GBK"));
			jb.put("hadmin",new String(ehs.getElectAdmin().getBytes("GBK"),"GBK"));
			jb.put("hphone",new String(ehs.getElectAdmPhone().getBytes("GBK"),"GBK"));
			jb.put("hcodes",new String(ehs.getElectCode().getBytes("GBK"),"GBK"));
			
			response.setContentType("text/html;charset=GBK");
			response.getWriter().write(jb.toString());
		} catch (JSONException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return null;
    }
    public String realUpdElet(){
    	request.getSession().removeAttribute("ctids");
    	int eleid = Integer.parseInt(updEleID);
    	int ctyd = Integer.parseInt(ctid);
    	electHouse.setShowcode("0500");
    	electHouse.setElectId(eleid);
    	City cit = new City();
    	cit.setId(ctyd);
    	electHouse.setCity(cit);
    	request.getSession().setAttribute("ctids",ctyd);
    	this.sersevice.updateHouses(electHouse);
    	this.setArrMessager("修改机房成功!");
		return "successCa";
    }
	public String creteLeftMenu() {
		System.out.println("I COME");
		if(request.getSession().getAttribute("UserEmps")==null || request.getSession().getAttribute("UserEmps").equals("")){
			String string=(String) request.getSession().getAttribute("loginName");
			List<Users> list=this.sersevice.getUsersAll(string);
			for (Users users : list) {
				request.getSession().setAttribute("UserEmps", users);
			}
		}
        ThreadGetSessions.setUser((Users)request.getSession().getAttribute("UserEmps"));
		this.request.getSession().removeAttribute("houseList");
		this.request.getSession().removeAttribute("cabList");
		List<ElectHouse> list = sersevice.selList();
		System.out.println("listca=" + list.size());
		List li = new ArrayList();
		List lims = new ArrayList();
		List rlist =new ArrayList();
		for (ElectHouse cabt : list) {
			Map map = new HashMap();
			map.put("houseName", cabt.getElectName());
			map.put("houid", cabt.getElectId());
			map.put("showcode", cabt.getShowcode());
			map.put("supID", cabt.getSuperid());
			map.put("houseRoom",cabt.getElectCode());
			li.add(map);
			rlist.add(map);
			List peletList = sersevice.get(cabt.getElectId());
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
		List provincelist = serversDao.getProvince(); //所有省份
		System.out.println(provincelist.size());
		//根据某一地区名字查询当地的机房
		List electlist = serversDao.getElectByCity("广东");
		System.out.println(electlist.get(0));
		System.out.println(electlist.size());
		request.setAttribute("provincelist", provincelist);
		request.setAttribute("electlist", electlist);
		
		this.request.getSession().setAttribute("houseList", li);
		this.request.getSession().setAttribute("cabList", lims);
		this.request.getSession().setAttribute("roomList",rlist);
		System.out.println("li=" + li);
		System.out.println("lims=" + lims);
		return "reList";
	}

//	// 查询显示信息
//	public String showallServer() {
//		int mid = Integer.parseInt(strinID);
////		System.out.println("coming select..." + mid);
//		UpServer upServer = this.sersevice.selByserID(mid);
//		request.getSession().setAttribute("allsers", upServer);
//		return SUCCESS;
//	}

	// 添加机柜
	public String createCabint() {
		Integer electid;
        if(electHouse.getElectId()==0){
        	electid= new Integer(request.getParameter("temp"));// 机房id
        }else{
        	electid = electHouse.getElectId();
        }
		ElectHouse e = (ElectHouse) this.sersevice.getConmensById(
				ElectHouse.class, electid);

		this.cabinet.setTelecthouse(e);

		this.cabinet.setDescription("cab");
		this.cabinet.setMaches(1);
		this.cabinet.setUseSize(1);

		List list = this.sersevice.get(electid);
		this.sersevice.add(cabinet);
		this.setArrMessager("添加机柜成功!");
		return "successCa";
		
	}

	// 删除机房下以及机柜
	public void delCabint() {
		String ppsString="";
		String ppsIDsString="";
		boolean flag=true;
		Integer electid =Integer.parseInt(strinID);
		this.request.getSession().setAttribute("elect",electid);
		// 根据Id得到一个对象
	  ElectHouse electHouse = (ElectHouse) this.sersevice.getConmensById(
			ElectHouse.class, electid);
		//得到机房和所有房间
		List<ElectHouse> lists = this.sersevice.IPManage("from ElectHouse e where SUBSTRING(e.electCode,1,2)=SUBSTRING('"+electHouse.getElectCode()+"',1,2)");
		for (ElectHouse electHouse2 : lists) {
			logs.info(electHouse2.getElectCode().substring(2,4));
			if(!electHouse2.getElectCode().substring(2,4).equals("00")){
				List<Cabinet> list12 = this.sersevice.IPManage("from Cabinet e where e.Telecthouse.electId="+electHouse2.getElectId());
				if(list12.size()>0){
					flag=false;
				}
			}
		}
	
		if(flag){
			List<ElectHouse> eleLi = this.sersevice.IPManage("from ElectHouse e where SUBSTRING(e.electCode,1,2)=SUBSTRING('"+electHouse.getElectCode()+"',1,2)");
			for (ElectHouse electHouse2 : eleLi) {
				this.sersevice.delEle(electHouse2);
			}
			ppsString="删除机房成功";
		}else{
			for (Iterator iterator = lists.iterator(); iterator.hasNext();) {
				ElectHouse eleObj = (ElectHouse) iterator.next();
				logs.info("substring="+eleObj.getElectCode().substring(2,4));
				if(!eleObj.getElectCode().substring(2,4).equals("00")){
				  ppsIDsString+=eleObj.getElectId()+",";
				}
			}
			ppsString="删除失败，因为此机房还存在机柜，请确定是否先转移后删除?";
		}
		request.getSession().setAttribute("allRooms",ppsIDsString);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(ppsString);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//确定后加载机房
	public void loadHouses(){
		String ppsString="";
		Integer electid =Integer.parseInt(strinID);

		List<ElectHouse> lists = this.sersevice.IPManage("from ElectHouse e where substring(e.electCode,3,2)='00'");
		ppsString+="<form method='post' id='roomOrHouseForm' >请选择机房:<select id='hsect' name='hsect' onchange='clickHouses()'><option value='0'>请选择</option>";
		for (ElectHouse electHouse : lists) {
			if(electHouse.getElectCode().substring(2,4).equals("00")){
			 ppsString+="<option value='"+electHouse.getElectCode()+"'>"+electHouse.getElectName()+"</option>";
			}
		}
		ppsString+="</select>请选择房间:<select id='rsect' name='rsect'><option value='0' selected>请选择</option></select></br>" +
				"<input type='hidden' id='elehousn' name='elehousn'/><input type='button' style='width:130px;height:30px;' onclick='subHouseRooms()' value='提交'/></form>";
        ppsString=ppsString+","+electid;
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(ppsString);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//通过机房加载有机柜的房间
	public void loadRooms(){
		String ppsString="";
		String mt=strinID.substring(0,2); 
		List<ElectHouse> lists = this.sersevice.IPManage("from ElectHouse e where substring(e.electCode,1,2)='"+mt+"'");
		for (ElectHouse electHouse : lists) {
			if(!electHouse.getElectCode().substring(2,4).equals("00")){
			  ppsString+="<option value='"+electHouse.getElectId()+"'>"+electHouse.getElectName()+"</option>";
		
			}
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(ppsString);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//确定后删除机房
	public String conDelHouse(){
		String ppsString="";
		ElectHouse elt=new ElectHouse();
		//删除机房
		elt.setElectId(Integer.parseInt(elehousn));
		this.sersevice.delEle(elt);
		logs.info("hsect(code)="+hsect+","+rsect);//修改时用,转移到这里,前面是code,后面是ID。。。delCabin(Cabinet)
		String allelectid=(String) request.getSession().getAttribute("allRooms");//要删除的房间
		String arrid[]=allelectid.split(",");
		for(int i=0;i<arrid.length;i++){
			int pi=Integer.parseInt(arrid[i]);
			List<Cabinet> lists = this.sersevice.IPManage("from Cabinet e where e.Telecthouse.electId="+pi);
			for (Cabinet cabinet : lists) {
				//this.sersevice.delCabin(cabinet);
				ElectHouse eh=new ElectHouse();
				eh.setElectId(Integer.parseInt(rsect));
				cabinet.setTelecthouse(eh);
				this.sersevice.updateCa(cabinet);
			}
		}
		for(int s=0;s<arrid.length;s++){
		   if(arrid[s]!="" || arrid[s]!=null){
			ElectHouse ehouse = (ElectHouse) this.sersevice.getConmensById(
						ElectHouse.class, Integer.parseInt(arrid[s]));
			List<ElectHouse> eleLi = this.sersevice.IPManage("from ElectHouse e where SUBSTRING(e.electCode,1,2)=SUBSTRING('"+ehouse.getElectCode()+"',1,2)");
			for (ElectHouse electHouse2 : eleLi) {
				this.sersevice.delEle(electHouse2);
			}
		   }
		}
		
		this.setArrMessager("转移删除机房成功.");
		return "successCa";
	}
	
	//判断机房是否相同的
	public String addAjaxname()
	{
//		System.out.println("进来了了..");
		String electname = request.getParameter("electname");
		
		try {
			electname = URLDecoder.decode(electname, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String temp;
		List list = this.sersevice.findELe(electname);
		if (list.size() > 0 && list != null) {
			temp = "名称不能相同!";
		}
		else
		{
			temp = "该名称可用!";
		}
		try {
//			System.out.println("x");
			System.out.println(electname);
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(temp);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	// 添加机房
	public String addEle() {
			try {
				System.out.println("yyyyyyyyyyyyyyyyyyyyyyinfo");
				this.electHouse.setShowcode("0500");
				City cy = new City();
				cy.setId(Integer.parseInt(ctid));
				this.electHouse.setCity(cy);
				this.sersevice.saveEle(electHouse);
				this.setArrMessager("操作成功,单击页面将跳转!");	
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "successCa";
//		}
	}

	// 删除单个机柜
	public String delCabinet() {
//		System.out.println("I Comm me");
		int caid =Integer.parseInt(request.getParameter("caid"));
		this.request.getSession().setAttribute("caid1",caid);
		Cabinet cabinet1 = (Cabinet) this.sersevice.getConmensById(
				Cabinet.class, caid);
		//判断机柜下是否有服务器
		List list = this.sersevice.findUp(cabinet1.getCaid());
		if(list != null && list.size() > 0)
		{
			this.setArrMessager("由于机柜下有服务器，不能删除此机柜，可先单击<a href='javascript:findCabinet("+cabinet1.getCaid()+")'>转移</a>里面的服务器后再执行删除操作。");
			return "find";
		}
		
		this.sersevice.delCabin(cabinet1);
		this.setArrMessager("删除机柜成功");
		return "successCa";
	}

	// 获得单个机柜
	public void updateCaUI() {
//		System.out.println("I Comm in update");
		Integer caid = new Integer(upcabitid);
		Cabinet cabinet = (Cabinet) this.sersevice.getConmensById(
				Cabinet.class, caid);
		response.setContentType("text/html;charset=GBK");
		JSONObject jb = new JSONObject();
		try {
			jb.put("cid", cabinet.getCaid());
			jb.put("hid", cabinet.getTelecthouse().getElectId());
			jb.put("name",new String(cabinet.getCaname().getBytes("GBK"),"GBK"));
			jb.put("size",cabinet.getCasz());
			jb.put("max", cabinet.getPmax());
			jb.put("wmax",cabinet.getBwmax());
			response.getWriter().write(jb.toString());
	
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	// 修改机柜
	public String updateCa() {
		try {
			request.setCharacterEncoding("GBK");
//			System.out.println("I Comm");
			//Integer caid = new Integer(request.getParameter("caid"));
			//Integer electid = new Integer(request.getParameter("electid"));
			//this.cabinet.setCaid(caid);
			this.cabinet.setDescription("0020");
			//this.cabinet.setElehouse(1);
			this.cabinet.setUseSize(1);
			this.cabinet.setMaches(0);
			//this.cabinet.getTelecthouse().setElectId(electid);
			this.cabinet.setTelecthouse(electHouse);
			this.sersevice.updateCa(cabinet);
			this.setArrMessager("修改成功!");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "successCa";
	}
	//查询所有的机房
	public String seleEle()
	{
		System.out.println("I Comm in chain");
		Integer electid = new Integer(request.getParameter("electid"));
//		System.out.println("得到的数字"+electid);
		List<ElectHouse> list = this.sersevice.findEle();
		for(int i = 0 ; i < list.size() ; i++)
		{
			if(electid == list.get(i).getElectId())
			{
				list.remove(i);
			}
		}
		System.out.println(list.get(0).getElectId());
		this.request.setAttribute("list11", list);
		return "allEle";
	}
	
	public String showImager(){
		System.out.println("sing="+cabinetId);
		Cabinet cabt = (Cabinet) sersevice.getObjDate(Integer.parseInt(cabinetId));
		int ms=cabt.getCasz();
		int pus=0;
		cabt.setMaches((ms/2));
		List<UpServer> list=sersevice.selbyUps(Integer.parseInt(cabinetId),0);
		List lis = new ArrayList();
		System.out.println("list="+list.size());
		for (UpServer ups : list) {
			Map mp = new HashMap();
			if(ups.getUpFlag()==1){
				mp.put("flagColor","green");
			}else if(ups.getUpFlag()==2){
				mp.put("flagColor", "yellow");
			}else{
				
			}
			String arr[]=ups.getMarknum().split(",");
			int spacesize = (Integer.parseInt(arr[1])-Integer.parseInt(arr[0])+1);
			mp.put("sizes",spacesize);
			pus=((Integer.parseInt(arr[1])-Integer.parseInt(arr[0])+1)*10);
			mp.put("marknumberstart",(ups.getTupcabs().getCasz()-Integer.parseInt(arr[1]))*10+71);
			mp.put("marknumberend",pus);
			mp.put("upflag",ups.getUpFlag());
			String ipcomString = ups.getServerIp();
			String ipcon="";
		
		    String str[]=ipcomString.split(",");
		    ipcon = str[0];
			
			mp.put("ipcon",ipcon);
			mp.put("upserID", ups.getId());
			lis.add(mp);
		}
		System.out.println("lis="+lis);
		cabt.setUseSize(lis.size());
		this.sersevice.updateCa(cabt);
		request.getSession().setAttribute("cabinet",cabt);
		request.getSession().setAttribute("showList",lis);
		request.getSession().setAttribute("casize",cabt.getCasz());
		return "showSingleImg";
	}
	
	//从机房里面的机柜转移到别的机房
	public void updateorC()
	{
//		System.out.println("I Comm in updateorC");
		Integer electid = new Integer(request.getParameter("electid"));
		Integer elect = new Integer(this.request.getSession().getAttribute("elect").toString());
		System.out.println(electid);
		List list = this.sersevice.get(elect);
		if(!list.isEmpty()){
			for(int i = 0 ;i < list.size() ; i++)
			{
				Cabinet cabinet = (Cabinet) list.get(i);
				this.sersevice.updateInc(electid, cabinet.getCaid());

			}
		}
		String temp = "转移成功!";
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(temp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

        //查询显示信息
	public String showallServer(){
			int mid = Integer.parseInt(strinID);
			System.out.println("coming select..."+mid+","+strinFlag);
			UpServer upServer=this.sersevice.selByserID(mid);
			SaveSelectInfomation savesels = new SaveSelectInfomation();
			request.getSession().removeAttribute("titleList");
			//查询服务器
			if(strinFlag.equals("ser")){
				 request.getSession().removeAttribute("customList");
                 Map mp = new HashMap();
				 savesels.setTmp1(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp1());
				 savesels.setTmp2(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp2());
				 savesels.setTmp3(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp3());
				 savesels.setTmp4(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp4());
				 savesels.setTmp5(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp5());
				 savesels.setTmp6(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp6());
				 savesels.setTmp7(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp7());
				 savesels.setTmp8(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp8());
				 savesels.setTmp9(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp9());
				 savesels.setTmp10(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp10());
				 savesels.setTmp11(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp11());
				 savesels.setTmp12(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp12());
				 savesels.setTmp13(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp13());
				 savesels.setTmp14(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp14());
				 savesels.setTmp15(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp15());
				 savesels.setTmp16(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp16());
				 savesels.setTmp17(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp17());
				 savesels.setTmp18(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp18());
				 savesels.setTmp19(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp19());
				 savesels.setTmp20(upServer.getProduct().getProperty().getModel().getCommodityTpye().getField().getTemp20());
			     if(savesels.getTmp1()!=null){
			    	 //1值
			    	 savesels.setTmp21(upServer.getProduct().getProperty().getTemp1());
			    	  mp.put(savesels.getTmp1(),savesels.getTmp21());
			     }
			     if(savesels.getTmp2()!=null){
			    	 //2值
			    	 savesels.setTmp22(upServer.getProduct().getProperty().getTemp2());
			    	 mp.put(savesels.getTmp2(),savesels.getTmp22());
			     }
			     if(savesels.getTmp3()!=null){
			    	 //3值
			    	 savesels.setTmp23(upServer.getProduct().getProperty().getTemp3());
			    	 mp.put(savesels.getTmp3(),savesels.getTmp23());
			     }
			     if(savesels.getTmp4()!=null){
			    	 //4值
			    	 savesels.setTmp24(upServer.getProduct().getProperty().getTemp4());
			    	 mp.put(savesels.getTmp4(),savesels.getTmp24());
			     }
			     if(savesels.getTmp5()!=null){
			    	 //5值
			    	 savesels.setTmp25(upServer.getProduct().getProperty().getTemp5());
			    	 mp.put(savesels.getTmp5(),savesels.getTmp25());
			     }
			     if(savesels.getTmp6()!=null){
			    	 //6值
			    	 savesels.setTmp26(upServer.getProduct().getProperty().getTemp6());
			    	 mp.put(savesels.getTmp6(),savesels.getTmp26());
			     }
			     if(savesels.getTmp7()!=null){
			    	 //7值
			    	 savesels.setTmp27(upServer.getProduct().getProperty().getTemp7());
			    	 mp.put(savesels.getTmp7(),savesels.getTmp27());
			     }
			     if(savesels.getTmp8()!=null){
			    	 //8值
			    	 savesels.setTmp28(upServer.getProduct().getProperty().getTemp8());
			    	 mp.put(savesels.getTmp8(),savesels.getTmp28());
			     }
			     if(savesels.getTmp9()!=null){
			    	 //9值
			    	 savesels.setTmp29(upServer.getProduct().getProperty().getTemp9());
			    	 mp.put(savesels.getTmp9(),savesels.getTmp29());
			     }
			     if(savesels.getTmp10()!=null){
			    	 //10值
			    	 savesels.setTmp30(upServer.getProduct().getProperty().getTemp10());
			    	 mp.put(savesels.getTmp10(),savesels.getTmp30());
			     }
			     if(savesels.getTmp11()!=null){
			    	 //11值
			    	 savesels.setTmp31(upServer.getProduct().getProperty().getTemp11());
			    	 mp.put(savesels.getTmp11(),savesels.getTmp31());
			     }
			     if(savesels.getTmp12()!=null){
			    	 //12值
			    	 savesels.setTmp32(upServer.getProduct().getProperty().getTemp12());
			    	 mp.put(savesels.getTmp12(),savesels.getTmp32());
			     }
			     if(savesels.getTmp13()!=null){
			    	 //13值
			    	 savesels.setTmp33(upServer.getProduct().getProperty().getTemp13());
			    	 mp.put(savesels.getTmp13(),savesels.getTmp33());
			     }
			     if(savesels.getTmp14()!=null){
			    	 //14值
			    	 savesels.setTmp34(upServer.getProduct().getProperty().getTemp14());
			    	 mp.put(savesels.getTmp14(),savesels.getTmp34());
			     }
			     
			     if(savesels.getTmp15()!=null){
			    	 //15值
			    	 savesels.setTmp35(upServer.getProduct().getProperty().getTemp15());
			    	 mp.put(savesels.getTmp15(),savesels.getTmp35());
			     }
			     if(savesels.getTmp16()!=null){
			    	 //16值
			    	 savesels.setTmp36(upServer.getProduct().getProperty().getTemp16());
			    	 mp.put(savesels.getTmp16(),savesels.getTmp36());
			     }
			     if(savesels.getTmp17()!=null){
			    	 //17值
			    	 savesels.setTmp37(upServer.getProduct().getProperty().getTemp17());
			    	 mp.put(savesels.getTmp17(),savesels.getTmp37());
			     }
			     if(savesels.getTmp18()!=null){
			    	 //18值
			    	 savesels.setTmp38(upServer.getProduct().getProperty().getTemp18());
			    	 mp.put(savesels.getTmp18(),savesels.getTmp38());
			     }
			     if(savesels.getTmp19()!=null){
			    	 //19值
			    	 savesels.setTmp39(upServer.getProduct().getProperty().getTemp19());
			    	 mp.put(savesels.getTmp19(),savesels.getTmp39());
			     }
			     if(savesels.getTmp20()!=null){
			    	 //20值
			    	 savesels.setTmp40(upServer.getProduct().getProperty().getTemp20());
			    	 mp.put(savesels.getTmp20(),savesels.getTmp40());
			     }
			     strinFlag="";
			     request.getSession().setAttribute("titleList",mp);
			     request.getSession().setAttribute("servID",mid);
			     response.setContentType("text/html;charset=gbk");
			     try {
					response.getWriter().write("yes");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			     //this.setUppserss(savesels);
			}else{
				//request.getSession().removeAttribute("titleList");
				JSONObject jb = new JSONObject();
				try {
					jb.put("upserID",new String(upServer.getUpNo().getBytes("GBK"),"GBK"));
					jb.put("custerCompany",new String(upServer.getCustomer().getCustomerCompany().getBytes("GBK"),"GBK"));
					jb.put("custerString",new String(upServer.getCustomer().getCustomerName().getBytes("GBK"),"GBK"));
					jb.put("customerPhone",new String(upServer.getCustomer().getMobilePhone().getBytes("GBK"),"GBK"));
					jb.put("serverPort",new String(upServer.getPort().getBytes("GBK"),"GBK"));
					jb.put("netWidth",upServer.getBandwidthAmount());
					jb.put("countIP",upServer.getIpnum());
					jb.put("numberIP",new String(upServer.getServerIp().getBytes("GBK"),"GBK"));
					jb.put("exchangeMatch",new String(upServer.getJhjname().getBytes("GBK"),"GBK"));
					jb.put("admOperString",new String(upServer.getEmployee().getName().getBytes("GBK"),"GBK"));
					jb.put("uptimeString",new String(upServer.getUptime().toString().getBytes("GBK"),"GBK"));
					jb.put("downtimeString",new String(upServer.getDowntime().toString().getBytes("GBK"),"GBK"));
					//System.out.println("jb"+jb.toString());
					response.setContentType("text/html;charset=gbk");
					Writer out = response.getWriter();
					out.write(jb.toString());
				}catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			 return null;
            
		}
		public String outputJson(){
			    int mid = Integer.parseInt(request.getParameter("strinID"));
			     this.page=Integer.parseInt(request.getParameter("page"));
			     this.row=Integer.parseInt(request.getParameter("rows"));
			     total = this.sersevice.selAllLoggers(mid);
			     System.out.println("total="+total);
			     this.rows = this.returnMap(this.sersevice.spliPages(this.getCurrent(),row,mid));
			     System.out.println("rowlist="+rows);
			     return SUCCESS;
		}
		//查询上架服务器
		public String downListservs(){
			int upid = Integer.parseInt(request.getParameter("upss"));
			System.out.println("ps="+upid);
			UpServer upServer=this.sersevice.selByserID(upid);
			request.getSession().setAttribute("upseList",upServer);
			return "downListsvs";
		}
		//下架服务器
		public String downthisServs(){
			System.out.println("downLoad...="+downse.getUpNo());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd",Locale.ENGLISH);
			UpServer upServer=this.sersevice.selByserID(Integer.parseInt(downse.getUpNo()));
			int cid = upServer.getTupcabs().getCaid();
			upServer.setUpFlag(2);
			upServer.setDelflag(0);//  
			this.sersevice.updaUperStat(upServer);
			sdf.setLenient(false);
			Date stri;
			try {
				String mt[] = downse.getDowTimedt().split("/");
				String pm = mt[2]+"-"+mt[0]+"-"+mt[1];
				stri = sdf.parse(pm);
				downse.setDtime(new Timestamp(stri.getTime()));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			downse.setDownFlag(2);
			downse.setAuditingFlag(1);
			downse.setDelflag(0);
			downse.setProduct(upServer.getProduct());
			downse.setCustomer(upServer.getCustomer());
			ThreadGetSessions.setUser((Users)request.getSession().getAttribute("UserEmps"));
			ThreadupserveSave.setUpSers(upServer);  //保存日志
			List<Employee> lt=this.sersevice.getOnceObject(Employee.class, "empNo", request.getSession().getAttribute("loginName").toString());
            System.out.println("lt="+lt.size());
			downse.setEmployee((Employee)lt.get(0));
			this.sersevice.saveDownSers(downse);
			response.setContentType("text/html;charset=GBK");
			try {
				response.getWriter().write("yes");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			response.setCharacterEncoding("GBK");
//			response.setHeader("refresh","1;url="+request.getContextPath()+"/serm/pager/innit.jsp?caid="+cid);
			return null;
		}
		@SuppressWarnings("unchecked")
		public List returnMap(List mli){
			List list =new ArrayList();
			for (Iterator iterator = mli.iterator(); iterator.hasNext();) {
				LogTab lTab = (LogTab) iterator.next();
				Map map = new HashMap();
				map.put("sername", lTab.getTupve().getProduct().getProperty().getName());
				map.put("logMen", lTab.getLoadmin());
				map.put("logOper", lTab.getLooper());
				map.put("logTime", lTab.getLoTime());
				list.add(map);
			}
			return list;
		}
		//修改上架状态
		public String upServerStat(){
			System.out.println(request.getSession().getAttribute("UserEmps"));
			ThreadGetSessions.setUser((Users)request.getSession().getAttribute("UserEmps"));
			int mid = Integer.parseInt(strinID);
			UpServer upServer = this.sersevice.selByserID(mid);
			ThreadupserveSave.setUpSers(upServer);
			upServer.setUpFlag(1);
			this.sersevice.upsaveStats(upServer);
			this.setArrMessager("服务器上架成功");
			//response.setCharacterEncoding("GBK");
			//response.setHeader("refresh","1;url="+request.getContextPath()+"/serm/pager/innit.jsp?caid="+caids);
			return SUCCESS;
		}

	//查询所有的机柜下除原来机柜
	public void seleCab()
	{
		int caid =Integer.parseInt(cabinetId);
		List<Cabinet> list = this.sersevice.find(caid);
		String bb = "";
		for(int i = 0 ; i < list.size() ; i++)
		{
			if(list.get(i).getCaid() == caid)
			{
				list.remove(i);
			}
			if(i==0){
				bb+="<option value='0'>请选择转移后的机柜</option>";
			}
			bb+="<option value='"+list.get(i).getCaid()+"'>"+list.get(i).getCaname()+"</option>";
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(bb);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//转入单个服务器
	public String servChange(){
		int id = Integer.parseInt(request.getParameter("caid"));
		logs.info("id="+id);
		request.setAttribute("loadcids",id);
		return "returnInnit";
	}
	//修改机柜表下的服务器
	public String updateU()
	{
		ThreadGetSessions.setUser((Users)request.getSession().getAttribute("UserEmps"));
		Integer caid = new Integer(request.getSession().getAttribute("caid1").toString());
		Integer caid1 = new Integer(request.getParameter("caid"));
		System.out.println(caid);
		List list = this.sersevice.findUp(caid);
		if(list.size()>0 && list != null){
			for(int i = 0 ; i< list.size() ; i ++)
			{
				UpServer upServer = (UpServer) list.get(i);
				ThreadupserveSave.setUpSers(upServer);
				this.sersevice.updateUp(caid1, upServer.getId());
			}
		}
		this.setArrMessager("转移成功!");
		return "successCa";
	}
	//转到上架单，传机柜ID
	public String putCabitId(){
		logs.info("sti="+cassids);
		request.setAttribute("catids",cassids);
		return "putcaids";
	}
	//新增上架单
	public String saveUp()
	{
		ThreadGetSessions.setUser((Users)request.getSession().getAttribute("UserEmps"));
		System.out.println("I saveUP");
		upServer.setId(0);
		StringBuffer stb = new StringBuffer();
		stb.append(upServer.getStartpossition())
		.append(",")
		.append(upServer.getEndpossition());
		upServer.setMarknum(stb.toString());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",Locale.ENGLISH);
		Date d1;
		Date d2;
		try {
			String mt[] = upServer.getDowntimeString().split("/");
			String pm = mt[2]+"-"+mt[0]+"-"+mt[1];
			d1 = sdf.parse(upServer.getUptimeString());
			d2=sdf.parse(pm);
			Timestamp tsp1=new Timestamp(d1.getTime());
			Timestamp tsp2=new Timestamp(d2.getTime());
			upServer.setUptime(tsp1);
			upServer.setDowntime(tsp2);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		cabinet.setCaid(Integer.parseInt(upServer.getJgh()));
		upServer.setTupcabs(cabinet);
		Employee employee = new Employee();
		employee.setId(upServer.getEmpIds());
		ThreadupserveSave.setUpSers(upServer);
		SaledFlow safw = new  SaledFlow();
		List<SaleOrder> lis=this.sersevice.getsaleNode(upServer.getSalenodeString());
		for (SaleOrder saleOrder : lis) {
			upServer.setSaleOrder(saleOrder);
			safw.setTsaleorders(saleOrder);
		}
		upServer.setEmployee(employee);
		upServer.setUpFlag(1);
		upServer.setDelflag(0);
		sersevice.saveupser(upServer);
		safw.setDfId(0);
		safw.setDfContent("服务器已上架，感谢你的使用...");
        safw.setDftime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
        saleOrdBussiss.saveFlowInfo(safw);
		response.setCharacterEncoding("GBK");
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//response.setHeader("refresh","1;url="+request.getContextPath()+"/serm/pager/innit.jsp?caid="+Integer.parseInt(upServer.getJgh()));
		return null;
	}
	//单个服务器转移
	public void changerOnOther(){
		System.out.println("来了"+serchag.getChangeHouse()+","+serchag.getChangecabit());
		ThreadGetSessions.setUser((Users)request.getSession().getAttribute("UserEmps"));
		UpServer upser=this.sersevice.selByserID(serchag.getUpidString());
		Cabinet cta = new Cabinet();
		cta.setCaid(Integer.parseInt(serchag.getChangecabit()));
		upser.setUpFlag(2);
		upser.setMarknum((serchag.getNumber3()+","+serchag.getNumber4()));
		upser.setTupcabs(cta);
		ThreadupserveSave.setUpSers(upser);
		sersevice.updateAllupsers(upser);
		response.setCharacterEncoding("GBK");
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//response.setHeader("refresh","1;url="+request.getContextPath()+"/serm/pager/innit.jsp?caid="+cta.getCaid());
	}
	//查询IP
    public void IPselct(){
         logs.info("ips="+startIP+","+endIP);
         String smtString="";
    	 List<IPConfiguration> lit=this.sersevice.IPManage("from IPConfiguration p WHERE INET_ATON(p.ipcaddress)  BETWEEN  INET_ATON('"+startIP+"') AND  INET_ATON('"+endIP+"') and p.ipcstate=0");
    	 if(lit.size()>0){
    	 smtString+="<div style='background-color:#999;margin-left:15px;'>";
    	 for (IPConfiguration ips : lit) {
    		
    		 smtString+="<input type='checkbox' name='cheb' value='"+ips.getIpcaddress()+"'>"+ips.getIpcaddress();
   
    		 smtString+="</br>";
    	 
    	 }
    	 smtString+="</div>";
    	 }else{
    		 smtString="no";
    	 }
    	 response.setContentType("text/html;charset=GBK");
    	 try {
			response.getWriter().write(smtString);
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
	
}


