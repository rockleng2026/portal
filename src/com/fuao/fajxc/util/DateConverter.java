package com.fuao.fajxc.util;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Map;
import org.apache.struts2.util.StrutsTypeConverter;


/**
 * 时间类型转换器
 * @author 袁天龙 
 * 2012-10-31
 */
public class DateConverter extends StrutsTypeConverter{
	//String==>Date
	public Object convertFromString(Map arg0, String[] value, Class arg2) {
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try {
			return sdf.parse(value[0]);
		} catch (Exception e) {
		
//			e.printStackTrace();
		}
		return null;
	}
//DAte-->String
	public String convertToString(Map arg0, Object obj) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format((Date)obj);
	}
}
