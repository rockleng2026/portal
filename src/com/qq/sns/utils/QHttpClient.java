package com.qq.sns.utils;

import java.util.List;

import com.qq.sns.beans.QParameter;

import org.apache.http.HttpResponse;
import org.apache.http.nio.concurrent.FutureCallback;

/**
 * Http请求接口
 * 
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */

public interface QHttpClient {

	public String httpGet(String url, String queryString,
			FutureCallback<HttpResponse> callBack) throws Exception;

	public String httpPost(String url, String queryString,
			FutureCallback<HttpResponse> callBack) throws Exception;

	public String httpPostWithFile(String url, String queryString,
			List<QParameter> files, FutureCallback<HttpResponse> callBack)
			throws Exception;
}
