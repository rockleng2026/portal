package com.fuao.fajxc.util;


import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class URLUtil {
	
	public static String returnURLParam(String urlStr) throws Exception{
		URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoInput(true); //设置可以进行输入操作
        connection.setDoOutput(true); //设置可以进行输出操作
        connection.setRequestMethod("POST"); //设置请求方式
        connection.setAllowUserInteraction(true); //设置可以进行交互操作
        connection.connect();
//        OutputStream outputStream = connection.getOutputStream();
//        OutputStreamWriter writer = new OutputStreamWriter(outputStream);
        
//        writer.write(str);
//        writer.flush(); //立即输出
//        writer.close();
        InputStream inputStream = connection.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream)); //为了进行一行读取操作
        String strMessage ="";
        StringBuffer  buffer = new StringBuffer();
		while ((strMessage  = reader.readLine()) != null) {
           
			buffer.append(strMessage);
        }
//		System.out.println(buffer+"获得的数据");
		return buffer.toString();
	}
	
	public static String returnURLParam(String urlStr,String charset) throws Exception{
		URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoInput(true); //设置可以进行输入操作
        connection.setDoOutput(true); //设置可以进行输出操作
        connection.setRequestMethod("POST"); //设置请求方式
        connection.setAllowUserInteraction(true); //设置可以进行交互操作
        connection.connect();
//        OutputStream outputStream = connection.getOutputStream();
//        OutputStreamWriter writer = new OutputStreamWriter(outputStream);
        
//        writer.write(str);
//        writer.flush(); //立即输出
//        writer.close();
        InputStream inputStream = connection.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,charset)); //为了进行一行读取操作
        String strMessage ="";
        StringBuffer  buffer = new StringBuffer();
		while ((strMessage  = reader.readLine()) != null) {
           
			buffer.append(strMessage);
        }
		System.out.println(buffer+"获得的数据");
		return buffer.toString();
	}
	public static String returnURLParamWithGet(String urlStr) throws Exception{
		System.out.println("link to the url"+urlStr);
		URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoInput(true); //设置可以进行输入操作
        connection.setDoOutput(true); //设置可以进行输出操作
        connection.setRequestMethod("GET"); //设置请求方式
        connection.setAllowUserInteraction(true); //设置可以进行交互操作
        connection.connect();
//        OutputStream outputStream = connection.getOutputStream();
//        OutputStreamWriter writer = new OutputStreamWriter(outputStream);
        
//        writer.write(str);
//        writer.flush(); //立即输出
//        writer.close();
        InputStream inputStream = connection.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream)); //为了进行一行读取操作
        String strMessage ="";
        StringBuffer  buffer = new StringBuffer();
		while ((strMessage  = reader.readLine()) != null) {
           
			buffer.append(strMessage);
        }
//		System.out.println(buffer+"获得的数据");
		return buffer.toString();
	}
	
	public static String returnURLParamWithGet(String urlStr,String charset) throws Exception{
		System.out.println("link to the url"+urlStr);
		URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoInput(true); //设置可以进行输入操作
        connection.setDoOutput(true); //设置可以进行输出操作
        connection.setRequestMethod("GET"); //设置请求方式
        connection.setAllowUserInteraction(true); //设置可以进行交互操作
        connection.connect();
//        OutputStream outputStream = connection.getOutputStream();
//        OutputStreamWriter writer = new OutputStreamWriter(outputStream);
        
//        writer.write(str);
//        writer.flush(); //立即输出
//        writer.close();
        InputStream inputStream = connection.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,charset)); //为了进行一行读取操作
        String strMessage ="";
        StringBuffer  buffer = new StringBuffer();
		while ((strMessage  = reader.readLine()) != null) {
           
			buffer.append(strMessage);
        }
//		System.out.println(buffer+"获得的数据");
		return buffer.toString();
	}
}