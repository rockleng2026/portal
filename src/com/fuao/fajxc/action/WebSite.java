package com.fuao.fajxc.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.dao.cms_website.WebSiteDAO;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;
import com.opensymphony.xwork2.ActionSupport;

public class WebSite extends ActionSupport implements ServletRequestAware,ServletResponseAware{
	private static Logger logger = Logger.getLogger(WebSite.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CommonBiz commonbiz;
	private WebSiteDAO webdao;
	private String forwardpath;
	
	

	public String getForwardpath() {
		return forwardpath;
	}

	public void setForwardpath(String forwardpath) {
		this.forwardpath = forwardpath;
	}

	public WebSiteDAO getWebdao() {
		return webdao;
	}

	public void setWebdao(WebSiteDAO webdao) {
		this.webdao = webdao;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public CommonBiz getCommonbiz() {
		return commonbiz;
	}

	public void setCommonbiz(CommonBiz commonbiz) {
		this.commonbiz = commonbiz;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	
	public Object getModel() {
		return null;
	}
	
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	
	
	/***
	 * 分页显示文章信息
	 * @return
	 */
	public String showlist(){
	    System.out.println("web前端 分页了。。。");
	    String classid = request.getParameter("classid");
	    String match_name= request.getParameter("match_name");//Aciton后缀匹配
	    
	    if(classid == null || !StringUtil.isNumeric(classid)){
	    	return "paramerror";
	    }
	    if(match_name == null){
	    	return "paramerror";
	    }
//	    Fa_Cms_News
	    String hql = "from Fa_Cms_News as news where news.delflag=0 and news.showflag=0 and news.classid = "+classid+" order by sequence desc,senddate desc";
	    int pageNo = 0;
	    String pageNoStr = request.getParameter("page");
		if (null == pageNoStr) {
			pageNo = 1;
		}else if(!StringUtil.isNumeric(pageNoStr)){
	    	return "paramerror";
	    }else{
	    	pageNo = Integer.parseInt(pageNoStr);
	    }
		int pageSize = 0;
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr) {
			pageSize = 20;
		}else if(!StringUtil.isNumeric(pageSizeStr)){
	    	return "paramerror";
	    }else{
	    	pageSize = Integer.parseInt(pageSizeStr);
	    }
	    Object[] values = null; 
	    Pages pages = commonbiz.exHqlPages(hql, pageNo, pageSize, values);
	    logger.info(pages.getPageNo());
	    logger.info(pages.getPageSize());
	    logger.info(pages.getAllCount());
	    logger.info(pages.getAllPage());
	    String fenye = StringUtil.paging2(pages.getPageNo(), pages.getAllCount(), pages.getPageSize(), 3, "cms/web/showlist"+match_name+".do?match_name="+match_name+"&classid="+classid);
//		total=newsDao.countData("select count(*) from Fa_Cms_News where delflag=0");
//		System.out.println("pageCount="+total);
//		this.setPage(Integer.parseInt(request.getParameter("page")));
//		//页面大小
//		this.setRow(Integer.parseInt(request.getParameter("rows")));
//		System.out.println("page="+page+"##row="+row);
//		rows=newsDao.splitPages(this.getCurrent(),this.row,"from Fa_Cms_News where delflag=0 order by cid desc");
//		System.out.println("rows="+this.rows);
	    request.setAttribute("match_name", match_name);
	    request.setAttribute("pages", pages);
		request.setAttribute("classid", classid);
		request.setAttribute("fenye", fenye);
		logger.info(fenye);
		
	    return "weblistproduct";	
	}
	/***
	 * 显示正文信息
	 * @return
	 */
	public String showinfo(){
		
		String cid = request.getParameter("cid");
	     
	    if(cid == null || !StringUtil.isNumeric(cid)){
	    	return "paramerror";
	    }else if( !StringUtil.isNumeric(cid)){
	    	return "paramerror";
	    }
	    
	    Fa_Cms_News product= (Fa_Cms_News)commonbiz.getForm(Fa_Cms_News.class, Integer.parseInt(cid));
	    if(product == null ){
	    	request.setAttribute("errorMsg", "你访问的内容不存在或者已经删除！");
	    	return "paramerror";
	    }
	    Fa_Cms_News product1  = null;
	    Fa_Cms_News product2  = null;
	    List<Fa_Cms_News> list1 = commonbiz.getForm("Fa_Cms_News", " and delflag=0 and showflag=0 and classes.classid = "+product.getClassid()+" and cid<"+cid+" order by cid desc");
	    List<Fa_Cms_News> list2 = commonbiz.getForm("Fa_Cms_News", " and delflag=0 and showflag=0 and classes.classid = "+product.getClassid()+" and cid>"+cid+" order by cid desc");
	   
	    //获得上一条记录
	    if(list1 != null && list1.size()>0)
	    	product1 = (Fa_Cms_News)list1.get(0);
	    //获得下一条记录
	    if(list2 != null && list2.size()>0)
	    	product2 = (Fa_Cms_News)list2.get(0);
	    
//	    String smalltext = StringUtil.textToHtml(product.getSmalltext());
//		对简介进行处理
	    String smalltext = product.getSmalltext();
	    smalltext = smalltext.replace("\n", "<br />\n");
	    smalltext = smalltext.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
	    logger.info(smalltext);
//	    对title图片和缩略图进行处理
		String thumb = product.getTitlepicThumb();
	     if(thumb != null && !thumb.trim().equals("")){
	    	 if(thumb.startsWith("|")){
	    		 thumb = thumb.substring(1,thumb.length());
	    	 }
	    	 String[] thumbarra = thumb.split("\\|");
	    	 String[] namearra = thumb.split("\\|");
	    	 for (int i = 0; i < thumbarra.length; i++) {
	    		 int  e = thumbarra[i].lastIndexOf(".");
	    		 int  s = thumbarra[i].lastIndexOf("/");
				String fname = thumbarra[i].substring(s+1,e);
				namearra[i] = fname;
			}
	    	 
	    	 request.setAttribute("thumbarra",thumbarra );
	    	 if(thumbarra.length >=4){
	    		 request.setAttribute("thumblength",4 );
	    	 }else{
	    		 request.setAttribute("thumblength",thumbarra.length );
	    	 }
	    	 
	    	 request.setAttribute("namearra",namearra );
	     }
		
//		if(imgstr != null && !imgstr.trim().equals("") && thumbstr !=null && !thumbstr.trim().equals("")){
//		  
//		  if(imgstr.startsWith("|")){
//			  imgstr = imgstr.substring(1,imgstr.length());
//		  }
//		  if(thumbstr.startsWith("|")){
//			  thumbstr = thumbstr.substring(1,thumbstr.length());
//		  }
//		  
//		  String[] imgarra = imgstr.split("\\|");
//		  
//		  String[] thumbarra = thumbstr.split("\\|");
//
//			  request.setAttribute("imgarra", imgarra);
//			  request.setAttribute("thumbarra", thumbarra);
//			  String targetstr = "var target = [";
//			  int num = thumbarra.length;
//			  for (int i = 0; i < thumbarra.length; i++) {
//				targetstr += "'xixi-0"+(i+1)+"',";
//			  }
//			  targetstr = targetstr.substring(0,targetstr.length()-1);
//			  targetstr += "];";
//			  request.setAttribute("thumb_num", thumbarra.length);
//			  request.setAttribute("targetstr", targetstr);
//	 }
	    
	    product.setSmalltext(smalltext);
	    request.setAttribute("product", product);
	    request.setAttribute("classid", product.getClassid());
	    logger.info(product.getClassid());
	    //logger.info(product.getClasses().getClassid());
	    if(product.getClasses() == null){
	    	request.setAttribute("classname", "未分类");
	    }else{
	    	request.setAttribute("classname", product.getClasses().getClassname());
	    }
	    
	    request.setAttribute("nextpdt", product2);
	    request.setAttribute("prevpdt", product1);
	    
		return "webinfoproduct";
	}
	
	/***
	 * 显示正文信息
	 * @return
	 */
	public String showinfo2(){
		
		String cid = request.getParameter("cid");
	     
	    if(cid == null || !StringUtil.isNumeric(cid)){
	    	return "paramerror";
	    }else if( !StringUtil.isNumeric(cid)){
	    	return "paramerror";
	    }
	    
	    Fa_Cms_News product= (Fa_Cms_News)commonbiz.getForm(Fa_Cms_News.class, Integer.parseInt(cid));
	    
	    Fa_Cms_News product1  = null;
	    Fa_Cms_News product2  = null;
	    List<Fa_Cms_News> list1 = commonbiz.getForm("Fa_Cms_News", " and delflag=0 and showflag=0 and classes.classid = "+product.getClassid()+" and cid<"+cid+" order by cid desc");
	    List<Fa_Cms_News> list2 = commonbiz.getForm("Fa_Cms_News", " and delflag=0 and showflag=0 and classes.classid = "+product.getClassid()+" and cid>"+cid+" order by cid desc");
	   
	    //获得上一条记录
	    if(list1 != null && list1.size()>0)
	    	product1 = (Fa_Cms_News)list1.get(0);
	    //获得下一条记录
	    if(list2 != null && list2.size()>0)
	    	product2 = (Fa_Cms_News)list2.get(0);
	    
//	    String smalltext = StringUtil.textToHtml(product.getSmalltext());
//		对简介进行处理
	    String smalltext = product.getSmalltext();
	    smalltext = smalltext.replace("\n", "<br />\n");
	    smalltext = smalltext.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
	    logger.info(smalltext);
//	    对title图片和缩略图进行处理
		String thumb = product.getTitlepicThumb();
	     if(thumb != null && !thumb.trim().equals("")){
	    	 if(thumb.startsWith("|")){
	    		 thumb = thumb.substring(1,thumb.length());
	    	 }
	    	 String[] thumbarra = thumb.split("\\|");
	    	 String[] namearra = thumb.split("\\|");
	    	 for (int i = 0; i < thumbarra.length; i++) {
	    		 int  e = thumbarra[i].lastIndexOf(".");
	    		 int  s = thumbarra[i].lastIndexOf("/");
				String fname = thumbarra[i].substring(s+1,e);
				namearra[i] = fname;
			}
	    	 
	    	 request.setAttribute("thumbarra",thumbarra );
	    	 if(thumbarra.length >=4){
	    		 request.setAttribute("thumblength",4 );
	    	 }else{
	    		 request.setAttribute("thumblength",thumbarra.length );
	    	 }
	    	 
	    	 request.setAttribute("namearra",namearra );
	     }
		
//		if(imgstr != null && !imgstr.trim().equals("") && thumbstr !=null && !thumbstr.trim().equals("")){
//		  
//		  if(imgstr.startsWith("|")){
//			  imgstr = imgstr.substring(1,imgstr.length());
//		  }
//		  if(thumbstr.startsWith("|")){
//			  thumbstr = thumbstr.substring(1,thumbstr.length());
//		  }
//		  
//		  String[] imgarra = imgstr.split("\\|");
//		  
//		  String[] thumbarra = thumbstr.split("\\|");
//
//			  request.setAttribute("imgarra", imgarra);
//			  request.setAttribute("thumbarra", thumbarra);
//			  String targetstr = "var target = [";
//			  int num = thumbarra.length;
//			  for (int i = 0; i < thumbarra.length; i++) {
//				targetstr += "'xixi-0"+(i+1)+"',";
//			  }
//			  targetstr = targetstr.substring(0,targetstr.length()-1);
//			  targetstr += "];";
//			  request.setAttribute("thumb_num", thumbarra.length);
//			  request.setAttribute("targetstr", targetstr);
//	 }
	    
	    product.setSmalltext(smalltext);
	    request.setAttribute("product", product);
	    request.setAttribute("classid", product.getClassid());
	    logger.info(product.getClassid());
	    logger.info(product.getClasses().getClassid());
	    request.setAttribute("classname", product.getClasses().getClassname());
	    request.setAttribute("nextpdt", product2);
	    request.setAttribute("prevpdt", product1);
	    
		return "webinfo2product";
	}
	
	public String indextohtml(){
		
		String typeid = request.getParameter("typeid");
		String forwardname = request.getParameter("forwardname");
		forwardpath = request.getParameter("forwardpath");
		
		if(forwardname == null || forwardpath == null){
			logger.error("模板名称或路径错误！");
			request.setAttribute("errorMsg", "模板名称或路径错误！");
			return "error";
		}
		
		//fa_cms_classes fa_cms_template  fa_cms_rec_part  fa_cms_rec_info
		int sitekey = 0;//站点ID
		int mid = 0;//模块ID 常量(1首页 2 栏目页 3内容页 4 最新页面 5其他页面)
		int topnum = 0;//最新几条
//		Fa_Cms_Rec_Part rp = null;//推荐类
		mid = StringUtil.strToInt(request.getParameter("mid"),0);
		sitekey = Integer.parseInt(typeid);
		List<Fa_Cms_Rec_Part> rplist = webdao.getRecPartList(sitekey,mid);
		for (Iterator it = rplist.iterator(); it.hasNext();) {
			Fa_Cms_Rec_Part rp = (Fa_Cms_Rec_Part) it.next();
			logger.info(rp.getEng_name()+"--"+rp.getPart_name());
			List<Fa_Cms_Rec_Info> rilist = webdao.getRecInfoList(" and info_pid="+rp.getPid(),topnum);
			request.setAttribute(rp.getEng_name(), rilist);
			request.setAttribute(rp.getEng_name()+"rec", rp);
//			for (Iterator it2 = rilist.iterator(); it2.hasNext();) {
//				Fa_Cms_Rec_Info ri = (Fa_Cms_Rec_Info) it2.next();
//				logger.info("文章信息-"+ri.getInfo_pid()+"-"+ri.getNews().getCid()+"-"+ri.getNews().getTitle());
//				
//				
//			}
		}
		return forwardname;
	}
	/**
	 * 可以定位每个部门的具体位置 比如热门推荐中有4个图片 我可以定位具体推荐到那个热门推荐的第几张图片
	 * @return
	 */
public String indextohtml2(){
		logger.info("indextohtml2");
		String typeid = request.getParameter("typeid");
		String forwardname = request.getParameter("forwardname");
		forwardpath = request.getParameter("forwardpath");
		logger.info("indextohtml2--1--"+forwardname);
		if(forwardname == null || forwardpath == null){
			logger.error("模板名称或路径错误！");
			request.setAttribute("errorMsg", "模板名称或路径错误！");
			return "error";
		}
		
		//fa_cms_classes fa_cms_template  fa_cms_rec_part  fa_cms_rec_info
		int sitekey = 0;//站点ID
		int mid = 0;//模块ID 常量(1首页 2 栏目页 3内容页 4 最新页面 5其他页面)
		int topnum = 0;//最新几条
//		Fa_Cms_Rec_Part rp = null;//推荐类
		mid = StringUtil.strToInt(request.getParameter("mid"),0);
		logger.info("indextohtml2--11--"+mid);
		sitekey = Integer.parseInt(typeid);
		List<Fa_Cms_Rec_Part> rplist = webdao.getRecPartList(sitekey,mid);
		logger.info("indextohtml2--2--"+rplist);
		for (Iterator it = rplist.iterator(); it.hasNext();) {
			Fa_Cms_Rec_Part rp = (Fa_Cms_Rec_Part) it.next();
			logger.info(rp.getEng_name()+"--"+rp.getPart_name()+"--"+rp.getPart_num());
			for (int i = 0; i < rp.getPart_num(); i++) {
				String andhql = " and info_pid="+rp.getPid()+" and info_seq ="+(i+1);
				List<Fa_Cms_Rec_Info> rilist = webdao.getRecInfoList(andhql,topnum);
				if( rilist == null || rilist.size() == 0 ){
					request.setAttribute(rp.getEng_name()+i, new Fa_Cms_Rec_Info());
				}else{
					request.setAttribute(rp.getEng_name()+i, rilist.get(0));
				}
			}
			request.setAttribute(rp.getEng_name()+"rec", rp);
			
//			for (Iterator it2 = rilist.iterator(); it2.hasNext();) {
//				Fa_Cms_Rec_Info ri = (Fa_Cms_Rec_Info) it2.next();
//				logger.info("文章信息-"+ri.getInfo_pid()+"-"+ri.getNews().getCid()+"-"+ri.getNews().getTitle());
//				
//				
//			}
		}
		return forwardname;
	}
	
}


