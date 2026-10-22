package com.fuao.fajxc.action.orderTemplate;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.orderTemplate.SetMealBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.SetmealPropertyComm;
import com.opensymphony.xwork2.ModelDriven;


/**
 * 订单套餐属性action
 * @author 阙超强 14015
 * @time 2012-02-28 11:45:25
 */
@SuppressWarnings("unchecked")
public class SetMealProAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private HttpServletResponse response;
	private SetmealPropertyComm setmealPropertyComm;
	private SetMealBussiness setMealBussiness;

	public SetMealBussiness getSetMealBussiness() {
		return setMealBussiness;
	}

	public void setSetMealBussiness(SetMealBussiness setMealBussiness) {
		this.setMealBussiness = setMealBussiness;
	}

	/*模型驱动 */
	public Object getModel() {
		setmealPropertyComm = new SetmealPropertyComm();
		return setmealPropertyComm;
	}

	/**
	 * 根据商品类型ID获得其类型下的型号(添加页面下的)
	 */
	public String selectModel(){
		try {
			//拿到选择的商品类型ID
			String strId = request.getParameter("id");
			if(null == strId){
				request.setAttribute("errorMsg", "操作出错，请重试或重新登录！");
				return "no";
			}
			//据商品类型ID拿到其对于的商品型号
			String hql = "from Model where commodityTpye.id = " + Integer.parseInt(strId);
			List<Model> modelList= setMealBussiness.exeHql(hql);
			
			//遍历 成字符串Html代码返回去
			int modelListSize = modelList.size();
			String returnHtml = "";
			for(int i = 0; i<modelListSize; i++){
				Model model = modelList.get(i);
				returnHtml += "<option value='"+model.getModel()+"'>"+model.getName()+"</option>";
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(returnHtml);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据商品型号获得其型号下的所有产品/商品(添加页面下的)
	 */
	public String selectProduct(){
		try {
			//拿到选择的商品型号ID
			String strId = request.getParameter("id");
			if(null == strId){
				request.setAttribute("errorMsg", "操作出错，请重试或重新登录！");
				return "no";
			}
			//据商品类型ID拿到其对于的商品型号
			String hql = "from Product where property.model.model = " + Integer.parseInt(strId);
			List<Product> productList = setMealBussiness.exeHql(hql);
			
			//遍历 成字符串Html代码返回去
			int productListSize = productList.size();
			String returnHtml = "";
			for(int i = 0; i<productListSize; i++){
				Product product = productList.get(i);
				returnHtml += "<option value='"+product.getId()+"'>"+product.getProperty().getName()+"</option>";
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(returnHtml);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 跳转至添加
	 * @return
	 */
	public String goAdd(){
		String hql = "from Product where delflag = 0 ";
		String hql1 = "from CommodityTpye where del = '0'";
		
		List<Product> proList = setMealBussiness.exeHql(hql);
		List<CommodityTpye> typeList = setMealBussiness.exeHql(hql1);
		
		request.setAttribute("proList", proList);
		request.setAttribute("typeList", typeList);
		
		return "goAdd";
	}
	
	/**
	 * 添加
	 * @return
	 */
	public String add(){
		
		//设置部分字段
		String uuid = UUID.randomUUID().toString();
		setmealPropertyComm.setUuid(uuid);
		setmealPropertyComm.setExistScfj(0);
		
		//执行添加
		SetmealPropertyComm sPropertyComm = (SetmealPropertyComm) setMealBussiness.add(setmealPropertyComm);
		if("".equals(sPropertyComm) && null == sPropertyComm){
			request.setAttribute("errorMsg", "添加套餐属性失败，请重试！");
			return "no";
		}
		return "success";
	}
	
	/**
	 * 跳转至修改(已和跳转详细合二为一)
	 * @return
	 */
//	public String goUpdate(){
//		return "goUpdate";
//	}
	
	/**
	 * 修改
	 * @return
	 */
	public String update(){
		boolean result = setMealBussiness.update(setmealPropertyComm);
		if(result == false){
			request.setAttribute("errorMsg", "修改属性失败，请重试！");
			return "no";
		}
		return "success";
	}
	
	/**
	 * 跳转至详细或修改页面
	 * @return
	 */
	public String go(){
		int id = Integer.parseInt(request.getParameter("id"));
		SetmealPropertyComm sPropertyComm = (SetmealPropertyComm) setMealBussiness.getById(SetmealPropertyComm.class, id);
		request.setAttribute("data", sPropertyComm);
		
		//判断跳转何处
		String type = request.getParameter("type");
		//如果是修改 就要把产品信息拿出来
		if("update".equals(type)){
			String hql = "from Product where delflag = 0 ";
			String hql1 = "from CommodityTpye where del = '0'";
			
			List<Product> proList = setMealBussiness.exeHql(hql);
			List<CommodityTpye> typeList = setMealBussiness.exeHql(hql1);
			
			request.setAttribute("proList", proList);
			request.setAttribute("typeList", typeList);
			return "goUpdate";
		}
		
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
		
		String hql = "from SetmealPropertyComm where delflag = 0 ";

		//条件查询
		String name = request.getParameter("propertyName");
		if(null != name && !"".equals(name)){
   		}
		
		hql += " order by id desc";
		Pages pages = setMealBussiness.exeHqlPages(hql, pageNo, 20, null);
		request.setAttribute("pages", pages);
		return "goList";
	}
	
	/**
	 * 删除
	 */
	public String del(){
		try {
			int mid=Integer.parseInt(request.getParameter("id"));
			SetmealPropertyComm setmealPropertyComm = (SetmealPropertyComm) setMealBussiness.getById(SetmealPropertyComm.class, mid);
			if(null != setmealPropertyComm){
				setmealPropertyComm.setDelflag(1);
				boolean b = setMealBussiness.delSoft(setmealPropertyComm);
				if(true == b){
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

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public SetmealPropertyComm getSetmealPropertyComm() {
		return setmealPropertyComm;
	}

	public void setSetmealPropertyComm(SetmealPropertyComm setmealPropertyComm) {
		this.setmealPropertyComm = setmealPropertyComm;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

}
