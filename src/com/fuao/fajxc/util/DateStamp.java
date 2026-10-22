package com.fuao.fajxc.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateStamp {
	/**
	 * 获取今天日期
	 * @return
	 */
	public static String getYesterday() 
	{
		String today="";
		try
		{
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
			Date d=new Date();
			d.setTime(d.getTime()-24*60*60*1000);
			today=format.format(d);
		}catch(Exception e)
		{
			
		}
		return today;
	}
	/**
	 * 获取当前时间
	 * @return
	 */
	public static String getNow() 
	{
		String today="";
		try
		{
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date d=new Date();
			today=format.format(d);
		}catch(Exception e)
		{
			
		}
		return today;
	}
	
	public static String getNow1() 
	{
		String today="";
		try
		{
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
			Date d=new Date();
			today=format.format(d);
		}catch(Exception e)
		{
			
		}
		return today;
	}
	/**
	 * 获取当前时间的时间戳
	 */
    public static String getNowStamp() throws Exception
    {
    	String a=null;
    	Date d1=new Date();
    	Date d2 = getDate("20090401","yyyyMMdd");
    	a=String.valueOf((d1.getTime()-d2.getTime())/1000);
    	return a;
    }
    /**
     * 将指定的日期字符串转化为日期对象	 
     * @param dateStr	 *日期字符串	
     * @return java.util.Date	
     */	
	public static Date getDate(String dateStr, String format) throws Exception 
	{			
		SimpleDateFormat df = new SimpleDateFormat(format);		
		try {			
			Date date = df.parse(dateStr);		
			return date;		
			} catch (Exception ex) 
			{			
				return null;		
			}	
	}
	
	public static String timeFormat(Date datetime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(datetime != null) {
			return format.format(datetime);
		}
		return "";
	}
	/**
	  * 取得GMT时间
	  * @return
	  */
	 @SuppressWarnings("deprecation")
	public static String getGmtDate()
	 {
		    Date date = null;
			try {
				Date datetime=new Date();
				String datestring=timeFormat(datetime);
				date = getDate(datestring,"yyyy-MM-dd HH:mm:ss");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	       return date.toGMTString();
	 } 
	/**
	  * 取得GMT时间
	  * @return
	  */
	 public static String getGmtDate(String datestring)
	 {
		    Date date = null;
			try {
				date = getDate(datestring,"yyyy-MM-dd HH:mm:ss");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	       String date1 = date.toGMTString();
	        
	       return date1;
	 } 


}
