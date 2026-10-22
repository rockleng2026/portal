package com.fuao.fajxc.util;
import javax.servlet.http.HttpServletRequest;

public class OtherMessageByView {

	/**
	 * 界面多个相同信息�?
	 * @param request 请求参数
	 * @param prefix 界面信息的前�?
	 * @return 同一组信�?
	 */
	public static String circleByViewValues(HttpServletRequest request, String prefix,int length) {
		StringBuffer buffer = new StringBuffer();
		for (int i = 1; i <= length; i++) {
			String cache = request.getParameter(prefix+i);
				if (cache!= null) {
					buffer.append(cache);
				}
			
			buffer.append(",");
		}
		return buffer.toString();
	}

}
