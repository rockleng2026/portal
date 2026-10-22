package com.fuao.fajxc.util;

import java.io.File;
/**
 * 文件大小转换  B  KB MB 保留2位小数
 * @author Administrator
 *
 */
public class ConvertFileSize {

	public static void main(String[] args) {
//		File f = new File("D:\\job\\portal\\CDN1\\access.log");
		File f = new File("H:\\[电影天堂www.dy2018.com]谍战深海01.rmvb");

		System.out.println(f.length());
//		System.out.println(convertFileByMB(f.length()));
		System.out.println(convertFileByMB(1024000.0));
		System.out.println(convertFileByMB(102400.0));
		System.out.println(convertFileByMB(10240.0));
		System.out.println(convertFileByMB(10240.0));
		System.out.println(convertFileByMB(1024.0));
		System.out.println(convertFileByMB(100.0));
		
	}
	/**
	 * 
	 * @param filesize 文件大小Byte
	 * @return >=1024 KB >=1024*1024 MB
	 */
   public 	static String convertFileSize(long filesize) {
		String strUnit = "Bytes";
		String strAfterComma = "";
		int intDivisor = 1;
		if (filesize >= 1024 * 1024) {
			strUnit = "MB";
			intDivisor = 1024 * 1024;
		} else if (filesize >= 1024) {
			strUnit = "KB";
			intDivisor = 1024;
		}
		
		if (intDivisor == 1)
			return filesize + " " + strUnit;
		//获取小数点后2位数
		
		strAfterComma = "" + 100 * (filesize % intDivisor) / intDivisor;
		if (strAfterComma == "")
			strAfterComma = ".0";
		return filesize / intDivisor + "." + strAfterComma + " " + strUnit;
	}
	
	/**
	 * 
	 * @param filesize 文件大小Byte
	 * @return 以MB为单位的数字字符串
	 */
	public static String convertFileByMB(Double filesize) {
//		String strUnit = "MB";
		double d = filesize/(1024*1024.0);
		double dd = Math.ceil(d*10000)/10000;
		return ""+dd;
	}
}
