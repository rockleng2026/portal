package com.fuao.fajxc.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class DNSPod {
	
	public String selectUserDNSPod(String userName,String password) throws Exception
	{
		//查询用户资料
		String[] xx =new String[5];
		String[] pram = {userName,password,"xml","cn","yes",""};
		String u="https://dnsapi.cn/Domain.List";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"&type=all";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			
		return buffer.toString();
	}
	
	public String selectDengJiDNSPod(String domainId,String domainGrade) throws Exception
	{
		//查询代理企业域名等级
		String[] xx =new String[5];
		String[] pram = {"yanyinhua@fuaotech.com","utemyan","xml","cn","yes",""};
		String u="https://dnsapi.cn/Record.Line";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"&domain_grade=D_Ultra&domain_id=248907";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			System.out.println(buffer.toString());
		return buffer.toString();
	}
	public String selectSubDomainDNSPod(String domainId,String subdomain) throws Exception
	{
		//查询子域名信息
		String[] xx =new String[5];
		String[] pram = {"yanyinhua@fuaotech.com","utemyan","xml","cn","yes",""};
		String u="https://dnsapi.cn/Record.List";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"&domain_id="+domainId+"&offset=0&length=20&sub_domain="+subdomain+"";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			
		return buffer.toString();
	}
	public String addDNSPod(String domainId,String subDomain,String recordType,String recordLine,String value,String ttl) throws Exception
	{
		//增加
		String[] xx =new String[5];
		String[] pram = {"yanyinhua@fuaotech.com","utemyan","xml","cn","yes",""};
		String u="https://dnsapi.cn/Record.Create";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"" +
        		"&domain_id="+domainId+"&sub_domain="+subDomain+"&record_type=A&record_line="+recordLine+"&value="+value+"&ttl=600";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			
		return buffer.toString();
	}
	
	public String updateDNSPod(String domainId,String  recordId,String subDomain,String recordType,String recordLine,String value,String ttl) throws Exception
	{
		//修改
		String[] xx =new String[5];
		String[] pram = {"yanyinhua@fuaotech.com","utemyan","xml","cn","yes",""};
		String u="https://dnsapi.cn/Record.Modify";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"" +
        		"&domain_id="+domainId+"&record_id="+recordId+"&sub_domain="+subDomain+"&record_type=A&record_line="+recordLine+"&value="+value+"&ttl=600";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			
		return buffer.toString();
	}
	public String delDNSPod(String domainId,String  recordId) throws Exception
	{
		//删除
		String[] xx =new String[5];
		String[] pram = {"yanyinhua@fuaotech.com","utemyan","xml","cn","yes",""};
		String u="https://dnsapi.cn/Record.Remove";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"" +
        		"&domain_id="+domainId+"&record_id="+recordId+"";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			
		return buffer.toString();
	}
	public String updateDNSPod(String domainId,String  recordId,String status) throws Exception
	{
		//enable使用中
		//disable未使用
		//删除
		String[] xx =new String[5];
		String[] pram = {"yanyinhua@fuaotech.com","utemyan","xml","cn","yes",""};
		String u="https://dnsapi.cn/Record.Status";
		//String u="https://dnsapi.cn/User.Info";
		System.out.println(u);
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		//HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.addRequestProperty("Content-type","application/x-www-form-urlencoded");
		connection.connect();
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); 
        String content = "login_email="+pram[0]+"&login_password="+pram[1]+"&format="+pram[2]+"&lang="+pram[3]+"&error_on_empty="+pram[4]+"" +
        		"&domain_id="+domainId+"&record_id="+recordId+"&status="+status+"";
        System.out.println(content);
        out.write(content);  
        out.flush();
        out.close(); // flush and close
        
		InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"UTF-8")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			
		return buffer.toString();
	}



}
