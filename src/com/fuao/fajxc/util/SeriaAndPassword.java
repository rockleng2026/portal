package com.fuao.fajxc.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class SeriaAndPassword {

	public static String getPassword(){
		return createRandomNum(6);
		
	}
	public static String getSreialno(){
		Random ram = new Random(10);
		SimpleDateFormat dateFm = new SimpleDateFormat("yyyyMMdd");
		String dateTime = dateFm.format(new Date());
		String rams =dateTime;
		rams = rams + createRandomNum(7);
		return rams;
	}
	private static String createRandomNum(int length) {
		Random rd = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append(""+rd.nextInt(10));
		}
		return sb.toString();
	}
	
	
}
