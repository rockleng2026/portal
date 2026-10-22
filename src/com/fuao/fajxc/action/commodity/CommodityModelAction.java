package com.fuao.fajxc.action.commodity;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.commodity.CommodityModelBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Model;
import com.opensymphony.xwork2.ModelDriven;

public class CommodityModelAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private CommodityModelBussiness commodityModelBussiness;
	private Model m;
	
	
	public CommodityModelBussiness getCommodityModelBussiness() {
		return commodityModelBussiness;
	}

	public void setCommodityModelBussiness(
			CommodityModelBussiness commodityModelBussiness) {
		this.commodityModelBussiness = commodityModelBussiness;
	}

	public Object getModel() {
		m = new Model();
		return m;
	}

	public void setServletRequest(HttpServletRequest arge) {
		this.request = arge;
		
	}

	public void setServletResponse(HttpServletResponse arge) {
		this.response = arge;
		
	}
	
	public String select()
	{
		System.out.println("232323___+++");
			 response.setContentType("text/html;charset=GBK");
			 String typeid=request.getParameter("deptid");
			 String str="";
			 str+="<option value=''>请选择</option>";
			 if(typeid!=null && !typeid.equals(""))
			 {
				List<Model>  model=commodityModelBussiness.select(typeid);
				 //Set emps= (Set) model.getCommodityTpye();		
				 for (Object models : model) {
					 Model data=(Model)models;
					 str += "<option value='"+data.getModel()+"'>"+data.getName()+"</option>";
				}
				 System.out.println(str);
				 	PrintWriter pw;
					try {
						pw = response.getWriter();
						if(model.size() > 0){
							pw.write(str);
						}else{
							pw.write("<option value=''></option>");
						}
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			 }
			return null;
		}
	
	/**
	 * 根据仓库Id和型号Id查找数量
	 * @return
	 */
	public String some()
	{
		String modelId=request.getParameter("modelId");
		String depId=request.getParameter("depId");
		int count=commodityModelBussiness.selsomeModel(Integer.parseInt(modelId), Integer.parseInt(depId));
		try {
			response.getWriter().print(count);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 查询机柜列表
	 */
	public String getCabinetList()
	{
		
		//得到类型为机柜的所以型号列表
		List<Model> model = commodityModelBussiness.getCabinetList();
		
		//定义空字符串用于存放modelid
		String modelid = "";
		
		//循环机柜列表 ，将机柜封装成数组 用于查询其属性
		for(int i = 0; i<model.size(); i++)
		{
			modelid+=model.get(i).getModel()+",";
		}
		modelid = modelid.substring(0,modelid.length()-1);
		//定义查询机柜列表的HQL预计
		String hql = "from Property where delflag = 0 and model in ("+modelid+")";

		String dpage = request.getParameter("pageNo");
		int pageNo = 1;

		String name = request.getParameter("cname");
		if (name != null && !name.equals("")) {
			hql += " and name like '%" + name + "%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		} else {
			hql += " order by id desc";
			request.getSession().setAttribute("hql", hql);
		}

		Pages pages = commodityModelBussiness.getList(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		return "CabinetList";
	}
	
}
