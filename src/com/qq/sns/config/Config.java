package com.qq.sns.config;

/**
 * Created by IntelliJ IDEA.
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */
public class Config {
    public static final String appKey = "200140";
	public static final String appSecret = "93a77582cec81f6ce62570f54c5310a5";
    public static final String requestTokenUrl  = "http://openapi.qzone.qq.com/oauth/qzoneoauth_request_token";
    public static final String accessTokenUrl  = "http://openapi.qzone.qq.com/oauth/qzoneoauth_access_token";
    public static final String authUrl  = "http://openapi.qzone.qq.com/oauth/qzoneoauth_authorize";
	public static String callBackURL = "http://www.djdkx.com/connect/qqLoginOK";
    //public static String callBackURL = "http://localhost:8080/FAJxc/litscloud/ucenter/u_login.jsp";
   // public static String QQ_USER_SESSION_NAME = "QQ_USER_SESSION_NAME";
}
