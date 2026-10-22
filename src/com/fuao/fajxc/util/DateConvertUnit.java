package com.fuao.fajxc.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.beanutils.Converter;
public class DateConvertUnit implements Converter {

	public Object convert(Class type, Object value) {
		if (value == null)// 如果为空,返回
		{
			return value;
		}
		if (value instanceof Date)// 如果类型是java.uitl.Date类型,返回
		{
			return value;
		}
		if (value instanceof String)// 如果类型是String,�?��转换成java.util.Date,再返�?
		{ // 也就是把�?��字符串转换成�?��日期
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");// 格式化日期的�?
			try {
				return sdf.parse((String) value);// 将String转换为java.util.Date类型
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
