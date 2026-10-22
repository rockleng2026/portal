package com.fuao.fajxc.action.project;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.project.ProjectDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Project;
import com.fuao.fajxc.vo.ProjectEmp;
import com.fuao.fajxc.vo.ProjectEmpLead;
import com.fuao.fajxc.vo.ProjectLead;
import com.opensymphony.xwork2.ActionSupport;

public class ProjectAction extends ActionSupport  implements ServletRequestAware,ServletResponseAware{
	private static Logger  logger = Logger.getLogger(ProjectAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ProjectDao prjdao;

	private List deptlist;

	private Project project;
	private ProjectEmp prjemp;
	private ProjectEmp pe;
	private Message message;
	private Employee employee;
	private Project project1;
	private Project project2;
	private Project project3;
	//上传
	private File upload;
	private String uploadFileName;
	//下载
	private InputStream inputStream; //获取下载文件输流
	private String downFileName; //下载文件名
	private Integer downid;
	// 获取所有参与人的ID
	private String cyrid;    
	
	public String getCyrid() {
		return cyrid;
	}

	public void setCyrid(String cyrid) {
		this.cyrid = cyrid;
	}

	public ProjectEmp getPrjemp() {
		return prjemp;
	}

	public void setPrjemp(ProjectEmp prjemp) {
		this.prjemp = prjemp;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public ProjectDao getPrjdao() {
		return prjdao;
	}

	public void setPrjdao(ProjectDao prjdao) {
		this.prjdao = prjdao;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	
	public List getDeptlist() {
		return deptlist;
	}

	public void setDeptlist(List deptlist) {
		this.deptlist = deptlist;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
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

	public Message getMessage() {
		return message;
	}

	public void setMessage(Message message) {
		this.message = message;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getDownFileName() {
		return downFileName;
	}

	public void setDownFileName(String downFileName) {
		this.downFileName = downFileName;
	}

	public Integer getDownid() {
		return downid;
	}

	public void setDownid(Integer downid) {
		this.downid = downid;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public ProjectEmp getPe() {
		return pe;
	}

	public void setPe(ProjectEmp pe) {
		this.pe = pe;
	}

	public Project getProject1() {
		return project1;
	}

	public void setProject1(Project project1) {
		this.project1 = project1;
	}

	public Project getProject2() {
		return project2;
	}

	public void setProject2(Project project2) {
		this.project2 = project2;
	}

	public Project getProject3() {
		return project3;
	}

	public void setProject3(Project project3) {
		this.project3 = project3;
	}

	/*****
	 * 得到所有的项目列表数据
	 */
	public String getAll(){
		//logger.info("getAll()--1");
		String dpage=request.getParameter("pageNo");
		int pageNo=0;
		if(null == dpage){
			pageNo=1;
		}else{
			pageNo=Integer.parseInt(dpage);
		}
		String hql="from Project WHERE isapproval=0 AND delflag=0";
		Pages pages=prjdao.getAllPrj(hql, pageNo, 20, null);
		
		for(int i=0;i<pages.getPageList().size();i++){
			Project p= (Project)pages.getPageList().get(i);
			// 根据部门ID设置部门信息
			Department dept=prjdao.getdeptById(p.getDeptid());
			p.setDept(dept);
			pages.getPageList().set(i, p);
			System.out.println(p.getDept().getName());
		}
		request.setAttribute("prjlist", pages.getPageList());
		request.setAttribute("pages", pages);
		//logger.info("getAll()--2");
		
		String logName = (String)request.getSession().getAttribute("loginName");
		System.out.println(logName);
		//根据当前登陆者名称查询其信息
		employee = prjdao.getEmployeeByEmpNo(logName);
		pe = (ProjectEmp)prjdao.getProjectEmpByEmpid(employee.getId());
		//logger.info("getAll()--3");
		//是否为项目负责人
		project1 = prjdao.getPrjByManager(employee.getName());
		//是否为领导
		project2 = prjdao.getPrjByLeadname(employee.getName());
		//是否为发起人
		project3 = prjdao.getPrjByStartperson(employee.getName());
		//logger.info("getAll()--4");
		return "prjlist";
	}
	
	/**
	 * 得到所有部门
	 */
	public String depts(){
		deptlist = prjdao.getAllDept("from Department where 1 = 1");
		System.out.println(deptlist.size());
		return "startprj";
	}
	
	/**
	 * 准备发起项目
	 * @return
	 */
	public String start() throws Exception{
	
		project.setPrjplan(0);
		project.setLeadevaluate("");
		project.setDelflag(0);
		project.setDeptid(project.getDept().getId());
		project.setIsapproval(0);
		
		//在这里添加附件
		if(upload!=null && uploadFileName!=null){
			FileInputStream fis = new FileInputStream(upload);
			
				String filedesc = request.getSession().getServletContext().getRealPath("/")+"userfiles/"+uploadFileName;
				System.out.println(request.getSession().getServletContext().getRealPath("/")+"userfiles/");
				System.out.println("要上传的文件:"+filedesc);
				FileOutputStream fos = new FileOutputStream(filedesc);
				byte[] buffer = new byte[1024];
				int len=0;
				while((len=fis.read(buffer))!=-1){
					fos.write(buffer,0,len);
				}
				fos.close();
				fis.close();
				project.setAnnex(uploadFileName);
		     }	
				
				prjdao.savePrj(project); //项目发起完毕
		
		String cyids = request.getParameter("cyr");
		String newcyid = cyids.replace("||", ",");//把||替换成,
		newcyid= newcyid.substring(1, newcyid.length()-1);//截取|
		String[] p = newcyid.split(","); // |属于转义字符,用拆分时用\\隔开
		System.out.println(p.toString());
		String str="";
		String sql = "";
		for(int i=0;i<p.length;i++){
			ProjectEmp premp = new ProjectEmp();
			Employee employee=(Employee)prjdao.getPrjById(Employee.class, Integer.parseInt(p[i]));
			premp.setEmployee(employee);
			premp.setPrj(project);
		//	premp.getPrj().setId(project.getId());
			premp.setPrjbegintime(new Date());
			premp.setPrjempplan(0);
			premp.setPrjvitetime(new Date());
			prjdao.savePrjEmp(premp);
		}
		return "add";
	}
	
	
	
	/*******
	 * 根据项目编号得到项目详细信息
	 */
	public String getInfo(){
		int id=Integer.parseInt(request.getParameter("id"));
		String flag=request.getParameter("flag");
		this.project = (Project)this.prjdao.getPrjById(Project.class, id);
		// 得到参与人集合　
		List<Map<String, String>> emplist=prjdao.getEmpByPrjid(this.project.getId());
		/**
		 * 查询列表
		 */
		String dpage=request.getParameter("pageNo");
		int pageNo=0;
		if(null == dpage){
			pageNo=1;
		}else{
			pageNo=Integer.parseInt(dpage);
		}
		String hql="from Project WHERE isapproval=0 AND delflag=0";
		Pages pages=prjdao.getAllPrj(hql, pageNo, 20, null);
		for(int i=0;i<pages.getPageList().size();i++){
			Project p= (Project)pages.getPageList().get(i);
			// 根据部门ID设置部门信息
			Department dept=prjdao.getdeptById(p.getDeptid());
			p.setDept(dept);
			System.out.println(p.getDept().getName());
		}
		
		request.setAttribute("prjlist", pages.getPageList());
		request.setAttribute("pages", pages);
		
		request.setAttribute("emplist", emplist);
		request.setAttribute("prj", this.project);
		request.setAttribute("flag", flag);
		return "prjlist";
	}
	
	/**********
	 * 跟进项目
	 */
	public String update(){
		System.out.println(this.cyrid);
		System.out.println(this.project.getPrjplan());
		this.cyrid=this.cyrid.replace("||", ",");
		if(this.cyrid.trim().length()>0){
			this.cyrid=this.cyrid.substring(1, (this.cyrid.length()-1));
			String[] arr=this.cyrid.split(",");
			for(int i=0;i<arr.length;i++){
				int empid=Integer.parseInt(arr[i]);
				// 根据员工编号得到对象，并一一添加到员工任务表里
				Employee emp=(Employee)this.prjdao.getPrjById(Employee.class, empid);
				ProjectEmp p=new ProjectEmp();
				p.setEmployee(emp);
				p.setPrj(project);
				
				p.setIsinvite(1);
				p.setPrjvitetime(new Date());
				// 保存员工任务
				prjdao.savePrjEmp(p);
			}
		}
		// 获得当前登录的领导
		String empno=request.getSession().getAttribute("loginName").toString();
		Employee leadname=prjdao.getEmp(empno);
		// 添加领导列表
		if(this.project.getLeadevaluate().trim().length()>0){
			ProjectLead prjlead=new ProjectLead();
			prjlead.setPrj(this.project);
			prjlead.setPjtime(new Date());
			prjlead.setLeadevaluate(this.project.getLeadevaluate());
			prjlead.setLeadname(leadname.getName());
			// 判断当前登录的是不是项目负责人
			if(this.project.getPrjmanager().equals(leadname.getName())){
				// 修改项目的进度
				prjdao.updatePrj(this.project);// 修改项目管理进度				
			}else{
				prjdao.leadGj(prjlead);
				this.project.setLeadname(leadname.getName());
			}
		}else{
			// 修改项目的进度
			prjdao.updatePrj(this.project);// 修改项目管理进度	
		}
		return getAll();
	}
	
	/*******
	 * 点击项目跟进时弹出并显示数据
	 */
	public String updateUI(){
		int id=Integer.parseInt(request.getParameter("id"));
		String flag=request.getParameter("flag");
		this.project = (Project)this.prjdao.getPrjById(Project.class, id);
		// 得到参与人集合　
		List<Map<String, String>> emplist=prjdao.getEmpByPrjid(this.project.getId());
		/**
		 * 查询列表
		 */
		String dpage=request.getParameter("pageNo");
		int pageNo=0;
		if(null == dpage){
			pageNo=1;
		}else{
			pageNo=Integer.parseInt(dpage);
		}
		String hql="from Project WHERE isapproval=0 AND delflag=0";
		Pages pages=prjdao.getAllPrj(hql, pageNo, 20, null);
		request.setAttribute("prjlist", pages.getPageList());
		request.setAttribute("pages", pages);
		
		request.setAttribute("flag", flag);
		request.setAttribute("emplist", emplist);
		request.setAttribute("prjgj", this.project);
		return "prjlist";
	}
	
	/******
	 * 根据员工编号获取员工进度条显示
	 */
	public String empPlan(){
		Integer empid=Integer.parseInt(request.getParameter("empid"));
		ProjectEmp prjemp= prjdao.empPlan(empid);
		System.out.println(prjemp.getPrjempplan());
		String str="";
		int count=0;
		for(int i=1;i<=prjemp.getPrjempplan();i++){
			count=i*10;
		}
		str+="<div style='background-image: url("+request.getContextPath()+"/img/jindutiao.jpg); width:"+count+"%; height:15px;  display: block></div>";
		try {
			response.setCharacterEncoding("GBK");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*******
	 * 根据员工编号获取员工信息
	 */
	public String empinfo(){
		Integer empid=Integer.parseInt(request.getParameter("empid"));
		this.prjemp= prjdao.empPlan(empid);
		Employee emp=(Employee)prjdao.getPrjById(Employee.class, empid);
		this.prjemp.setEmployee(emp);
		this.prjemp.setPrj(this.project);
		System.out.println(this.prjemp.getPrj().getPrjname());
		System.out.println(this.prjemp.getPrjempplan());
		// 获得部门名称
		String dname=this.prjemp.getEmployee().getDepartment().getName();
		request.setAttribute("dname", dname);
		return "empinfo";
	}
	
	/****
	 * 在移交任务页面,点击提交,想prjemp表,message表写入数据
	 * @return
	 */
	public String commitMission(){
		System.out.println(this.prjemp.getEmployee().getId());
		System.out.println(prjemp.getWarn());
		System.out.println(this.prjemp);
		
		// 添加领导评价表的数据
		if(this.prjemp.getLeadname()!=null||this.prjemp.getLeadname().trim().length()>0){
			ProjectEmpLead emplead=new ProjectEmpLead();
			emplead.setLeadname(this.prjemp.getLeadname());
			emplead.setLeadevaluate(this.prjemp.getLeadevaluate());
			emplead.setPrjemp(prjemp);
			emplead.setPjtime(new Date());
			prjdao.addEmpLead(emplead);
		}
		prjdao.updateMission(prjemp);
		return "update";
	}
	
	/**
	 * 下载附件
	 * @return
	 */
	public String downFile() throws Exception{
		project = (Project)prjdao.getPrjById(Project.class, downid);
		
		
		String dfile = request.getSession().getServletContext().getRealPath("/")+"userfiles/"+downFileName;
		inputStream = new FileInputStream(new File(dfile));
		return null;
	}
	
	
	//修改项目进度条的显示
	public String planShow(){
		Integer num=Integer.parseInt(request.getParameter("num"));
		System.out.println(num);
		
		String str="";
		for(int i=0;i<num;i++){
			if(i==0){
				str+="<img src="+request.getContextPath()+"/img/bluejdt.jpg width=10px; height=15px; style=margin-left: 0px;></img>";
			}else{
				str+="<img src="+request.getContextPath()+"/img/bluejdt.jpg width=10px; height=15px; style=margin-left: -4px;></img>";
			}
		}
		str+="<span style='color:red;'>"+num*10+"%</span>";
		try {
			response.setCharacterEncoding("GBK");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	

	// 得到所有的详细信息
	public String getAllInfo(){
		int prjid=Integer.parseInt(request.getParameter("id"));
		this.project=(Project)prjdao.getPrjById(Project.class, prjid);
		Department dept=prjdao.getdeptById(this.project.getDeptid());
		this.project.setDept(dept);
		// 得到这个下的所有人员与人员对应的工作任务
		List<ProjectEmp> prjemplist=prjdao.prjEmp(this.project.getId());
		request.setAttribute("prjemplist", prjemplist);
		
		// 得到此项目中的所有领导评价信息
		List<ProjectLead> leadlist=prjdao.leadPJByPrjid(this.project.getId());
		
		//加载最近项目更进数据，获取所有项目更进的时间
//		List<ProjectEmp> alluplist= prjdao.updatePrjmsg("prjuptime",prjid);
		List<ProjectEmp> uplist= prjdao.updatePrjmsg("prjuptime",prjid);
		List<ProjectEmp> vitelist= prjdao.updatePrjmsg("prjvitetime",prjid);
		
		// 得到当前登陆人的项目动态信息，一周内动态
		String empno=request.getSession().getAttribute("loginName").toString();
		Employee leadname=prjdao.getEmp(empno);
		List<ProjectEmp> mylist=prjdao.proempByPidAndEid(leadname.getId(), prjid);
	    // 得到所有领导对我的评价
		String str="";
		List<ProjectEmpLead> emplist= new ArrayList<ProjectEmpLead>();
		for(int i=0;i<mylist.size();i++){
			int prjempid= mylist.get(i).getId();
			emplist= prjdao.leadPJByEmpid(prjempid);
		}
		for(int i=0;i<emplist.size();i++){
			str+="，评价"+(i+1)+":"+ emplist.get(i).getLeadevaluate();
		}
		str= str.replaceAll("，", "");
		
		request.setAttribute("leadpj", str);
		request.setAttribute("mylist",mylist);
		request.setAttribute("uplist", uplist);
		request.setAttribute("vitelist", vitelist);
		request.setAttribute("leadlist", leadlist);
		return "prjprocess";
	}
	
	// 获取领导最新动态信息
	public String leadMsg(){
		prjdao.getLeadMsg("");
		return null;
	}
	
	
	// 得到详细信息的员工任务
	public String processInfo(){
		int id=Integer.parseInt(request.getParameter("id"));
		System.out.println(id);
		this.prjemp=(ProjectEmp)prjdao.getPrjById(ProjectEmp.class, id);
		// 得到员工任务编号找到领导的评价
		List<ProjectEmpLead> empleadlist=prjdao.leadPJByEmpid(this.prjemp.getId());
		String str="";
		if(this.prjemp!=null){
			str+="<table class='toptable grid' cellSpacing=1 cellPadding=4 align=center border=1><tr><th width='25%'>领导</th>" +
					"<th width='50%'>评价</th><th width='25%'>评价时间</th></tr>";
			if(empleadlist.size()<=0){
				str+="<tr><td align=center  width='100%' colspan=3>暂时没有领导给评价</td></tr>";
			}if(empleadlist!=null&&empleadlist.size()>0){
				for(int i=0;i<empleadlist.size();i++){
				    str+="<tr><td align=center>"+empleadlist.get(i).getLeadname()+"</td><td align=left>"+empleadlist.get(i).getLeadevaluate()+"</td><td align=left>"+empleadlist.get(i).getPjtime()+"</td></tr>";
				}
			}			
			str+="<tr><td align=center>警告状态：</td><td width='70%' colspan=2>"; 
					if(this.prjemp.getWarn()==0){
						str+="<img src="+request.getContextPath()+"/img/green.gif></img>";
					}else if(this.prjemp.getWarn()==1){
						str+="<img src="+request.getContextPath()+"/img/yellow.gif></img>";
					}else if(this.prjemp.getWarn()==2){
						str+="<img src="+request.getContextPath()+"/img/red.gif></img>";
					}
		    str+="</td><tr><td align=center>任务描述：</td><td width='70%'  colspan=3>";
		    if(this.prjemp.getJobdes()!=null){
		    	str+=this.prjemp.getJobdes();
		    }else if(this.prjemp.getJobdes()==null){
		    	str+="暂时没有分配任务！";
		    }
		    str+="</td></tr></table>";
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 根据前台传过来的时间查询
	public String processByTime(){
		String zd=request.getParameter("zd");		
		int prjid=Integer.parseInt(request.getParameter("prjid"));
		String prjuptime=request.getParameter("time"); // prjuptime项目最新动态
		String yue=request.getParameter("yue");
		List<ProjectEmp> prjlist= null;
		if(prjuptime!=null&&prjuptime.trim().length()>0){
			prjlist= prjdao.getProcessByTime(zd, prjid, prjuptime);   
		}else{
			prjlist= prjdao.getProcessByYue(zd, prjid, yue);   
		}
		int len=0;
		if(prjlist.size()>4){
			len=4;
		}else{
			len=prjlist.size();
		}
		String str="";
		if(zd.equals("prjuptime")){
			for(int i=0;i<len;i++){
				ProjectEmp proemp=prjlist.get(i);
				str+="<li  class='DetailLine'><div class='DetailLineInfo'><img src='"+request.getContextPath()+"/images/desk/list.gif' border='0' height='8' width=8>";
				str+="<a href='#'>"+(i+1)+":"+proemp.getEmployee().getName()+"</a></div><div  class='DetailLineName'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				
				str+=proemp.getPrjuptime()+"更新了项目"+proemp.getPrj().getPrjname()+"，项目进度：<font color='red'>"+proemp.getPrjempplan()*10+"%</font>";
				str+="领导评价： <font color=blue>"+proemp.getLeadevaluate()+"</font></div></li>";
			}
		}
		if(zd.equals("prjvitetime")){
			for(int i=0;i<len;i++){
				ProjectEmp proemp=prjlist.get(i);
				str+="<li  class='DetailLine'><div class='DetailLineInfo'><img src='"+request.getContextPath()+"/images/desk/list.gif' border='0' height='8' width=8>";
				str+="<a href='#'>"+(i+1)+":"+proemp.getPrj().getPrjname()+"</a></div><div  class='DetailLineName'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				str+=proemp.getPrjvitetime()+"   "+proemp.getPrj().getPrjmanager()+"邀请了"+proemp.getEmployee().getName()+"参与此项目，邀请原因："+proemp.getInvite();
				str+="</div></li>";
			}
		}if(zd.equals("lead")){ //领导最新动态
			
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	// 查询年动态
	public String processByYear(){
		String zd=request.getParameter("zd");		
		int prjid=Integer.parseInt(request.getParameter("prjid"));
		List<ProjectEmp> prjlist= prjdao.getProcessByYear(zd, prjid);
		String str="";
		int len=0;
		if(prjlist.size()>4){
			len=4;
		}else{
			len=prjlist.size();
		}
		if(zd.equals("prjuptime")){
			for(int i=0;i<len;i++){
				ProjectEmp proemp=prjlist.get(i);
				str+="<li  class='DetailLine'><div class='DetailLineInfo'><img src='"+request.getContextPath()+"/images/desk/list.gif' border='0' height='8' width=8>";
				str+="<a href='#'>"+(i+1)+":"+proemp.getEmployee().getName()+"</a></div><div  class='DetailLineName'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				str+=proemp.getPrjuptime()+"更新了项目"+proemp.getPrj().getPrjname()+"，项目进度：<font color='red'>"+proemp.getPrjempplan()*10+"%</font>";
				str+="领导评价： <font color=blue>"+proemp.getLeadevaluate()+"</font></div></li>";
			}
		}
		if(zd.equals("prjvitetime")){
			for(int i=0;i<len;i++){
				ProjectEmp proemp=prjlist.get(i);
				str+="<li  class='DetailLine'><div class='DetailLineInfo'><img src='"+request.getContextPath()+"/images/desk/list.gif' border='0' height='8' width=8>";
				str+="<a href='#'>"+(i+1)+":"+proemp.getPrj().getPrjname()+"</a></div><div  class='DetailLineName'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				str+=proemp.getPrjvitetime()+"   "+proemp.getPrj().getPrjmanager()+"邀请了"+proemp.getEmployee().getName()+"参与此项目，邀请原因："+proemp.getInvite();
				str+="</div></li>";
			}
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	// 添加领导评价，对人员任务评价
	public String addLeadPj(){
		String empno=request.getSession().getAttribute("loginName").toString();
		Employee leadname=prjdao.getEmp(empno);
		int prjempid=Integer.parseInt(request.getParameter("prjempid"));
		ProjectEmp empprj=(ProjectEmp)prjdao.getPrjById(ProjectEmp.class, prjempid);
		String content=request.getParameter("content");
		try {
			content= URLDecoder.decode(content,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		ProjectEmpLead emplead=new ProjectEmpLead();
		emplead.setPrjemp(empprj);
		emplead.setLeadevaluate(content);
		Date now = new Date();
		emplead.setPjtime(now);
		emplead.setLeadname(leadname.getName());
		prjdao.addEmpLead(emplead);
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("");
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return null;
	}
	
	// 领导对项目的跟进
	public String leadGj(){
		String empno=request.getSession().getAttribute("loginName").toString();
		Employee leadname=prjdao.getEmp(empno);
		int prjid=Integer.parseInt(request.getParameter("prjid"));
		Project prj=(Project)prjdao.getPrjById(Project.class, prjid);
		ProjectLead prjlead=new ProjectLead();
		prjlead.setLeadname(leadname.getName());
		prjlead.setPjtime(new Date());
		prjlead.setPrj(prj);
		prjdao.leadGj(prjlead);
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("");
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return null;
	}
	
	// 我的地盘，选择时间时查询
	public String myprocessByTime(){
		
		String empno=request.getSession().getAttribute("loginName").toString();
		Employee leadname=prjdao.getEmp(empno);		
		int prjid=Integer.parseInt(request.getParameter("prjid"));
		String prjuptime=request.getParameter("time"); // prjuptime项目最新动态
		String yue=request.getParameter("yue"); // prjuptime项目最新动态
		List<ProjectEmp> mylist = new ArrayList<ProjectEmp>();
		if(prjuptime!=null){
			mylist=prjdao.proempByTime(leadname.getId(), prjid,prjuptime);
		}else{
			mylist=prjdao.myProcessByYue(leadname.getId(), prjid,yue);
		}
		String str="";
		String pjstr="";
		List<ProjectEmpLead> emplist= new ArrayList<ProjectEmpLead>();
		for(int i=0;i<mylist.size();i++){
			int prjempid= mylist.get(i).getId();
			emplist= prjdao.leadPJByEmpid(prjempid);
		}
		for(int i=0;i<emplist.size();i++){
			pjstr+="领导评价"+(i+1)+":"+ emplist.get(i).getLeadevaluate();
		}
		int len=0;
		if(mylist.size()>4){
			len=4;
		}else{
			len=mylist.size();
		}
		for(int i=0;i<len;i++){
			ProjectEmp proemp=mylist.get(i);
			str+="<li  class='DetailLine'><div class='DetailLineInfo'><img src='"+request.getContextPath()+"/images/desk/list.gif' border='0' height='8' width=8>";
			str+="<a href='#'>"+(i+1)+":"+proemp.getPrj().getPrjname()+"</a></div><div  class='DetailLineName'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			str+=proemp.getPrjuptime()+"提交了项目，我的任务进度：<font color=red>"+proemp.getPrjempplan()*10+"%</font>。<font color='blue'>"+pjstr+"</font>";
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return null;
	}
	
	// 查询我的年动态
	public String myprocessByYear(){
		String empno=request.getSession().getAttribute("loginName").toString();
		Employee leadname=prjdao.getEmp(empno);		
		int prjid=Integer.parseInt(request.getParameter("prjid"));
		List<ProjectEmp> mylist = prjdao.getmyProcessByYear(leadname.getId(), prjid);
		String str="";
		String pjstr="";
		List<ProjectEmpLead> emplist= new ArrayList<ProjectEmpLead>();
		for(int i=0;i<mylist.size();i++){
			int prjempid= mylist.get(i).getId();
			emplist= prjdao.leadPJByEmpid(prjempid);
		}
		for(int i=0;i<emplist.size();i++){
			pjstr+="领导评价"+(i+1)+":"+ emplist.get(i).getLeadevaluate();
		}
		int len=0;
		if(mylist.size()>4){
			len=4;
		}else{
			len=mylist.size();
		}
		for(int i=0;i<len;i++){
			ProjectEmp proemp=mylist.get(i);
			str+="<li  class='DetailLine'><div class='DetailLineInfo'><img src='"+request.getContextPath()+"/images/desk/list.gif' border='0' height='8' width=8>";
			str+="<a href='#'>"+(i+1)+":"+proemp.getPrj().getPrjname()+"</a></div><div  class='DetailLineName'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			str+=proemp.getPrjuptime()+"提交了项目，我的任务进度：<font color=red>"+proemp.getPrjempplan()*10+"%</font>。<font color='blue'>"+pjstr+"</font>";
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}	
		
		return null;
	}
	

}
