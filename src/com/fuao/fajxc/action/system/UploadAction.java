package com.fuao.fajxc.action.system;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
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
import com.opensymphony.xwork2.ActionContext;

/**
 * 上传的图片Action
 * @author Administrator
 *
 */
public class UploadAction implements ServletRequestAware,ServletResponseAware {
private static final long serialVersionUID = -4848248679889814408L;
private static Logger logger = Logger.getLogger(UploadAction.class); 

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
		extName = FiledataFileName.get(i).substring(
		FiledataFileName.get(i).lastIndexOf("."));
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
	 request.getSession().setAttribute("sczj", zj);
	response.getWriter().print(1);
	System.out.println("Debugging MC --->     --->    --->   doUpload()方法执行到最后部分");
	return null;
}
public String doUpload2() throws IOException {
	request.getSession().setAttribute("filedata", filedata);
	ActionContext ac=ActionContext.getContext();
	ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
	System.out.println("Debugging MC --->     --->    --->   filedata = "+filedata);
	String savePath = sc.getRealPath("/");
	savePath = savePath + "uploads/";
	//Map zj = new HashMap();
	File f1 = new File(savePath);
	if (!f1.exists()) {
		f1.mkdirs();
	}
	int size = filedata.size();
	
	if (size == 0)
		return "error";
	
	String extName = null;
	String name = null;
	String img2=null;
	String txt=null;
	
	for (int i = 0; i < size; i++) {
		extName = FiledataFileName.get(i).substring(
		FiledataFileName.get(i).lastIndexOf("."));
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
		 //zj.put(sczjmc.get(i), "/uploads/"+name + extName);
		img2="/uploads/"+name + extName;
		 txt=name + extName;

	}
	request.getSession().setAttribute("sczj1", img2);
	request.getSession().setAttribute("uploadtxt", txt);
	
	response.getWriter().print(1);
	System.out.println("Debugging MC --->     --->    --->   doUpload()方法执行到最后部分");
	return null;
}

    //删除上传的证件
    public String delfile() throws IOException
    {
    	System.out.println("Debugging MC --->     --->    --->   进入删除附件方法");
    	ActionContext ac=ActionContext.getContext();
    	ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
    	String filePath = sc.getRealPath("/");
    	filePath = filePath.replace("\\","/");
    	filePath = filePath.substring(0,filePath.length()-1);
    	String id = request.getParameter("id");
    	String tableName = request.getParameter("bean");//附件表对应的实体bean
    	if(StringUtil.isnull(tableName)){
    		logger.error("delfile 表对应的实体bean为空");
    		response.getWriter().print(0);
    	}
    	if(StringUtil.isnull(id))
    	{
    		logger.error("delfile 附件id为空");
    		response.getWriter().print(0);
    	}
    	id = id.substring(0,id.length()-1);
    	String[] ids = id.split(",");
    	List path = new ArrayList();
    	String sczjid = "";
    	for(int i=0; i<ids.length;i++)
    	{
    		if(i%2==0)
    		{
    			sczjid += ids[i]+",";
    		}else
    			path.add(filePath+ids[i]);
    	}
    	System.out.println(path);
    	System.out.println(sczjid);

    	
    	sczjid = sczjid.substring(0,sczjid.length()-1);

    	boolean b = upbiz.del(tableName,sczjid, path);
    	if(b)
    	{
    		response.getWriter().print(1);
    		return null;
    	}else
    		response.getWriter().print(0);
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