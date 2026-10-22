package com.qq.sns.utils.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.nio.concurrent.FutureCallback;

/**
 * Handle the AsyncRequest
 * 
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */

public class AsyncCallBack implements FutureCallback<HttpResponse> {
	private static final String chartSet = "UTF-8";

	public void cancelled() {
		// TODO Auto-generated method stub
	}

	public void completed(final HttpResponse response) {
		// TODO Auto-generated method stub
		System.out.println("AsyncCallBack: " + response.getStatusLine());

		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					response.getEntity().getContent(), chartSet));
			StringBuffer buff = new StringBuffer("");
			String inputLine;
			while ((inputLine = reader.readLine()) != null) {
				if (!"".equals(buff.toString())) {
					buff.append("\r\n");
				}
				buff.append(inputLine);
			}
			System.out.println("--------------------------------");
			System.out.println(buff.toString());
			System.out.println("--------------------------------");
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
	}

	
	public void failed(Exception ex) {
		// TODO Auto-generated method stub
		ex.printStackTrace();
	}
}
