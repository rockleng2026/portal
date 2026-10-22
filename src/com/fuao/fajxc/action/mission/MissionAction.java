package com.fuao.fajxc.action.mission;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.fuao.fajxc.action.cdn.PurgeManager;
import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.mission.MissionBussiness;
import com.fuao.fajxc.bussiness.mission.MissiontypeBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.CDNsaleOrder;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.MissionEmp;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.Updatecache;
import com.fuao.fajxc.vo.cdnPanelPoint;
import com.fuao.fajxc.vo.cdnRealmNameIP;
import com.opensymphony.xwork2.ModelDriven;
@SuppressWarnings("deprecation")
public class MissionAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private static Logger  logger = Logger.getLogger(MissionAction.class);
		private MissionBussiness missionBussiness;
		private HttpServletRequest request;
		private HttpServletResponse response;
		private Mission mission;
		private MissiontypeBussiness missiontypeBussiness;
		private CommonBiz formbiz;
		
		//14015 2011-12-18 21:32:29 对应使用 630行作用
		private GroupSystemBussiness groupSystemBussiness;
		
		public GroupSystemBussiness getGroupSystemBussiness() {
			return groupSystemBussiness;
		}
		public void setGroupSystemBussiness(GroupSystemBussiness groupSystemBussiness) {
			this.groupSystemBussiness = groupSystemBussiness;
		}


		//要删除的id
		private Object[] ids;
		//要读取的id
		private Object[] duqu;
		// 得到参与人员ＩＤ
		private String empno;

		public String getEmpno() {
			return empno;
		}
		public void setEmpno(String empno) {
			this.empno = empno;
		}
		public Object[] getIds() {
			return ids;
		}
		public void setIds(Object[] ids) {
			this.ids = ids;
		}
		public Object[] getDuqu() {
			return duqu;
		}
		public void setDuqu(Object[] duqu) {
			this.duqu = duqu;
		}
		
		public Object getModel() {
			mission =new Mission();
			return mission;
		}
		/**
		 * 得到request
		 */
		public void setServletRequest(HttpServletRequest arg0) {
			this.request=arg0;
		}
		
		/**
		 * 得到response
		 */
		public void setServletResponse(HttpServletResponse arg0) {
			this.response=arg0;
			
		}
		
		
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss ");
		
		//获得当前时间
		Date now = new Date();
	    String str3 = dateFormat.format(now);
	    
	    int week = new Date().getDay();
		int date = new Date().getDate();
		int month = new Date().getMonth()+1;
		String nowDate = TimePattern.doTimeDf3(new Date());
	    /**
	     * 定时任务 定时添加发布任务
	     * @author 阙超强 14015
	     * 2011-12-7 17:10:45
	     */
	    @SuppressWarnings("unchecked")
		public void timingTask(){
	    	logger.info("timingTask开始开始开始"+StringUtil.formatDate(new Date()));
			try {
				//拿出所有未到期的任务
				List<Mission> misList = missionBussiness.getObjectList("Mission", " and status = 0 and cycleType != 5 and dueTime > " + "'"+nowDate+"'");
				int misListSize = misList.size();
				
				if( misListSize > 0 ){
					for(int i = 0; i < misListSize; i++){
						Mission mis = misList.get(i);
						
	        			//周期类型
	        			int cycleType = mis.getCycleType();
	        			//为了设置结束时间
	        			Calendar c = Calendar.getInstance();
	        			//日任务
						if(cycleType == 0){
							c.add(Calendar.HOUR_OF_DAY,15);
							goExe(mis,c);
						}
						//周任务
						else if(cycleType == 1 && week == 1){
							c.add(Calendar.DAY_OF_MONTH,7);
							goExe(mis,c);
						}
						//月任务
						else if(cycleType == 2 && date == 1){
							c.add(Calendar.MONTH,1);
							goExe(mis,c);
						}
						//季任务
						else if(cycleType == 3 && date == 1 && (month == 3 || month == 6 || month == 9 || month == 12)){
							c.add(Calendar.MONTH,3);
							goExe(mis,c);
						}
						//年任务
						else if(cycleType == 4 && month ==1 && date ==1){
							c.add(Calendar.YEAR,1);
							goExe(mis,c);
						}
					}
				}
				logger.info("timingTask结束"+StringUtil.formatDate(new Date()));
				Thread.sleep(1000);
				//保存附件
//				formbiz.addFJ(mis.getSbh(), "Mission", request);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
	    /**
	     * 执行新增 自动分配 自动绑定附件
	     * 2011-12-8 17:53:53
	     * @author 14015
	     * @param mis 拿到当前任务对象
	     * @param c   拿到结束时间（Calendar类型）
	     */
		public void goExe(Mission mis,Calendar c){
			try {
				//先拿出到期时间   再放入下一个任务中
				String duetime = mis.getDueTime();
				//此对象的ID
				int oldTaskId = mis.getTaskId();
				//此对象的uuid标示 于 附件的fbsbh
				String oldSbh = mis.getSbh();
				String uuid = UUID.randomUUID().toString(); //拿出来为了下面更新附件表  保持和附件一样UUID  绑定到任务表和附件表。
				/**************于duetime相关     自动添加任务****************/
				//修改之前的任务
				mis.setDueTime(nowDate);
				mis.setStatus("-1");
				mis.setEndTime(new Date());
				missionBussiness.updateData(mis);
				
				//添加一个新任务
				Mission mis2 = new Mission();
				mis2.setTaskId(null);
				mis2.setMissiontype(mis.getMissiontype());
				mis2.setEmployee(mis.getEmployee());
				mis2.setName(mis.getName());
				mis2.setExpStartTime(new Date());
				mis2.setExpEndTime(c.getTime());
				mis2.setBuildTime(new Date());
				mis2.setIsSingle(mis.getIsSingle());
				mis2.setDescription(mis.getDescription());
				mis2.setStatus("0");
				mis2.setEndTime(null);
				mis2.setSbh(uuid);
				mis2.setDueTime(duetime);
				mis2.setCycleType(mis.getCycleType());
				mis2.setTmp(mis.getTmp());
				mis2.setTmp1(mis.getTmp1());
				mis2.setTmp2(mis.getTmp2());
				mis2.setTmp3(mis.getTmp3());
				
				mis2.setMissionEmps(mis.getMissionEmps());
				mis2.setPlanses(mis.getPlanses());
				
				//添加并获得其对象 为了下面重新自动发布任务
				Mission newMission = (Mission) missionBussiness.addReturn(mis2);
				
				/**************于oldSbh相关    自动添加附件****************/
				String hqlSbh = "from CommonScfjb csfj where csfj.fbsbh = " + "'" + oldSbh + "'";
				List<Object> csfjList = missionBussiness.exHql(hqlSbh);
				int csfjListSize = csfjList.size();
				if(csfjListSize > 0){
					for(int i = 0; i < csfjListSize; i++){
						CommonScfjb commonScfjb = (CommonScfjb) csfjList.get(i);
						commonScfjb.setId(null);
						commonScfjb.setSbh(UUID.randomUUID().toString());
						commonScfjb.setFbsbh(uuid);
						commonScfjb.setBuildTime(new Date());
						missionBussiness.addData(commonScfjb);
					}
				}
				
				/**************于oldTaskId相关    自动分配任务****************/
				//查到刚添加进去的 那条任务（mission）对象
//				Mission maxMission = new Mission();
//				String hqlMaxMission = "from Mission m where m.id=(select max(mis.taskId) from Mission mis)";
//				List<Object> maxList = missionBussiness.exHql(hqlMaxMission);
//				if( maxList.size() > 0 ){
//					maxMission = (Mission) maxList.get(0);
//				}
				
				//拿出原来分配的任务 重新自动分配
				String hqlTaskId = "from MissionEmp where mission.taskId = "+oldTaskId;
				List<Object> objList = missionBussiness.exHql(hqlTaskId);
				int objListSize = objList.size();
				if(objListSize > 0){
					for(int i = 0; i < objListSize; i++){
						MissionEmp misEmp = (MissionEmp) objList.get(i);
						misEmp.setId(null);
						misEmp.setMission(newMission);
						misEmp.setBuildTime(new Date());
						misEmp.setReceiveTime(null);
						misEmp.setCompleteTime(null);
						misEmp.setStatus("0");
						misEmp.setCompleteDescribe(null);
						misEmp.setSbh(UUID.randomUUID().toString());
						misEmp.setCompleteFjbs(null);
						missionBussiness.addData(misEmp);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		/*
		 * 添加任务
		 */
		public String add(){
			
			try {
				//验证cookie登陆信息是否为空
				Cookies cookie = new Cookies();
				
			    String empid=cookie.getCookie(request, "employeeId");
			    if(empid==null || empid.equals("")){
			    Employee emp =(Employee)request.getSession().getAttribute("emp");
			    empid=String.valueOf(emp.getId());
			    }
			    if(StringUtil.isnull(empid)){
			    	logger.error("添加任务 cookie中id为空");
			    	return "error";
			    }
			    
			    //判断新增还是修改
			    String misId = "";
			    String content = "";
				if(mission.getTaskId() == null || "".equals(mission.getTaskId())){
					
					// 上面的添加是系统里面的任务列表，下面添加的是如果选择的是项目任务的话那么就给项目表添加任务
					String tmp1= mission.getTmp1();
					String tmp2=mission.getTmp2();
					NewFunction function=new NewFunction();			
					if(tmp1!=null){ // 不为空说明是项目任务
						int projectid= Integer.parseInt(tmp1);
						int parentid=-1;
						if(tmp2!=null && tmp2.trim().length()>0){
							parentid=Integer.parseInt(tmp2);
						}
						// 给项目添加任务
						System.out.println(parentid);
						
						function.setFunctionname(mission.getName());
						function.setParentid(parentid); // 设置父类编号
						function.setFinishtasktype(mission.getIsSingle());//设置状态
						NewProject newproject=(NewProject)missionBussiness.getObj(NewProject.class, projectid);
						function.setNewProject(newproject);
						function.setFunctioninfo(mission.getDescription());
						function.setBegintime(mission.getExpStartTime());
						function.setEndtime(mission.getExpEndTime());
						function.setFstate(0);
						function.setFj("");// 暂时为空
						function.setFlag(0);
						// 添加项目任务
						missionBussiness.addproject(function);
						// 给当前任务分配人员
						String[] emparr=null;
						if(empno.trim().length()>0){
						    emparr=empno.split(",");
							for(int i=0;i<emparr.length;i++){
								NewTask task=new NewTask();
								task.setFunction(function);
								int cyrid=Integer.parseInt(emparr[i]);
								Employee empcyr=(Employee)missionBussiness.getObj(Employee.class, cyrid);
								task.setEmp(empcyr);
								task.setBegintime(function.getBegintime());
								task.setEndtime(function.getEndtime());
								task.setFj("");
								task.setSchedule(0);
								task.setFlag(0);
								missionBussiness.addtask(task);// 给任务分配参与人
							}
						}
						
					}
					
					mission.setBuildTime(new Date());
					Employee  emp = new Employee();
					emp.setId(Integer.valueOf(empid));
					mission.setEmployee(emp);
					mission.setStatus("0");
					mission.setSbh(UUID.randomUUID().toString());
					mission.setTmp2(function.getId().toString());
					
					//添加任务
					Mission mis = (Mission) missionBussiness.addReturn(mission);
					misId = mis.getTaskId().toString();
					content = "发布了一个新任务。";
					//保存附件
					if(request.getSession().getAttribute("abcname")!=null){ 
						String filename=request.getSession().getAttribute("abcname").toString();//下载文件名
						String extname=request.getSession().getAttribute("extName").toString();
						String fileNames=request.getSession().getAttribute("fileNames").toString();//真实文件名
						String sfileNames=new String(fileNames.getBytes("ISO-8859-1"), "UTF-8");
						request.getSession().removeAttribute("abcname"); 
						request.getSession().removeAttribute("fileNames"); 
						request.getSession().removeAttribute("extname");
					    String sbh=filename.split(extname)[0];
						String trueName=sfileNames.split(extname)[0];
						String fjhz=extname.substring(1);
						System.out.println(trueName);
						formbiz.addFJ2(filename,"Function",trueName,fjhz,function.getId().toString(),request);
						System.out.println(filename);
					}

					
				}else{
					logger.info("editmission");
					missionBussiness.updateData(mission);
					formbiz.addFJ(mission.getSbh(), "Mission", request);
					
					// 修改任务，得到项目任务编号
					if(mission.getTmp1()!=null && mission.getTmp2()!=null){
						int prjid=Integer.parseInt(mission.getTmp1());
						int fid=Integer.parseInt(mission.getTmp2());
						NewProject project=(NewProject)missionBussiness.getObj(NewProject.class, prjid);
						NewFunction fun=(NewFunction)missionBussiness.getObj(NewFunction.class, fid);
						fun.setNewProject(project);
						fun.setBegintime(mission.getExpStartTime());
						fun.setEndtime(mission.getExpEndTime());
						fun.setFunctioninfo(mission.getDescription());
						fun.setFunctionname(mission.getName());
						missionBussiness.updateNewFunction(fun);
					}
					
					
					misId = mission.getTaskId().toString();
					content = "修改了一个任务。";
				}
				/*因为任务表标示ID为taskid 所以暂时先不做*/
				//author 阙超强 14015 添加任务同时添加执行记录到executeRecord表
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent(content);
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(misId);
					executerecord.setEntityName("Mission");
					executerecord.setSeenEmpId("");
					
					missionBussiness.addData(executerecord);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
				return "error";
			}
			
			
			return "addsuccess";
		}
		/*
		 * 结束我发布的任务
		 */
		public String end(){
			try {
				String id=request.getParameter("id");
				if(StringUtil.isnull(id)){
					logger.error("end id为空");
					return "error";
				}
				Date bdate = new Date();
				String hql = " update Mission set status = '-1',endTime='"+TimePattern.doTimeDf3(bdate)+"' where id= "+id;
				System.out.println("hql:"+hql);
				if(missionBussiness.exehqlupdate(hql)>0){
					System.out.println("更新成功");
					response.getWriter().print(0);
				}else{
					logger.error("end 更新出错");
					response.getWriter().print(1);
				}
				
			} catch (Exception e) {
				logger.error(e);
			}
			return null;
		}
		/**
		 * 分配任务(关联员工和任务)
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public String savehandout(){
			
			//获取到所有员工的id字符串 前台拼凑的字符串
			 List emplist = new ArrayList();
			 String alluserids=request.getParameter("users");
			 String taskid = request.getParameter("id");
			 if(taskid ==null || taskid ==""){
				logger.error("任务id为空");
				return "error";
			 }
			 Mission  m = new Mission(Integer.valueOf(taskid));
			 String newalluserids="";
			 String newacustomers="";
			 String[] allemps=null;
			 String[] allcustomer=null;
			 if(alluserids!=null){
				 newalluserids=alluserids.substring(1, alluserids.length()-1); 
				 newalluserids= newalluserids.replace("||", ",");
				 allemps= newalluserids.split(",");
				 Date dd = new Date();
				 Set set = new HashSet();
				//获取添加员工接收对象id 过滤重复的
				for (int i = 0; i < allemps.length; i++) {
					set.add(allemps[i]);
				}
				//查询此已经接受过改任务的员工
				List list = missionBussiness.exHql(" from MissionEmp where mission.taskId = "+taskid);
				//过滤掉已经发下过任务的员工id
				if(list != null && list.size()>0){
					for (Iterator it = list.iterator(); it
							.hasNext();) {
						MissionEmp me = (MissionEmp) it.next();
						me.getEmployee().getId();
						if(set.contains(""+me.getEmployee().getId())){
							set.remove(""+me.getEmployee().getId());
						}
					}
				}
				//关联任务和员工
				for (Iterator it = set.iterator(); it.hasNext();) {
					String str = (String) it.next();
					MissionEmp  me=new MissionEmp();
					System.out.println("需要匹配的员工ID:"+str);
					int id = Integer.valueOf(str);
					Employee e = new Employee(id);
					List emlist = missionBussiness.exHql(" from Employee where id = "+id);
					e = (Employee)emlist.get(0);
					emplist.add(e);
					
					me.setMission(m);
					//接收人类型
					me.setEmployee(e);
					me.setSbh(UUID.randomUUID().toString());//设置唯一标识
					me.setStatus("0");//设置初始状态
					me.setBuildTime(dd);//设置生成时间
					try {
						missionBussiness.addData(me);
					} catch (Exception e1) {
						e1.printStackTrace();
						logger.error(e1);
						return "error";
					}
				}
				//邮件接口调用
//				for (Iterator it = emplist.iterator(); it.hasNext();) {
//					Employee emp = (Employee) it.next();
//					if(StringUtil.isnull(emp.getEmail())){
//					//MessageremindBiz
//					String mark = "KHGZSB";//任务下发接口配置字符串
//					String hql = "from Messageremind where mark = '"+mark+"'";
//					
//					List mblist = missionBussiness.exHql(hql);
//					Messageremind mm = (Messageremind)mblist.get(0);
//					if(null != mm && null !=mm.getIsEmailRemind()&& (mm.getIsEmailRemind() == "yj" || mm.getIsEmailRemind().equals("yj")))
//					{
//
//					//组合路劲
//								String uri = request.getContextPath();
//								
//								String object = request.getRequestURL().substring(0, request.getRequestURL().indexOf(uri));
//								
//								String url = object+"/"+uri;
//								String urls=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
//								//要发送的内容
//								String msg  = "客户<br/><A href= "+urls+">"+urls+"</A>+你有新的任务请去接收!";
//						        Email email = new Email();
//								
//					            //接收邮件者邮件地址
//						        String callcenter=emp.getEmail().toString();
//
//					            String title = "福奥内部OA系统任务下发";
//						             
//								email.sendEmail(callcenter, title, msg);
//						}
//					}
//				}
			 }
			return "addsuccess";
		}
		
		/*
		 * 删除消息信息对象
		 */
		public String del(){
			try {
				boolean flag=missionBussiness.delmission(ids);
				if(flag){
					//author 阙超强 14015 添加任务同时添加执行记录到executeRecord表
					//拿到登陆员工用户
					Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
					//添加记录到动态记录表
					if(null != loginEmp){
						Executerecord executerecord = new Executerecord();
						executerecord.setEmployee(loginEmp);
						executerecord.setContent("删除了一些任务。");
						executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
						executerecord.setEntityId(StringUtil.arrayToString(ids));
						executerecord.setEntityName("Mission");
						executerecord.setSeenEmpId("");
						
						missionBussiness.addData(executerecord);
					}
					
					response.getWriter().print(0);
				}
				else{
					response.getWriter().print(1);
				}
				
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
		 * 更改消息信息对象
		 */
		public String update(){
			try {
				String MissionId=request.getParameter("MissionId");//消息主键编号
				missionBussiness.updateData(mission);
				//author 阙超强 14015 添加任务同时添加执行记录到executeRecord表
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个任务。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(mission.getTaskId().toString());
					executerecord.setEntityName("Mission");
					executerecord.setSeenEmpId("");
					
					missionBussiness.addData(executerecord);
				}
				
				return this.getpage();
			} catch (Exception e) {
				return "sess"; 
			}
		}
		
		/*
		 * 根据条件进行筛选查询消息信息
		 */
		public String getpage(){
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String MissionId=request.getParameter("MissionId");//消息主键编号
			String type=request.getParameter("type");//消息类型，租用托管，百共等等
			String type2=request.getParameter("type2");//消息所属类型，意向，正式
			String name=request.getParameter("name");//消息名称
			String company=request.getParameter("company");//消息公司
			String timeb=request.getParameter("timeb");//消息就建立开始时间
			String timee=request.getParameter("timee");//消息就建立开始时间
			String hql="from Mission as tb where 1=1 and delfalg!='1'";
			if(MissionId!=null &&!"".equals(MissionId)){
				hql+=( " and tb.MissionId ="+ MissionId);
			}
			if(type!=null && !"".equals(type)){
				hql+=" and tb.MissionType like '"+type+"'";
			}
			if(type2!=null && !"".equals(type2)){
				hql+=" and tb.MissionType2 like '%"+type2+"%'";
			}
			if(name!=null && !"".equals(name)){
				hql+=" and tb.MissionName like '%"+name+"%'";
			}
			hql+="order by tb.id desc";
			System.out.println("hql is"+hql);
			Pages pages=missionBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			return "listMission";
		}
		
		/*
		 * 根据所有我发布任务信息
		 */
		public String getmybuild(){
			System.out.println("getmybuild");
			String conditonempid = "";
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String missionid=request.getParameter("missionId");//消息主键编号
			String empid = request.getParameter("empid");
		    HttpSession session = request.getSession();
		    //获得session中的员工
		    Cookies cookie = new Cookies();
		    String eocid=cookie.getCookie(request, "employeeId");
		    Employee emp =(Employee)request.getSession().getAttribute("emp");
		    String sempid = (String)session.getAttribute("misbuildid");//放session中的empid
            empid=String.valueOf(emp.getId());
		    if((eocid==null || eocid.equals(""))||(sempid==null || sempid.equals(""))){
			    eocid=String.valueOf(emp.getId());
			    sempid=String.valueOf(emp.getId());
			    }
		    
		   
		    System.out.println("员工id:"+sempid);
		    logger.error("员工id:"+sempid+"eocid:"+eocid);
		    if(StringUtil.isnull(empid) && StringUtil.isnull(sempid) ){
		    	conditonempid = eocid;
		    }else if(!StringUtil.isnull(empid)){//参数不为空 优先匹配
		    	conditonempid = empid;
		    }else{//其次是session中的参数
		    	conditonempid = ""+sempid;
		    }
		    session.setAttribute("misbuildid", conditonempid);
		    System.out.println("conditonempid"+conditonempid);
			String company=request.getParameter("company");//消息公司
			String timeb=request.getParameter("timeb");//消息就建立开始时间
			String timee=request.getParameter("timee");//消息就建立结束始时间
			if(StringUtil.isnull(conditonempid)){
				logger.error("getmybuild conditonempid is null or ''");
				return "error";
			}
			String hql="from Mission as tb where 1=1 and tb.employee.id = "+conditonempid+" ";
			if(missionid!=null &&!"".equals(missionid)){
				hql+=( " and tb.taskId ="+ missionid);
			}
			
			hql+=" order by tb.id desc";
			System.out.println("hql is"+hql);
			Pages pages=missionBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			return "listmybuildmission";
		}
		/**
		 * 查询所有我接收的任务信息
		 */
		public String getmyreceive(){
			String conditonempid = "";
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String missionid=request.getParameter("missionId");//消息主键编号
			String status = request.getParameter("status");//request中任务状态标识
			
			String empid = request.getParameter("empid");
		    HttpSession session = request.getSession();
		    //获得session中的员工
		    Cookies cookie = new Cookies();
		    String eocid=cookie.getCookie(request, "employeeId");
		    if(StringUtil.isnull(eocid)){
		    	logger.error("getmyreceive 未获取到cookid中员工id");
		    	return "error";
		    }
		    String sempid = (String)session.getAttribute("misbuildid");//放session中的empid
		    String sstatus = (String)request.getSession().getAttribute("missionstatus");//session中任务状态标识
		    System.out.println("员工id:"+sempid);
		    String hql="from MissionEmp as tb where 1=1 " ;
		    if(StringUtil.isnull(empid)&& StringUtil.isnull(sempid)){
		    	conditonempid = eocid;
		    }else if(StringUtil.isnull(sempid)){
		    	conditonempid = empid;
		    }else{
		    	conditonempid = ""+sempid; 
		    }
		    session.setAttribute("misbuildid", conditonempid);
		    hql += " and tb.employee.id = "+conditonempid+" ";
		    System.out.println("status:"+status);
		    System.out.println("sstatus:"+sstatus);
		    if(StringUtil.isnull(status)&& StringUtil.isnull(sstatus)){//都为空
		    	 
		    }else if(StringUtil.isnull(status)){//sstatus不为空
		    	status =  sstatus;
		    	hql += " and tb.status = '"+status+"' ";
		    }else{//status不为空
		    	hql += " and tb.status = '"+status+"' ";
		    }
		    session.setAttribute("missionstatus", status);
		    if(missionid!=null &&!"".equals(missionid)){
				hql+=( " and tb.mission.taskId ="+ missionid);
			}
			hql+=" order by tb.id desc";
			System.out.println("hql is"+hql);
			Pages pages=missionBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 50, null);
			request.setAttribute("pages", pages);
			
			/**
			 * @author 阙超强 14015 2011-12-18 21:18:40
			 * 更改session中的显示在登录页面的任务安排Start***********************/
			
			String hqlNotice = "from MissionEmp where status = 0 and employee.id = "+conditonempid+" order by buildTime desc";
			Pages pagesMission = missionBussiness.exHqlPages(hqlNotice, 1, 5, null);
			ServletActionContext.getContext().getSession().remove("pagesMission");
			ServletActionContext.getContext().getSession().put("pagesMission", pagesMission);
			
			/**************************更改session中的显示在登录页面的任务安排End***********************/
			
			/**
			 * @author 阙超强 14015 2011-12-18 21:22:53
			 * 更改session中的显示在登录页面的今日任务Start*************************/
			
			Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
		    calendar.add(Calendar.DATE, -1);    //得到前一天
		    String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
		    //员工自定义明日任务计划
		    //List<Scheduleplan> planlist = groupSystemBussiness.getObject("Scheduleplan", " and endtime like '%"+yestedayDate+"%' and state = 1 and employee.id = "+conditonempid);
		    String hqlPlan = "From Scheduleplan as tb where tb.endtime like '%"+yestedayDate+"%' and tb.state = 1 and tb.employee.id = " + conditonempid;
		    Pages planlist = missionBussiness.exHqlPages(hqlPlan, 1, 5, null);
		    //公司安排任务
		    List<Mission> missionlist = groupSystemBussiness.getObject("Mission", " and date(exp_end_time)>= curdate() and taskId in (select mission.taskId from MissionEmp where status = '1' and employee.id = "+conditonempid+")");
		    if(missionlist.size() > 5){
		    	missionlist = missionlist.subList(0, 5);
		    }
		    
		    ServletActionContext.getContext().getSession().remove("pagesPlan");
		    ServletActionContext.getContext().getSession().remove("missionlist");
		    
		    ServletActionContext.getContext().getSession().put("pagesPlan", planlist);
		    ServletActionContext.getContext().getSession().put("missionlist", missionlist);
		    /**   更改session中的显示在登录页面的今日任务End*************************/
		    
		    
			return "listmyrecemission";
		}
		
		
		/*
		 * 获得员工分配出去的任务列表
		 * 
		 */
		public String getmyhandout(){
			try {
				System.out.println("**********************");
				String taskid=request.getParameter("taskid");//获得任务ID
//				String empid=request.getParameter("taskid");//获得员工ID
				String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
				String staskid = (String)request.getSession().getAttribute("taskid");
				
				if(StringUtil.isnull(taskid) && StringUtil.isnull(staskid)){
					logger.error("getmyhandout ：任务id为空");
					return "error";
				}else if(StringUtil.isnull(taskid)){
					taskid = staskid;
				}
				System.out.println("taskid:"+taskid);
				request.getSession().setAttribute("taskid", taskid);
				String hql = " from MissionEmp where mission.taskId = "+taskid+"  order by id desc";
				System.out.println(hql);
				Pages pages = missionBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 50, null);
				request.setAttribute("pages", pages);
				return "myhandout";
			} catch (Exception e) {
				logger.error(e);
				return "listmyrecemission";
			}
		}
		/*
		 * 任务接收
		 */
		public String receive(){
			try {
				String id=request.getParameter("id");
				String status=request.getParameter("status");
				if(StringUtil.isnull(id)){
					logger.error("updatestatus id为空");
					return "error";
				}
				if(!StringUtil.isNumeric(status)){
					logger.error("updatestatus status不是数字");
					return "error";
				}
				Date bdate = new Date();
				String hql = " update MissionEmp set status = '"+status+"',receiveTime='"+TimePattern.doTimeDf3(bdate)+"' where id= "+id;
				System.out.println("hql:"+hql);
				if(missionBussiness.exehqlupdate(hql)>0){
					System.out.println("更新成功");
					/*因为任务表标示ID为taskid 所以暂时先不做*/
					//author 阙超强 14015 添加任务同时添加执行记录到executeRecord表
					//拿到登陆员工用户
					Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
					//添加记录到动态记录表
					if(loginEmp != null){
						Executerecord executerecord = new Executerecord();
						executerecord.setEmployee(loginEmp);
						executerecord.setContent("接收了一个任务。");
						executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
						executerecord.setEntityId(id);
						executerecord.setEntityName("MissionEmp");
						executerecord.setSeenEmpId("");
						
						missionBussiness.addData(executerecord);
					}
					
					response.getWriter().print(0);
				}else{
					logger.error("updatestatus 更新出错");
					response.getWriter().print(1);
				}
				
			} catch (Exception e) {
				logger.error(e);
			}
			return null;
		}
		/*
		 * 任务完成
		 */
		public String complete(){
			try {
				String id=request.getParameter("meid");
				String status=request.getParameter("mestatus");
				String describe = request.getParameter("describe");
				if(StringUtil.isnull(id)){
					logger.error("updatestatus id为空");
					return "error";
				}
				if(!StringUtil.isNumeric(status)){
					logger.error("updatestatus status不是数字");
					return "error";
				}
				System.out.println(describe);
				if(!StringUtil.isnull(describe)){
//					String describe2 = new String(describe.getBytes("ISO-8859-1"),"gbk");
//					String describe3 = new String(describe.getBytes("UTF-8"),"gbk");
//					String describe4 = new String(describe.getBytes("utf8"),"gbk");
//					String describe5 = new String(describe.getBytes("utf-8"),"gbk");
//					String describe6 = new String(describe.getBytes("ISO-8859-1"),"GBK");
//					String describe7 = new String(describe.getBytes("UTF-8"),"GBK");
//					String describe8 = new String(describe.getBytes("utf8"),"GBK");
//					String describe9 = new String(describe.getBytes("utf-8"),"GBK");
//					String describe10 = new String(describe.getBytes("GBK"),"UTF-8");
//					String describe11 = new String(describe.getBytes("GBK"),"utf-8");
//					System.out.println(describe2);
//					System.out.println(describe3);
//					System.out.println(describe4);
//					System.out.println(describe5);
//					System.out.println(describe6);
//					System.out.println(describe7);
//					System.out.println(describe8);
//					System.out.println(describe9);
//					System.out.println(describe10);
//					System.out.println(describe11);
//					String dd1 = StringUtil.decode(describe);
//					System.out.println(dd1);
				}
				System.out.println(describe);
				Date bdate = new Date();
				List list  = missionBussiness.getObjectList("MissionEmp", " and id="+id);
				MissionEmp me = (MissionEmp)list.get(0);
				//String hql = " update MissionEmp set status = '"+status+"',completeTime='"+TimePattern.doTimeDf3(bdate)+"',completeDescribe='"+describe+"' where id= "+id;
				me.setStatus(status);
				me.setCompleteTime(new Date());
				me.setCompleteDescribe(describe);
				me.setCompleteFjbs(UUID.randomUUID().toString());
				
//				System.out.println("hql:"+hql);
				if(missionBussiness.addData(me)){
					System.out.println("更新成功");
					formbiz.addFJ(me.getCompleteFjbs(), "MissionEmp", request);
					//response.getWriter().print(0);
					/*因为任务表标示ID为taskid 所以暂时先不做*/
					//author 阙超强 14015 添加任务同时添加执行记录到executeRecord表
					//拿到登陆员工用户
					Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
					//添加记录到动态记录表
					if(loginEmp != null){
						Executerecord executerecord = new Executerecord();
						executerecord.setEmployee(loginEmp);
						executerecord.setContent("完成了一个任务。");
						executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
						executerecord.setEntityId(id);
						executerecord.setEntityName("MissionEmp");
						executerecord.setSeenEmpId("");
						
						missionBussiness.addData(executerecord);
					}
					return "completesucss";
				}else{
					logger.error("updatestatus 更新出错");
					//response.getWriter().print(1);
					return "error";
				}
				
			} catch (Exception e) {
				logger.error(e);
			}
			return "error";
		}
		/*
		 * 获取单个任务对象以及附件
		 */
		public String get(){
			try {
				String id=request.getParameter("id");
				if(StringUtil.isnull(id)){
					logger.error("id为空");
					return "error";
				}
				//获得任务对象
				Mission data=missionBussiness.getMissiondata(id);
				// 绑定所有项目
				Employee employee =(Employee) this.request.getSession().getAttribute("emp");
				List prjlist=missionBussiness.projectlist(employee);
				// 绑定所有参与人员
				// 根据项目编号得到这个项目下面的所有参与人员，并在前台显示的时候默认勾选中
				if(data.getTmp1()!=null){
					int pid=Integer.parseInt(data.getTmp1());
					List cyrlist= missionBussiness.functionByPid(pid);
					List emplist=new ArrayList();
					for(int i=0;i<cyrlist.size();i++){
						NewParticipator np = (NewParticipator)cyrlist.get(i);
						emplist.add(np.getEmployee());
					}
					// 根据项目编号得到这个项目下面的所有任务,注意任务到了100%的就不用分配了
					List funlist=missionBussiness.funByPid(pid);
					request.setAttribute("funlist",funlist);
					request.setAttribute("emplist", emplist);
				}
				
				request.setAttribute("prjlist", prjlist);
				request.setAttribute("data", data);
				//获得任务对象附件列表
				if(data != null){
				List fjlist = formbiz.getForm("CommonScfjb", " and fbsbh='"+data.getSbh()+"'");
				request.setAttribute("fjlb", fjlist);
				}else{
					logger.error("任务id不存在");
				}
				//获得任务类别list
				String hql="from Missiontype where superid in(1,-1)";
				List meslist=missiontypeBussiness.exHql(hql);
				request.setAttribute("missiontypes", meslist);
				
				return "add";
			} catch (Exception e) {
				logger.error(e);
				return "error";
			}
		}
		/*
		 * 获取单个任务对象以及附件
		 */
		public String logdetail(){
			try {
				String id=request.getParameter("id");
				if(StringUtil.isnull(id)){
					logger.error("id为空");
					return "error";
				}
				//获得任务对象
				Mission data=missionBussiness.getMissiondata(id);
				request.setAttribute("data", data);
				//获得任务对象附件列表
				if(data != null){
					List fjlist = formbiz.getForm("CommonScfjb", " and fbsbh='"+data.getSbh()+"'");
					request.setAttribute("fjlb", fjlist);
				}else{
					logger.error("任务id不存在");
				}
				//获得任务类别list
				return "logdetail";
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
				return "error";
			}
		}
		/*
		 * 获取对应任务类型的的所有任务,参数为类别id
		 */
		public String gettypeparam(){
			try {
				String id=request.getParameter("type");
				String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
				String hql="";
				if(!StringUtil.isnull(id)){
					 if(StringUtil.isNumeric(id)){
						 hql="from Mission where 1=1 and missiontype.id="+id;
					 }else{
						 logger.error("getall 任务类型id不是数字");
						 return "error";
					 }
				}else{
					hql = " from Mission where 1=1 ";
				}
				hql += " order by id desc";
				Pages pages=missiontypeBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 50, null);
				request.setAttribute("pages", pages);
				return "missionlist";
			} catch (Exception e) {
				logger.error(e);
				return "error";
			}
		}
		/*
		 * 获取单个消息信息对象跳转到下发页面
		 */
		public String handout(){
			try {
				String id=request.getParameter("id");
				Mission data=missionBussiness.getMissiondata(id);
				request.setAttribute("data", data);
				return "handout";
			} catch (Exception e) {
				return "will";
			}
		}
		
		
		
		
		public String addMessByCustomer()
		{
			Customer c = (Customer)request.getSession().getAttribute("customer");
//			System.out.println(mission.getTitleweb()+"   ****   "+mission.getMissioncontent());
//			List<Missiontype> typelist = missionBussiness.getObjectList("Missiontype", " and missiontypeid = 2");
//		
//			Missiontype mess=new Missiontype();
//			mess.setMissiontypeid(2);
//			mission.setMissiontypeBySendertype(mess);
//			mission.setSender(c.getCustomerId()+"");
//			mission.setMissiontypeByMissiontype(typelist.get(0));
//			mission.setDelfalg(0+"");
//			mission.setRepealfalg("0");
//			mission.setDraftfalg("0");
//			mission.setReleasetime(Timestamp.valueOf(str3));
			
			try {
				
				boolean flag = missionBussiness.addData(mission);
				if(flag)
				{
					response.getOutputStream().print("0");
				}
				else
				{
					response.getOutputStream().print("1");
				}
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			return null;
		}
		/**
				 * 获取已读或未读信息
				 * @return
				 */
				public String selmessbyreadflag(){
					Cookies cookie = new Cookies();
					String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
					//标识员工或消息
					String restypeid=request.getParameter("restypeid");
					String readfalg=request.getParameter("readflag");
					if(restypeid!=""&&restypeid!=null)
					{
						String receiverer = "";
						if(restypeid.equals("1"))
						{
							//客户或员工id
							String eocid=cookie.getCookie(request, "employeeId");
							receiverer = eocid;
						}
						if(restypeid.equals("2"))
						{
							Customer c = (Customer)request.getSession().getAttribute("customer");
							receiverer = c.getCustomerId()+"";
						}
						//消息或员工id
						String eocid=cookie.getCookie(request, "employeeId");
						//是否已读
						
		//				if(restypeid!=null && readfalg!=null){
		//					String hql="from Missionreceiver where missiontype.missiontypeid="+restypeid+" and receiverer="+receiverer+" and readfalg="+readfalg+" and delfalg=0 ";
		//					System.out.println("hql : "+hql);
		//					Pages pages=missionBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		//					request.setAttribute("pages", pages);
		//					request.setAttribute("mark", readfalg);
		//					if(restypeid.equals("2"))
		//					{
		//						if(list.size()>0)
		//						{
		//							String missionids = "";
		//							for(int i=0;i<list.size();i++)
		//							{
		//								missionids += list.get(i).getMission().getMissionid()+",";
		//							}
		//							List<Mission> mlist = missionBussiness.getObjectList("Mission", " and missionid in ("+missionids.substring(0,missionids.length()-1)+")");
		//							String empids = "";
		//							for(int i=0;i<mlist.size();i++)
		//							{
		//								empids += mlist.get(i).getSender() + ",";
		//							}
		//							List<Employee> emplist = missionBussiness.getObjectList("Employee", " and id in ("+empids.substring(0,empids.length()-1)+")");
		//							System.out.println("size : "+emplist.size());
		//							request.setAttribute("emplist", emplist);
		//						}
		//					}
		//				}
					}
					
					if(restypeid.equals("2"))
					{
						if(readfalg.equals("0"))
						{
							return "customermissionshow";
						}
						else
						{
							return "receivemissionshow";
						}
						
					}
					return "messshow";
				}
		/**
		 * 删除信息
		 * @return
		 */
		public String delmesflag()
		{
			System.out.println("delAction");
			boolean flag=missionBussiness.delmission(ids);
			try
			{
				if(flag){
					
					response.getWriter().print("0");
				}
				else
				{
					response.getWriter().print("1");
				}
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
			return null;
		}
		
		/**
		 * 阅读消息
		 * @return
		 */
		public String readMessByCustomer()
		{
			String rid = request.getParameter("rid");
			//List<Missionreceiver> receiver = missionBussiness.getObjectList("Missionreceiver", " and receiverid = "+rid);
//			if(receiver.size()>0)
//			{
//				Mission mission = receiver.get(0).getMission();
//				String sendname = "";
//				if(mission.getMissiontypeBySendertype().getMissiontypeid() == 1)
//				{
//					List<Employee> emplist = missionBussiness.getObjectList("Employee"," and id = "+mission.getSender());
//					if(emplist.size()>0)
//					{
//						sendname = emplist.get(0).getName();
//					}
//				}
//				if(mission.getMissiontypeBySendertype().getMissiontypeid() ==2)
//				{
//					List<Customer> clist = missionBussiness.getObjectList("Customer"," and customerId = "+mission.getSender());
//					if(clist.size()>0)
//					{
//						sendname = clist.get(0).getCustomerName();
//					}
//				}
//				request.setAttribute("missioncontent", mission);
//				request.setAttribute("from", sendname);
//				System.out.println("rid : "+receiver.get(0).getReceiverid());
//				request.setAttribute("rid", receiver.get(0).getReceiverid());
//				request.setAttribute("readflag", receiver.get(0).getReadfalg());
//			}
			return "readmissionBycustomer";
		}
		public String messend(){
			System.out.println(1111);
			Cookies cookie = new Cookies();
			//获取登录用户
			String eocid=cookie.getCookie(request, "employeeId");
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String hql="from Mission where sender="+eocid+" and missiontypeBySendertype.missiontypeid=1 and repealfalg=0 and delfalg=0 and draftfalg=0";
			System.out.println("hql::::::"+hql);
			Pages pages=missionBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			return "sendshow";
		}
		
		/**
		 * 删除发送者信息
		 * @return
		 */
		public String delsendmes()
		{
			System.out.println("delAction");
			boolean flag=missionBussiness.delsendmes(ids);
			try
			{
				if(flag){
					response.getWriter().print("0");
				}
				else
				{
					response.getWriter().print("1");
				}
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
			return null;
		}
		
		/**
		 * 获得消息类型
		 */
		public String build(){
			System.out.println("4334443");
			// 得到执行人 empid
 			String selid=request.getParameter("selid")!=null?request.getParameter("selid"):"";
			String selid1="";
			try {
				selid1 = request.getParameter("selid1")!=null?new String(request.getParameter("selid1").getBytes("ISO-8859-1"),"UTF-8"):"";
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(!selid.equals("") && selid!=null ){
				
				request.setAttribute("selid1", selid1);
				request.setAttribute("selid", selid);
			}
			NewFunction function=new NewFunction();
			Employee emp=new Employee();
			String empidstr=request.getParameter("empid");
			Integer empid=0;
			Integer fid=0;
			if(empidstr!=null){
				empid=Integer.parseInt(empidstr);
				fid=Integer.parseInt(request.getParameter("fid"));
			}
			if(empid!=0 && fid!=0){
				function=(NewFunction)missionBussiness.getObj(NewFunction.class, fid);
				emp=(Employee)missionBussiness.getObj(Employee.class, empid);
			}
			List<Employee> ep=null;
			List meslist=missionBussiness.alltype();
			if(!selid.equals("")&&selid!=null)
			{
				String hql="from NewParticipator where newProject.id="+Integer.parseInt(selid)+" and isagree=2";
				List na1=missionBussiness.exHql(hql);
				
				ep=new ArrayList<Employee>();
				for(int i=0;i<na1.size();i++)
				{
					ep.add(i, ((NewParticipator) na1.get(i)).getEmployee());
				}
				
			}
			else
			{	List emplist= missionBussiness.allEmp();
			ep=new ArrayList<Employee>();
				for(int i=0;i<emplist.size();i++)
				{
					ep.add(i, (Employee) emplist.get(i));
				}
			}
			// 得到所有员工列表
			
			// 保存执行人对象与任务对象
			request.setAttribute("function", function);
			request.setAttribute("emp", emp);
			
			request.setAttribute("missiontypes", meslist);
			request.setAttribute("emplist", ep);
			
			return "add";
		}
		
		/**
		 * 根据superid查找相应的数据
		 */
		public String selbysuperid(){
			response.setContentType("text/html;charset=GBK");
			String superid=request.getParameter("surperid");
			System.out.println("superid:::"+superid);
			//拼接select
			String str="";
			if(superid!=null){
				String hql="from Missiontype where superid="+superid+" and delflag=0";
				List<Object> meslist=missiontypeBussiness.exHql(hql);
				for(Object mes:meslist){
//					str+="<option value='"+mes.getMissiontypeid()+"' >"+mes.getType()+"</option>";
				}
				try{
					if(str!="")
						response.getWriter().print(str);
					else
						response.getWriter().print(1);
				}catch(Exception ex){
					ex.printStackTrace();
				}
			}
			return null;
		}
		
		/********
		 * 选择项目，只有是项目负责人才能发布自己下面负责的项目，并且这个项目是正在进行中的
		 */
		public String selectprj(){
			// 得到当前登陆人
			Employee employee =(Employee) this.request.getSession().getAttribute("emp");
			List prjlist=missionBussiness.projectlist(employee);
			System.out.println(prjlist.size());
			String str="";
			if(prjlist.size()>0){
				for(int i=0;i<prjlist.size();i++){
					NewProject project=(NewProject)prjlist.get(i);
					str+="<option value='"+project.getId()+"'>"+project.getProjectname()+"</option>";
				}
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
		
		/********
		 * 根据项目编号得到这个参与人的
		 */
		public String cyrbyid(){
			int pid=Integer.parseInt(request.getParameter("prjid"));
			List cyrlist= missionBussiness.functionByPid(pid);
			String str="<table align='left' border='1' style='cursor:pointer; border: solid 1px;border-color: #0A0A0A;' width='100%'>";
			//<input type="checkbox" id="${emp.id }" name="cyr" value="${emp.name }" onclick="getempno()"  />${emp.name } 
			
			for(int i=0;i<cyrlist.size();i++){
				NewParticipator np = (NewParticipator)cyrlist.get(i);
				Employee emp=np.getEmployee();
				str+="<tr><td><input type='checkbox' name='cyr' onclick='getempno()' value='"+emp.getName()+"' id='"+emp.getId()+"' /> "+emp.getName()+" </td></tr>";
			}
			str+="</table>";
			try {
				response.setCharacterEncoding("UTF-8");
				PrintWriter out=response.getWriter();
				out.println(str);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return null;
		}
		
		/********
		 * 根据项目编号得到所有任务
		 * @return
		 */
		public String funbyid(){
			int pid=Integer.parseInt(request.getParameter("prjid"));
			List funlist=missionBussiness.funByPid(pid);
			String str="";
			if(funlist.size()<=0){
				str+="<option value='-1'>暂无任务</option>";
			}
			for(int i=0;i<funlist.size();i++){
				NewFunction function=(NewFunction)funlist.get(i);
				str+="<option value='"+function.getId()+"'>"+function.getFunctionname()+"</option>";
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
		
		/**
		 * 清楚squild缓存Action
		 * @param name server urllist
		 * @return 
		 * @throws Exception 
		 */
		/**
		 * 后天查询节点
		 */
		public String selectJieDian()
		{
			String hql="from cdnPanelPoint where del=0";
			cdnPanelPoint c=new cdnPanelPoint();
			List<Object> cdnpp1=missionBussiness.exHql(hql);//查询服务器的节点
			List<cdnPanelPoint> cdnpp=new ArrayList<cdnPanelPoint>();
			for(int i=0;i<cdnpp1.size();i++)//便利节点放入实体的list中
			{
				c=(cdnPanelPoint) cdnpp1.get(i);
				cdnpp.add(i, c);
			}
			String hql1="from Updatecache where 1=1 order by id desc";
			List<Object> objest1=missionBussiness.exHql(hql1);//查询记录
			List<Updatecache> updatecache=new ArrayList<Updatecache>();
			Updatecache uc=new Updatecache();
			for(int i=0;i<objest1.size();i++)//便利放入实体的list中
			{
				if(i==10)//获取前10条记录  超过10条结束便利
					break;
				uc=(Updatecache) objest1.get(i);
				updatecache.add(i, uc);
			}
			request.setAttribute("updatecache", updatecache);
			request.setAttribute("cdnpp", cdnpp);
			return "addCache111";
		}
		/**
		 * 前端跳转到刷新页面
		 * @return
		 */
		public String selectJieDian1()
		{
			Object ob=request.getSession().getAttribute("customer");//获取登录客户
			Customer customer=null;
			if(ob!=null)
				customer=(Customer)ob;
			else{
				///不是客户登录，没有客户信息
			}
			
			String hql1="from Updatecache where customer.customerId="+customer.getCustomerId()+" order by id desc";
			List<Object> objest1=missionBussiness.exHql(hql1);//查询客户的操作记录
			List<Updatecache> updatecache=new ArrayList<Updatecache>();
			Updatecache uc=new Updatecache();
			for(int i=0;i<objest1.size();i++)//便利记录放入list里面
			{
				if(i==10)//显示前10条数据  超过10条结束便利
					break;
				uc=(Updatecache) objest1.get(i);
				updatecache.add(i, uc);
			}
			String hql2="from CDNsaleOrder where customer.customerId="+customer.getCustomerId()+" and delFlag='0' order by id desc";
			List<Object> objest2=missionBussiness.exHql(hql2);//查询客户的域名
			List<CDNsaleOrder> cdnSaleOrder=new ArrayList<CDNsaleOrder>();
			CDNsaleOrder cso=new CDNsaleOrder();
			for(int i=0;i<objest2.size();i++)//便利放入list
			{
				cso=(CDNsaleOrder) objest2.get(i);
				cdnSaleOrder.add(i, cso);
			}
			request.setAttribute("cdnSaleOrder", cdnSaleOrder);
			request.setAttribute("updatecache", updatecache);
			return "addCacheQianDuan";
		}
		/**
		 * 前端的刷新操作
		 * @throws Exception
		 */
	public void clearCache2() throws Exception{
			
			logger.info("clearCache2");
			String urllist =URLDecoder.decode(request.getParameter("urllist"), "UTF-8");
			
			String type=request.getParameter("type");
			String name1=request.getParameter("name");
			
			 String name=name1.replace("http://",""); 
			Object ob=request.getSession().getAttribute("customer");//获取登录客户
			Customer customer=null;
			if(ob!=null)
				customer=(Customer)ob;
			else{
				///不是客户登录，没有客户信息
			}
			logger.info("clearCache3");
			PurgeManager pm=PurgeManager.getInstance();
			String  mark="0";
			String hql="from cdnRealmNameIP where  cuRealmName='"+name+"' and customerID.customerId="+customer.getCustomerId()+" and del=0";
			List<Object> object=missionBussiness.exHql(hql);//查询该域名有那些服务器和端口
			cdnRealmNameIP crni=new cdnRealmNameIP();
			DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String mark1="";
			logger.info("clearCache4");
			for(int i=0;i<object.size();i++)
			{
				crni=(cdnRealmNameIP) object.get(i);
				if(type.equals("1"))//刷新文件
				{
					logger.info("clearCache5");
					mark=pm.doOneSquid1(crni.getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=refresh***ParamType=files***domain="+name1+"***Parameter="+urllist+"***", crni.getCdnPanelPointID().getDuankou())+"";
					mark1="刷新文件";
					//进行操作
					
				}
				if(type.equals("2"))//刷新目录
				{
					
					mark=pm.doOneSquid1(crni.getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=refresh***ParamType=dir***domain="+name+"***Parameter="+urllist+"***", crni.getCdnPanelPointID().getDuankou())+"";
					mark1="刷新目录";
				}
				if(type.equals("3"))//删除文件
				{
					mark=pm.doOneSquid1(crni.getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=delete***ParamType=files***domain="+name+"***Parameter="+urllist+"***", crni.getCdnPanelPointID().getDuankou())+"";
					mark1="删除文件";
				}
				if(type.equals("4"))//删除目录
				{
					mark=pm.doOneSquid1(crni.getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=delete***ParamType=dir***domain="+name+"***Parameter="+urllist+"***", crni.getCdnPanelPointID().getDuankou())+"";
					mark1="删除目录";
					
				}
				if(type.equals("5"))//增加刷新文件
				{
					mark=pm.doOneSquid1(crni.getCdnPanelPointID().getPanelPointIp(), "LogBat***Method=add***ParamType=files***domain="+name+"***Parameter="+urllist+"***",  crni.getCdnPanelPointID().getDuankou())+"";
					mark1="新增刷新文件";
				}
				logger.info("clearCache6");
				Updatecache upecache = new Updatecache();
				upecache.setContent(urllist);
				
				upecache.setResult(mark);
				
				upecache.setDomain(name);
				
				upecache.setCustomer(customer);
				
				upecache.setTime(df3.format(new Date()));
				upecache.setTmp(mark1);
				logger.info("clearCache7= "+mark+" "+name+" "+customer.getCustomerId()+" "+mark1);
				logger.info("clearCache8= "+crni.getCdnPanelPointID().getCdnAreaID().getProvince());
				logger.info("clearCache9= "+crni.getCdnPanelPointID().getCdnTypeID().getTypeName());
				upecache.setTmp1(crni.getCdnPanelPointID().getCdnAreaID().getProvince()+"、"+crni.getCdnPanelPointID().getCdnTypeID().getTypeName());
				logger.info("clearCache10");
				missiontypeBussiness.addData(upecache);//添加操作记录
				logger.info("clearCache11");
			}
			
			
			
		
//			public static int FileNotFound = 404;//文件没有找到
//			public static int Error_Reg = 1;//错误的正则表达式
//			public static int Site_Conf_Error = 2;//站点配置错误
//			public static int DomainNotFount = 3;//域名未找打
//			public static int InnerServerError  = 500;//内部错误 服务器处理有异常
//			public static int NoPermitAccess= 403;//不允许访问
//			public static int BadRequest= 400;//错误的请求，请检查的的域名是否合法
//			public static int doOk = 0;//处理成功
//			public static int BlankMethod = 999;//空方法体 暂时启用
			
			
			logger.info("clearCache mark="+mark);
			response.setCharacterEncoding("utf-8");
			if(mark.equals("0"))
			{
				response.getWriter().print("0");//操作成功
			}else if(mark.equals("404"))//不存在缓存或者缓存已刷新
			{
				response.getWriter().print("0");//网络错误
			}else if(mark.equals("1"))
			{
				response.getWriter().print("1");//网络错误
			}else if(mark.equals("2"))
			{
				response.getWriter().print("1");//网络错误
			}else if(mark.equals("3"))
			{
				response.getWriter().print("1");//网络错误
			}else if(mark.equals("500"))
			{
				response.getWriter().print("1");//网络错误
			}
			else if(mark.equals("403"))
			{
				response.getWriter().print("1");//网络错误
			}else if(mark.equals("400"))
			{
				response.getWriter().print("1");//网络错误
			}else if(mark.equals("999"))
			{
				response.getWriter().print("1");//网络错误
			}else if(mark.equals("-1"))
			{
				response.getWriter().print("1");//网络错误
			}
			else if(mark.equals("-2"))
			{
				response.getWriter().print("2");//参数错误
			}
			else if(mark.equals("-3"))
			{
				response.getWriter().print("3");//服务未开启
			}
			else if(mark.equals("-4"))
			{
				response.getWriter().print("4");//创建读写出错（服务出错）
			}else {
				response.getWriter().print("5");//服务器错错(服务出错）
			}
			
		    				
			
		}
		/** 后端的刷新操作
		 * 细节注释和clearCache2一样  参考clearCache2 进行解读
		 * @throws Exception
		 */
		
		public void clearCache1() throws Exception{
			
		//	String sitename =URLDecoder.decode(request.getParameter("name"), "UTF-8");//
			String servername = request.getParameter("server");
			String urllist =URLDecoder.decode(request.getParameter("urllist"), "UTF-8");
			String duankou=request.getParameter("duankou");
			String type=request.getParameter("type");
			String name=request.getParameter("name");
			String name11=request.getParameter("name");
			
			 String name1=name11.replace("http://",""); 
			String mark1="";
			String hql="from cdnRealmNameIP where cuRealmName='"+name1+"' and cdnPanelPointID.panelPointIp='"+servername+"'";
			List<Object> object=missionBussiness.exHql(hql);
			
			PurgeManager pm=PurgeManager.getInstance();
			String  mark="0";
			
			if(type.equals("1"))
			{
					mark=pm.doOneSquid1(servername, "LogBat***Method=refresh***ParamType=dir***domain="+name+"***Parameter="+urllist+"***", Integer.parseInt(duankou))+"";
					mark1="刷新目录";
			}else 
			if(type.equals("2"))
			{
					mark=pm.doOneSquid1(servername, "LogBat***Method=refresh***ParamType=files***domain="+name+"***Parameter="+urllist+"***", Integer.parseInt(duankou))+"";
					mark1="刷新文件";
			}else 
			if(type.equals("3"))
			{
					mark=pm.doOneSquid1(servername, "LogBat***Method=delete***ParamType=dir***domain="+name+"***Parameter="+urllist+"***", Integer.parseInt(duankou))+"";
					mark1="删除目录";
			}else 
			if(type.equals("4"))
			{
					mark=pm.doOneSquid1(servername, "LogBat***Method=delete***ParamType=files***domain="+name+"***Parameter="+urllist+"***", Integer.parseInt(duankou))+"";
					mark1="删除文件";
			}else 
			if(type.equals("5"))
			{
					mark=pm.doOneSquid1(servername, "LogBat***Method=add***ParamType=files***domain="+name+"***Parameter="+urllist+"***", Integer.parseInt(duankou))+"";
					mark1="新增刷新文件";
			}
			//List list = sb.toString().split("<br/>"); 
			//logger.error(sb.toString());
			Cookies cookie = new Cookies();
			//获取登录用户
			String couid=cookie.getCookie(request, "customerId");
			
			Customer customer = null;
//			
//			if(null != couid && couid !=""){
//				
//				int customerid = Integer.parseInt(125+"");
//				
//				customer = new Customer();
//				
//				customer.setCustomerId(customerid);
//			}
			int customerid = Integer.parseInt(125+"");
			
			customer = new Customer();
			
			customer.setCustomerId(customerid);
			DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Updatecache upecache = new Updatecache();
			
			upecache.setContent(urllist);
			
			upecache.setResult(mark);
			
			upecache.setDomain(name1);
			
			//upecache.setCustomer(customer);
			
			upecache.setTime(df3.format(new Date()));
			upecache.setTmp(mark1);
			cdnRealmNameIP c=new cdnRealmNameIP();
			if(object.size()>0)
			{
			c=(cdnRealmNameIP) object.get(0);
			upecache.setTmp1(c.getCdnPanelPointID().getCdnAreaID().getProvince()+"、"+c.getCdnPanelPointID().getCdnTypeID().getTypeName());
			}
			missiontypeBussiness.addData(upecache);
			
			response.setCharacterEncoding("utf-8");
			if(mark.equals("0"))
			{
				response.getWriter().print("0");
			}
			else if(mark.equals("-1"))
			{
				response.getWriter().print("1");
			}
			else if(mark.equals("-2"))
			{
				response.getWriter().print("2");
			}
			else if(mark.equals("-3"))
			{
				response.getWriter().print("3");
			}
			else if(mark.equals("-4"))
			{
				response.getWriter().print("4");
			}
			
		    				
			
		}
		public String clearCache() throws Exception{
			
			String sitename =URLDecoder.decode(request.getParameter("name"), "UTF-8");//
			String servername = request.getParameter("server");
			String urllist =URLDecoder.decode(request.getParameter("urllist"), "UTF-8");
			logger.error("参数:"+urllist);
			if(StringUtil.isnull(urllist)){
				logger.error("clearCache 参数urllist为空");
				return "error";
			}
			String[] url = urllist.split("\\|"); //用|分割必须转义
			PurgeManager  pm = PurgeManager.getInstance();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < url.length; i++) {
				//logger.error(url[i].trim());
				if(!StringUtil.isnull(url[i].trim())){
					sb.append(pm.purgeSquid(url[i].trim()));
				}
			}
			//List list = sb.toString().split("<br/>"); 
			//logger.error(sb.toString());
			Cookies cookie = new Cookies();
			//获取登录用户
			String couid=cookie.getCookie(request, "customerId");
			
			Customer customer = null;
			
			if(null != couid && couid !=""){
				
				int customerid = Integer.parseInt(couid);
				
				customer = new Customer();
				
				customer.setCustomerId(customerid);
			}
			DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			request.setAttribute("info", sb.toString());
			Updatecache upecache = new Updatecache();
			
			upecache.setContent(urllist);
			
			upecache.setResult(sb.toString());
			
			upecache.setDomain(sitename);
			
			upecache.setCustomer(customer);
			
			upecache.setTime(df3.format(new Date()));
			
			missiontypeBussiness.addData(upecache);
			
			response.setCharacterEncoding("utf-8");
			
		    if(sb.toString().indexOf("200")>0){
		    	
		    	response.getWriter().print(1);
		    	System.out.println("成功");
		    	return null;
		    }else{
		    	response.getWriter().print(0);
		    	System.out.println("失败");
		    	return null;
		    }				
			
		}
		public MissionBussiness getMissionBussiness() {
			return missionBussiness;
		}
		public void setMissionBussiness(MissionBussiness missionBussiness) {
			this.missionBussiness = missionBussiness;
		}
		public MissiontypeBussiness getMissiontypeBussiness() {
			return missiontypeBussiness;
		}
		public void setMissiontypeBussiness(MissiontypeBussiness missiontypeBussiness) {
			this.missiontypeBussiness = missiontypeBussiness;
		}
		public CommonBiz getFormbiz() {
			return formbiz;
		}
		public void setFormbiz(CommonBiz formbiz) {
			this.formbiz = formbiz;
		}
		

}
