package com.fuao.fajxc.util;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.List;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.springframework.aop.AfterReturningAdvice;

import com.fuao.fajxc.serser.service.LoggerServices;
import com.fuao.fajxc.serser.service.SerajaxService;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.LogTab;
import com.fuao.fajxc.vo.UpServer;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class OperratoLoggers implements AfterReturningAdvice{

	private LoggerServices lotb;
	public void afterReturning(Object arg0, Method arg1, Object[] arg2,
			Object arg3) throws Throwable {
		 System.out.println("记录日志了..."+arg0);
//		 if(arg1.getName().equals("upsaveStats")){
//			  lotb.saveDate(this.returnLogTabs("进行了服务器上架操作"));
//			
//		 }
//		 if(arg1.getName().equals("saveDownSers")){
//			 lotb.saveDate(this.returnLogTabs("进行了服务器下架操作"));
//		 }
		 if(arg1.getName().equals("saveDate")){
			 lotb.saveDate(this.returnLogTabs("进行了录入上架单的操作"));
		 }
		 if(arg1.getName().equals("updateDate")){
			 lotb.saveDate(this.returnLogTabs("进行了转移服务器的操作"));
		 }
	     
	}
    public LogTab returnLogTabs(String opers){
       try{
	    	 LogTab lTab = new LogTab();
	    	 lTab.setLoid(0);
			 lTab.setLoadmin(ThreadGetSessions.getUser().getUserName());
			 lTab.setLooper(opers);
			 lTab.setLoTime(new Date());
		     lTab.setTupve(ThreadupserveSave.getUpSers());
		     return lTab;
		 }catch(NullPointerException e) {
			return null;
		 }catch (Exception e) {
			return null;
		 }
    	 
    }
	public LoggerServices getLotb() {
		return lotb;
	}
	public void setLotb(LoggerServices lotb) {
		this.lotb = lotb;
	}
    
    
}
