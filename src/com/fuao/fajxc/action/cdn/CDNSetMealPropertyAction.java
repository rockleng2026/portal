package com.fuao.fajxc.action.cdn;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.cdn.SetMealPropertyBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.SetMeal;
import com.fuao.fajxc.vo.SetMealProperty;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 套餐属性action
 * @author 阙超强 14015
 *@time 2012-02-01 15:03:28
 */
public class CDNSetMealPropertyAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private SetMealProperty setMealProperty;
	private SetMealPropertyBussiness setMealPropertyBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;
	

	/*
	 *添加套餐属性
	 */
	public String add(){
		//拿到登陆员工用户  判断登录信息是否存在
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		if(null == loginEmp){
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}
		
		//添加
		setMealProperty.setHitnum(Integer.parseInt(setMealProperty.getFlow())*Integer.parseInt(setMealProperty.getBandwidth())+"");
		SetMealProperty sMealProperty = setMealPropertyBussiness.addSetMealProperty(setMealProperty);
		if(null == sMealProperty){
			request.setAttribute("errorMsg", "添加套餐属性失败，请重试！");
			return "no";
		}
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个CDN套餐属性。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(sMealProperty.getId().toString());
			executerecord.setEntityName("SetMealProperty");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "success";
	}
	
	/*
	 * 删除套餐属性（软删除）
	 */
	public void del(){
		
		try {
			String id = request.getParameter("id")==null?null:request.getParameter("id");
			SetMealProperty setMealProperty = setMealPropertyBussiness.findSetMealPropertyById(Integer.parseInt(id));
			setMealProperty.setDelflag(1);
			String hql="update SetMealProperty set delflag=1 where id="+setMealProperty.getId()+"";
			int aa = setMealPropertyBussiness.updataByHQL(hql);
			if(aa==0){
					response.getWriter().print(0);
					return;
			}
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一个CDN套餐属性。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(id);
				executerecord.setEntityName("SetMealProperty");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			response.getWriter().print(1);
		} catch (IOException e) {
			try {
				response.getWriter().print(0);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	/*
	 *修改套餐属性
	 */
	public String update(){
		//拿到登陆员工用户  判断登录信息是否存在
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		if(null == loginEmp){
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}
		
		//执行修改
		String hql="update SetMealProperty set name='"+setMealProperty.getName()+"' " +
				" , flow='"+setMealProperty.getFlow()+"'" +
				" , flow1='"+setMealProperty.getFlow1()+"'" +
				" , flow2='"+setMealProperty.getFlow2()+"'" +
				" , flow3='"+setMealProperty.getFlow3()+"'" +
				" , flow4='"+setMealProperty.getFlow4()+"'" +
				" , bandwidth='"+setMealProperty.getBandwidth()+"'" +
				" , bandwidth1='"+setMealProperty.getBandwidth1()+"'" +
				" , bandwidth2='"+setMealProperty.getBandwidth2()+"'" +
				" , bandwidth3='"+setMealProperty.getBandwidth3()+"'" +
				" , bandwidth4='"+setMealProperty.getBandwidth4()+"'" +
				" , hitnum="+Integer.parseInt(setMealProperty.getFlow())*Integer.parseInt(setMealProperty.getBandwidth())+"" +
				" , hitnum1='"+setMealProperty.getHitnum1()+"'" +
				" , hitnum2='"+setMealProperty.getHitnum2()+"'" +
				" , hitnum3='"+setMealProperty.getHitnum3()+"'" +
				" , hitnum4='"+setMealProperty.getHitnum4()+"'" +
				"where id="+setMealProperty.getId()+"";
		int aa = setMealPropertyBussiness.updataByHQL(hql);
		
		if(aa==0){
			request.setAttribute("errorMsg", "修改套餐属性失败，请重试！");
			return "no";
		}
		
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("修改了一个CDN套餐属性。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(setMealProperty.getId()+"");
			executerecord.setEntityName("SetMealProperty");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "success";
	}
	
	/*
	 * 跳转至 详细信息页面/修改页面
	 * @return
	 */
	public String deal(){
		//获得单个套餐对象
		String id = request.getParameter("id")==null?null:request.getParameter("id");
		SetMealProperty setMealProperty = setMealPropertyBussiness.findSetMealPropertyById(Integer.parseInt(id));
		
		request.setAttribute("data", setMealProperty);
		
		//获得类型   （修改/查看详细）
		String type = request.getParameter("type")==null?null:request.getParameter("type");
		
		return ("update".equals(type))?"goUpdate":"goInfo";
	}
	
	/*
	 * 跳转至列表页
	 */
	public String getAll() throws IOException{
		//获得页面标签数
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		
		//定义hql查询语句
		String hql = "From SetMealProperty where delflag=0 ";
		
		//拿到条件查询
		Object pnObject = request.getParameter("propertyName");
		if(null != pnObject){
			hql += " and name like '%" + pnObject.toString() + "%' ";
		}
		
		/*字段查找*/
		if(null != setMealProperty.getId() && !"".equals(setMealProperty.getId())){
			hql += " and id like '%"+URLDecoder.decode(setMealProperty.getId().toString(),"UTF-8")+"%'";
		}
		if(null != setMealProperty.getName() && !"".equals(setMealProperty.getName())){
			hql += " and name like '%"+URLDecoder.decode(setMealProperty.getName(),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getFlow()) && setMealProperty.getFlow()!=null){
			hql += " and flow like '%"+setMealProperty.getFlow()+"%'";
		}
		if(!"".equals(setMealProperty.getBandwidth()) && setMealProperty.getBandwidth()!=null){
			hql += " and bandwidth like '%"+setMealProperty.getBandwidth()+"%'";
		}
		if(null != setMealProperty.getHitnum() && !"".equals(setMealProperty.getHitnum())){
			hql += " and hitnum like '%"+URLDecoder.decode(setMealProperty.getHitnum().toString(),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getFlow1()) && setMealProperty.getFlow1()!=null){
			hql += " and flow1 like '%"+setMealProperty.getFlow1()+"%'";
		}
		if(!"".equals(setMealProperty.getFlow2()) && setMealProperty.getFlow2()!=null ){
			hql += " and flow2 like '%"+URLDecoder.decode(setMealProperty.getFlow2(),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getFlow3()) && setMealProperty.getFlow3() != 0.0){
			hql += " and flow3 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getFlow3())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getFlow4()) && setMealProperty.getFlow4() != 0.0){
			hql += " and flow4 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getFlow4())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getBandwidth1()) && setMealProperty.getBandwidth1() != 0.0){
			hql += " and bandwidth1 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getBandwidth1())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getBandwidth2()) && setMealProperty.getBandwidth2() != 0.0){
			hql += " and bandwidth2 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getBandwidth2())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getBandwidth3()) && setMealProperty.getBandwidth3() != 0.0){
			hql += " and bandwidth3 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getBandwidth3())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getBandwidth4()) && setMealProperty.getBandwidth4() != 0.0){
			hql += " and bandwidth4 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getBandwidth4())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getHitnum1()) && setMealProperty.getHitnum1() != 0.0){
			hql += " and hitnum1 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getHitnum1())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getHitnum2()) && setMealProperty.getHitnum2() != 0.0){
			hql += " and hitnum2 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getHitnum2())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getHitnum3()) && setMealProperty.getHitnum3() != 0.0){
			hql += " and hitnum3 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getHitnum3())),"UTF-8")+"%'";
		}
		if(!"".equals(setMealProperty.getHitnum4()) && setMealProperty.getHitnum4() != 0.0){
			hql += " and hitnum4 like '%"+URLDecoder.decode(String.valueOf(Math.round(setMealProperty.getHitnum4())),"UTF-8")+"%'";
		}
		
		//分页查询
		Pages pages = setMealPropertyBussiness.exePagesList(hql, Integer.parseInt(pageNo), 20, null);
		
		//字段查找
		if(request.getParameter("tage") != null && request.getParameter("tage").equals("y")){
			PropertyEditor property = new PropertyEditor();
			String strr="";
			String str="";
			if(null != pages.getPageList() && pages.getPageList().size()>0)
			{
				for(int i=0; i<pages.getPageList().size(); i++)
				{
					SetMealProperty sMealProperty = new SetMealProperty();
					sMealProperty =(SetMealProperty)pages.getPageList().get(i);
					str = property.getID("selectSetMealProperty").toString();
				    str = str.replace("#id#", sMealProperty.getId()+"");
					str = str.replace("#name#", sMealProperty.getName());
					str = str.replace("#flow#", sMealProperty.getFlow()+"");
					str = str.replace("#bandwidth#", sMealProperty.getBandwidth()+"");
					str = str.replace("#hitnum#", sMealProperty.getHitnum()+"");
					str = str.replace("#flow1#", sMealProperty.getFlow1()+"");
					str = str.replace("#flow2#", sMealProperty.getFlow2()+"");
					str = str.replace("#flow3#", sMealProperty.getFlow3()+"");
					str = str.replace("#flow4#", sMealProperty.getFlow4()+"");
					str = str.replace("#bandwidth1#", sMealProperty.getBandwidth1()+"");
					str = str.replace("#bandwidth2#", sMealProperty.getBandwidth2()+"");
					str = str.replace("#bandwidth3#", sMealProperty.getBandwidth3()+"");
					str = str.replace("#bandwidth4#", sMealProperty.getBandwidth4()+"");
					str = str.replace("#hitnum1#", sMealProperty.getHitnum1()+"");
					str = str.replace("#hitnum2#", sMealProperty.getHitnum2()+"");
					str = str.replace("#hitnum3#", sMealProperty.getHitnum3()+"");
					str = str.replace("#hitnum4#", sMealProperty.getHitnum4()+"");
					strr +=str;		
				}
				pages.setUrl("getAllCDNSetMealPropertyAction.do");
				strr+="#"+pages.getHtml("selectSetMealProperty");
			}
		   response.setCharacterEncoding("utf-8");
		   response.getWriter().print(strr);
		   return null;
		}
		
		request.setAttribute("pages", pages);
		return "goAllList";
	}
	
	/*
	 * 跳转至添加页面goAddCDNSetMealPropertyAction
	 * */
	public String goAdd(){
		
		return "goAdd";
	}
	
	/*属性封装*/
	public SetMealProperty getSetMealProperty() {
		return setMealProperty;
	}
	public void setSetMealProperty(SetMealProperty setMealProperty) {
		this.setMealProperty = setMealProperty;
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
	
	public SetMealPropertyBussiness getSetMealPropertyBussiness() {
		return setMealPropertyBussiness;
	}
	public void setSetMealPropertyBussiness(
			SetMealPropertyBussiness setMealPropertyBussiness) {
		this.setMealPropertyBussiness = setMealPropertyBussiness;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}
	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
	/*模型驱动*/
	public Object getModel() {
		setMealProperty = new SetMealProperty();
		return setMealProperty;
	}
	/*request*/
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}
	/*response*/
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

}
