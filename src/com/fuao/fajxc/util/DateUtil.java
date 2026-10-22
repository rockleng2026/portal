package com.fuao.fajxc.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.text.DecimalFormat;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;

public class DateUtil 
{
	public void DateUtil()
    {
		
    }

    /**
     * ??��????��????????�??????��????��??
     * @param str
     * @return
     */
	public static String getDateNow(String format)
    {
        Calendar ca = Calendar.getInstance();
        java.util.Date dt = ca.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(dt);
    }
	
	/**
     * 以�??�???��????????n天�????��????��??
     * @param str
     * @return
     */
	public static String getLastDate(String format, int n)
    {
        Calendar ca = Calendar.getInstance();
        ca.add(Calendar.DAY_OF_MONTH, n); 
        java.util.Date dt = ca.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(dt);
    }
	
	/**
	 * ??��????��?????�????
	 */
	public static String getNumber(String pattern, double number)
	{
		DecimalFormat df = new DecimalFormat(pattern);
		return df.format(number);
	}
	
	/**
     * ??��?????n??��????��???????��??
     * @param str �?????????��????��??
     * @param n ???n???�?n=1,2,3,4,5......
     * @return  
     */
	public static String getFirstDayOfWeek(String strFormat, int n)
	 {
		Date   date   =   new   Date();   
        GregorianCalendar   date1   =   new   GregorianCalendar();
        date1.setFirstDayOfWeek(Calendar.MONDAY); 
        date1.setTime(date); 
        
        int   dayOfWeek = date1.get(Calendar.DAY_OF_WEEK); 
        
        n = n * 7;
        date1.add(Calendar.DATE,2-dayOfWeek-n); 
        
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(strFormat);        
         
	    return format.format(date1.getTime());
	 }
	
	/**
     * ??��?????n??????�?�?天�????��??
     * @param str �?????????��????��??
     * @param n ???n???�?n=1,2,3,4,5......
     * @return  
     */
	public static String getFirstDayOfMonth(String strFormat, int n)
	 {
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-01"); 
		 
		Calendar aCalendar = Calendar.getInstance();
		aCalendar.add(Calendar.MONTH, -n);
		Date firstDay = aCalendar.getTime();      
         
	    return format.format(firstDay);
	 }
	
	/**
	 * 在日期上添加�?��
	 * @param date
	 * @return
	 */
	public static Date getEndDate(String strdate){
		Calendar c = Calendar.getInstance();
        c.setTime(getDate(strdate));   //设置当前日期
        c.add(Calendar.DATE, 1); //日期�?
        return c.getTime();
	}
	
	/**
	 * 将字符格式日期转换成yyyy-MM-dd格式date
	 * 
	 * @param strdate
	 * @return
	 */
	public static Date getDate(String strdate){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");     
		Date dt=null;
		try{
			dt = format.parse(strdate);
		}catch(Exception ex){
			
		}
		return dt;
	}
}
