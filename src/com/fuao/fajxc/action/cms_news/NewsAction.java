package com.fuao.fajxc.action.cms_news;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.json.annotations.JSON;

import com.fuao.fajxc.action.InitConfig;
import com.fuao.fajxc.bussiness.common.CommonBiz;

import com.fuao.fajxc.vo.Fa_Cms_Classes;

import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.bussiness.common.CommonBizImpl;
import com.fuao.fajxc.dao.cms_news.NewsDao;
import com.fuao.fajxc.site.EnumStaticPath;
import com.fuao.fajxc.util.FileUtil;
import com.fuao.fajxc.util.HDThumb;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StrUtil;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.UtilCommon;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.ibm.icu.text.SimpleDateFormat;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import freemarker.cache.StringTemplateLoader;

public class NewsAction extends ActionSupport implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private static Logger logger = Logger.getLogger(NewsAction.class);
	private static final long serialVersionUID = 1L;
	private File fileupload; // 和JSP中input标记name同名
    private String imageUrl;
	private String attachmentUrl;
	private String fileRealName;	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CommonBiz commonbiz;
	private List rows=new ArrayList();
	private static int flags=0;
	private int total;
	private Fa_Cms_News news;
	private NewsDao newsDao;
    //private List<Fa_Cms_Member> cMember;
    protected int current;
	protected int page;
    protected int row;
    private String mid;
    //条件
    private String condit1;
    private String condit2;
    private String condit3;
    private String condit4;
    
    
    private String fileuploadFileName;

    public String getFileuploadFileName() {
		return fileuploadFileName;
	}

	public void setFileuploadFileName(String fileuploadFileName) {
		this.fileuploadFileName = fileuploadFileName;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public void setCondit3(String condit3) {
		this.condit3 = condit3;
	}

	public void setCondit4(String condit4) {
		this.condit4 = condit4;
	}

	public void setCondit1(String condit1) {
		this.condit1 = condit1;
	}

	public void setCondit2(String condit2) {
		this.condit2 = condit2;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}
	private String del;
    
	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}
	@JSON(serialize=false)
    public NewsDao getNewsDao() {
		return newsDao;
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

	public void setNewsDao(NewsDao newsDao) {
		this.newsDao = newsDao;
	}

	public Fa_Cms_News getNews() {
		return news;
	}

	public void setNews(Fa_Cms_News news) {
		this.news = news;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	private int pageNumber;
	
	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
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
	public void setCommonbiz(CommonBiz commonbiz) {
		this.commonbiz = commonbiz;
	}
	
	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("HHmmss");
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	
	/***
	 * 分页显示文章信息
	 * @return
	 */
	public String splitPages(){
	    System.out.println("分页了。。。");
		total=newsDao.countData("select count(*) from Fa_Cms_News where delflag=0 ");
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=newsDao.splitPages(this.getCurrent(),this.row,"from Fa_Cms_News where delflag=0 order by cid desc");
		System.out.println("rows="+this.rows);
	    return "success";
	}
	
	
	
	// 点击修改时进入修改
	public String update(){		
		// 绑定文章类型
		//cList=newsDao.getClasses();
		int id = Integer.parseInt(request.getParameter("cid"));
		System.err.println(id);
		this.setNews((Fa_Cms_News)newsDao.getNewsById(Fa_Cms_News.class, id));
		String smalltext = this.getNews().getSmalltext();
//		smalltext = smalltext.replace("\n", "<br />\n");
//	    smalltext = smalltext.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
//		smalltext = smalltext.replace("<br />", "");
//		smalltext = smalltext.replace("&nbsp;&nbsp;&nbsp;&nbsp;", "\t");
		this.getNews().setSmalltext(smalltext);
		System.out.println(this.news.getContents()+"内容，"+this.news.getTitle()+"，标题，"+this.news.getCid());
		return "update";
	}
	
	// 保存添加或修改的数据
	public void addOrUpdate(){
		String urls="";
		Date now = new Date();
		String str3 =dateFormat.format(now);
		String str= dateFormat2.format(now);
		
		news.setEditdate(str);
		System.out.println("content="+this.news.getContents());
		System.out.println("title="+this.news.getTitle());
		String  img1 = request.getParameter("img1");//图片地址
		String  img2 = request.getParameter("img2");
		String  img3 = request.getParameter("img3");
		String  img4 = request.getParameter("img4");
		String  img5 = request.getParameter("img5");
		String  img6 = request.getParameter("img6");
		String sgImg=null;
		String sgThumb=null;
		if(img1!=null && !img1.equals("")){
			sgImg="|"+img1;
			
		}
		if(img2!=null && !img2.equals("")){
			sgImg+="|"+img2;
			}
		if(img3!=null && !img3.equals("")){
			sgImg+="|"+img3;
			}
		if(img4!=null && !img4.equals("")){
			sgImg+="|"+img4;
			
			}
		if(img5!=null && !img5.equals("")){
			sgImg+="|"+img5;
		}
		if(img6!=null && !img6.equals("")){
			sgImg+="|"+img6;
		}
		sgThumb = sgImg.replace("/pic/", "/pic_thumb/");
        this.news.setTitlepic(sgImg);
        
        String contentcheck = (String)request.getSession().getServletContext().getAttribute("contentcheck");
        if(contentcheck == null){
        	this.news.setStatus(1);//为空默认是不需要审核 审核通过
        }else if(contentcheck.equals("0")){
        	this.news.setStatus(1);//为0审核关闭 审核通过
        }else if(contentcheck.equals("1")){
        	this.news.setStatus(0);//为1审核开启 新增或修改初始化内容时需要审核
        }else{
        	this.news.setStatus(1);//其他值默认是不需要审核 审核通过
        }
        
        this.news.setTitlepicThumb(sgThumb);
	    String smalltext = this.news.getSmalltext();
//	    input = replace(input, "\n", "<br>\n");
//		input = replace(input, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
//		input = replace(input, "  ", "&nbsp;&nbsp;");
//	    smalltext = smalltext.replace("\n", "<br />");
//	    smalltext = smalltext.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
//	    logger.info(smalltext);
//		this.news.setSmalltext(smalltext);
		if(request.getParameter("pams").equals("up")){
			System.out.println("cid="+this.news.getCid());
			this.news.setDelflag(0);
			this.news.setStatus(0);
			System.out.println("cid="+this.news.getClasses().getClassid());
			newsDao.updNews(this.news);
			urls="paperManage.jsp";
		}else if(request.getParameter("pams").equals("ad")){
			this.news.setDelflag(0);
			this.news.setStatus(0);
			System.out.println("cid="+this.news.getClasses().getClassid());
			news.setSenddate(str);
			newsDao.addNews(this.news);
			urls="paperManage.jsp";
		}else{
			this.news.setDelflag(0);
			this.news.setStatus(0);
			System.out.println("cid="+this.news.getClasses().getClassid());
			newsDao.updNews(this.news);
			urls=request.getParameter("pams");
		}
		try {
			response.setCharacterEncoding("GBK");
			response.getWriter().write("<center>保存成功!</center><script>location.back(-1);</script>");	
			response.setHeader("refresh", "1;URL="+request.getContextPath()+"/cms/papers/"+urls);
			System.out.println("request.getContextPath()="+request.getContextPath());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	/***
	 * 根据字段的模糊查询
	 * @return
	 */
	public String select(){		
		 // 根据关键字查
		 String keyboard=this.condit1;
		 // 根据显示与不显示查
		  int showflag=Integer.parseInt(this.condit2);
		 //根据审核状态查
		 int status= Integer.parseInt(this.condit3);
		 // 选择类别
		 int classid = Integer.parseInt(this.condit4);
		 //key=KTVshow=1status=100classid=100
		 try {
			keyboard = new String(keyboard.getBytes("gbk"),"utf8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		logger.info("key="+keyboard+"show="+showflag+"status="+status+"classid="+classid);
		String sql="";
		String hsql="";
		if(status==100 && classid!=100){
			   sql="select count(*) from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%') and showflag="+showflag+" and classid="+classid;
			   hsql="from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag+" and classid="+classid;
		}else if(classid==100 && status!=100){
			   sql="select count(*) from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag+" and status="+status;
			   hsql="from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag+" and status="+status;
		}else if(classid==100 && status==100){
			 sql="select count(*) from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag;
			   hsql="from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag;
		}else{
		   sql="select count(*) from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag+" and status="+status+" and classid="+classid;
		   hsql="from Fa_Cms_News where delflag=0 and (title  like '%"+keyboard+"%' or keyboard like '%"+keyboard+"%')  and showflag="+showflag+" and status="+status+" and classid="+classid;
		}
	    total=newsDao.countData(sql);
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=newsDao.splitPages(this.getCurrent(),this.row,hsql);
		System.out.println("##rows="+rows);
		return SUCCESS;
	}
	 
	// 点击添加按妞时触发
	public String load(){
		
		
		String sitekey = (String)request.getSession().getServletContext().getAttribute("sitekey");
		if(sitekey == null){
			logger.error("无法获得全局变量-sitekey值 请确认配置文件config/tempconfig.xml存在 且配置了此属性");
			return null;
		}
		
//		List<Fa_Cms_Classes> cList2=newsDao.getClasses();
		
		
		String sql = "select getChildClassesLst("+  new Integer(sitekey) + ")";
		String sonIds = commonbiz.executeSql(sql);
		List<Fa_Cms_Classes> cList=commonbiz.getForm("Fa_Cms_Classes", " and delflag = 0 and showflag = 0 and classid in("+sonIds+" )");
		String str="";//AH4J8sDVsCHzLqChhapMyNnV5ziXK2FweB
		for (int i = 0; i < cList.size(); i++) {
			Fa_Cms_Classes classes=cList.get(i);
			str+="<option value="+classes.getClassid()+">"+classes.getClassname()+"</option>";
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		try {
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	// 删除
	public String del(){
		System.out.println("dgfsdfsf="+mid);
		String str[]=mid.split(",");
		for (int i = 0; i < str.length; i++) {
		Fa_Cms_News fanews=new Fa_Cms_News();
		int id=Integer.parseInt(str[i]);
		fanews=(Fa_Cms_News)newsDao.getNewsById(Fa_Cms_News.class,id);
		newsDao.delNews(fanews);
		flags=1;
		}
		if(flags==1){
		   this.del="删除成功！";
		}
		return SUCCESS;
	}
	
	// 切换隐藏，显示
	public String show(){
		int cid=Integer.parseInt(request.getParameter("cid"));
		int state=Integer.parseInt(request.getParameter("state"));
		System.out.println("显示"+cid+"*stat="+state);
		if(state==1){
			newsDao.hiddenNews(cid,1);
		}else{
			newsDao.hiddenNews(cid,0);
		}
		return "show";
	}
	
	/**
	 * 查看新闻
	 * @return
	 */
	public String  info(){
		int cid = StringUtil.strToInt(request.getParameter("cid"), 0);
		if(cid == 0){
			return "info_no_param";
		}
		Fa_Cms_News cms = (Fa_Cms_News)newsDao.getNewsById(Fa_Cms_News.class, cid);
		if(cms == null){
			return "info_no_cid";
		}
		request.setAttribute("news", cms);
		return "info";
	}
	/**
	 * 文件上传
	 * @return
	 */
	public String upload() {
		String extName = ""; // 保存文件拓展名
		String newFileName = ""; // 保存新的文件名
		String nowTimeStr = ""; // 保存当前时间
		PrintWriter out = null;
		SimpleDateFormat sDateFormat;
		Random r = new Random();

		String savePath = ServletActionContext.getServletContext().getRealPath(
				""); // 获取项目根路径
		logger.info(ServletActionContext.getServletContext().getContextPath());
		String contentspic = EnumStaticPath.getInstance().getCONTENT_PIC();//从配置文件中读取内容发布中上传图片路径
		
		String  absFilePath= ServletActionContext.getServletContext().getContextPath()+""+contentspic;
		String absThumbPath = ServletActionContext.getServletContext().getContextPath()+""+contentspic+"/pic_thumb/";
		
		
		String thumbPath = savePath +StringUtil.replace(contentspic, "/", File.separator)+File.separator+"pic_thumb"+File.separator;
		savePath = savePath + StringUtil.replace(contentspic, "/", File.separator)+File.separator;
		File f  = new File(savePath);
		File f2  = new File(thumbPath);
		if(!f.exists()) f.mkdirs();
		if(!f2.exists()) f2.mkdirs();
		f=null;
		f2=null;
		response.setContentType("text/html;charset=GBK"); // 务必，防止返回文件名是乱码

		// 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）
		//int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数
		//sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式
		//nowTimeStr = sDateFormat.format(new Date()); // 当前时间
		// 获取拓展名
		if (fileuploadFileName !=null && fileuploadFileName.lastIndexOf(".") >= 0) {
			extName = fileuploadFileName.substring(fileuploadFileName
					.lastIndexOf("."));
		}
		try {
			out = response.getWriter();
			//newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字
			
//			String filePath = savePath + fileuploadFileName;
			String filePath = savePath + fileuploadFileName;
//			thumbPath = thumbPath + newFileName;
			
			thumbPath = thumbPath + fileuploadFileName;
			filePath = filePath.replace("\\", "/");
			thumbPath = thumbPath.replace("\\", "/");
			
			//检查上传的是否是图片
			if (UtilCommon.checkIsImage(extName)) {
				FileUtils.copyFile(fileupload, new File(filePath));
				logger.info(filePath);
				logger.info(thumbPath);
				//生成缩略图
				new HDThumb().buildHDThumb(filePath, thumbPath, 350);
//				filePath = StrUtil.getStr(filePath);
				
				out.print("<font color='red'>" + fileuploadFileName
						+ "上传成功!</font>#" + absThumbPath+fileuploadFileName + "#" + fileuploadFileName);

			} else {
				out.print("<font color='red'>上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!</font>");
			}
			out.flush();
			out.close();
			logger.info("上传end");
			} catch (IOException e) {
			e.printStackTrace();
			out.print("上传失败，出错啦!");
			logger.info("上传error");
		}
		return null;
	}
	
	/**
	 * 文件上传--推荐模块
	 * @return
	 */
	public String upload2() {
		String extName = ""; // 保存文件拓展名
		String newFileName = ""; // 保存新的文件名
		String nowTimeStr = ""; // 保存当前时间
		PrintWriter out = null;
		SimpleDateFormat sDateFormat;
		Random r = new Random();

		String savePath = ServletActionContext.getServletContext().getRealPath(
				""); // 获取项目根路径
		System.out.println(ServletActionContext.getServletContext().getContextPath());
		
		String recpath = EnumStaticPath.getInstance().getREC_PIC();//从配置文件中读取推荐上传路径
		
		String  absFilePath= ServletActionContext.getServletContext().getContextPath()+"/"+EnumStaticPath.getInstance().getREC_PIC();
		String absThumbPath = ServletActionContext.getServletContext().getContextPath()+"/"+EnumStaticPath.getInstance().getREC_PIC()+"/pic_thumb/";
		
		String thumbPath = savePath+File.separator +StringUtil.replace(recpath, "/", File.separator) +File.separator+"pic_thumb"+File.separator;
		savePath = savePath +File.separator + StringUtil.replace(recpath, "/", File.separator)+File.separator;
		File f  = new File(savePath);
		File f2  = new File(thumbPath);
		if(!f.exists()) f.mkdirs();
		if(!f2.exists()) f2.mkdirs();
		f=null;
		f2=null;
		response.setContentType("text/html;charset=GBK"); // 务必，防止返回文件名是乱码
		
		// 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）
		int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数
		sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式
		nowTimeStr = sDateFormat.format(new Date()); // 当前时间
		// 获取拓展名
		logger.info("文件名："+fileuploadFileName);
		if (fileuploadFileName !=null && fileuploadFileName.lastIndexOf(".") >= 0) {
			extName = fileuploadFileName.substring(fileuploadFileName
					.lastIndexOf("."));
		}
		try {
			out = response.getWriter();
			newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字
			
//			String filePath = savePath + fileuploadFileName;
			String filePath = savePath + newFileName;
			thumbPath = thumbPath + newFileName;
//			thumbPath = thumbPath + fileuploadFileName;
			filePath = filePath.replace("\\", "/");
			thumbPath = thumbPath.replace("\\", "/");
			
			//检查上传的是否是图片
			if (UtilCommon.checkIsImage(extName)) {
				FileUtils.copyFile(fileupload, new File(filePath));
				logger.info(filePath);
				//logger.info(thumbPath);
				//生成缩略图
				//new HDThumb().buildHDThumb(filePath, thumbPath, 350);
//				filePath = StrUtil.getStr(filePath);
				
				out.print("<font color='red'>" + fileuploadFileName
						+ "上传成功!</font>#" + absFilePath+"/"+newFileName + "#" + newFileName);

			} else {
				out.print("<font color='red'>上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!</font>");
			}
			out.flush();
			out.close();
			logger.info("上传end");
			} catch (IOException e) {
			e.printStackTrace();
			out.print("上传失败，出错啦!");
			logger.info("上传error");
		}
		return null;
	}
	/**
	 * 重新加载初始化配置
	 */
	public void reconfig(){
		
		InitConfig.doInit(request.getSession().getServletContext());
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(0);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	

	public File getFileupload() {
		return fileupload;
	}

	public void setFileupload(File fileupload) {
		this.fileupload = fileupload;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getAttachmentUrl() {
		return attachmentUrl;
	}

	public void setAttachmentUrl(String attachmentUrl) {
		this.attachmentUrl = attachmentUrl;
	}

	public String getFileRealName() {
		return fileRealName;
	}

	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}	
	
}
