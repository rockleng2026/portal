package com.fuao.fajxc.util;

import org.springframework.context.support.StaticApplicationContext;

import com.fuao.fajxc.vo.UpServer;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class ThreadupserveSave {
    //ªÒ»°session 
	private static ThreadLocal<UpServer>  up_ThreadLocal = new ThreadLocal<UpServer>();
	public static void setUpSers(UpServer up){
		up_ThreadLocal.set(up);
	}
	public static UpServer getUpSers(){
		return up_ThreadLocal.get();
	}
}
