package com.qq.sns.utils.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.List;

import com.qq.sns.beans.QParameter;
import com.qq.sns.utils.QHttpClient;
import com.qq.sns.utils.QStr;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.nio.concurrent.FutureCallback;
import org.apache.http.params.HttpConnectionParams;
import org.apache.james.mime4j.util.CharsetUtil;

/**
 * 
 * @author vottot:<a href="http://www.djdkx.com">笑话</a> 
 * @Data 2011-04-22
 * @Version 1.0
 */

public class SyncHttpClient implements QHttpClient {
	private static final String chartSet = "UTF-8";
	private static final int CONNECTION_TIMEOUT = 20000;
	private static boolean debug = false;

	/**
	 * Using GET method.
	 * 
	 * @param url
	 *            The remote URL.
	 * @param queryString
	 *            The query string containing parameters
	 * @return Response string.
	 * @throws Exception
	 */
	public String httpGet(String url, String queryString,
			FutureCallback<HttpResponse> callBack) throws Exception {
		StringBuffer responseData = new StringBuffer("");

		if (queryString != null && !queryString.equals("")
				&& !queryString.startsWith("?")) {
			url += "?" + queryString;
		}

		HttpClient httpClient = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(url);
		HttpConnectionParams.setConnectionTimeout(httpClient.getParams(),
				CONNECTION_TIMEOUT);

		// Execute HTTP request
		print("executing request " + httpGet.getURI());
		HttpResponse response = httpClient.execute(httpGet);

		print("----------------------------------------");
		print(response.getStatusLine());
		print("----------------------------------------");

		// Get hold of the response entity
		HttpEntity entity = response.getEntity();

		// If the response does not enclose an entity, there is no need
		// to bother about connection release
		if (entity != null) {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					entity.getContent(), chartSet));
			try {
				// do something useful with the response
				String inputLine;
				while ((inputLine = reader.readLine()) != null) {
					if (!"".equals(responseData.toString())) {
						responseData.append("\r\n");
					}
					responseData.append(inputLine);
				}
			} catch (Exception ex) {
				httpGet.abort();
				throw ex;
			} finally {
				// Closing the input stream will trigger connection release
				reader.close();
			}
		}
		print("----------------------------------------");
		print(responseData.toString());
		print("----------------------------------------");

		// When HttpClient instance is no longer needed,
		// shut down the connection manager to ensure
		// immediate deallocation of all system resources
		httpClient.getConnectionManager().shutdown();

		return responseData.toString();
	}

	/**
	 * Using POST method.
	 * 
	 * @param url
	 *            The remote URL.
	 * @param queryString
	 *            The query string containing parameters
	 * @return Response string.
	 * @throws Exception
	 */
	public String httpPost(String url, String queryString,
			FutureCallback<HttpResponse> callBack) throws Exception {
		StringBuffer responseData = new StringBuffer("");

		if (queryString.startsWith("?")) {
			queryString = queryString.substring(1);
		}

		HttpClient httpClient = new DefaultHttpClient();
		HttpPost httpPost = new HttpPost(url);

		StringEntity strEntity = new StringEntity(queryString);
		strEntity.setContentType("application/x-www-form-urlencoded");
		httpPost.setEntity(strEntity);

		// Execute HTTP request
		print("executing request " + httpPost.getURI());
		HttpResponse response = httpClient.execute(httpPost);

		print("----------------------------------------");
		print(response.getStatusLine());
		print("----------------------------------------");

		// Get hold of the response entity
		HttpEntity entity = response.getEntity();

		// If the response does not enclose an entity, there is no need
		// to bother about connection release
		if (entity != null) {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					entity.getContent(), chartSet));
			try {
				// do something useful with the response
				String inputLine;
				while ((inputLine = reader.readLine()) != null) {
					if (!"".equals(responseData.toString())) {
						responseData.append("\r\n");
					}
					responseData.append(inputLine);
				}
			} catch (Exception ex) {
				httpPost.abort();
				throw ex;
			} finally {
				// Closing the input stream will trigger connection release
				reader.close();
			}
		}
		print("----------------------------------------");
		print(responseData.toString());
		print("----------------------------------------");

		// When HttpClient instance is no longer needed,
		// shut down the connection manager to ensure
		// immediate deallocation of all system resources
		httpClient.getConnectionManager().shutdown();

		return responseData.toString();
	}

	/**
	 * Using POST method with multiParts.
	 * 
	 * @param url
	 *            The remote URL.
	 * @param queryString
	 *            The query string containing parameters
	 * @param files
	 *            The list of image files
	 * @return Response string.
	 * @throws Exception
	 */
	public String httpPostWithFile(String url, String queryString,
			List<QParameter> files, FutureCallback<HttpResponse> callBack)
			throws Exception {

		if (files == null || files.size() == 0) {
			System.out.println("httpPostWithFile.files is empty");
			return this.httpPost(url, queryString, callBack);
		}
		if (queryString.startsWith("?")) {
			queryString = queryString.substring(1);
		}

		StringBuffer responseData = new StringBuffer("");

		HttpClient httpClient = new DefaultHttpClient();
		HttpPost httpPost = new HttpPost(url);

		MultipartEntity reqEntity = new MultipartEntity();
		if (queryString != null && !queryString.equals("")) {// add parameters
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

		// Execute HTTP request
		print("executing request " + httpPost.getURI());
		HttpResponse response = httpClient.execute(httpPost);

		print("----------------------------------------");
		print(response.getStatusLine());
		print("----------------------------------------");

		// Get hold of the response entity
		HttpEntity entity = response.getEntity();

		// If the response does not enclose an entity, there is no need
		// to bother about connection release
		if (entity != null) {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					entity.getContent(), chartSet));
			try {
				// do something useful with the response
				String inputLine;
				while ((inputLine = reader.readLine()) != null) {
					if (!"".equals(responseData.toString())) {
						responseData.append("\r\n");
					}
					responseData.append(inputLine);
				}
			} catch (Exception ex) {
				httpPost.abort();
				throw ex;
			} finally {
				// Closing the input stream will trigger connection release
				reader.close();
			}
		}
		print("----------------------------------------");
		print(responseData.toString());
		print("----------------------------------------");

		return responseData.toString();
	}

	private void print(Object obj) {
		if (debug) {
			System.out.println(obj);
		}
	}

}
