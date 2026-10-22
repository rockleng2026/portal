package com.fuao.fajxc.action.form;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.form.FormTempBussiness;
import com.fuao.fajxc.bussiness.system.DocmentBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.FormTemp;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 单据模板
 * **/
public class FormTempAction  implements ServletRequestAware,ServletResponseAware,ModelDriven{
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private FormTempBussiness formtempbussiness;
	private FormTemp formtemp;
	private DocmentBussiness docbussiness;
	static Log log = LogFactory.getLog(FormTempAction.class);

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

	public FormTempBussiness getFormtempbussiness() {
		return formtempbussiness;
	}

	public void setFormtempbussiness(FormTempBussiness formtempbussiness) {
		this.formtempbussiness = formtempbussiness;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public DocmentBussiness getDocbussiness() {
		return docbussiness;
	}

	public void setDocbussiness(DocmentBussiness docbussiness) {
		this.docbussiness = docbussiness;
	}

	public Object getModel() {
		formtemp=new FormTemp();
		return formtemp;
	}
	
	public String markadd()
	{
		String aname=request.getParameter("aname");
		String mark=request.getParameter("mark");
		if(aname==null||"".equals(aname))
		{
			request.setAttribute("Message", "请输入审核类型！");
			return "error";
		}
		if(mark==null||"".equals(mark))
		{
			request.setAttribute("Message", "请输入审核标识符！");
			return "error";
		}
		///添加到审核表的docmark表
		Docmark docmark=new Docmark();
		docmark.setAname(aname);
		docmark.setMark(mark);
		docmark.setTemp1("FormTemp");
		docbussiness.addDoc(docmark);
		return "marksuccess";
	}
	/**
	 * 显示增加单据模板页面
	 * **/
	public String readadd()
	{
		try{
			String addhql=" and  temp1='FormTemp' ";
			List doclist=docbussiness.selDocmark(addhql);
			request.setAttribute("doclist", doclist);
		}catch(Exception e)
		{
			log.debug(e);
		}
		
		return "showadd";
	}
	/**
	 * 增加单据模板
	 * **/
	public String add()
	{
		Object object =  request.getSession().getAttribute("emp");
		Employee employee = null;
		if(null != object){
			employee = (Employee) object;
		}else{
			request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
			return "no";
		}
		formtemp.setEmployee(employee);		
		formtemp=formtempbussiness.addReturnFormTemp(formtemp);
		//添加记录到动态记录表
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(employee);
		executerecord.setContent("添加了一个名为"+formtemp.getTypeName()+"的单据模板。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(formtemp.getId().toString());
		executerecord.setEntityName("FormTemp");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		//添加完模板，即跳到模板列表
		return "selectmore";
	}
	/**
	 * 删除单据模板  软删除
	 * **/
	public String delruan()
	{
		Object object =  request.getSession().getAttribute("emp");
		Employee employee = null;
		if(null != object){
			employee = (Employee) object;
		}else{
			request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
			return "no";
		}
		String id=request.getParameter("id");
		FormTemp ft=formtempbussiness.selectFormTemp(Integer.parseInt(id));
		formtempbussiness.delruanFormTemp(ft);
		//添加记录到动态记录表
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(employee);
		executerecord.setContent("删除了一个名为"+ft.getTypeName()+"的单据模板。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(ft.getId().toString());
		executerecord.setEntityName("FormTemp");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		//删除完模板，即跳到模板列表
		return "selectmore";
	}
	/**
	 * 删除单据模板  硬删除
	 * **/
	public String delying()
	{
		String id=request.getParameter("id");
		FormTemp ft=formtempbussiness.selectFormTemp(Integer.parseInt(id));
		formtempbussiness.delyingFormTemp(ft);
		//删除完模板，即跳到模板列表
		return "selectmore";
	}
	
	/**
	 * 显示修改单据模板
	 * **/
	public String editshow()
	{
		String id=request.getParameter("id");
		FormTemp ft=formtempbussiness.selectFormTemp(Integer.parseInt(id));
		request.removeAttribute("temp");
		request.setAttribute("temp", ft);
		String addhql=" and  temp1='FormTemp' ";
		List<Docmark> doclist=docbussiness.selDocmark(addhql);
		for(Docmark d:doclist)
		{
			if(d.getMark().equals(ft.getMark()))
			{
				request.setAttribute("TName", d.getAname());
				break;
			}
		}
		String str=StitchingStr(ft.getTemp());
		request.setAttribute("pingstr", str);
		request.setAttribute("doclist", doclist);
		//在增加模板页面显示
		return "edit";
	}
	/**
	 * 修改单据模板
	 * **/
	public String editupdate()
	{
		Object object =  request.getSession().getAttribute("emp");
		Employee employee = null;
		if(null != object){
			employee = (Employee) object;
		}else{
			request.setAttribute("errorMsg", "由于您长时间未活动请重新登录！");
			return "no";
		}
		if("__".equals(formtemp.getMark()))
		{
			formtemp.setMark(request.getParameter("oldmark"));
		}
		FormTemp ft=formtempbussiness.editReturnFormTemp(formtemp);
		request.removeAttribute("formtemp");
		request.getSession().removeAttribute("formtemp");
		//添加记录到动态记录表
		Executerecord executerecord = new Executerecord();
		executerecord.setEmployee(employee);
		executerecord.setContent("修改了一个名为"+ft.getTypeName()+"的单据模板。");
		executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
		executerecord.setEntityId(ft.getId().toString());
		executerecord.setEntityName("FormTemp");
		executerecord.setSeenEmpId("");
		executeRecordBussiness.addData(executerecord);
		//修改完模板，即跳到模板列表
		return "selectmore";
	}
	/**
	 * 查看一个单据模板
	 * **/
	public String selectone()
	{
		String id=request.getParameter("id");
		FormTemp aformtemps=formtempbussiness.selectFormTemp(Integer.parseInt(id));
		//html代码转换
		StringBuffer sb=new StringBuffer(aformtemps.getCode());
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
			if(m==0)break;
		}
		aformtemps.setCode(sb.toString());
		request.setAttribute("formtemp", aformtemps);
		// 查看一个单据模板
		return "showone";
	}
	/**
	 * 模糊查找单据模板
	 * **/
	public String selectonetemp()
	{
		String namestr=request.getParameter("namestr");
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		String hql=" from FormTemp where delflag=0 and typeName like '%"+namestr+"%'  order by id desc";
		Pages pages=formtempbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		//查询符合条件的模板，显示到页面
		return "selectmorelist";
	}
	/**
	 * 查看所有单据模板     列表
	 * **/
	public String selectmore()
	{
		String pageNo=request.getParameter("pageNo");
		if(pageNo==null||"".equals(pageNo))
			pageNo="1";
		String hql=" from FormTemp where delflag=0  order by id desc";
		Pages pages=formtempbussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		//查询所有模板，显示到页面
		return "selectmorelist";
	}
	/**
	 * 拼接字符串
	 * **/
	public String  StitchingStr(String str)
	{
		if(str==null||"".equals(str))
			return "";
		//拼接字符串，temp1 .....    temp50..... temp100
		String strtemp[]=str.split("#");
		StringBuffer  newstr=new StringBuffer();
		for(int i=0;i<strtemp.length;i++)
		{
			newstr.append("<div class='ziduan_ming billziduan' >temp"+(i+1)+"&nbsp;&nbsp;&nbsp;&nbsp;<input name='temp"+(i+1)+"' id ='temp"+(i+1)+"' value='"+strtemp[i]+"'/></div>");
		}
		return newstr.toString();
	}
}