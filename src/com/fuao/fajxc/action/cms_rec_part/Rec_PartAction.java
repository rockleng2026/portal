package com.fuao.fajxc.action.cms_rec_part;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspApplicationContext;
import javax.servlet.jsp.JspEngineInfo;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.components.ActionComponent;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.util.ServletContextAware;
import org.springframework.web.context.ServletConfigAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;

import com.fuao.fajxc.dao.cms_news.NewsDao;

import com.fuao.fajxc.dao.cms_classesdao.ClassesDao;

import com.fuao.fajxc.dao.cms_rec_part.Rec_PartDao;
import com.fuao.fajxc.site.EnumStaticPath;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;

import com.ibm.icu.text.SimpleDateFormat;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import com.opensymphony.xwork2.ActionSupport;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.config.entities.ActionConfig;
public class Rec_PartAction extends ActionSupport implements Action,ServletRequestAware,ServletResponseAware{


	private HttpServletRequest request;
	private HttpServletResponse response;
	private ServletConfig servletConfig;
	private Fa_Cms_News news;
	private Fa_Cms_Rec_Info info;

	public Fa_Cms_News getNews() {
		return news;
	}

	public Fa_Cms_Rec_Info getInfo() {
		return info;
	}
	public void setInfo(Fa_Cms_Rec_Info info) {
		this.info = info;
	}

	private Fa_Cms_Rec_Part rec_part;
	private Rec_PartDao partDao;
	private NewsDao newsDao;
	private List partDescList;

	private ClassesDao classd;

	private int total;
	protected int current;
	protected int page;
    protected int row;	


    //模糊查询条件
    private String className;
    private String info_pid;
    public String getInfo_pid() {
		return info_pid;
	}

	public void setInfo_pid(String infoPid) {
		info_pid = infoPid;
	}

	//上传图片
    private File picname; //保存上传图片的临时文件
    private String fileName; //上传文件的名称
    private String contentType; //上传文件的内容类型
	private Long   fileId;
	private String msg; //错误消息提示
	private Long fileSize;//上传文件的的大小信息
	private InputStream downInputStream;

