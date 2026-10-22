package com.fuao.fajxc.util;

import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.UpServer;

public class ThreadDownserverSave {
    //ªÒ»°session 
	private static ThreadLocal<DownServer>  up_ThreadLocal = new ThreadLocal<DownServer>();
	public static void setDowns(DownServer up){
		up_ThreadLocal.set(up);
	}
	public static DownServer getDowns(){
		return up_ThreadLocal.get();
	}
}
