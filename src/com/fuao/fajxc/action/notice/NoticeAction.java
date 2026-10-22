package com.fuao.fajxc.action.notice;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.hql.ast.tree.FromClause;

import com.fuao.fajxc.bussiness.customService.MalfunctionDeclarBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.message.NoticeDao;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Notice;
import com.fuao.fajxc.vo.NoticeDept;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class NoticeAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private NoticeDao noticeDao;
	private Notice notice;
	private MalfunctionDeclarBussiness maldao;
	private AuditingBussiness auditingBussiness;
	public ExecuteRecordBussiness executeRecordBussiness;
	
	public void setServletRequest(HttpServletRequest arg0) {
		request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		response = arg0;
	}

	public Object getModel() {
		
		return null;
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

	public NoticeDao getNoticeDao() {
		return noticeDao;
	}

	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}

	public Notice getNotice() {
		return notice;
	}

	public void setNotice(Notice notice) {
		this.notice = notice;
	}

	public AuditingBussiness getAuditingBussiness() {
		return auditingBussiness;
	}

	public void setAuditingBussiness(AuditingBussiness auditingBussiness) {
		this.auditingBussiness = auditingBussiness;
	}

	public MalfunctionDeclarBussiness getMaldao() {
		return maldao;
	}

	public void setMaldao(MalfunctionDeclarBussiness maldao) {
		this.maldao = maldao;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	Cookies ck = new Cookies();
	
	/**
	 * 
	 * @return
	 */
	public String send(){
		String hql = "from Department where delflag=0";
		List list = noticeDao.getNotice(hql);
		System.out.println(list.size());
		request.setAttribute("list", list);
		return "tosend";
	}
	
	/**
	 * 部门列表
	 * @return
	 */
	public String deptlist() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
//		ActionContext act = ActionContext.getContext();
//		HttpServletRequest req = (HttpServletRequest)act.get(ServletActionContext.HTTP_REQUEST);
//		String deptname = new String(req.getParameter("deptname").getBytes("ISO-8859-1"),"gbk");
		
		String name = request.getParameter("deptname");
		String hql = "from Department where id not in(0,1) and delflag=0";
		if(!"".equals(name) && null!=name){
			
			String deptname = URLDecoder.decode(name,"utf-8");
			hql += " and name like '%"+deptname+"%'";
		}
		List list = noticeDao.getNotice(hql);
		System.out.println(list.size());
		String str = "";
		for(int i=0;i<list.size();i++){
			Department dept = (Department)list.get(i);
			str+="<tr><td><input type='checkbox' id='"+dept.getId()+"' value='"+dept.getName()+"' onclick='checkDept(this)'/>"+dept.getName()+"</td></tr>";
		}
		out.print(str);
		return null;
	}
	
	/**
	 * 发布公告,进入审核
	 * @return
	 */
	public String sendToAudit() throws Exception{
		
		String fmark=ck.getCookie(request, "filialemark");
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");

		String no = serial.getSerialNumber();
		
		System.out.println(notice.getTitle());
		System.out.println(notice.getTypeid());
		System.out.println(notice.getContent());
		String deptid = request.getParameter("deptid");
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		
		int flg = Integer.parseInt(request.getParameter("flg"));
		if(flg==1){
			int id = notice.getId();
			System.out.println(id);
			Notice oldnotice = (Notice)noticeDao.getObjectById(Notice.class, id);
			String hql = "update Notice set draftFlag=0 where id="+id;
			noticeDao.updateNotice(hql);
			
			
			//上传附件
			Map zj =(Map) request.getSession().getAttribute("sczj");
			if(null!=zj && zj.size()>0){
			Iterator it = zj.keySet().iterator();
			String keyStr = "";
			String txtName = "";
			while(it.hasNext()){
				Object key = it.next();
				System.out.println("key="+key + ",value=" + zj.get(key));
				Object obj = zj.get(key);
				String name = (String)obj;
				String string = name.replace("/uploads/", "");
				keyStr+=key+",";
				txtName+=string+",";
			}
			System.out.println(txtName);
			
			String[] fjs = txtName.split(",");
			String[] mc = keyStr.split(",");
			for(int i=0;i<fjs.length;i++){
				String fjmc = fjs[i];  
				String hz = fjmc.substring(fjmc.lastIndexOf(".")+1);
				CommonScfjb fj = new CommonScfjb();
				fj.setFjmc(mc[i]);
				fj.setFjhz(hz);
				fj.setFjlj(fjmc);
				fj.setTmp("Notice");
				fj.setBuildTime(new Date());
				fj.setTmp1(oldnotice.getId().toString());
				noticeDao.addNotice(fj);
			}
		 }
			
			
			int marker = auditingBussiness.addAuditingOrderNotice("GG", oldnotice.getNoticeNo(), "GG", fmark);
			if(marker==0){
				response.getWriter().print("0");
			}else if(marker==2){
//				Employee loginEmp = this.getEmp();
				Employee loginEmp = (Employee)request.getSession().getAttribute("emp");
				if(null == loginEmp){
					request.setAttribute("errorMsg", "登陆超时,请重新登录");
					return "no";
				}
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个公告");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(oldnotice.getId().toString());
				executerecord.setEntityName("UpServer");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
				
				response.getWriter().print("2");
				request.getSession().removeAttribute("sczj");
			}else{
				response.getWriter().print("1");
			}
		}
		
	 if(flg==0){
		Notice nt = new Notice();
		nt.setNoticeNo(no);
		nt.setTitle(notice.getTitle());
		nt.setTypeid(notice.getTypeid());
		nt.setContent(notice.getContent());
		nt.setSendTime(new Date());
		nt.setAudtitingFlag(0); 
		nt.setDraftFlag(0);  
		nt.setIsRead(0);
		nt.setStartDept(emp.getDepartment());
		noticeDao.addNotice(nt);
		
		System.out.println(deptid);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String[] dept = deptid.split(",");
		for(int i=0;i<dept.length;i++){
			int id = Integer.parseInt(dept[i]);
			Department department = (Department)noticeDao.getObjectById(Department.class, id);
			NoticeDept nd = new NoticeDept();
			nd.setDept(department);
			nd.setNotice(nt);
			noticeDao.addNotice(nd);
		}
		
	
		Map zj =(Map) request.getSession().getAttribute("sczj");
		if(null!=zj && zj.size()>0){
		Iterator it = zj.keySet().iterator();
		String keyStr = "";
		String txtName = "";
		while(it.hasNext()){
			Object key = it.next();
			System.out.println("key="+key + ",value=" + zj.get(key));
			Object obj = zj.get(key);
			String name = (String)obj;
			String string = name.replace("/uploads/", "");
			keyStr+=key+",";
			txtName+=string+",";
		}
		System.out.println(txtName);
		
		String[] fjs = txtName.split(",");
		String[] mc = keyStr.split(",");
		for(int i=0;i<fjs.length;i++){
			String fjmc = fjs[i];  
			String hz = fjmc.substring(fjmc.lastIndexOf(".")+1);
			CommonScfjb fj = new CommonScfjb();
			fj.setFjmc(mc[i]);
			fj.setFjhz(hz);
			fj.setFjlj(fjmc);
			fj.setTmp("Notice");
			fj.setBuildTime(new Date());
			fj.setTmp1(nt.getId().toString());
			noticeDao.addNotice(fj);
		}
	}
		int marker = auditingBussiness.addAuditingOrderNotice("GG", nt.getNoticeNo(), "GG", fmark);
		if(marker==0){
			response.getWriter().print("0");
		}else if(marker==2){
//			Employee loginEmp = this.getEmp();
			Employee loginEmp = (Employee)request.getSession().getAttribute("emp");
			if(null == loginEmp){
				request.setAttribute("errorMsg", "登陆超时,请重新登录");
				return "no";
			}
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个公告");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(nt.getId().toString());
			executerecord.setEntityName("UpServer");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
			
			response.getWriter().print("2");
		}else{
			response.getWriter().print("1");
		}
	}
		return "tolist";
	}
	
	/**
	 * 发布公告时,点击存入草稿箱
	 * @return
	 */
	public String saveDraft() throws Exception{
		String fmark=ck.getCookie(request, "filialemark");
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		// 调用工具类
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");
		String no = serial.getSerialNumber();
		
		System.out.println(request.getParameter("content"));
		String title = request.getParameter("title");
		String t = URLDecoder.decode(title, "utf-8");
		String content = request.getParameter("content");
		String c = URLDecoder.decode(content, "utf-8");
		String deptid = request.getParameter("deptid");
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		
		Notice nt = new Notice();
		nt.setTitle(t);
		nt.setTypeid(Integer.parseInt(request.getParameter("type")));
		nt.setContent(c);
		nt.setSendTime(new Date());
		nt.setNoticeNo(no);
		nt.setAudtitingFlag(0); 
		nt.setDraftFlag(1);  //存入草稿箱
		nt.setIsRead(0);
		nt.setStartDept(emp.getDepartment());
		noticeDao.addNotice(nt);
		
		System.out.println(deptid);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String[] dept = deptid.split(",");
		for(int i=0;i<dept.length;i++){
			int id = Integer.parseInt(dept[i]);
			Department department = (Department)noticeDao.getObjectById(Department.class, id);
			NoticeDept nd = new NoticeDept();
			nd.setDept(department);
			nd.setNotice(nt);
			noticeDao.addNotice(nd);
		}
		
		
		//上传附件
		Map zj =(Map) request.getSession().getAttribute("sczj");
		if(null!=zj && zj.size()>0){
		Iterator it = zj.keySet().iterator();
		String keyStr = "";
		String txtName = "";
		while(it.hasNext()){
			Object key = it.next();
			System.out.println("key="+key + ",value=" + zj.get(key));
			Object obj = zj.get(key);
			String name = (String)obj;
			String string = name.replace("/uploads/", "");
			keyStr+=key+",";
			txtName+=string+",";
		}
		System.out.println(txtName);
		
		String[] fjs = txtName.split(",");
		String[] mc = keyStr.split(",");
		for(int i=0;i<fjs.length;i++){
			String fjmc = fjs[i];  
			String hz = fjmc.substring(fjmc.lastIndexOf(".")+1);
			CommonScfjb fj = new CommonScfjb();
			fj.setFjmc(mc[i]);
			fj.setFjhz(hz);
			fj.setFjlj(fjmc);
			fj.setTmp("Notice");
			fj.setBuildTime(new Date());
			fj.setTmp1(nt.getId().toString());
			noticeDao.addNotice(fj);
		}
	}
		request.getSession().removeAttribute("sczj");
		return "tolist";
	}
	
	
	
	/**
	 *
	 * @return
	 */
	public String listNt(){
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		int deptid = emp.getDepartment().getId();
		int flag = Integer.parseInt(request.getParameter("flag"));
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));