	private List rows=new ArrayList();
    private String allval;
	public List getPartDescList() {
		return partDescList;
	}
	public void setPartDescList(List partDescList) {
		this.partDescList = partDescList;
	}
	public String getAllval() {
		return allval;
	}
	public void setAllval(String allval) {
		this.allval = allval;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
	public int getCurrent() {
		return (this.page-1)*this.row;
	}
	public void setCurrent(int current) {
		this.current = current;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public void setClassd(ClassesDao classd) {
		this.classd = classd;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public void setPartDao(Rec_PartDao partDao) {
		this.partDao = partDao;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setRec_part(Fa_Cms_Rec_Part recPart) {
		rec_part = recPart;
	}
	
	public Fa_Cms_Rec_Part getRec_part() {
		return rec_part;
	}

	public void setNews(Fa_Cms_News news) {
		this.news = news;
	}
	public void setNewsDao(NewsDao newsDao) {
		this.newsDao = newsDao;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}

	public File getPicname() {
		return picname;
	}
	public void setPicname(File picname) {
		this.picname = picname;
	}

	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/***
	 * 分页显示
	 * @return
	 */
	public String splitPages(){
		String sitekey = (String)request.getSession().getServletContext().getAttribute("sitekey");
	    System.out.println("分页了。。。");
	    String sql = "select count(*) from Fa_Cms_Rec_Part where typeid = "+sitekey;
		total=partDao.countData(sql);
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=partDao.splitPages(this.getCurrent(),this.row);
		System.out.println("rows="+this.rows);
	    return SUCCESS;	
	}

	
	/***
	 * 分页显示
	 * @return
	 * 袁天龙
	 */
	public String splitPages2(){
	    System.out.println("分页了。。。");
//	    Fa_Cms_Rec_Info
	    String sql = "select count(*) from Fa_Cms_Rec_Info";
	    String hql = "from Fa_Cms_Rec_Info";
		total=partDao.countData(sql);
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=newsDao.splitPagesRecInfo(this.getCurrent(),this.row,"");
		System.out.println("rows="+this.rows);
	    return SUCCESS;	
	}
	

//	public String load(){
//		List<Fa_Cms_Classes> cList=newsDao.getClasses();
//		String str="";
//		for (int i = 0; i < cList.size(); i++) {
//			Fa_Cms_Classes classes=cList.get(i);
//			System.out.println("===>"+cList.get(i));
//			str+="<option value="+classes.getClassid()+">"+classes.getClassname()+"</option>";
//		}
//	//	System.out.println("新增值="+str);
//		response.setCharacterEncoding("utf-8");
//		try {
//			response.getWriter().print(str);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}	
//		return null;
//	}

	// 点击修改时进入修改
	public String update(){		
		// 绑定文章类型
		//cList=newsDao.getClasses();
		int id = Integer.parseInt(request.getParameter("cid"));
		System.err.println("id="+id);
		rec_part=(Fa_Cms_Rec_Part) partDao.getPartById(Fa_Cms_Rec_Part.class, id);
		System.out.println(this.rec_part.getEng_name());
//		String[] arry=rec_part.getTemp().split(",");
//		System.out.println("arr1="+arry[1]);
		rec_part.setTypeid(rec_part.getTypeid());
		rec_part.setTemp(rec_part.getTemp());
		request.setAttribute("strname","reups");
		return "update";
	}
	public String load(){ 
		System.err.println("allval");
		allval="";
		List list=classd.getObjects("from Fa_Cms_Classes c where c.delflag=0");
		System.err.println("li="+list.size());
		for(Iterator<Fa_Cms_Classes> ite=list.iterator();ite.hasNext();){
			Fa_Cms_Classes clast = ite.next();
			allval+="<option value="+clast.getClassid()+">"+clast.getClassname()+"</option>";
		}
		return "load";
	}
	/**
	 * ajax加载推荐部分
	 * @return
	 */
	public String loadrecinfo(){ 
		System.err.println("allval");
		allval="";//Fa_Cms_Rec_Part
		List list=classd.getObjects("from Fa_Cms_Rec_Part order by pid");
		System.err.println("li="+list.size());
		for(Iterator<Fa_Cms_Rec_Part> ite=list.iterator();ite.hasNext();){
			Fa_Cms_Rec_Part rec = ite.next();
			String prx = "";
			switch (rec.getMid()) {
			case 1:{
				prx = "首页";
				break;
			}
			case 2:{
				prx = "栏目页";
				break;
			}
			case 3:{
				prx = "内容页";
				break;
			}
			case 4:{
				prx = "最新页面";
				break;
			}
			case 5:{
				prx = "其他页面";
				break;
			}
			
			default:
				prx="未知";
				break;
			}
			allval+="<option value="+rec.getPid()+">"+prx+"-"+rec.getPart_name()+"</option>";
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		try {
			response.getWriter().print(allval);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	// 保存添加或修改的数据
	public void addOrUpdate(){
		String urls="";
		System.out.println("content");
		int body=rec_part.getMid();
		String pps="";
		if(body==1){
			pps="首页";
		}else if(body==2){
			pps="栏目页";
		}else if(body==3){
			pps="内容页";
		}else if(body==4){
			pps="最新页面";
		}else{
			pps="其它页面";
		}
		if(request.getParameter("pams").equals("add")){
			System.out.println("adds");
			System.out.println("type="+rec_part.getTypeid());
			rec_part.setPart_desc(pps+"-"+rec_part.getPart_name());
//			rec_part.setTemp(rec_part.getTemp()+","+rec_part.getTypeid());
//			rec_part.setTemp(rec_part.getTemp()+","+rec_part.getTypeid());
			Fa_Cms_Classes c = new Fa_Cms_Classes();
			c.setClassid(rec_part.getTypeid());
			rec_part.setClasses(c);
			partDao.addPart(rec_part);
			
			urls="putDeploy.jsp";
		}else{
			System.out.println("cid="+this.rec_part.getPid());
			System.out.println("cid="+this.rec_part.getPart_desc());
//		    rec_part.setPart_desc("");
			rec_part.setPart_desc(pps+"-"+rec_part.getPart_name());
//			rec_part.setTemp(rec_part.getTemp()+","+rec_part.getTypeid());
			partDao.updPart(this.rec_part);
			String hql = "update Fa_Cms_Rec_Info set info_pname='"+rec_part.getPart_name()+"' where info_pid = "+rec_part.getPid();
			newsDao.excuteHql(hql);
			urls="putDeploy.jsp";
		}
		this.rec_part=null;
		try {
			response.setCharacterEncoding("GBK");
			response.getWriter().write("<center>保存成功!</center><script>location.back(-1);</script>");	
			response.setHeader("refresh", "1;URL="+request.getContextPath()+"/cms/papers/"+urls);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}

	
	
	/*** 
	 * 根据字段的模糊查询
	 * @return
	 */
	public String select(){
		System.out.println("已经进入查询方法...");
		System.out.println(this.className);
    	int classid = Integer.parseInt(this.className);
		System.out.println("------------"+classid);
		String sql = "select count(*) from Fa_Cms_News where delflag=0";
		String hql = "from Fa_Cms_News where delflag=0";
		if(classid!=100){
			sql+=" and classid="+classid;
			hql+=" and classid="+classid;
		}
		total = newsDao.countData(sql); //总记录数
		System.out.println("sql语句:"+sql);
		System.out.println("hql语句:"+hql);
		System.out.println("总记录数="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page:"+page+","+"row:"+rows);
	//	rows=newsDao.splitPagesNews(this.getCurrent(),this.row);
		rows = newsDao.splitPagesRecInfo(this.getCurrent(), row ,"");
		System.out.println(">>>>"+rows);
		return SUCCESS;
	}
	/*** 
	 * 根据字段的模糊查询推荐信息
	 * @return
	 */
	public String select2(){
		System.out.println("已经进入查询方法...");
		System.out.println(this.info_pid);
    	int classid = Integer.parseInt(this.info_pid);
		System.out.println("------------"+classid);
		String sql = "select count(*) from Fa_Cms_Rec_Info where 1=1 ";
		if(classid!=100){
			sql+=" and info_pid="+info_pid;
		}
		total = newsDao.countData(sql); //总记录数
		System.out.println("sql语句:"+sql);
		System.out.println("总记录数="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page:"+page+","+"row:"+rows);
	//	rows=newsDao.splitPagesNews(this.getCurrent(),this.row);
		rows = newsDao.splitPagesRecInfo(this.getCurrent(), row," and info_pid="+info_pid);
		System.out.println(">>>>"+rows);
		return SUCCESS;
	}
    public void delt(){
    	String error="";
    	int m=Integer.parseInt(request.getParameter("cid"));
    	System.out.println("m="+m);
    	Fa_Cms_Rec_Part parts=new Fa_Cms_Rec_Part();
    	parts.setPid(m);
    	try {
			partDao.delPart(parts);
			error="删除成功!";
		} catch (Exception e1) {
			error="此数据在其它表有使用,删除失败!";
		   // e1.printStackTrace();
		}
    	try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().write("<center>"+error+"</center><script>location.back(-1);</script>");	
			response.setHeader("refresh", "1;URL="+request.getContextPath()+"/cms/papers/putDeploy.jsp");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
    }
	public String adddate(){
		this.rec_part=null;
		return "addDate";
	}
	
	/**
	 * 点击推荐按钮,要选中当前行的 标题,列出推荐位置,上传图片
	 */
	public String part(){
		//根据ID查询当前记录的标题
		Integer  cid = Integer.parseInt(request.getParameter("cid"));
		news = partDao.getNewsById(Fa_Cms_News.class, cid);
	//	System.out.println("推荐标题是:"+news.getTitle());
		//显示推荐位置,从part表里查出来 part_desc字段
		partDescList = partDao.getAllPart("from Fa_Cms_Rec_Part where 1=1");
	//	System.out.println("part_desc是:"+partDescList.size());
		request.setAttribute("partDescList", partDescList);
		
		return SUCCESS;
	}
	
	/**
	 * 点击层里面的推荐,把数据写入DB
	 */
	public String commitPart(){
		//向rec_info表写入数据
		System.out.println(news.getCid());
		partDescList = partDao.getAllPart("from Fa_Cms_Rec_Part where 1=1");
		Fa_Cms_Rec_Info info = new Fa_Cms_Rec_Info();
		info.setInfo_vid(news.getCid());
		for(int i=0;i<partDescList.size();i++){
			Fa_Cms_Rec_Part part2 = (Fa_Cms_Rec_Part)partDescList.get(i);
			info.setInfo_pid(part2.getPid());
		}
		info.setIs_img(0);
		info.setInfo_imgSrc(fileName);
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		info.setInfo_recdate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((new Date())));
		info.setTemp("推荐");
		partDao.addRec_info(info);
		return "a";
}
	/**
	 * 批量推荐,把数据写入DB
	 */
	public String commitParts(){
		//向rec_info表写入数据
		
		
		String num = request.getParameter("recNum");		
		int topid = StringUtil.strToInt(request.getParameter("topid"),0);		
		int _num = Integer.parseInt(num);
		for (int i = _num-1; i >=0 ; i--) {
			Fa_Cms_Rec_Info info = new Fa_Cms_Rec_Info();
			info.setInfo_seq(Integer.parseInt(request.getParameter("info_seq" + i)));
			info.setInfo_vid(Integer.parseInt(request.getParameter("recVid" + i)));
			info.setInfo_pid(Integer.parseInt(request.getParameter("recPart" + i)));
			info.setInfo_pname(request.getParameter("info_pname" + i));
			
			String datestr = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			String image = request.getParameter("recImgSrc" + i) == null || "".equals(request.getParameter("recImgSrc" + i)) ? null
					:EnumStaticPath.getInstance().getREC_PIC()+ "/"+request.getParameter("recImgSrc" + i);
			info.setTemp(request.getParameter("pyname"+i));
			info.setIs_img(Integer.valueOf(request.getParameter("isImg"+i)));
			info.setInfo_imgSrc(image);
			info.setInfo_recdate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((new Date())));
//			info.setInfo_recdate(new Date());
			System.out.println(info.getTemp()+"    ======   "+info.getInfo_imgSrc());
			Fa_Cms_News news  = new Fa_Cms_News();
			news.setCid(info.getInfo_vid());
			info.setNews(news);
			partDao.addRec_info(info);
			
		}
		request.setAttribute("topid", topid);
		
		
		
		
//		System.out.println(news.getCid());
//		partDescList = partDao.getAllPart("from Fa_Cms_Rec_Part where 1=1");
//		Fa_Cms_Rec_Info info = new Fa_Cms_Rec_Info();
//		info.setInfo_vid(news.getCid());
//		for(int i=0;i<partDescList.size();i++){
//			Fa_Cms_Rec_Part part2 = (Fa_Cms_Rec_Part)partDescList.get(i);
//			info.setInfo_pid(part2.getPid());
//		}
//		info.setIs_img(0);
//		info.setInfo_imgSrc(fileName);
//		info.setInfo_recdate(new Date());
//		info.setTemp("推荐");
//		partDao.addRec_info(info);
		
		
		
		return "a";
}


}
