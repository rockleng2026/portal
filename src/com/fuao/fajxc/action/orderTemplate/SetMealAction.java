package com.fuao.fajxc.action.orderTemplate;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.orderTemplate.SetMealBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.Ordertype;
import com.fuao.fajxc.vo.SetMealCenter;
import com.fuao.fajxc.vo.SetMealProperty;
import com.fuao.fajxc.vo.SetmealComm;
import com.fuao.fajxc.vo.SetmealPropertyComm;
import com.opensymphony.xwork2.ModelDriven;


/**
 * 订单套餐action
 * @author 阙超强 14015
 * @time 2012-02-27 15:45:11
 *
 */
@SuppressWarnings("unchecked")
public class SetMealAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private HttpServletResponse response;
	private SetmealComm setmealComm;
	private SetMealBussiness setMealBussiness;

	public SetMealBussiness getSetMealBussiness() {
		return setMealBussiness;
	}

	public void setSetMealBussiness(SetMealBussiness setMealBussiness) {
		this.setMealBussiness = setMealBussiness;
	}

	/*模型驱动 */
	public Object getModel() {
		setmealComm = new SetmealComm();
		return setmealComm;
	}

	/**
	 * 跳转至添加
	 * @return
	 */
	public String goAdd(){
		//查处套餐所有类型
		String hql = "from Ordertype where delflag = 0 ";
	 	List<Ordertype> otList = setMealBussiness.exeHql(hql);
		
	 	//查处所有未绑定套餐的套餐属性
	 	String hql2 = "from SetmealPropertyComm where delflag = 0 and setmealComm.id = null";
	 	List<SetmealPropertyComm> smProList = setMealBussiness.exeHql(hql2);
	 	
	 	request.setAttribute("otList", otList);
	 	request.setAttribute("smProList", smProList);
	 	
		return "goAdd";
	}
	
	/**
	 * 添加
	 * @return
	 */
	public String add(){
		//拿到选择的属性
		String property[]=request.getParameterValues("property");
		
		//设置套餐、添加
		setmealComm.setUuid(UUID.randomUUID().toString());
		setmealComm.setBuildTime(TimePattern.doTimeDf3(new Date()));
		
		SetmealComm smComm = (SetmealComm) setMealBussiness.addSetMeal(setmealComm, property);
		
		if( null == smComm){
		        request.setAttribute("errorMsg", "添加套餐出错，请重新再试！");
		        return "no";
		}
		
		return "success";
	}
	
	/**
	 * 跳转至修改
	 * @return
	 * 跳到修改需要传递4个参数过去：1、修改的对象。2、套餐的所有类型（ordertype）。3、套餐的所有属性。4、属于这个套餐的属性。
	 */
	public String goUpdate(){
		//拿出修改对象
		int id = Integer.parseInt(request.getParameter("id"));
		SetmealComm smComm = (SetmealComm) setMealBussiness.getById(SetmealComm.class, id);
		
		//拿出绑定此对象的属性。
		String hql3 = "from SetmealPropertyComm where delflag = 0 and setmealComm.id = " + smComm.getId();
		List<SetmealPropertyComm> smProList2 = setMealBussiness.exeHql(hql3);
		
		//查处套餐所有类型
		String hql = "from Ordertype where delflag = 0 ";
	 	List<Ordertype> otList = setMealBussiness.exeHql(hql);
		
	 	//查出所有未绑定套餐 的属性
	 	String hql2 = "from SetmealPropertyComm where (setmealComm.id = null or setmealComm.id = "+ smComm.getId()+") and delflag = 0";
	 	List<SetmealPropertyComm> smProList = setMealBussiness.exeHql(hql2);
	 	
	 	request.setAttribute("data", smComm);
	 	request.setAttribute("otList", otList);
	 	request.setAttribute("smProList", smProList);
	 	request.setAttribute("smProList2", smProList2);
		return "goUpdate";
	}
	
	/**
	 * 修改
	 * @return
	 */
	public String update(){
		//拿到选择的属性
		String property[]=request.getParameterValues("property");
		
		//拿出修改之前属于此套餐的属性
		String hql ="from SetmealPropertyComm where delflag = 0 and setmealComm.id = " + setmealComm.getId();
		List<SetmealPropertyComm> oldProperty = setMealBussiness.exeHql(hql);
		
 		//修改
		boolean result = setMealBussiness.updateSetMeal(setmealComm, property,oldProperty);
		
		if(false == result){
		        request.setAttribute("errorMsg", "修改套餐出错，请重新再试！");
		        return "no";
		}
		
		return "success";
	}
	
	/**
	 * 跳转至详细
	 * @return
	 */
	public String goInfo(){
		int id = Integer.parseInt(request.getParameter("id"));
		//查出套餐对象
		SetmealComm setmealComm = (SetmealComm) setMealBussiness.getById(SetmealComm.class, id);
		
		//查出套餐所包含的属性
		String hql = "from SetmealPropertyComm where setmealComm.id = "+ id +" and delflag = 0 ";
	 	List<SetmealPropertyComm> smProList = setMealBussiness.exeHql(hql);
		
		//传值
		request.setAttribute("data", setmealComm);
		request.setAttribute("smProList", smProList);
		
		return "goInfo";
	}
	
	/**
	 * 跳转列表
	 * @return
	 */
	public String goList(){
		//拿到当前第几页
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if(null != strPageNo && !"".equals(strPageNo)){
			pageNo = Integer.parseInt(strPageNo);
		}

		String hql = "from SetmealComm where delflag = 0 ";
		//条件查询
		String mealName = request.getParameter("mealName");
		if(null != mealName && !"".equals(mealName)){
			hql += " and name like '%" + mealName + "%'";
		}
		
		hql += " order by id desc";
		Pages pages = setMealBussiness.exeHqlPages(hql, pageNo, 20, null);
		request.setAttribute("pages", pages);
		return "goList";
	}
	
	/**
	 *  删除
	 * @throws IOException
	 */
	public String del(){
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			//拿到要删除的对象
			SetmealComm sComm = (SetmealComm) setMealBussiness.getById(SetmealComm.class, id);
			
			//查出套餐所包含的属性
			String hql = "from SetmealPropertyComm where setmealComm.id = "+ id +" and delflag = 0 ";
		 	List<SetmealPropertyComm> smProList = setMealBussiness.exeHql(hql);
		 	
			if(null != sComm){
				sComm.setDelflag(1);
				//删除的时候取消属性对其的绑定
				boolean b = setMealBussiness.delSoftSetMeal(sComm, smProList);
				if(b == true){
					response.getWriter().print(0);
				}
			}else{
				response.getWriter().print(1);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*request*/
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	/*response*/
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}
	
	/* 属性封装*/
	public HttpServletRequest getRequest() {
		return request;
	}

	public SetmealComm getSetmealComm() {
		return setmealComm;
	}

	public void setSetmealComm(SetmealComm setmealComm) {
		this.setmealComm = setmealComm;
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

}
