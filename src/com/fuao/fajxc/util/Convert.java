package com.fuao.fajxc.util;
import java.text.DecimalFormat;

/**
 * �ַ����ת��?
 * 
 * @version 1.0 2008-04-21
 * @author ok ������־�� *
 */
public class Convert {

	/**
	 * �ַ�ת��
	 * 
	 * @param String
	 *            s
	 * @return String
	 */
	public static String strConvet(String s) throws Exception {
		return new String(s.getBytes("ISO-8859-1"), "GBK");
	}

	/**
	 * ת���ɴ�ŵ���ʽ��ʾ��?23456=123,456
	 * 
	 * @param num
	 * @return
	 */
	public static String getNewNum(String num) {
		DecimalFormat bf = new DecimalFormat("###,###");
		return bf.format(Integer.valueOf(num));
	}

	/**
	 * ת���ɴ�ŵ���ʽ��ʾ��?23456=123,456
	 * 
	 * @param num
	 * @return
	 */
	public static String getNewNum(int num) {
		DecimalFormat bf = new DecimalFormat("###,###");
		return bf.format(num);
	}

	public static int getIntegerByString(String s) {
		try {
			return Integer.valueOf(s);
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	public static String stgConvet(String s) throws Exception {
		return new String(s.getBytes("GBK"), "UTF-8");
	}
}
