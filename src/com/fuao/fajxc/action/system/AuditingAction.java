package com.fuao.fajxc.action.system;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.jasypt.util.text.BasicTextEncryptor;

import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Freeze;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.UpServer;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.VerifyOrderEmployee;

public class AuditingAction implements ServletRequestAware,ServletResponseAware {

	public static Logger  log = Logger.getLogger(AuditingAction.class);
	private AuditingBussiness aub;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private GroupSystemBussiness groupSystemBussiness;
	private LoginBussiness loginBussiness;
	Cookies ck = new Cookies();
	private EmployeeBussiness empBussiness;
	private CommonBiz formbiz;
	public CommonBiz getFormbiz() {
		return formbiz;
	}

	public void setFormbiz(CommonBiz formbiz) {
		this.formbiz = formbiz;
	}

	private AuditingOrderTab aot;

	
	
	public AuditingOrderTab getAot() {
		return aot;
	}

	public void setAot(AuditingOrderTab aot) {
		this.aot = aot;
	}

	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}

	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	public AuditingBussiness getAub() {
		return aub;
	}

	public void setAub(AuditingBussiness aub) {
		this.aub = aub;
	}
	
	/**
	 * 进入审核流程
	 * @return
	 */

	public String auditingVal2()
	{
		//获得单号
		String orderNo=request.getParameter("orderNo");
		//获得登录用户的Id
		String empId="";
		Employee emp11=null;
		if(empId==""){
			
			 emp11=(Employee)request.getSession().getAttribute("emp");
			 empId=String.valueOf(emp11.getId());
		}
		log.info("empId:"+empId);
		//获取表名
		String tab=request.getParameter("tab");
		//获取审核标识字段
		String aFiled=request.getParameter("filed");
		//获取单号名称
		String orderName=request.getParameter("orderName");
		//获得按钮的审核序号
		String orderNum=request.getParameter("orderNum");
		//获得意见反馈
		String tmp=request.getParameter("tmp");
		//获取是同意还是拒绝
		String marks=request.getParameter("marks");
		try{
			if(tmp!=null){
				tmp=URLDecoder.decode(tmp,"utf-8");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		log.info("tmp:::::::::::"+tmp);
		log.info("empid : "+empId);
		Employee emp=null;
		if(empId!=null){
			List list0=empBussiness.selEmps(" and id="+Integer.parseInt(empId));
			if(list0!=null)
				emp=(Employee) list0.get(0);
		}
		List list=null;
		try
		{
			if(emp==null){
				//没有审核权限 返回5
				response.getWriter().print("5");
				return null;
			}
			if(emp.getDepartment()!=null&&emp.getDelflag()==0){
				list=aub.someauditingOrder(" and orderNo='"+orderNo+"' and handlestate=1 and department.id="+emp.getDepartment().getId());
				List list1 = aub.someauditingOrder(" and orderNo='"+orderNo+"' and handlestate=0 and department.id="+emp.getDepartment().getId());
				
				if(null != list1 && list1.size()>0){
					//请等待上一个部门审核后在审核
						response.getWriter().print("7");
						return null;
				}
				log.info("listSize:"+list.size());
			}
			else{
				response.getWriter().print("5");
				return null;
			}
			if(list.size()>0&&list!=null){
				//获得单号的标识（'-'前面的字母）
				String ordertype=orderNo.substring(0,orderNo.lastIndexOf("-"));
				//判断登录的员工是否有审核的权限
				List verList=aub.someVerifyOrderEmployee(" and department.id="+emp.getDepartment().getId()+" and verifyOrder.ordertype='"+ordertype+"'");
				
				if(verList.size()>0){
					boolean flag=false;
					VerifyOrderEmployee verEmployee=(VerifyOrderEmployee) verList.get(0);
					log.info("employee:"+verEmployee.getEmployees());
					String employees=verEmployee.getEmployees();
					Object[] objemp=employees.split(",");
					for(int i=0;i<objemp.length;i++){
						log.info("empId:"+objemp[i]);
						log.info("logId:"+empId);
						if(objemp[i].equals(empId)){
								flag=true;
						}
					}
					log.info("该员工是否有权限："+flag);
					if(!flag){
						//没有审核权限
						response.getWriter().print("5");
						return null;
					}
				}
				else{
					//该单据的审核机制已被删除，请重新添加审核机制
					response.getWriter().print("6");
					return null;
				}
				//获得AuditingOrderTab对象
				AuditingOrderTab aot=(AuditingOrderTab) list.get(0);
				if(orderNum!=null){
					if(aot.getAuditingOrder()!=Integer.parseInt(orderNum)){
						//你不是该部门的员工无法审核！
						response.getWriter().print("3");
						return null;
					}
				}
				if(aot.getAuditingOrder()>1){
					AuditingOrderTab aot2=(AuditingOrderTab) aub.someauditingOrder(" and orderNo='"+orderNo+"' and auditingOrder="+(aot.getAuditingOrder()-1)).get(0);
					if(aot2.getAuditingFlag()==0){
						response.getWriter().print("4");
						return null;
					}
				}
				//获得当前时间
				SimpleDateFormat simdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime=simdate.format(new Date());
				log.info(nowTime);
				String hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2, employeeByEmpId.id="+emp.getId()+",auditingtime='"+nowTime+"'," +
						"auditingFlag="+marks+" where department.id="+emp.getDepartment().getId()+" and handlestate=1 and orderNo='"+orderNo+"'";
				log.info("hql:"+hql);
				
				
				list=new ArrayList();
				log.info(orderNo);
				list= aub.someauditingOrder("and orderNo='"+orderNo+"'");
				
				log.info("****************************");
				String s =((AuditingOrderTab)list.get(0)).getSbh();
				log.info(s);
				log.info("****************************");
				//保存附件
				formbiz.addFJ(s, "AuditingOrderTab", request);
				
				//吴伦清修改的地方  将审核是否通过的标识存储到aor对象中
				aot.setAuditingFlag(Integer.parseInt(marks));
				int flag=aub.AudtintingRound(hql,aot,tab,aFiled,orderName);
				if(flag==0){
					//审核通过 审核成功
					response.getWriter().print("0");
				}
				else if(flag==1){
					//formbiz.addFJ(aot.getSbh(), "AuditingOrderTab", request);
					//最终审核通过
					response.getWriter().print("1");
				}
				else{ 
					//审核出错
					response.getWriter().print("2");
				}
			}
			else
				//没有审核权限
				response.getWriter().print("5");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}

		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("SELECT count(id) as tmp ,verifyOrder.id FROM AuditingOrderTab where handlestate =1 and employees like '%"+emp.getId().toString()+"%' and verifyOrder.id!=''  group by verifyOrder.id");
		if(tablist.size()>0)
		{
			List<VerifyOrder> orderlist = groupSystemBussiness.getObject("VerifyOrder", "");
			if(orderlist.size()>0)
			{
				ServletActionContext.getContext().getSession().put("orderlist", orderlist);
			}
			ServletActionContext.getContext().getSession().put("backlogList", tablist);
		}
		return null;
	}
	
	/**
	 * 验证是否已进入审核流程
	 * @return
	 */
	public String valEdit()
	{
		log.info("ValEdit");
		String orderNo=request.getParameter("orderNo");
		try
		{
			if(orderNo!=null){
				List list=aub.someauditingOrder(" and orderNo='"+orderNo+"' and auditingFlag=0");
				if(list.size()>0)
					response.getWriter().print("0");
				else
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
	 * 执行接收按钮
	 * @return
	 */
	public String incept(){
		//获取当前时间
		TimePattern tp=new TimePattern();
		Date date=new Date();
		String hql=null;
		String hql2=null;
		String nowtime=tp.doTimeDf3(date);
		//获取单号1
		String orderNo=request.getParameter("orderNo");
		String tab=request.getParameter("tab");
		String sv=request.getParameter("state");
		String No=request.getParameter("No");
		//获得登录用户的Id
		Employee emp1=null;
		String empId=ck.getCookie(request,"employeeId");
		if(empId==""){
			 emp1=(Employee)request.getSession().getAttribute("emp");
			 empId=String.valueOf(emp1.getId());
		}
		
		log.info("empId:"+empId);
		
		// 根据表名找到订单类型标识
		String empOrdept="";
		String dochql=" and temp1='"+tab+"'";
		List doclist=aub.getObjectList("Docmark", dochql);
		if(doclist!=null && doclist.size()>0){
			// 得到标识对象后并且根据当前登录人所在的部门去找到审核对象(verifyorder)判断是由员工审核还是部门审核。
			Docmark docmark=(Docmark)doclist.get(0);
			// 得到当前登录人所在的部门
			Employee emp=(Employee)aub.getObj(Employee.class, Integer.parseInt(empId));
			String vhql=" and ordertype.id="+docmark.getId()+" and departments='"+emp.getDepartment().getId()+"'";
			List vlist=aub.getObjectList("VerifyOrder", vhql);
			if(vlist!=null && vlist.size()>0){
				VerifyOrder vorder=(VerifyOrder)vlist.get(0);
				empOrdept=vorder.getEmpOrdept();
			}
		}
		
		if(tab.equals("Sale_goods") || tab.equals("Sale_orders")){
		    hql="update "+tab+" set "+sv+"=2 where "+No+"='"+orderNo+"'" ;
		    List list = aub.getObjectList("AuditingOrderTab"," and orderNo='"+orderNo+"' and deldate=0");
		    AuditingOrderTab aTab1=(AuditingOrderTab) list.get(0);
		    empOrdept=aTab1.getEmpOrdept();
		}else{
		    hql="update "+tab+" set "+sv+"=8 where "+No+"='"+orderNo+"'" ;
			log.info(hql);
		}
//		    hql2="update AuditingOrderTab set empOrdept='"+empOrdept+"',incepttime='"+nowtime+"' , employeeByInceptemp.id="+empId+"" +
//			" where orderNo='"+orderNo+"' and handlestate=1" ;
		hql2="update AuditingOrderTab set empOrdept='emp',incepttime='"+nowtime+"' , employeeByInceptemp.id="+empId+"" +
		" where orderNo='"+orderNo+"' and handlestate=1" ;
		boolean flag=aub.updatehql(hql);
		boolean flag1=aub.updatehql(hql2);
		try{
			if(flag&flag1)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	public String incepts(){
		//获取当前时间
		String hql=null;
		TimePattern tp=new TimePattern();
		Date date=new Date();
		String nowtime=tp.doTimeDf3(date);
		//获取单号
		String orderNo=request.getParameter("orderNo");
		String tab=request.getParameter("tab");
		String sv=request.getParameter("state");
		String No=request.getParameter("No");
		
		//获得登录用户的Id
		String empId=ck.getCookie(request,"employeeId");
		log.info("empId:"+empId);
		hql="update "+tab+" set "+sv+"=8 where "+No+"='"+orderNo+"'" ;
		log.info(hql);
		String hql2="update AuditingOrderTab set incepttime='"+nowtime+"' , employeeByInceptemp.id="+empId+" " +
		" where rvid='"+orderNo+"' and handlestate=1" ;
		boolean flag=aub.updatehql(hql);
		boolean flag1=aub.updatehql(hql2);
		try{
			if(flag&flag1)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	

	
	
	public String auditingVals() throws IOException
	{   
		
		//获得单号
		String orderNo=request.getParameter("orderNo");
		//获得登录用户的Id
		Employee emp11=null;
		String empId="";
		if(empId==""){
			
			 emp11=(Employee)request.getSession().getAttribute("emp");
			 empId=String.valueOf(emp11.getId());
		}
		log.info("empId:"+empId);
		//获取表名
		String tab=request.getParameter("tab");
		//获取审核标识字段
		String aFiled=request.getParameter("filed");
		//获取单号名称
		String orderName=request.getParameter("orderName");
		//获得按钮的审核序号
		String orderNum=request.getParameter("orderNum");
		//获得意见反馈
		String tmp=request.getParameter("tmp");
		//获取是同意还是拒绝
		String marks=request.getParameter("marks");
		//同意和拒绝不同的操作
		if(marks.equals("1"))
		{
			String hqls = "update Tresourcecheck set isstate=1 where rvid='"+orderNo+"'";
			boolean flag = aub.updatehql(hqls); 
		}else
		{
			String hqls = "update Tresourcecheck set isstate=3 where rvid='"+orderNo+"'";
			boolean flag = aub.updatehql(hqls); 
		}
		
		try{
			if(tmp!=null){
				tmp=URLDecoder.decode(tmp,"utf-8");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		AuditingOrderTab aott = new AuditingOrderTab();
		List<AuditingOrderTab> aotlist = aub.someauditingOrder(" and rvid='"+orderNo+"' and handlestate=1");
		//没有数据表示没有该员工审核的单据或者没有权限
		if(null == aotlist || aotlist.size()<=0){
			
			response.getWriter().print("8");
		}
		for(int i=0; i<aotlist.size(); i++){
			AuditingOrderTab aot5 = aotlist.get(i);
			log.info(aot5.getEmployees());
			if(aot5.getEmployees() ==empId || aot5.getEmployees().equals(empId)){
				aott = aotlist.get(i);
				String hql = "";
				//获得当前时间
				SimpleDateFormat simdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime=simdate.format(new Date());
				
				//标识等于零的时候表示没有人与该员工同时审核
				log.info(aot5.getMark());
				//log.info(aot5.getMark()=="0" || aot5.getMark().equals("0"));
				
				if(aot5.getMark().equals("") || aot5.getMark()== "0" || aot5.getMark().equals("0")){
					
					hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2, employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
					
					"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and rvid='"+orderNo+"'";
					
					
					   //标识等于壹的时候表示有人与该员工同时审核，但其中一个人审核后就可以通过
				}else if(aot5.getMark()=="1" || aot5.getMark().equals("1")){
					
                    hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2, employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
					
					"auditingFlag="+marks+" where handlestate=1 and rvid='"+orderNo+"' and mark='1'";
					 //标识等于贰的时候表示有人与该员工同时审核，并且要同时审核的员工读审核通过后才能通过
				}else if(aot5.getMark()=="2" || aot5.getMark().equals("2")){
					
                    hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2, employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
					
					"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and rvid='"+orderNo+"'";
                    
                   
				}
				aott.setAuditingFlag(Integer.parseInt(marks));
				log.info("xxxxxxxxxxxxxxxx---1");
				 int flag=aub.AudtintingRound2(hql,aott,tab,aFiled,orderName,marks);
				 log.info("xxxxxxxxxxxxxxxx---2");
			//	int flag=aub.AudtintingRound(hql,aott,tab,aFiled,orderName);
			}
			
			
		}
		
		
				
				
				log.info("****************************");
				String s =aott.getSbh();
				log.info(s);
				log.info("****************************");
				//保存附件
//				formbiz.addFJ(s, "AuditingOrderTab", request);
				
				//吴伦清修改的地方  将审核是否通过的标识存储到aor对象中
		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("SELECT count(id) as tmp ,verifyOrder.id FROM AuditingOrderTab where handlestate =1 and employees like '%"+empId+"%' and verifyOrder.id!=''  group by verifyOrder.id");
		if(tablist.size()>0)
		{
			List<VerifyOrder> orderlist = groupSystemBussiness.getObject("VerifyOrder", "");
			if(orderlist.size()>0)
			{
				ServletActionContext.getContext().getSession().put("orderlist", orderlist);
			}
			ServletActionContext.getContext().getSession().put("backlogList", tablist);
		}
		return null;
	}
	
	public String auditingVal() throws IOException
	{ log.info("auditingVals()!");
		//获得单号
		String orderNo=request.getParameter("orderNo");
		//获得登录用户的Id
		String empId="";
		Employee emp11=null;
		if(empId==""){
			
			 emp11=(Employee)request.getSession().getAttribute("emp");
			 empId=String.valueOf(emp11.getId());
		}
		log.info("empId:"+empId);
		//获取表名
		String tab=request.getParameter("tab");
		//获取审核标识字段
		String aFiled=request.getParameter("filed");
		//获取单号名称
		String orderName=request.getParameter("orderName");
		//获得按钮的审核序号
		String orderNum=request.getParameter("orderNum");
		//获得意见反馈
		String tmp=request.getParameter("tmp");
		//获取是同意还是拒绝
		String marks=request.getParameter("marks");
		// 获取价格字段
		String priceFiled=request.getParameter("price");
		log.info(tab+","+orderName+","+marks+","+orderName+",");
		double price=0;
		// 得到当前表名根据单号得到当前订单的价格
		if(priceFiled!=null){
			price=aub.objByprice(tab, orderNo,orderName,priceFiled); //以后要改的－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
		}
		try{
			if(tmp!=null){
				tmp=URLDecoder.decode(tmp,"utf-8");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		AuditingOrderTab aott = new AuditingOrderTab();
		List<AuditingOrderTab> aotlist = aub.someauditingOrder(" and orderNo='"+orderNo+"' and handlestate!=2");
		//没有数据表示没有该员工审核的单据或者没有权限
		if(null == aotlist || aotlist.size()<=0){
			
			response.getWriter().print("8");
		}
		int flag=0;
		for(int i=0; i<aotlist.size(); i++){
			AuditingOrderTab aot5 = aotlist.get(i);
			log.info(aot5.getEmployees()+"审核的employee");
			if(aot5.getEmployees() ==empId || aot5.getEmployees().equals(empId)){
				aott = aotlist.get(i);
				// 首先要判断当前登录的人是按部门审核还是按员工审核的？
				if(aott.getEmpOrdept().equals("emp")){
					// 根据表名找到审核类型并且是根据员工审核的
					log.info("员工审核");
					Docmark docmark=aub.typeBymark(tab);
					OperationEmployeematch operemp = null;
				    
					
					String hql = "";
					//获得当前时间
					SimpleDateFormat simdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String nowTime=simdate.format(new Date());
					
					//标识等于零的时候表示没有人与该员工同时审核
					log.info(aot5.getMark()+"//标识等于零的时候表示没有人与该员工同时审核");
					//log.info(aot5.getMark()=="0" || aot5.getMark().equals("0"));
					//这里要根据员工去判断月，季，年度的金额是否可以通过。
					Map<String, Double> map=null;
					Map<String, Double> map2=null;
					map=aub.yjnByemp(Integer.parseInt(empId));// 查找审核记录
					try {
						operemp=aub.getOper(docmark, Integer.parseInt(empId));
					} catch (Exception e) {
						log.info(e+"错误");
						e.printStackTrace();
					}
					 map2=aub.empByprice(operemp);   // 根据审核人员对象找到不同月份规定的审核金额找的表是:Auditline
					 System.out.println(aot5.getMark());
					 log.info(aot5.getMark()+"mark的值");
					 log.info(map2);
					if(aot5.getMark() == null || aot5.getMark()== "0" || aot5.getMark().equals("0") || aot5.getMark().equals("")){
						log.info("进入make"+aot5.getMark());
						if(tab.equals("Notice")){
							hql="update AuditingOrderTab set tmp='"+tmp+"',deldate=0, handlestate=2,employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
							"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and orderNo='"+orderNo+"'";
						}
						
						
						if(tab.equals("Sale_goods") || tab.equals("Sale_orders")){//deldate=1
							hql="update AuditingOrderTab set tmp='"+tmp+"',deldate=0, handlestate=2,employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
							"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and orderNo='"+orderNo+"'";
						}else{
							// 判断单次审核金额，当前月的审核金额，当前季度的审核金额，当前半年的审核金额，这一年的审核金额够不够
							log.info("运行进入金额审批部分！");
							log.info(hql);
							if(operemp.getMoney()>=price && map2.get("monthprice")>=map.get("monthprice") && map2.get("jdprice")>=map.get("jdprice") && map2.get("bnprice")>=map.get("bnprice") && map2.get("yearprice")>=map.get("yearprice")){
								log.info("619进行判断");
								hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,price="+price+",employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
								"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and orderNo='"+orderNo+"'";
								log.info(marks+"marks");
								if(marks.equals("2")){
			                    	String upNo = orderNo;
			                    	String uphql = "from Freeze where upNo='"+upNo+"'";
			                    	List list = aub.getAll(uphql);
			                    	if(list.size()>0 && null!=list){
			                    		Freeze freeze = (Freeze)list.get(0);
			                    		freeze.setFreezeFlag(0);
			                    		aub.updObj(freeze);
			                    		Product product = freeze.getProduct();
			                    		product.setUsestate(2);
			                    		product.setIsfreeze(0);
			                    		aub.updObj(product);
			                    	}
			                    }
								
							}
						
						}
					    //标识等于壹的时候表示有人与该员工同时审核，但其中一个人审核后就可以通过
					}else if(aot5.getMark()=="1" || aot5.getMark().equals("1")){
						
						if(tab.equals("Sale_goods") || tab.equals("Sale_orders")){
							  hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,deldate=0,employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
								"auditingFlag="+marks+" where handlestate=1 and orderNo='"+orderNo+"' and mark='1'";
						}else{
							if(operemp.getMoney()>=price && map2.get("monthprice")>=map.get("monthprice") && map2.get("jdprice")>=map.get("jdprice") && map2.get("bnprice")>=map.get("bnprice") && map2.get("yearprice")>=map.get("yearprice")){
			                    hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,price="+price+",employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
								"auditingFlag="+marks+" where handlestate=1 and orderNo='"+orderNo+"' and mark='1'";
			                    
							}
						}
						 //标识等于贰的时候表示有人与该员工同时审核，并且要同时审核的员工读审核通过后才能通过
					}else if(aot5.getMark()=="2" || aot5.getMark().equals("2")){
						
						if(tab.equals("Sale_goods") || tab.equals("Sale_orders")){
							 hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,deldate=0,employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
								"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and orderNo='"+orderNo+"'";
						}else{
							if(operemp.getMoney()>=price && map2.get("monthprice")>=map.get("monthprice") && map2.get("jdprice")>=map.get("jdprice") && map2.get("bnprice")>=map.get("bnprice") && map2.get("yearprice")>=map.get("yearprice")){
			                    hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,price="+price+",employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
								"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1 and orderNo='"+orderNo+"'";
			                    
							}
						}
					}
					aott.setAuditingFlag(Integer.parseInt(marks));
					log.info("xxxxxxxxxxxxxxxx---1"+hql);
					if(hql.trim().length()>0){
						flag=aub.AudtintingRound1(hql,aott,tab,aFiled,orderName,marks);
						log.info("执行结果"+flag);
						if(tab.equals("UpServer")){
							aub.updatehql("update "+tab+" set audtitingFlag=1 where upNo='"+orderNo+"'");
							String newhql = "from UpServer where upNo='"+orderNo+"'";
							List list  = aub.getAll(newhql);
							if(list.size()>0){
								UpServer us = (UpServer)list.get(0);
								System.out.println(us.getSoOrders().getSoId());
								int id = us.getSoOrders().getSoId();
								Sale_orders so  = (Sale_orders)aub.getObj(Sale_orders.class, id);								
								so.setSoStat(4);
								aub.updObj(so);
							}
						}
						if(tab.equals("Notice")){
							
							String hqln = "update "+tab+" set audtitingFlag="+marks+" where noticeNo='"+orderNo+"'";
							aub.updatehql(hqln);
						}else if(tab.equals("Outbound")){//判断如果是出入库库单，审核完成后把产品状态从冻结修改成已用1
							aub.updatehql("update "+tab+" set auditingState=1 where outboundNo='"+orderNo+"'");
							String crkhql="from Outbound where outboundNo='"+orderNo+"'";
							List list=empBussiness.exHql(crkhql);
							Outbound ob=new Outbound();
							ob=(Outbound)list.get(0);
							if(ob.getOutboundInfos()!=null){
							Set obset=ob.getOutboundInfos();
							for (Iterator iterator = obset.iterator(); iterator
									.hasNext();) {
								OutboundInfo object = (OutboundInfo) iterator.next();//出库详情取值出库商品，修改商品状态改成已使用
								Product pro=new Product();
								if(object.getProduct()!=null){
								pro=object.getProduct();
								pro.setUsestate(1);//1 已经使用。 2未使用（可以使用）
								pro.setIsfreeze(0);//冻结状态休息
								aub.updObj(pro);//更改状态
								}
							}
							}
								
								
							}else if(tab.equals("Storage")){
								aub.updatehql("update "+tab+" set storageVerify=1 where storageNo='"+orderNo+"'");
								String crkhql="from Storage where storageNo='"+orderNo+"'";
								List list=empBussiness.exHql(crkhql);
								Storage st=new Storage();
								st=(Storage)list.get(0);
								Set obset=st.getStorageInfos();
								for (Iterator iterator = obset.iterator(); iterator
										.hasNext();) {
									StorageInfo object = (StorageInfo) iterator.next();//出库详情取值出库商品，修改商品状态改成已使用
									Product pro=new Product();
									if(object.getProducts()!=null){
								
										Set porset= object.getProducts();
										for (Iterator iterator2 = porset
												.iterator(); iterator2
												.hasNext();) {
											Product object2 = (Product) iterator2
													.next();
											object2.setUsestate(2);//1 已经使用。  2未使用（可以使用）
											object2.setIsfreeze(0);//冻结状态休息
											aub.updObj(object2);//更改状态
										}
									
									}
								
							}}else {
							
								
							
							aub.updatehql("update "+tab+" set sgStat=1 where sgcode='"+orderNo+"'");
						}
					}else{
						flag=10;
					}
					log.info("xxxxxxxxxxxxxxxx---2");
			}
			// 是部门审核
			if(aott.getEmpOrdept().equals("dept")){
				// 根据表名找到审核类型并且是根据员工审核的
				Docmark docmark=aub.typeBymark(tab);
				OperationDepartmentmatch operdept=aub.operBydept(Integer.parseInt(docmark.getOtype()), Integer.parseInt(empId));
				String hql = "";
				//获得当前时间
				SimpleDateFormat simdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime=simdate.format(new Date());
				
				//标识等于零的时候表示没有人与该员工同时审核
				log.info(aot5.getMark());
				//log.info(aot5.getMark()=="0" || aot5.getMark().equals("0"));
				//这里要根据员工去判断月，季，年度的金额是否可以通过。
				Map<String, Double> map=aub.yjnBydept(Integer.parseInt(empId));
				Map<String, Double> map2=aub.deptByprice(operdept);
				if(aot5.getMark() == null || aot5.getMark()== "0" || aot5.getMark().equals("0")){
					// 判断单次审核金额，当前月的审核金额，当前季度的审核金额，当前半年的审核金额，这一年的审核金额够不够
					if(operdept.getMoney()>=price && map2.get("monthprice")>=map.get("monthprice") && map2.get("jdprice")>=map.get("jdprice") && map2.get("bnprice")>=map.get("bnprice") && map2.get("yearprice")>=map.get("yearprice")){
						hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,price="+price+", employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
						"auditingFlag="+marks+" where employees= "+empId+" and handlestate=1  and orderNo='"+orderNo+"'";
					}else{
						String zgid=aub.getZG(Integer.parseInt(empId)); // 如果审核金额不足的话则上报给上级审核，根据当前登录人找到主管
						hql="update AuditingOrderTab set tmp='"+tmp+"',employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"',employees="+zgid+
						"auditingFlag="+0+" where employees= "+empId+" and handlestate=1 and orderNo='"+orderNo+"'";
					}
				    //标识等于壹的时候表示有人与该员工同时审核，但其中一个人审核后就可以通过
				}else if(aot5.getMark()=="1" || aot5.getMark().equals("1")){
					if(operdept.getMoney()>=price && map2.get("monthprice")>=map.get("monthprice") && map2.get("jdprice")>=map.get("jdprice") && map2.get("bnprice")>=map.get("bnprice") && map2.get("yearprice")>=map.get("yearprice")){
	                    hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,price="+price+", employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
						"auditingFlag="+marks+" where orderNo='"+orderNo+"' and mark='1'";
					}else{
						String zgid=aub.getZG(Integer.parseInt(empId)); // 如果审核金额不足的话则上报给上级审核，根据当前登录人找到主管
						hql="update AuditingOrderTab set tmp='"+tmp+"',employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"',employees="+zgid+
						"auditingFlag="+1+" where employees= "+empId+" and orderNo='"+orderNo+"'";
					}
					 //标识等于贰的时候表示有人与该员工同时审核，并且要同时审核的员工读审核通过后才能通过
				}else if(aot5.getMark()=="2" || aot5.getMark().equals("2")){
					if(operdept.getMoney()>=price && map2.get("monthprice")>=map.get("monthprice") && map2.get("jdprice")>=map.get("jdprice") && map2.get("bnprice")>=map.get("bnprice") && map2.get("yearprice")>=map.get("yearprice")){
	                    hql="update AuditingOrderTab set tmp='"+tmp+"', handlestate=2,price="+price+", employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"'," +
						"auditingFlag="+marks+" where employees= "+empId+"  and orderNo='"+orderNo+"'";
					}else{
						String zgid=aub.getZG(Integer.parseInt(empId)); // 如果审核金额不足的话则上报给上级审核，根据当前登录人找到主管
						hql="update AuditingOrderTab set tmp='"+tmp+"',employeeByEmpId.id="+empId+",auditingtime='"+nowTime+"',employees="+zgid+
						"auditingFlag="+2+" where employees= "+empId+"  and orderNo='"+orderNo+"'";
					}
				}
				aott.setAuditingFlag(Integer.parseInt(marks));
				log.info("xxxxxxxxxxxxxxxx---1");
				flag=aub.AudtintingRound1(hql,aott,tab,aFiled,orderName,marks);
				log.info("xxxxxxxxxxxxxxxx---2");
			}
			
		}
		}
		log.info("****************************");
		String s =aott.getSbh();
		log.info(s);
		log.info("****************************");
		//保存附件
		formbiz.addFJ(s, "AuditingOrderTab", request);
		
		//吴伦清修改的地方  将审核是否通过的标识存储到aor对象中
		List<AuditingOrderTab> tablist = loginBussiness.getAuditingOrder("SELECT count(id) as tmp ,verifyOrder.id FROM AuditingOrderTab where handlestate =1 and employees like '%"+empId+"%' and verifyOrder.id!=''  group by verifyOrder.id");
		if(tablist.size()>0)
		{
			List<VerifyOrder> orderlist = groupSystemBussiness.getObject("VerifyOrder", "");
			if(orderlist.size()>0)
			{
				ServletActionContext.getContext().getSession().put("orderlist", orderlist);
			}
			ServletActionContext.getContext().getSession().put("backlogList", tablist);
		}
		try {
			log.info("结束"+flag);
			response.getWriter().print(flag);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	
	
	
	/**
	 * 流程跟踪
	 * @return
	 */
	public String follow(){
		String orderNo=request.getParameter("orderNo");
		List<AuditingOrderTab> alist=aub.someauditingOrder(" and orderNo='"+orderNo+"'");
		if(alist.size()>0){
			request.setAttribute("alist", alist);
		}
		return "success";
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response=response;
	}
		
	public static void main(String[] args) {
		String test="i love java";
		log.info(test);
		BasicTextEncryptor bte=new BasicTextEncryptor();
		bte.setPassword("jsun781");
		String encrypted=bte.encrypt(test);
		log.info(encrypted);
		log.info(bte.decrypt(encrypted));

	}

	public GroupSystemBussiness getGroupSystemBussiness() {
		return groupSystemBussiness;
	}

	public void setGroupSystemBussiness(GroupSystemBussiness groupSystemBussiness) {
		this.groupSystemBussiness = groupSystemBussiness;
	}

	public LoginBussiness getLoginBussiness() {
		return loginBussiness;
	}

	public void setLoginBussiness(LoginBussiness loginBussiness) {
		this.loginBussiness = loginBussiness;
	}

}
