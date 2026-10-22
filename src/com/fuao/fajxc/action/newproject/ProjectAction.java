package com.fuao.fajxc.action.newproject;

/*******
 * 我的项目Action
 */
import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dom4j.Document;
import org.dom4j.Element;

import com.fuao.fajxc.dao.LoginDao;
import com.fuao.fajxc.dao.impl.LoginDaoImpl;
import com.fuao.fajxc.dao.newproject.Project;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.utilinterface.Dom4jUtil;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Messagetype;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.NewDocument;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewPrjdept;
import com.fuao.fajxc.vo.NewPrjtresource;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.NewWatch;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ProjectAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	private static Logger  logger = Logger.getLogger(ProjectAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Project projectdao;// 项目列表dao
	private LoginDao loginDao;// 登陆DAO
	
	private NewProject project; 
	private NewApprove approve;
	private NewPrjdept prjdept;
	private NewParticipator cyr;
	private NewWatch watcher;
	private NewDocument document;
	private List projectlist;
	private List projectlist2;
	private List sellist;
	private List deptlist;
	private List emplist;
	private List approverlist;
	private List typelist;
	private Integer id;
	private Integer pid; //删除时 用于接收页面传过来的项目ID
	private String cm2; //修改时,用来接收页面传过来的部门ID字符串
	private String ck2; //修改时,用来接收页面传过来的员工ID字符串
	private String cy2; //修改时,用了接收页面传过来的员工ID字符串
	private String type; //修改时,用来接收页面传过来的类型
	private String app; //修改时,用来接收页面传到的审批人ID
	private Integer proid; //点击项目详细信息传过来项目ID
	private String empnum; //当前登陆者的员工编号empNo
	private int isapprove; //是否提交审批
	private String lxcyr; //立项时,接收参与人字符串
	private int messpid;  //办理的时候,把receiver表的pid传过来
	private int messpid2;  //点击拒绝的时候,把receiver表的pid传过来
	private Employee employee; //权限设置,列表页面取到当前登陆人
	//修改2
	private String cybm2;
	private String ckz2;
	private String begintime;
	private String endtime;
	private String projecttype;
	private int approver;
	//查询
	private String pname;//项目名称
	private Integer state; //状态
	private String btime; //开始时间
	private String etime; //结束时间
	//上传
	private File upload;
	private String uploadFileName;
	
	private String empid;
	private String projectid;
	
	public Project getProjectdao() {
		return projectdao;
	}
	public void setProjectdao(Project projectdao) {
		this.projectdao = projectdao;
	}	
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public List getProjectlist() {
		return projectlist;
	}
	public void setProjectlist(List projectlist) {
		this.projectlist = projectlist;
	}
	public List getDeptlist() {
		return deptlist;
	}
	public void setDeptlist(List deptlist) {
		this.deptlist = deptlist;
	}
	public List getEmplist() {
		return emplist;
	}
	public void setEmplist(List emplist) {
		this.emplist = emplist;
	}	
	public NewProject getProject() {
		return project;
	}
	public void setProject(NewProject project) {
		this.project = project;
	}	
	public NewPrjdept getPrjdept() {
		return prjdept;
	}
	public void setPrjdept(NewPrjdept prjdept) {
		this.prjdept = prjdept;
	}
	public NewParticipator getCyr() {
		return cyr;
	}
	public void setCyr(NewParticipator cyr) {
		this.cyr = cyr;
	}	
	public List getApproverlist() {
		return approverlist;
	}
	public void setApproverlist(List approverlist) {
		this.approverlist = approverlist;
	}
	public List getTypelist() {
		return typelist;
	}
	public void setTypelist(List typelist) {
		this.typelist = typelist;
	}	
	public NewWatch getWatcher() {
		return watcher;
	}
	public void setWatcher(NewWatch watcher) {
		this.watcher = watcher;
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
	public NewDocument getDocument() {
		return document;
	}
	public void setDocument(NewDocument document) {
		this.document = document;
	}		
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getBtime() {
		return btime;
	}
	public void setBtime(String btime) {
		this.btime = btime;
	}
	public String getEtime() {
		return etime;
	}
	public void setEtime(String etime) {
		this.etime = etime;
	}
	public List getProjectlist2() {
		return projectlist2;
	}
	public void setProjectlist2(List projectlist2) {
		this.projectlist2 = projectlist2;
	}
	public String getCm2() {
		return cm2;
	}
	public void setCm2(String cm2) {
		this.cm2 = cm2;
	}
	public String getCk2() {
		return ck2;
	}
	public void setCk2(String ck2) {
		this.ck2 = ck2;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getApp() {
		return app;
	}
	public void setApp(String app) {
		this.app = app;
	}	
	public NewApprove getApprove() {
		return approve;
	}
	public void setApprove(NewApprove approve) {
		this.approve = approve;
	}	
	public Integer getProid() {
		return proid;
	}
	public void setProid(Integer proid) {
		this.proid = proid;
	}	
	public String getCy2() {
		return cy2;
	}
	public void setCy2(String cy2) {
		this.cy2 = cy2;
	}
	public List getSellist() {
		return sellist;
	}
	public void setSellist(List sellist) {
		this.sellist = sellist;
	}
	public String getEmpnum() {
		return empnum;
	}
	public void setEmpnum(String empnum) {
		this.empnum = empnum;
	}
	public int getIsapprove() {
		return isapprove;
	}
	public void setIsapprove(int isapprove) {
		this.isapprove = isapprove;
	}
	public String getLxcyr() {
		return lxcyr;
	}
	public void setLxcyr(String lxcyr) {
		this.lxcyr = lxcyr;
	}
	public int getMesspid() {
		return messpid;
	}
	public void setMesspid(int messpid) {
		this.messpid = messpid;
	}
	public int getMesspid2() {
		return messpid2;
	}
	public void setMesspid2(int messpid2) {
		this.messpid2 = messpid2;
	}
	public String getCybm2() {
		return cybm2;
	}
	public void setCybm2(String cybm2) {
		this.cybm2 = cybm2;
	}
	public String getCkz2() {
		return ckz2;
	}
	public void setCkz2(String ckz2) {
		this.ckz2 = ckz2;
	}
	public String getBegintime() {
		return begintime;
	}
	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getProjecttype() {
		return projecttype;
	}
	public void setProjecttype(String projecttype) {
		this.projecttype = projecttype;
	}
	public int getApprover() {
		return approver;
	}
	public void setApprover(int approver) {
		this.approver = approver;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public String getProjectid() {
		return projectid;
	}
	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}
	
	private static  StringBuffer x;
	 String str1="";
	 public String selemp1(String deptid){
		 
		 int dept=Integer.parseInt(deptid);
		 String hql="FROM Department where delflag=0 and  parentId="+deptid+"order by squnum";
		 List dlist = projectdao.execHQL(hql);
		 List<Department> list1=dlist;
		 String a="";
		 int y=dlist.size();
		 System.out.println(y);
		 if(y>0){
			
		 for (int i = 0; i < list1.size(); i++) {
			 String ss="|";
			Object o=list1.get(i).getId();
			Integer o1=list1.get(i).getIslevel();
			a=o.toString();
			String b=o1.toString();
			for (int j = 0; j < o1-2; j++) {
				ss=ss+"--";
			}
		
			//str1=str1+"<br>"+ss+"<input type='checkbox' id='sel' onclick='sel(this)'  name='sel' value='"+list1.get(i).getId()+"'>"+list1.get(i).getName()+"<br>";
			str1+="<tr><td style='border-color: white;'>"+ss+"<input type='checkbox' id='"+list1.get(i).getId()+"' value='"+list1.get(i).getName()+"' onclick='checkDept(this)'/>"+list1.get(i).getName()+"</td></tr>";
			
			System.out.println(a);
			 if(list1.size()>0){
				 selemp1(a);
				 System.out.println(x);
			 }
		 }}
	
		 System.out.println(str1);
		
	
			return str1;
		 
		 	 
		 	
		 }
	/**
	 * 部门列表
	 * @return
	 */
	public String deptlist() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		str1=new String();
		 String str2=selemp1("28");
		
		deptlist = projectdao.getAllDepts("from Department where id not in(0,1)");
		System.out.println(deptlist.size());
		String str = "";
		for(int i=0;i<deptlist.size();i++){
			Department dept = (Department)deptlist.get(i);
			String Str="|";
			if(dept.getIslevel()!=null){
			for(int j=1;j<dept.getIslevel();j++){
				
				Str+="-";
			}}
			str+="<tr><td style='border-color: white;'>"+Str+"<input type='checkbox' id='"+dept.getId()+"' value='"+dept.getName()+"' onclick='checkDept(this)'/>"+dept.getName()+"</td></tr>";
		}
		System.out.println("部门:"+str);
		out.print(str2);
		return null;
	}
	
	/**
	 * 员工列表
	 * @return
	 */
	public String emplist() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		emplist = projectdao.getAllEmps("from Employee where isLeave=1 and delflag=0");
		String str = "";
		for(int i=0;i<emplist.size();i++){
			Employee emp = (Employee)emplist.get(i);
			str+="<tr><td><input type='checkbox' id="+emp.getId()+" value='"+emp.getName()+"' onclick='checkEmp(this)'/>"+emp.getName()+"</td></tr>";
		}
		out.print(str);
		return null;
	}
	
	/**
	 * 立项时,添加参与人,列出所有人员
	 * @author 袁天龙  2012-11-16
	 * @return
	 * @throws Exception
	 */
	public String emplistlx() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String deptid = request.getParameter("deptid");
		String cyrid = request.getParameter("cyrid");
		String[] arrcyr=cyrid.split(",");
		String name = "";
		
		if(!"".equals(deptid)){
			String tstString = deptid.substring(0, deptid.length()-1);
			
			//改变需求,参与人只列出所选中部门的主管
//			String hql = "from Department where id in ('"+deptid+"')";
//			List<Department> list = projectdao.getAllDepts(hql);
//			for(int i=0;i<list.size();i++){
//				Department dept = list.get(i);
//				name = dept.getEmployee().getName();
//			}
			
			String hql = "from Employee where department.id in ("+tstString+") and delflag = 0 and isLeave=1";
			deptlist = projectdao.getAllDepts(hql);
			
			String str = "";
			for(int i=0;i<deptlist.size();i++){
				boolean bool=false;
				Employee emp= (Employee)deptlist.get(i);
			//	System.out.println(department.getId());
			//	System.out.println(department.getEmployee().getId());
				if(cyrid.trim().length()>0){
					for(int j=0;j<arrcyr.length;j++){
						System.out.println(arrcyr[j]);
						int cyr=Integer.parseInt(arrcyr[j]);
						if(emp.getId()==cyr){
							str+="<tr><td><input type='checkbox' id="+emp.getId()+" value='"+emp.getName()+"' checked='checked' onclick='checkCyr(this)'/>"+emp.getName()+"</td></tr>";
							bool=true;
						}
					}
					if(bool==false){
						str+="<tr><td><input type='checkbox' id="+emp.getId()+" value='"+emp.getName()+"' onclick='checkCyr(this)'/>"+emp.getName()+"</td></tr>";
					}
				}else{
					str+="<tr><td><input type='checkbox' id="+emp.getId()+" value='"+emp.getName()+"' onclick='checkCyr(this)'/>"+emp.getName()+"</td></tr>";
				}
			}
			out.print(str);
			}
		
		
		
		
		
		
//		if(!"".equals(deptid)){
//		String tstString = deptid.substring(0, deptid.length()-1);
//		
//		//改变需求,参与人只列出所选中部门的主管
////		String hql = "from Department where id in ('"+deptid+"')";
////		List<Department> list = projectdao.getAllDepts(hql);
////		for(int i=0;i<list.size();i++){
////			Department dept = list.get(i);
////			name = dept.getEmployee().getName();
////		}
//		
//		String hql = "from Employee where isLeave=1 and delflag=0 and department.id in ("+tstString+")";
//		emplist = projectdao.getAllEmps(hql);
//		
//		String str = "";
//		for(int i=0;i<emplist.size();i++){
//			boolean bool=false;
//			Employee employee = (Employee)emplist.get(i);
//			System.out.println(employee.getId());
//			if(cyrid.trim().length()>0){
//				for(int j=0;j<arrcyr.length;j++){
//					System.out.println(arrcyr[j]);
//					int cyr=Integer.parseInt(arrcyr[j]);
//					if(employee.getId()==cyr){
//						str+="<tr><td><input type='checkbox' id="+employee.getId()+" value='"+employee.getName()+"' checked='checked' onclick='checkCyr(this)'/>"+employee.getName()+"</td></tr>";
//						bool=true;
//					}
//				}
//				if(bool==false){
//					str+="<tr><td><input type='checkbox' id="+employee.getId()+" value='"+employee.getName()+"' onclick='checkCyr(this)'/>"+employee.getName()+"</td></tr>";
//				}
//			}else{
//				str+="<tr><td><input type='checkbox' id="+employee.getId()+" value='"+employee.getName()+"' onclick='checkCyr(this)'/>"+employee.getName()+"</td></tr>";
//			}
//		}
//		out.print(str);
//		}
		out.print("");
		return null;
	}
	
	
	/**
	 * 员工列表2
	 * @return
	 */
	public String emplist2() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String hql="";
		String empids = request.getParameter("empids");
		System.out.println(empids);
		String did = request.getParameter("did"); //取到参与部门
		System.out.println(did);
		String cyrid = request.getParameter("cyrid"); //取到参与人ID
		System.out.println(cyrid);
		String[] arrcyr = cyrid.split(",");
		
		//项目为进行中,变更
