package com.platcenter.ipparse;

import org.apache.log4j.lf5.Log4JLogRecord;

public class test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
//		LoginRecord lr = new LoginRecord();
//		lr.setIp(realip);

		// lr.setIp(request.getHeader("X-Real-IP"));
		String dir = IPSeeker.class.getResource("/").getPath()
		+ "qqwry";
		dir = dir.replace("%20", " ");
		IPSeeker ip = new IPSeeker("QQWry.Dat", dir);
//		lr.setFrom(request.getServerName());
//		lr.setTime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
//		.format(new Date()));
//		lr.setInfo("登陆及相关操作");
//		lr.setUid(c.getUid());
		System.out.println((ip.getIPLocation("91.36.3.3").getCountry()));
		// lr.setCity(ip.getIPLocation(request.getHeader("X-Real-IP")).getCountry());
		
	}

}
