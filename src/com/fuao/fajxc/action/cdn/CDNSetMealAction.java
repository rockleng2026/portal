package com.fuao.fajxc.action.cdn;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.cdn.SetMealBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.RealmType;
import com.fuao.fajxc.vo.SetMeal;
import com.fuao.fajxc.vo.SetMealCenter;
import com.fuao.fajxc.vo.SetMealProperty;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * @author 阙超强 14015
 * @time 2012-01-31 11:05:16
 * CDN套餐action
 */
public class CDNSetMealAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private HttpServletResponse response;
	private SetMeal setMeal;
	private SetMealBussiness setMealBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;
	
	
	//跳转至列表页
	public String getAll() throws IOException{
		//获得页面标签数
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		
		//定义hql查询语句
		String hql = "From SetMeal where delFlag=0  ";
		
		//拿到条件查询
		Object smnObject = request.getParameter("mealName");
		if(null != smnObject){
			hql += " and name like '%" + smnObject.toString() + "%' ";
		}
		
		//是否为字段查找的判断
		if(null != setMeal.getId() && !"".equals(setMeal.getId())){
			hql += " and id like '%"+URLDecoder.decode(setMeal.getId().toString(),"UTF-8")+"%'";
		}
		if(null != setMeal.getName() && !"".equals(setMeal.getName())){
			hql += " and name like '%" + URLDecoder.decode(setMeal.getName(),"UTF-8") + "%' ";
		}
		if(null != setMeal.getRealmtype()&& !"".equals(setMeal.getRealmtype()) && null != setMeal.getRealmtype().getName() && !"".equals(setMeal.getRealmtype().getName())){
			hql += " and realmtype.name like '%"+URLDecoder.decode(setMeal.getRealmtype().getName(),"UTF-8")+"%'";
		}
		if(null != setMeal.getStarttime() && !"".equals(setMeal.getStarttime())){
			hql += " and starttime like '%"+URLDecoder.decode(setMeal.getStarttime(),"UTF-8")+"%'";
		}
		if(null != setMeal.getEndtime() && !"".equals(setMeal.getEndtime())){
			hql += " and endtime like '%"+URLDecoder.decode(setMeal.getEndtime(),"UTF-8")+"%'";
		}
		if(null != setMeal.getUsetime() && !"".equals(setMeal.getUsetime())){
			hql += " and usetime like '%"+URLDecoder.decode(setMeal.getUsetime(),"UTF-8")+"%'";
		}
		if(null != setMeal.getPrice() && !"".equals(setMeal.getPrice())){
			System.out.println(Math.round(setMeal.getPrice()));
			hql += " and price like '%"+URLDecoder.decode(String.valueOf(Math.round(setMeal.getPrice())),"UTF-8")+"%' ";
		}
		if(null != setMeal.getPayprice() && !"".equals(setMeal.getPayprice())){
			hql += " and payprice like '%"+URLDecoder.decode(String.valueOf(Math.round(setMeal.getPayprice())),"UTF-8")+"%' ";
		}
		if(null != setMeal.getChargeType()){
			if(!"".equals(setMeal.getChargeType())){
				hql +=" and chargeType = " + setMeal.getChargeType();
			}else{
				hql +=" and chargeType in(0,1,2,3) ";
			}
		}
		hql+="order by id desc";
		//分页查询
		Pages pages = setMealBussiness.exePagesList(hql, Integer.parseInt(pageNo), 20, null);
		
		//字段查找
		if(request.getParameter("tage") != null && request.getParameter("tage").equals("y")){
			PropertyEditor property = new PropertyEditor();
			String strr="";
			String str="";
			if(null != pages.getPageList() && pages.getPageList().size()>0)
			{
				for(int i=0; i<pages.getPageList().size(); i++)
				{
					SetMeal sMeal = new SetMeal();
					sMeal =(SetMeal)pages.getPageList().get(i);
					String chargeType = "";
					if("0".equals(sMeal.getChargeType())){chargeType = "免费";}
					else if("1".equals(sMeal.getChargeType())){chargeType = "赠送";}
					else if("2".equals(sMeal.getChargeType())){chargeType = "预付";}
					else if("3".equals(sMeal.getChargeType())){chargeType = "后付";}
					str = property.getID("selectSetMeal").toString();
				    str = str.replace("#id#", sMeal.getId()+"");
					str = str.replace("#name#", sMeal.getName());
					str = str.replace("#realmtype.name#", sMeal.getRealmtype().getName());
					str = str.replace("#starttime#", sMeal.getStarttime());
					str = str.replace("#endtime#", sMeal.getEndtime());
					str = str.replace("#usetime#", sMeal.getUsetime()+"天");
					str = str.replace("#chargeType#", chargeType);
					str = str.replace("#price#", sMeal.getPrice()+"");
					str = str.replace("#payprice#", sMeal.getPayprice()+"");
					strr +=str;		
				}
				pages.setUrl("getAllCDNSetMealAction.do");
				strr+="#"+pages.getHtml("selectSetMeal");
			}  
		   response.setCharacterEncoding("utf-8");
		   response.getWriter().print(strr);
		   return null;
		}
		 
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");
		String datetime=time.format(new Date())+"";
		datetime=datetime.replace("-", "");
		String[] markstart=new String[20];
		for(int i=pages.getRecordStart();i<pages.getRecordEnd();i++)
		{
			SetMeal sm=(SetMeal) pages.getPageList().get(i);
			
			String datetime1=sm.getStarttime();
			datetime1=datetime1.replace("-", "");
			String datetime2=sm.getEndtime();
			datetime2=datetime2.replace("-", "");
			
			
			if(Integer.parseInt(datetime1)-Integer.parseInt(datetime)>0)
			{
				markstart[i]="0";//开始时间大于当前时间没有开始
			}
			else if(Integer.parseInt(datetime)-Integer.parseInt(datetime2)>0)
			{
				markstart[i]="1";//结束时间大于当前时间套餐活动结束
			}
			else
			{
				markstart[i]="2";//套餐活动进行中
			}
		}
		String[] date=new String[20];
		for(int i=pages.getRecordStart();i<pages.getRecordEnd();i++)
		{
			SetMeal sm=(SetMeal) pages.getPageList().get(i);
			
			int shijian=Integer.parseInt(sm.getUsetime());
			int shijian1=0;//存放多少年
			int shijian2=0;//存放多少月
			date[i]="";
			if(shijian>360)//判断是否有年
			{
				shijian1=shijian/360;
				date[i]+=shijian1+"年";
			}
			System.out.println(shijian-shijian1*360>30);
			if(shijian-shijian1*360>30)//判断是否有月
			{
				shijian2=(shijian-shijian1*360)/30;
				date[i]+=shijian2+"月";
			}
			if((shijian-shijian1*360)-(shijian2*30)>0)//判断还剩下多少天
			{
				date[i]+=(shijian-shijian1*360)-(shijian2*30)+"天";
			}
		}
		request.setAttribute("date", date);
		request.setAttribute("markstart", markstart);
		request.setAttribute("pages", pages);
		return "goAllList";
	}
	
	//删除一个套餐（软删除）
	public void del(){
		try {
			String id = request.getParameter("id")==null?null:request.getParameter("id");
			SetMeal setMeal = setMealBussiness.getSetMealData(id);
			setMeal.setDelflag(1);
			
			SetMeal sMeal = setMealBussiness.updateSetMeal(setMeal);
			if(null == sMeal){
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
				executerecord.setContent("删除了一个CDN套餐。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(id);
				executerecord.setEntityName("SetMeal");
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
	
	//跳换至套餐添加页面
	public String goAdd(){
		//拿出域类型 为了放到下拉列表中
		String hql = "From RealmType where delFlag = 0 ";
		List<RealmType> realmTypeList = setMealBussiness.findObjectListByHQL(hql);
		
		//拿出所有套餐属性
		String hql2 = "From SetMealProperty where 1=1 and delflag = 0";
		List<SetMealProperty> propertyList = setMealBussiness.findObjectListByHQL(hql2);
		
		request.setAttribute("realmTypeList", realmTypeList);
		request.setAttribute("propertyList", propertyList);
		
		return "goAdd";
	}
	
	//跳换至套餐详细页面
	public String goInfo(){
		//获得单个套餐对象
		String id = request.getParameter("id")==null?null:request.getParameter("id");
		SetMeal setMeal = setMealBussiness.getSetMealData(id);
		
		//拿出套餐下的所有属性
		String hql= "From SetMealCenter where delflag = 0 and setmeal.id = " + Integer.parseInt(id);
		List<SetMealCenter> centerList = setMealBussiness.findObjectListByHQL(hql);
		
		request.setAttribute("data", setMeal);
		request.setAttribute("centerList", centerList);
		
		return "goInfo";
	}
	
	//跳换至套餐修改页面
	public String goUpdate(){
		//获得单个套餐对象
		String id = request.getParameter("id")==null?null:request.getParameter("id");
		SetMeal setMeal = setMealBussiness.getSetMealData(id);
		System.out.println(setMeal.getId());
		//拿出域类型 为了放到下拉列表中
		String hql = "From RealmType where delFlag = 0 ";
		List<RealmType> realmTypeList = setMealBussiness.findObjectListByHQL(hql);
		
		//拿出所有套餐属性
		String hql2 = "from SetMealProperty where  delflag = 0";
		List<SetMealProperty> propertyList = setMealBussiness.findObjectListByHQL(hql2);
		
		//拿出套餐下的所有属性
		String hql3= "From SetMealCenter where delflag = 0 and setmeal.id = " + Integer.parseInt(id);
		List<SetMealCenter> centerList = setMealBussiness.findObjectListByHQL(hql3);
		
		request.setAttribute("data", setMeal);
		request.setAttribute("realmTypeList", realmTypeList);
		request.setAttribute("propertyList", propertyList);
		request.setAttribute("centerList", centerList);
		return "goUpdate";
	}
	//强制结束套餐
	public void goUpdate1() throws IOException{
		String id = request.getParameter("id");
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");
		String datetime=time.format(new Date())+"";
		String hql="update SetMeal set endtime='"+datetime+"' where id="+Integer.parseInt(id)+"";
		
		int a=setMealBussiness.updataByHQL(hql);
		if(a>0)
		{
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("0");
		}
	}
	
	//修改套餐
	public String update(){
		//拿到登陆员工用户  判断登录信息是否存在
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		if(null == loginEmp){
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}
		
		//修改套餐信息
		SetMeal sMeal = setMealBussiness.updateSetMeal(setMeal);
		if(null == sMeal){
			request.setAttribute("errorMsg", "修改出现错误，请重试！");
			return "no";
		}
		
		//先删除套餐已有的属性
		String hql3= "From SetMealCenter where delflag = 0 and setmeal.id = " + sMeal.getId();
		List<SetMealCenter> centerList = setMealBussiness.findObjectListByHQL(hql3);
		for(int i = 0; i < centerList.size(); i++){
			SetMealCenter sMealCenter = centerList.get(i);
			sMealCenter.setDelflag(1);
			String updatehql="update SetMealCenter set delflag=1 where id="+sMealCenter.getId()+"";
		//	setMealBussiness.updataObject(sMealCenter);
			setMealBussiness.updataByHQL(updatehql);
		}
		
		//再添加套餐的属性
		String property[] = request.getParameterValues("property");
		for(int i = 0; i < property.length; i++){
			//拿到CDN属性的当前ID
			String strId = property[i];
			//当前ID的CDN属性数据
			SetMealProperty setmealproperty = (SetMealProperty) setMealBussiness.findObjectById("SetMealProperty", Integer.parseInt(strId));
			
			//设置中间表数据
			SetMealCenter setMealCenter = new SetMealCenter();
			
			setMealCenter.setDelflag(0);
			setMealCenter.setSetmeal(sMeal);
			setMealCenter.setSetMealProperty(setmealproperty);
			
			setMealBussiness.addObject(setMealCenter);
		}
		
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("修改了一个CDN套餐。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(setMeal.getId().toString());
			executerecord.setEntityName("SetMeal");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		return "success";
	}
	
	//添加套餐addCDNSetMealAction
	public String add(){
		
	
		//拿到登陆员工用户  判断登录信息是否存在
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		if(null == loginEmp){
			request.setAttribute("errorMsg", "长时间未活动，请重新登录！");
			return "no";
		}
		
		//执行添加    返回对象 为了添加动态
		String aa=request.getParameter("price");
		SetMeal sMeal = (SetMeal) setMealBussiness.addObject(setMeal);
		if(null == sMeal){
			request.setAttribute("errorMsg", "添加套餐失败，请重试！");
			return "no";
		}
		
		/*阙超强 14015   添加记录动态信息*/
		//添加记录到动态记录表
		if(null != loginEmp){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个CDN套餐。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(sMeal.getId().toString());
			executerecord.setEntityName("SetMeal");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}
		
		String property[]=request.getParameterValues("property");
		for(int i = 0; i < property.length; i++){
			//拿到CDN属性的当前ID
			String strId = property[i];
			//当前ID的CDN属性数据
			SetMealProperty setmealproperty = (SetMealProperty) setMealBussiness.findObjectById("SetMealProperty", Integer.parseInt(strId));
			
			//设置中间表数据
			SetMealCenter setMealCenter = new SetMealCenter();
			
			setMealCenter.setDelflag(0);
			setMealCenter.setSetmeal(sMeal);
			System.out.println(setmealproperty.getId());
			setMealCenter.setSetMealProperty(setmealproperty);
			
			setMealBussiness.addObject(setMealCenter);
		}
		
		return "success";
	}
	
	/*属性封装*/
	public SetMeal getSetMeal() {
		return setMeal;
	}
	public void setSetMeal(SetMeal setMeal) {
		this.setMeal = setMeal;
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

	public SetMealBussiness getSetMealBussiness() {
		return setMealBussiness;
	}
	public void setSetMealBussiness(SetMealBussiness setMealBussiness) {
		this.setMealBussiness = setMealBussiness;
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
		setMeal = new SetMeal();
		return setMeal;
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
