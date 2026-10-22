package com.fuao.fajxc.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author keane
 * 
 * 
 */

public class Cookies {

	public int maxAge;

	public String path;

	public Cookies() {
		maxAge = 60 * 60 * 24 * 7;			//设置cookie有效期是一个星期，根据需要自定义
		path = "/";
	}

	

	/**
	 * Put cookie to the client
	 * 
	 * @param response
	 * @param name
	 * @param value
	 */
	public void putCookie(HttpServletResponse response, String name,
			String value) {
		System.out.println("maxAge::::"+this.maxAge);
		try {
			Cookie cookie = new Cookie(name, encode(value));
			cookie.setMaxAge(this.maxAge);
			cookie.setPath("/");
			response.addCookie(cookie);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * get cookie from client
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public String getCookie(HttpServletRequest request, String name) {
		Cookie[] cookie_get = {};
		if (cookie_get == null || cookie_get.length == 0) {
			cookie_get = request.getCookies();
		}
		String returnStr;
		returnStr = "";
		try {
			for (int i = 0; cookie_get != null && i < cookie_get.length; i++) {
				cookie_get[i].setPath(path);
				if (cookie_get[i].getName().equals(name)) {
					cookie_get[i].setMaxAge(-1);
					returnStr = cookie_get[i].getValue().toString();
					break;
				}
			}
			return decode(returnStr);
		} catch (Exception e) {
			return decode(returnStr);
		}
	}

	/**
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @param name
	 *            String
	 */
	public void removeCookie(HttpServletResponse response, String name) {
		this.maxAge = 0;
		putCookie(response, name, null);
	}

	/**
	 * 
	 * @param value
	 *            String
	 * @return String
	 */
	private static String decode(String value) {
		String result = "";
		if (!isEmpty(value)) {
			try {
				result = java.net.URLDecoder.decode(value, "utf-8");
			} catch (UnsupportedEncodingException ex) {

			}
		}
		return result;
	}

	/**
	 * * @param value String
	 * 
	 * @return String
	 */
	private static String encode(String value) {
		String result = "";
		if (!isEmpty(value)) {
			try {
				result = java.net.URLEncoder.encode(value, "utf-8");
			} catch (UnsupportedEncodingException ex) {

			}
		}
		return result;
	}

	/**
	 * 
	 * @param value
	 *            String
	 * @return boolean
	 */
	private static boolean isEmpty(String value) {
		if (value == null || value.trim().equals(""))
			return true;
		else
			return false;
	}

}