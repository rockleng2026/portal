package com.fuao.fajxc.action.stockpile;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.action.basic.EmployeeAction;
import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.DepotBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.stockpile.StatBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.fuao.fajxc.vo.Stat;
import com.fuao.fajxc.vo.StatInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.ObjectFactory;


public class StatAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private StatBussiness statbussiness;
	private EmployeeBussiness empBussiness;
	private DepotBussiness depotBussiness;
	private Stat stat;
	private Object[] ids;
	private static Logger logger = Logger.getLogger(EmployeeAction.class);
	//获得盘点单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	//所有型号字符串
	private String mode;
	//所有盘点数量字符串
	private String factcount;
	//所有账面数量字符串
	private String datacount;
	//所有损益情况字符串
	private String count;
	//所有备注字符串
	private String markInfo;
	Cookies ck = new Cookies();
	
	//添加动态记录
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	private AuditingBussiness audBussiness;
	
	
	
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	/**
	 * @return the mode
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode the mode to set
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * @return the factcount
	 */
	public String getFactcount() {
		return factcount;
	}

	/**
	 * @param factcount the factcount to set
	 */
	public void setFactcount(String factcount) {
		this.factcount = factcount;
	}

	/**
	 * @return the datacount
	 */
	public String getDatacount() {
		return datacount;
	}

	/**
	 * @param datacount the datacount to set
	 */
	public void setDatacount(String datacount) {
		this.datacount = datacount;
	}

	/**
	 * @return the count
	 */
	public String getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(String count) {
		this.count = count;
	}



	
	/**
	 * @return the markInfo
	 */
	public String getMarkInfo() {
		return markInfo;
	}

	/**
	 * @param markInfo the markInfo to set
	 */
	public void setMarkInfo(String markInfo) {
		this.markInfo = markInfo;
	}

	/**
	 * @return the empBussiness
	 */
	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}

	/**
	 * @param empBussiness the empBussiness to set
	 */
	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	/**
	 * @return the depotBussiness
	 */
	public DepotBussiness getDepotBussiness() {
		return depotBussiness;
	}

	/**
	 * @param depotBussiness the depotBussiness to set
	 */
	public void setDepotBussiness(DepotBussiness depotBussiness) {
		this.depotBussiness = depotBussiness;
	}

	
	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the statbussiness
	 */
	public StatBussiness getStatbussiness() {
		return statbussiness;
	}

	/**
	 * @param statbussiness the statbussiness to set
	 */
	public void setStatbussiness(StatBussiness statbussiness) {
		this.statbussiness = statbussiness;
	}

	public Object getModel() {
		stat=new Stat();
		return stat;
	}

	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}

	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response=response;
	}
	
	/**
	 * 查找盘点单
	 * @return
	 */
	public String select()
	{
		String marker=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker);
		request.setAttribute("taskid", taskid);
		
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找的盘点单编号
		String statNo=request.getParameter("statNo");
		if(statNo!=null){
			addhql+=" and statNo like '%"+statNo+"%'";
		}
		System.out.println("addhql"+addhql);
		String hql="from Stat where delflag=0"+addhql;
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by id desc";
		
		System.out.println("hql:"+hql);
		System.out.println("pageNo:"+pageNo);
		Pages pages=statbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages"+pages);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 * 盘点单详细信息
	 * @return
	 */
	public String detail()
	{
		String id=request.getParameter("cid");
		String info = request.getParameter("info");
		if(id!=null)
		{
			List list=statbussiness.someStat(" and id="+id);
			System.out.println(((Stat)list.get(0)).getStatNo());
			request.setAttribute("pdList", list.get(0));
			
			
			String empid=ck.getCookie(request, "employeeId");
			System.out.println("ck::::"+empid);
			boolean flag=audBussiness.checkemp(((Stat)list.get(0)).getStatNo(), empid);
			System.out.println("saleActionflag:::::"+flag);
			if(flag){
				request.setAttribute("mark", "mark");
			}
			boolean flag1=audBussiness.checkemp1(((Stat)list.get(0)).getStatNo(), empid);
			if(flag1)
			{
				request.setAttribute("quanxian", "quanxian");
			}
		
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(((Stat)list.get(0)).getStatNo()!=null){
				String addhql2=" and orderNo='"+((Stat)list.get(0)).getStatNo()+"'";
				
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
		}
		
		return "detail";
	}
	
	/**
	 * 进入添加盘点单
	 */
	public String addshow()
	{
		System.out.println("addShow");
		String ckNo="PD-"+serial.getSerialNumber();
		request.setAttribute("PDNo", ckNo);
		return "add";
	}
	
	/**
	 * 根据mark显示对话框
	 * @return
	 */
	public String showDialog()
	{
		System.out.println("showDialog");
		System.out.println("request:"+request);
		System.out.println("depotBussiness"+depotBussiness);
		String mark=request.getParameter("mark");
		System.out.println("mark:"+mark);
		//页码
		String pageNoS = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		int pageNo=Integer.parseInt(pageNoS);
		//仓库对话框
		if(mark.equals("depot")){
			String hql="from Depot where del = 0 ";
			
			String name = request.getParameter("cname");
			if(name !=null && !name.equals(""))
			{
				hql +=" and name like '%"+name+"%'";
			}
			hql+=" order by id desc";
			Pages pages=depotBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages", pages);
			return "showDepotDialog";
		}
		else if(mark.equals("employee")){
			String hql="from Employee where delflag=0";
			String name = request.getParameter("ename");
			if(name !=null && !name.equals(""))
			{
				hql +=" and name like '%"+name+"%'";
			}
			hql+="order by id desc";
			Pages pages=empBussiness.paginationQuery(hql, pageNo, 10, null);
			request.setAttribute("pages",pages);
			return "showemployeeDialog";
		}
		return null;
	}
	
	/**
	 * 添加盘点单
	 */
	public String add()
	{
		System.out.println("add");
		boolean flag=this.addAndedit("add");
		try
		{
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			logger.error("添加采购订单时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 添加或修改盘点单
	 * @param addOredit
	 * @return
	 */
	public boolean addAndedit(String addOredit)
	{
		String fmark=ck.getCookie(request, "filialemark");
		try {
			stat.setStatType(URLDecoder.decode(stat.getStatType(),"utf-8"));
			stat.setRemark(URLDecoder.decode(stat.getRemark(),"utf-8"));
			stat.setAuditingState("0");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		boolean flag=false;
		if(addOredit.equals("add"))
		{
			Stat st = statbussiness.addReturnStat(stat);
			if(null != st)
			{
				flag = true;
				audBussiness.addAuditingOrder("PD",stat.getStatNo(),"Stat",fmark);
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个库存盘点单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(st.getId().toString());
					executerecord.setEntityName("Stat");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
			}else{
				flag = false;
			}
			
		}
		else
		{
			flag=statbussiness.editStat(stat);
			String cid=request.getParameter("id");
			if(cid!=null)
			{
				statbussiness.delStatInfo(" and statId="+cid);
				System.out.println("删除了");
			}
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个库存盘点单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(stat.getId().toString());
				executerecord.setEntityName("Stat");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		}
		System.out.println(434334);
		boolean flag2=false;
		if(flag)
		{
			System.out.println("进入Info");
			String[] modes=mode.split("-");
			String[] factcounts=factcount.split("-");
			String[] datacounts=datacount.split("-");
			String[] counts=count.split(",");
			String[] markInfos=markInfo.split("-");
			for(int i=0;i<modes.length;i++)
			{
				System.out.println("进入循环");
				StatInfo statinfo=new StatInfo();
				Model mod=new Model();
				mod.setModel(Integer.parseInt(modes[i]));
				statinfo.setModel(mod);
				statinfo.setStat(stat);
				statinfo.setProfitOrloss(Integer.parseInt(counts[i]));
				statinfo.setDatacount(Integer.parseInt(datacounts[i]));
				statinfo.setFactcount(Integer.parseInt(factcounts[i]));
				System.out.println("markInfoLeng:"+markInfos.length);
				if(markInfos.length>0)
				{
					System.out.println("marker"+i+":"+markInfos[i]);
					if(!markInfos[i].equals("")&&markInfos!=null)
					{
						try {
							statinfo.setRemark(URLDecoder.decode(markInfos[i],"utf-8"));
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
				}
				flag2=statbussiness.addStatInfo(statinfo);
				System.out.println("info:"+flag2);
			}
		}
		if(flag&&flag2)
			return true;
		return false;
	}
	
	/**
	 * 修改显示页面
	 */
	public String updateShow()
	{
		System.out.println("updateShow");
		String cid=request.getParameter("cid");
		Stat stat=(Stat) statbussiness.someStat(" and id="+cid).get(0);
		System.out.println("stat:"+stat);
		request.setAttribute("oneStat", stat);
		return "add";
	}
	
	/**
	 * 修改盘点单
	 */
	public String edit()
	{
		boolean flag=this.addAndedit("edit");
		try
		{
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			logger.error("修改盘点单时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据盘点详细id删除盘点单中的盘点详细信息
	 * @return
	 */
	public String delInfo()
	{
		String infoId=request.getParameter("infoId");
		if(infoId!=null)
		{
			String addhql=" and id="+Integer.parseInt(infoId);
			boolean flag=statbussiness.delStatInfo(addhql);
			System.out.println("flag"+flag);
			try
			{
				if(flag)
					response.getWriter().print("0");
				else
					response.getWriter().print("1");
			}
			catch(Exception ex)
			{
				logger.error("删除盘点详细时出错",ex);
				ex.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 删除多个指定Id盘点单
	 */
	public String del()
	{
		boolean flag=false;
		try
		{
			flag=statbussiness.delStat(ids);
			if(flag){
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一些盘点单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Stat");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				response.getWriter().print("0");
			}
			else{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			logger.error("删除多个指定Id出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	

	

}
