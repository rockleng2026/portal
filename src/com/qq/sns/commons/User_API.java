package com.qq.sns.commons;

import java.util.ArrayList;
import java.util.List;

import com.qq.sns.beans.OAuth;
import com.qq.sns.beans.QParameter;

/**
 * 帐户相关API
 * 
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */

public class User_API extends RequestAPI {

	/**
	 * 获取自己的资料
	 * 
	 * @param oauth
	 * @param format
	 * @return
	 * @throws Exception
	 */
	public String info(OAuth oauth, String format) throws Exception {
		List<QParameter> parameters = new ArrayList<QParameter>();
		parameters.add(new QParameter("format", format));
        parameters.add(new QParameter("openid", oauth.getOpenID()));
		return getResource("http://openapi.qzone.qq.com/user/get_user_info", parameters,
				oauth);
	}
}
