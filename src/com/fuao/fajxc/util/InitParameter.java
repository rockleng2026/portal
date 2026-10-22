package com.fuao.fajxc.util;

import java.util.ResourceBundle;

public class InitParameter {
	private static InitParameter instance = new InitParameter();
	private static ResourceBundle bundle = ResourceBundle.getBundle("init");

	private InitParameter() {

	}

	public static InitParameter getInstance() {
		return instance;
	}

	public String getProperty(String key) {
		return bundle.getString(key);
	}


}
