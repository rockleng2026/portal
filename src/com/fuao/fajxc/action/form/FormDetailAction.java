package com.fuao.fajxc.action.form;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.form.FormDetailBussiness;
import com.fuao.fajxc.bussiness.form.FormTempBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.FormDetail;
import com.fuao.fajxc.vo.FormTemp;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 详细单据
 * **/
public class FormDetailAction  implements ServletRequestAware,ServletResponseAware,ModelDriven{
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private FormDetailBussiness formdetailbussiness;
	private FormTempBussiness formtempbussiness;
	private FormDetail formdetail;
	private AuditingBussiness audBussiness;//核审
	Cookies ck = new Cookies();
	//记录动态service
	public ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
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

	public FormDetailBussiness getFormdetailbussiness() {
		return formdetailbussiness;
	}

	public void setFormdetailbussiness(FormDetailBussiness formdetailbussiness) {
		this.formdetailbussiness = formdetailbussiness;
	}
	
	

	public FormTempBussiness getFormtempbussiness() {
		return formtempbussiness;
	}

	public void setFormtempbussiness(FormTempBussiness formtempbussiness) {
		this.formtempbussiness = formtempbussiness;
	}

	public FormDetail getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(FormDetail formdetail) {
		this.formdetail = formdetail;
	}
	
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public Object getModel() {
		formdetail=new FormDetail();
		return formdetail;
	}
	/**
	 * 获得当前登录员工信息
	 * @return
	 * @time 2012-01-10 14:14:10
	 */
	public Employee getEmp(){
		Object object = request.getSession().getAttribute("emp");
		Employee loginEmp = null; 
		if(null != object){
			loginEmp = (Employee) object;
		}
		return loginEmp;
	}
	