//		String department = request.getParameter("department");
//		System.out.println(department);
		if("".equals(empids)){
			hql = "from Employee where isLeave=1 and delflag=0";
		}
		if(!"".equals(empids) && !"".equals(did)){
			String[] empidstr = empids.split(",");
			int id=0;
			String idstr="";
			for(int i=0;i<empidstr.length;i++){
				id=Integer.parseInt(empidstr[i]);
				idstr+=","+id;
			}
			String ids = idstr.replaceFirst(",", "");
			//列出的参与人,必须是选中的参与部门下的员工
			String dids = did.substring(0, did.length()-1);
			hql = "from Employee where isLeave=1 and delflag=0 and id not in("+ids+") and department.id in ("+dids+")";
			System.out.println(hql);
		}
		    emplist = projectdao.getAllEmps(hql);
	
		
		
		String str = "";
		for(int i=0;i<emplist.size();i++){
			boolean bool = false;
			Employee employee = (Employee)emplist.get(i);
			if(cyrid.trim().length()>0){
				for(int j=0;j<arrcyr.length;j++){
					System.out.println(arrcyr[j]);
					int cyr = Integer.parseInt(arrcyr[j]);
					if(employee.getId()==cyr){
						str+="<tr><td><input type='checkbox' checked='checked' id="+employee.getId()+" value='"+employee.getName()+"' onclick='checkCyr(this)'/>"+employee.getName()+"</td></tr>";
						bool=true;
					}
				}
				if(bool==false){
					str+="<tr><td><input type='checkbox' id="+employee.getId()+" value='"+employee.getName()+"' onclick='checkCyr(this)'/>"+employee.getName()+"</td></tr>";
				}
			}else{
				str+="<tr><td><input type='checkbox' id="+employee.getId()+" value='"+employee.getName()+"' onclick='checkCyr(this)'/>"+employee.getName()+"</td></tr>";
				
			}
			
		}
		out.print(str);
		return null;
	}
	
	//查询
	public String getempByzg() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		Employee employee = (Employee)this.request.getSession().getAttribute("emp");
		List<Department> list = projectdao.getDepartmentByEmp(employee.getId());
		Department d = list.get(0);
		List<Employee> empli = projectdao.getEmpByDept(d.getId());
		String str = "";
		for(int i=0;i<empli.size();i++){
			System.out.println(empli.get(i).getId());
			Employee emp = empli.get(i);
			str += "<tr><td><input type='checkbox' id='"+emp.getId()+"' onclick='checkdata(this)'/>"+emp.getName()+"</td></tr>";
		}
		out.print(str);
		return null;
	}
	
	/**
	 * 加载审批人和类型
	 */
	public String loadApprover(){
		approverlist = projectdao.getPrjApprover("from Employee");
		// 得到当前登录人
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		
		//参数  岗位员工表对象
		WorkpositionEmployee  empposition1 =(WorkpositionEmployee) this.request.getSession().getAttribute("empposition");
//		根据岗位得到部门--再得到部门的主管-放到approveemp里
//		empposition.getPositiontype();//1主岗 2分岗3分管4主管
		empposition1.getWorkposition().getDepartment().getParentId();//父部门
//		HQL = " select emp    empposition where (type=4 or type = 3) and deptid = partid "
//		该岗位所在部门没有主管岗或者 主管岗没有人担任 则查找分管人员
		
//		以上2个都没有则递归查找
		Employee approveemp=null;
		List<WorkpositionEmployee> empposition=new ArrayList<WorkpositionEmployee>();
		empposition.add(0, empposition1);
		//登录人是主岗分岗就找出他的上一级   主管
		System.out.println(empposition.get(0).getId());
		System.out.println(empposition.get(0).getPositiontype());
		System.out.println(empposition.get(0).getWorkposition().getDepartment().getId());
		if(empposition.get(0).getPositiontype()==1||empposition.get(0).getPositiontype()==2)
		{
			String tophql="from WorkpositionEmployee where positiontype=4 and workposition.department.id="+empposition.get(0).getWorkposition().getDepartment().getId()+"";
			List<WorkpositionEmployee> we=projectdao.execHQL(tophql);
			if(we.size()>0)//没有比他大的岗位时候自己审批
				request.setAttribute("workpositionEmployee", we);
				else
					request.setAttribute("workpositionEmployee", empposition);
		}
		//登录人是主岗的时候就找出他的上一级  分岗
		else if(empposition.get(0).getPositiontype()==4)
		{
			String tophql="from WorkpositionEmployee where positiontype=3 and workposition.department.id="+empposition.get(0).getWorkposition().getDepartment().getId()+"";
			List<WorkpositionEmployee> we=projectdao.execHQL(tophql);
			if(we.size()>0)//没有比他大的岗位时候自己审批
			request.setAttribute("workpositionEmployee", we);
			else
				request.setAttribute("workpositionEmployee", empposition);
			
		}
		//登录人是分岗的是就他自己审批
		else
		{
			request.setAttribute("workpositionEmployee", empposition);
		}
//		// 根据人员编号得到部门
//		String hql="select e.department from Employee e where e.id="+employee.getId();
//		List deptlist=projectdao.execHQL(hql);
//		// 审批人
//		//Employee approveemp=null;
//		if(deptlist!=null && deptlist.size()>0){
//			Department dept=(Department)deptlist.get(0);
//			//int deptid=dept.getId();
//	        // 根据部门编号得到部门对象
//			//Department dept=(Department) projectdao.getObjectById(Department.class, deptid);
//			// 得到这个部门的主管
//			if(dept.getEmployee()!=null){
//				approveemp=dept.getEmployee();
//			}else{
//				//如果这个负责人所对应的部门里没有主管的话，那说明这个人就是最大的了。则审批人就是当前登录人
//				approveemp=employee;
//			}
//		}else{
//			approveemp=employee;
//		}
//		request.setAttribute("approveemp",approveemp);
		typelist = projectdao.getPrjType("from Missiontype where isflag=2");
		request.getSession().getAttribute("loginName");
		return "success";
	}
	
	/**
	 * 添加项目信息(立项)
	 */
	public String start() {
		  try{
			 logger.error("pjaction-xxxxxxxxx");
		//  empnum = request.getSession().getAttribute("loginName").toString();
			// 得到当前登录人
			Employee dqdlr =(Employee) this.request.getSession().getAttribute("emp");
		
		    int iscommit = Integer.parseInt(request.getParameter("iscommit"));
		    if(iscommit==1){  //1是提交审批 还要向审批表写入记录
				String type = request.getParameter("type");
				int app = project.getEmployee().getId();
		//		String app = request.getParameter("approver");
				System.out.println(iscommit);
				//审批人
				//获取审批人的id （监管人！！！）
				String shengpirenId=request.getParameter("project.employee.id");
				Employee emp = (Employee)projectdao.getObjectById(Employee.class, Integer.parseInt(shengpirenId));
				Employee employee1 = (Employee)this.request.getSession().getAttribute("emp");
				int mid=Integer.parseInt(type);
				Missiontype missiontype = (Missiontype)projectdao.getObjectById(Missiontype.class, mid);
				logger.error("pjaction-xxxxxxxxx1");
				//int eid = Integer.parseInt(request.getSession().getAttribute("loginName").toString());
				project.setLauncher(dqdlr.getName());
				project.setLauncher(employee1.getName());
				project.setMoney(project.getMoney());
				project.setProjectname(project.getProjectname());
				logger.error("pjaction-xxxxxxxxx2");
				project.setMissiontype(missiontype); //添加类型
				logger.error("pjaction-xxxxxxxxx3");
				project.setBegintime(project.getBegintime());
				project.setEndtime(project.getEndtime());
				project.setProjectinfo(project.getProjectinfo());
				project.setEmployee(emp); //添加审批人
				project.setSchedule(0);
				project.setProjectstatus(1);
				logger.error("pjaction-xxxxxxxxx4");
				logger.error(project.getEmployee().getId());
				logger.error(project.getMissiontype().getId());
				logger.error(project.getSchedule());
				logger.error(project.getId());
				id=projectdao.lx(project);
				this.project=(NewProject)projectdao.getObjectById(NewProject.class,id);
				logger.error("pjaction-xxxxxxxxx51");
				////////////向审批表插入记录//////////////
				String empNo="";
				if(request.getSession().getAttribute("loginName")==null){
					empNo=dqdlr.getEmpNo();
					
				}else{
					empNo = request.getSession().getAttribute("loginName").toString();
					request.getSession().setAttribute("loginName", empNo);
				}
				
				
				
				Employee sqr = projectdao.getEmployeeByEmpNo(dqdlr.getEmpNo());
				NewApprove newapprove = new NewApprove();
				
				newapprove.setNewproject(project);
				logger.error("pjaction-xxxxxxxxx6");
				newapprove.setApplypeople(sqr);
				newapprove.setBegintime(project.getBegintime());
				
				newapprove.setEndtime(project.getEndtime());
				newapprove.setAppstatus(0);
				newapprove.setApproveemp(emp);
				newapprove.setAppLD(emp.getId().toString());
				projectdao.addProject(newapprove);
				logger.error("pjaction-xxxxxxxxx7");
				
				//id = project.getId();
				String cybm = request.getParameter("cybm");//参与部门
				String ckz = request.getParameter("ckz"); //项目查看者
				lxcyr = request.getParameter("joinemp");  //参与人员
				
				//添加参与部门
				String[] str = cybm.split(",");
				String string = "";
				for(int i=0;i<str.length;i++){
					NewPrjdept d = new NewPrjdept();
					int deptid = Integer.parseInt(str[i]);
					Department dept=(Department)projectdao.getObjectById(Department.class,deptid);
					d.setDept(dept);
					NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,id);
					d.setProject(newprj);
					projectdao.addPrjdept(d);
				}
				//添加查看者
				String[] str2 = ckz.split(",");
				String string2 = "";
				for(int i=0;i<str2.length;i++){
					NewWatch w = new NewWatch();
					int eid2=Integer.parseInt(str2[i]);
					System.out.println(eid2);
					Employee employee = (Employee)projectdao.getObjectById(Employee.class, eid2);
					NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,id);
					w.setEmp(employee);
					w.setProject(newprj);
					projectdao.addPrjWatcher(w);
				}
				
				//添加参与人员
				String[] cyr2 = lxcyr.split(",");
				String s = "";
				for(int i=0;i<cyr2.length;i++){
					NewParticipator participator = new NewParticipator();
					int partid = Integer.parseInt(cyr2[i]);
					System.out.println(partid);
					Employee employee = (Employee)projectdao.getObjectById(Employee.class, partid);
					NewProject prj = (NewProject)projectdao.getObjectById(NewProject.class, id);
					participator.setEmployee(employee);
					participator.setProject(prj);
					participator.setIsagree(0);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date date = new Date();
					String now = sdf.format(date);
					System.out.println(now);
					projectdao.addCyr(participator);
				}
				
				//发送短消息(对参与人员),先向message表写入数据,messageid有值后再向messagereceiver表写数据
				Messagetype sendertype = (Messagetype)projectdao.getObjectById(Messagetype.class, 1);  //sendertype员工消息
				Messagetype messagetype = (Messagetype)projectdao.getObjectById(Messagetype.class, 28); //messagetype 消息类型:个人公公
				String empno="";
				if(request.getSession().getAttribute("loginName")==null){
					empno=dqdlr.getEmpNo();
					
				}else{
					empno = request.getSession().getAttribute("loginName").toString();
				}
				
				
				System.out.println(empno);
				Employee employee = projectdao.getEmployeeByEmpNo(empno);
				String sender = employee.getId().toString();
				System.out.println(employee.getId().toString());
				Message mess = new Message();
				mess.setSender(sender);  //发送人(当前登录人ID)
				mess.setMessagetypeBySendertype(sendertype); //发送类型:员工消息
				mess.setMessagetypeByMessagetype(messagetype);//消息类型:个人公告
				String title = request.getParameter("title"); //标题
				String messagecontent = request.getParameter("messagecontent"); //内容
				mess.setTitleweb(title);
				mess.setMessagecontent(messagecontent);
				mess.setRepealfalg("0"); //是否撤销 0为否 	 1为是
				mess.setDelfalg("0"); //删除标识
				mess.setDraftfalg("0"); //草稿标识
				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String releasetime = sdf.format(now);
				mess.setReleasetime(Timestamp.valueOf(releasetime));
				mess.setTmp1("0");
				projectdao.add(mess);
				
				//消息表有PK之后,再向接收消息表写入记录
				int messageid = mess.getMessageid();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date date = new Date();
				String receivertime = dateFormat.format(date);
				String[] projectcyr = lxcyr.split(",");
				for(int i=0;i<projectcyr.length;i++){
					Messagereceiver receiver = new Messagereceiver();
					receiver.setMessage(mess);
					receiver.setMessagetype(sendertype);
					receiver.setReceiverer(projectcyr[i]);
					receiver.setReceivetime(Timestamp.valueOf(releasetime));
					receiver.setReadfalg("0"); //是否读取 未读取0
					receiver.setDelfalg("0"); //删除标识 没有0
					receiver.setTmp1("0");  //0是员工 1是客户
					receiver.setTmp2("project");
					//根据项目ID取到项目对象
					NewProject project=(NewProject)projectdao.getObjectById(NewProject.class,id);
					receiver.setProject(project);
					projectdao.add(receiver);
				}   // ===========>发消息完毕
				logger.error("pjaciton---1111");
		            //在这里添加附件
				if(request.getSession().getAttribute("files")!=null){
					String fileNames=request.getSession().getAttribute("fileNames").toString();//真实文件名
					String fjhzname=request.getSession().getAttribute("fjhzname").toString();
					String sfileNames=new String(fileNames.getBytes("ISO-8859-1"), "UTF-8");
					request.getSession().removeAttribute(fileNames);
					logger.error("pjaciton---2");
					String paths=request.getSession().getAttribute("files").toString();
					String[] file=paths.split(",");
					logger.error("pjaciton---3");
					for(int i=0;i<file.length;i++){
						//NewDocument d=new NewDocument();
						String filestr=file[i];
						String filetrue=sfileNames.split(",")[i];
						//d.setFilepath(filestr);
						//d.setFilename(filetrue);
						//d.setNewProject(project);
						//projectdao.addFj(d);
						String extName=fjhzname.split(",")[i];
						//String extName=filetrue.split(".")[1];
						String trueName=filetrue.split(extName)[0];
						String fjhz=extName.substring(1);
						projectdao.addFJ2(filestr,"Project",trueName,fjhz,project.getId().toString());
						
					}
					logger.error("pjaciton---4");
			        // 清除session缓存
					request.getSession().removeAttribute("files");
					request.getSession().removeAttribute("filedata");
				}
				logger.error("pjaciton---5");
		    }
		    
		    //判断2
		    if(iscommit==2){  //不提交审批,只向项目表写入数据
		    	logger.error("2pjaciton---1");
		    	String type = request.getParameter("type");
		    	int app = project.getEmployee().getId(); //得到页面上审批人的ID
				System.out.println(iscommit);
				//审批人
				Employee emp = (Employee)projectdao.getObjectById(Employee.class, app);
				int mid=Integer.parseInt(type);
				Missiontype missiontype = (Missiontype)projectdao.getObjectById(Missiontype.class, mid);
				//int eid = Integer.parseInt(request.getSession().getAttribute("loginName").toString());
				System.out.println(project.getLauncher());
				System.out.println(project.getProjectname());
				System.out.println(project.getBegintime());
				System.out.println(project.getEndtime());
				project.setLauncher(project.getLauncher());
				project.setProjectname(project.getProjectname());
				project.setMissiontype(missiontype); //添加类型
				project.setBegintime(project.getBegintime());
				project.setEndtime(project.getEndtime());
				project.setProjectinfo(project.getProjectinfo());
				project.setEmployee(emp); //添加审批人
				project.setSchedule(0);
				project.setProjectstatus(0);
				logger.error("iscommit2pjaction-xxxxxxxxx4");
				logger.error(project.getEmployee().getId());
				logger.error(project.getMissiontype().getId());
				logger.error(project.getSchedule());
				logger.error(project.getId());
				id=projectdao.lx(project);
				logger.error("iscommit2pjaction-xxxxxxxxx5");
				//id = project.getId();
				String cybm = request.getParameter("cybm");//参与部门
				String ckz = request.getParameter("ckz"); //项目查看者
				String cyr = request.getParameter("joinemp");  //参与人员
				this.project=(NewProject)projectdao.getObjectById(NewProject.class,id);
				//添加参与部门
				String[] str = cybm.split(",");
				String string = "";
				for(int i=0;i<str.length;i++){
					NewPrjdept d = new NewPrjdept();
					int deptid = Integer.parseInt(str[i]);
					Department dept=(Department)projectdao.getObjectById(Department.class,deptid);
					d.setDept(dept);
					NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,id);
					d.setProject(newprj);
					projectdao.addPrjdept(d);
				}
				//添加查看者
				String[] str2 = ckz.split(",");
				String string2 = "";
				for(int i=0;i<str2.length;i++){
					NewWatch w = new NewWatch();
					int eid2=Integer.parseInt(str2[i]);
					System.out.println(eid2);
					Employee employee = (Employee)projectdao.getObjectById(Employee.class, eid2);
					NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,id);
					w.setEmp(employee);
					w.setProject(newprj);
					projectdao.addPrjWatcher(w);
				}
				
				
				//添加参与人员
				String[] cyr2 = cyr.split(",");
				String s = "";
				for(int i=0;i<cyr2.length;i++){
					NewParticipator participator = new NewParticipator();
					int partid = Integer.parseInt(cyr2[i]);
					System.out.println(partid);
					Employee employee = (Employee)projectdao.getObjectById(Employee.class, partid);
					NewProject prj = (NewProject)projectdao.getObjectById(NewProject.class, id);
					participator.setEmployee(employee);
					participator.setProject(prj);
					participator.setIsagree(0);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date date = new Date();
					String now = sdf.format(date);
					System.out.println(now);
					projectdao.addCyr(participator);
				}
				
				
				//发送短消息(对参与人员),先向message表写入数据,messageid有值后再向messagereceiver表写数据
				Messagetype sendertype = (Messagetype)projectdao.getObjectById(Messagetype.class, 1);  //sendertype员工消息
				Messagetype messagetype = (Messagetype)projectdao.getObjectById(Messagetype.class, 28); //messagetype 消息类型:个人公公
				
				String empno="";
				if(request.getSession().getAttribute("loginName")==null){
					empno=dqdlr.getEmpNo();
					
				}else{
					empno = request.getSession().getAttribute("loginName").toString();
				}
			
				System.out.println(empno);
				Employee employee = projectdao.getEmployeeByEmpNo(empno);
				String sender = employee.getId().toString();
				System.out.println(employee.getId().toString());
				Message mess = new Message();
				mess.setSender(sender);  //发送人(当前登录人ID)
				mess.setMessagetypeBySendertype(sendertype); //发送类型:员工消息
				mess.setMessagetypeByMessagetype(messagetype);//消息类型:个人公告
				String title = request.getParameter("title"); //标题
				String messagecontent = request.getParameter("messagecontent"); //内容
				mess.setTitleweb(title);
				mess.setMessagecontent(messagecontent);
				mess.setRepealfalg("0"); //是否撤销 0为否 	 1为是
				mess.setDelfalg("0"); //删除标识
				mess.setDraftfalg("0"); //草稿标识
				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String releasetime = sdf.format(now);
				mess.setReleasetime(Timestamp.valueOf(releasetime));
				mess.setTmp1("0");
				projectdao.add(mess);
				
				//消息表有PK之后,再向接收消息表写入记录
				int messageid = mess.getMessageid();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date date = new Date();
				String receivertime = dateFormat.format(date);
				String[] projectcyr = cyr.split(",");
				for(int i=0;i<projectcyr.length;i++){
					Messagereceiver receiver = new Messagereceiver();
					receiver.setMessage(mess);
					receiver.setMessagetype(sendertype);
					receiver.setReceiverer(projectcyr[i]);
					receiver.setReceivetime(Timestamp.valueOf(releasetime));
					receiver.setReadfalg("0"); //是否读取 未读取0
					receiver.setDelfalg("0"); //删除标识 没有0
					receiver.setTmp1("0");  //0是员工 1是客户
					receiver.setTmp2("project");
					//根据项目ID取到项目对象
					NewProject project=(NewProject)projectdao.getObjectById(NewProject.class,id);
					receiver.setProject(project);
					projectdao.add(receiver);
				}   // ===========>发消息完毕
				logger.error("2pjaciton---2");
			     //在这里添加附件
				if(request.getSession().getAttribute("files")!=null){
					String fileNames=request.getSession().getAttribute("fileNames").toString();//真实文件名
					String fjhzname=request.getSession().getAttribute("fjhzname").toString();
					String sfileNames=new String(fileNames.getBytes("ISO-8859-1"), "UTF-8");
					request.getSession().removeAttribute(fileNames);
					logger.error("pjaciton---2");
					String paths=request.getSession().getAttribute("files").toString();
					String[] file=paths.split(",");
					logger.error("pjaciton---3");
					for(int i=0;i<file.length;i++){
						//NewDocument d=new NewDocument();
						String filestr=file[i];
						String filetrue=sfileNames.split(",")[i];
						//d.setFilepath(filestr);
						//d.setFilename(filetrue);
						//d.setNewProject(project);
						//projectdao.addFj(d);
						String extName=fjhzname.split(",")[i];
						//String extName=filetrue.split(".")[1];
						String trueName=filetrue.split(extName)[0];
						String fjhz=extName.substring(1);
						projectdao.addFJ2(filestr,"Project",trueName,fjhz,project.getId().toString());
						
					}
					logger.error("pjaciton---4");
			        // 清除session缓存
					request.getSession().removeAttribute("files");
					request.getSession().removeAttribute("filedata");
					logger.error("2pjaciton---4");
				}
				logger.error("2pjaciton---5");
		    }
		  }catch (Exception e) {
			  logger.error("pjaction-xxxxxxxxxerror");
			  logger.error(e.getMessage());
			e.printStackTrace();
		}
		  project = null;
		  logger.error("pjaction-xxxxxxxxxend");
		return "lx";
	}

	
	/**
	 * 查询
	 * @return
	 */
	public String sel() throws Exception{
		String hql="from NewProject where isdel=0";
		String pageNo = request.getParameter("pageNo");
		if(null == pageNo){
			pageNo = "1";
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		pname = project.getProjectname();
		state = project.getProjectstatus();
		btime="";
		etime="";
		if(project.getBegintime()!=null && project.getEndtime()!=null){
		btime = sdf.format(project.getBegintime());
		etime = sdf.format(project.getEndtime());
		}
		
		if(pname.equals("-1")){
			hql+="";
		}else{
			hql+=" and projectname='"+pname+"'";
		}
		if(state==-1){
			hql+="";
		}else{
			hql+=" and projectstatus="+state;
		}
		
		if(btime!=null && ""!=btime && !"".equals(btime)){
			hql+=" and begintime='"+btime+"'";
		}else{
			hql+="";
		}
		
		if(etime!=null && !"".equals(etime) && ""!=etime){
			hql+= " and endtime='"+etime+"'";
		}else{
			hql+="";
		}
		
		if(btime!=null && ""!=btime && etime!=null && ""!=etime){
			hql+=" and begintime='"+btime+"' and endtime='"+etime+"'";
		}else{
			hql+="";
		}
		Pages pages = projectdao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
//		projectlist = projectdao.getAllProjects(hql);
		this.projectlist = pages.getPageList();
		request.setAttribute("pagelist", pages);
		request.setAttribute("pages", pages);
		return "list";
	}
	/**
	 * 我的项目列表
	 */
	public String EmpPojListbyDept(){
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}	 
		// 得到当前登陆人
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		
		//得到部门成员
		
		// 拿到当前登录岗位
		WorkpositionEmployee empposition=(WorkpositionEmployee)request.getSession().getAttribute("empposition");
		// 拿到当前登录员工
//		Employee loginEmp =(Employee) this.request.getSession().getAttribute("emp");
		if (null == employee) {
			return "no";
		}
		//子部门id
		String sonIds = loginDao.executeSql("select getChildDeptLst("+ empposition.getWorkposition().getDepartment().getId() + ")");
		
		String[] son = sonIds.split(",");
		String hql1 = "(";
		if (son.length > 1) {
			for (int i = 0; i < son.length; i++) {
				if (i != son.length - 1)
					hql1 += "department.id=" + Integer.parseInt(son[i])
							+ " or ";
				else
					hql1 += "department.id=" + Integer.parseInt(son[i]) + ")";
			}
		} else {
			hql1 = "department.id=" + employee.getDepartment().getId() + "";
		}

		String hql2 = "from Employee where delflag=0 and isLeave=1 and delflag=0 and "
				+ hql1 + " order by department.id   ";
		
		List  emplist = projectdao.execHQL(hql2);
		String empnamestr = "";
		String empidstr = "";
		String npidstr = "";
		for (Iterator it = emplist.iterator(); it.hasNext();) {
			Employee emp = (Employee) it.next();
			empnamestr += "'"+emp.getName()+"',";
			empidstr += emp.getId()+",";
		}
		if(emplist.size()>0){
			empidstr = empidstr.substring(0,empidstr.length()-1);
		}else{
			empidstr = "0";
		}
		String hql3 = " from NewParticipator as npt where npt.isagree=2 and npt.employee.id in("+empidstr+")";
		List nptlist  = projectdao.execHQL(hql3);
		for (Iterator ii = nptlist.iterator(); ii.hasNext();) {
			NewParticipator npt = (NewParticipator) ii.next();
			npidstr += npt.getNewProject().getId()+",";
		}
		if(nptlist.size()>0){
			npidstr = npidstr.substring(0,npidstr.length()-1);
		}else{
			npidstr = "0";
		}
		String hql="from NewProject as np where np.isdel=0 ";
		String hqloffical = "";
		if( emplist.size()>0){
			empnamestr = empnamestr.substring(0, empnamestr.length()-1);
			empidstr = empidstr.substring(0, empidstr.length()-1);
			// 
			hqloffical ="from NewProject as np where np.isdel=0 and( np.id in("+npidstr+") or  np.launcher in("+empnamestr+"))"; 
		}else{
			
			hqloffical="from NewProject as np where 1 != 1";
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			 String projectname= URLDecoder.decode(request.getParameter("projectname"), "utf-8");
			 String status=request.getParameter("status");
			 String begintime=request.getParameter("begintime");
			 String endtime=request.getParameter("endtime");
			 if(projectname!=null&&projectname.trim().length()>0){
				 hqloffical+=" and np.projectname like '%"+projectname+"%'";
				 request.setAttribute("projectname", projectname);
			 }
			 if(status!=null && !status.equals("-1")){
				 hqloffical+=" and np.projectstatus="+status;
				 request.setAttribute("projectstatus", status);
			 }
			 if(begintime!=null && begintime.trim().length()>0){
				 hqloffical+=" and np.begintime>='"+begintime+"'";
				 request.setAttribute("begintime", begintime);
			 }
			 if(endtime!=null && endtime.trim().length()>0){
				 hqloffical+=" and np.endtime<='"+endtime+"'";
				 request.setAttribute("endtime", endtime);
			 }
		} catch (Exception e) {
		}
		
	//	hql+=" order by id desc";
		hqloffical +=" order by np.id desc";
		String dcstr= request.getParameter("dc");
		if(dcstr!=null&&dcstr.equals("1")){
			List prjlist=projectdao.execHQL(hqloffical);
			
			request.setAttribute("projectlist", prjlist);
			
			for(int i=0;i<prjlist.size();i++){
				NewProject newProject = (NewProject)prjlist.get(i);
				int projectid = newProject.getId();
				//查看人
				List watchlist = projectdao.getWatcherByPid(projectid);
				for(int j=0;j<watchlist.size();j++){
					NewWatch watch = (NewWatch)watchlist.get(j);
					if(employee.getId().toString().equals(watch.getEmp().getId().toString())){
						newProject.setTemp1("1");
					}else {
						newProject.setTemp1("2");
					}
				}
				//参与人
				List parlist = projectdao.getParticipatorByPid(projectid);
				for(int m=0;m<parlist.size();m++){
					NewParticipator newParticipator = (NewParticipator)parlist.get(m);
					if(employee.getId().toString().equals(newParticipator.getEmployee().getId().toString())){
						newProject.setTemp2("1");
					}else {
						newProject.setTemp2("0");
					}
				}
				//发起人 审批人
				if(employee.getName().equals(newProject.getLauncher()) || employee.getId().toString().equals(newProject.getEmployee().getId().toString())){
					newProject.setTemp3("1");
				}else {
					newProject.setTemp3("0");
				}
			}
			
			
			return "dclist";
		}else{
			Pages page= projectdao.paginationQuery(hqloffical, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("employee", employee);
			request.setAttribute("projectlist", page.getPageList());
			request.setAttribute("pages", page);
			List plist = page.getPageList();
			for(int i=0;i<plist.size();i++){
				NewProject newProject = (NewProject)plist.get(i);
				int projectid = newProject.getId();
				//查看人
			//	List watchlist = projectdao.getWatcherByPid(projectid);
				newProject.setTemp1("1");				
			}
			
			
			return "list";
		}
	}
	/**
	 * 我的项目列表
	 */
	public String list(){
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}	 
		// 得到当前登陆人
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		
		String hql="from NewProject as np where np.isdel=0 ";
		 String str="";
		 List list=projectdao.getAllProjects(hql);
		 for(int i=0;i<list.size();i++){
			 NewProject np=(NewProject)list.get(i);
			 if(np.getLauncher().equals(employee.getName())){
				 str+=","+np.getId();
			 }
			 if(np.getEmployee().getId().equals(employee.getId())){
				 str+=","+np.getId();
			 }
			 //查看者
			 String ckzhql="from NewWatch where project.id="+np.getId()+" and emp.id="+employee.getId();
			 List cklist = projectdao.getWatch(ckzhql);
			 if(cklist.size()>0){
				 NewWatch watch = (NewWatch)cklist.get(0);
				 if(watch.getEmp().getId().toString().equals(employee.getId().toString())){
					 str+=","+np.getId();
				 }
			 }
			 //参与人
			 String cyrhql = "from NewParticipator where pid="+np.getId()+" and inviteemp="+employee.getId()+" and isagree=2";
			 List cyrlist = projectdao.getPar(cyrhql);
			 if(cyrlist.size()>0){
				 NewParticipator p = (NewParticipator)cyrlist.get(0);
				 if(p.getEmployee().getId().equals(employee.getId())){
					 str+=","+np.getId();
				 }
			 }
		 }
		 hql+=" and np.id in(''"+str+")";
		 
		//List projectList2= projectdao.execHQL(hql);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			 String projectname= URLDecoder.decode(request.getParameter("projectname"), "utf-8");
			 String status=request.getParameter("status");
			 String begintime=request.getParameter("begintime");
			 String endtime=request.getParameter("endtime");
			 if(projectname!=null&&projectname.trim().length()>0){
				 hql+=" and np.projectname like '%"+projectname+"%'";
				 request.setAttribute("projectname", projectname);
			 }
			 if(status!=null && !status.equals("-1")){
				 hql+=" and np.projectstatus="+status;
				 request.setAttribute("projectstatus", status);
			 }
			 if(begintime!=null && begintime.trim().length()>0){
				 hql+=" and np.begintime>='"+begintime+"'";
				 request.setAttribute("begintime", begintime);
			 }
			 if(endtime!=null && endtime.trim().length()>0){
				 hql+=" and np.endtime<='"+endtime+"'";
				 request.setAttribute("endtime", endtime);
			 }
		} catch (Exception e) {
		}
		
	//	hql+=" order by id desc";
		hql+=" order by np.id desc";
		String dcstr= request.getParameter("dc");
		if(dcstr!=null&&dcstr.equals("1")){
			List prjlist=projectdao.execHQL(hql);
			
			request.setAttribute("projectlist", prjlist);
			
			for(int i=0;i<prjlist.size();i++){
				NewProject newProject = (NewProject)prjlist.get(i);
				int projectid = newProject.getId();
				//查看人
				List watchlist = projectdao.getWatcherByPid(projectid);
				for(int j=0;j<watchlist.size();j++){
					NewWatch watch = (NewWatch)watchlist.get(j);
					if(employee.getId().toString().equals(watch.getEmp().getId().toString())){
						newProject.setTemp1("1");
					}else {
						newProject.setTemp1("2");
					}
				}
				//参与人
				List parlist = projectdao.getParticipatorByPid(projectid);
				for(int m=0;m<parlist.size();m++){
					NewParticipator newParticipator = (NewParticipator)parlist.get(m);
					if(employee.getId().toString().equals(newParticipator.getEmployee().getId().toString())){
						newProject.setTemp2("1");
					}else {
						newProject.setTemp2("0");
					}
				}
				//发起人 审批人
				if(employee.getName().equals(newProject.getLauncher()) || employee.getId().toString().equals(newProject.getEmployee().getId().toString())){
					newProject.setTemp3("1");
				}else {
					newProject.setTemp3("0");
				}
			}
			
			
			return "dclist";
		}else{
			Pages page= projectdao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("employee", employee);
			request.setAttribute("projectlist", page.getPageList());
			request.setAttribute("pages", page);
			List plist = page.getPageList();
			for(int i=0;i<plist.size();i++){
				NewProject newProject = (NewProject)plist.get(i);
				int projectid = newProject.getId();
				//查看人
			//	List watchlist = projectdao.getWatcherByPid(projectid);
				List watchlist = projectdao.getWaByPidAndEmpid(projectid, employee.getId());
				if(watchlist.size()>0){
					NewWatch watch = (NewWatch)watchlist.get(0);
					if(employee.getId().toString().equals(watch.getEmp().getId().toString())){
						newProject.setTemp1("1");
					}else {
						newProject.setTemp1("2");
					}
				}
				//参与人
			//	List parlist = projectdao.getParticipatorByPid(projectid);
				List parlist = projectdao.getNpByPidAndEmpid(projectid, employee.getId());
				 if(parlist.size()>0){
					NewParticipator newParticipator = (NewParticipator)parlist.get(0);
					if(employee.getId().toString().equals(newParticipator.getEmployee().getId().toString())){
						newProject.setTemp2("1");
					}else {
						newProject.setTemp2("0");
					}
				 }
				//发起人 审批人
				if(employee.getName().equals(newProject.getLauncher()) || employee.getId().toString().equals(newProject.getEmployee().getId().toString())){
					newProject.setTemp3("1");
				}else {
					newProject.setTemp3("0");
				}
			}
			
			
			return "list";
		}
	}
	/**
	 * 删除项目(立项中)
	 * @return
	 */
	public String del() throws Exception{
		response.setCharacterEncoding("utf-8");
		System.out.println(pid);
		NewProject oldproject = (NewProject)projectdao.getObjectById(NewProject.class, pid);
		PrintWriter out = response.getWriter();
		if(oldproject!=null){
			projectdao.delproject(pid);
			System.out.println("删除...");
			out.print("OK");
		}else {
			out.print("ERROR");
		}
		return null;
	}
	/**
	 * 准备修改项目
	 * @return
	 */
	public String toupd(){
		  String empname="";
    	  String empNoString ="";
    	  if(request.getSession().getAttribute("loginName")==null){
    		  Employee emp=(Employee)request.getSession().getAttribute("emp");
    		  empnum=emp.getEmpNo();
    		  
    	  }
    	  else{
    		  
    		  
    		  empnum = request.getSession().getAttribute("loginName").toString();
    	  }
		//empnum = request.getSession().getAttribute("loginName").toString();
		//权限设置
		Employee employee = projectdao.getEmployeeByEmpNo(empnum); //登陆人
		NewProject newProject = (NewProject)projectdao.getObjectById(NewProject.class, pid);
		String loginName = newProject.getLauncher();
		System.out.println(loginName);
	//	if(employee.getName().equals(loginName)){
			typelist = projectdao.getPrjType("from Missiontype where isflag=2"); //项目类型
			project = (NewProject)projectdao.getObjectById(NewProject.class, pid);	//点击修改,得到项目信息
			employee = project.getEmployee(); //得到该项目的审批人
			List prjdeptlist= projectdao.getPrjdept(pid);  //修改时，得到该项目的参与部门
			List prjemplist = projectdao.getPrjwatch(pid); //修改时，得到该项目的查看者
			List emplist2 = projectdao.getAllEmps("from Employee where isLeave=1 and delflag=0"); //所有员工
			List dlist = projectdao.getAllDepts("from Department where id not in(0,1)");
			List elist = projectdao.getAllEmps("from Employee where isLeave=1 and delflag=0");
			request.setAttribute("project", project);
			request.setAttribute("typelist", typelist);
		 	request.setAttribute("emplist2", emplist2);
			request.setAttribute("dlist", dlist);
			request.setAttribute("elist", elist);
			request.setAttribute("prjdeptlist", prjdeptlist);
			request.setAttribute("prjemplist", prjemplist);
	//	}
		return "upd";
	}
	/**
	 * 修改
	 * @author 袁天龙
	 * @date  2012
	 * @return
	 */
	public String upd() throws Exception{
		System.out.println(cm2);
		System.out.println(ck2);
		System.out.println(type);
		System.out.println(project.getProjectstatus());
		
		//项目类型
		Missiontype missiontype = (Missiontype)projectdao.getObjectById(Missiontype.class, Integer.parseInt(type));
		//审批人
		Employee employee = (Employee)projectdao.getObjectById(Employee.class, Integer.parseInt(app));
		
		System.out.println(project.getApprover());
		int pid = project.getId();
		NewProject oldproject = (NewProject)projectdao.getObjectById(NewProject.class, pid);
		int approve_id = project.getId();
		NewProject app_project = (NewProject)projectdao.getObjectById(NewProject.class, approve_id);
		List applist = projectdao.getApproveByPid(approve_id); //根据项目ID查询审批表这个项目对象
		System.out.println(applist.size());
		 System.out.println(project.getProjectname());
		 System.out.println(project.getBegintime());
		 System.out.println(project.getEndtime());
		 oldproject.setProjectname(project.getProjectname());
		 oldproject.setMissiontype(missiontype);
		 oldproject.setBegintime(project.getBegintime());
		 oldproject.setEndtime(project.getEndtime());
		 oldproject.setEmployee(employee);
		 projectdao.updateObj(oldproject);
		 System.out.println(oldproject.getProjectstatus());
		 
		 //如果审批表没有这个项目,就向审批表写入改项目信息
		 if(isapprove==1 && applist.size()<=0){  //用户选择提交审批,且审批记录没有该条记录
			 System.out.println(employee.getId().toString());
			 Employee apply = projectdao.getEmployeeByEmpNo(empnum);
			 NewApprove ap = new NewApprove(); // 得到审批项目
			 ap.setApplypeople(apply);
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			 Date date = new Date();
			 Date now = sdf.parse(sdf.format(date));
			 Date now2 = sdf.parse(sdf.format(date));
			 ap.setBegintime(now);
			 ap.setEndtime(now2);
		     ap.setAppstatus(0);
			 ap.setNewproject(oldproject);
			 ap.setApproveemp(employee);
			 System.out.println("+++++++++++++++++++++______________________"+employee.getId());
			 ap.setAppLD(employee.getId().toString());
			 projectdao.add(ap);
			 //把状态改为审批中
			 oldproject.setProjectstatus(1);
			 projectdao.updateObj(oldproject);
		 }
		 if(isapprove==1 && applist.size()>0){
			 NewApprove ap=projectdao.appByPid(pid, oldproject.getEmployee().getId());
			 ap.setAppstatus(0);
			 System.out.println("________________________+++++++++++++++"+employee.getId());
			 ap.setAppLD(employee.getId().toString());
			 projectdao.add(ap);
			 //把状态改为审批中
			 oldproject.setProjectstatus(1);
			 projectdao.updateObj(oldproject);
		 }
		 
		 List prjdeptlist= projectdao.getPrjdept(pid);
		 if(prjdeptlist!=null && cm2!=null && !"".equals(cm2)){
		 projectdao.deletePrjdept(pid);
		//修改参与部门
		String[] str = cm2.split(",");
		for(int i=0;i<str.length;i++){
			NewPrjdept d = new NewPrjdept();
			int deptid = Integer.parseInt(str[i]);
			Department dept=(Department)projectdao.getObjectById(Department.class,deptid);
			d.setDept(dept);
			NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
			d.setProject(newprj);
			projectdao.addPrjdept(d);
		}
		 }
		//修改查看者
		 List prjemplist = projectdao.getPrjwatch(pid);
		 if(prjemplist!=null && ck2!=null && !"".equals(ck2)){
		projectdao.deletePrjwatch(pid);
		System.out.println(ck2);
		 String[] str2 = ck2.split(",");
		 for(int i=0;i<str2.length;i++){
			 NewWatch d = new NewWatch();
			 int empid = Integer.parseInt(str2[i]);
			 Employee emp=(Employee)projectdao.getObjectById(Employee.class,empid);
			 d.setEmp(emp);
			 NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
			 d.setProject(newprj);
			 projectdao.addPrjWatcher(d);
		 }
		 }
		
		return null;
	}
	
	/**
	 * 点击变更,提取数据(状态为进行中)
	 * @author 袁天龙
	 * @return
	 */
       public String tochange(){
		typelist = projectdao.getPrjType("from Missiontype where isflag=2"); //项目类型
		project = (NewProject)projectdao.getObjectById(NewProject.class, pid);	
		List prjdeptlist= projectdao.getPrjdept(pid);  //修改时，得到该项目的参与部门
		List prjemplist = projectdao.getPrjwatch(pid); //修改时，得到该项目的查看者
		List cyrlist = projectdao.getCyr(pid);
		//变更时,邀请新的参与人,只能添加新的,原来的参与人继续保留在参与人表,当点击参与人按钮时,把已经存在的参与人不显示在层里面
		String empStr="";
		int empid=0;
		List participatorlist = projectdao.getParticipatorByPid(pid);
		for(int i=0;i<participatorlist.size();i++){
			NewParticipator part = (NewParticipator)participatorlist.get(i);
			empid=part.getEmployee().getId();
			empStr+=","+empid;
		}
		String hql = "from Employee where isLeave=1 and delflag=0 and id not in(''"+empStr+")";
		System.out.println(hql);
		List emplist2 = projectdao.getAllEmps(hql); //所有员工
		//变更参与部门,只能增加,不能修改
		String deptStr="";
		int deptid=0;
		for(int i=0;i<prjdeptlist.size();i++){
			NewPrjdept dept = (NewPrjdept)prjdeptlist.get(i);
			deptid = dept.getDept().getId();
			deptStr+=","+deptid;
		}
		String dept = deptStr.replaceFirst(",", "");
		String depthql = "from Department where id not in ("+dept+")";
		System.out.println(hql);
		List dlist = projectdao.getAllDepts(depthql); //取到除了已经存在的部门
		List elist = projectdao.getAllEmps("from Employee where isLeave=1 and delflag=0");
		String mark="";
		for(int i=0;i<elist.size();i++)
		{
			boolean aa=true;
			for(int j=0;j<prjemplist.size();j++)
			{
				if(((Employee)elist.get(i)).getId()==((NewWatch)prjemplist.get(j)).getEmp().getId())
				{
					mark+=" <tr><td><input type='checkbox' checked=\"checked\" id="+((Employee)elist.get(i)).getId()+" name="+((Employee)elist.get(i)).getName()+" value="+((Employee)elist.get(i)).getName()+" onclick=\"checkEmp(this)\"/>"+((Employee)elist.get(i)).getName()+"</td></tr>";
					aa=false;
					break;
				}
			}
			if(aa==true)
			mark+=" <tr><td><input type='checkbox' id="+((Employee)elist.get(i)).getId()+" name="+((Employee)elist.get(i)).getName()+" value="+((Employee)elist.get(i)).getName()+" onclick=\"checkEmp(this)\"/>"+((Employee)elist.get(i)).getName()+"</td></tr>";
		}
		request.setAttribute("mark", mark);
		request.setAttribute("project", project);
		request.setAttribute("typelist", typelist);
		request.setAttribute("project", project);
		request.setAttribute("emplist2", emplist2);
		request.setAttribute("dlist", dlist);
		request.setAttribute("elist", elist);
		request.setAttribute("prjdeptlist", prjdeptlist);
		request.setAttribute("prjemplist", prjemplist);
		request.setAttribute("cyrlist", cyrlist);
		
		if(request.getSession().getAttribute("loginName")==null){
  		  Employee emp=(Employee)request.getSession().getAttribute("emp");
  		empnum=emp.getEmpNo();
  		  
  	  }
  	  else{
  		empnum = request.getSession().getAttribute("loginName").toString();
  	  }
		
		return "change";
	}
       
       /**
        * 变更项目(状态为进行中)
        * @author 袁天龙
        * @return
        */
       public String change() throws Exception{
    	   System.out.println(request.getParameter("cy2"));
    	   System.out.println(request.getParameter("cm2"));
    	   System.out.println(request.getParameter("ck2"));
    	   System.out.println(cy2);
    	   System.out.println(cm2);
    	   System.out.println(ck2);
    	   //变更项目状态,状态限制在已超时,已结束2种
    	   NewProject changeproject = (NewProject)projectdao.getObjectById(NewProject.class, pid);
    	   System.out.println(project.getProjectstatus());
    	   changeproject.setProjectstatus(project.getProjectstatus());
    	   projectdao.updateObj(changeproject);
    	   
   		 List prjdeptlist= projectdao.getPrjdept(pid);
   		 if(prjdeptlist!=null && cm2!=null && !"".equals(cm2)){
 //  		 projectdao.deletePrjdept(pid);
   		//修改参与部门
   		String[] str = cm2.split(",");
   		for(int i=0;i<str.length;i++){
   			NewPrjdept d = new NewPrjdept();
   			int deptid = Integer.parseInt(str[i]);
   			Department dept=(Department)projectdao.getObjectById(Department.class,deptid);
   			d.setDept(dept);
   			NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
   			d.setProject(newprj);
   			projectdao.addPrjdept(d);
   		}
   		 }
   		//修改查看者
   		 List prjemplist = projectdao.getPrjwatch(pid);
   		 if(prjemplist!=null && ck2!=null && !"".equals(ck2)){
   		projectdao.deletePrjwatch(pid);
   		System.out.println(ck2);
   		 String[] str2 = ck2.split(",");
   		 for(int i=0;i<str2.length;i++){
   			 NewWatch d = new NewWatch();
   				int empid = Integer.parseInt(str2[i]);
   				Employee emp=(Employee)projectdao.getObjectById(Employee.class,empid);
   				d.setEmp(emp);
   				NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
   				d.setProject(newprj);
   				projectdao.addPrjWatcher(d);
   		 }
   		 }
   		 
   		 // 修改参与人
   		 List cyrlist = projectdao.getCyr(pid);
   		 if(cy2!=null && !"".equals(cy2)){
 //  			 projectdao.deleteCyr(pid);
   			 System.out.println(cy2);
   			 String[] cyemp = cy2.split(",");
   			 for(int i=0;i<cyemp.length;i++){
   				 NewParticipator p = new NewParticipator();
   				 int empid = Integer.parseInt(cyemp[i]);
   				 Employee employee = (Employee)projectdao.getObjectById(Employee.class, empid);
   				 p.setEmployee(employee);
   				 NewProject project = (NewProject)projectdao.getObjectById(NewProject.class, pid);
   				 p.setProject(project);
   				 p.setIsagree(0);
   				 projectdao.addCyr(p);
   			 }
   		 }
   		 
   	//发送短消息(对参与人员),先向message表写入数据,messageid有值后再向messagereceiver表写数据
			Messagetype sendertype = (Messagetype)projectdao.getObjectById(Messagetype.class, 1);  //sendertype员工消息
			Messagetype messagetype = (Messagetype)projectdao.getObjectById(Messagetype.class, 28); //messagetype 消息类型:个人公公
			Employee employee = projectdao.getEmployeeByEmpNo(empnum);
			String sender = employee.getId().toString();
			System.out.println(employee.getId().toString());
			Message mess = new Message();
			mess.setSender(sender);  //发送人(当前登录人ID)
			mess.setMessagetypeBySendertype(sendertype); //发送类型:员工消息
			mess.setMessagetypeByMessagetype(messagetype);//消息类型:个人公告
			mess.setTitleweb("项目变更");
			mess.setMessagecontent("项目变更,邀请您参与此项目");
			mess.setRepealfalg("0"); //是否撤销 0为否 	 1为是
			mess.setDelfalg("0"); //删除标识
			mess.setDraftfalg("0"); //草稿标识
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String releasetime = sdf.format(now);
			mess.setReleasetime(Timestamp.valueOf(releasetime));
			mess.setTmp1("0");
			projectdao.add(mess);
			
			//消息表有PK之后,再向接收消息表写入记录
			int messageid = mess.getMessageid();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String receivertime = dateFormat.format(date);
			String[] projectcyr = cy2.split(",");
			for(int i=0;i<projectcyr.length;i++){
				Messagereceiver receiver = new Messagereceiver();
				receiver.setMessage(mess);
				receiver.setMessagetype(sendertype);
				receiver.setReceiverer(projectcyr[i]);
				receiver.setReceivetime(Timestamp.valueOf(releasetime));
				receiver.setReadfalg("0"); //是否读取 未读取0
				receiver.setDelfalg("0"); //删除标识 没有0
				receiver.setTmp1("0");  //0是员工 1是客户
				receiver.setTmp2("project");
				//根据项目ID取到项目对象
				NewProject project=(NewProject)projectdao.getObjectById(NewProject.class,pid);
				receiver.setProject(project);
				projectdao.add(receiver);
			}   // ===========>发消息完毕
   		return "selectListaa";
   	}
       
       /**
   	 * 点击项目状态为已超时的变更,提取数据
   	 * @author 袁天龙
   	 * @return
   	 */
       public String tochange2(){
   		typelist = projectdao.getPrjType("from Missiontype where isflag=2"); //项目类型
   		project = (NewProject)projectdao.getObjectById(NewProject.class, pid);	
   		List prjdeptlist= projectdao.getPrjdept(pid);  //修改时，得到该项目的参与部门
   		
   		
   		int d=0;
   		String deptid="";
   		for(int i=0;i<prjdeptlist.size();i++){
   			NewPrjdept newdept = (NewPrjdept)prjdeptlist.get(i);
   			d=newdept.getDept().getId();
   			deptid+=","+d;
   		}
   		
//   		String[] deptids = did.split(",");
//   		int ids=0;
//   		String id="";
//   		for(int i=0;i<deptids.length;i++){
//   			ids = Integer.parseInt(deptids[i]);
//   			id+=","+ids;
//   		}
//   		String departmentid = id.replaceFirst(",", "");
   		String dept = deptid.replaceFirst(",", "");
   		List prjemplist = projectdao.getPrjwatch(pid); //修改时，得到该项目的查看者
   		List cyrlist = projectdao.getCyr(pid);
   		List emplist2 = projectdao.getAllEmps("from Employee where isLeave=1 and delflag=0"); //所有员工
   		List dlist = projectdao.getAllDepts("from Department where id not in(0,1,"+dept+")"); //去除已经选中的部门
   		List elist = projectdao.getAllEmps("from Employee where isLeave=1 and delflag=0");
   		request.setAttribute("project", project);
   		request.setAttribute("typelist", typelist);
   		request.setAttribute("project", project);
   		request.setAttribute("emplist2", emplist2);
   		request.setAttribute("dlist", dlist);
   		request.setAttribute("elist", elist);
   		request.setAttribute("prjdeptlist", prjdeptlist);
   		request.setAttribute("prjemplist", prjemplist);
   		request.setAttribute("cyrlist", cyrlist);
   	//	empnum=request.getSession().getAttribute("loginName").toString();
   		return "change2";
   	}
          
          /**
           * 变更状态为已超时的项目
           * @return
           */
          public String change2() throws Exception{
        	System.out.println(cm2);
      		System.out.println(ck2);
      		System.out.println(cy2);
      		int pid = project.getId();
      		NewProject oldproject = (NewProject)projectdao.getObjectById(NewProject.class, pid);
      		 oldproject.setEndtime(project.getEndtime());
      		 oldproject.setProjectstatus(project.getProjectstatus());
      		 projectdao.updateObj(oldproject);
      		 
      		 
      		 
      		//修改参与部门
      		 List prjdeptlist= projectdao.getPrjdept(pid);
      		 if(prjdeptlist!=null && cm2!=null && !"".equals(cm2)){
      //		 projectdao.deletePrjdept(pid);
      		String[] str = cm2.split(",");
      		for(int i=0;i<str.length;i++){
      			NewPrjdept d = new NewPrjdept();
      			int deptid = Integer.parseInt(str[i]);
      			Department dept=(Department)projectdao.getObjectById(Department.class,deptid);
      			d.setDept(dept);
      			NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
      			d.setProject(newprj);
      			projectdao.addPrjdept(d);
      		}
      		 }
      		//修改查看者
      		 List prjemplist = projectdao.getPrjwatch(pid);
      		 if(prjemplist!=null && ck2!=null && !"".equals(ck2)){
      		projectdao.deletePrjwatch(pid);
      		System.out.println(ck2);
      		 String[] str2 = ck2.split(",");
      		 for(int i=0;i<str2.length;i++){
      			 NewWatch d = new NewWatch();
      				int empid = Integer.parseInt(str2[i]);
      				Employee emp=(Employee)projectdao.getObjectById(Employee.class,empid);
      				d.setEmp(emp);
      				NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
      				d.setProject(newprj);
      				projectdao.addPrjWatcher(d);
      		 }
      		 }
      		 
      		 //修改参与人
     // 		 List cyrlist = projectdao.getCyr(pid);
      		 if(cy2!=null && !"".equals(cy2)){
      	//		 projectdao.deleteCyr(pid);
      			 System.out.println(cy2);
      			 String[] cyr = cy2.split(",");
      			 for(int i=0;i<cyr.length;i++){
      				 NewParticipator p = new NewParticipator();
      				 int empid = Integer.parseInt(cyr[i]);
      				 Employee employee = (Employee)projectdao.getObjectById(Employee.class, empid);
      				 p.setEmployee(employee);
      				 NewProject np = (NewProject)projectdao.getObjectById(NewProject.class, pid);
      				 p.setProject(np);
      				 p.setIsagree(0);
      				 projectdao.addCyr(p);
      			 }
      			 
      			//发送短消息(对参与人员),先向message表写入数据,messageid有值后再向messagereceiver表写数据
     			Messagetype sendertype = (Messagetype)projectdao.getObjectById(Messagetype.class, 1);  //sendertype员工消息
     			Messagetype messagetype = (Messagetype)projectdao.getObjectById(Messagetype.class, 28); //messagetype 消息类型:个人公公
     			Employee employee = projectdao.getEmployeeByEmpNo(empnum);
     			String sender = employee.getId().toString();
     			System.out.println(employee.getId().toString());
     			Message mess = new Message();
     			mess.setSender(sender);  //发送人(当前登录人ID)
     			mess.setMessagetypeBySendertype(sendertype); //发送类型:员工消息
     			mess.setMessagetypeByMessagetype(messagetype);//消息类型:个人公告
     			mess.setTitleweb("项目变更(已超时)");
     			mess.setMessagecontent("变更已超时项目,邀请您参与");
     			mess.setRepealfalg("0"); //是否撤销 0为否 	 1为是
     			mess.setDelfalg("0"); //删除标识
     			mess.setDraftfalg("0"); //草稿标识
     			Date now = new Date();
     			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     			String releasetime = sdf.format(now);
     			mess.setReleasetime(Timestamp.valueOf(releasetime));
     			mess.setTmp1("0");
     			projectdao.add(mess);
     			
     			//消息表有PK之后,再向接收消息表写入记录
     			int messageid = mess.getMessageid();
     			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
     			Date date = new Date();
     			String receivertime = dateFormat.format(date);
     			String[] projectcyr = cy2.split(",");
     			for(int i=0;i<projectcyr.length;i++){
     				Messagereceiver receiver = new Messagereceiver();
     				receiver.setMessage(mess);
     				receiver.setMessagetype(sendertype);
     				receiver.setReceiverer(projectcyr[i]);
     				receiver.setReceivetime(Timestamp.valueOf(releasetime));
     				receiver.setReadfalg("0"); //是否读取 未读取0
     				receiver.setDelfalg("0"); //删除标识 没有0
     				receiver.setTmp1("0");  //0是员工 1是客户
     				receiver.setTmp2("project");
     				//根据项目ID取到项目对象
     				NewProject project=(NewProject)projectdao.getObjectById(NewProject.class,pid);
     				receiver.setProject(project);
     				projectdao.add(receiver);
     			}   // ===========>发消息完毕
      		 }
      		return list();
        	}
          
          /**
           * 项目详细信息
           * @author 袁天龙
           * @return
           */
          public String projectInfo(){
        	  System.out.println("proid="+proid);
        	  NewProject np = (NewProject)projectdao.getObjectById(NewProject.class, proid);
        	  String projectstatus=request.getParameter("projectstatus");
        	  //String hql="from NewDocument where newProject.id="+proid;
        	  String hql2="from CommonScfjb where tmp1="+proid+" and tmp='Project'";
        	  List CommonScfjblist=projectdao.execHQL(hql2);
        	  String hql1="from NewFunction where pid="+proid;
        	  List functionlist=projectdao.execHQL(hql1);
        	 //List newdocuments= projectdao.execHQL(hql);
        	  List prjdeptlist= projectdao.getPrjdept(proid);  //修改时，得到该项目的参与部门
      		  List prjemplist = projectdao.getPrjwatch(proid); //修改时，得到该项目的查看者
      		  List cyrlist = projectdao.getCyr(proid);
      		  request.setAttribute("projectdao", projectdao);
        	  request.setAttribute("p", np);
        	  //request.setAttribute("newdocuments", newdocuments);
        	  request.setAttribute("CommonScfjblist", CommonScfjblist);
        	  request.setAttribute("d",prjdeptlist);
        	  request.setAttribute("e", prjemplist);
        	  request.setAttribute("cyrlist", cyrlist);
        	  request.setAttribute("status", projectstatus);
        	  request.setAttribute("functionlist", functionlist);
        	  return "info";
          }
         
          /**
           * 读取属于当前登陆人的项目消息
           * @author 袁天龙
           * @return
           */
          public String showMessage(){
        	  String empname="";
        	  String empNoString ="";
        	  if(request.getSession().getAttribute("loginName")==null){
        		  Employee emp=(Employee)request.getSession().getAttribute("emp");
        		  empNoString=emp.getEmpNo();
        		  
        	  }
        	  else{
        	   empNoString = request.getSession().getAttribute("loginName").toString();
        	  }
        	  Employee employeeString = projectdao.getEmployeeByEmpNo(empNoString);
        	  //List messlist = projectdao.empOfMessage(String.valueOf(employeeString.getId()));
        	  String hql="from Messagereceiver r where r.delfalg=0 " +
				" and r.readfalg=0 and r.tmp2='project' and r.receiverer='"+String.valueOf(employeeString.getId())+"' order by id desc";
        	 // System.out.println(messlist.size());
        	  String pageNo=request.getParameter("pageNo");
      		  if(null == pageNo){
      			pageNo ="1";
      		  }
      		  Pages page=null;
      		 page=projectdao.paginationQuery(hql, Integer.parseInt(pageNo), 10, null);
			 int n=Integer.parseInt(pageNo);
			// 算出从第几页开始
			// int pyno=(n-1)*10;
			// 分页后的集合。
			 List pagetask=new ArrayList();
			// 封装集合。
			 
				request.setAttribute("pages", page);
				request.setAttribute("recordlist", page.getPageList());
           
        	  
        	  
        	  request.setAttribute("employee", employeeString);
        	  return "empOfmessage";
          }
          
          /**
           * 登陆人同意参与项目
           * @return
           */
          public String agree() throws Exception{
        	  response.setCharacterEncoding("utf-8");
        	  String flag = "";
        	  PrintWriter out = response.getWriter();
        	
        	  String empno ="";
        	  if(request.getSession().getAttribute("loginName")==null){
        		  Employee emp=(Employee)request.getSession().getAttribute("emp");
        		  empno=emp.getEmpNo();
        		  
        	  }
        	  else{
        		  empno = request.getSession().getAttribute("loginName").toString();
        	  }
        	  
        	 
        	  Employee e = projectdao.getEmployeeByEmpNo(empno);
        	  System.out.println(messpid);
        	  List list = projectdao.getNewParticipatorByEmpidAndPid(e.getId(), messpid);
        	  if(list.size()>0){
        	    NewParticipator par = (NewParticipator)list.get(0);
        	    par.setIsagree(2);
        	    projectdao.updateObj(par);
        	    flag+="SUCCE";
        	  }
        	  
        	  List messlist = projectdao.getMessreceiverByPid(String.valueOf(e.getId()),messpid);
        	  if(messlist.size()>0){
        	    Messagereceiver mr = (Messagereceiver)messlist.get(0);
        	    mr.setReadfalg("1");
        	    projectdao.updateObj(mr);
        	    flag+="SS";
        	  }
        	  if(flag.equals("SUCCESS")){
        		 out.print("SUCCESS");  
        	  }else{
        		  out.print("ERROR");
        	  }
        	  
        	  return null;
          }
          
          /**
           * 登陆人点击拒绝
           * @return
           */
          public String unagree() throws Exception{
        	  response.setCharacterEncoding("utf-8");
        	  String flag = "";
        	  PrintWriter out = response.getWriter();

        	  String empno ="";
        	  if(request.getSession().getAttribute("loginName")==null){
        		  Employee emp=(Employee)request.getSession().getAttribute("emp");
        		  empno=emp.getEmpNo();
        		  
        	  }
        	  else{
        		  empno = request.getSession().getAttribute("loginName").toString();
        	  }
        	  
        	  Employee e  = projectdao.getEmployeeByEmpNo(empno);
              System.err.println(messpid2);
              List list = projectdao.getNewParticipatorByEmpidAndPid(e.getId(), messpid2);
              if(list.size()>0){
                NewParticipator np = (NewParticipator)list.get(0);
                np.setIsagree(0);
                projectdao.updateObj(np);
                flag+="SUCCE";
              }
              
              List messlist = projectdao.getMessreceiverByPid(String.valueOf(e.getId()),messpid2);
              if(messlist.size()>0){
              Messagereceiver mr = (Messagereceiver)messlist.get(0);
              mr.setReadfalg("1");
              projectdao.updateObj(mr);
              flag+="SS";
              }
              if(flag.equals("SUCCESS")){
            	out.print("SUCCESS");  
              }else{
            	  out.print("ERROR");
              }    
        	  return null;
          }
          
          
          
          
      	public String upd2() throws Exception{
    		String iscommit = request.getParameter("iscommit");
    		
    		String moneystr=request.getParameter("money");
    		double money=0;
    		if(moneystr!=null){
    			money=Double.parseDouble(moneystr);
    		}
    		String cybm2 = request.getParameter("cybm2"); //参与部门
    		String ckz2 = request.getParameter("ckz2"); //查看者
    		String cc = request.getParameter("projectname");
    		String projectname = URLDecoder.decode(cc,"utf-8");
    		String projecttype = request.getParameter("projecttype"); //类型
      		String begintime = request.getParameter("begintime"); //开始时间
      		String endtime = request.getParameter("endtime"); //结束时间
      		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		
      		
      		
      		System.out.println(project.getEmployee().getId());
    		//项目类型
    		Missiontype missiontype = (Missiontype)projectdao.getObjectById(Missiontype.class, Integer.parseInt(projecttype));
    		int pid = project.getId();
    		NewProject oldproject = (NewProject)projectdao.getObjectById(NewProject.class, pid);
    		int approve_id = project.getId();
    		NewProject app_project = (NewProject)projectdao.getObjectById(NewProject.class, approve_id);
    		List applist = projectdao.getApproveByPid(approve_id); //根据项目ID查询审批表这个项目对象
    		System.out.println(applist.size());

    		 oldproject.setProjectname(projectname);
    		 oldproject.setMissiontype(missiontype);
    		 oldproject.setBegintime(sdf.parse(begintime));
    		 oldproject.setEndtime(sdf.parse(endtime));
    		 oldproject.setMoney(money);
    		 projectdao.updateObj(oldproject);
    		 System.out.println(oldproject.getProjectstatus());
 		   
    		 //如果审批表没有这个项目,就向审批表写入改项目信息
    		 if(Integer.parseInt(iscommit)==1 && applist.size()<=0){  //用户选择提交审批,且审批记录没有该条记录
    			 Employee apply = projectdao.getEmployeeByEmpNo(empnum);
    			 NewApprove ap = new NewApprove();
    			 ap.setApplypeople(apply);
    			 Date date = new Date();
    			 Date now = sdf.parse(sdf.format(date));
    			 Date now2 = sdf.parse(sdf.format(date));
    			 ap.setBegintime(now);
    			 ap.setEndtime(now2);
    		     ap.setAppstatus(0);
    			 ap.setNewproject(oldproject);
    			 ap.setApproveemp(oldproject.getEmployee());
    			 //加入审批领导记录ID
    			 ap.setAppLD(project.getEmployee().getId().toString());
    			 projectdao.add(ap);
    			 //把状态改为审批中
    			 oldproject.setProjectstatus(1);
    			 projectdao.updateObj(oldproject);
    		 }
    		 if(Integer.parseInt(iscommit)==1 && applist.size()>0){
    			 int eid = oldproject.getEmployee().getId();
    			 System.out.println(eid);
    			 NewApprove ap=projectdao.appByPid(pid, oldproject.getEmployee().getId());
    			 int appid=oldproject.getEmployee().getId();
    			 while(ap==null){
    				 Employee emp=getZG(appid);
    				 ap= projectdao.appByPid(pid,emp.getId());
    				 if(ap==null){
    					 appid=emp.getId();
    					 continue;
    				 }
    			 }
    			 ap.setAppstatus(0);
    			 projectdao.add(ap);
    			 //把状态改为审批中
    			 oldproject.setProjectstatus(1);
    			 projectdao.updateObj(oldproject);
    		 }

    		 
    		 List prjdeptlist= projectdao.getPrjdept(pid);
    		 if(prjdeptlist!=null && cybm2!=null && !"".equals(cybm2)){
    		 projectdao.deletePrjdept(pid);
    		//修改参与部门
    		String[] str = cybm2.split(",");
    		for(int i=0;i<str.length;i++){
    			NewPrjdept d = new NewPrjdept();
    			int deptid = Integer.parseInt(str[i]);
    			Department dept=(Department)projectdao.getObjectById(Department.class,deptid);
    			d.setDept(dept);
    			NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
    			d.setProject(newprj);
    			projectdao.addPrjdept(d);
    		}
    		 }
    		//修改查看者
    		 List prjemplist = projectdao.getPrjwatch(pid);
    		 if(prjemplist!=null && ckz2!=null && !"".equals(ckz2)){
    		projectdao.deletePrjwatch(pid);
    		System.out.println(ck2);
    		 String[] str2 = ckz2.split(",");
    		 for(int i=0;i<str2.length;i++){
    			 NewWatch d = new NewWatch();
    			 int empid = Integer.parseInt(str2[i]);
    			 Employee emp=(Employee)projectdao.getObjectById(Employee.class,empid);
    			 d.setEmp(emp);
    			 NewProject newprj=(NewProject)projectdao.getObjectById(NewProject.class,pid);
    			 d.setProject(newprj);
    			 projectdao.addPrjWatcher(d);
    		 }
    		 }
    		 
    		//修改附件(先删除,再添加)
    		 String files=(String)request.getSession().getAttribute("files");
    	if(!"".equals(files) && files!=null){
    		
 			projectdao.deleteDocument(pid);
 			if(request.getSession().getAttribute("files")!=null){
				String fileNames=request.getSession().getAttribute("fileNames").toString();//真实文件名
				String fjhzname=request.getSession().getAttribute("fjhzname").toString();
				String sfileNames=new String(fileNames.getBytes("ISO-8859-1"), "UTF-8");
				request.getSession().removeAttribute(fileNames);
				logger.error("pjaciton---2");
				String paths=request.getSession().getAttribute("files").toString();
				String[] file=paths.split(",");
				logger.error("pjaciton---3");
				for(int i=0;i<file.length;i++){
					//NewDocument d=new NewDocument();
					String filestr=file[i];
					String filetrue=sfileNames.split(",")[i];
					//d.setFilepath(filestr);
					//d.setFilename(filetrue);
					//d.setNewProject(project);
					//projectdao.addFj(d);
					String extName=fjhzname.split(",")[i];
					//String extName=filetrue.split(".")[1];
					String trueName=filetrue.split(extName)[0];
					String fjhz=extName.substring(1);
					projectdao.addFJ2(filestr,"Project",trueName,fjhz,project.getId().toString());
					
				}
				logger.error("pjaciton---4");
		        // 清除session缓存
				request.getSession().removeAttribute("files");
				request.getSession().removeAttribute("filedata");
				logger.error("2pjaciton---4");
 			}
    	 }
    		return null;
    	}
      	
      	/***********
      	 * 项目甘特图
      	 */
      	 public String projectGTT(){
      		// 创建document对象
      		Document doc1 = Dom4jUtil.createDocument();
    		Element gb=doc1.addElement("GanttChart");
    		gb.addAttribute("FileName", "*.xml");
    	    Element bck=gb.addElement("Background");
    	    Element sol=bck.addElement("SolidColor");
    	    sol.addText("#00FFFFFF");
    	    Element font=gb.addElement("Font");
    	    font.addAttribute("Family", "宋体");
    	    font.addAttribute("Size", "12");
    	    Element col= font.addElement("Color");
    	    Element fcol=col.addElement("SolidColor");
    	    fcol.addText("#000000");
    		Element e = gb.addElement("Columns");
            Element e1= e.addElement("GanttColumn");
            e1.addAttribute("FieldName", "Name");
            e1.addAttribute("Title", "项目名称");
            Element e2=e.addElement("GanttColumn");
            e2.addAttribute("FieldName", "PercentComplete");
            e2.addAttribute("Title", "完成进度");
            Element e3=e.addElement("GanttColumn");
            e3.addAttribute("FieldName", "Start");
            e3.addAttribute("Title", "开始时间");
            Element e4=e.addElement("GanttColumn");
            e4.addAttribute("FieldName", "Finish");
            e4.addAttribute("Title", "完成时间");
            Element e5=e.addElement("GanttColumn");
            e5.addAttribute("FieldName", "Resources");
            e5.addAttribute("Title", "任务备注");
      		
            // 任务根节点
            Element tasks=gb.addElement("Tasks");
      		 // 得到所有正在进行中或已结束的项目
      		String hql="from NewProject where isdel=0 and projectstatus IN(2,3,4)";
      		List prjlist= projectdao.getAllProjects(hql);
      		// 得到每个项目下面的功能模块
      		for(int i=0;i<prjlist.size();i++){
      			NewProject project=(NewProject)prjlist.get(i);
      			// 不回项目节点
      			Element gant=tasks.addElement("GanttTask");
      			gant.addAttribute("Id", (i+1)+"");//唯一标识
      			gant.addAttribute("Name", project.getProjectname()); // 项目名称
      			gant.addAttribute("OutlineNumber", (i+1)+""); // 项目关联关系
      			gant.addAttribute("OutlineLevel", (i+1)+"");
      			gant.addAttribute("Resources", "项目："+project.getProjectname());
      			gant.addAttribute("Start", project.getBegintime().toString());
      			gant.addAttribute("Finish", project.getEndtime().toString());
      			gant.addAttribute("PercentComplete", project.getSchedule().toString());
      			
      			List funlist=projectdao.prjtask(project.getId());
      			// 得到功能对象
      			for(int j=0;j<funlist.size();j++){
      				NewFunction function=(NewFunction)funlist.get(j);
      				// 添加功能任务节点
      				gant=tasks.addElement("GanttTask");
      				gant.addAttribute("Id", (i+1)+"."+(j+1));//唯一标识
      				gant.addAttribute("Name", function.getFunctionname());
      				gant.addAttribute("OutlineNumber", (i+1)+"."+(j+1));
      				gant.addAttribute("OutlineLevel", (j+1)+"");
      				gant.addAttribute("Resources", "任务："+function.getFunctionname());
      				gant.addAttribute("Start", function.getBegintime().toString());
      				gant.addAttribute("Finish", function.getEndtime().toString());
      				gant.addAttribute("PercentComplete", function.getFstate().toString());
  					gant.addAttribute("PredecessorLink", (i+1)+"");
      				// 添加每个功能任务下面的子任务节点，根据得到function找其对应的子类
  					hql="from NewFunction where flag=0 and parentid="+function.getId(); 
  					List parentlist=projectdao.execHQL(hql);
  					if(parentlist.size()>0){
	  					for(int n=0;n<parentlist.size();n++){
	  						NewFunction parentfun=(NewFunction)parentlist.get(n);
	  	      				// 添加功能任务节点
	  	      				gant=tasks.addElement("GanttTask");
	  	      				gant.addAttribute("Id", (i+1)+"."+(j+1)+"."+(n+1));//唯一标识
	  	      				gant.addAttribute("Name", parentfun.getFunctionname());
	  	      				gant.addAttribute("OutlineNumber", (i+1)+"."+(j+1)+"."+(n+1));
	  	      				gant.addAttribute("OutlineLevel", (n+1)+"");
	  	      				gant.addAttribute("Resources", "任务："+parentfun.getFunctionname());
	  	      				gant.addAttribute("Start", parentfun.getBegintime().toString());
	  	      				gant.addAttribute("Finish", parentfun.getEndtime().toString());
	  	      				gant.addAttribute("PercentComplete", parentfun.getFstate().toString());
	  	  					gant.addAttribute("PredecessorLink", (i+1)+"."+(j+1));
	  	  					
	  	  				    // 得到这个任务下面的所有执行人
	  	      				List tasklist=projectdao.taskByFid(parentfun.getId());
	  	      				for(int m=0;m<tasklist.size();m++){
	  	      					NewTask task=(NewTask)tasklist.get(m);
	  	      					// 添加任务执行人对象
	  	      					gant=tasks.addElement("GanttTask");
	  	      					gant.addAttribute("Id", (i+1)+"."+(j+1)+"."+(n+1)+"."+(m+1));//唯一标识
	  	      					gant.addAttribute("Name", task.getEmp().getName());
	  	      					gant.addAttribute("OutlineNumber", (i+1)+"."+(j+1)+"."+(n+1)+"."+(m+1));
	  	      					gant.addAttribute("OutlineLevel", (m+1)+"");
	  	      					gant.addAttribute("Resources", "执行人："+task.getEmp().getName());
	  	      					gant.addAttribute("Start", task.getBegintime().toString());
	  	      					gant.addAttribute("Finish", task.getEndtime().toString());
	  	      					gant.addAttribute("PercentComplete", task.getSchedule().toString());
	  	      					gant.addAttribute("PredecessorLink", (i+1)+"."+(j+1)+"."+(n+1));
	  	      				}
	  					}
  					}else{
	      				// 得到这个任务下面的所有执行人
	      				List tasklist=projectdao.taskByFid(function.getId());
	      				for(int m=0;m<tasklist.size();m++){
	      					NewTask task=(NewTask)tasklist.get(m);
	      					// 添加任务执行人对象
	      					gant=tasks.addElement("GanttTask");
	      					gant.addAttribute("Id", (i+1)+"."+(j+1)+"."+(m+1));//唯一标识
	      					gant.addAttribute("Name", task.getEmp().getName());
	      					gant.addAttribute("OutlineNumber", (i+1)+"."+(j+1)+"."+(m+1));
	      					gant.addAttribute("OutlineLevel", (m+1)+"");
	      					gant.addAttribute("Resources", "执行人："+task.getEmp().getName());
	      					gant.addAttribute("Start", task.getBegintime().toString());
	      					gant.addAttribute("Finish", task.getEndtime().toString());
	      					gant.addAttribute("PercentComplete", task.getSchedule().toString());
	      					gant.addAttribute("PredecessorLink", (i+1)+"."+(j+1));
	      				}
  					}
      				
      			}
      		}

      		ActionContext ac=ActionContext.getContext();
      		ServletContext sc = (ServletContext) ac.get(ServletActionContext.SERVLET_CONTEXT);
      		String savePath = sc.getRealPath("/");
      		System.out.println(savePath);
      		String gttpath=savePath+"bin-release\\\\en_US\\\\Engineering3.xml";
      		System.out.println(gttpath);
      		Dom4jUtil.docToXmlFile(doc1, gttpath);
      		
      		return "gtt";
      	 }
      	 
      	 /*********
      	  * 根据员工编号找出对应得主管
      	  */
      	 public Employee getZG(int empid){
      	// 根据人员编号得到部门
				String hql="select e.department from Employee e where e.id="+empid;
				List deptlist=projectdao.execHQL(hql);
				// 审批人
				Employee approveemp=null;
				if(deptlist!=null && deptlist.size()>0){
					Department dept=(Department)deptlist.get(0);
					if(dept.getEmployee()!=null){
						approveemp=dept.getEmployee();// 这个就是上级人员
					}
				}
				return approveemp;
      	 }
      	
      	 //消息列表页面,用户点击办理
      	 public String addcyr() throws Exception{
      		 response.setCharacterEncoding("utf-8");
      		 PrintWriter out = response.getWriter();
      		 empid = request.getParameter("empid");
      		 projectid = request.getParameter("projectid");
      		 NewProject p = (NewProject)projectdao.getObjectById(NewProject.class, Integer.parseInt(projectid));
      		 Employee e = (Employee)projectdao.getObjectById(Employee.class, Integer.parseInt(empid));
      		 System.out.println(empid);
      		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		 String[] id = empid.split(",");
      		 for(int i=0;i<id.length;i++){
      			 // 12.25 接着做
      			 System.out.println(id[i]);
      			 NewParticipator part = new NewParticipator();
      			 part.setProject(p);
      			 part.setEmployee(e);
      			 Date date = new Date();
      			 part.setInvitetime(sdf.format(date));
      			 part.setContent("协助他们完成项目...");
      			 part.setIsagree(2);
      			 projectdao.add(part);
      		 }
      		 return null;
      	 }
		public LoginDao getLoginDao() {
			return loginDao;
		}
		public void setLoginDao(LoginDao loginDao) {
			this.loginDao = loginDao;
		}
	
      	 
      	
      
}
