package com.fuao.fajxc.util;


import java.util.HashMap;
import java.util.Map;

public class RequestParametersHolder {

	private HashMap<String,String> protocalMustParams;
	private HashMap<String,String> protocalOptParams;
	private HashMap<String,String> applicationParams;

	public HashMap<String,String> getProtocalMustParams() {
		return protocalMustParams;
	}

	public void setProtocalMustParams(HashMap<String,String> protocalMustParams) {
		this.protocalMustParams = protocalMustParams;
	}

	public HashMap<String,String> getProtocalOptParams() {
		return protocalOptParams;
	}

	public void setProtocalOptParams(HashMap<String,String> protocalOptParams) {
		this.protocalOptParams = protocalOptParams;
	}

	public HashMap<String,String> getApplicationParams() {
		return applicationParams;
	}

	public void setApplicationParams(HashMap<String,String> applicationParams) {
		this.applicationParams = applicationParams;
	}

	public Map<String, String> getAllParams() {
		Map<String, String> params = new HashMap<String, String>();
		if (protocalMustParams != null && !protocalMustParams.isEmpty()) {
			params.putAll(protocalMustParams);
		}
		if (protocalOptParams != null && !protocalOptParams.isEmpty()) {
			params.putAll(protocalOptParams);
		}
		if (applicationParams != null && !applicationParams.isEmpty()) {
			params.putAll(applicationParams);
		}
		return params;
	}

}
