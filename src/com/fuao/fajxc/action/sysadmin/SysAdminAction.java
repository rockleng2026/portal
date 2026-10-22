package com.fuao.fajxc.action.sysadmin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.sysadmin.SysadminDAO;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.MD5;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.opensymphony.xwork2.ActionSupport;

public class SysAdminAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	// 对密码进行解密
	MD5 m5=new MD5();
	private HttpServletRequest request;
	private HttpServletResponse response;
	private SysadminDAO admindao;
	private int total;
	protected int current;
	protected int page;
	protected int row;
	private Integer deptid;
	
	public Integer getDeptid() {
		return deptid;
	}

	public void setDeptid(Integer deptid) {
		this.deptid = deptid;
	}
	private List rows=new ArrayList();
	private Fa_Cms_Admin admin;
	
	public Fa_Cms_Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Fa_Cms_Admin admin) {
		this.admin = admin;
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
		return this.current;
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

	public Object getModel() {
		return null;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public void setAdmindao(SysadminDAO admindao) {
		this.admindao = admindao;
	}
	
	/***
	 * 分页显示信息
	 * @return
	 */
	public String splitPages(){
	    System.out.println("分页了。。。");
		total=admindao.countData("select count(*) from fa_cms_admin where flag=0");
		System.out.println("pageCount="+total);
		this.setPage(Integer.parseInt(request.getParameter("page")));
		//页面大小
		this.setRow(Integer.parseInt(request.getParameter("rows")));
		Fa_Cms_Admin cmsadmin =(Fa_Cms_Admin) request.getSession().getAttribute("adminid");
		int adminid=cmsadmin.getUser_id();
		String sql="";
		if(adminid==2){
			sql="from Fa_Cms_Admin where flag=0 and user_id not in(2)";
		}else{
			sql="from Fa_Cms_Admin where flag=0 and user_id not in(2,"+adminid+")";
		}
		System.out.println("page="+page+"##row="+row);
		rows=admindao.splitPages(this.getCurrent(),this.row,sql);
		System.out.println("rows="+this.rows);	
		
//	    return SUCCESS;	
		 return "success";
	}
	/******
	 * 预先加载部门信息
	 * @return
	 */
	public String loadDepts(){
		// 绑定部门
		List<Department> depts=admindao.getDept();
		String str="";
		for (int i = 0; i < depts.size(); i++) {
			Department dept=depts.get(i);
			str+="<option value='"+dept.getId()+"'>"+dept.getName()+"</option>";
		}
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/****
	 * 添加
	 */
	public String addOrUpdate(){
		//System.out.println(this.deptid);
		System.out.println(this.admin.getDepts().getId());
		Date now = new Date();
	    this.admin.setRegdate(now);
	  //  this.admin.getDepts().setId(this.deptid);
	    String userpwd=this.admin.getAdmin_password();
	    userpwd= m5.get3DESEncrypt(userpwd,"mima");//生成密钥
	    this.admin.setAdmin_password(userpwd);
	   if(this.admin.getUser_id()==null){
		   // 添加
		   // 设置是否删除键
		   this.admin.setFlag(0);
		   // 设置注销状态
		   this.admin.setAdmin_status(0);
		   admindao.addAdmin(this.admin);
	   }else{
		   admindao.updateAdmin(admin);
		   //加入判断 如果修改自己的资料 要及时刷新
		   Fa_Cms_Admin adminid =  (Fa_Cms_Admin)request.getSession().getAttribute("adminid");
		   
		   if(adminid.getUser_id().equals(admin.getUser_id())){
			   request.getSession().setAttribute("adminid", admin);
		   }
		   
	   }
	   
		return "cg";
	}
	
	
	/****
	 * 更改个人资料
	 */
	public String updateInfo(){
		//System.out.println(this.deptid);
		System.out.println(this.admin.getDepts().getId());
		Date now = new Date();
	    this.admin.setRegdate(now);
	    
	    String userpwd=this.admin.getAdmin_password();
	    userpwd= m5.get3DESEncrypt(userpwd,"mima");//生成密钥
	    
	    if(this.admin.getUser_id()==null){
		   // 添加
		   // 设置是否删除键
		   this.admin.setFlag(0);
		   // 设置注销状态
		   this.admin.setAdmin_status(0);
		   admindao.addAdmin(this.admin);
	   }else{
		   Fa_Cms_Admin fadmin =  (Fa_Cms_Admin)admindao.getAdminById(Fa_Cms_Admin.class, admin.getUser_id());
		   if(fadmin.getAdmin_password().equals(userpwd)){
			   admin.setAdmin_password(userpwd);
			   admindao.updateAdmin(admin);
			 //加入判断 如果修改自己的资料 要及时刷新
			   Fa_Cms_Admin adminid =  (Fa_Cms_Admin)request.getSession().getAttribute("adminid");
			   
			   if(adminid.getUser_id().equals(admin.getUser_id())){
				   request.getSession().setAttribute("adminid", admin);
			   }
		   }
	   }
	   
		return "cg";
	}
	
	/****
	 * 注销开通用户
	 */
	public String kaiTong(){
		int userid=Integer.parseInt(request.getParameter("userid"));
		int sta=Integer.parseInt(request.getParameter("sta"));
		admindao.updateSta(userid, sta);
		response.setHeader("refresh", "0;URL="+request.getContextPath()+"/cms/papers/sysAdmin.jsp");
		return null;
	}
	/****
	 * 修改密码
	 */
	public String updatePwd(){
		
		Integer userid=admin.getUser_id();
		System.out.println(userid);
		String userpwd=admin.getAdmin_password();
		userpwd= m5.get3DESEncrypt(userpwd,"mima");//生成密钥
		System.out.println(this.deptid);
		this.admin.setAdmin_password(userpwd);
		this.admin.getDepts().setId(this.deptid);
//		Fa_Cms_Admin sysadmin=(Fa_Cms_Admin)admindao.getAdminById(Fa_Cms_Admin.class, userid);
//		sysadmin.setAdmin_password(userpwd);
		admindao.updateAdminPassword(this.admin);
		 
		return "cg";
	}
	/****
	 * 密码验证
	 */
	public String checkPwd(){
		String oldpwd=request.getParameter("oldpwd");
		oldpwd= m5.get3DESEncrypt(oldpwd,"mima");//生成密钥
		int userid=Integer.parseInt(request.getParameter("userid"));
		this.admin=(Fa_Cms_Admin)admindao.getAdminById(Fa_Cms_Admin.class, userid);
		try {
			if(!this.admin.getAdmin_password().equals(oldpwd)){
				response.setCharacterEncoding("GBK");
				response.getWriter().write("0");	
			}else{
				response.getWriter().write("1");
			}
			
		} catch (Exception e) {
		}
		return null;
	}
	
	/**
	 * 系统退出
	 * @return
	 */
	public String safetyExit()
	{
		this.admin=null;
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
		
		request.getSession().invalidate();
		Cookies cook = new Cookies();
		cook.putCookie(response, "loginName", "");
		cook.putCookie(response, "password", "");
		return "safetyexit";
	}
}
