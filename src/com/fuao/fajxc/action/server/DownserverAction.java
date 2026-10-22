package com.fuao.fajxc.action.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.server.DownserverBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class DownserverAction implements ServletRequestAware,ServletResponseAware,ModelDriven {

	private  static Logger  logger = Logger.getLogger(DownServer.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private DownServer downserver;
	private Object[] ids;
	private DownserverBussiness dsb;
	//获得下架单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	Cookies ck = new Cookies();
	private AuditingBussiness audBussiness;
	private SaleorderBussiness sobiz;
	private CommonBiz commbiz;
	//添加动态记录业务类
	private ExecuteRecordBussiness executeRecordBussiness;
	
	private List upserverlist;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public DownserverBussiness getDsb() {
		return dsb;
	}

	public void setDsb(DownserverBussiness dsb) {
		this.dsb = dsb;
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

	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public Object getModel() {
		downserver=new DownServer();
		return downserver;
	}
	
	/**
	 * 查看下架单列表
	 * @return
	 */
	public String select()
	{
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		StringBuffer addhql=new StringBuffer();
		//参数 ：实体名
		String marker = request.getParameter("marker")==null?"":request.getParameter("marker");
		//单据的审核状态      0：未审   1：待审   2：已审
		String state = request.getParameter("state")==null?"1":request.getParameter("state");
		
		Cookies cook = new Cookies();
		String employeeId = cook.getCookie(request, "employeeId");
		List<Employee> emplist = audBussiness.getObjectList("Employee", " and id = "+employeeId);
		
		String funid = request.getParameter("funid");		//菜单栏id
		String resouceSet = "";
		if(funid!=null&&!funid.equals(""))
		{
			Map resouceMap = (Map)ActionContext.getContext().get("resouceSet");		//组角色访问资源权限列表
			resouceSet = (String)resouceMap.get("resouce");
		}
		
		//模糊查找 
		//筛选单据的单号
		String sjNo=request.getParameter("sjNo");
		
		//待审核的单据查询
		if(marker!=null&&!marker.equals(""))
		{
			//需要当前登录员工审核单据的单号集合
			String condition = audBussiness.getOrderNOList(marker, employeeId,sjNo,state);
			if(condition!=null&&!condition.equals(""))
			{
				condition = condition.substring(0,condition.length()-1);
			}
			else
			{
				condition = "''";
			}
			//根据单据的单号集合，获取列表
			addhql.append(" and downNo in ("+condition+")") ;
			request.setAttribute("tag", marker);
			request.setAttribute("state", state);
		}
		//组角色访问的资源权限   
		else if (resouceSet!=null&&!resouceSet.equals(""))
		{
			//根据单号筛选单据
			if(sjNo!=null&&sjNo!=""){
				addhql.append(" and upNo like '%"+sjNo.trim()+"%'");
			}
			if(resouceSet.indexOf(funid)==-1)
			{
				//addhql.append(" and employee.id = '0'");
			}
		}
		//部门权限
		else
		{
			if(sjNo!=null&&sjNo!=""){
				addhql.append(" and downNo like '%"+sjNo+"%'");
			}
			//员工权限   和主管权限
			if(employeeId !=null &&!employeeId.equals(""))
			{
				if(emplist.size()>0)
				{
					//职位等级小于3的，表明是主管以下的，就查询当前登录的员工id的数据列表
					if(emplist.get(0).getGroups().getGrade()<3)  
					{
					//	addhql.append(" and employee.id = '"+employeeId+"'");
					}
					//职位等小于等于4的并且职位大于等3的，表明是经理级 的和主管级的。主管级的看不到经理级的数据
					else if(emplist.get(0).getGroups().getGrade()>=3&&emplist.get(0).getGroups().getGrade()<=4)
					{
						List<Employee> elist = audBussiness.getObjectList("Employee", " and groups.superGroupId = "+emplist.get(0).getGroups().getSuperGroupId()+" and groups.grade <"+emplist.get(0).getGroups().getGrade());
						String empids = "";
						for(Employee e : elist)
						{
							empids += e.getId()+",";
						}
						if(empids!=null&&!empids.equals(""))
						{
							empids = empids+employeeId;		//将自己的也查出来
							addhql.append(" and employee.id in("+empids+")");
						}
					}
					//职位等级是5的，表明是总经办的或者管理员的。可以看到所有数据
					else
					{
						//可以不用加员工id，进行查询
					}
				}
			}
			//只有在查询数据列表的时候，才可以对单据进行增删改，而是查询审核的数据列表是不可以修改单据的
			ServletActionContext.getRequest().setAttribute("option", map);
		}
		String hql=" from DownServer where delflag=0 "+addhql.toString()+" order by id desc";
		Pages pages=dsb.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		logger.error("logger::::"+hql);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 * 显示添加下架单页面
	 * @return
	 */
	public String addShow()
	{
		response.setCharacterEncoding("ios8859-1");
		///增加下架单所需数据列表  
		//1.下架单号   2.服务器名称    3.根据服务器名称获取没有下架的IP ，4.获取机房位置    
		
		//获得下架单号
		String ckNo="XJ-"+serial.getSerialNumber();
		request.setAttribute("XJNo", ckNo);
		//查找下架类型
		List<AllType> downList=dsb.someType("");
		request.setAttribute("downType", downList);
		return "add";
	}
	/**
	 * 从上架单列表页面跳转到添加下架单页面
	 * @return
	 */
	public String addShow2()
	{
		response.setCharacterEncoding("ios8859-1");
		///增加下架单所需数据列表  
		//1.下架单号   2.服务器名称    3.根据服务器名称获取没有下架的IP ，4.获取机房位置    
		
		//获得下架单号
		String ckNo="XJ-"+serial.getSerialNumber();
		request.setAttribute("XJNo", ckNo);
		//查找下架类型
		List<AllType> downList=dsb.someType("");
		request.setAttribute("downType", downList);
		String upNo = request.getParameter("upNo");
		request.setAttribute("upNo",upNo);
		return "add";
	}
	

	
	/**
	 * 添加下架单
	 * @return
	 */
	public String add()
	{
		boolean flag=false;
		try
		{		
			downserver.setRemark(downserver.getRemark().trim());
			downserver.setBusinesstype(downserver.getBusinesstype().trim());
			downserver.setSystem(downserver.getSystem().trim());
			downserver.setBandwidthflow(downserver.getBandwidthflow().trim());
			downserver.setConfigurationinfo(downserver.getConfigurationinfo().trim());
			downserver.setDowncause(downserver.getDowncause().trim());
			downserver.setServerLocation(downserver.getServerLocation().trim());
			if("其它".equals(downserver.getSystem()))
			{
				downserver.setSystem(request.getParameter("systemother").trim());//系统显示中的其它
			}
			if("其它".equals(downserver.getBandwidthflow()))
			{
				downserver.setBandwidthflow(request.getParameter("bandother").trim());//系统显示中的其它
			}
			if("CDN".equals(downserver.getBandwidthflow()))
			{
				downserver.setBandwidthflow(request.getParameter("bandcdn").trim());//系统显示中的其它
			}
			downserver=dsb.addReturndownServer(downserver);
			if(downserver!=null){
				int marker=audBussiness.addAuditingOrder2("XJ",downserver.getDownNo(),"DownServer",ck.getCookie(request, "filialemark"));
				if(marker==0)
				{
					downserver.setAuditingFlag(1);
					dsb.editdownServer(downserver);
					response.getWriter().print("0");
				}
				else if(marker==2)
					response.getWriter().print("2");
				else
					response.getWriter().print("1");
			}
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		/*阙超强 14015   添加记录动态信息*/
		//拿到登陆员工用户
		Object object =  request.getSession().getAttribute("emp");
		Employee loginEmp = null;
		if(null != object){
			loginEmp = (Employee) object;
		}else{
			request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
			return "no";
		}
		//添加记录到动态记录表
		if(loginEmp != null){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个下架单。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(downserver.getId().toString());
			executerecord.setEntityName("DownServer");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "addright";
	}
	

	/**
	 * 更新下架单显示
	 * @return
	 */
	public String updateShow()
	{
		//查找下架类型
		List downList=dsb.someType("");
		request.setAttribute("downType", downList);
		String id=request.getParameter("cid");
		if(id!=null){
			DownServer dserver=(DownServer) dsb.somedownServer(" and id="+Integer.parseInt(id)).get(0);
			//取得所对应的服务器所有的  还没有下架的ip地址
		//	dserver.getProduct().getId();///下架单--服务器--id--ip的parentId
		//	List<Product> iplist=null;
			request.setAttribute("oneDownS", dserver);
		}
		return "add";
	}
	
	/**
	 * 修改下架单
	 * @return
	 */
	public String edit()
	{
		boolean flag=false;
		try
		{
			downserver.setRemark(downserver.getRemark().trim());
			downserver.setDelflag(0);
			if("其它".equals(downserver.getSystem()))
			{
				downserver.setSystem(request.getParameter("systemother").trim());//系统显示中的其它
			}
			if("其它".equals(downserver.getBandwidthflow()))
			{
				downserver.setBandwidthflow(request.getParameter("bandother").trim());//系统显示中的其它
			}
			if("CDN".equals(downserver.getBandwidthflow()))
			{
				downserver.setBandwidthflow(request.getParameter("bandcdn").trim());//系统显示中的其它
			}
			flag=dsb.editdownServer(downserver);
			
			//拿到登陆员工用户
			Object object =  request.getSession().getAttribute("emp");
			Employee loginEmp = null;
			if(null != object){
				loginEmp = (Employee) object;
			}else{
				request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
				return "no";
			}
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个下架单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(downserver.getId().toString());
				executerecord.setEntityName("Downserver");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "addright";
	}
	
	/**
	 * 删除下架单
	 * @return
	 */
	public String del()
	{
		boolean flag=dsb.deldownServer(ids);
		try
		{
			if(flag)
			{
				//拿到登陆员工用户
				Object object =  request.getSession().getAttribute("emp");
				Employee loginEmp = null;
				if(null != object){
					loginEmp = (Employee) object;
				}else{
					request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
					return "no";
				}
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一些下架单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Downserver");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				response.getWriter().print("0");
				
			}
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "addright";
	}
	
	/**
	 * 查询详细
	 * @return
	 */
	public String detail()
	{
		response.setCharacterEncoding("iso8859-1");
		//String id=request.getParameter("cid");id和downNo重复取downNo即可
		//获得下架单号
		String downNo=request.getParameter("downNo");
		//获取info
		String info = request.getParameter("info");
		if(downNo!=null & !downNo.equals("")){
			String addhql=" and downNo='"+downNo+"'";
			List list=dsb.somedownServer(addhql);
			
			if(list.size()>0){
				DownServer down=(DownServer)list.get(0);
				request.setAttribute("downDetail", down);
				if(down.getAuditingFlag()==0)
				{
//					boolean flag=false;
//					if(flag){
						request.setAttribute("mark", "mark");
//					}
				}
			}
		}
		String empid=ck.getCookie(request, "employeeId");
		
		boolean flag1=audBussiness.checkemp1(downNo, empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(downNo!=null){
				String addhql2=" and orderNo='"+downNo+"'";
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0){
					
					String depid = ck.getCookie(request, "departmentId");
					
					for(int i=0; i<audList.size(); i++){
						
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						
						if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 ){
							
							//表示未审核
							request.setAttribute("flage", 0);
							
						}else if(aot.getDepartment().getId() == Integer.parseInt(depid)&&
								(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2)){
							
							//表示已经审核
							request.setAttribute("flage", 1);
							request.setAttribute("aot", aot);
						}
					}
				}				
			}
		}
		return "detail";
	}
	
	/**
	 * 审核后操作  点击下架的操作
	 * @return
	 * @throws IOException 
	 */
	public void auditing() throws IOException
	{
		//服务器下架操作     还要传个saleorder订单的id 值过来，查找，并生成一个新的子上架单
		//要查找原有的销售订单，根据在下架单中的产品（服务器）product，的id，到销售订单中
		//针对销售订单分组查询，找出该服务器的最大的（最新的）开始时间的订单，找到它的id，把它的id做为parentId,新增加一个订单，
		//如果完全下架，则不要生成新销售订单
		boolean flag=false;
		String proId=request.getParameter("proId");//商品id  ///服务器id
		String downId=request.getParameter("upId");//doserver.id下架单的id
		
			if(proId!=null&&downId!=null){
				flag=dsb.executeUpserver(proId, downId);
			}
			if(flag){
				response.getWriter().print("0");
			}
			else{
				response.getWriter().print("1");
			}
		
	}
	/**
	 * 根据上架单编号获得下架单编号
	 */
	public void getDownNo(){
		response.setContentType("text/html");
		String upNo = request.getParameter("upNo");
		try {
			if(upNo == null || upNo.equals("")){
				response.getWriter().print(1);
				return ;
			}
			String hql = " and upNo ='"+upNo+"'";
			List list = dsb.somedownServer(hql);
			if(list !=null && list.size() >0){
				String data = ((DownServer)list.get(0)).getDownNo();
				response.getWriter().print(data);
			}else{
				response.getWriter().print(2);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ; 
	}
	/**
	 * 审核失败后取消下架单
	 */
	
	public void cancle(){
		response.setContentType("text/html");
		String id = request.getParameter("id");
		try {
			if(id == null || id.equals("")){
				response.getWriter().print(1);
				return ;
			}
			String hql = " and id ="+id;
			List list = dsb.somedownServer(hql);
			if(list !=null && list.size() >0){
				DownServer ds = (DownServer)list.get(0);
				ds.setDownFlag(2);//撤销下架单
				dsb.editdownServer(ds);
				commbiz.updateBills("update UpServer set upFlag =1 where upNo='"+ds.getUpNo()+"'");
				response.getWriter().print(0);
			}else{
				response.getWriter().print(2);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ; 
	}

	public SaleorderBussiness getSobiz() {
		return sobiz;
	}

	public void setSobiz(SaleorderBussiness sobiz) {
		this.sobiz = sobiz;
	}

	public CommonBiz getCommbiz() {
		return commbiz;
	}

	public void setCommbiz(CommonBiz commbiz) {
		this.commbiz = commbiz;
	}
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
	}
}
