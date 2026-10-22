package com.platcenter.ipparse;
public class IPtest  {
	
	public void testIp(){
                //指定纯真数据库的文件名，所在文件夹
//		IPSeeker ip=new IPSeeker("QQWry.Dat","f:/qqwry");
//		 //测试IP 58.20.43.13
//		System.out.println(ip.getIPLocation("58.20.43.13").getCountry()+":"+ip.getIPLocation("58.20.43.13").getArea());
	}
	public static void main(String[] args) {
//		IPSeeker  ip2 = new IPSeeker(IPtest.class.getResource("/qqwry/QQWry.Dat").getPath());
	
		String dir = IPtest.class.getResource("/qqwry").getPath();
		dir = dir.replace("%20", " ");
		System.out.println(dir);
		IPSeeker  ip2 = new IPSeeker("QQWry.Dat","/D:/Program Files/Apache Software Foundation/Tomcat 6.0/webapps/yeepaytest/WEB-INF/classes/qqwry");
		System.out.println(ip2.getIPLocation("124.160.94.100").getCountry()+":"+ip2.getIPLocation("58.20.43.13").getArea());
	}

}
