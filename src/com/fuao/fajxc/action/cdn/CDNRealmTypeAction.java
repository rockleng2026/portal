package com.fuao.fajxc.action.cdn;


import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.cdn.RealmTypeBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.RealmType;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author 阙超强 14015
 * @time 2012-02-06 10:18:50
 * CDN套餐的域类型action
 */
public class CDNRealmTypeAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
	private RealmType realmType;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private RealmTypeBussiness realmTypeBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;

	/*模型驱动*/
	public Object getModel() {
		realmType = new RealmType();
		return realmType;
	}
	/*request*/
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}
	/*response*/
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}
	
	/**
	 * 获得所有 跳转列表页
	 * @return
	 * @throws IOException 
	 */
	public String getAll() throws IOException{
		//获得页面标签数
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		
		//定义hql查询语句
		String hql = "From RealmType where delFlag = 0 ";
		
		//拿到条件查询
		Object smnObject = request.getParameter("typeName");
		if(null != smnObject){
			hql += " and name like '%" + smnObject.toString() + "%' ";
		}
		
		//是否为字段查找的判断
		if(null != realmType.getId() && !"".equals(realmType.getId())){
			hql += " and id like '%"+URLDecoder.decode(realmType.getId().toString(),"UTF-8")+"%'";
		}
		if(null != realmType.getName() && !"".equals(realmType.getName())){
			hql += " and name like '%" + URLDecoder.decode(realmType.getName(),"UTF-8") + "%' ";
		}
		
		//分页查找
		Pages pages = realmTypeBussiness.exePagesList(hql, Integer.parseInt(pageNo), 20, null);
		
		//字段查找
		if(request.getParameter("tage") != null && request.getParameter("tage").equals("y")){
			PropertyEditor property = new PropertyEditor();
			String strr="";
			String str="";
			if(null != pages.getPageList() && pages.getPageList().size()>0)
			{
				for(int i=0; i<pages.getPageList().size(); i++)
				{
					RealmType rType = new RealmType();
					rType =(RealmType)pages.getPageList().get(i);
					str = property.getID("selectRealmType").toString();
				    str = str.replace("#id#", rType.getId()+"");
					str = str.replace("#name#", rType.getName());
					strr +=str;		
				}
				pages.setUrl("getAllCDNRealmTypeAction.do");
				strr+="#"+pages.getHtml("selectRealmType");
			}  
		   response.setCharacterEncoding("utf-8");
		   response.getWriter().print(strr);
		   return null;
		}
		
		request.setAttribute("pages", pages);
		return "goAllList";
	}
	
	/**
	 * 添加类型
	 * @return
	 */
	public String add(){
		//拿到登陆员工用户  判断登录信息是否存在
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		if(null == loginEmp){
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}
		
		//执行添加
		RealmType rType = (RealmType) realmTypeBussiness.addObject(realmType);
		//添加失败 至错误页面
		if(null == rType){
			request.setAttribute("errorMsg", "修改出现错误，请重试！");
			return "no";
		}
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个CDN域名类型。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(rType.getId().toString());
			executerecord.setEntityName("RealmType");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "success";
	}
	
	/**
	 * 删除（软删除）
	 * @return
	 */
	public void del(){
		try {
			//拿到登陆员工用户  判断登录信息是否存在
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			if(null == loginEmp){
				response.getWriter().print(0);
				return;
			}
			
			//获得需要删除的id，对象
			String id = request.getParameter("id")==null?null:request.getParameter("id");
			RealmType rType = null;
			if(null != id){
				RealmType realmType = (RealmType) realmTypeBussiness.findObjectById("RealmType", Integer.parseInt(id));
				//设置删除标记为1 表示已经删除
				realmType.setDelflag(1);
				//执行删除（修改）
				rType = (RealmType) realmTypeBussiness.updataObject(realmType);
			}
			
			if(null == rType){
				//删除失败返回0
				response.getWriter().print(0);
				return;
			}
			
			/*阙超强 14015   添加记录动态信息*/
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一个CDN域名类型。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(rType.getId().toString());
				executerecord.setEntityName("RealmType");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			//删除成功 返回1
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
	
	/**
	 * 修改
	 * @return
	 */
	public String update(){
		//拿到登陆员工用户  判断登录信息是否存在
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		if(null == loginEmp){
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}
		
		//修改类型
		RealmType rType = (RealmType) realmTypeBussiness.updataObject(realmType);
		
		//修改失败返回错误页面
		if(null == rType){
			request.setAttribute("errorMsg", "修改出现错误，请重试！");
			return "no";
		}
		
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("修改了一个CDN域名类型。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(rType.getId().toString());
			executerecord.setEntityName("RealmType");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "success";
	}
	
	/**
	 * 跳转至添加页
	 * @return
	 */
	public String goAdd(){
		return "goAdd";
	}
	
	/**
	 * 跳转至修改页
	 * @return
	 */
	public String goUpdate(){
		//获得单个套餐对象
		String id = request.getParameter("id")==null?null:request.getParameter("id");
		if(null != id){
			RealmType realmType = (RealmType) realmTypeBussiness.findObjectById("RealmType", Integer.parseInt(id));
			request.setAttribute("data", realmType);
			return "goUpdate";
		}else{
			request.setAttribute("errorMsg", "获取修改对象时出错，请重试！");
			return "no";
		}
	}
	
	/*属性封装*/
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
	public RealmType getRealmType() {
		return realmType;
	}
	public void setRealmType(RealmType realmType) {
		this.realmType = realmType;
	}
	public RealmTypeBussiness getRealmTypeBussiness() {
		return realmTypeBussiness;
	}
	public void setRealmTypeBussiness(RealmTypeBussiness realmTypeBussiness) {
		this.realmTypeBussiness = realmTypeBussiness;
	}
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}
	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
}
