package com.fuao.fajxc.action.cms_classes;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.json.annotations.JSON;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.dao.cms_classesdao.ClassesDao;
import com.fuao.fajxc.dao.common.CommonDao;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ClassesAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{
	private static Logger logger = Logger.getLogger(ClassesAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Fa_Cms_Classes classes; // 文章类型
	private List rows=new ArrayList();
	private int total;
	protected int current;
	protected int page;
	protected int row;
	private ClassesDao classdao;
	private String del;
	private int pcid;
	private String mid;
	private static int flags=0;
	

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


	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("HHmmss");
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}
	@JSON(serialize=false)
	public Fa_Cms_Classes getClasses() {
		return classes;
	}
	public void setClasses(Fa_Cms_Classes classes) {
		this.classes = classes;
	}
	public void setClassdao(ClassesDao classdao) {
		this.classdao = classdao;
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

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	/***
	 * 分页显示栏目信息
	 * @return
	 */
	public String splitPagesBySitekey(){
	    System.out.println("分页了。。。");
		
		String sitekey = (String)request.getSession().getServletContext().getAttribute("sitekey");
		if(sitekey == null){
			logger.error("无法获得全局变量-sitekey值 请确认配置文件config/tempconfig.xml存在 且配置了此属性");
		}
		
		
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		
		//String sql = "select getChildClassesLst("+  new Integer(sitekey) + ")";
		String sonIds = classdao.getClassesIdStr(sitekey);
		String andsql = " and classid in("+sonIds+") and classid != "+sitekey;
		total=classdao.countDataByAndsql(andsql);
		System.out.println("pageCount="+total);
		rows=classdao.splitPagesByAndsql(this.getCurrent(),this.row,andsql);
		System.out.println("rows="+this.rows);
	    return SUCCESS;	
	}
	/***
	 * 分页显示栏目信息
	 * @return
	 */
	public String splitPages(){
	    System.out.println("分页了。。。");
		total=classdao.countData();
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		System.out.println("page="+page+"##row="+row);
		rows=classdao.splitPages(this.getCurrent(),this.row);
		System.out.println("rows="+this.rows);
	    return SUCCESS;	
	}
	
	// 点击修改时进入修改
	public String update(){		

		System.out.println("查sdf");
		this.classes=(Fa_Cms_Classes)classdao.getPartById(Fa_Cms_Classes.class, pcid);

		// 绑定会员列表
		int classid = Integer.parseInt( request.getParameter("classid"));
		System.out.println(classid);
		this.classes=(Fa_Cms_Classes)classdao.getPartById(Fa_Cms_Classes.class, classid);
		 System.out.println(this.classes.getClassname());

		return "update";
	}
	
	// 保存添加或修改的数据
	public String addOrUpdate(){
		System.out.println("进入增加或修改");
		// 如果是修改的话那么就把数据库以前的给删除再保存，否直接保存添加数据。
		// 添加
		String mark = request.getParameter("mark");
		logger.info("mark="+mark);
		
		String datestr = StringUtil.formatDate(new Date());
//		String str3 =dateFormat.format(now);
//		Integer num=Integer.parseInt(str3); // 设置当前时间的ID
//		String str= dateFormat2.format(now);// 当前时间
		
		
		classes.setDelflag(0);
		
		if("update".equals(mark)){
			Fa_Cms_Classes c1 = (Fa_Cms_Classes)classdao.getPartById(Fa_Cms_Classes.class, classes.getClassid());
			c1.setClassname(classes.getClassname());
			c1.setDelflag(0);
			c1.setEditdate(datestr);
			c1.setEngname(classes.getEngname());
			c1.setFatherclass(classes.getFatherclass());
			c1.setFatherpath(classes.getFatherpath());
			c1.setIslastest(classes.getIslastest());
			c1.setIsmember(classes.getIsmember());
			c1.setIsout(classes.getIsout());
			c1.setNamedrules(classes.getNamedrules());
			c1.setOutpath(classes.getOutpath());
			c1.setUserid(classes.getUserid());
			c1.setSuperid(classes.getSuperid());
			c1.setSonclass(classes.getSonclass());
			c1.setShowflag(classes.getShowflag());
			classdao.updateClasses(c1);
		}else{
			this.classes.setRegdate(datestr);
			classes.setEditdate(datestr);
			classdao.addClasses(this.classes);
		}
		
		
		try {
			response.setCharacterEncoding("GBK");
			response.getWriter().write("<center>保存成功!");	
			response.setHeader("refresh", "1;URL="+request.getContextPath()+"/cms/papers/titleManage.jsp");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	/***
	 * 根据字段的模糊查询
	 * @return
	 */
	public String select(){	
		
		String sql="from Fa_Cms_Classes where contes like";
		
		return "select";
	}
	
	// 点击添加按妞时触发
	public String addUI(){
		
		// 绑定会员列表
		List<Fa_Cms_Member> userlist=classdao.getMembers();
		request.setAttribute("userlist", userlist);
		return "addui";
	}
	
	// 删除
	public String del(){
		
		System.out.println("dgfsdfsf="+mid);
		String str[]=mid.split(",");
		for (int i = 0; i < str.length; i++) {
		Fa_Cms_Classes fanews=new Fa_Cms_Classes();
		int id=Integer.parseInt(str[i]);
		fanews=(Fa_Cms_Classes)classdao.getPartById(Fa_Cms_Classes.class, id);
		classdao.delClasses(fanews);
		flags=1;
		}
		if(flags==1){
		   this.del="删除成功！";
		}
		return SUCCESS;
	}
	
	// 添加子类型
	public String addChildren (){
		int superid=this.classes.getClassid();
        classdao.addClasses(this.classes);
        
		return "addchildren";
	}
	
	// 切换隐藏，显示
	public String show(){
		int cid=Integer.parseInt(request.getParameter("cid"));
		int state=Integer.parseInt(request.getParameter("state"));
		System.out.println("显示"+cid+"*stat="+state);
		if(state==1){
			classdao.hiddenNews(cid,1);
		}else{
			classdao.hiddenNews(cid,0);
		}
		return "show";
	}
	

}
