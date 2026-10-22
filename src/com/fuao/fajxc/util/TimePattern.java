package com.fuao.fajxc.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class TimePattern {
	static DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	static DateFormat df2 = new SimpleDateFormat("yyyyMMddhhmmss");
	static DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 
	 * @param date
	 * @return yyyy-MM-dd
	 */
	public static String doDateTime(Date date) {
		String d = df.format(date);
		return d;
	}
	/**
	 * 
	 * @param date
	 * @return yyyyMMddhhmmss
	 */
	public static String doTimeDf2(Date date){
		String d = df2.format(date);
		return d;
	}
	/**
	 * 
	 * @param date
	 * @return yyyy-MM-dd hh:mm:ss
	 */
	public static String doTimeDf3(Date date){
		String d = df3.format(date);
		return d;
	}
	/**
	 * 
	 * @param date
	 * @param dateformat 指定格式
	 * @return dateformat格式的日期字符串
	 */
	public static String doTimeDf(Date date,String dateformat){
		DateFormat df = new SimpleDateFormat(dateformat);
		String d = df.format(date);
		return d;
	}
	/**
	 * 
	 * @param date 日期格式的字符串
	 * @return  Date
	 */
	public static Date doStringTime(String date) {
		Date d = null;
		try {
			d = df.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	public static String getYearOfTime(Date d){
		return df2.format(d).substring(0,4);
	}
	public static String getMonthOfTime(Date d)
	{
		return df2.format(d).substring(4, 6);
		
	}
	public static String getDayOfTime(Date d)
	{
		
		return df2.format(d).substring(6,8); 
	}
	public static String getHoursOfTime(Date d)
	{	
		return df2.format(d).substring(8, 10);
	}
	public static String getMinutesOfTime(Date d)
	{	
		return df2.format(d).substring(10, 12);
	}
	public static String getSecondstOfTime(Date d)
	{	
		return df2.format(d).substring(12, 14);
	}
	
	
	public static String getSFirstDateOfThisWeek(Date d){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.DAY_OF_MONTH, d.getDate());
		c.set(Calendar.YEAR, Integer.parseInt(TimePattern.getYearOfTime(d)));
		c.set(Calendar.MONTH, d.getMonth());
//		获得这个日期所在星期的第一天
		c.add(Calendar.DATE, -(Calendar.getInstance().get(Calendar.DAY_OF_WEEK)-2));
		
		String year = getYearOfTime(c.getTime());
		String month = getMonthOfTime(c.getTime());
		java.text.DecimalFormat format=new java.text.DecimalFormat("00");
		String sFirstDateOfThisWeek = year + month +format.format(c.getTime().getDate());
		return sFirstDateOfThisWeek;
	}
	public static Date getDFirstDayOfThisWeek(Date d){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.DAY_OF_MONTH, d.getDate());
		c.set(Calendar.YEAR, Integer.parseInt(TimePattern.getYearOfTime(d)));
		c.set(Calendar.MONTH, d.getMonth());
//		获得这个日期所在星期的第一天
		c.add(Calendar.DATE, -(Calendar.getInstance().get(Calendar.DAY_OF_WEEK)-2));
		return c.getTime();
	}
	public static String getSLastDateOfThisWeek(Date d){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.DAY_OF_MONTH, d.getDate());
		c.set(Calendar.YEAR, Integer.parseInt(TimePattern.getYearOfTime(d)));
		c.set(Calendar.MONTH, d.getMonth());
//		获得这个日期所在星期的星期一
		c.add(Calendar.DATE, -(Calendar.getInstance().get(Calendar.DAY_OF_WEEK)-1-1)+6);
		
		String year = getYearOfTime(c.getTime());
		String month = getMonthOfTime(c.getTime());
		java.text.DecimalFormat format=new java.text.DecimalFormat("00");
		String sLastDateOfThisWeek = year + month +format.format(c.getTime().getDate());
		return sLastDateOfThisWeek;
	}
	public static Date getDLastDayOfThisWeek(Date d){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.DAY_OF_MONTH, d.getDate());
		c.set(Calendar.YEAR, Integer.parseInt(TimePattern.getYearOfTime(d)));
		c.set(Calendar.MONTH, d.getMonth());
//		获得这个日期所在星期的星期天
		c.add(Calendar.DATE, -(Calendar.getInstance().get(Calendar.DAY_OF_WEEK)-1-1)+6);
		
		return c.getTime();
	}
	public static String  getSLastDateOfThisMonth(Date d){
		Calendar c = Calendar.getInstance();
		
		c.set(Calendar.YEAR, Integer.parseInt(TimePattern.getYearOfTime(d)));
		c.set(Calendar.MONTH, d.getMonth());
		c.set(Calendar.DAY_OF_MONTH, d.getDate());
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(c.DATE));
		
		d = c.getTime();
		String year = getYearOfTime(d);
		String month = getMonthOfTime(d);
		String sLastDayOfThisMonth = getDayOfTime(d);
		String sLastDateOfThisMonth = year + month +sLastDayOfThisMonth;
		return sLastDateOfThisMonth;
	}
	public static Date  getDLastDayOfThisMonth(Date d){
		Calendar c = Calendar.getInstance();
		
		c.set(Calendar.YEAR, Integer.parseInt(TimePattern.getYearOfTime(d)));
		c.set(Calendar.MONTH, d.getMonth());
		c.set(Calendar.DAY_OF_MONTH, d.getDate());
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(c.DATE));
		
		return  c.getTime();
	}
	public static void main(String[] args) {
		DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
		System.out.println(df3.format(new Date()));
		
	}

}
