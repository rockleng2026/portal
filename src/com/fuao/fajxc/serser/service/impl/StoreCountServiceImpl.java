package com.fuao.fajxc.serser.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.serser.dao.StoreCountDao;
import com.fuao.fajxc.serser.service.StoreCountService;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;

public class StoreCountServiceImpl implements StoreCountService{

	private StoreCountDao storeDaos;
	private Logger logger = Logger.getLogger(StoreCountServiceImpl.class);
	public StoreCountDao getStoreDaos() {
		return storeDaos;
	}

	public void setStoreDaos(StoreCountDao storeDaos) {
		this.storeDaos = storeDaos;
	}

	public List selAllDateList() {	
		return this.storeDaos.selAllDateList();
	}

	public List getStoreList(String sql,int current,int pagesize) {
		return this.storeDaos.getStoreList(sql,current,pagesize);
	}
	
	public List getStoreList2(String sql){
		return this.storeDaos.getStoreList2(sql);
	}

	public int getStoreSize(String sql) {
		return this.storeDaos.getStoreSize(sql);
	}

	public String getSingleSelect(String st) {
		String selectString="";
	    if(st.equals("st1")){
	    	//按编码
	    	List<Property> list=this.storeDaos.getSingleSelect("from Property");
	    	for (Property property : list) {
	    		selectString +="<option value='"+property.getPcord()+"'>"+property.getPcord()+"</option>"; 
			}
	    }
	    if(st.equals("st2")){//p.property.model.commodityTpye.typeName
	    	//按类型
	    	List<CommodityTpye> list1=this.storeDaos.getSingleSelect("from CommodityTpye");
	    	for (CommodityTpye commodityTpye : list1) {
	    		selectString +="<option value='"+commodityTpye.getTypeName()+"'>"+commodityTpye.getTypeName()+"</option>"; 
			}
	    }
	    if(st.equals("st3")){//p.property.name 
	    	//按名称
	    	List<Property> list2=this.storeDaos.getSingleSelect("from Property");
	    	for (Property property : list2) {
	    		selectString +="<option value='"+property.getName()+"'>"+property.getName()+"</option>"; 
			}
	    }
	    if(st.equals("stn")){
	    	List<Depot> list2=this.storeDaos.getSingleSelect("from Depot");
	    	for (Depot property : list2) {
	    		selectString +="<option value='"+property.getName()+"'>"+property.getName()+"</option>"; 
			}
	    }
	    logger.info("selectString="+selectString);
		return selectString;
	}

	public List differentCondition(String sect1, String sect2, String sect3, String sect4,String sels,int current,int pagesize) {
       List lt = new ArrayList();//p.property.name,,,p.property.model.commodityTpye.typeName,,,p.depot.name,,,
  	   if(!sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		   lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where  p.property.name='"+sect3+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		   lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"' and p.property.pcord='"+sect1+"'",current,pagesize);////
  	   }else if(sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"'  and  p.depot.name='"+sels,current,pagesize);
  	   }else if(sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.depot.name='"+sels,current,pagesize);///
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where  p.property.name='"+sect3+"'  and  p.depot.name='"+sels+"'",current,pagesize);
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3,current,pagesize);///
  	   }else if(!sect1.equals("0") && sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.name='"+sect3+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0") && sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.property.pcord='"+sect1+"'",current,pagesize);////
  	   }else if(!sect1.equals("0") && sect2.equals("0") && sect3.equals("0") && sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(sect1.equals("0") && !sect2.equals("0") && sect3.equals("0") && sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'",current,pagesize);
  	   }else if(sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.name='"+sect3+"'",current,pagesize);
  	   }else if(sect1.equals("0") && sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.name='"+sels+"'",current,pagesize);///
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.name='"+sect3+"'  and p.property.pcord='"+sect1+"'",current,pagesize);
  	   }else if(!sect1.equals("0") && sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'",current,pagesize);///
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.property.name='"+sect3+"'",current,pagesize);
  	   }else if(sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.depot.name='"+sels+"'",current,pagesize);////
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0") && sect4.equals("undefined") && !sels.equals("0")){
  		 lt=this.storeDaos.getStoreList("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"'  and  p.depot.name='"+sels,current,pagesize);//
  	   }else{///全部没有
  		 lt=this.storeDaos.getStoreList(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p ",current,pagesize);
  	   } 
		return lt;
	}

	public int diffrentCount(String sect1,String sect2,String sect3,String sect4,String sels) {//2,商品类型，3,商品名称，sels，库房
	   int counts=0;//counts=this.storeDaos.getStoreSize(
	   if(!sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		  counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where  p.property.name='"+sect3+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		  counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"' and p.property.pcord='"+sect1+"'");////
  	   }else if(sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"'  and  p.depot.name='"+sels);
  	   }else if(sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.depot.name='"+sels);///
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where  p.property.name='"+sect3+"'  and  p.depot.name='"+sels+"'");
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3);///
  	   }else if(!sect1.equals("0") && sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.name='"+sect3+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0") && sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.property.pcord='"+sect1+"'");////
  	   }else if(!sect1.equals("0") && sect2.equals("0") && sect3.equals("0") && sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.pcord='"+sect1+"'");
  	   }else if(sect1.equals("0") && !sect2.equals("0") && sect3.equals("0") && sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'");
  	   }else if(sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.name='"+sect3+"'");
  	   }else if(sect1.equals("0") && sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.name='"+sels+"'");///
  	   }else if(!sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.name='"+sect3+"'  and p.property.pcord='"+sect1+"'");
  	   }else if(!sect1.equals("0") && sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.depot.name='"+sels+"'  and p.property.pcord='"+sect1+"'");///
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0")&& sect4.equals("undefined") && sels.equals("0")){
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.property.name='"+sect3+"'");
  	   }else if(sect1.equals("0") && !sect2.equals("0") && sect3.equals("0")&& sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and p.depot.name='"+sels+"'");////
  	   }else if(sect1.equals("0") && !sect2.equals("0") && !sect3.equals("0") && sect4.equals("undefined") && !sels.equals("0")){
  		counts=this.storeDaos.getStoreSize("select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p where p.property.model.commodityTpye.typeName='"+sect2+"'  and  p.property.name='"+sect3+"'  and  p.depot.name='"+sels);//
  	   }else{///全部没有
  		counts=this.storeDaos.getStoreSize(" select DISTINCT(concat(p.property.name,p.property.model.commodityTpye.typeName,p.depot.name)),p.property.name,p.property.model.commodityTpye.typeName,p.depot.name,p.property.pcord,p.property.unit,p.property.pprice from Product p ");
  	   } 
	   return counts;
	}
	
	public List executeSql(String sql){
		return this.storeDaos.executeSql(sql);
	}
}
