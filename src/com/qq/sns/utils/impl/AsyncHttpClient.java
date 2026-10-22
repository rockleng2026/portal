package com.qq.sns.utils.impl;

import java.io.File;
import java.util.List;
import java.util.concurrent.CountDownLatch;

import com.qq.sns.beans.QParameter;
import com.qq.sns.utils.QHttpClient;
import com.qq.sns.utils.QStr;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.nio.client.DefaultHttpAsyncClient;
import org.apache.http.nio.client.HttpAsyncClient;
import org.apache.http.nio.concurrent.FutureCallback;
import org.apache.james.mime4j.util.CharsetUtil;

/**
 * 
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */

public class AsyncHttpClient implements QHttpClient {
	private static final String chartSet = "UTF-8";

	
	public String httpGet(String url, String queryString,
			final FutureCallback<HttpResponse> callBack) throws Exception {
		if (queryString != null && !queryString.equals("")
				&& !queryString.startsWith("?")) {
			url += "?" + queryString;
		}

		HttpAsyncClient httpClient = new DefaultHttpAsyncClient();
		httpClient.start();

		try {
			final HttpGet httpGet = new HttpGet(url);
			final CountDownLatch latch = new CountDownLatch(1);
			httpClient.execute(httpGet, new FutureCallback<HttpResponse>() {

				public void completed(final HttpResponse response) {
					latch.countDown();
					callBack.completed(response);
				}

				public void failed(final Exception ex) {
					latch.countDown();
					callBack.failed(ex);
				}

				public void cancelled() {
					latch.countDown();
					callBack.cancelled();
				}

			});
			latch.await();
		} finally {
			httpClient.shutdown();
		}
		return null;
	}

	public String httpPost(String url, String queryString,
			final FutureCallback<HttpResponse> callBack) throws Exception {
		HttpAsyncClient httpClient = new DefaultHttpAsyncClient();
		httpClient.start();

		try {
			final HttpPost httpPost = new HttpPost(url);
			StringEntity strEntity = new StringEntity(queryString);
			strEntity.setContentType("application/x-www-form-urlencoded");
			httpPost.setEntity(strEntity);

			final CountDownLatch latch = new CountDownLatch(1);
			httpClient.execute(httpPost, new FutureCallback<HttpResponse>() {

				public void completed(final HttpResponse response) {
					latch.countDown();
					callBack.completed(response);
				}

				public void failed(final Exception ex) {
					latch.countDown();
					callBack.failed(ex);
				}

				public void cancelled() {
					latch.countDown();
					callBack.cancelled();
				}

			});
			latch.await();
		} finally {
			httpClient.shutdown();
		}
		return null;
	}

	public String httpPostWithFile(String url, String queryString,
			List<QParameter> files, final FutureCallback<HttpResponse> callBack)
			throws Exception {
		HttpAsyncClient httpClient = new DefaultHttpAsyncClient();
		httpClient.start();

		try {
			final HttpPost httpPost = new HttpPost(url);
			MultipartEntity reqEntity = new MultipartEntity();
			if (queryString != null && !queryString.equals("")) {
				String[] p = queryString.split("&");
				for (String s : p) {
					if (s != null && !s.equals("")) {
						if (s.indexOf("=") > -1) {
							String[] param = s.split("=");
							String value = (param.length == 2 ? QStr
									.decode(param[1]) : "");
							reqEntity.addPart(param[0], new StringBody(value,CharsetUtil.getCharset(chartSet)));
						}
					}
				}
			}
			for (int i = 0; i < files.size(); i++) {// add file
				File file = new File(files.get(i).getValue());
				reqEntity.addPart(files.get(i).getName(), new FileBody(file));
			}
			httpPost.setEntity(reqEntity);

			final CountDownLatch latch = new CountDownLatch(1);
			httpClient.execute(httpPost, new FutureCallback<HttpResponse>() {

				public void completed(final HttpResponse response) {
					latch.countDown();
					callBack.completed(response);
				}

				public void failed(final Exception ex) {
					latch.countDown();
					callBack.failed(ex);
				}

				public void cancelled() {
					latch.countDown();
					callBack.cancelled();
				}

			});
			latch.await();
		} finally {
			httpClient.shutdown();
		}
		return null;
	}

}
