package com.fuao.fajxc.action.basic;

import java.beans.Encoder;
import java.io.IOException;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.util.SubsetIteratorFilter.Decider;

import com.fuao.fajxc.action.LoginAction;
import com.fuao.fajxc.action.common.FJCommonAction;
import com.fuao.fajxc.action.mission.MissiontypeAction;
import com.fuao.fajxc.bussiness.basic.DepartmentBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.MyProperties;
import com.fuao.fajxc.util.PageBean;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Messagetype;
import com.fuao.fajxc.vo.Workgrade;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class DepartmentAction extends ActionSupport implements ServletRequestAware, ModelDriven,
		ServletResponseAware {

	private static Logger logger = Logger.getLogger(LoginAction.class);
	private DepartmentBussiness departBussiness;
	private EmployeeBussiness empBussiness;
	private int page; // 第几页
	private PageBean pagebean;
	private MissiontypeAction mty;
	private HttpServletRequest request;
	private Department depart;
	private HttpServletResponse response;
	private Object[] ids;
	private GroupSystemBussiness groupSystemBussiness;
	private CommonBiz commonbiz;
	
	public CommonBiz getCommonbiz() {
		return commonbiz;
	}

	public void setCommonbiz(CommonBiz commonbiz) {
		this.commonbiz = commonbiz;
	}

	public GroupSystemBussiness getGroupSystemBussiness() {
		return groupSystemBussiness;
	}

	public void setGroupSystemBussiness(GroupSystemBussiness groupSystemBussiness) {
		this.groupSystemBussiness = groupSystemBussiness;
	}

	//记录动态
	private ExecuteRecordBussiness executeRecordBussiness;

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids
	 *            the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the empBussiness
	 */
	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}

	/**
	 * @param empBussiness
	 *            the empBussiness to set
	 */
	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @param page
	 *            the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}

	/**
	 * @return the departBussiness
	 */
	public DepartmentBussiness getDepartBussiness() {
		return departBussiness;
	}

	/**
	 * @param departBussiness
	 *            the departBussiness to set
	 */
	public void setDepartBussiness(DepartmentBussiness departBussiness) {
		this.departBussiness = departBussiness;
	}

	/**
	 * 分页查找
	 * 
	 * @return
	 */
	public String select() {
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找
		String sjNo=request.getParameter("dname");
		
		if(sjNo!=null&&sjNo!=""){
			addhql+=" and name like '%"+sjNo+"%'";
		}
		String hql="from Department where delflag=0"+addhql+" order by id desc";
		Pages pages=departBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		
		//获得所有部门
		List<Department> depList=departBussiness.getalldept("");
		request.setAttribute("alldep", depList);
		
		return "success";
	}

	/**
	 * 
	 * 跳转到添加部门页面时查找主管信息
	 * 
	 * @return
	 */
	public String showemp() {
		//获得所有部门
		List<Department> depList=departBussiness.getalldept("");
		System.out.println("allDepSize:"+depList.size());
		request.setAttribute("alldep", depList);
		System.out.println("所有部门:"+depList.toString());
//		List groupList=groupSystemBussiness.getObject("Groups", "and  superGroupId=1");
//		request.setAttribute("groupList", groupList);
		return "depShow";
	}

	/**
	 * 添加部门
	 * 
	 * @return
	 */
	public String add() {
		if(depart.getEmployee().getId()==null){
			Employee emp=null;
			depart.setEmployee(emp);
		}
		//判断是否为分公司部门
		String parenttext=request.getParameter("ptext");
		System.out.println("ptext::::::::::::"+parenttext);
		String fmark=request.getParameter("fmark");
		if(parenttext!=null && !parenttext.equals("") && fmark!=null && !fmark.equals("")){
			depart.setFilialemark(parenttext+fmark);
		}else if(fmark!=null && !fmark.equals("")){
			depart.setFilialemark(fmark);
		}else{
			depart.setFilialemark(depart.getFilialemark().trim());
		}
		System.out.println("departfmark::::::::::::::"+depart.getFilialemark());
		
//		departBussiness.addOrUpdateDepartment(1, depart);
		Department department = departBussiness.addDepartment(depart);
		
		/*阙超强 14015      添加动态记录*/
		//拿到登陆员工用户
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		//添加记录到动态记录表
		if(loginEmp != null){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个部门信息。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(department.getId().toString());
			executerecord.setEntityName("Department");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "select";
	}

	public String show() {
		Integer did = Integer.parseInt(request.getParameter("id"));
		String mark = request.getParameter("mark");
		if( did != null){
			
			Department dep = departBussiness.onedep(" and id=" + did);
			
			if( "edit".equals(mark)){
				request.setAttribute("selectedid", dep.getParentId());
				request.setAttribute("onedep", dep);
			}else if("new".equals(mark)){
				request.setAttribute("selectedid", dep.getId());
			}
		}
		//获得所有部门
		List<Department> depList=departBussiness.getalldept(" and tb.id!="+did);
		request.setAttribute("alldep", depList);
		return "depShow";
	}

	public String edit() {
		response.setContentType("text/html");
		try {
			depart.setName(URLDecoder.decode(depart.getName(), "utf-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(depart.getEmployee().getId()==null){
			depart.setEmployee(null);
		}
		
		//判断是否为分公司部门
		String parenttext=request.getParameter("ptext");
		System.out.println("ptext::::::::::::"+parenttext);
		String fmark=request.getParameter("fmark");
		System.out.println("fmark::::::::::::"+fmark);
		
		if(parenttext!=null && !parenttext.equals("") && fmark!=null && !fmark.equals("")){
			depart.setFilialemark(parenttext+fmark);
		}else if(fmark!=null && !fmark.equals("")){
			depart.setFilialemark(fmark);
		}else{
			depart.setFilialemark(depart.getFilialemark().trim());
		}
		System.out.println("departfmark::::::::::::::"+depart.getFilialemark());
		
		boolean flag = departBussiness.addOrUpdateDepartment(2, depart);
		System.out.println(flag);
		try {
			if (flag) {
				/*阙超强 14015      添加动态记录*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个部门信息。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(depart.getId().toString());
					executerecord.setEntityName("Department");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (Exception ex) {
			logger.error("修改返回错误！", ex);
			ex.printStackTrace();
		}
		return null;
	}

	public String del() {
		boolean flag = departBussiness.delEmp(ids);
		try {
			if (flag) {
				/*阙超强 14015      添加动态记录*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一些部门信息。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Department");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (Exception ex) {
			logger.error("删除时错误！", ex);
			ex.printStackTrace();
		}
		return null;
	}

	public String like() {
		String ename = request.getParameter("ename");
		try {
			ename = new String(ename.getBytes("ISO-8859-1"), "GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String hql = " and name like '%" + ename + "%'";
		if (page == 0)
			page = 1;
		PageBean pb = departBussiness.selDepart(10, page, hql);
		request.getSession().setAttribute("DepartPagebean", pb);
		return "success";
	}

	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request = request;
	}

	public Object getModel() {
		depart = new Department();
		return depart;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	/*
	 * 跟据部门查找出所有部门下面所对应的员工
	 */
	public String getdeptEmp() {

		System.out.println("进入部门下所有的员工查询");
		response.setContentType("text/html;charset=GBK");
		String deptid = request.getParameter("deptid");
		System.out
				.println("deptid————————————————————————————————————————————————"
						+ deptid);
		String str = "";
		if (deptid != "") {
			Department dept = departBussiness.getDepartment(deptid);
			// 获取部门下所有的员工
			Set emps = dept.getEmployees();
			for (Object emp : emps) {
				Employee data = (Employee) emp;
				if(data.getDelflag()==0)
				{
					str += "<option value='" + data.getId() + "'>" + data.getName()
							+ "</option>";
				}
			}
			PrintWriter pw;
			try {
				pw = response.getWriter();
				if (emps.size() > 0) {
					pw.write(str);
				} else {
					pw.write("<option value=''></option>");
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}

	/*
	 * 获取到所有的部门
	 */
	public String getalldept() throws IOException {
		response.setContentType("text/html;charset=GBK");
		String str = "";
		PrintWriter pw = response.getWriter();
		List<Department> alldept = departBussiness.getalldept("");
		str += "<option value=''>请选择</option>";
		for (Department data : alldept) {
			str += "<option value='" + data.getId() + "'>" + data.getName()
					+ "</option>";
		}
		if (alldept.size() > 0) {
			pw.write(str);
		} else {
			pw.write("<option value=''></option>");
		}
		return null;
	}

	
	public String alldeptmessage(){
		List<Department> depts = departBussiness.getalldept("");
		System.out.println("进入返回部门"+depts.size());	
		request.setAttribute("depts", depts);
	//	request.getSession().setAttribute("depts", depts);
		
		return "alldept";
	}
	/**
	 * 获得所有部门
	 * @return
	 */
	public String   getAllstatistics(){	
			//获得所有部门id
			String addhql=" order by id ";
			List<Department> dlist= departBussiness.getalldept2(addhql);
			
			//如果是1，2级将全部数组放到newdatas里面
			request.setAttribute("deptlist", dlist);
			return "dtreelist";
	}
	/**
	 * 级联删除下级部门
	 * @return
	 */
	public String deljl() {
		Object[] obj=new Object[ids.length];
		List idlist= new ArrayList();
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
			idlist.add(obj[i]);
			//级联查找下级id
			List list = departBussiness.getalldept(" and parentId = "+obj[i]);
			for (int j = 0; j < list.size(); j++) {
				Department dept = (Department)list.get(i);
				idlist.add(dept.getId());
			}
		}
		
		boolean flag = departBussiness.delEmp(idlist.toArray());
		try {
			if (flag) {
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (Exception ex) {
			logger.error("删除时错误！", ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据id查找是否为分公司，是的话返回拼接代号
	 * @return
	 */
	public String checkfilial(){
		//获得父id
		response.setContentType("text/html");
		String parentid=request.getParameter("parentid");
		System.out.println("parentid::::"+parentid);
		String match="";
		
		Department dep=departBussiness.getDepartment(parentid);
		System.out.println("depfilialemark:::::::::::"+dep.getFilialemark());
		if(dep.getFilialemark()!=null && !dep.getFilialemark().equals("")){
			//System.out.println("333333333333333333333333");
			match=dep.getFilialemark();
		}
		System.out.println("match::::"+match);
		try{
			if(match!="" && !match.equals("")){
				//System.out.println("1111111111111111111111111111111");
				response.getWriter().print(match);
			}
			else{
				//System.out.println("2222222222222222222222222222222222");
				response.getWriter().print("1");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return null;
	}
	/**
	 * 以下为职位-部门功能
	 * 
	 * 
	 */
	
	/**
	 * 获得部门职位
	 */
	public String getDept(){
		String deptid = request.getParameter("deptid");
		String sql="from Department where id="+Integer.parseInt(deptid);
		List list1=empBussiness.exHql(sql);
		List<Department> l3=list1;
		request.setAttribute("deptname", l3.get(0).getName());
		if(deptid == null || deptid.equals("")){
			logger.error(this.getClass().toString()+" error:deptid is null or '' in  getDept() Method ");
			return "error";
		}
		if(!StringUtil.isNumeric(deptid)){
			logger.error(this.getClass().toString()+" error:deptid is validate numer  in  getDept() Method ");
			return "error";
		}
		List list = commonbiz.getForm("Workposition", " and department.id="+deptid);
		List list2 = commonbiz.getForm("Workgrade", " and 1=1");
		request.setAttribute("data", list);
		request.setAttribute("deptid", deptid);
		request.setAttribute("gradelist", list2);
		return "deptposition";
	}
	/**
	 * 获得部门职位jquery
	 */
	public void getDept2(){
		try {
		StringBuffer sb = new StringBuffer();
		//sb.append("");
		String deptid = request.getParameter("deptid");
		if(deptid == null || deptid.equals("")){
			logger.error(this.getClass().toString()+" error:deptid is null or '' in  getDept() Method ");
			response.getWriter().print(1);
			return ;
		}
		if(!StringUtil.isNumeric(deptid)){
			logger.error(this.getClass().toString()+" error:deptid is validate numer  in  getDept() Method ");
			response.getWriter().print(1);
			return ;
		}
		List list = commonbiz.getForm("Workposition", " and department.id="+deptid);
		for (Iterator it = list.iterator(); it.hasNext();) {
			Workposition wp = (Workposition) it.next();
			sb.append("<option value='"+wp.getId()+"'>"+wp.getName()+"</option>");
		}
		System.out.println(sb.toString());
		response.setCharacterEncoding("utf-8");
//		String st = new String(sb.toString().getBytes(),"UTF-8");
		String st = sb.toString();
//		System.out.println("---"+st);
		response.getWriter().print(st);
		return ;
		} catch (IOException e) {
			logger.error(this.getClass().toString()+" error:IOException  in  getDept() Method ");
			e.printStackTrace();
		}
		
	}
	public String str3="";
	public String selpid(int id,int pid){
		String sql="select parentId from Department where id="+id;
		List list1=empBussiness.exHql(sql);
		for (int i = 0; i < list1.size(); i++) {
			Object o=list1.get(i);
			String o1=o.toString();
			Integer o2=Integer.parseInt(o1);
			if(o2==pid){
				
				System.out.println(o2);
				str3=str3+o2+",";
				return str3;//错误
			}else{
				str3=str3+o2+",";
				selpid(o2,pid);
			}
			
			return str3;
		}

		
		
		
		return "";
	}
	/**
	 * 
	 * 关联分管岗位
	 */
	 public StringBuffer selemp(String deptid){
			
		 x.append(deptid);
		 x.append(",");
		 int dept=Integer.parseInt(deptid);
		 String hql="select id FROM Department where  parentId="+dept;
		 List dlist = empBussiness.exHql(hql);
		 String a="";
		 
		 int y=dlist.size();
		 System.out.println(y);
		 if(y>0){
			
		 for (int i = 0; i < dlist.size(); i++) {
			Object o=dlist.get(i);
			a=o.toString();
			x.append(a);
			x.append(",");
			System.out.println(a);
			 if(dlist.size()>0){
				 selemp(a);
				 System.out.println(x);
			 }
		 }}
		 System.out.println(x);
		 System.out.println(str1);
		
			return x;
		 
		 	
		 }
	private static  StringBuffer x;
	 String str1="";
	public void ispersonman(){
		try {
			str1=new String();
			str3=new String();
		String ispersonman = request.getParameter("ispersonman");//传过来的要分管的id
		String id = request.getParameter("wpid");//这个职位id
		String depid = request.getParameter("deptid");//这个职位的部门
		
		System.out.println(ispersonman);
		System.out.println(id);
		String str="";
		    int x0=Integer.parseInt(ispersonman);
		    int x1=Integer.parseInt(id);
		    int x2=Integer.parseInt(depid);
			String hql="from Workposition where department.id="+x0; //查找选中部门的主管职位加入到Str中
			List list1=empBussiness.exHql(hql);
			List<Workposition> list2=list1;
			if(list2.size()>0){
			for (int j = 0; j < list2.size(); j++) {
				Object o=list2.get(j).getIspersonman();
				Object oo=list2.get(j).getId();
				if(o!="" && o!=null){
				String o1=o.toString();
				String o2=oo.toString();
				if(o1.equals("1")){
					str=o2;
					break;
				}
				}
			}
			}
			if(str!="" && str!=null){
			String hql1="from Workposition where id="+x1;//查找这个职位的分管职位setParpostionid
			List list3=empBussiness.exHql(hql1);
			//本职位原有的分管职位
			List<Workposition> list4=list3;
			if(list4.size()>0){
			for (int i = 0; i < list4.size(); i++) {
				Object o=list4.get(i).getParpostionid();
				
				if(o !=null && !o.equals("") ){
					String o1=o.toString();
					str1=o1+",";
				}
			}
			}
			
			String ids[]=str1.split(",");//此职位数据库分管职位对应的部门
			String deptlist="";//部门list
			for (int i = 0; i < ids.length; i++) {
				if(!ids[i].equals("") && !ids[i].equals(null)){
				String selsql="from Workposition where id="+ids[i];
				List list5=empBussiness.exHql(selsql);
				List<Workposition> list6=list5;
				if(list6.size()>0){
				for (int j = 0; j < list6.size(); j++) {
					Object o=list6.get(j).getDepartment().getId();
					if(j!=list6.size()){
					deptlist=deptlist+o.toString()+",";}
					else{
						deptlist=deptlist+o.toString();
					}
				}
				
				}
				}
				
			}
			response.setContentType("text/html;charset=GBK");
	          
			System.out.println(deptlist);//数据库的部门集合
			System.out.println(str);
			System.out.println(str1);
			x=new StringBuffer();
			StringBuffer sb=selemp(ispersonman);//子部门集合
			String sb1=sb.toString();
				System.out.println(sb);
			  String sep=selpid(x0,x2);//父部门集合 
			System.out.println(sep);
		String [] detptl=deptlist.split(",");//数据库的
		String [] sb2=sb1.split(",");//子的
		String [] sep1=sep.split(",");//父的
		for (int i = 0; i < sb2.length; i++) { //子比较
			for (int j = 0; j < detptl.length; j++) {
				
				if(sb2[i].equals(detptl[j])){ //cuowu1
						response.getWriter().print("false1");//自部门的主管职位以关联本职位
				        return;
				}
			}
			
		}
		for (int i = 0; i < sep1.length; i++) {
				for (int j = 0; j < detptl.length; j++) {
				if(sep1[i]!=depid){
				if(sep1[i].equals(detptl[j])){ //cuowu1
						 response.getWriter().print("false2");//父部门的主管职位以关联本职位
						 return;
				}
			}
			
			
		}}
			}else{
				response.getWriter().print("null");
				return;
				
			}
		if(str!="" && str!=null){
		 str1=str1+str;
		 }
		Object o=null;
		if(str1!="" && str1!=null ){
			
		System.out.println(str1);
		String sqla="update Workposition set parpostionid='"+str1+"' where id="+x1;
		 o =empBussiness.updatesql(sqla);
		}
		String Sql="from WorkpositionEmployee where workposition.id="+id;//查询这个岗位下的人员
		List l1=empBussiness.exHql(Sql);
		List<WorkpositionEmployee> l2=l1;
		for (int i = 0; i < l2.size(); i++) {
			Integer empid=l2.get(i).getEmployee().getId();//得到这个职位对应的人员
			String postionid[]=str1.split(",");
			for (int j = 0; j < postionid.length; j++) {
				
				String sql="from WorkpositionEmployee where workposition.id="+Integer.parseInt(postionid[i])+" and employee.id="+empid;
				List l3=empBussiness.exHql(sql);
				if(l3.size()==0){
					 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 

					 java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

					 String str_date1 = formatter.format(currentTime);
					String sql1="insert into workposition_employee(positionid,empid,edittime,positiontype) values("+Integer.parseInt(postionid[i])+","+empid+",'"+str_date1+"',3)";
					boolean b=	empBussiness.add(sql1);
				}
				
			}
			
		}
		
		
		if( o != null){
			response.getWriter().print(0);
		}else{
			response.getWriter().print(1);
		}
		
		System.out.println(str);
		System.out.println();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 删除分管职位
	 */
	public void	delispersonman(){
	   
		String ispersonman = request.getParameter("ispersonman");//传过来的要分管的id
		String id = request.getParameter("wpid");//这个职位id
		String depid = request.getParameter("deptid");//这个职位的部门
		int x0=Integer.parseInt(ispersonman);
	    int x1=Integer.parseInt(id);
	    int x2=Integer.parseInt(depid);
	    String hql1="from Workposition where id="+x1;//查找这个职位的分管职位setParpostionid
		List list3=empBussiness.exHql(hql1);
		String str1="";//本职位原有的分管职位
		List<Workposition> list4=list3;
		if(list4.size()>0){
		for (int i = 0; i < list4.size(); i++) {
			Object o=list4.get(i).getParpostionid();
			if(o!="" && o!=null){
				String o1=o.toString();
				str1=o1;
			}
		}
		}
		String str="";
		String hql="from Workposition where department.id="+x0; //查找选中部门的主管职位加入到Str中
		List list1=empBussiness.exHql(hql);
		List<Workposition> list2=list1;
		if(list2.size()>0){
		for (int j = 0; j < list2.size(); j++) {
			Object o=list2.get(j).getIspersonman();
			Object oo=list2.get(j).getId();
			if(o!="" && o!=null){
			String o1=o.toString();
			String o2=oo.toString();
			if(o1.equals("1")){
				str=o2;
				break;
			}
			}
		}
		String ids[]=str1.split(",");//此职位数据库分管职位对应的部门
	String s="";
		for (int i = 0; i < ids.length; i++) {
			if(!ids[i].equals(str) && !ids[i].equals("")){
				if(i!=ids.length-1 ){
				s=s+ids[i]+",";
				}else{
					
					s=s+ids[i];
				}
			}
			
		}
		

		String sqla="update Workposition set parpostionid='"+s+"' where id="+x1;
		Object o =empBussiness.updatesql(sqla);
		if( o != null){
			try {
				response.getWriter().print(0);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			try {
				response.getWriter().print(1);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}}
	}
	/**
	 * 添加或修改部门职位
	 */
	public void addoreditWork(){
		
		try {
			request.setCharacterEncoding("UTF-8");
			String mark = request.getParameter("mark");
			String id = request.getParameter("wpid");
			String deptid = request.getParameter("deptid");
			String name = request.getParameter("name");
			String shortname = request.getParameter("shortname");
			String grade = request.getParameter("grade");
			String ispersonman = request.getParameter("ispersonman")!=null?request.getParameter("ispersonman"):"0";
			String content = request.getParameter("content");
			
			Workposition wp = new Workposition();
			if(mark !=null &&mark.equals("edit")){
				wp.setId(Integer.parseInt(id));
			}
			if(ispersonman.equals("1")){
				int deptname = request.getParameter("deptname")!=null?Integer.parseInt(request.getParameter("deptname")):1;
			String hql="SELECT ispersonman FROM Workposition where department.id="+deptname;
			List list1=empBussiness.exHql(hql);
			for (int i = 0; i < list1.size(); i++) {
				Object o=list1.get(i);
				String s=o.toString();
				if(s.equals("1")){
					response.getWriter().print(3);
					return ;
					
				}
				
			}
			}
			
			Department dept =  new Department();
			dept.setId(Integer.parseInt(deptid));
			wp.setDepartment(dept);
			wp.setIspersonman(Integer.parseInt(ispersonman));
			wp.setEdittime(StringUtil.formatDate(new Date()));
			wp.setName(URLDecoder.decode(name,"UTF-8"));
			wp.setShortname(URLDecoder.decode(shortname,"UTF-8"));
			wp.setWorkcontent(URLDecoder.decode(content,"UTF-8"));
			Workgrade wg = new Workgrade();
			wg.setId(Integer.parseInt(grade));
			wp.setWorkgrade(wg);
			
			Object o =commonbiz.addForm(wp, null, request);
			
			if( o != null){
				response.getWriter().print(0);
			}else{
				response.getWriter().print(1);
			}
			
		}catch (Exception e) {
			logger.error("addoreditWork Error :"+e.getMessage());
			e.printStackTrace();
		}
		return ;
		
	}
	
	/**
	 * 删除部门职位
	 */
	public void delWork(){
		
		try {
			String id = request.getParameter("wpid");
			if(id == null || "".equals(id)){
				response.getWriter().print(1);
				return;
			}
			List list = commonbiz.getForm(" WorkpositionEmployee", " and workposition.id="+id);
			if( list !=null && list.size()>0){
				response.getWriter().print(2);//有关联不能删除
			}else{//无关联执行删除
				int rowcount = commonbiz.updateBills(" delete Workposition where id = "+ id);
				if(rowcount >0){
					response.getWriter().print(0);//删除成功
				}else{
					response.getWriter().print(1);//删除失败
				}
			}
		}catch (Exception e) {
			logger.error("delWork Error :"+e.getMessage());
			e.printStackTrace();
		}
		return ;
		
	}
	/**
	 * 兼职列表
	 * @return
	 */
	public String permissionwork(){
		
		String empid = request.getParameter("empid");
		if(empid == null || "".equals(empid)){
			logger.error(this.getClass().toString()+" error:empid is null or '' in  permissionwork() Method ");
			return "error";
		}
		if(!StringUtil.isNumeric(empid)){
			logger.error(this.getClass().toString()+" error:empid is validate numer  in  permissionwork() Method ");
			return "error";
		}
		logger.error("xxxx"+empid);
		logger.error("commonbiz"+commonbiz);
		
		List list = commonbiz.getForm("WorkpositionEmployee", " and employee.id="+empid);
		request.setAttribute("data", list);
		logger.error("yyy"+empid);
		request.setAttribute("empid", empid);
		return "mypositionlist";
		
	}
	/**
	 *  这里开始是员工兼职职位管理
	 *  修改或者添加员工职位
	 */
	public void addoreditEmp(){
		try {
			
			String mark = request.getParameter("mark");
			if(mark != null && mark.equals("new")){
				String wpid = request.getParameter("wpid");
				String empid = request.getParameter("empid");
				String deptid = request.getParameter("deptid");
				List list = commonbiz.getForm("WorkpositionEmployee", " and employee.id="+empid+" and workposition.departemtnt.id="+deptid);
				if( list ==null || list.size()<1){
					WorkpositionEmployee wpe  = new WorkpositionEmployee();
					Employee e= new Employee();
					e.setId(Integer.valueOf(empid));
					Workposition wp  = new Workposition();
					wp.setId(Integer.valueOf(wpid));
					wpe.setEmployee(e);
					wpe.setWorkposition(wp);
					wpe.setEdittime(StringUtil.formatDate(new Date()));
					Object o =  commonbiz.addForm(wpe, null, request);
					if(o != null){
						response.getWriter().print(0);
					}else{
						response.getWriter().print(1);
					}
					return;
				}else{
					response.getWriter().print(2);//该部门已存在该职位
					return ;
				}
			}
		} catch (Exception e) {
			logger.error(this.getClass().toString()+" error:IOException  in  validateselectdept() Method ");
			e.printStackTrace();
		}
		return ;
		
		
	}
	/**
	 * 去除职位关联
	 */
	public void removeEmp(){
		try {
			
			String wpeid = request.getParameter("wpeid");
			if(wpeid == null || "".equals(wpeid)){
				response.getWriter().print(1);
				return;
			}
			int rowcount = commonbiz.updateBills(" delete WorkpositionEmployee where id = "+wpeid);
			if(rowcount>0){
				response.getWriter().print(0);
			}else{
				response.getWriter().print(1);
			}
			return;
		} catch (Exception e) {
			logger.error(this.getClass().toString()+" error:IOException  in  validateselectdept() Method ");
			e.printStackTrace();
		}
		return ;
		
	}
	
	/**
	 * 保存兼职列表
	 * @return
	 */
	public String savework(){
		
		
		return "mypositionlist";
		
	}
	public void updatework(){
		
		
		return ;
	}
	/**
	 * 兼职列表
	 * @return
	 */
	public void delwork(){
		
		
		return ;
	}
	
	/**
	 * 以下为职位管理功能
	 * 
	 * 
	 */
	/**
	 * 获得公司所有职位
	 */
	public String getCompany(){
		
		List list = commonbiz.getForm("Workgrade", " order by grade desc ");
		System.out.println("getCompany");
		String grade = "";
		
		Map<String, String> map = new HashMap<String, String>();
		com.fuao.fajxc.util.MyProperties prop = new com.fuao.fajxc.util.MyProperties();
		InputStream is;
		try {
			is = Department.class.getResourceAsStream("/proper.properties");
			prop.load(is,"UTF-8");
			is.close();
		} catch (FileNotFoundException e) {
			logger.error("FileNotFoundException" + e.getMessage());
			
		} catch (IOException e) {
			logger.error("IOException" + e.getMessage());
		}
		String gradestr = prop.getProperty("grade");
		//List gradelist = new ArrayList();
		if(gradestr !=null && !"".equals(gradestr)){
			String[] gradeArr = gradestr.split(",");
			for (int i = 0; i < gradeArr.length; i++) {
				//logger.info(gradeArr[i].split(":"));
				String[] temp = gradeArr[i].split(":");
				map.put(temp[0],temp[1]);
			}
			for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				Workgrade wg = (Workgrade) iterator.next();
				if(map.containsKey(""+wg.getGrade())){
					map.remove(""+wg.getGrade());
				}
			}
		}
//		String[] str = new String[]{"6:董事","5:总经理","4:高级经理","3:经理","2:主管","1:组长"};
		request.setAttribute("gradelist", map);
		request.setAttribute("gradestr", gradestr);
		request.setAttribute("positionlist", list);
		
		return "positionlist";
	}
	//CheckPositionName
	/**
	 * 新建或修改职位验证职位名称
	 */
	public void CheckPName(){
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		
		try {
		if(name != null && !"".equals(name)){
			//name =new String(name.getBytes(),"UTF-8");
			name = URLDecoder.decode(name,"UTF-8");
			name = name.trim();
		}else{
			response.getWriter().print(1);
			return;
		}
		if(id != null && !"".equals(id)){//修改验证
			List list = null;
			Workgrade wg =  (Workgrade)commonbiz.getForm(Workgrade.class, Integer.parseInt(id));
			if(wg == null || wg.getId()== null || wg.getId() == 0){
				response.getWriter().print(1);
				return;
			}else{
				if(wg.getName().equals(name)){
					response.getWriter().print(0);//未做改变继续添加
				}else{
					list = commonbiz.getForm("Workgrade", " and name = '"+name+"'");
					if(list != null && list.size()>0){
						response.getWriter().print(2);//
					}else{
						response.getWriter().print(0);//修改了名称没有重复允许
					}
				}
			}
			wg = null;
			list = null;
		}else{//新建验证
			List list =commonbiz.getForm("Workgrade", " and name= '"+name+"'");
			if(list !=null && list.size()>0){
				response.getWriter().print(2);
			}else{
				response.getWriter().print(0);
			}
			list = null;
			
		}
		}catch (Exception e) {
			logger.error("addOrEditCompany Error:"+e.getMessage());
			logger.error(e);
			logger.debug(e);
		}
		return ;
	}
	/*
	 * 审查权重是否被使用grade
	 */
	public void checkGrade(){
		try{
		String id = request.getParameter("id");
		String grade = request.getParameter("grade");
		if(grade == null || "".equals(grade)){
			response.getWriter().print(1);
			return ;
		}
		if(id != null && !"".equals(id)){//修改验证
			List list = null;
			Workgrade wg =  (Workgrade)commonbiz.getForm(Workgrade.class, Integer.parseInt(id));
			if(wg == null || wg.getId()== null || wg.getId() == 0){
				response.getWriter().print(1);
				return;
			}else{
				if(wg.getGrade().toString().equals(grade)){
					response.getWriter().print(0);//未做改变继续添加
				}else{
					list = commonbiz.getForm("Workgrade", " and grade = "+grade+"");
					if(list != null && list.size()>0){
						response.getWriter().print(2);//
					}else{
						response.getWriter().print(0);//修改了名称没有重复允许
					}
				}
			}
			wg = null;
			list = null;
		}else{//新建验证
			List list =commonbiz.getForm("Workgrade", " and grade= "+grade+"");
			if(list !=null && list.size()>0){
				response.getWriter().print(2);
			}else{
				response.getWriter().print(0);
			}
			list = null;
		}
		}catch (Exception e) {
			logger.error("checkGrade Exception:"+e.getMessage());
		}
		return ;
		
	}
	/**
	 * 新建或编辑公司职位
	 */
	public void addOrEditCompany(){
		
		try {
			//request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String shortname = request.getParameter("shortname");
			String grade = request.getParameter("grade");
			String desc = request.getParameter("desc");
			String edittime = StringUtil.formatDate(new Date());
		if(name !=null && !"".equals(name)){
			name = URLDecoder.decode(name,"UTF-8");
		}
		if(shortname !=null && !"".equals(shortname)){
			shortname = URLDecoder.decode(shortname,"UTF-8");
		}
		if(desc !=null && !"".equals(desc)){
			desc = URLDecoder.decode(desc,"UTF-8");
		}
		Workgrade wg = new Workgrade();
		if(id != null && !"".equals(id)){
			wg =  (Workgrade)commonbiz.getForm(Workgrade.class,Integer.parseInt(id));
			List list1 =commonbiz.getForm("Workgrade", " and name= '"+name+"'");
			List list2 =commonbiz.getForm("Workgrade", " and grade= "+grade+"");
			if(!name.equals(""+wg.getName()) && list1 !=null && list1.size()>0 ){
				response.getWriter().print(2);
				return;
			}
			list1 = null;
			if(!grade.equals(""+wg.getGrade()) && list2 !=null && list2.size()>0 ){
				response.getWriter().print(3);
				return ;
			}
			list2 = null;
			wg.setName(name);
			wg.setShortname(shortname);
			wg.setGrade(Integer.parseInt(URLDecoder.decode(grade,"UTF-8")));
			wg.setDescription(desc);
			wg.setEdittime(edittime);
		}else{
			
			wg.setName(name);
			wg.setShortname(shortname);
			wg.setGrade(Integer.parseInt(URLDecoder.decode(grade,"UTF-8")));
			wg.setDescription(desc);
			wg.setEdittime(edittime);
			List list =commonbiz.getForm("Workgrade", " and grade= "+grade+"");
			if(list != null && list.size()>0){
				response.getWriter().print(3);
				return ;
			}
			list = null;
		}
			wg = (Workgrade)commonbiz.addForm(wg, null, request);
			if(wg !=null && wg.getId() != 0){
				response.getWriter().print(0);
			}else{
				response.getWriter().print(1);
			}
		} catch (Exception e) {
			try {
				response.getWriter().print(1);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			logger.error(e);
		}
		return ;
	}
	/**
	 * 编辑属性文件中的职位权重
	 */
	public void editGradeStr(){
		String gradestr = request.getParameter("gradestr");
		try {
			if(gradestr ==null || gradestr == ""){
				response.getWriter().print(1);
				return;
			}
			gradestr = URLDecoder.decode(gradestr,"UTF-8");
			gradestr = gradestr.trim().replace("，",",");
			gradestr = gradestr.trim().replace("：",":");
			if(gradestr.endsWith(",")){
				gradestr = gradestr.substring(0,gradestr.length()-1);
			}
			MyProperties mp = new MyProperties();
			InputStream is = null;
			is = getClass().getResourceAsStream("/proper.properties");
			mp.load(is);
			is.close();
			logger.info(mp.getProperty("grade"));
			mp.setProperty("grade", "6:董事,5:总经理,4:高级经理,3:经理,2:主管,1:组长,7:xxx");
			OutputStream os = null;
			os = new FileOutputStream("/proper.properties");
			mp.store(os, "UTF-8");
			os.close();
			response.getWriter().print(0);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * 验证删除公司职位等级
	 */
	public void validateCompany(){
		try {
			String id = request.getParameter("id");
			if(id == null ){
				//传入参数错误
				response.getWriter().print(9);
			}
			//isLeave=1在职 delflag=0未删除
			String hql = " From Employee where workposition.id ="+id;
			List list = commonbiz.getForm("Employee", " and workposition.id ="+id);
			if(list !=null && list.size()>0){
				//有员工在员工职位中关联了此职位是否要撤销关联
				logger.info("有员工在员工职位中关联了此职位");
				response.getWriter().print(2);//
			}
			list = commonbiz.getForm("WorkpositionEmployee", " and workposition.id ="+id);
			if(list !=null && list.size()>0){
				//有员工在兼职职位中关联了此职位是否要撤销关联
				logger.info("有员工在兼职职位中关联了除");
				response.getWriter().print(3);//
			}
			logger.info("无其他关联,可以删除");
			response.getWriter().print(0);
		} catch (Exception e) {
			logger.error("addOrEditCompany Error:"+e.getMessage());
			logger.error(e);
			logger.debug(e);
		}
		
		
	}
	/**
	 * 验证删除部门职位
	 */
	public void validatedept(){
		try {
			String id = request.getParameter("id");
			if(id == null ){
				//传入参数错误
				response.getWriter().print(9);
			}
			//isLeave=1在职 delflag=0未删除
			String hql = " From Employee where workposition.id ="+id;
			List list = commonbiz.getForm("Employee", " and workposition.id ="+id);
			if(list !=null && list.size()>0){
				//有员工在员工职位中关联了此职位是否要撤销关联
				logger.info("有员工在员工职位中关联了此职位");
				response.getWriter().print(2);//
			}
			list = commonbiz.getForm("WorkpositionEmployee", " and workposition.id ="+id);
			if(list !=null && list.size()>0){
				//有员工在兼职职位中关联了此职位是否要撤销关联
				logger.info("有员工在兼职职位中关联了除");
				response.getWriter().print(3);//
			}
			logger.info("无其他关联,可以删除");
			response.getWriter().print(0);
		} catch (Exception e) {
			logger.error("addOrEditCompany Error:"+e.getMessage());
			logger.error(e);
			logger.debug(e);
		}
		
		
	}
	/**
	 * 执行删除公司职位操作
	 */
	public void delCompany(){
		try {
			String id = request.getParameter("id");
			if(id == null ){
				//传入参数错误
				response.getWriter().print(1);
			}
			int returncount = commonbiz.updateBills(" delete Workgrade where id="+id);
			if(returncount > 0){
				//执行成功
				response.getWriter().print(0);
			}else{
				//系统错误
				response.getWriter().print(1);
			}
		} catch (Exception e) {
			logger.error(e);
			//logger.debug(e);
		}
		
		
	}

	
	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		String[] str = new String[]{"6:董事","5:总经理","4:高级经理","3:经理","2:主管","1:组长"};
		System.out.println(str.length);
	}

	public void setMty(MissiontypeAction mty) {
		this.mty = mty;
	}

	public MissiontypeAction getMty() {
		return mty;
	}
	
	/**
	 * 添加或修改部门职位
	 */
	public void sendemail(){
		
		try {
			request.setCharacterEncoding("UTF-8");
			String name = request.getParameter("name");//邮件地址-收件人
			String title = request.getParameter("shortname");//标题
			String content = request.getParameter("content");//内容
			
			//发送邮件的邮箱
			String EMAIL = "information@cicgp.com";
			
			//发送邮件邮箱密码
			String EMAIL_PASSWORD = "sendemail";
			
			//邮件端口
			Integer EMAIL_PORT = 25;
			
			//邮件ftp字符
			String FTP_STRING = "smtp.exmail.qq.com";

			//定义邮件列表
			List emaillist = new ArrayList();
			//读取文件获取收件人地址
			String emaildir = "D:\\";
			File f = new File(emaildir);
			if(!f.exists()){
				System.out.println("监听目录不存在，请设置正确的ftp文件目录");
//				doWriteAppLog("监听目录不存在，请设置正确的ftp文件目录");
			}else if(!f.isDirectory()){
				System.out.println("监听对象不是log文件目录，请设置正确的log文件目录");
//				doWriteAppLog("监听对象不是log文件目录，请设置正确的log文件目录");
			}else{
				System.out.println("遍历"+emaildir+"文件");
				String[] fnamelist = f.list();
				File[] flist = f.listFiles();
				if(fnamelist.length == 0){
					System.out.println("没有可更新的文件");
					//doWriteAppLog("没有可更新的文件");
				}else{
					Set serial = new TreeSet();//带自动排序功能
					int divisor = 288;//288=1*24*60/5
					String fsuffix= "email.txt";
					//过滤和排序 文件格式access.log.1 access.log.2 access.log.3 按最后数字的倒序排列
					for (int i = 0; i < fnamelist.length; i++) {
						if(fnamelist[i].startsWith(fsuffix) && !fnamelist[i].equals(fsuffix) && !fnamelist[i].equals(fsuffix+".0")){
							try{
								int seral = divisor-Integer.parseInt(fnamelist[i].substring(11,fnamelist[i].length()));
								serial.add(seral);
							}catch (ClassCastException e) {//如果造型异常标识不符合筛选要求
								System.out.println("不符合筛选要求过滤掉:"+fnamelist[i]);
//								doWriteAppLog("不符合筛选要求过滤掉:"+fnamelist[i]);
							}
						}
					}
					for (Iterator it = serial.iterator(); it.hasNext();) {
						
						int	 o = (Integer) it.next();
						String fpath = f.getPath()+File.separator+fsuffix+"."+(divisor-o);	
						System.out.println("开始读取logfile:"+fpath);
//						doWriteAppLog("开始读取logfile:"+fpath);
						File file = new File(fpath);
						BufferedReader reader = null;
						try {
//							System.out.println("以行为单位读取文件内容，一次读一整行：");
							reader = new BufferedReader(new FileReader(file));
							String tempString = null;
							int line = 1;
							// 一次读入一行，直到读入null为文件结束
							while ((tempString = reader.readLine()) != null) {
								// 显示行号
								System.out.println("邮件地址"+line+":"+tempString);
//								StringUtil.checkEmail(mail)
								emaillist.add(tempString.trim());
								line++;
							}
							reader.close();
						} catch (IOException e) {
							e.printStackTrace();
//							doWriteAppLog("读取文件"+fileName+"IO异常:"+e.getMessage());
						} finally {
							if (reader != null) {
								try {
									reader.close();
								} catch (IOException e1) {
									e1.printStackTrace();
//									doWriteAppLog("读取文件"+fileName+"IO异常:"+e1.getMessage());
								}
							}
						}
//						deleteFile(fpath);
					}
				}
			}
			Email email=new Email();
			boolean chenggong = false;
			StringBuffer sb = new StringBuffer();
			for (Iterator it = emaillist.iterator(); it.hasNext();) {
				String reciver = (String) it.next();
				chenggong=email.sendEmail(reciver, title, content);
				sb.append("邮件"+reciver+"发送状态"+chenggong+"/n");
			}
			
//			写入日志文件
			RandomAccessFile randomFile = null;
			try {
				// 打开一个随机访问文件流，按读写方式
//				String fileName = emaildir+File.separator+buildLogFileName("Node", ".log");
//				String c =TimePattern.doDateTime3(new Date())+" "+content;
//				randomFile = new RandomAccessFile(fileName, "rw");
				// 文件长度，字节数
				long fileLength = randomFile.length();
				// 将写文件指针移到文件尾。
				randomFile.seek(fileLength);
				byte buffer[] = new byte[content.getBytes().length];
				buffer = content.getBytes();
				randomFile.write(buffer);
				randomFile.writeBytes("\n");
				randomFile.close();
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				if (randomFile != null) {
					try {
						randomFile.close();
					} catch (IOException e1) {
					}
				}
			}
//			e.sendEmail(to, title, content)
			
//			if( o != null){
//				response.getWriter().print(0);
//			}else{
//				response.getWriter().print(1);
//			}
			
		}catch (Exception e) {
			logger.error("addoreditWork Error :"+e.getMessage());
			e.printStackTrace();
		}
		return ;
		
	}
	/**
	 * 以行为单位读取文件，常用于读面向行的格式化文件
	 * 
	 * @param fileName
	 *            文件名
	 */
	public static int readLogFileByLines(String fileName) {
//		fileName= "D:\\job\\portal\\CDN2\\www_litscloud_com20130425112305seral00001";
		File file = new File(fileName);
		BufferedReader reader = null;
		try {
//			System.out.println("以行为单位读取文件内容，一次读一整行：");
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			int line = 1;
			// 一次读入一行，直到读入null为文件结束
			while ((tempString = reader.readLine()) != null) {
				// 显示行号
//				System.out.println("line " + line + ": " + tempString);
//				doStrSplit(tempString,line);
//				doStrSplit2_7(tempString, line);
				System.out.println("邮件地址"+line+":"+tempString);
				line++;
				//处理字符串
				
//				if(line ==10) break;
			}
			reader.close();
			
			return --line;
		} catch (IOException e) {
			e.printStackTrace();
//			doWriteAppLog("读取文件"+fileName+"IO异常:"+e.getMessage());
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
					e1.printStackTrace();
//					doWriteAppLog("读取文件"+fileName+"IO异常:"+e1.getMessage());
				}
			}
		}
		return 0;
	}
   
}
