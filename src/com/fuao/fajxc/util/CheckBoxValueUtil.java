package com.fuao.fajxc.util;

import java.util.ArrayList;
import java.util.List;

public class CheckBoxValueUtil {

	/**
	 * 得到checkbox的一组数据转成一个字符串
	 * 
	 * @param values
	 * @param division
	 * @return
	 */
	public static String getCheckBoxValues(String[] values, String division) {
		StringBuffer buffer = new StringBuffer();
		if (values!=null) {
			int index = 0;
			for (String string : values) {
				buffer.append(string );
				if (values.length-1!=index) {
					buffer.append( division);
				}
				index++;
			}
		}
		return buffer.toString();
	}

	public static List<String> getListByStringWithDivision(String value,
			String division) {
		List<String> list = new ArrayList<String>();
		int begin = 0;// �?��的位�?
		int index = 0;// 分隔符所在的位置
		while (value.length() > 0) {
			// 找到分隔符所在的位置
			index = value.indexOf(division);
			// 截取从分隔符后到下一个分隔符前的字符�?
			String content = value.substring(begin, index).trim();
			if (!("".equals(content) || content == null)) {
				list.add(content);
			}
			// 记录分隔符后的位�?
			begin = index + 1;
			value = value.substring(begin);
		}
		return list;
	}
}
