package com.qq.sns.examples;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;

import com.qq.sns.beans.Account;
import com.qq.sns.beans.OAuth;
import com.qq.sns.config.Config;
import com.qq.sns.utils.OAuthClient;

public class Test {
	private static OAuth oauth = new OAuth(Config.appKey, Config.appSecret,
			Config.callBackURL); // 初始化OAuth请求令牌
	private static OAuthClient authClient = new OAuthClient();// OAuth 认证对象
	private static String verify = null;


	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		String u="https://dnsapi.cn/User.Detail?login_email='yanyinhua@fuaotech.com'&login_password='utemyan'&format='json'&lang='cn'&error_on_empty='yes'";
		String uu="";
		
		//URI url=new URI("");
		URL url=new URL(u);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setDoInput(true); //设置可以进行输入操作
		connection.setDoOutput(true); //设置可以进行输出操作
		connection.setRequestMethod("POST"); //设置请求方式
		connection.setAllowUserInteraction(true); //设置可以进行交互操作
		connection.connect();

		 InputStream inputStream = connection.getInputStream();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,"GBK")); //为了进行一行读取操作
		    String strMessage ="";
		    StringBuffer  buffer = new StringBuffer();
			while ((strMessage  = reader.readLine()) != null) {
		       
				buffer.append(strMessage);
				//System.out.println(buffer+"获得的数据");
		    }
			System.out.println(buffer+"获得的数据");
		
	}
    /**
     * 登陆请求
     */
	public static void snsRequest() {
		Scanner in = new Scanner(System.in);
		try {
			oauth = authClient.requestToken(oauth);
			if (oauth.getStatus() == 1) {
				System.out.println("Request Token 授权失败！");
				return;
			} else {
				String url = Config.authUrl + "?oauth_token="
						+ oauth.getOauth_token() + "&oauth_consumer_key="
						+ Config.appKey + "&oauth_callback="
						+ Config.callBackURL;
				
				if (!java.awt.Desktop.isDesktopSupported()) {

					System.err.println("Desktop is not supported (fatal)");
					System.exit(1);
				}
				java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
				if (desktop == null
						|| !desktop.isSupported(java.awt.Desktop.Action.BROWSE)) {

					System.err
							.println("Desktop doesn't support the browse action (fatal)");
					System.exit(1);
				}

				desktop.browse(new URI(url));
			
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
	/**
	 * 登录成功后获取授权
	 */
	public static  String  snsLoginOk() {
		try {
			//注意，授权成功后需要获取到授权验证码oauth_vericode，
			//verify=request.getParameter("oauth_vericode");
            oauth.setOauth_vericode(verify);
            oauth = authClient.accessToken(oauth);
            Account ac= authClient.getAccount(oauth);
            System.out.println("*************************************************");
            System.out.println(oauth.getStatus());
            if (oauth.getStatus() == 2) {
            	System.out.println("Access Token 授权失败！......................");
                return oauth.getStatus()+"";
            }else{
            	System.out.println("用户名："+ac.getName()+",昵称："+ac.getNick());
            	return ac.getName();
            }
        } catch (Exception e) {
        	e.printStackTrace();
            return "";
        }
	}

}
