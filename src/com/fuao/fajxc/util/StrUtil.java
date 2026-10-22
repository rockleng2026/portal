package com.fuao.fajxc.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StrUtil {
	public static int getSubNumber(String des, String reg) {
	     Pattern p = Pattern.compile(reg);
	     Matcher m = p.matcher(des);
	     int count = 0;//¼ÇÂ¼¸öÊı
	     while(m.find()){
	           count++;
	     }
	     return count;
	}
	public static String getStr(String str) {
		
		int a = str.lastIndexOf("/");
		String str1 = str.substring(0,a); 
		int b = str1.lastIndexOf("/");
		String strs =str.substring(b,str.length()); 
		return strs;
	}

}
