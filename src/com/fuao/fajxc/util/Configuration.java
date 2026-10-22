package com.fuao.fajxc.util;


import java.io.InputStream;
import java.io.FileInputStream;
import java.util.Properties;

public  class Configuration {
	/**
	 * ¶ÁÈ¡ÊìÏ¤ÎÄ¼þ
	 * @param name
	 * @return String
	 */
	public static String getConfiguration(String filename,String key){
	    String name="";
		try{
			FileInputStream inputStream =new  FileInputStream(filename);    
			Properties pro=new Properties();
			pro.load(inputStream);
			name = pro.getProperty(key);
		}catch(Exception ex){
			
		}
		return name;
	}
}
