package com.fuao.fajxc.serser.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.directwebremoting.util.LogErrorHandler;

import sun.nio.cs.MS1250;

import com.fuao.fajxc.serser.dao.SerajaxDao;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.City;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.UpServer;
import com.sun.org.apache.bcel.internal.generic.RETURN;
import com.sun.xml.internal.ws.message.StringHeader;

public class CabinetContent {
    
	private SerajaxDao serAjax;
	private SerajaxService serajaxService;
	private Logger logs=Logger.getLogger(CabinetContent.class);
	
	public SerajaxService getSerajaxService() {
		return serajaxService;
	}

	public void setSerajaxService(SerajaxService serajaxService) {
		this.serajaxService = serajaxService;
	}

	public SerajaxDao getSerAjax() {
		return serAjax;
	}

	public void setSerAjax(SerajaxDao serAjax) {
		this.serAjax = serAjax;
	}
	public String getUpservNumber(String st){
		//获得上架单号
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,"EveryDaySerialNumber.dat");
		String ckNo="SJ-"+serial.getSerialNumber();
		System.out.println("ckno="+ckNo);
        return ckNo;
	}
	//销售定单
	public String getUpsernode(String upno){
		System.out.println("get orders");
		//获取所有的订单
		List<SaleOrder> listsale = this.serAjax.findAllSale(upno);
		StringBuffer strin = new StringBuffer();
		for (SaleOrder saleOrder : listsale) {
			try{
			strin.append(saleOrder.getCustomer().getCustomerCompany())
			.append(",").append(saleOrder.getCustomer().getCustomerName())
			.append(",").append(saleOrder.getCustomer().getMobilePhone())
			.append(",").append(saleOrder.getCustomer().getEmployee().getName())
			//.append(",").append(saleOrder.getProperty().getProperty().getName())//服务器
			.append(",").append(saleOrder.getSpaceSize())//服务器大小
			.append(",").append(saleOrder.getCustomer().getEmployee().getId())//员工ID
			.append(",").append(saleOrder.getCustomer().getCustomerId())
			.append(",").append(saleOrder.getIpNum());
			
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return strin.toString();
	}
	//验证位置
	public String getCabpossition(String cabs){
		String arr[]=cabs.split(",");
		int start=Integer.parseInt(arr[0]);
		int end=Integer.parseInt(arr[1]);
		Integer caid=Integer.parseInt(arr[2]);
		int flag=1;
		List<UpServer>list=serAjax.findCabUper(caid);
		if(list.size()>0){
	    for (UpServer upServer : list) {
	      if(end <(upServer.getTupcabs().getCasz())){
			String nums[]=upServer.getMarknum().split(",");
			int st=Integer.parseInt(nums[0]);
			int en=Integer.parseInt(nums[1]);
			System.out.println("marknum="+upServer.getMarknum());
			for(int i=st;i<=en;i++){
				for (int j = start; j <=end; j++) {
					if(i==j || (en+1)==j){
						flag=0;
						break;
					}else if(i<j && j<=(en+1)){
						flag=0;
						break;
					}else{
						
					}
				}
				if(flag==0){
				    break;
				}
			}
	      }else{
	    	  flag=0;
	    	  break;
	      }
		}
		}
	   if(flag==0){
		  return "no";
	   }else{
		   return "yes";
	   }
	}
	//转移前的暂时下架
	public String upsFlags(String m){
		String str[]=m.split(",");
		UpServer up=this.serAjax.selByserID(Integer.parseInt(str[0]));
		int hoid=up.getTupcabs().getTelecthouse().getElectId();
		String houseString=up.getTupcabs().getTelecthouse().getElectName();
		int caid=up.getTupcabs().getCaid();
		int upid=up.getId();
		String caString=up.getTupcabs().getCaname();
		String mark[]=up.getMarknum().split(",");
		String start=mark[0];
	    String end=mark[1];
		up.setUpFlag(Integer.parseInt(str[1]));
		String flag="no";
		if(serAjax.updateAllupsers(up)){
			flag=hoid+","+houseString+","+caid+","+caString+","+start+","+end+","+upid;
		}
		return flag;
	}
	//获取所有机房和房间
	public String getAllHouses(String mt){
		String hos="";
		List<ElectHouse> list=this.serAjax.findEle();
		for (ElectHouse et: list) {
			String mttString=et.getElectCode().substring(0,2);
			List<ElectHouse> list2 =this.serAjax.IPManage("from ElectHouse e where substring(e.electCode,3,2)<>'00' and  substring(e.electCode,1,2)='"+mttString+"'");
			for (ElectHouse electHouse : list2) {
				hos="<option value='"+electHouse.getElectId()+"'>"+et.getElectName()+"&"+electHouse.getElectName()+"</option>"+hos;
			}
			
		}
		return hos;
	}
	
	
	//获取所有机柜除现有
	public String getAllCabinets(String mg){
		int t = Integer.parseInt(mg);
		String hos="";
		List <Cabinet> cabs=this.serAjax.get(t);
		for (Cabinet cabinet : cabs) {
			hos="<option value='"+cabinet.getCaid()+"'>"+cabinet.getCaname()+"</option>"+hos;
		}
		return "<option value='0' selected>请选择</option>"+hos;
	}
	public String loadStorage(String ms){
		List<Depot> det = this.serAjax.getStorage();
		String strin=new String();
		for (Depot depot : det) {
			strin="<option value="+depot.getId()+">"+depot.getName()+"</option>"+strin;
		}
		return strin;
	}
	public String loadservers(String ms){
		//仓库ID
		System.out.println("ms="+ms);
		int detid = Integer.parseInt(ms);
		String serString=new String();
		List<Product> lt=this.serAjax.getstorageId(detid);
		for (Product product : lt) {
			serString="<option value='"+product.getId()+"'>"+product.getProperty().getName()+"-----"+product.getBarcode()+"</option>"+serString;
		
		}
		return serString;
	}
	//获取房间编码
	public String getRoomCode(String pp){
		String codes = "" ;
		TreeSet<String> tStri= new TreeSet<String>(new Comparator<String>() {
			public int compare(String o1, String o2) {
				return o2.compareTo(o1);
			}
		});
		List list=this.serAjax.getRoomCode("from ElectHouse order by electId desc");
		if(list.size()==0){
			codes="0100";
		}else{
			for (Iterator iterator =list.iterator();iterator.hasNext();) {
				ElectHouse obj = (ElectHouse)iterator.next();
				String co=obj.getElectCode().substring(0,2);
				tStri.add(co);
				logs.info("result="+co);
			}
	       for (Iterator iter =tStri.iterator();iter.hasNext();) {
				String sg=(String) iter.next();
				String psString=sg.substring(0,1);
				String psing=sg.substring(1,2);
				if((Integer.parseInt(psString))==0){
					if((Integer.parseInt(psing))==9){
						 int m = (Integer.parseInt(psing)+1);
						 codes =m+"00";
					}else{
					  int m = (Integer.parseInt(psing)+1);
					  codes ="0"+m+"00";
					}
				}else{
					int n = (Integer.parseInt(sg)+1);
					codes =n+"00";
				}
				break;
	       }
		}
		return codes;
	}
	//获取现有机房
	public String getCommentHouses(String mt){
		int cid = Integer.parseInt(mt);
		logs.info("city="+cid);
		String hos="";
		List<ElectHouse> list=this.serAjax.getRoomCode("from ElectHouse e where e.superid=0 and e.city.id="+cid);;
		for (ElectHouse et: list) {
			hos=et.getElectName()+","+et.getElectId()+","+hos;
		}
		return hos;
	}
	//获取所有信息
	public List getEleInfos(String pms){
		String info="";
		int m1;
		int m2;
		List lt = new ArrayList();
		List<ElectHouse> list=this.serAjax.getRoomCode("from ElectHouse where electId ="+Integer.parseInt(pms));
		logs.info("resultlist="+list.size());
		for (ElectHouse el : list) {
			lt.add(el.getElectName());
			lt.add(el.getElectPosition());
			lt.add(el.getElectTel());
			lt.add(el.getElectAdmin());
			lt.add(el.getElectAdmPhone());
			logs.info("code1="+el.getElectCode().substring(2,3));
			logs.info("code2="+el.getElectCode().substring(3,4));
			List<ElectHouse> lst=this.serAjax.getRoomCode("from ElectHouse where substring(electCode,1,2)='"+el.getElectCode().substring(0,2)+"'  order by electId desc" );
		    for (ElectHouse electHou : lst) {
			if(Integer.parseInt(electHou.getElectCode().substring(3,4))==9){
				m1=(Integer.parseInt(electHou.getElectCode().substring(2,3))+1);
				m2=(Integer.parseInt(electHou.getElectCode().substring(3,4))-9);
				String pmst=electHou.getElectCode().substring(0,1)+m1;
				String pms1=pmst+m2;
				lt.add(pms1);
			}else{
				m2=(Integer.parseInt(electHou.getElectCode().substring(3,4))+1);
				String pms2=electHou.getElectCode().substring(0,3);
				lt.add((pms2+m2));
			}
			break;
		    }
		}
		return lt;
	}
	//查询所在机房的房间号
	public String ReAtRoom(String hoid){
		String strin = "";
		int id = Integer.parseInt(hoid);
		ElectHouse elct = this.serAjax.getElehouseObj(id);
		logs.info("elct="+elct.getElectCode().substring(0,2));
		List<ElectHouse> list=this.serAjax.getRoomCode("from ElectHouse e where e.electCode like '"+elct.getElectCode().substring(0,2)+"%' and e.superid <> 0");
		for (ElectHouse et : list) {
			strin = "<option value="+et.getElectId()+">"+et.getElectName()+"</option>"+strin;
		}
		return strin;
	}
	//获取城市
	public String getCityNames(String m){
		String strin = "";
		int id = Integer.parseInt(m);
		List<City> list=this.serAjax.getRoomCode("from City c where c.id="+id);
		for (City city : list) {
			strin=city.getName();
		}
		return strin;
	}
	//自动分配空间
	public String autoAllotSpase(String ps){//treeset
		String strin = "";
		int sizes=0;
		String []arrs = ps.split(",");
		int caid = Integer.parseInt(arrs[0]);
		String serids = arrs[1];
		int a=0,b=0,p=0;
		int flag=0;
//		TreeSet <String>ts =  new TreeSet<String>(new Comparator<String>() {
//			public int compare(String o1, String o2) {
//				return o2.compareTo(o1);
//			}}); ;
//		List<SaleOrder> lists=this.serAjax.getRoomCode("from SaleOrder s where s.saleOrderNo='"+serids+"'");
		List<Sale_orders> lists=this.serAjax.getRoomCode("from Sale_orders s where s.soNums='"+serids+"'");
		for(Sale_orders sa : lists){
			sizes = Integer.parseInt(sa.getSpaceSize());
		}
//		for (SaleOrder sa : lists) {
//			sizes = Integer.parseInt(sa.getSpaceSize());
//		}
		List<UpServer> list=this.serAjax.getRoomCode("from UpServer u where u.Tupcabs.caid="+caid);
		if(list.size()!=0){
		for (UpServer upServer : list) {//upServer.getTupcabs().getCasz()
			for(int mp=0;mp<100;mp++){
			String []mark = upServer.getMarknum().split(",");
		    for(int i=0;i<100;i++){
			    a=getIntNum(upServer.getTupcabs().getCasz());
			    b=(a+sizes-1);
		    	if(b<upServer.getTupcabs().getCasz()){
		    		logs.info("a="+a);
		    		logs.info("b="+b);
		    		break;
		    	}else{
		    		continue;
		    	}
		    }
		    for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				UpServer ups = (UpServer) iterator.next();
				if(!"".equals(ups.getMarknum()) && ups.getMarknum()!=null){
				String []marknums = ups.getMarknum().split(",");
				int nu1=Integer.parseInt(marknums[0]);
				int nu2=Integer.parseInt(marknums[1]);
				if(a<=nu1 && b>=nu1 && b<=nu2){
					flag=0;
					break;
				}else if(a>=nu1 && nu1<=b && b<=nu2){
					flag=0;
					break;
				}else if(a<=nu1 && nu2<=b){
					flag=0;
					break;
		        }else if(a>=nu1 && a<=nu2 && nu2<=b){
		        	flag=0;
					break;
		        }else{
					flag=1;
				}
				}
				
				}
		       if(flag==1){
				   break;
		       } 
			}
			   if(flag==1){
				   break;
		       } 
			}
		  if(flag==0){
			  strin="未找到合适的柜号建议:更改机柜或房间"+","+"no";
		  }else{
				logs.info("a="+a);
				logs.info("b="+b);
				strin=a+","+b; 
		  }
		}else{
			List<Cabinet> list1=this.serAjax.getRoomCode("from Cabinet c where c.caid="+caid);
			for (Cabinet cabinet : list1) {  
					for(int j=0;j<100;j++){
						a=getIntNum(cabinet.getCasz());
						b=(a+sizes-1);
						if(b<cabinet.getCasz()){
							break;
						}else{
							continue;
						}
			}
			}
			strin=a+","+b; 
		}
	
		return strin;
	}
	//转移时判断
	public String getChangePosition(String m){
		int flag=1;
		String mt="";
		String arr[]=m.split(",");
		int start=Integer.parseInt(arr[0]);
		int end=Integer.parseInt(arr[1]);
		Integer caid=Integer.parseInt(arr[2]);
		List<UpServer>list=serAjax.findCabUper(caid);
		if(list.size()>0){
	    for (UpServer upServer : list) {
	      if(end <(upServer.getTupcabs().getCasz())){
			String nums[]=upServer.getMarknum().split(",");
			int st=Integer.parseInt(nums[0]);
			int en=Integer.parseInt(nums[1]);
			logs.info("marknum="+upServer.getMarknum());
			for(int i=st;i<=en;i++){
				for (int j = start; j <=end; j++) {
					if(i==j || (en+1)==j){
						flag=0;
						break;
					}else if(i<j && j<=(en+1)){
						flag=0;
						break;
					}else{
						
					}
				}
				if(flag==0){
				    break;
				}
			}
	      }else{
	    	  flag=0;
	    	  break;
	      }
		}
		}else{
			Cabinet cbt=(Cabinet) serAjax.getObjDate(caid);
			if(end<cbt.getCasz()){
				 flag=1;
			}else{
				 flag=0;
			}
		}
		if(flag==1){
			mt="yes";
		}else{
			mt="no";
		}
		return mt;
	}
	public int getIntNum(int mn){
		return (int) Math.round(Math.random()*mn);
	}
	public String getUpdSize(String sizes){
		logs.info("size="+sizes);
		String arr[]=sizes.split(",");
		String upsizeString="yes";
		int cid=Integer.parseInt(arr[0]);
		int size=Integer.parseInt(arr[1]);
		List<UpServer> list=this.serAjax.getRoomCode("from UpServer u where u.Tupcabs.caid="+cid);
		TreeSet<String> tSet= new TreeSet<String>(new Comparator<String>(){
            public int compare(String o1, String o2) {
						return o2.compareTo(o1);
			}
		});
		for (UpServer ups : list) {
			String ars[]=ups.getMarknum().split(",");
			tSet.add(ars[1]);
		}
		for (Iterator iterator = tSet.iterator(); iterator.hasNext();) {
			String string = (String) iterator.next();
			logs.info("tset="+string);
			if(size<Integer.parseInt(string)){
				upsizeString="no";
				break;
			}
		}
		return upsizeString;
	}
}
