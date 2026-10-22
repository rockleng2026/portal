package com.fuao.fajxc.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;

import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Users;

public class ThreadGetSessions {
	     
	private static ThreadLocal<Users> local = new ThreadLocal<Users>();
	public static void setUser(Users user)
	{
		local.set(user);
	}
	
	public static Users getUser()
	{
		return local.get();
	}
		  
}