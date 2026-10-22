package com.fuao.fajxc.action.newproject;

/*******
 * 审批项目Action
 */
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Hibernate;

import com.fuao.fajxc.dao.basic.EmployeeDao;
import com.fuao.fajxc.dao.newproject.ApprovalProject;
import com.fuao.fajxc.dao.newproject.Project;
import com.fuao.fajxc.dao.project.ProjectDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.Approverecord;
import com.fuao.fajxc.vo.Auditline;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewPrjtresource;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewWatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ActionSupport;

public class ApprovalProjectAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ApprovalProject approvaldao;
	private NewApprove approve;
	private Project projectdao;
	
	public NewApprove getApprove() {
		return approve;
	}
	public void setApprove(NewApprove approve) {
		this.approve = approve;
	}
	public ApprovalProject getApprovaldao() {
		return approvaldao;
	}
	public void setApprovaldao(ApprovalProject approvaldao) {
		this.approvaldao = approvaldao;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public Project getProjectdao() {
		return projectdao;
	}
	public void setProjectdao(Project projectdao) {
		this.projectdao = projectdao;
	}
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	// 待审批项目列表
	public String waitProject(){
		// 得到当前登录人，判断他所得到审批项目。
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		String hql="from NewApprove where appstatus!=-1 ";
		// and approveemp.id="+employee.getId()+" or applypeople.id="+employee.getId();
		List list=approvaldao.execHQL(hql);
		String str="";
		 for(int i=0;i<list.size();i++){
			 NewApprove app=(NewApprove)list.get(i);
			 if(app.getApproveemp().getId().equals(employee.getId())){
				 str+=","+app.getId();
			 }
			 if(app.getApplypeople().getId().equals(employee.getId())){
				 str+=","+app.getId();
			 }
		 }
		 hql+=" and id in(''"+str+") ";
		String pid="";
		try {
			String projectname= URLDecoder.decode(request.getParameter("projectname"),"utf-8");
			String begintime=request.getParameter("begintime");
			String endtime=request.getParameter("endtime");
			if(projectname!=null&&projectname.trim().length()>0){
				// 根据传过来的项目名称模糊查询审批的项目编号
				List prjidList=approvaldao.getProject(projectname,employee);
				for(int i=0;i<prjidList.size();i++){
					pid+=","+prjidList.get(i);
				}
				// 根据项目名称查
				hql+=" and newproject.id in (''"+pid+")";
				request.setAttribute("projectname", projectname);
			}
			if(begintime!=null && begintime.trim().length()>0){
				hql+=" and begintime>='"+begintime+"'";
				request.setAttribute("begintime", begintime);
			}
			if(endtime!=null && endtime.trim().length()>0){
				hql+=" and endtime<='"+endtime+"'";
				request.setAttribute("endtime", endtime);
			}
		} catch (Exception e) {
			
		}
		hql+=" order by id desc";
			
		String dcstr=request.getParameter("dc");
		if(dcstr!=null && dcstr.equals("1")){
			List waitprj= approvaldao.execHQL(hql);
			request.setAttribute("waitprj",waitprj);
			return "dcwait";
		}else{
			Pages pages=approvaldao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
			//查询登录人单次审核的最大额度
			int superid=PublicMissionType.operationtype;//配置中读出是那种类型的单次审批额度（采购内）
			String moneyhql="From Missiontype where name='采购' and superid="+superid;
			List<Missiontype> missionType=approvaldao.execHQL(moneyhql);
			if(missionType.size()>0)
			{
				String typrId="from OperationEmployeematch where type.id="+missionType.get(0).getId()+" and employee.id="+employee.getId()+"";
				List<OperationEmployeematch> opemp=approvaldao.execHQL(typrId);
				if(opemp.size()>0)
				{
				double aa=opemp.get(0).getMoney();
				request.setAttribute("oneMoney", aa);
				}
				
			}
			
			// 查询所有的待审批项目的列表数据
			request.setAttribute("pages", pages);
					
			request.setAttribute("waitprj", pages.getPageList());
			request.setAttribute("employee", employee);// 保存当前登录人
			return "wait";
		}
	}
	//获得项目流程信息
	public String getProcedures(){
		
		String projectid=request.getParameter("projectid");
		int id=Integer.parseInt(projectid.trim());
		String hql="From NewProject where id="+id;
		List list=approvaldao.execHQL(hql);
		NewProject newproject=(NewProject) list.get(0);
		request.setAttribute("newproject", newproject);
		System.out.println(newproject.getProjectname()+"_____________+++++++++");
		request.setAttribute("newproject", newproject);
		String hql1="From NewApprove where pid="+id;
		NewApprove newapp=(NewApprove) approvaldao.execHQL(hql1).get(0);
		request.setAttribute("newapp", newapp);
		String appLD=newapp.getAppLD();		
		int len=appLD.split(",").length;
		System.out.println(appLD);
		request.setAttribute("len",len);
		if(len==1){
			System.out.println(appLD);
			Integer ld= Integer.parseInt(appLD);
			Employee emp=approvaldao.getEmpByEId(ld);
			System.out.println(emp.getName());
			request.setAttribute("appName", emp.getName());
		}
		else if(len==2){
		
		int a=Integer.parseInt(appLD.split(",")[0]);
		int b=Integer.parseInt(appLD.split(",")[1]);	
		
		String appld1=approvaldao.getEmpByEId(a).getName();
		String appld2=approvaldao.getEmpByEId(b).getName();
		System.out.println(appld1);
		System.out.println(appld2);
		request.setAttribute("appld1", appld1);
		request.setAttribute("appld2", appld2);
		}
		
		
		
		
		
		return "procedures";
	}
	
	// 添加审批记录与审批处理
	public String appRecord(){
		int approveid=Integer.parseInt(request.getParameter("approveid"));// 待审批ID
		int status=Integer.parseInt(request.getParameter("status")); // 审批状态
		int num=0;
		String numbumen="";
		String content="";
		try {
			content=URLDecoder.decode(request.getParameter("content"),"utf-8");
			//content= new String(request.getParameter("content").getBytes("ISO-8859-1"),"utf-8");
			
		} catch (Exception e) {
		}
		// 根据审批编号得到审批对象
		NewApprove newapp=(NewApprove) approvaldao.getObjById(NewApprove.class, approveid);
	
		// 根据审批人得到这个审批人的上级
		Employee appemp=newapp.getApproveemp();
		if(status==1){
			String moneystr= request.getParameter("money");
			double money=newapp.getApplypeople().getApprovemoney();//审批金额
			if(moneystr!=null && !moneystr.equals("")){
				money=Double.parseDouble(moneystr); 
			}
			
			int sqrid = Integer.parseInt(request.getParameter("sqrid")); //申请人id
			int pid = Integer.parseInt(request.getParameter("pid")); //项目id
			String ckzid =""; 
			String ckzstr=request.getParameter("ckzid"); //查看者id
			if(ckzstr!=null && !ckzstr.equals("")){
				ckzid=ckzstr;
				//添加查看者
				String[] idstr = ckzid.split(",");
				String string2 = "";
				for(int i=0;i<idstr.length;i++){
					NewWatch w = new NewWatch();
					int eid2=Integer.parseInt(idstr[i]);
					System.out.println(eid2);
					Employee employee = (Employee)approvaldao.getObjById(Employee.class, eid2);
					NewProject newprj=(NewProject)approvaldao.getObjById(NewProject.class,pid);
					w.setEmp(employee);
					w.setProject(newprj);
					approvaldao.addPrjWatcher(w);
				}
			}
			//修改申请人的审批金额,且必须比之前的多
			
			Employee e = approvaldao.getEmpByEId(sqrid);
			System.out.println(e.getApprovemoney());
			if(e.getApprovemoney()==null){
				e.setApprovemoney(money);
			}else if(e.getApprovemoney()!=null && e.getApprovemoney()>money){
				e.setApprovemoney(e.getApprovemoney());
			}else if(e.getApprovemoney()<money){
				e.setApprovemoney(money);
			}else{}
			approvaldao.updateApprovemoney(e);
			
			
			newapp.setAppstatus(1);
		}
		if(status==0){
			newapp.setAppstatus(-1);
		}
		Employee approveemp=null;
		if(status==2){ //　审批状态为２说明他的权限还不够大，那么就把这个审批提交给他的上级去处理
			newapp.setAppstatus(0);
			// 根据人员编号得到部门
			String hql="select e.department from Employee e where e.id="+appemp.getId();
			List deptlist=approvaldao.execHQL(hql);
			// 审批人
			
			 NewWatch watch=new NewWatch();
				
				//参数  岗位员工表对象
				WorkpositionEmployee  empposition =(WorkpositionEmployee) this.request.getSession().getAttribute("empposition");
//				根据岗位得到部门--再得到部门的主管-放到approveemp里
//				empposition.getPositiontype();//1主岗 2分岗3分管4主管
				empposition.getWorkposition().getDepartment().getParentId();//父部门
//				HQL = " select emp    empposition where (type=4 or type = 3) and deptid = partid "
//				该岗位所在部门没有主管岗或者 主管岗没有人担任 则查找分管人员
				if(empposition.getPositiontype()==1||empposition.getPositiontype()==2)
				{
					String tophql="from WorkpositionEmployee where positiontype=4 and workposition.department.id="+empposition.getWorkposition().getDepartment().getId()+"";
					List<WorkpositionEmployee> we=approvaldao.execHQL(tophql);
					if(we.size()>0)//找到他上上一级主管
					{
						approveemp=we.get(0).getEmployee();//获取登录人部门的主管
						
						
						watch.setProject(newapp.getNewproject());
				    	watch.setEmp(approveemp);
					    // 保存对象
					    approvaldao.addcyr(watch);
					}
					else
					{
						//没有主管找分管
						String tophql1="from WorkpositionEmployee where positiontype=3 and workposition.department.id="+empposition.getWorkposition().getDepartment().getId()+"";
						List<WorkpositionEmployee> we1=approvaldao.execHQL(tophql1);
						if(we1.size()>0)//找到他上上一级主管
						{
							approveemp=we1.get(0).getEmployee();//获取登录人部门的主管
							
							watch.setProject(newapp.getNewproject());
					    	watch.setEmp(approveemp);
						    // 保存对象
						    approvaldao.addcyr(watch);
						}
						else{
							//没有分管找上部门的主管、分管
							//主管
							String tophql11="from WorkpositionEmployee where positiontype=4 and workposition.department.id="+empposition.getWorkposition().getDepartment().getParentId()+"";
							List<WorkpositionEmployee> we11=approvaldao.execHQL(tophql11);
							if(we11.size()>0)//找到他上上一级主管
							{
								approveemp=we11.get(0).getEmployee();//获取登录人部门的主管
								
								
								watch.setProject(newapp.getNewproject());
						    	watch.setEmp(approveemp);
							    // 保存对象
							    approvaldao.addcyr(watch);
							}
							else{
								String tophql111="from WorkpositionEmployee where positiontype=3 and workposition.department.id="+empposition.getWorkposition().getDepartment().getParentId()+"";
								List<WorkpositionEmployee> we111=approvaldao.execHQL(tophql111);
								if(we111.size()>0)//找到他上上一级主管
								{
									approveemp=we111.get(0).getEmployee();//获取登录人部门的主管
									
									watch.setProject(newapp.getNewproject());
							    	watch.setEmp(approveemp);
								    // 保存对象
								    approvaldao.addcyr(watch);
								}
								else{
									//没有分管就审核通过
									approveemp=appemp;
									String moneystr= request.getParameter("money");
									double money=newapp.getApplypeople().getApprovemoney();//审批金额
									if(moneystr!=null && !moneystr.equals("")){
										money=Double.parseDouble(moneystr); 
									}
									
									int sqrid = Integer.parseInt(request.getParameter("sqrid")); //申请人id
									int pid = Integer.parseInt(request.getParameter("pid")); //项目id
									String ckzid =""; 
									String ckzstr=request.getParameter("ckzid"); //查看者id
									if(ckzstr!=null && !ckzstr.equals("")){
										ckzid=ckzstr;
										//添加查看者
										String[] idstr = ckzid.split(",");
										String string2 = "";
										for(int i=0;i<idstr.length;i++){
											NewWatch w = new NewWatch();
											int eid2=Integer.parseInt(idstr[i]);
											System.out.println(eid2);
											Employee employee = (Employee)approvaldao.getObjById(Employee.class, eid2);
											NewProject newprj=(NewProject)approvaldao.getObjById(NewProject.class,pid);
											w.setEmp(employee);
											w.setProject(newprj);
											approvaldao.addPrjWatcher(w);
										}
									}
									//修改申请人的审批金额,且必须比之前的多
									
									Employee e = approvaldao.getEmpByEId(sqrid);
									System.out.println(e.getApprovemoney());
									if(e.getApprovemoney()==null){
										e.setApprovemoney(money);
									}else if(e.getApprovemoney()!=null && e.getApprovemoney()>money){
										e.setApprovemoney(e.getApprovemoney());
									}else if(e.getApprovemoney()<money){
										e.setApprovemoney(money);
									}else{}
									approvaldao.updateApprovemoney(e);
									
									
									newapp.setAppstatus(1);
									num=1;
									numbumen=we111.get(0).getWorkposition().getDepartment().getName();
								}
							}
						}
					}
				
				}
				//登录人是主岗的时候就找出他的上一级  分岗
				else if(empposition.getPositiontype()==4)
				{
					String tophql="from WorkpositionEmployee where positiontype=3 and workposition.department.id="+empposition.getWorkposition().getDepartment().getId()+"";
					List<WorkpositionEmployee> we=approvaldao.execHQL(tophql);
					if(we.size()>0)//找到他上上一级主管
					{
						approveemp=we.get(0).getEmployee();//获取登录人部门的主管
						
						
						watch.setProject(newapp.getNewproject());
				    	watch.setEmp(approveemp);
					    // 保存对象
					    approvaldao.addcyr(watch);
					}
					else{
						
						//没有分管找上部门的主管、分管
						//主管
						String tophql11="from WorkpositionEmployee where positiontype=4 and workposition.department.id="+empposition.getWorkposition().getDepartment().getParentId()+"";
						List<WorkpositionEmployee> we11=approvaldao.execHQL(tophql11);
						if(we11.size()>0)//找到他上上一级主管
						{
							approveemp=we11.get(0).getEmployee();//获取登录人部门的主管
							
							
							watch.setProject(newapp.getNewproject());
					    	watch.setEmp(approveemp);
						    // 保存对象
						    approvaldao.addcyr(watch);
						}
						else{
							String tophql111="from WorkpositionEmployee where positiontype=3 and workposition.department.id="+empposition.getWorkposition().getDepartment().getParentId()+"";
							List<WorkpositionEmployee> we111=approvaldao.execHQL(tophql111);
							if(we111.size()>0)//找到他上上一级主管
							{
								approveemp=we111.get(0).getEmployee();//获取登录人部门的主管
								
								watch.setProject(newapp.getNewproject());
						    	watch.setEmp(approveemp);
							    // 保存对象
							    approvaldao.addcyr(watch);
							}
							else{
								//没有分管就审核通过
								approveemp=appemp;
								String moneystr= request.getParameter("money");
								double money=newapp.getApplypeople().getApprovemoney();//审批金额
								if(moneystr!=null && !moneystr.equals("")){
									money=Double.parseDouble(moneystr); 
								}
								
								int sqrid = Integer.parseInt(request.getParameter("sqrid")); //申请人id
								int pid = Integer.parseInt(request.getParameter("pid")); //项目id
								String ckzid =""; 
								String ckzstr=request.getParameter("ckzid"); //查看者id
								if(ckzstr!=null && !ckzstr.equals("")){
									ckzid=ckzstr;
									//添加查看者
									String[] idstr = ckzid.split(",");
									String string2 = "";
									for(int i=0;i<idstr.length;i++){
										NewWatch w = new NewWatch();
										int eid2=Integer.parseInt(idstr[i]);
										System.out.println(eid2);
										Employee employee = (Employee)approvaldao.getObjById(Employee.class, eid2);
										NewProject newprj=(NewProject)approvaldao.getObjById(NewProject.class,pid);
										w.setEmp(employee);
										w.setProject(newprj);
										approvaldao.addPrjWatcher(w);
									}
								}
								//修改申请人的审批金额,且必须比之前的多
								
								Employee e = approvaldao.getEmpByEId(sqrid);
								System.out.println(e.getApprovemoney());
								if(e.getApprovemoney()==null){
									e.setApprovemoney(money);
								}else if(e.getApprovemoney()!=null && e.getApprovemoney()>money){
									e.setApprovemoney(e.getApprovemoney());
								}else if(e.getApprovemoney()<money){
									e.setApprovemoney(money);
								}else{}
								approvaldao.updateApprovemoney(e);
								
								
								newapp.setAppstatus(1);
								num=1;
								numbumen=we111.get(0).getWorkposition().getDepartment().getName();
							}
						}
					}
					
				}
				else
				{

					//没有分管找上部门的主管、分管
					//主管
					String tophql11="from WorkpositionEmployee where positiontype=4 and workposition.department.id="+empposition.getWorkposition().getDepartment().getParentId()+"";
					List<WorkpositionEmployee> we11=approvaldao.execHQL(tophql11);
					if(we11.size()>0)//找到他上上一级主管
					{
						approveemp=we11.get(0).getEmployee();//获取登录人部门的主管
						
						watch.setProject(newapp.getNewproject());
				    	watch.setEmp(approveemp);
					    // 保存对象
					    approvaldao.addcyr(watch);
					}
					else{
						String tophql111="from WorkpositionEmployee where positiontype=3 and workposition.department.id="+empposition.getWorkposition().getDepartment().getParentId()+"";
						List<WorkpositionEmployee> we111=approvaldao.execHQL(tophql111);
						if(we111.size()>0)//找到他上上一级主管
						{
							approveemp=we111.get(0).getEmployee();//获取登录人部门的主管
							
							watch.setProject(newapp.getNewproject());
					    	watch.setEmp(approveemp);
						    // 保存对象
						    approvaldao.addcyr(watch);
						}
						else{
							//没有分管就审核通过
							approveemp=appemp;
							String moneystr= request.getParameter("money");
							double money=newapp.getApplypeople().getApprovemoney();//审批金额
							if(moneystr!=null && !moneystr.equals("")){
								money=Double.parseDouble(moneystr); 
							}
							
							int sqrid = Integer.parseInt(request.getParameter("sqrid")); //申请人id
							int pid = Integer.parseInt(request.getParameter("pid")); //项目id
							String ckzid =""; 
							String ckzstr=request.getParameter("ckzid"); //查看者id
							if(ckzstr!=null && !ckzstr.equals("")){
								ckzid=ckzstr;
								//添加查看者
								String[] idstr = ckzid.split(",");
								String string2 = "";
								for(int i=0;i<idstr.length;i++){
									NewWatch w = new NewWatch();
									int eid2=Integer.parseInt(idstr[i]);
									System.out.println(eid2);
									Employee employee = (Employee)approvaldao.getObjById(Employee.class, eid2);
									NewProject newprj=(NewProject)approvaldao.getObjById(NewProject.class,pid);
									w.setEmp(employee);
									w.setProject(newprj);
									approvaldao.addPrjWatcher(w);
								}
							}
							//修改申请人的审批金额,且必须比之前的多
							
							Employee e = approvaldao.getEmpByEId(sqrid);
							System.out.println(e.getApprovemoney());
							if(e.getApprovemoney()==null){
								e.setApprovemoney(money);
							}else if(e.getApprovemoney()!=null && e.getApprovemoney()>money){
								e.setApprovemoney(e.getApprovemoney());
							}else if(e.getApprovemoney()<money){
								e.setApprovemoney(money);
							}else{}
							approvaldao.updateApprovemoney(e);
							
							
							newapp.setAppstatus(1);
							num=1;
							numbumen=we111.get(0).getWorkposition().getDepartment().getName();
						}
					}
				}
				
			newapp.setApproveemp(approveemp);
			String appld= newapp.getAppLD()+","+approveemp.getId();
			newapp.setAppLD(appld);
		}
		
		if(num==1)
		{
			newapp.setTemp("没有"+numbumen+"部门主管、自己审批");
			newapp.setAppstatus(1);
		}
		else
		{
			newapp.setAppstatus(status);
		}
		newapp.setApproveinfo(content);
		// 修改审批记录的状态
		if(status==2&&num==0)
		{
			//上级审批修改数据库审批人
			try {
				newapp.setAppstatus(0);
				newapp.setApproveinfo("");
				approvaldao.updateApprove(newapp);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
		else
		{
			approvaldao.updateApprove(newapp);
		}
		// 修改审批项目记录的状态
		NewProject project=newapp.getNewproject();
		
		
		//  状态为１就是通过则项目状态改为进行中
		if(status==1||num==1){
			project.setProjectstatus(2);
		}
		//  状态为0就是拒绝，则项目状态改为立项中
		if(status==0){
			project.setProjectstatus(0);
		}
		//project.setProjectstatus(2);
		approvaldao.updatePrj(project);
		// 增加审批记录。
		Approverecord record=new Approverecord();
		record.setProjectname(newapp.getNewproject().getProjectname());
		record.setApproveemp(appemp.getName());
		record.setApplypeople(newapp.getApplypeople().getName());
		String now = dateFormat2.format(new Date());
		record.setApptime(now);
		record.setIspass(status);
		record.setApproveinfo(content);
		approvaldao.addRecord(record);//执行dao 方法
		return "apprecord";
	}
	
	// 审批记录
	public String appRecordList(){
		//页码
		String pageNo=request.getParameter("pageNo");
	    String dcstr=request.getParameter("dc");
		if(null == pageNo){
			pageNo ="1";
		}
		String hql="from Approverecord as a where 1=1";
		try {
			 String projectname= URLDecoder.decode(request.getParameter("projectname"),"utf-8");
			 String approveemp= URLDecoder.decode(request.getParameter("approveemp"),"utf-8");
			 int status=Integer.parseInt(request.getParameter("status"));
			 String sqr= URLDecoder.decode(request.getParameter("sqr"),"utf-8");
			 String apptime=request.getParameter("apptime");
			if(projectname!=null){
				hql+=" and projectname like '%"+projectname+"%'";
				request.setAttribute("projectname", projectname);
			}
			if(approveemp!=null){
				hql+=" and approveemp like '%"+approveemp+"%'";
				request.setAttribute("approveemp", approveemp);
			}
			if(status!=-1){
				hql+=" and ispass="+status;
				request.setAttribute("status", status);
			}
			if(sqr!=null){
				hql+=" and applypeople like '%"+sqr+"%'";
				request.setAttribute("sqr", sqr);
			}
			if(apptime!=null){
				hql+=" and apptime>='"+apptime+"'";
				request.setAttribute("apptime", apptime);
			}
			 
		} catch (Exception e) {
		}

		hql+=" order by id desc";
		if(dcstr!=null&&dcstr.equals("1")){
			int dc=Integer.parseInt(dcstr);
			List recordlist= approvaldao.execHQL(hql);
			request.setAttribute("recordlist",recordlist);
			return "dcrecord";
		}else{
			Pages pages=approvaldao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
			request.setAttribute("pages", pages);
			request.setAttribute("recordlist", pages.getPageList());
			return "record";
		}
	}

}
