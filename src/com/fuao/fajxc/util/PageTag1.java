package com.fuao.fajxc.util;

import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
public class PageTag1 extends TagSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private  String url;
	private String key;
	private Object value="";
	private String param;
	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	/**
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * @param key the key to set
	 */
	public void setKey(String key) {
		this.key = key;
	}

	

	/**
	 * @return the value
	 */
	public Object getValue() {
		return value;
	}

	/**
	 * @param value the value to set
	 */
	public void setValue(final Object value) {
		System.out.println("testValue:"+value);
		if(value!=null)
		{
			try {
				this.value = ExpressionEvaluatorManager.evaluate(
				        "value", value.toString(), Object.class, this, pageContext);
			} catch (JspException e) {
			
				e.printStackTrace();
			}  
		}
		else
			this.value=value;

	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int doStartTag() throws JspException{	
		String html="";
		Pages page =null;
		try{
		if(pageContext.getRequest().getAttribute("pages")!= null){
			 Object obj = pageContext.getRequest().getAttribute("pages");
			if(obj !=null){
				page = (Pages)obj;
				page.setUrl(this.getUrl());
				if(key!=null&&key!=""&&value!=null&&value!="")
				{
					HashMap<String,String> map=new HashMap<String, String>();
					//String keys[]=key.split(",");
					System.out.println("key:"+key);
					System.out.println("value"+value);
					//String values[]=value.split(",");
//					for(int i=0;i<keys.length;i++)
//					{
//						System.out.println("key:"+key+"values:"+value);
//						map.put(keys[i], values[i]);
//					}
					map.put(key, value.toString());
					page.setSearchTerms(map);
				}
				if(param !=null && !"".equals(param)){
					System.out.println("param::::"+param);
					page.setUrl(this.getUrl()+"?"+param);
				}
				if(param !=null && !"".equals(param) && param.contains("openmethod=1")){
					html = page.getHtml();
				}else{
					html = page.getHtml2();
				}
				
			}
		}
		JspWriter out = pageContext.getOut();
		out.print(html);
		}catch (Exception e){
			throw new JspException(e);
		}
		return EVAL_PAGE;
	}
}
