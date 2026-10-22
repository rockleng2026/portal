package com.fuao.fajxc.action.cms_template;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.fuao.fajxc.action.WebToHtml;
import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.dao.cms_template.TemplateDao;
import com.fuao.fajxc.util.FileUtil;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;
import com.fuao.fajxc.vo.Fa_Cms_Template;


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.xml.internal.stream.buffer.stax.StreamWriterBufferProcessor;

public class TemplateAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private static Logger logger = Logger.getLogger(TemplateAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private TemplateDao tempdao;
	private Fa_Cms_Template template;
	private File uploadImage;// 得到上传的文件 特别注意的是在这里的文件名必须跟前台的input 标签中的name 一致   
	private String forwordname;//配置文件跳转路径
	
	public String getForwordname() {
		return forwordname;
	}
	public void setForwordname(String forwordname) {
		this.forwordname = forwordname;
	}
	public File getUploadImage() {
		return uploadImage;
	}
	public void setUploadImage(File uploadImage) {
		this.uploadImage = uploadImage;
	}
	public Object getModel() {
		return null;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public TemplateDao getTempdao() {
		return tempdao;
	}
	public void setTempdao(TemplateDao tempdao) {
		this.tempdao = tempdao;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	public Fa_Cms_Template getTemplate() {
		return template;
	}
	public void setTemplate(Fa_Cms_Template template) {
		this.template = template;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	// 获得所有模板数据
	public String getAllList(){
		List<Fa_Cms_Template> templist=tempdao.getAllTemplate();
		System.out.println("模板数量:"+templist.size());
		request.setAttribute("templist", templist);
		
		return "all";
	}
	
	// 进入修改页面
	public String update(){
		
		Fa_Cms_Admin admin  = (Fa_Cms_Admin)request.getSession().getAttribute("adminid");
		if(admin == null){
			return "relogin";
		}
		
		
		
		Integer tid=Integer.parseInt(request.getParameter("tid"));
		System.out.println(tid);
		
		// 绑定classes 类型对象
		List<Fa_Cms_Classes> typelist=tempdao.getClasses();
		// 绑定模板类型名称
		List<Fa_Cms_Template> templist=tempdao.getAllTemplate();
		List<String> typename=new ArrayList<String>();
		for(int i=0;i<templist.size();i++){
			Fa_Cms_Template temp = templist.get(i);
			String name=temp.getName();
			typename.add(name);
		}
		
		// 根据ID 得到对象
		this.template=(Fa_Cms_Template)tempdao.getTempById(Fa_Cms_Template.class, tid);
		request.setAttribute("typelist", typelist);
		request.setAttribute("typename", typename);
		if(admin.getUsername().equals("admin")){
			request.setAttribute("editable", "true");
		}
		System.out.println(typename.size());
		System.out.println(this.template.getFname());
		System.out.println(this.template.getClasses().getClassname());
		return "update";
	}
	
	/***
	 * 进入添加页面
	 * @return
	 */
	public String add(){
		// 绑定classes 类型对象
		Fa_Cms_Admin admin  = (Fa_Cms_Admin)request.getSession().getAttribute("adminid");
		if(admin == null){
			return "relogin";
		}
		
		List<Fa_Cms_Classes> typelist=tempdao.getClasses();
		request.setAttribute("typelist", typelist);
		if(admin.getUsername().equals("admin")){
			request.setAttribute("editable", "true");
		}
		this.template = null;
		return "add";
	}
	
	//添加模板
	public String addTemp(){
		System.out.println(this.getTemplate().getFdir());
		
		Date now = new Date();
	    this.getTemplate().setEditdate(now);
	    tempdao.addTemp(this.template);
	    
	    try {
			response.setCharacterEncoding("GBK");
			response.getWriter().write("<center>保存成功!</center><script>location.back(-1);</script>");	
			response.setHeader("refresh", "1;URL="+request.getContextPath()+"/cms/getAllListTemplate.do");//
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	// 保存修改
	public String updateTemp(){
		
		Date now = new Date();
	    this.getTemplate().setEditdate(now);
	    if(this.template.getId()==null){
	    	this.getTemplate().setDelflag(0);
	    	tempdao.addTemp(this.template);
	    }else{
		   tempdao.updateTemp(this.template);
	    }
		
		try {
			response.setCharacterEncoding("GBK");
			response.getWriter().write("<center>保存成功!</center><script>location.back(-1);</script>");	
			response.setHeader("refresh", "1;URL="+request.getContextPath()+"/cms/getAllListTemplate.do");//
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return null;
	}
	
	// 删除
	public String delTemp(){
		int tid=Integer.parseInt( request.getParameter("id"));
		System.out.println(tid);
		tempdao.delTemp(tid);
		response.setHeader("refresh", "0;URL="+request.getContextPath()+"/cms/getAllListTemplate.do");//
		return null;
	}
	
	// 添加文件
	public String addFile(){		
		int tid = Integer.parseInt(request.getParameter("id"));
		System.out.println(tid);
		// 判断写入的是什么模板页
		this.template=(Fa_Cms_Template)tempdao.getTempById(Fa_Cms_Template.class, tid);
		// 写入的文件内容
		String contents=this.template.getContents();
		String projectPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");
		projectPath=projectPath.replaceAll("/WEB-INF/classes", "");
		System.out.println(projectPath);
		String temppath=projectPath+this.template.getFdir()+this.template.getFname();
	    // 首先判定文件夹是否存在，不存在则新建
		File file=new File(projectPath+this.template.getFdir());
		 if(!file.exists()){
			 file.mkdirs();
		 }
		 
		
		//将contents里的内容写到文件中
		try {
			FileWriter fileWriter = new FileWriter(temppath);
			fileWriter.write(contents);
		    fileWriter.flush();
		    fileWriter.close();
		    response.setCharacterEncoding("utf-8");
		    response.setContentType("text/html");
		    response.getWriter().print("写入成功！");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 生成静态页
	public String currentHTML(){
		
		//接收
		int tid = Integer.parseInt(request.getParameter("id"));
		
		//定义
		int flag = 0; //返回前端结果
		String result = "";//请求返回的数据
		String tempJspPath="";// 读取jsp页面
		String tempHtmlPath=""; // 写入html页面
		String forwardpath = "";//配置文件中匹配的路径 <forward name="huaqiang" path="/template_file/huaqiang/index.jsp"></forward>
		String charset = "GBK";//初始化编码
		
		int mid = 0;//
		this.template=(Fa_Cms_Template)tempdao.getTempById(Fa_Cms_Template.class, tid);
		mid = this.template.getMid();
		System.out.println(tid);
		
		String fdir = template.getFdir(); //模板路径
		String fname = template.getFname();//模板文件
		String contents = template.getContents();//模板内容
		String urlStr = template.getDo_action();//模板访问路径
		
		Fa_Cms_Classes tp  = this.template.getClasses();
		
		String htmldir = request.getRealPath("/");//获得绝对路径
		logger.info("绝对路径"+htmldir);
		charset = (String)request.getSession().getServletContext().getAttribute("charset");
//		String projectPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");
//		projectPath=projectPath.replaceAll("/WEB-INF/classes", "");
//		System.out.println(projectPath);
		
//		 判断写入的是什么模板页
		if(mid==1){// 首页
			
			String homepage = (String)request.getSession().getServletContext().getAttribute("homepage");
			//"index.html";//静态文件名
			//工程路径 后台定义
			//工程路径+静态路径(/cms/classse.engname_web)+静态页面名称
			tempJspPath=htmldir+this.template.getFdir()+"/"+this.template.getFname();
			tempHtmlPath = htmldir+"cms_web"+File.separator+tp.getEngname();
			
			//http请求获得返回结果内容
			try {
				forwardpath = "/"+template.getFdir()+template.getFname();
				String rqurl = urlStr+"?mid="+mid+"&forwardname="+tp.getEngname()+"&forwardpath="+forwardpath+"&typeid="+tp.getClassid();
				logger.info("请求地址:"+rqurl);
				result = StringUtil.returnURLParam(rqurl,charset);
				tempHtmlPath = htmldir+"cms"+File.separator+tp.getEngname();
				FileUtil.newFile(tempHtmlPath,homepage,result,charset);
				flag = 0;
			} catch (Exception e) {
				flag  = 1;
				e.printStackTrace();
			}
			
		}else if(mid==2){// 栏目页
//			tempJspPath=projectPath+this.getTemplate().getFdir()+this.getTemplate().getFname();
//			tempHtmlPath=projectPath+this.getTemplate().getFdir()+"program.html";
		}else if(mid==3){// 内容页
//			tempJspPath=projectPath+this.getTemplate().getFdir()+this.getTemplate().getFname();
//			tempHtmlPath=projectPath+this.getTemplate().getFdir()+"contents.html";
		}else if(mid==4){// 最新页
//			tempJspPath=projectPath+this.getTemplate().getFdir()+this.getTemplate().getFname();
//			tempHtmlPath=projectPath+this.getTemplate().getFdir()+"news.html";
		}else if(mid==4){// 其他页
//			tempJspPath=projectPath+this.getTemplate().getFdir()+this.getTemplate().getFname();
//			tempHtmlPath=projectPath+this.getTemplate().getFdir()+"other.html";
		}	
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			PrintWriter pw = response.getWriter();
			
			if(flag  == 0){
				pw.print(0);
			}else{
				pw.print(1);
			}
		} catch (IOException e) {
			logger.error(e);
			e.printStackTrace();
		}	
		
		return null;		
	}
	
	public String indextohtml(){
		
		String typeid = request.getParameter("typeid");
		forwordname = request.getParameter("forwordname");
		
//		tempdao
		
		//System.out.println("indexTplxxxxx");
	    //获得类别
//		List rsList = getGameCategoryList();
//		templateDAO  tdao = new templateDAOImpl();
//		TypeDAO tpdao = new TypeDAOimpl();
//		ContentsDAO  cdao = new ContentsDAOimpl();
		
		//获得所有游戏攻略类别的所有子类
		//String typeid = getTypeid("walkthrough");
		
//		String typeidStr = gettypeidStr(tpdao,cdao,typeid);//游戏攻略
//		this.GONGLUE_ID = typeid;//gonglue
//		String typeid2 = getTypeid("game");
//		String typeid2Str = gettypeidStr(tpdao,cdao,typeid2);//游戏
//		this.GAME_ID = typeid2;
		
//		typeidStr = stringUtil.replace(typeidStr,"(", "");
//		typeidStr = stringUtil.replace(typeidStr,")", "");
//		//分类别得到各类型的最新文章

		
		
		
//		WebToHtml wth = new WebToHtml();
////		List<Fa_Cms_Rec_Part> partList = pdao.getDataByTypeidAndMid(stringUtil.strToInt(typeid, 0),0);//默认0是首页部分推荐
//		for (Fa_Cms_Rec_Part recPart : partList) {
//		if (recPart.getPart_name().equals("今日头条")) {
//			List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");	
//			
//		   request.setAttribute(recPart.getEng_name(), templist2);			
//		} else if (recPart.getPart_name().equals("今日关注")) {
//			//for (int i = 0; i < str.length; i++) {
//			 List 	templist = tpdao.getChildList(Integer.valueOf(this.GONGLUE_ID));
//			 for (Iterator it = templist.iterator(); it.hasNext();) {
//				type tp = (type) it.next();
//				List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 and r.temp='"+tp.getEngname()+"'");
//				//以栏目英文名字为属相放入request中
//				
//				request.setAttribute(tp.getEngname(),templist2);
//				
//			}
//		//	}
//		}else if (recPart.getPart_name().equals("今日关注-最新攻略")) {
//			List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0");
//			//以栏目英文名字为属相放入request中
//			request.setAttribute(recPart.getEng_name(), templist2);
//			
//				
//		}else if (recPart.getPart_name().equals("节目回顾")) {
//		
//		} else if (recPart.getPart_name().equals("金牌推荐-最新推荐")) {
//			
//			//获得图片热门推荐
//			List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");
//			//以栏目英文名字为属相放入request中
//			request.setAttribute(recPart.getEng_name(), templist2);
//			
//		}
//		else if (recPart.getPart_name().equals("金牌推荐-热门推荐")) {
//			//获得图片热门推荐
//			List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0");
//			//以栏目英文名字为属相放入request中
//			//System.out.println(recPart.getEng_name()+"--------"+templist2.size());
//			request.setAttribute(recPart.getEng_name(), templist2);
//			
//		}else if(recPart.getPart_name().equals("游戏-推荐")){
//			//获得所有游戏攻略类别的所有子类
//			String[] str2 = typeidStr.split(",");
//				 List 	templist = tpdao.getChildList(Integer.valueOf(this.GAME_ID));
//				 for (Iterator it = templist.iterator(); it.hasNext();) {
//					type tp = (type) it.next();
//					List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 and r.temp='"+tp.getEngname()+"'");
//					//以栏目英文名字为属相放入request中
//					
//					request.setAttribute(tp.getEngname(),templist2);
//				}
//			}//游戏站首页推荐结束
//			//华强首页推荐开始
//			else if(recPart.getPart_name().equals("首页-主打推荐")){
//				List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");	
//				request.setAttribute(recPart.getEng_name(), templist2);	
//				templist2 = null;
//			}
//			else if(recPart.getPart_name().equals("首页-热销产品")){
//				List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");	
//				request.setAttribute(recPart.getEng_name(), templist2);	
//				templist2 = null;
//			}
//			else if(recPart.getPart_name().equals("首页-企业介绍")){
//				List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");	
//				request.setAttribute(recPart.getEng_name(), templist2);	
//				templist2 = null;
//			}
//			else if(recPart.getPart_name().equals("首页-服务中心")){
//				List templist2 = cdao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");	
//				request.setAttribute(recPart.getEng_name(), templist2);	
//				templist2 = null;
//			}
		
		return forwordname;
			
		}
}

