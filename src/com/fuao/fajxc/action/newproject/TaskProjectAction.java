package com.fuao.fajxc.action.newproject;

/*******
 * 项目任务，与任务分配Action
 */
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.system.UploadBussiness;
import com.fuao.fajxc.dao.newproject.TaskProject;
import com.fuao.fajxc.util.PageBuilder;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewFunctionDelRecord;
import com.fuao.fajxc.vo.NewFunctionRecord;
import com.fuao.fajxc.vo.NewPrjdept;
import com.fuao.fajxc.vo.NewPrjtresource;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.Ordertype;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.Taskplan_saleorder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TaskProjectAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private TaskProject taskdao;
	private NewTask newtask;// 任务对象
	private Integer pid=-2;// 项目编号
	//上传
	private String upload;
	private String uploadFileName;
	private NewFunction function;
	
	private List<File> filedata;
	private List<String> sczjmc;
	private List<String> FiledataFileName;
	private List<String> FiledataContentType;
	private String name;
	private Object[] ids;
	private String marker2;
	private Integer taskid;
	
	// 接收对象
 	private AllType allTypeByPayStatus;

	public Groups getGroups() {
		return groups;
	}
	public void setGroups(Groups groups) {
		this.groups = groups;
	}

	private Customer customer;	
    private Questioncategory allTypeByOrdertype;  //分类
    private Department department;
    private Groups groups;
    private Employee employee;

	private UploadBussiness upbiz;
	
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	public Questioncategory getAllTypeByOrdertype() {
		return allTypeByOrdertype;
	}
	public void setAllTypeByOrdertype(Questioncategory allTypeByOrdertype) {
		this.allTypeByOrdertype = allTypeByOrdertype;
	}
	public AllType getAllTypeByPayStatus() {
		return allTypeByPayStatus;
	}
	public void setAllTypeByPayStatus(AllType allTypeByPayStatus) {
		this.allTypeByPayStatus = allTypeByPayStatus;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Integer getTaskid() {
		return taskid;
	}
	public void setTaskid(Integer taskid) {
		this.taskid = taskid;
	}
	public String getMarker2() {
		return marker2;
	}
	public void setMarker2(String marker2) {
		this.marker2 = marker2;
	}
	public Object[] getIds() {
		return ids;
	}
	public void setIds(Object[] ids) {
		this.ids = ids;
	}
	public NewFunction getFunction() {
		return function;
	}
	public void setFunction(NewFunction function) {
		this.function = function;
	}
	public String getUpload() {
		return upload;
	}
	public void setUpload(String upload) {
		this.upload = upload;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public NewTask getNewtask() {
		return newtask;
	}
	public void setNewtask(NewTask newtask) {
		this.newtask = newtask;
	}
	public TaskProject getTaskdao() {
		return taskdao;
	}
	public void setTaskdao(TaskProject taskdao) {
		this.taskdao = taskdao;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String select(){
		System.out.println("+++++++++++++++++"+pid);
		String npid=request.getParameter("npid");//项目id
		// 格式化时间
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		Pages page=null;
		// 得到当前登陆人
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		// 绑定项目
		List projectlist=taskdao.getProject(employee.getId());
		String hql="from NewTask where flag=0 and emp.id="+employee.getId()+" and function.finishtasktype=1";
		
		if(this.pid==-2){
			// 根据所在的项目得到这个项目的任务，并默认查询的是当前时间正在执行的项目。如果当前登陆人当前时间执行了几个项目的话那么就取第一个。
//			NewProject project=(NewProject)projectlist.get(0);// 取随机一个正在进行的项目做为默认的。
			List tasklist=taskdao.projectlist(employee.getId());	
			page = PageBuilder.createPage(Integer.parseInt(pageNo),tasklist.size(),10);// 创建分页。
			int n=Integer.parseInt(pageNo);
			// 算出从第几页开始
			int pyno=(n-1)*10;
			// 分页后的集合。
			List pagetask=new ArrayList();
			// 封装集合。
			for(int i=pyno;i<n*10;i++){
				if(i<tasklist.size()){
					pagetask.add(tasklist.get(i));
				}
			}
			page.setPageList(pagetask);
		}else{
			// 保存查询条件
			request.setAttribute("pid", this.pid);
			if(this.pid!=0){
				List newfunctlist=taskdao.prjtask(pid);
				String fid="";
				for(int i=0;i<newfunctlist.size();i++){
					NewFunction fun=(NewFunction)newfunctlist.get(i);
					fid+=","+fun.getId();
				}
				fid=fid.replaceFirst(",", "");
				if(fid.trim().length()<=0){
					fid="''";
				}
				hql+=" and function.id in("+fid+")";
			}
			if(npid!=null&&!npid.equals("")){
				List newfunctlist=taskdao.prjtask(Integer.parseInt(npid));
				String fid="";
				for(int i=0;i<newfunctlist.size();i++){
					NewFunction fun=(NewFunction)newfunctlist.get(i);
					fid+=","+fun.getId();
				}
				fid=fid.replaceFirst(",", "");
				if(fid.trim().length()<=0){
					fid="''";
				}
				hql+=" and function.id in("+fid+")";
			}
			
			if(this.newtask!=null){
				if(this.newtask.getFunction()!=null){
					if(this.newtask.getFunction().getId()!=0){
						System.out.println(this.newtask.getFunction().getId());
						hql+=" and function.id="+this.newtask.getFunction().getId();
						request.setAttribute("fid", this.newtask.getFunction().getId());
						NewFunction fun=(NewFunction)taskdao.getObj(NewFunction.class, this.getNewtask().getFunction().getId());
						request.setAttribute("fname", fun.getFunctionname());
					}
				}
				if(this.newtask.getBegintime()!=null){
					String begintime= dateFormat2.format(this.newtask.getBegintime());
					hql+=" and begintime>='"+begintime+"'";
					request.setAttribute("begintime", begintime);
				}
				if(this.newtask.getEndtime()!=null){
					String endtime= dateFormat2.format(this.newtask.getEndtime());
					hql+=" and endtime<='"+endtime+"'";
					request.setAttribute("endtime", endtime);
				}
			}
				
			page= taskdao.paginationQuery(hql, Integer.parseInt(pageNo), 10, null);
		}
		
		request.setAttribute("taskdao", taskdao);
		//查询所有订单类型
		List marklist = taskdao.getDomark();
		//将集合放在request中
		request.setAttribute("marklist", marklist);
		
		
		// 导出任务列表
		String dcstr=request.getParameter("dc");
		if(dcstr!=null && dcstr.equals("1")){
			int dc=Integer.parseInt(dcstr);
			List tasklist=taskdao.execHQL(hql);
			request.setAttribute("tasklist", tasklist);
			return "dctask";
		}else{
			request.setAttribute("tasklist", page.getPageList());
			request.setAttribute("pages", page);
			request.setAttribute("prjlist", projectlist);
			return "listsuccess";
		}
		
		
	}
	
	
	
	
	/*******
	 * 根据项目编号和到这个项目下所有的功能
	 * @return
	 */
	public String function(){
		int pid=Integer.parseInt(request.getParameter("pid"));
		System.out.println("++++______+++"+pid);
		List newfunctlist=taskdao.prjtask(pid);
		System.out.println("++++++__________"+newfunctlist.size());
		String str="<option value='0'>--请选择--</option>";
		if(newfunctlist.size()<=0){
			str+="<option value='0'>未发布任务</option>";
		}
		for(int i=0;i<newfunctlist.size();i++){
			NewFunction newfu=(NewFunction)newfunctlist.get(i);
			str+="<option value="+newfu.getId()+">"+newfu.getFunctionname()+"</option>";
		}
		try {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out=response.getWriter();
			out.println(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	/*****
	 * 点击办理请求到页面
	 */
	public String handleTask(){
//		sdjlasdjkfalsdkfjalsdjfalsdfjalsjd
		System.out.println("sssssss");
		System.out.println("sssssss");
		System.out.println("sssssss");
		System.out.println("sssssss");
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		
		// 任务ID
		int taskid=Integer.parseInt(request.getParameter("taskid"));
		//保存这个taskid
		request.setAttribute("taskid",taskid);
		// 根据任务编号得到任务对象
		NewTask task=(NewTask)taskdao.getObj(NewTask.class, taskid);
		// 根据任务ID与任务负责人去查询工作记事
		List loglist=taskdao.logByTask(task);
		List<Scheduleplan> schellist=new ArrayList<Scheduleplan>();
		// 根据功能得到功能下的任务。
		for(int i=0;i<loglist.size();i++){
			Scheduleplan schel =(Scheduleplan)loglist.get(i);
			NewTask t = taskdao.functionByLog(schel);
			// 暂时利用 记事表里的字段来存储值。分别代表是.任务名称(tmp),进度(isplan),任务id(tmp2);
			Employee emp=t.getEmp();
			schel.setEmployee(emp);
			schel.setTmp(t.getFunction().getFunctionname());
			schel.setTmp2(t.getId().toString());
			schellist.add(schel);
		}
		Pages page = PageBuilder.createPage(Integer.parseInt(pageNo),schellist.size(),10);// 创建分页。
		int n=Integer.parseInt(pageNo);
		// 算出从第几页开始
		int pyno=(n-1)*10;
		// 分页后的集合。
		List pagetask=new ArrayList();
		// 封装集合。
		for(int i=pyno;i<n*10;i++){
			if(i<schellist.size()){
				pagetask.add(schellist.get(i));
			}
		}
		
//		//从任务、订单的中间表取数据
//		String hql = "from Taskplan_saleorder where taskid = "+taskid;
//		List ts = taskdao.execHQL(hql);
//		for(int i=0;i<ts.size();i++){
//			Taskplan_saleorder s = (Taskplan_saleorder)ts.get(i);
//			s.getSaleorderid();
//		}
//		request.setAttribute("ts", ts);
		//查询所有订单类型
		List marklist = taskdao.getDomark();
		
		
		page.setPageList(pagetask);
		
		request.setAttribute("loglist", page.getPageList());
		request.setAttribute("task", task);
		request.setAttribute("pages", page);
		//把marklist对象放在request中
		request.setAttribute("marklist", marklist);
		
		return "handletask";
	}
	
	/******
	 * 上传附件与添加进度
	 *  
	 */
	public String updateJD(){
//		// 得到当前登录人的主管
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");		
		NewTask task=(NewTask)taskdao.getObj(NewTask.class, newtask.getId());
		// 得到项目负责人也就是以前所说的发起人。
		Employee launcher= taskdao.getLauncher(task.getFunction().getNewProject().getLauncher());
        if(request.getSession().getAttribute("abcname")!=null){ 
        	String filedataname2=request.getSession().getAttribute("filedataname2").toString();
			String filename=request.getSession().getAttribute("abcname").toString();
			request.getSession().removeAttribute("abcname"); 
			request.getSession().removeAttribute("filedataname2"); 
			// 进度
			int jd=newtask.getSchedule();
			//task.setSchedule(jd);
			taskdao.add(task);
			// 任务保存成功后再对日志进行添加数据，不过在这里日志的内容是空的只是暂时的位置。在显示的时候可以提示用户去写日志
			Scheduleplan schel=new Scheduleplan();
			int fid=taskdao.getFun(newtask.getId());
			NewFunction function=(NewFunction)taskdao.getObj(NewFunction.class, fid);
			schel.setFunction(function);
			schel.setPlantype(5);// 日记事
			Employee emp=(Employee)taskdao.getObj(Employee.class,task.getEmp().getId());
			schel.setEmployee(emp);// 执行人
			schel.setIsplan(jd);// 保存任务进度，与日志同步
			// 得到当前时间
			Date now=new Date();
	        String nowstr=dateFormat2.format(now);
	        schel.setBegintime(nowstr);
	        schel.setEndtime(nowstr);
	        schel.setTmp3(filename);
	        schel.setTmp1(filedataname2);// 储存附件名
			// 保存日志
			taskdao.addLog(schel);
		    request.setAttribute("taskid", task.getId());
		    
		    // 添加到给项目消费表里面去并给其主管进行审批。
		    NewPrjtresource prjresource=new NewPrjtresource();
		    prjresource.setTask(task);
		    prjresource.setEmp(launcher);
		    prjresource.setEmpsubmit(employee);
		    prjresource.setTplan(newtask.getSchedule());// 得到当前提交的任务进度。
		    prjresource.setSubtime(nowstr);// 办理任务提交的时间
		    prjresource.setNfj(filename);
		    prjresource.setTemp2(filedataname2);//备注字段存储附件原名

		    Double money=0d;// 备注字段存储了钱。
		    if(newtask.getTemp().trim().length()<=0){
		    	money=0d;
		    }else{
		    	money=Double.parseDouble(newtask.getTemp());
		    }
		    prjresource.setNmoney(money);
		    String remark="";
			try {
				remark = URLDecoder.decode(newtask.getTemp1(), "utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    prjresource.setRemakes(remark);// 申请索要支出金额的原因。
		    prjresource.setAppstatus(2);
		    taskdao.addPrjresource(prjresource);
		  
		    /********
		     * 只在在审批通过后才会影响进度。
		     */
        }
        else{
			// 进度
			int jd=newtask.getSchedule();
			// 任务保存成功后再对日志进行添加数据，不过在这里日志的内容是空的只是暂时的位置。在显示的时候可以提示用户去写日志
			Scheduleplan schel=new Scheduleplan();
			int fid=taskdao.getFun(newtask.getId());
			NewFunction function=(NewFunction)taskdao.getObj(NewFunction.class, fid);
			schel.setFunction(function);
			schel.setPlantype(5);// 日记事
			Employee emp=(Employee)taskdao.getObj(Employee.class,task.getEmp().getId());
			schel.setEmployee(emp);// 执行人
			schel.setIsplan(jd);// 保存任务进度，与日志同步
			// 得到当前时间
			Date now=new Date();
	        String nowstr=dateFormat2.format(now);
	        schel.setBegintime(nowstr);
	        schel.setEndtime(nowstr);
			// 保存日志
			taskdao.addLog(schel);
			request.setAttribute("taskid", task.getId());
			
			 // 添加到给项目消费表里面去并给其主管进行审批。
		    NewPrjtresource prjresource=new NewPrjtresource();
		    prjresource.setTask(task);
		    prjresource.setEmp(launcher);
		    prjresource.setEmpsubmit(employee);
		    prjresource.setTplan(newtask.getSchedule());// 得到当前提交的任务进度。
		    prjresource.setSubtime(nowstr);// 办理任务提交的时间
		    Double money=Double.parseDouble(newtask.getTemp());// 备注字段存储了钱。
		    prjresource.setNmoney(money);
		    System.out.println(newtask.getTemp1());
		    String remark="";
			try {
				remark = URLDecoder.decode(newtask.getTemp1(), "utf-8");
			    System.out.println(remark);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    prjresource.setRemakes(remark);// 申请索要支出金额的原因。
		    prjresource.setAppstatus(2);
		    taskdao.addPrjresource(prjresource);
		    try {
		    	List l1=taskdao.execHQL("FROM NewTask where id="+newtask.getId());
		    	NewTask newtask1=new NewTask();
		    	newtask1=(NewTask)l1.get(0);
		    	newtask1.setSchedule(newtask.getSchedule());
		    	taskdao.update(newtask1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
		
		return "updatejd";
	}
	
	
	/*
	 * 上传文件
	 */
public String uploadfiles(){
			NewTask task=(NewTask)taskdao.getObj(NewTask.class, newtask.getId());
			// 进度
			int jd=newtask.getSchedule()+task.getSchedule();
			task.setSchedule(jd);
			task.setFj(uploadFileName);
			taskdao.add(task);
			// 任务保存成功后再对日志进行添加数据，不过在这里日志的内容是空的只是暂时的位置。在显示的时候可以提示用户去写日志
			Scheduleplan schel=new Scheduleplan();
			int fid=taskdao.getFun(newtask.getId());
			NewFunction function=(NewFunction)taskdao.getObj(NewFunction.class, fid);
			schel.setFunction(function);
			schel.setPlantype(5);// 日记事
			Employee emp=(Employee)taskdao.getObj(Employee.class,task.getEmp().getId());
			schel.setEmployee(emp);// 执行人
			schel.setIsplan(jd);// 保存任务进度，与日志同步
			// 得到当前时间
			Date now=new Date();
	        String nowstr=dateFormat2.format(now);
	        schel.setBegintime(nowstr);
	        schel.setEndtime(nowstr);
			// 保存日志
			taskdao.addLog(schel);

			
		request.setAttribute("taskid", task.getId());
		
		
		return "updatejd";
	}
	
	
	
	/*******
	 * 分配任务列表，根据当前登录的人去判断我这个人是不是一个项目的负责人如果是一个项目的负责人的话那么就可以对项目进行分配任务。
	 */
	public String publishtask(){
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		// 得到当前登录人
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		// 判断当前登录人是不是项目审批人也就是负责人，得到这个人审批的项目集合
		List projectlist=taskdao.projectlist(employee);
		Pages  page=null;

		// 得到所有当前项目下面所有参与人的员工列表
		List emplist= new ArrayList();

		String hql="";
		if(projectlist!=null && projectlist.size()>0){
			// 默认查询最近一段时间项目下的所有任务
			NewProject newprj=(NewProject)projectlist.get(0);
			// 根据项目编号得到参与人列表
			emplist=taskdao.cyrByPid(newprj.getId());
			if(function!=null){
				if(function.getNewProject()!=null){
					if(function.getNewProject().getId()!=null && function.getNewProject().getId()!=-1){
						emplist=taskdao.cyrByPid(function.getNewProject().getId());
						hql="from NewFunction where flag=0 and newProject.id="+function.getNewProject().getId();
						request.setAttribute("pid", function.getNewProject().getId());
					}else{
						hql="from NewFunction where flag=0 and newProject.id="+newprj.getId();
					}
				}
				if(function.getBegintime()!=null){
					String begintime= dateFormat2.format(function.getBegintime());
					hql+=" and begintime>='"+begintime+"'";
					request.setAttribute("begintime", begintime);
				}
				if(function.getEndtime()!=null){
					String endtime= dateFormat2.format(function.getEndtime());
					hql+=" and endtime<='"+endtime+"'";
					request.setAttribute("endtime", endtime);
				}
			}else{
				hql="from NewFunction where flag=0 and newProject.id="+newprj.getId();
			}
			
			page= taskdao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
		} 
		
		request.setAttribute("projectlist", projectlist);
		request.setAttribute("taskdao", taskdao);
		request.setAttribute("emplist", emplist);
		
		String dcstr=request.getParameter("dc");
		if(dcstr!=null&&dcstr.equals("1")){
			List tasklist=taskdao.execHQL(hql);
			request.setAttribute("tasklist", tasklist);
			return "dcpublish";
		}else{
			if(page!=null){
				request.setAttribute("tasklist", page.getPageList());
			}
			request.setAttribute("pages", page);
			return "publish";
		}
		
	}
	
	/*******
	 * 查看更多参与人
	 */
	public String more(){
		int fid=Integer.parseInt(request.getParameter("fid"));
		NewFunction function=(NewFunction)taskdao.getObj(NewFunction.class, fid);
		List list= taskdao.taskemp(fid);
		String flag=request.getParameter("flag");
		String str="";
		if(flag.equals("0")){
			for(int i=0;i<list.size();i++){
				Employee emp=(Employee)list.get(i);
				str+=emp.getName()+"   ";
			}
		}else{
			for(int i=0;i<list.size();i++){
				Employee emp=(Employee)list.get(i);
				str+="<input type='checkbox' name='emp' value='"+fid+"' id='"+emp.getId()+"'>";
				if(function.getFinishtasktype()==0){
					str+="<a href='#'>"+emp.getName()+"<a>"+"&nbsp;&nbsp;&nbsp;";
				}else{
					str+=emp.getName()+"&nbsp;&nbsp;&nbsp;";
				}
			}
			str+="<a href='javascript:cyr("+fid+");' title='点击可给任务分配新人员，也可以将选中的人员任务移交给新人员。'>分配人员</a>";
		}
		try {
			response.setCharacterEncoding("utf-8");
			PrintWriter out=response.getWriter();
			out.println(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/******
	 * 移交员工任务
	 */
	public String moveEmp(){
		
		String tendtime=request.getParameter("tendtime"); // 任务结束时间
		String emp=request.getParameter("empno");
		String emptask=request.getParameter("emptask");//移交前的id和fid
		System.out.println(emp+emptask);//emp为移交后的人
		// 员工，要判断我选择的人员存不存在当前任务中，如果存在的话那么就把这个人给删除。如果说不存在则把新人员添加这个任务。并删除这个人。
		 String[] emparr=emp.split(",");//移交后的人ID emparr[0];
		 String[] emptaskarr=emptask.split(",");
		 String str="";
		 for(int i=0;i<emptaskarr.length;i++){
			 String task=emptaskarr[i];
			 String[] taskarr= task.split("\\|");
			 int empid=Integer.parseInt(taskarr[0]);// 旧人员
			 int fid=Integer.parseInt(taskarr[1]);// 旧人员所在的任务编号
			 Employee oldemp= (Employee)taskdao.getObj(Employee.class, empid);
			 // 得到旧人员的任务对象
			 NewTask newtask=taskdao.getNewTask(empid, fid);
			 for(int j=0;j<emparr.length;j++){
				 int newempid=Integer.parseInt(emparr[j]);
				 if(empid!=newempid){
					 // 如果存在的话那么他的任务不变其余的人员都新增过来。
					    Employee newemp= (Employee)taskdao.getObj(Employee.class, newempid);
					    if(tendtime!=null && tendtime.trim().length()>0){ // 修改任务时间
					    	NewFunction function=newtask.getFunction();
					    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");  
					    	Date date=new Date();
							try {
								date = df.parse(tendtime);
							} catch (ParseException e) {
								e.printStackTrace();
							}   
					    	function.setEndtime(date);
					    	taskdao.updateFunEndtime(function);
					    	newtask.setEndtime(date);
					    }
					    newtask.setEmp(newemp);
					    // 在添加之前判断新人员存不存在这个任务里
					    NewTask tnk= taskdao.getNewTask(newempid, fid);
					    if(tnk.getId()==null){
					    	taskdao.add(newtask);// 这里只是修改了当前任务
					    	taskdao.updateParentTask(fid,oldemp,newemp); // 判断当前任务有没有子任务，有则将其对应的人员修改成新人员
					    }else{
					    	taskdao.add(newtask);
					    	taskdao.updateParentTask(fid,oldemp,newemp);
					    }
					 //新增之后把这个旧消费记录更新到新增消费记录。  
					    NewPrjtresource resource=new NewPrjtresource();
					    resource.setTask(newtask);
					 // 添加任务记录
					    NewFunctionRecord record=new NewFunctionRecord();
					    record.setFunction(newtask.getFunction());
					    record.setOldemp(oldemp);
					    record.setNewemp(newemp);
					    record.setTurntime(new Date());
					    taskdao.addRecord(record);
					    str="任务分配成功，重新登录系统可查看新人员！";
				 }else{
					 str="移交任务给不同的人！";
				 }
			 }
		 }
		 try {
				response.setCharacterEncoding("utf-8");
				PrintWriter out=response.getWriter();
				out.println(str);
			} catch (Exception e) {
				e.printStackTrace();
		}
		
		return null;
	}
	
	/********
	 * 给任务添加员工
	 */
	public String addEmp(){
		String empstr=request.getParameter("empstr");// 新人员
		int fid=Integer.parseInt(request.getParameter("fid"));// 功能编号
		String tendtime=request.getParameter("tendtime"); // 任务结束时间
		System.out.println(tendtime);
		String[] emparr=empstr.split(",");
		int flag=0;
		boolean bool=false;
		// 根据 fid判断当前的empid存不存在于我这个任务里，如果它以前都存在我这个任务的话那么就不添加这个人
		List emplist=taskdao.taskemp(fid); 
		for(int i=0;i<emparr.length;i++){
			bool=false;
			int empid=Integer.parseInt(emparr[i]);
			for(int j=0;j<emplist.size();j++){
				Employee emp=(Employee)emplist.get(j);
				if(empid==emp.getId()){
					bool=true;
					break;
				}
			}
			if(bool==false){
				// 给任务添加新人员 
				NewTask task=new NewTask();
				NewFunction function=(NewFunction)taskdao.getObj(NewFunction.class, fid);
				// 首先改变任务模块的时间
				if(tendtime.trim().length()>0){
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");  
					Date date=null;
					try {
						date = df.parse(tendtime);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}   
					System.out.println(date);
					function.setEndtime(date);
					taskdao.updateFunEndtime(function);
				}
				System.out.println(function.getEndtime());
				Employee newemp=(Employee)taskdao.getObj(Employee.class, empid);
				task.setFunction(function);
				task.setBegintime(new Date());
				task.setEndtime(function.getEndtime());
				task.setSchedule(0);
				task.setEmp(newemp);
				taskdao.addNewTas(task);
				flag=1;
			}
		}
		
		try {
			String str="";
			if(flag==0){
				str="此参与人员已经存在！";
			}else{
				str="人员任务分配成功，刷新可查看新人员！";
			}
			response.setCharacterEncoding("utf-8");
			PrintWriter out=response.getWriter();
			out.println(str);
		} catch (Exception e) {
			e.printStackTrace();
	   }
		
		return null;
	}
	
	/*******
	 * 删除任务
	 */
	public String del(){
		
		String taskstr=request.getParameter("taskstr");
		String[] taskarr=taskstr.split(",");
		for(int i=0;i<taskarr.length;i++){
			int fid=Integer.parseInt(taskarr[i]);
			// 根据功能编号删除任务与项目功能数据。
			taskdao.del(fid);
		}
		try {
			String str="删除成功，为了您的数据统一建议您刷新系统！";
			response.setCharacterEncoding("utf-8");
			PrintWriter out=response.getWriter();
			out.println(str);
		} catch (Exception e) {
			e.printStackTrace();
	   }
		
		return null;
	}
	
	/************
	 * 查看任务移交的记录
	 */
	public String taskrecord(){
		int fid=Integer.parseInt(request.getParameter("fid"));
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		String hql="from NewFunctionRecord where function.id="+fid;
		
	     try {
	    	 String projectname= URLDecoder.decode(request.getParameter("projectname"), "utf-8");
			 String functionname=URLDecoder.decode(request.getParameter("functionname"), "utf-8");
			 String turntime=request.getParameter("turntime");
			 String oldempname=URLDecoder.decode(request.getParameter("oldempname"), "utf-8");
			 String newempname= URLDecoder.decode(request.getParameter("newempname"),"utf-8");
				if(projectname!=null){
					hql+=" and function.newProject.projectname like '%"+projectname+"%'";
					request.setAttribute("projectname", projectname);
				}
				if(functionname!=null){
					hql+=" and function.functionname like '%"+functionname+"%'";
					request.setAttribute("functionname", functionname);
				}
				if(turntime!=null){
					hql+=" and turntime>='"+turntime+"'";
					request.setAttribute("turntime", turntime);
				}
				if(oldempname!=null){
					hql+=" and oldemp.name like '%"+oldempname+"%'";
					request.setAttribute("oldempname", oldempname);
				}
				if(newempname!=null){
					hql+=" and newemp.name like '%"+newempname+"%'";
					request.setAttribute("newempname", newempname);
				}
		 	} catch (Exception e) {
		 	}
			request.setAttribute("fid", fid);
			
		 	String dcstr=request.getParameter("dc");
		 	if(dcstr!=null&&dcstr.equals("1")){
		 		List recordlist=taskdao.execHQL(hql);
		 		request.setAttribute("recordlist", recordlist);
				return "dcfunctinrecord";
		 	}else{
				Pages page= taskdao.paginationQuery(hql, Integer.parseInt(pageNo), 12, null);
				request.setAttribute("pages",page);
				return "functinrecord";
		 	}
	}
	
	public String selMarkBytemp2(){
		System.out.println(ids); //得到选中项的ID
		System.out.println(marker2); //得到选中项的Bean的名字
		System.out.println(taskid);
		String ids2 = StringUtil.arrayToString(this.ids); //将数组转换成字符串
		String[] id = ids2.split(",");
		for(int i=0;i<id.length;i++){
			int oid = Integer.parseInt(id[i]);
			String sql = "insert into taskplan_saleorder(taskid,saleorderid,flag,status) values("+taskid+","+oid+",'"+marker2+"',0)";
			System.out.println(sql);
			taskdao.addPlan_Order(sql);
		}
		return null;
	}
	
	/**
	 * 点击编号,查询订单或者合同的详情
	 * @return
	 */
	public String saleorderInfo() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String mar = request.getParameter("marker");
		String id = request.getParameter("id");
		int oid = Integer.parseInt(id);
		System.out.println(id);
		
		List docmarklist = taskdao.getDocmark();
		for(int i=0;i<docmarklist.size();i++){
			Docmark docmark = (Docmark)docmarklist.get(i);
			if(mar.equals(docmark.getTemp1())){
				out.print(docmark.getTemp2());
				request.setAttribute("temp2", docmark.getTemp2());
			}
		}
		//根据marker和订单id定位某条记录
//		List list = taskdao.getSaleorder_task(oid, mar);
//		if(list.size()>0){
//			Object ts = list.get(0);
//			if(ts!=null){
//				out.print("SUCCESS");
//				request.setAttribute("saleorder", ts);
//			}else{
//				out.print("ERROR");
//			}
//		 }else {
//			 out.print("NO");
//		}
		
		return null;
	}
	
	/*********
	 * 查询当前登录人得到所有的待批任务，并且要判断当前登录人是部门主管才有权力查看
	 */
	public String waitapptask(){
		// 得到当前登录人
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		// 查询保存集合
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		Pages pages=null;
		// 只查看未通过与正在审批中有任务
		String apptaskhql="from NewPrjtresource where 1=1";
		// 如果当前登录人是提交任务的人话那么有权力查看自己的待批任务，但是没有权力进行审批
		List list=taskdao.execHQL(apptaskhql);

        String apptaskid="";
        // 判断是提交任务人
		for(int m=0;m<list.size();m++){
			NewPrjtresource res=(NewPrjtresource)list.get(m);
			if(res.getEmpsubmit().getId().equals(employee.getId())){
				apptaskid+=","+res.getId();
			}
		}
		// 判断是项目负责人
        for(int m=0;m<list.size();m++){
			NewPrjtresource res=(NewPrjtresource)list.get(m);
			if(res.getEmp().getId().equals(employee.getId())){
				apptaskid+=","+res.getId();
			}
		}
		apptaskhql+=" and id in(''"+apptaskid+")";
		// 拼接字符串查询
		try {
			String projectname= URLDecoder.decode(request.getParameter("projectname"),"utf-8");
			String taskname= URLDecoder.decode(request.getParameter("taskname"),"utf-8");
			String subtime= request.getParameter("subtime");
			String subempname= URLDecoder.decode(request.getParameter("subempname"),"utf-8");  
			String appempname= URLDecoder.decode(request.getParameter("appempname"),"utf-8");
			String appstatus= request.getParameter("appstatus");
			if(projectname!=null&&projectname.trim().length()>0){
				apptaskhql+=" and task.function.newProject.projectname like '%"+projectname+"%'";
				request.setAttribute("projectname", projectname);
			}
			if(taskname!=null&&taskname.trim().length()>0){
				apptaskhql+=" and task.function.functionname like '%"+taskname+"%'";
				request.setAttribute("taskname", taskname);
			}
			if(subtime!=null&&subtime.trim().length()>0){
				apptaskhql+=" and subtime>='"+subtime+"'";
				request.setAttribute("subtime", subtime);
			}
			if(subempname!=null&&subempname.trim().length()>0){
				apptaskhql+=" and empsubmit.name like '%"+subempname+"%'";
				request.setAttribute("subempname", subempname);
			}
			if(appempname!=null&&appempname.trim().length()>0){
				apptaskhql+=" and emp.name like '%"+appempname+"%'";
				request.setAttribute("appempname", appempname);
			}
			if(!appstatus.equals("-1")){
				if(appstatus.equals("0")){
					apptaskhql+=" and appstatus in(0,3)";
				}else{
					apptaskhql+=" and appstatus="+appstatus;
				}
				request.setAttribute("appstatus", appstatus);
			}
		} catch (Exception e) {
		}
		apptaskhql+=" order by id desc";
		String dcstr=request.getParameter("dc");
		request.setAttribute("emp",employee);
		if(dcstr!=null && dcstr.equals("1")){
			List tasklist=taskdao.execHQL(apptaskhql);
			request.setAttribute("waitapptask", tasklist);
			return "dcwaitapptask";
		}else{
			pages=taskdao.paginationQuery(apptaskhql, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("pages", pages);
			return "waitapptask";
		}
	}
	
	/************
	 * 审批任务
	 */
	public String app(){
		int approveid=Integer.parseInt(request.getParameter("approveid"));
		int appstatus=Integer.parseInt(request.getParameter("status"));
		String content="";
		try {
			content= URLDecoder.decode(request.getParameter("content"),"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 得到待审批任务的对象 
		NewPrjtresource resource=(NewPrjtresource)taskdao.getObj(NewPrjtresource.class, approveid);
		// 审批通过
		if(appstatus==1){
			resource.setAppstatus(1);
			resource.setTemp1(content);
			// 进度员工任务进度
			NewTask task=resource.getTask();
			// 审批通过以后将task_saleorder表的状态给改成1。
			String hqlString = "from Taskplan_saleorder where taskid = "+task.getId();
			List ts = taskdao.execHQL(hqlString);
		    for(int j=0;j<ts.size();j++){
		        Taskplan_saleorder s = (Taskplan_saleorder)ts.get(j);
		        s.setStatus(1);
		        taskdao.updateTaskSaleorder(s);
		    }
			
			int jd=resource.getTplan()+task.getSchedule();
			if(jd>100){
				jd=100;
			}
			task.setSchedule(jd);
			taskdao.add(task);
			// 得到newfunction对象
			NewFunction function=resource.getTask().getFunction();
			function.setFstate(jd);
			// 审批通过以后才能引响任务进度，并且将记事中的状态改成审批通过
		    taskdao.jdByFid(function);
		    // 项目进度的修改
		    taskdao.jdByPid(function);
		}
		// 审批拒绝
		if(appstatus==0){
			resource.setAppstatus(3);
			resource.setTemp1(content);
			taskdao.updateResource(resource);
		}
		// 审批为2的话就改变审批人
		if(appstatus==2){
			// 得到这个任务下面的项目监督者，将审批人改成它就行了
			Employee emp=resource.getTask().getFunction().getNewProject().getEmployee();
			resource.setEmp(emp);
			resource.setAppstatus(2);
			resource.setTemp1(content);
			taskdao.updateResource(resource);
		}
		return "app";
	}
	
	/*********
	 * 根据任务编号得到任务对象
	 */
	public String selTaskInfo(){
		int taskid=Integer.parseInt(request.getParameter("taskid"));
		NewTask task=(NewTask)taskdao.getObj(NewTask.class, taskid);
		request.setAttribute("task", task);
		request.setAttribute("taskdao", taskdao);

		return "selTaskInfo";
	}

	/**
	 * 任务移交时,判断当前登录人是否为某个部门的主管,并且还是某个项目参与部门的主管
	 * @return
	 */
	public String transfer() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		//根据项目id区
		Employee employee = (Employee)this.request.getSession().getAttribute("emp");
		String hql = "from Department where delflag=0";
		List<Department> deptlist = taskdao.getDepartment(hql);
		//项目id 
		int xmid = Integer.parseInt(request.getParameter("xmid"));
		System.out.println(xmid);
		List<NewPrjdept> list = taskdao.getPrjdeptByPid(xmid);
		for(int i=0;i<list.size();i++){
			NewPrjdept prjdept = list.get(i); 
			int zgid = prjdept.getDept().getEmployee().getId();
			for(int j=0;j<deptlist.size();j++){
				Department dept = deptlist.get(j);
				int empid = dept.getEmployee().getId(); //部门主管id
				if(empid==employee.getId() && zgid==employee.getId()){
					out.print("1");
				}
			}
		}
		
		
		
		return null;
	}


	/*********
	 * 查看删除任务的记录
	 */
	public String delRecord(){
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		int pid=Integer.parseInt(request.getParameter("pid"));
		System.out.println(pid);
		String hql="from NewFunctionDelRecord where function.newProject.id="+pid;
		try {
			String functionname= URLDecoder.decode(request.getParameter("functionname"),"utf-8");
			String tasktype=request.getParameter("tasktype");
			String begintime=request.getParameter("begintime");
			String endtime=request.getParameter("endtime");
			String deltime=request.getParameter("deltime");
			if(functionname!=null && functionname.trim().length()>0){
				hql+=" and function.functionname like '%"+functionname+"%'";
				request.setAttribute("functionname",functionname);
			}
			if(!tasktype.equals("-1")){
				hql+=" and function.finishtasktype="+tasktype;
				request.setAttribute("tasktype", tasktype);
			}
			if(begintime!=null && begintime.trim().length()>0){
				hql+=" and function.begintime>='"+begintime+"'";
				request.setAttribute("begintime", begintime);
			}
			if(endtime!=null && endtime.trim().length()>0){
				hql+=" and function.endtime<='"+endtime+"'";
				request.setAttribute("endtime", endtime);
			}
			if(deltime!=null && deltime.trim().length()>0){
				hql+=" and deldate>='"+deltime+"'";
				request.setAttribute("deltime", deltime);
			}
		} catch (Exception e) {
		}

		request.setAttribute("pid", pid);// 保存项目编号，分页传值所用。
		request.setAttribute("taskdao", taskdao);
		
		String dcstr=request.getParameter("dc");
		if(dcstr!=null && dcstr.equals("1")){
			List list=taskdao.execHQL(hql);
			request.setAttribute("list", list);
			return "DCdelRecord";
		}else{
			Pages pages=taskdao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("pages", pages);
			return "delRecord";
		}
	}
	

}
