package com.fuao.fajxc.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class TimePattern1 {
	static DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	static DateFormat df2 = new SimpleDateFormat("yyyyMMddhhmmss");
	static DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 将时间转化为毫秒数
	 * @param date 日期
	 * @return 日期的毫秒数
	 */
	public static Long doDateTime4(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.getTimeInMillis();
	}
	/**
	 * 将日期的毫秒数转换为yyyy-MM-dd HH:mm:ss 字符串
	 * @param msecs 时间的毫秒数
	 * @return String yyyy-MM-dd HH:mm:ss
	 */
	public static String doStringTime4(Long msecs) {
		String d = df3.format(new Date(msecs));
		return d;
	}
	/**
	 * 
	 * @param date
	 * @return String yyyy-MM-dd
	 */
	public static String doDateTime(Date date) {
		String d = df.format(date);
		return d;
	}
	/**
	 * 
	 * @param date
	 * @return String yyyyMMddhhmmss
	 */
	public static String doDateTime2(Date date){
		String d = df2.format(date);
		return d;
	}

	/**
	 * 
	 * @param date
	 * @return String yyyy-MM-dd HH:mm:ss
	 */
	public static String doDateTime3(Date date) {
		
		String d = df3.format(date);
		return d;
	}
	/**
	 * 将java.util.Date格式 转换成java.sql.Timestamp 格式
	 * @param date 
	 * @return java.sql.Timestamp
	 */
	public static java.sql.Timestamp utiltosqldate(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strdate = sdf.format(date);
		java.sql.Date d = new java.sql.Date(date.getTime());
		Timestamp timestamp = java.sql.Timestamp.valueOf(strdate);
		return  timestamp;
	}
	/**
	 * 
	 * @param strdate 格式yyyy-MM-dd
	 * @return java.util.Date 
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
	/**
	 * 
	 * @param strdate 格式yyyyMMddhhmmss
	 * @return java.util.Date 
	 */
	public static Date doStringTime2(String date) {
		Date d = null;
		try {
			d = df2.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	/**
	 * 将日期字符串解析为时间
	 * @param strdate 格式yyyy-MM-dd HH:mm:ss
	 * @return java.util.Date 
	 */
	public static Date doStringTime3(String date) {
		Date d = null;
		try {
			d = df3.parse(date);
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
//		Date d = doStringTime("Wed Jul 25 00:00:00 CST 2007");
	
//		System.out.println(doTime(new Date()));
		System.out.println(doDateTime4(new Date()));
	}	
	}
