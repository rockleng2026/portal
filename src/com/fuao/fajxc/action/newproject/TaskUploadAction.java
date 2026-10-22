package com.fuao.fajxc.action.newproject;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.NewsAddress;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.action.common.FJCommonAction;
import com.fuao.fajxc.bussiness.system.UploadBussiness;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.NewFunction;
import com.opensymphony.xwork2.ActionContext;

/**
 * 上传的图片Action
 * @author Administrator
 *
 */
public class TaskUploadAction implements ServletRequestAware,ServletResponseAware {
private static final long serialVersionUID = -4848248679889814408L;
private static Logger logger = Logger.getLogger(TaskUploadAction.class); 

private List<File> filedata;
private List<String> sczjmc;
private List<String> FiledataFileName;
private List<String> FiledataContentType;
private String name;
private HttpServletRequest request;
private HttpServletResponse response;
private UploadBussiness upbiz;

/**
 * 上传
 * @return
 * @throws IOException
 */
public String doUpload() throws IOException {
	request.getSession().setAttribute("filedata", filedata);
	
	String tname=URLDecoder.decode(request.getParameter("fileNames"), "utf-8");
	System.out.println(tname);
	request.getSession().setAttribute("fileNames", tname);
	ActionContext ac=ActionContext.getContext();
	ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
	System.out.println("Debugging MC --->     --->    --->   filedata = "+filedata);	
	String savePath = sc.getRealPath("/");
	savePath = savePath + "uploads/";
	Map zj = new HashMap();
	File f1 = new File(savePath);
	if (!f1.exists()) {
		f1.mkdirs();
	}
	int size = filedata.size();
	
	if (size == 0)
		return "error";
	
	String extName = null;
	String name = null;
	
	for (int i = 0; i < size; i++) {
		String filedataname2=new String(tname.getBytes("ISO-8859-1"), "UTF-8");
		System.out.println(filedataname2);
		request.getSession().setAttribute("filedataname2", filedataname2);
		extName = filedataname2.substring(
				filedataname2.lastIndexOf("."));
		name = UUID.randomUUID().toString();
		File file = new File(savePath + name + extName);
		System.out.println(filedata.get(i).getName()+filedata.get(i).getPath());
		try {
			FileUtils.copyFile(filedata.get(i), file);
		} catch (IOException e) {
			response.getWriter().print(3);
			e.printStackTrace();
			return null;
			
		}
		System.out.println("Debugging MC --->     --->    --->   /uploads/"+name + extName);
		 zj.put(sczjmc.get(i), "/uploads/"+name + extName);

	}
	logger.info("111"+name+extName);
	logger.info("222"+extName);
	request.getSession().setAttribute("sczj", zj);
	request.getSession().setAttribute("abcname", name+extName);
	request.getSession().setAttribute("extName",extName);
	String str="";
	for(int i=0;i<filedata.size();i++){
		File file=((List<File>) filedata).get(i);
		str+=file.toString();
	}
	request.setAttribute("filepaths", str);
	logger.info(str);
	response.getWriter().print(1);
	
	return null;
}

    
    /*
     * 下载附件
     */
    public String download()throws Exception{
    	String Url=request.getParameter("url");
    	boolean isOnLine = true;
    	String chinaName="uploads/"+Url;
    	ActionContext ac=ActionContext.getContext();
    	ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
		String savePath = sc.getRealPath("/");	
		String url=savePath+chinaName;
		System.out.println(url);
    File f = new File(url); 

    if(!f.exists()){

    request.setAttribute("message", "该文件不存在");

    return "uploaderror"; 

    }

    BufferedInputStream br = new BufferedInputStream(new FileInputStream(f)); 

    byte[] buf = new byte[1024]; 

    int len = 0; 

    response.reset(); //非常重要

    if(isOnLine){ //在线打开方式

    URL u = new URL("file:///"+url); 

    response.setContentType(u.openConnection().getContentType()); 

    response.setHeader("Content-Disposition", "inline; filename="+Url); 

    //文件名应该编码成UTF-8

    }

    else{ //纯下载方式

    response.setContentType("application/x-msdownload"); 

    response.setHeader("Content-Disposition", "attachment; filename=" +Url); 

    }

    OutputStream out = response.getOutputStream(); 

    while((len = br.read(buf))>0)

    out.write(buf,0,len); 

    br.close(); 

    out.close(); 
    return null;
    } 
    public String download1()throws Exception{
    	String Url=request.getParameter("url");
    	boolean isOnLine = true;
    	String chinaName=Url;
    	ActionContext ac=ActionContext.getContext();
    	ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
		String savePath = sc.getRealPath("/");	
		String url=savePath+chinaName;
		System.out.println(url);
    File f = new File(url); 

    if(!f.exists()){

    request.setAttribute("message", "该文件不存在");

    return "uploaderror"; 

    }

    BufferedInputStream br = new BufferedInputStream(new FileInputStream(f)); 

    byte[] buf = new byte[1024]; 

    int len = 0; 

    response.reset(); //非常重要

    if(isOnLine){ //在线打开方式

    URL u = new URL("file:///"+url); 

    response.setContentType(u.openConnection().getContentType()); 

    response.setHeader("Content-Disposition", "inline; filename="+Url); 

    //文件名应该编码成UTF-8

    }

    else{ //纯下载方式

    response.setContentType("application/x-msdownload"); 

    response.setHeader("Content-Disposition", "attachment; filename=" +Url); 

    }

    OutputStream out = response.getOutputStream(); 

    while((len = br.read(buf))>0)

    out.write(buf,0,len); 

    br.close(); 

    out.close(); 
    return null;
    } 


    
    
    
	public List<File> getFiledata() {
		return filedata;
	}

	public void setFiledata(List<File> filedata) {
		this.filedata = filedata;
	}

	public List<String> getFiledataFileName() {
		return FiledataFileName;
	}

	public void setFiledataFileName(List<String> filedataFileName) {
		FiledataFileName = filedataFileName;
	}

	public List getFiledataContentType() {
		return FiledataContentType;
	}

	public void setFiledataContentType(List<String> 
filedataContentType) {
		FiledataContentType = filedataContentType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public List<String> getSczjmc() {
		return sczjmc;
	}

	public void setSczjmc(List<String> sczjmc) {
		this.sczjmc = sczjmc;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
		
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
		
	}

	public UploadBussiness getUpbiz() {
		return upbiz;
	}

	public void setUpbiz(UploadBussiness upbiz) {
		this.upbiz = upbiz;
	}
	
}