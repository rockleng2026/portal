package com.fuao.fajxc.util;

import java.io.IOException;
import java.util.Properties;
public class PropertyEditor {

	public Object getID(String name) {
		Properties p = new Properties();
		try {
			p.load(getClass().getResourceAsStream("/proper.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return p.getProperty(name);
	}

	public static void main(String[] args) throws Exception {
		PropertyEditor a = new PropertyEditor();
		System.out.println(a.getID("selectemp"));
	}

	

}