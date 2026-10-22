package com.fuao.fajxc.action.cms_content_comments;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.dao.cms_classesdao.ClassesDao;
import com.fuao.fajxc.dao.cms_content_comment.Cms_Content;
import com.fuao.fajxc.dao.cms_content_comment.Cms_Content_Impl;
import com.fuao.fajxc.dao.cms_news.NewsDao;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Content_Comments;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ContextCommentsAction extends ActionSupport implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Fa_Cms_Content_Comments conmments;
	private Cms_Content content;
	private List rows=new ArrayList();
	private int total;
	protected int current;
	private NewsDao newsDao;
	private Fa_Cms_News news;
	protected int page;
	protected int row;
	private String del;//审核
	private int pcid;
	private String mid;
	private String condit1;
	private String condit2;
	public String getCondit1() {
		return condit1;
	}

	public void setCondit1(String condit1) {
		this.condit1 = condit1;
	}

	public String getCondit2() {
		return condit2;
	}
	public void setNewsDao(NewsDao newsDao) {
		this.newsDao = newsDao;
	}
	public void setCondit2(String condit2) {
		this.condit2 = condit2;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
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

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public int getPcid() {
		return pcid;
	}

	public void setPcid(int pcid) {
		this.pcid = pcid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public Object getModel() {
		return null;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public void setContent(Cms_Content content) {
		this.content = content;
	}
	public Fa_Cms_Content_Comments getConmments() {
		return conmments;
	}

	public void setConmments(Fa_Cms_Content_Comments conmments) {
		this.conmments = conmments;
	}

	/***
	 * 分页显示栏目信息
	 * @return
	 */
	public String splitPages(){
	    System.out.println("分页了。。。");
		total=content.countData("select count(*) from Fa_Cms_Content_Comments c where c.news.delflag=0 and c.news.status<2");
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=content.splitPages(this.getCurrent(),this.row,"from Fa_Cms_Content_Comments c where c.news.delflag=0 and c.news.status<2");
		System.out.println("rows="+this.rows);
	    return SUCCESS;	
	}
	// 点击修改时进入修改
	public String update(){		
		System.out.println("查comment");
		pcid=Integer.parseInt(request.getParameter("cid"));
		this.conmments=content.getById(pcid);
		System.out.println("cid="+this.conmments.getNews().getCid());
		this.news=(Fa_Cms_News) newsDao.getNewsById(Fa_Cms_News.class,this.conmments.getNews().getCid());
		System.out.println("nihao="+this.news.getTitle());
		news.setNewUrl("uls");
		request.setAttribute("news",news);	
		
		
		return "update";
	}
	
	/***
	 * 根据字段的模糊查询
	 * @return
	 */
	public String select(){	
		 //根据审核状态查
		System.out.println("condit1="+condit1+"***condit2"+condit2);
		String sql="";
		String hsql="";
		if(this.condit2.equals("100")){
			sql="select count(*) from  Fa_Cms_Content_Comments c where c.news.status="+this.condit1+" "+"and c.news.delflag=0";
			hsql="from Fa_Cms_Content_Comments c where c.news.status="+this.condit1+" "+"and c.news.delflag=0";
		}else{
			sql="select count(*) from  Fa_Cms_Content_Comments c where c.news.delflag=0 and c.news.status="+this.condit1+" "+"and c.news.classes.classid="+this.condit2;
		    hsql="from  Fa_Cms_Content_Comments c where c.news.delflag=0 and c.news.status="+this.condit1+" "+"and c.news.classes.classid="+this.condit2;
		}
	    total=this.content.countData(sql);
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=this.content.splitPages(this.getCurrent(),this.row,hsql);
		System.out.println("##rows="+rows);
		return SUCCESS;
	}
	
	// 点击添加按妞时触发
	public String load(){
		List<Fa_Cms_Classes> cList=newsDao.getClasses();
		String str="";
		for (int i = 0; i < cList.size(); i++) {
			Fa_Cms_Classes classes=cList.get(i);
			str+="<option value="+classes.getClassid()+">"+classes.getClassname()+"</option>";
		}
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	public String checkd(){
		System.out.println("chek="+del+","+mid);//1,2
		if(request.getParameter("pas").equals("manys")){
			String arr[] = mid.split(",");
			for(int i=0;i<arr.length;i++){
				Fa_Cms_News comt = (Fa_Cms_News) this.newsDao.getNewsById(Fa_Cms_News.class,Integer.parseInt(arr[i]));
				comt.setStatus(2);
				this.newsDao.updNews(comt);
			}
		}else{
			Fa_Cms_News comt = (Fa_Cms_News) this.newsDao.getNewsById(Fa_Cms_News.class,Integer.parseInt(mid));
			comt.setStatus(Integer.parseInt(del));
			this.newsDao.updNews(comt);
		}
		del="修改成功";
		return "check";
	}


}
