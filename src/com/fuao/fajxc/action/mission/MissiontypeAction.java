package com.fuao.fajxc.action.mission;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.record.PageBreakRecord.Break;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.omg.PortableInterceptor.INACTIVE;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.mission.MissionBussiness;
import com.fuao.fajxc.bussiness.mission.MissiontypeBussiness;
import com.fuao.fajxc.dao.impl.mission.MissiontypeDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.Auditline;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.DepartmentGrade;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.Operationgroup;
import com.fuao.fajxc.vo.Workgrade;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;
import com.sun.org.apache.xml.internal.serialize.Printer;

public class MissiontypeAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	private static Logger logger = Logger.getLogger(MissiontypeAction.class);
	private MissiontypeBussiness missiontypeBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Missiontype missiontype;
	private MissionBussiness missionBussiness;
	private Object[] ids;
	private CommonBiz formbiz;
	private Workposition workpos;
	// 得到页面传过来的missiontype ID
	private Integer mid;
	 private String workid;
	private String parantIds;
	private String strinName;
	private String islevel;
	private String value1;
	private String squnum;
	private String pid;
	private String employeeid;
	private String workpositionid;
	private String workpositionempid;
	List list=new ArrayList();
	private String money1;//额度审核管理页面传过来的参数
	private String money2;
	private String money3;
	private String money4;
	private String money5;
	private String money6;
	private String money7;
	private String money8;
	private String money9;
	private String money10;
	private String money11;
	private String money12;
	private String jd1;
	private String jd2;
	private String jd3;
	private String jd4;
	private String sbn;
	private String xbn;
	private String year;
   
	
	public String getMoney1() {
		return money1;
	}

	public void setMoney1(String money1) {
		this.money1 = money1;
	}

	public String getMoney2() {
		return money2;
	}

	public void setMoney2(String money2) {
		this.money2 = money2;
	}

	public String getMoney3() {
		return money3;
	}

	public void setMoney3(String money3) {
		this.money3 = money3;
	}

	public String getMoney4() {
		return money4;
	}

	public void setMoney4(String money4) {
		this.money4 = money4;
	}

	public String getMoney5() {
		return money5;
	}

	public void setMoney5(String money5) {
		this.money5 = money5;
	}

	public String getMoney6() {
		return money6;
	}

	public void setMoney6(String money6) {
		this.money6 = money6;
	}

	public String getMoney7() {
		return money7;
	}

	public void setMoney7(String money7) {
		this.money7 = money7;
	}

	public String getMoney8() {
		return money8;
	}

	public void setMoney8(String money8) {
		this.money8 = money8;
	}

	public String getMoney9() {
		return money9;
	}

	public void setMoney9(String money9) {
		this.money9 = money9;
	}

	public String getMoney10() {
		return money10;
	}

	public void setMoney10(String money10) {
		this.money10 = money10;
	}

	public String getMoney11() {
		return money11;
	}

	public void setMoney11(String money11) {
		this.money11 = money11;
	}

	public String getMoney12() {
		return money12;
	}

	public void setMoney12(String money12) {
		this.money12 = money12;
	}

	public String getJd1() {
		return jd1;
	}

	public void setJd1(String jd1) {
		this.jd1 = jd1;
	}

	public String getJd2() {
		return jd2;
	}

	public void setJd2(String jd2) {
		this.jd2 = jd2;
	}

	public String getJd3() {
		return jd3;
	}

	public void setJd3(String jd3) {
		this.jd3 = jd3;
	}

	public String getJd4() {
		return jd4;
	}

	public void setJd4(String jd4) {
		this.jd4 = jd4;
	}

	public String getSbn() {
		return sbn;
	}

	public void setSbn(String sbn) {
		this.sbn = sbn;
	}

	public String getXbn() {
		return xbn;
	}

	public void setXbn(String xbn) {
		this.xbn = xbn;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public Missiontype getMissiontype() {
		return missiontype;
	}

	public void setMissiontype(Missiontype missiontype) {
		this.missiontype = missiontype;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPid() {
		return pid;
	}

	public void setEmployeeid(String employeeid) {
		this.employeeid = employeeid;
	}

	public String getEmployeeid() {
		return employeeid;
	}

	public void setWorkpositionid(String workpositionid) {
		this.workpositionid = workpositionid;
	}

	public String getWorkpositionid() {
		return workpositionid;
	}

	public String getIslevel() {
		return islevel;
	}

	public void setIslevel(String islevel) {
		this.islevel = islevel;
	}

	public String getValue1() {
		return value1;
	}

	public void setValue1(String value1) {
		this.value1 = value1;
	}

	public String getSqunum() {
		return squnum;
	}

	public void setSqunum(String squnum) {
		this.squnum = squnum;
	}

	public String getParantIds() {
		return parantIds;
	}

	public void setParantIds(String parantIds) {
		this.parantIds = parantIds;
	}

	public String getStrinName() {
		return strinName;
	}

	public void setStrinName(String strinName) {
		this.strinName = strinName;
	}

	public Workposition getWorkpos() {
		return workpos;
	}

	public void setWorkpos(Workposition workpos) {
		this.workpos = workpos;
	}

	public CommonBiz getFormbiz() {
		return formbiz;
	}

	public void setFormbiz(CommonBiz formbiz) {
		this.formbiz = formbiz;
	}

	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public MissiontypeBussiness getMissiontypeBussiness() {
		return missiontypeBussiness;
	}

	public void setMissiontypeBussiness(
			MissiontypeBussiness missiontypeBussiness) {
		this.missiontypeBussiness = missiontypeBussiness;
	}

	public MissionBussiness getMissionBussiness() {
		return missionBussiness;
	}

	public void setMissionBussiness(MissionBussiness missionBussiness) {
		this.missionBussiness = missionBussiness;
	}

	public Object getModel() {
		missiontype = new Missiontype();
		return missiontype;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	/**
	 * 得到request
	 */
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;

	}

	/**
	 * 得到response
	 */
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}

	/*
	 * 添加或更改
	 */
	public String add() {
		try {
			missiontype.setSbh(UUID.randomUUID().toString());
			boolean thing = missiontypeBussiness.addData(missiontype);
			return this.getpage();
		} catch (Exception e) {
			e.printStackTrace();
			return "will";
		}
	}

	/*
	 * 删除客户信息对象
	 */
	public String del() {
		try {
			boolean flag = missionBussiness.delmesstype(ids);
			response.getWriter().print(0);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.getWriter().print(1);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return null;
	}

	/*
	 * 更改客户信息对象
	 */
	public String update() {
		try {
			String MissiontypeId = request.getParameter("MissiontypeId");// 客户主键编号
			missiontypeBussiness.updateData(missiontype);
			return this.getpage();
		} catch (Exception e) {
			return "sess";
		}
	}

	/*
	 * 根据条件进行筛选查询客户信息
	 */
	public String getpage() {
		System.out.println(111111);
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String MissiontypeId = request.getParameter("MissiontypeId");// 客户主键编号
		String hql = "from Missiontype where 1=1 and delflag!=1 and (superid=1 or superid=2) order by missiontypeid desc";
		System.out.println("hql:::" + hql);
		Pages pages = missiontypeBussiness.exHqlPages(hql, Integer
				.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "listMissiontype";
	}

	/*
	 * 获得部门的列表数
	 */
	public String getall() {
		System.out.println(111111);
		// String hql="from Missiontype where 1=1 order by id desc";
		String addhql = "from Department where delflag=0  order by squnum ";
		List dlist = missiontypeBussiness.exHql(addhql);

		// 如果是1，2级将全部数组放到newdatas里面
		request.setAttribute("deptlist", dlist);
		// request.setAttribute("missiontypelist", list);
		return "listMissiontype";
	}

	/*
	 * 获取项目类型列表
	 */
	public String getProjectlist() {
		String superhql = "from Missiontype ";
		List typelist = missionBussiness.exHql(superhql);
		request.setAttribute("typelist", typelist);
		response.setContentType("text/html;charset=GBK");
		return "listProjecttype";
	}

	/*
	 * 类型表添加所有类型--付飞翔
	 */

	public void addTypes() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		// 得到当前时间
		Date now = new Date();
		String nowstr = dateFormat2.format(now);
		String typename = "";
		try {
			typename = request.getParameter("typeName");
			typename = URLDecoder.decode(typename, "utf-8");
			System.out.println(typename);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String superids = request.getParameter("superid");
		String isflag = request.getParameter("isflag");
		int isflags = Integer.parseInt(isflag);
		int ids = Integer.parseInt(superids);

		missiontypeBussiness.addTypes(ids, typename, nowstr, isflags);
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/*
	 * 删除类型--付飞翔
	 */
	public void deltypes() {
		System.out.println("+++");
		int id = Integer.parseInt(request.getParameter("typeid")); // 要删除的ID
		System.out.println(id);
		missiontypeBussiness.delType(id);
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * 修改类型--付飞翔
	 */
	public void edittypes() {
		String id = request.getParameter("typeid");
		String typenames = request.getParameter("typename");
		String tynames = "";
		try {
			tynames = URLDecoder.decode(typenames, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		// 得到当前时间
		Date now = new Date();
		int ids = Integer.parseInt(id);
		String nowstr = dateFormat2.format(now);
		missiontypeBussiness.updateType(ids, tynames, nowstr);

	}

	/*
	 * 获取单个客户信息对象
	 */
	public String get() {
		System.out.println(22222);
		try {
			String id = request.getParameter("id");
			System.out.println("id:::::" + id);
			if (id != null) {
				Missiontype data = missiontypeBussiness.getMissionTypedata(id);
				request.setAttribute("data", data);
			}
			String hql = "from Missiontype where superid=11";
			List<Object> meslist = missiontypeBussiness.exHql(hql);
			System.out.println("listsize:::" + meslist.size());
			request.setAttribute("missiontypes", meslist);
			return "missiontype";
		} catch (Exception e) {
			return "will";
		}
	}

	/*********
	 * 给选中的类型添加子修改类型
	 */
	public String addType() {

		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		// 得到当前时间
		Date now = new Date();
		String nowstr = dateFormat2.format(now);

		// 得到父类名称
		String supername = "";
		// 得到子类名称
		String child = "";
		try {
			supername = new String(request.getParameter("supername").getBytes(
					"iso-8859-1"), "gbk");
			child = new String(request.getParameter("child").getBytes(
					"iso-8859-1"), "gbk");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// 得到类型父id
		Integer superid = Integer.parseInt(request.getParameter("superid"));
		// 判断是修改部门还是类型
		String flag = request.getParameter("flag");
		if (child.trim().length() <= 0) { // 代表修改
			if (flag.equals("1")) { // 修改部门
				missiontypeBussiness.updateDept(superid, supername, nowstr);
			}
			if (flag.equals("0")) {// 修改类型
				missiontypeBussiness.updateType(superid, supername, nowstr);
			}
		} else { // 给父类添加子级
			if (flag.equals("1")) { // 添加子级部门
				missiontypeBussiness.addDept(superid, child, nowstr);
			}
			if (flag.equals("0")) {// 添加子级类型
				missiontypeBussiness.addType(superid, child, nowstr);
			}
		}
		System.out.println("添加成功！");
		return "showtype";
	}

	/*********
	 * 删除节点
	 */
	public String delType() {

		int id = Integer.parseInt(request.getParameter("id")); // 要删除的ID
		int flag = Integer.parseInt(request.getParameter("flag")); // 标识删除部门还是类型。1部门，0类型
		if (flag == 0) { // 删除类型
			missiontypeBussiness.delType(id);
		}
		if (flag == 1) { // 删除部门
			missiontypeBussiness.delDept(id);
		}

		return "showtype";
	}

	/**
	 * 根据类别 名称查询详细信息
	 * 
	 * @return
	 */
	public String getMission() {
		int id = Integer.parseInt(request.getParameter("mid"));
		List list = missiontypeBussiness.getMissionById(id);
		System.out.println(list.size());
		request.setAttribute("list", list);
		return "missionlist";
	}

	/*
	 * 根据id查寻权重
	 */
	public String addgrade() {
		int id = Integer.parseInt(request.getParameter("id"));
		String hql = "FROM Workposition where deptid=" + id;
		List<Object> gradelist = missiontypeBussiness.exHql(hql);
		request.setAttribute("gradelist", gradelist);
		request.setAttribute("ids", id);
		return "addgrade";
	}

	public void addoption() {
		String hql = "FROM Workgrade";
		String stg = "";
		List<Object> gradelist = missiontypeBussiness.exHql(hql);
		for (Object obj : gradelist) {
			Workgrade wg = (Workgrade) obj;
			stg += "<option value=" + wg.getId() + ">" + wg.getName()
					+ "</option>";
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(stg);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 增加部门
	public void addpositions() {
		try {
			response.setCharacterEncoding("UTF-8");
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		Department dep = new Department();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = null;
		try {
			d = sdf.parse(sdf.format(new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String st = null;
		try {
			st = URLDecoder.decode(strinName,"UTF-8" );
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		int pids = Integer.parseInt(pid);
		int ids = Integer.parseInt(parantIds);
		int isle = Integer.parseInt(islevel);
		int isle1 = isle + 1;
		int squnum1 = 0;
		dep.setIslevel(isle1);
		String addhql = "select max(d.squnum) from Department as d where  parentId=" + ids;
		System.out.println(addhql);
		List<Object> dlist = missiontypeBussiness.exHql(addhql);

		for (int i = 0; i < dlist.size(); i++) {
			Object object = dlist.get(i);
			if (object != null) {
				squnum1 = (Integer) object;
			} else {
				squnum1 = 1;
			}
		}
	
		int squnum2 = squnum1 + 1;
		dep.setDelflag(0);
		dep.setSqunum(squnum2);
		dep.setParentId(ids);
		dep.setName(st);
	
		dep.setTime(new Timestamp(d.getTime()));

		
		missiontypeBussiness.savemissions(dep);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 改变部门信息排列的顺序
	 * 
	 */
	public void orderby() {
		int ids = Integer.parseInt(parantIds);// 部门的id
		int pids = Integer.parseInt(pid);
		int isle = Integer.parseInt(islevel);// 部门的级别
		int v1 = Integer.parseInt(value1);// 目标的顺序id(squnum)
		int squ1 = Integer.parseInt(squnum);// 当前squnum

		int squnummax = 0;// 最大值
		int squnum2 = 0;

		// 如果这个部门下没有子部门
		String addhql1 = "select max(d.squnum) from Department as d where  parentId=" + pids;
		;
		// 取得目标同级别条目的最大值
		List<Object> dlist = missiontypeBussiness.exHql(addhql1);
		for (int i = 0; i < dlist.size(); i++) {
			Object object = dlist.get(i);
			squnummax = (Integer) object;
		}
		int id1 = 0;
		String addhql2 = "select id from Department  where squnum=" + squnummax
				+ " and islevel=" + isle + " and parentId=" + pids; // 取得目标同级同父id别条目的最大值
		List<Object> dlist1 = missiontypeBussiness.exHql(addhql2);
		for (int i = 0; i < dlist1.size(); i++) {
			Object object = dlist1.get(i);
			id1 = (Integer) object;
		}
		int id2 = 0;
		String addhql3 = "select id from Department  where squnum=" + v1
				+ " and islevel=" + isle + " and parentId=" + pids; // 取得目标同级别条目的suq
		List<Object> dlist2 = missiontypeBussiness.exHql(addhql3);
		for (int i = 0; i < dlist2.size(); i++) {
			Object object = dlist2.get(i);
			id2 = (Integer) object;
		}

		missiontypeBussiness.updetorderby(ids, isle, v1, squ1, squnummax, id1,
				id2);
		// String hql="from Missiontype where 1=1 order by id desc";
		String addhql = "from Department where delflag=0  order by id,squnum ";
		List dlist111 = missiontypeBussiness.exHql(addhql);

		// 如果是1，2级将全部数组放到newdatas里面
		request.setAttribute("deptlist", dlist111);
		// request.setAttribute("missiontypelist", list);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		return "listMissiontype";
	}
	/**
	 * 递归查询子部门id
	 */
	private List emplist;
	private static  StringBuffer x;
	 String str1="";
	 public String selemp1(String deptid){
		 
		 int dept=Integer.parseInt(deptid);
		 String hql="FROM Department where delflag=0 and  parentId="+deptid+"order by squnum";
		 List dlist = missiontypeBussiness.exHql(hql);
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
				ss=ss+"----";
			}
			x.append(a);
			str1=str1+"<br>"+ss+"<input type='checkbox' id='sel' onclick='sel(this)'  name='sel' value='"+list1.get(i).getId()+"'>"+list1.get(i).getName()+"<br>";
			x.append(",");
			System.out.println(a);
			 if(list1.size()>0){
				 selemp1(a);
				 System.out.println(x);
			 }
		 }}
		 System.out.println(x);
		 System.out.println(str1);
		
	
			return str1;
		 
		 	 
		 	
		 }
	 
	 public StringBuffer selemp(String deptid){
			
		 x.append(deptid);
		 x.append(",");
		 int dept=Integer.parseInt(deptid);
		 String hql="select id FROM Department where delflag=0 and  parentId="+dept;
		 List<Object> dlist = missiontypeBussiness.exHql(hql);
		 String a="";
		 
		 int y=dlist.size();
		 System.out.println(y);
		 if(y>0){
			
		 for (int i = 0; i < dlist.size(); i++) {
			Object o=dlist.get(i);
			a=o.toString();
			if(a!=""){
			x.append(a);
			x.append(",");}
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
	

	/**
	  * 查询部门人员
	  * @param x
	  * @return
	  */
	 public List getemp(StringBuffer x){
		 
		 String allx=x.toString();
		 String []allid= allx.split(",");
		 System.out.println(allid);
		 String hql="from Employee where isLeave=1 and delflag='0' and department.id in(";
		 String hql1="";
		  HashSet functionSet=new HashSet();
		  ArrayList listString =new ArrayList ();
		  for (int i = 0; i < allid.length; i++) {
			  listString.add(allid[i]);
		}
		   functionSet.addAll(listString); 
		   System.out.println(functionSet);
		   Iterator<String> iterator=functionSet.iterator();
		   
		   while (iterator.hasNext()) {
			   int a = Integer.parseInt(iterator.next());

			hql1=hql1+a+",";
			}
		
	
		String hql2=hql+hql1+"-1)";
	  	System.out.println(hql2);
		List<Object> emplist1 = missiontypeBussiness.exHql(hql2);
		 
		return emplist1; 
	 }
	 public String getposition(StringBuffer x){
		 String str="";
		 String allx=x.toString();
		 String []allid= allx.split(",");
		 String hql="from Workposition where  department.id =";
		 String hql1="";
		 HashSet functionSet=new HashSet();
		  ArrayList listString =new ArrayList ();
		  for (int i = 0; i < allid.length; i++) {
			  listString.add(allid[i]);
		}
		   functionSet.addAll(listString); 
		   System.out.println(functionSet);
		   Iterator<String> iterator=functionSet.iterator();
		   String Str1="";
		   while (iterator.hasNext()) {
			   Str1=Str1+iterator.next()+",";
			}
		  
		   String []allid1= Str1.split(",");
		   System.out.println(allid1.length);
		for (int i = 0; i < allid1.length; i++) {
			String hqlStr="from Department where  id ="+allid1[i];
			List emplist1 = missiontypeBussiness.exHql(hqlStr);
			List<Department> workp=emplist1;
			
			str=str+"<br><input type='checkbox'  name='sel' class='c"+workp.get(0).getId()+"' value='"+workp.get(0).getId()+"'>"+workp.get(0).getName();
//			
//				for (int j = 0; j < workp.size(); j++) {
//					str=str+"<br>----"+"<input type='checkbox'  name='sel' value='"+workp.get(j).getId()+"'>"+workp.get(j).getName()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
//					System.out.println(str);
//			}
			
		}
	
	  	System.out.println(str);
	
		 
		return str; 
	 }
	 /**
	  * 显示子部门的岗位信息
	  * 
	  */

	 public void selpositin(){
		 x=new StringBuffer();
		 str1=new String();
		 int deptid = Integer.parseInt(pid); 
		 int workid1 = Integer.parseInt(workid); 
		 String str = "0";
			String hql1="select parentId from Department where id="+deptid;
			List<Object> dlist0 = missiontypeBussiness.exHql(hql1);
			for (int i = 0; i < dlist0.size(); i++) {
				Object o=dlist0.get(i);
				 str=o.toString();
				
			}
		 String x=selemp1(str);
		 String str1="";
		 String str2="";
		 String hql2="select parpostionid from Workposition where id="+workid1;
		 List<Object> dlist1 = missiontypeBussiness.exHql(hql2);
		 for (int i = 0; i < dlist1.size(); i++) {
				Object o=dlist1.get(i);
				 if(o!="" && o!=null){
				 str1=o.toString(); 
				 }
			}
		 String [] sr=str1.split(",");
		  System.out.println(sr);
		 for (int i = 0; i < sr.length; i++) {
			 if(!sr[i].equals("") && !sr[i].equals(null)){
			 String hql3="from Workposition where id="+sr[i];
			 List dlist12 = missiontypeBussiness.exHql(hql3);
			 List<Workposition> l3=dlist12;
			 for (int j = 0; j < l3.size(); j++) {
					Object o=l3.get(j).getDepartment().getId();
					 if(o!="" && o!=null){
						String  str3=o.toString(); 
						str2=str2+str3+",";
					 }
				}
			 }
		}
		 String strall=x+"/"+str2;
		 response.setContentType("text/html;charset=GBK");
		 System.out.println(strall);
		 try {
			response.getWriter().print(strall);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	 }
	 
	 /**
	  * 移除分管关联的
	  * 
	  */
	/**
	 
	 * 查找到页面的的部门信息和次部门的职位
	 * 14032
	 * @return
	 */
	public String selposition() {
		x=new StringBuffer();
		int deptid = Integer.parseInt(request.getParameter("deptid"));
		System.out.println(deptid);
		String selhql = "from Workgrade where 1=1";
		List<Object> dlist = missiontypeBussiness.exHql(selhql);
		// 查询部门下的员工
		String str="from Department where id="+deptid;
		List dlist12 = missiontypeBussiness.exHql(str);
		List<Department> l3=dlist12;
		request.setAttribute("deptname", l3.get(0).getName());
		int  d2=0;
		String hql111="";
		List<Object> dlist1=null;
		for (int i = 0; i < l3.size(); i++) {
			
			Integer s= l3.get(i).getIsbj();
			if(s!=null){
				if(s==1){
					d2=l3.get(i).getParentId();
				}
			}
		}
		if(d2!=0){
			
			 x=selemp(String.valueOf(d2));	
			 dlist1=getemp(x);
		}else{
			  hql111="from Employee where isLeave=1 and delflag='0' and department.id="+deptid;
				 dlist1 = missiontypeBussiness.exHql(hql111);
			 
		}
		
	
		int y=dlist1.size();
		System.out.println(y);
		String selworsString="from WorkpositionEmployee";
		
		List dlist3 = missiontypeBussiness.exHql(selworsString);
		// 查询次部门的职位
		String selhql2 = "from Workposition  where  department.id=" + deptid;
		List<Object> dlist2 = missiontypeBussiness.exHql(selhql2);
		response.setContentType("text/html;charset=GBK");
		request.setAttribute("deptid", deptid);
		request.setAttribute("workgradelist", dlist);
		request.setAttribute("employeelist", dlist1);
		request.setAttribute("workposition", dlist2);
		request.setAttribute("dlist3", dlist3);
		request.setAttribute("dlist4", dlist3);
		return "selposition";
	}

	/**14032
	 * 
	 * 给人员分配职位
	 */
	public void changeworkposition() {
		
		
        Integer v1=value1!=null?Integer.parseInt(value1):0;//岗位类型
 		String employ = employeeid;
		int empid=Integer.parseInt(employ);//员工id
		int postion = Integer.parseInt(workpositionid);//岗位id
		String deptempid="from Employee where id="+empid;
		List empdeptid=missiontypeBussiness.exHql(deptempid);
		List<Employee> empdeptid1=empdeptid;
		Integer deptid0=empdeptid1.get(0).getDepartment().getId();
		String seldeptlx="from Workposition where id="+postion;//查询职位
		List sfzg=missiontypeBussiness.exHql(seldeptlx);
		List<Workposition> sfzg1=sfzg;
		for (int i = 0; i < sfzg.size(); i++) {
			Integer o;
			if(sfzg1.get(0).getIspersonman()==null){
				
				o=0;
			}else{
			 o=sfzg1.get(0).getIspersonman();
			}
			if(o==1){
				
				
			}
			Integer deptid=sfzg1.get(0).getDepartment().getId();
			if(deptid==deptid0){
				if(o==1){
					
					v1=4;
				}else{
					v1=1;
				}
				
			}else{
					if(o==1){
					
					v1=3;
				}else{
					v1=2;
				}
				
				
			}
		}
		if(v1==2){
			
			String fgid=sfzg1.get(0).getParpostionid()!=null?sfzg1.get(0).getParpostionid():"";
			if(fgid!=""){
			String fgids[]=fgid.split(",");
			for (int i = 0; i < fgids.length; i++) {
				missiontypeBussiness.changeworkpos(employ, Integer.parseInt(fgids[i]),3);
				
				
			}
			}
		}
		String hql0="from WorkpositionEmployee where positionid="+postion+" and empid="+empid;
		List we=missiontypeBussiness.exHql(hql0);
		String hql="from WorkpositionEmployee where positiontype=1 and empid="+empid;
		
		List we1=missiontypeBussiness.exHql(hql);//这个人是否存在主岗
		String sql="select ispersonman from Workposition where id="+postion;
		List iszg=missiontypeBussiness.exHql(sql);
		List<Integer> l3=iszg;
		for (int i = 0; i < l3.size(); i++) {
			Integer a=l3.get(i);
			if(a==1){
				if(v1!=4){
					
					try {
						response.getWriter().print("false3");//是主管岗位，请选择主管岗位类型
						return;
						} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						}
					
					
				}
				
			}else{
				if(v1==4){
					try {
						response.getWriter().print("false4");//是主管岗位，请选择主管岗位类型
						return;
						} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						}
				}
				
				
				
				
			}
		}
		
		String hqls="from WorkpositionEmployee where  positionid="+postion;
		List we1s=missiontypeBussiness.exHql(hqls);//这个职位是否存在主管人员
		int x2=we1s.size();
		if(x2>0&&v1==4){
			try {
				response.getWriter().print("false1");
				return;
				} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}
			
		}
		int x1=we1.size();
		if(x1>0&&v1==1){
			try {
				response.getWriter().print("false2");
				return;
				} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}
			
		}
		int x=we.size();
		System.out.println(x);
		Boolean boolean1=false;
		if(x==0){
		 boolean1= missiontypeBussiness.changeworkpos(employ, postion,v1);
		}
		response.setContentType("text/html;charset=GBK");
		try {
			if(boolean1==true){
			response.getWriter().print("ok");
			}else {
				response.getWriter().print("false");	
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 修改部门职位 14032
	 */
	public void editworkposition(){
		
	int weid=Integer.parseInt(workpositionempid);
	String employ = employeeid;
	int empid=Integer.parseInt(employ);
	int postion = Integer.parseInt(workpositionid);
	Integer v1=value1!=null?Integer.parseInt(value1):0;
	Integer workid1=workid!=null?Integer.parseInt(workid):0;
	String hqls1="select ispersonman from Workposition where  id="+postion;
	
	List we1s1=missiontypeBussiness.exHql(hqls1);//这个职位是否存在主管人员
	for (int i = 0; i < we1s1.size(); i++) {
	if(we1s1.get(0)!=null && we1s1.get(0)!=""){
		
		Object o=we1s1.get(0);
		String s=o.toString();
		if(s.equals("1")){
			v1=4;
			
		}
		
	}
		
	}
	
	String hqls="from WorkpositionEmployee where  positionid="+postion;
	List we1s=missiontypeBussiness.exHql(hqls);//这个职位是否存在主管人员
	int x2=we1s.size();
	if(x2>0&&workid1==1){
		try {
			response.getWriter().print("false1");
			return;
			} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
		
	}
	 
	String HQL="update workposition_employee set positionid="+postion+",empid="+empid+",positiontype="+v1+" where id="+weid;
	System.out.println(HQL);
	missiontypeBussiness.update(HQL);
	
	response.setContentType("text/html;charset=GBK");
	try {
		
		response.getWriter().print("ok");
		
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
	/**
	 * 删除部门职位人员
	 */
	public void delworkposition(){
		
		int weid=Integer.parseInt(workpositionempid);
		String sql="delete from workposition_employee where id="+weid;
		missiontypeBussiness.update(sql);
		response.setContentType("text/html;charset=GBK");
		try {
			
			response.getWriter().print("ok");
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 编辑部门信息的详细信息加载信息页面
	 */
	public String editdept() {
		int deptid = Integer.parseInt(request.getParameter("deptid"));
		System.out.println(deptid);
		String addhql = "from Department where delflag=0 and id=" + deptid; // 获得当前id的部门信息
		List dlist = missiontypeBussiness.exHql(addhql);
		int parentid;
		int directorId = 0;
		request.setAttribute("deptlists", dlist);
		List<Department> list1 = dlist;
		parentid = list1.get(0).getParentId();
		request.setAttribute("deptname", list1.get(0).getName());
		System.out.println(directorId);
		List<Employee> emplist = missiontypeBussiness.seldirectorId(deptid);
		String addhql1 = "from Department  where delflag=0 and id=" + parentid;// 获得直属部门的名字。
		List list11 = missiontypeBussiness.exHql(addhql1);

		request.setAttribute("deptlist1", list11);

		String addhql2 = "from Employee where isLeave=1 and delflag='0' and department="
				+ deptid;// 获得此部门的员工。
		List dlist2 = missiontypeBussiness.exHql(addhql2);

		String nameString = "";
		for (int i = 0; i < emplist.size(); i++) {
			Object object = emplist.get(0);
			nameString = (String) object;
		}
		String sqlS = "from DepartmentGrade"; // 得到级别信息
		List gradlist = missiontypeBussiness.exHql(sqlS);
		request.setAttribute("gradlist", gradlist);
		if (nameString != "") {
			request.setAttribute("emplist", nameString);
		} else {
			request.setAttribute("emplist", "");
		}
		if (dlist2.size() > 0) {
			request.setAttribute("deptlist2", dlist2);
		}
		return "editdept";
	}

	/**
	 * 编辑部门信息的详细信息
	 */
	public String editdepment() {
		try {
			request.setCharacterEncoding("GBK");
			response.setCharacterEncoding("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int depid = Integer.parseInt(request.getParameter("deptid"));// 部门id
		String deptname = request.getParameter("deptname") != null ? request
				.getParameter("deptname") : "";// 名
		String tel = request.getParameter("tel") != null ? request
				.getParameter("tel") : "";// 电话
		String depno = request.getParameter("depno") != null ? request
				.getParameter("depno") : "";// 电话
		String zhuguan = request.getParameter("zhuguan") != null ? request
				.getParameter("zhuguan") : "0";// 主管
				if(zhuguan.equals("0")){
					
					zhuguan=request.getParameter("sel")!= null ? request
							.getParameter("sel") : "0";// 主管
					
				}
		String zg=		request.getParameter("sel");
		int isbj = request.getParameter("isbj") != null ? Integer
				.parseInt(request.getParameter("isbj")) : 0;// 半级
		int fiiale = request.getParameter("fiiale") != null ? Integer
				.parseInt(request.getParameter("fiiale")) : 0;// 分公司
		String filialemark = request.getParameter("filialemark") != null ? request
				.getParameter("filialemark")
				: "";// 分公司标识:
		String islevel1 = request.getParameter("islevel") != "" ?
						request.getParameter("islevel") :"0";// 级别	
		if(islevel1=="0"){
							islevel1=request.getParameter("islevel1")!=""?request.getParameter("islevel1") : "7";
						}
		Integer  islevel=Integer.parseInt(islevel1);
		Boolean B = missiontypeBussiness.editdepent(depid, tel, zhuguan, isbj,
				fiiale, filialemark, deptname, depno,islevel);
		String addhq11 = "from Department where delflag=0  order by islevel,squnum ";
		List dlis = missiontypeBussiness.exHql(addhq11);

		// 如果是1，2级将全部数组放到newdatas里面
		request.setAttribute("deptlist", dlis);
		
		return "editdeptment";
	}

	/**
	 * 删除部门，把部门人员调度到临时部门
	 * 
	 */
	public void deldept() {
		int deptid = Integer.parseInt(pid);
		int islevel1 = Integer.parseInt(islevel);
		x=new StringBuffer();
		StringBuffer s=selemp(pid);
		String x=s.toString();
		 String idx[]=  x.split(",");
		missiontypeBussiness.deldept(idx);
		
		

		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().print("ok");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 给临时部门分配部门 得到次低级部门部门级别
	 */
	public String getislevefater() {
		String hql0 = "from Employee where isLeave=1   and department=0";
		String hql = "from Department where  delflag=0 ";

		List list = missiontypeBussiness.exHql(hql);

		List list0 = missiontypeBussiness.exHql(hql0);
		request.setAttribute("deptlist0", list0);
		request.setAttribute("deptlist", list);

		return "getislevefater";
	}

	/**
	 * 分配临时部门的员工去指定部门
	 */
	public void setemployye() {
		int empid = Integer.parseInt(employeeid);
		int depid = Integer.parseInt(workpositionid);

		missiontypeBussiness.setemployye(empid, depid);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().print("ok");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 显示出部门的职位和人员
	 */

	public void xianshi() {
		int deptid = Integer.parseInt(pid);
		System.out.println(deptid);
		String zwlist = missiontypeBussiness.xianshi(deptid);

		request.setAttribute("zhiweilist", zwlist);

		System.out.println(zwlist);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().print(zwlist);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 初始话部门
	 */

	public String resetposition() {

		String n1 = request.getParameter("n1");
		String n2 = request.getParameter("n2");

		missiontypeBussiness.resetposition(n1);

		return employeeid;

	}
	 /**
	  * 初始化顺序
	  */
	public String resetDeptqum(){
		request.removeAttribute("deptlist");
		missiontypeBussiness.resetDeptqum();
		return "showtype";
	
		
	}
	/**
	 * 添加部门业务
	 */
    public String addOperation(){
    	logger.info("addOperation1");
    	int superid=PublicMissionType.operationtype;
    	logger.info("addOperation1-"+superid);
        String deptid=request.getParameter("deptid");
        int id=Integer.parseInt(deptid);
        String hql="From Department where id="+id;
        Department dep=(Department)missiontypeBussiness.exHql(hql).get(0);
        String deptname=dep.getName();
        request.setAttribute("deptid", deptid);
        request.setAttribute("deptname", deptname);
        String hql2="From Missiontype where superid="+superid;
        List missiontypelist=missiontypeBussiness.exHql(hql2);
        request.setAttribute("missiontypelist",missiontypelist);
        int d=missiontypelist.size();
        System.out.println(missiontypelist.size());
        String hql3="From OperationDepartmentmatch where departid="+deptid;
        List operationDepartmentlist=missiontypeBussiness.exHql(hql3);
        request.setAttribute("operationDepartmentlist", operationDepartmentlist);
        logger.info("addOperation1-end");
    	return "addOperation";
    }
    
    /**
     * 将数据写入部门业务表中
     */
    public void addOperation2(){
    
    	try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
    int deptid=Integer.parseInt(request.getParameter("deptid"));
    int typeid=Integer.parseInt(request.getParameter("typeid"));
    double money1=Double.parseDouble(this.money1);
    double money2=Double.parseDouble(this.money2);
    double money3=Double.parseDouble(this.money3);
    double money4=Double.parseDouble(this.money4);
    double money5=Double.parseDouble(this.money5);
    double money6=Double.parseDouble(this.money6);
    double money7=Double.parseDouble(this.money7);
    double money8=Double.parseDouble(this.money8);
    double money9=Double.parseDouble(this.money9);
    double money10=Double.parseDouble(this.money10);
    double money11=Double.parseDouble(this.money11);
    double money12=Double.parseDouble(this.money12);
    double jd1=Double.parseDouble(this.jd1);
    double jd2=Double.parseDouble(this.jd2);
    double jd3=Double.parseDouble(this.jd3);
    double jd4=Double.parseDouble(this.jd4);
    double sbn=Double.parseDouble(this.sbn);
    double xbn=Double.parseDouble(this.xbn);
    double year=Double.parseDouble(this.year);
    String hql="From OperationDepartmentmatch where departid="+deptid+" and typeid="+typeid;
    List operationDepartlist=missiontypeBussiness.exHql(hql);
    OperationDepartmentmatch operationDepart=null;
    double money=Double.parseDouble(request.getParameter("money"));
    String explain=request.getParameter("explain");
    String explains="";
	try {
		explains = URLDecoder.decode(explain, "utf-8");
	} catch (UnsupportedEncodingException e2) {
		// TODO Auto-generated catch block
		e2.printStackTrace();
	}
    java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd ");
    // 得到当前时间
    Date now = new Date();
    String creatTime = dateFormat2.format(now);
    if(operationDepartlist==null||operationDepartlist.size()==0){
    missiontypeBussiness.addOperationDepart(typeid, deptid, money, creatTime, explains);
    String hql1="From OperationDepartmentmatch where departid="+deptid+" and typeid="+typeid;
    List operationDepartlist1=missiontypeBussiness.exHql(hql1);
    OperationDepartmentmatch operationDepart1=null;
    operationDepart1=(OperationDepartmentmatch)operationDepartlist1.get(0);
    int foreignId=operationDepart1.getId();
    missiontypeBussiness.addAuditline(foreignId,money1,money2,money3,money4,money5,money6,money7,money8,money9,money10,money11,money12,jd1,jd2,jd3,jd4,sbn,xbn,year,1,0,creatTime);
		try {
			response.getWriter().print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    else if(operationDepartlist!=null||operationDepartlist.size()!=0){
    	operationDepart=(OperationDepartmentmatch)operationDepartlist.get(0);
    	int oid=operationDepart.getId();
    	missiontypeBussiness.updateOperationDepart(oid,money,creatTime,explains);
    	missiontypeBussiness.updateAuditline(oid,money1,money2,money3,money4,money5,money6,money7,money8,money9,money10,money11,money12,jd1,jd2,jd3,jd4,sbn,xbn,year,1,0,creatTime);
    	try {
			response.getWriter().print(1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    }
    
    /**
     * 获得按年月季度录入数据
     */
    public void getAuditlines(){
    	response.setCharacterEncoding("utf-8");
    	int foreignId=Integer.parseInt(request.getParameter("id"));
    	int temp=Integer.parseInt(request.getParameter("temp"));
    	String hql="From Auditline where foreignId="+foreignId+" and temp="+temp;
    	List auditlinelist=missiontypeBussiness.exHql(hql);
    	Auditline aud=null;
    	aud=(Auditline)auditlinelist.get(0);
    	String str=aud.getJanuarymoney()+","+aud.getFebruarymoney()+","+aud.getMarchmoney()+","+aud.getAprilmoney()+","+aud.getMaymoney()+","+aud.getJunemoney()+","+aud.getJulymoney()+","+aud.getAugustmoney()+","+aud.getSeptembermoney()+","+aud.getOctobermoney()+","+aud.getNovembermoney()+","+aud.getDecembermoney()+","+aud.getFirstquarter()+","+aud.getTwoquarter()+","+aud.getThreequarter()+","+aud.getFourquarter()+","+aud.getHalfyear1()+","+aud.getHalfyear2()+","+aud.getYearmoney();
    	try {
			response.getWriter().print(str);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }
    /**
     * 删除部门业务数据
     */
    public void delOperation(){
    	int deptid=Integer.parseInt(request.getParameter("deptid"));
    	int typeid=Integer.parseInt(request.getParameter("typeid"));
    	String hql1="From OperationDepartmentmatch where departid="+deptid+" and typeid="+typeid;
    	List operationDepartlist=missiontypeBussiness.exHql(hql1);
        OperationDepartmentmatch operationDepart=null;
        operationDepart=(OperationDepartmentmatch)operationDepartlist.get(0);
        int foreignId=operationDepart.getId();
        missiontypeBussiness.delAuditline(foreignId,1,0);
    	missiontypeBussiness.delDepOperation(deptid,typeid);
    	try {
			response.getWriter().print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * 显示授权信息
     */
    public String getAuthorization(){
    	//查询该部门下的所有子部门
    	ArrayList<Integer> dm = new ArrayList<Integer>();
    	ArrayList<Integer> dms = new ArrayList<Integer>();
    	List<Map<String,Integer>> dmlist = new ArrayList<Map<String,Integer>>();
        String hql11="From Department ";
        List departmentlist1=missiontypeBussiness.exHql(hql11);
        for(int i=0;i<departmentlist1.size();i++){
        	Map<String, Integer> map=new HashMap<String, Integer>();
        	Department dep1=(Department)departmentlist1.get(i);
        	map.put("id", dep1.getId());
        	map.put("parentid",dep1.getParentId());
        	dmlist.add(map);
        }
     
    	int superid=PublicMissionType.operationtype;
    	String deptid=request.getParameter("deptid");
        int id=Integer.parseInt(deptid);
        this.list=new ArrayList();
        list.add(id);//一级
        this.getDeptById(id);
        
   for(int j=0;j<dmlist.size();j++){
        	if(dmlist.get(j).get("parentid")==id){
        		dm.add(dmlist.get(j).get("id"));
        	}
        	
        }
        
        System.out.println("+++++++++++++++++"+dms.size());
        String hql="From Department where id="+id;
        Department dep=(Department)missiontypeBussiness.exHql(hql).get(0);
        String deptname=dep.getName();
        request.setAttribute("deptid", deptid);
        request.setAttribute("deptname", deptname);
        
        
        String hql2="From Missiontype where superid="+superid;
        List missiontypelist=missiontypeBussiness.exHql(hql2);
        request.setAttribute("missiontypelist",missiontypelist);
        
        int len=0;
        if(list!=null && list.size()>0){
        	len=list.size();
        }
        String str="";
        for(int n=0;n<len;n++){
        	str+=","+list.get(n);
        }
        String hql3="From Employee where isLeave=1 AND delflag=0 AND department!=0 and department in(''"+str+")";
        
        List employeelist=missiontypeBussiness.exHql(hql3);
        request.setAttribute("employeelist",employeelist);
        String hql4="From OperationEmployeematch where temp="+deptid;
        List DepartToEmplist=missiontypeBussiness.exHql(hql4);
        request.setAttribute("DepartToEmplist", DepartToEmplist);
        String hql5="From OperationDepartmentmatch where departid="+deptid+"order by money desc";
        if(missiontypeBussiness.exHql(hql5).size()!=0){
        OperationDepartmentmatch oper=(OperationDepartmentmatch)missiontypeBussiness.exHql(hql5).get(0);
        request.setAttribute("oper", oper);
        }
    	return "getAuthorization";
    }
    
    
    @SuppressWarnings("unchecked")
	public List getDeptById(int deptid){
       String hql="from Department where delflag=0 and parentid="+deptid;
       List dlist=missiontypeBussiness.exHql(hql);
       for(int i=0;i<dlist.size();i++){
    	   Department dept=(Department)dlist.get(i);
    	   if(dept!=null){
    		   System.out.println(dept.getId());
    		   list.add(dept.getId());
    	   }
       }
       if(dlist!=null && dlist.size()>0){
    	   for(int i=0;i<dlist.size();i++){
    		   Department dept=(Department)dlist.get(i);
    		   if(dept!=null){
    			   getDeptById(dept.getId());
    		   }
    	   }
       }
       return dlist;
    }
    
    /**
     * 获得运维组所有列表
     */
   
    public String getOperations(){
    	String hql = "from Missiontype ";
		List Operationlist = missionBussiness.exHql(hql);
		request.setAttribute("Operationlist", Operationlist);
		response.setContentType("text/html;charset=GBK");
		return "operationgroup";
    }
    
    /**
	 * 类型表添加新的运维组--付飞翔
	 */

	public void addTypesOperation() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		// 得到当前时间
		Date now = new Date();
		String nowstr = dateFormat2.format(now);
		String typename = "";
		try {
			typename = request.getParameter("typeName");
			typename = URLDecoder.decode(typename, "utf-8");
			System.out.println(typename);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String superids = request.getParameter("superid");
		String isflag = request.getParameter("isflag");
		int isflags = Integer.parseInt(isflag);
		int ids = Integer.parseInt(superids);

		missiontypeBussiness.addTypes(ids, typename, nowstr, isflags);
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().write("yes");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	public void seeemps(){
		response.setCharacterEncoding("utf-8");
		int operid=Integer.parseInt(request.getParameter("operid"));
		String hql="from Operationgroup where operId="+operid;
		List operationgrouplist=missiontypeBussiness.exHql(hql);
		Operationgroup opera=null;
		if(operationgrouplist.size()!=0){
		opera=(Operationgroup)operationgrouplist.get(0);
		String empnames=opera.getEmpnames();
		try {
			response.getWriter().print(empnames);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		else{
			try {
				response.getWriter().print(0);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	/**
	 * 运维部门转接业务
	 */
	public void getOperationzj(){
		response.setCharacterEncoding("utf-8");
		int operid=Integer.parseInt(request.getParameter("operid"));
		String hql="from Operationgroup where operId="+operid;
		List operationgrouplist=missiontypeBussiness.exHql(hql);
		if(operationgrouplist.size()==0){
		    
			try {
				response.getWriter().print(1);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
			else{
				Operationgroup opera=null;
				opera=(Operationgroup)operationgrouplist.get(0);
				String empids=opera.getEmpids();
				String empnames=opera.getEmpnames();
				String hql1="from Employee where id in(";
				int len=empids.split(",").length;
				for(int i=0;i<len;i++){
					hql1+=empids.split(",")[i]+",";
				}
				int len2=hql1.length();
				String hql2=hql1.substring(0, len2-1);
				hql2+=")";
				List employeelist=missiontypeBussiness.exHql(hql2);
				Employee employee=null;
				String data="";
				if(employeelist.size()!=0){
				for(int j=0;j<employeelist.size();j++){
					employee=(Employee)employeelist.get(j);
					int eid=employee.getId();
					String ename=employee.getName();
					 data+="<option value='"+eid+"' style='width: 100px'>"+ename+"</option>";
				}
				}
				try {
					response.getWriter().print(data);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	}
	
	
	public void addOperationgroups(){
		int operid=Integer.parseInt(request.getParameter("operid"));
		String empids=request.getParameter("empids");
		String empnames=request.getParameter("empnames");
		String vempnames="";
		try {
			 vempnames=URLDecoder.decode(empnames, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String nowstr = sdf.format(now);
		String hql="from Operationgroup where operId="+operid;
		List operationgrouplist=missiontypeBussiness.exHql(hql);
		if(operationgrouplist.size()==0){
		missiontypeBussiness.addOperationGroup(operid,empids,vempnames,nowstr);
		try {
			response.getWriter().print(1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		else{
			Operationgroup opera=null;
			opera=(Operationgroup)operationgrouplist.get(0);
			int id=opera.getId();
			missiontypeBussiness.editOperationGroup(id,empids,vempnames,nowstr);
			try {
				response.getWriter().print(2);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 获取员工列表
	 * @return
	 */
	public String emplist() {
		response.setCharacterEncoding("utf-8");
		String hql="from Employee where isLeave=1 and delflag=0";
		List emplist = missiontypeBussiness.exHql(hql);
		String hql2="from Operationgroup";
		List list=null;
		List operationgrouplists=missiontypeBussiness.exHql(hql2);
		int len=operationgrouplists.size();
		Operationgroup ope=null;
		String str2="";
		if(len!=0){
		for(int j=0;j<len;j++){
			ope=(Operationgroup)operationgrouplists.get(j);
			str2+=ope.getEmpids();
		}
		String[] str3=str2.split(",");
		list=getOperationEmpids(str3);
		}
		String str = "";
		for(int i=0;i<emplist.size();i++){
			Employee emp = (Employee)emplist.get(i);
			int ids=emp.getId();
			if(list!=null && list.size()!=0&&list.contains(emp.getId().toString())){
			str+="<tr><td><input type='checkbox' id="+emp.getId()+" value='"+emp.getName()+"' onclick='checkEmp(this)'/>"+emp.getName()+"----员工已被选"+"</td></tr>";
			}else{
			str+="<tr><td><input type='checkbox' id="+emp.getId()+" value='"+emp.getName()+"' onclick='checkEmp(this)'/>"+emp.getName()+"</td></tr>";
			}
			
		}
		int operid=Integer.parseInt(request.getParameter("operid"));
		String hql1="from Operationgroup where operId="+operid;
		List operationgrouplist=missiontypeBussiness.exHql(hql1);
		String str1="";
		if(operationgrouplist.size()!=0){
		Operationgroup operationgroup=null;
		operationgroup=(Operationgroup)operationgrouplist.get(0);
		String empids=operationgroup.getEmpids();
		String empnames=operationgroup.getEmpnames();
		str1 = empids+";"+empnames;}
		String strs=str+";"+str1;
		try {System.out.println(strs+"kkkassdsoa");
			response.getWriter().print(strs);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	/**
	 *运维组所有录入的员工id 
	 */
	public List getOperationEmpids(String []str) {  
		        for (String elementA:str ) {  
		            System.out.print(elementA + " ");  
		        }  
		        List<String> list = new ArrayList<String>();  
		        for (int i=0; i<str.length; i++) {  
		            if(!list.contains(str[i])) {  
		                list.add(str[i]);  
		            }  
		        }
		   return list;     
	}
	public String getOperationemps(){
		response.setCharacterEncoding("utf-8");
		int operid=Integer.parseInt(request.getParameter("operid"));
		String hql="from Operationgroup where operId="+operid;
		List operationgrouplist=missiontypeBussiness.exHql(hql);
		Operationgroup operationgroup=null;
		operationgroup=(Operationgroup)operationgrouplist.get(0);
		String empids=operationgroup.getEmpids();
		String empnames=operationgroup.getEmpnames();
		String str1 = empids+";"+empnames;
		
		try {
			response.getWriter().write(str1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
    
	public void setWorkpositionempid(String workpositionempid) {
		this.workpositionempid = workpositionempid;
	}

	public String getWorkpositionempid() {
		return workpositionempid;
	}

	public void setEmplist(List emplist) {
		this.emplist = emplist;
	}

	public List getEmplist() {
		return emplist;
	}

	public void setWorkid(String workid) {
		this.workid = workid;
	}

	public String getWorkid() {
		return workid;
	}
    
    
   
}