//		String hql = "from Notice where audtitingFlag=1 and draftFlag=0 and  order by id desc";
//		String sql = "from NoticeDept n,NoticeDept d where n.id=d.notice.id and n.audtitingFlag=1 and n.draftFlag=0 and d.dept.id="+emp.getDepartment().getId()+" order by n.id desc";
//		System.out.println(sql);
		String hql = "from NoticeDept where dept.id="+emp.getDepartment().getId()+" and notice.audtitingFlag=1 and notice.draftFlag=0 order by notice.id desc";
		Pages pages = noticeDao.exHqlPages(hql, pageNo, 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
//		List list = noticeDao.getNotice(hql);
		
//		request.setAttribute("list", list);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("emp", emp);
		request.setAttribute("demo", 1);
		return "list";
	}
	
	/**
	 * 待审核列表
	 * @return
	 */
	public String noApp(){
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		String hql = "from Notice where draftFlag=0 order by id desc";
//		List list = noticeDao.getNotice(hql);
//		String hql = "select distinct(d.id) from NoticeDept d where d.notice.draftFlag=0 order by d.notice.id desc";
		Pages pages = noticeDao.exHqlPages(hql, pageNo, 20, null);
		
//		request.setAttribute("list", list);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", 1);
		request.setAttribute("emp", emp);
		request.setAttribute("demo", 2);
		return "tosh";
	}
	
	/**
	 * 草稿箱列表
	 * @return
	 */
	public String draftList(){
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		int flag = Integer.parseInt(request.getParameter("flag"));
//		String hql = "from Notice where audtitingFlag=0 and draftFlag=1 order by id desc";
//		List list = noticeDao.getNotice(hql);
		String hql = "from NoticeDept where dept.id="+emp.getDepartment().getId()+" and notice.draftFlag=1 order by notice.id desc";
		Pages pages = noticeDao.exHqlPages(hql, pageNo, 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
//		request.setAttribute("list", list);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("emp", emp);
		request.setAttribute("demo", 1);
		return "list";
	}
	
	
	public String toAuditNt(){
		String hql = "from Notice where audtitingFlag=0 and draftFlag=0";
		List list = noticeDao.getNotice(hql);
		
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		request.setAttribute("list", list);
		request.setAttribute("emp", emp);
		return "toaudit";
	}
	
	/**
	 *
	 * @return
	 */
	public String detail(){
		int nid = Integer.parseInt(request.getParameter("nid"));
		String info = request.getParameter("info");
		Notice data = (Notice)noticeDao.getObjectById(Notice.class, nid);
//		data.setIsRead(1);
		String updhql = "update Notice set isRead=1 where id = "+nid;
		noticeDao.updateNotice(updhql);

		String hql = "from NoticeDept where notice.id="+nid;
		List list = noticeDao.getNotice(hql);
		

		Notice notice = (Notice)auditingBussiness.getObj(Notice.class, nid);
		if(notice.getAudtitingFlag()==0){
			request.setAttribute("mark", "mark");
		}
		String empid=ck.getCookie(request, "employeeId");  
		boolean flag1=auditingBussiness.checkemp1(notice.getNoticeNo(), empid);
		if(flag1){
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			if(notice.getNoticeNo()!=null){
				String addhql2=" and orderNo='"+notice.getNoticeNo()+"'";
				List audList=auditingBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null!=audList && audList.size()>0){
					String depid = ck.getCookie(request, "departmentId");
					for(int i=0;i<audList.size();i++){
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						if(aot.getDepartment().getId()==Integer.parseInt(depid) && aot.getAuditingFlag()==0){
							
							request.setAttribute("flage", 0);
						}else if(aot.getDepartment().getId()==Integer.parseInt(depid) && (aot.getAuditingFlag()==1
								|| aot.getAuditingFlag()==2)){
							
							request.setAttribute("flage", 1);
							request.setAttribute("aot", aot);
						}
					}
				}
			}
		}
		
		
		
		
		
		
		
		
		String fjhql = "from CommonScfjb where tmp1 = "+nid +" and tmp='Notice'";
		List fjlist = noticeDao.getNotice(fjhql);
		request.setAttribute("fjlist", fjlist);
		request.setAttribute("data", data);
		request.setAttribute("list", list);
		return "detail";
	}
	
	/**
	 * 
	 * @return
	 */
	public String noAppDetail(){
		int id = Integer.parseInt(request.getParameter("id"));
		String info = request.getParameter("info");
		Notice notice = (Notice)noticeDao.getObjectById(Notice.class, id);
		
		String hql = "from NoticeDept where notice.id="+notice.getId();
		List list = noticeDao.getNotice(hql);
		
		
		if(notice.getAudtitingFlag()==0){
			request.setAttribute("mark", "mark");
		}
	//	String empid=ck.getCookie(request, "employeeId");  
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		String empid = employee.getId().toString();
		boolean flag1=auditingBussiness.checkemp1(notice.getNoticeNo(), empid);
		if(flag1){
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			if(notice.getNoticeNo()!=null){
				String addhql2=" and orderNo='"+notice.getNoticeNo()+"'";
				List audList=auditingBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null!=audList && audList.size()>0){
				//	String depid = ck.getCookie(request, "departmentId");
					String depid = employee.getDepartment().getId().toString();
					for(int i=0;i<audList.size();i++){
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						if(aot.getDepartment().getId()==Integer.parseInt(depid) && aot.getAuditingFlag()==0){
							
							request.setAttribute("flage", 0);
						}else if(aot.getDepartment().getId()==Integer.parseInt(depid) && (aot.getAuditingFlag()==1
								|| aot.getAuditingFlag()==2)){
							
							request.setAttribute("flage", 1);
							request.setAttribute("aot", aot);
						}
					}
				}
			}
		}
		
		
		
		
		String fjhql = "from CommonScfjb where tmp1 = "+id+" and tmp='Notice'";
		List fjlist = noticeDao.getNotice(fjhql);
		request.setAttribute("fjlist", fjlist);
		request.setAttribute("data", notice);
		request.setAttribute("list", list);
		return "noAppDetail";
	}
	
	/**
	 * 
	 * @return
	 */
	public String resetNotice(){
		int id = Integer.parseInt(request.getParameter("id"));
		Notice notice = (Notice)noticeDao.getObjectById(Notice.class, id);
		notice.setAudtitingFlag(3);
		String hql = "update Notice set audtitingFlag=3 where id="+id;
		noticeDao.updateNotice(hql);
		return "reset";
	}
	
	/**
	 * 
	 * @return
	 */
	public String editNotice(){
		int id = Integer.parseInt(request.getParameter("id"));
		Notice notice = (Notice)noticeDao.getObjectById(Notice.class, id);

		String hql = "from NoticeDept where notice.id="+notice.getId();
		List list = noticeDao.getNotice(hql);
		String str = "";
		String strId = "";
		for(int i=0;i<list.size();i++){
			NoticeDept nd = (NoticeDept)list.get(i);
			str += nd.getDept().getName()+",";
			strId += nd.getDept().getId()+",";
		}
		
		//附件信息
		String fjhql = "from CommonScfjb where tmp1 = "+id+" and tmp='Notice'";
		List fjlist = noticeDao.getNotice(fjhql);
		request.setAttribute("fjlist", fjlist);
		request.setAttribute("strName", str);
		request.setAttribute("strId", strId);
		request.setAttribute("list", list);
		request.setAttribute("data", notice);
		return "editNotice";
	}
	
	/**
	 * 审核失败,点击编辑
	 * @return
	 */
	public String reSend(){
		int id = Integer.parseInt(request.getParameter("id"));
		Notice notice = (Notice)noticeDao.getObjectById(Notice.class, id);

		String hql = "from NoticeDept where notice.id="+notice.getId();
		List list = noticeDao.getNotice(hql);
		String str = "";
		String strId = "";
		for(int i=0;i<list.size();i++){
			NoticeDept nd = (NoticeDept)list.get(i);
			str += nd.getDept().getName()+",";
			strId += nd.getDept().getId()+",";
		}
		
		//附件信息
		String fjhql = "from CommonScfjb where tmp1 = "+id+" and tmp='Notice'";
		List fjlist = noticeDao.getNotice(fjhql);
		request.setAttribute("fjlist", fjlist);
		request.setAttribute("strName", str);
		request.setAttribute("strId", strId);
		request.setAttribute("list", list);
		request.setAttribute("data", notice);
		return "reSend";
	}
	
	/**
	 * @return
	 */
	public String successDetail(){
		int id = Integer.parseInt(request.getParameter("id"));
		Notice notice = (Notice)noticeDao.getObjectById(Notice.class, id);
		String info = request.getParameter("info");
	
		if(notice.getAudtitingFlag()==0){
			request.setAttribute("mark", "mark");
		}
		String empid=ck.getCookie(request, "employeeId"); 
		boolean flag1=auditingBussiness.checkemp1(notice.getNoticeNo(), empid);
		if(flag1){
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			if(notice.getNoticeNo()!=null){
				String addhql2=" and orderNo='"+notice.getNoticeNo()+"'";
				List audList=auditingBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null!=audList && audList.size()>0){
					String depid = ck.getCookie(request, "departmentId");
					for(int i=0;i<audList.size();i++){
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						if(aot.getDepartment().getId()==Integer.parseInt(depid) && aot.getAuditingFlag()==0){
						
							request.setAttribute("flage", 0);
						}else if(aot.getDepartment().getId()==Integer.parseInt(depid) && (aot.getAuditingFlag()==1
								|| aot.getAuditingFlag()==2)){
							
							request.setAttribute("flage", 1);
							request.setAttribute("aot", aot);
						}
					}
				}
			}
		}
		
		
		String hql = "from NoticeDept where notice.id="+id;
		List list = noticeDao.getNotice(hql);
		
		
		String fjhql = "from CommonScfjb where tmp1 = "+id+" and tmp='Notice'";
		List fjlist = noticeDao.getNotice(fjhql);
		request.setAttribute("fjlist", fjlist);
		request.setAttribute("data", notice);
		request.setAttribute("list", list);
		return "successDetail";
	}
	
}