	/**
	 * 增加详细单据的页面显示
	 * 
	 * **/
	public String readadd()
	{
		String formtempid=request.getParameter("id");
		if(formtempid!=null&&!"".equals(formtempid))
		{
			FormTemp formtemp=formtempbussiness.selectFormTemp(Integer.parseInt(formtempid));
			//html代码转换
			formtemp=htmlprocessing(formtemp,null);
			request.setAttribute("formtemp", formtemp);
			request.setAttribute("showflag", "yes");
		}else{
			request.removeAttribute("formtemp");
		}
		//查询出来所有的模板，并放在列表中
		String formtemplisthql=" from FormTemp where delflag=0 ";
		List<FormTemp>	formtemplist=formtempbussiness.selectFormTemp(formtemplisthql);
		request.setAttribute("formtemplist", formtemplist);
		//跳转到增加formdetail页面   addformdetail.jsp
		return "addformdetail";
	}
	/**
	 * 增加详细单据
	 * **/
	public String add()
	{
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		Employee loginEmp = this.getEmp();
		if(null == loginEmp){
			request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
			return "no";
		}
		String formtempid=request.getParameter("formtempid");
		FormTemp formtemp=formtempbussiness.selectFormTemp(Integer.parseInt(formtempid));
		formdetail.setFormtemp(formtemp);
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
		String no=serial.getSerialNumber();
		formdetail.setOrderNo(formtemp.getMark()+no);
		formdetail.setAudtitingFlag(0);
		formdetail.setEmployee(loginEmp);
		formdetail = formdetailbussiness.addReturn(formdetail);
		if(null == formdetail){
			request.setAttribute("errorMsg", "添加单据失败，请重试！");
			return "no";
		}
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(loginEmp);
		executerecord.setContent("添加了一个"+formdetail.getFormtemp().getTypeName()+"单据详细。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(formdetail.getId().toString());
		executerecord.setEntityName("FormDetail");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		///添加审核
		int marker = audBussiness.addAuditingOrder2(formdetail.getFormtemp().getMark(),formdetail.getOrderNo(),"FormDetail",ck.getCookie(request, "filialemark"));
		//当插入审核流程的方法返回0是 代表该单据没有审核流程 修改单据的审核状态为审核通过
		if(marker==0)
		{
			formdetail.setAudtitingFlag(1);
			formdetailbussiness.editFormDetail(formdetail);
		}
		request.setAttribute("formtemp", formtemp);//模板
		// 查看一个单据模板下的所有详细单据 v显示到页面
		return "selectonelist";
	}
	
	/**
	 * 删除详细单据  软删除
	 * **/
	public String delruan()
	{
		//添加记录到动态记录表
		Employee loginEmp = this.getEmp();
		if(null == loginEmp){
			request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
			return "no";
		}
		String formdetailid=request.getParameter("id");
		FormDetail formdetail=formdetailbussiness.selectFormDetail(Integer.parseInt(formdetailid));
		formdetailbussiness.delruanFormDetail(formdetail);
		request.setAttribute("formtemp", formdetail.getFormtemp());
		// 查看一个单据模板下的所有详细单据 v显示到页面
		/*阙超强 14015   添加记录动态信息*/
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(loginEmp);
		executerecord.setContent("删除了一个"+formdetail.getFormtemp().getTypeName()+"单据详细。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(formdetailid);
		executerecord.setEntityName("FormDetail");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		return "selectonelist";
	}
	
	/**
	 * 删除详细单据  硬删除  彻底删除
	 * **/
	public String delying()
	{
		String formdetailid=request.getParameter("id");
		FormDetail formdetail=formdetailbussiness.selectFormDetail(Integer.parseInt(formdetailid));
		formdetailbussiness.delyingFormDetail(formdetail);
		request.setAttribute("formtemp", formdetail.getFormtemp());
		// 查看一个单据模板下的所有详细单据 v显示到页面
		return "selectonelist";
	}
	
	/**
	 * 显示修改详细单据页面  
	 * **/
	public String editshow()
	{
		String formdetailid=request.getParameter("id");
		FormDetail formdetail=formdetailbussiness.selectFormDetail(Integer.parseInt(formdetailid));
		FormTemp formtemp=formdetail.getFormtemp();
		//html代码转换
		formtemp=htmlprocessing(formtemp,formdetail);
		formdetail.setFormtemp(formtemp);
		request.setAttribute("showmark", "xiugai");
		request.setAttribute("formdetail", formdetail);
		//跳到查年详细单据页面    可以共用一个页面
		return "showone";
	}
	/**
	 * 执行修改详细单据
	 * **/
	public String editupdate()
	{
		//添加记录到动态记录表
		Employee loginEmp = this.getEmp();
		if(null == loginEmp){
			request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
			return "no";
		}
		String formtempid=request.getParameter("formtempid");
		FormTemp formtemp=formtempbussiness.selectFormTemp(Integer.parseInt(formtempid));
		FormDetail fd=formdetailbussiness.selectFormDetail(formdetail.getId());
		formdetail.setEmployee(fd.getEmployee());
		formdetail.setFormtemp(formtemp);
		formdetailbussiness.editFormDetail(formdetail);
		request.setAttribute("formtemp", formtemp);
		
		/*阙超强 14015   添加记录动态信息*/
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(loginEmp);
		executerecord.setContent("修改了一个"+formdetail.getFormtemp().getTypeName()+"单据详细。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(formdetail.getId().toString());
		executerecord.setEntityName("FormDetail");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		// 查看一个单据模板下的所有详细单据 v显示到页面
		return "selectonelist";
	}
	
	/**
	 * 查看一个详细单据
	 * **/
	public String selectone()
	{
		/////0：未审  1：审核同意  2 ：审核拒绝 3：已提交上架;8:接收
		String formdetailid=request.getParameter("id");
		FormDetail formdetail=formdetailbussiness.selectFormDetail(Integer.parseInt(formdetailid));
		FormTemp formtemp=formdetail.getFormtemp();
		//html代码转换
		formtemp=htmlprocessing(formtemp,formdetail);
		formdetail.setFormtemp(formtemp);
		request.setAttribute("formdetail", formdetail);
		request.setAttribute("showmark", "chakan");
		//查找所对应的核审状况
		String empid=ck.getCookie(request, "employeeId");
		//审核流程
		String addhql2=" and orderNo='"+formdetail.getOrderNo()+"'";
		List audList=audBussiness.someauditingOrder(addhql2);
		request.setAttribute("auditingList", audList);
		boolean flag1=audBussiness.checkemp1(formdetail.getOrderNo(), empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");///有权限接收与审核
			boolean flag=audBussiness.checkemp(formdetail.getOrderNo(), empid);
			if(flag)
				request.setAttribute("mark", "mark");///可以接收吗？
			else{
				if(null != audList && audList.size()>0)
				{
					String depid = ck.getCookie(request, "departmentId");
					for(int i=0; i<audList.size(); i++)
					{
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 )
						{
							//表示未审核
							request.setAttribute("flage", 0);
						}else if(aot.getDepartment().getId() == Integer.parseInt(depid)&&
								(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2))
						{
							//表示已经审核
							request.setAttribute("flage", 1);
							request.setAttribute("aot", aot);
						}
					}
				}
			}
		}
		//查看一个详细单据
		return "showone";
	}
	
	/**
	 * 查看一个单据模板下的所有详细单据
	 * **/
	public String selectformmore()
	{
		String page=request.getParameter("pageNo");
		FormTemp formtemp=null;
		Object object = null;
		if(page!=null&&!"".equals(page))
			object=request.getSession().getAttribute("formtemp");
		Object ob2=request.getAttribute("formtemp");
		String id=request.getParameter("id");
		if(id!=null&&!"".equals(id))
		{	
			formtemp=(FormTemp)formtempbussiness.selectFormTemp(Integer.parseInt(id));
		}
		else if(null!=ob2)
		{
			formtemp=(FormTemp)ob2;
		}else if(null!=object){
			formtemp=(FormTemp)object;
		}else{
			//没有模板怎么办？  没有就不进行查询，不显示
		}
		if(formtemp!=null)///有模板的选择，查询该模板下的所有单
		{
			formtemp=htmlprocessing(formtemp,null);
			request.setAttribute("formtemp", formtemp);
			if((page!=null&&!"".equals(page))||(id!=null&&!"".equals(id)))
				request.getSession().setAttribute("formtemp", formtemp);
			else request.getSession().removeAttribute("formtemp");
			
			String hql=" from FormDetail where formtemp.id="+formtemp.getId()+"  and  delflag=0  order by id  desc  ";
			String pageNo=request.getParameter("pageNo");
			if(pageNo==null||"".equals(pageNo))
				pageNo="1";
			Pages pages=formdetailbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			request.setAttribute("flag", "yes");
		}
		//查询出来所有的模板，并放在列表中
		String formtemplisthql=" from FormTemp where delflag=0 ";
		List<FormTemp> formtemplist=formtempbussiness.selectFormTemp(formtemplisthql);
		request.setAttribute("formtemplist", formtemplist);
		// 查看一个单据模板下的所有详细单据 v显示到页面
		return "selectmorelist";
	}
	
	/**
	 * 查看所有详细单据    列表   不分类
	 * **/
	public String selectallmore()
	{
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		String hql=" from FormDetail where delflag=0  order by id desc";
		Pages pages=formdetailbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		//查询所有详细单据，显示到页面
		return "selectalllist";
	}
	
	/**
	 * html代码转换方法
	 * **/
	public FormTemp htmlprocessing(FormTemp formtemp,FormDetail formdetail)
	{
		StringBuffer sb=new StringBuffer(formtemp.getCode());
		if(formdetail!=null)
		{
			String str[]=formdetail.getTemp().split("#");
			for(int i=0;i<str.length;i++)
			{
				String ss="#temp"+(i+1)+"#";
				String mm=str[i];
				int n=sb.indexOf(ss);
				int le=ss.length();
				while(n>-1)
				{
					sb.replace(n, n+le, mm);
					n=sb.indexOf(ss);
				}
			}
		}
		else{
			for(int i=1;;i++)
			{
				String ss="#temp"+i+"#";
				String mm="";
				int n=sb.indexOf(ss);
				int le=ss.length();
				int m=0;
				while(n>-1)
				{
					m++;
					sb.replace(n, n+le, mm);
					n=sb.indexOf(ss);
				}
				if(m==0)
					break;
			}
		}
		formtemp.setCode(sb.toString());
		return formtemp;
	}
	public static void main(String[] args) {
		String xx = "技术部# #2012-6-29#现金##1000# # # #";
		String[] yy = xx.split("#");
		for (int i = 0; i < yy.length; i++) {
			System.out.print(yy[i]);
		}
	}
}