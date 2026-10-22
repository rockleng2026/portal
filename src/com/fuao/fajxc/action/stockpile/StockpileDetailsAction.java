package com.fuao.fajxc.action.stockpile;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.stockpile.StockpileDetailsBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 库存明细Action
 * @author 14012
 *
 */
public class StockpileDetailsAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	private StockpileDetailsBussiness stockpileDetailsBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	
	public void setStockpileDetailsBussiness(
			StockpileDetailsBussiness stockpileDetailsBussiness) {
		this.stockpileDetailsBussiness = stockpileDetailsBussiness;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response = arg0;
	}

	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	/**
	 * 库存明细综合查询
	 */
	public String storageQuery()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String depotName = request.getParameter("depotName")==null?"":request.getParameter("depotName");
		String productName = request.getParameter("productName")==null?"":request.getParameter("productName");
		
		String hql = "select depot.id,property.id,count(property.id) as tmp2 from Product  where usestate between 0 and 1 ";
		
		if(!depotName.equals("")&&depotName!=null)
		{
			Depot depot = (Depot)stockpileDetailsBussiness.getObject("Depot", " and name = '"+depotName+"'");
			hql+= " and depot.id = "+depot.getId();
		}
		if(!productName.equals("")&&productName!=null)
		{
			Model model = (Model)stockpileDetailsBussiness.getObject("Model", " and delflag = 0  and name = '"+productName+"'");
			Property property = (Property)stockpileDetailsBussiness.getObject("Property", " and delflag = 0  and modelId = "+model.getModel());
			hql+=" and property.id = "+property.getId();
		}
		
		hql+=" group by depot.id,property.id ";
		
		System.out.println("hql : "+hql);
		
		Pages pages=stockpileDetailsBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "storageIntegrationQuery";
	}
	
	/**
	 * 架下商品查询
	 */
	public String untappeCommodity()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String depotName = request.getParameter("depotName")==null?"":request.getParameter("depotName");
		String productName = request.getParameter("productName")==null?"":request.getParameter("productName");
		
		String hql = "from Product where delflag = 0 and usestate = 0 ";
		
		if(!depotName.equals("")&&depotName!=null)
		{
			Depot depot = (Depot)stockpileDetailsBussiness.getObject("Depot", " and name = '"+depotName+"'");
			hql+= " and depot.id = "+depot.getId();
		}
		if(!productName.equals("")&&productName!=null)
		{
			Model model = (Model)stockpileDetailsBussiness.getObject("Model", " and delflag = 0  and name = '"+productName+"'");
			Property property = (Property)stockpileDetailsBussiness.getObject("Property", " and delflag = 0  and modelId = "+model.getModel());
			hql+=" and property.id = "+property.getId();
		}
		
		hql+="  order by barcode desc ";
		
		System.out.println("hql : "+hql);
		
		Pages pages=stockpileDetailsBussiness.exHqlObjectPages(hql, Integer.parseInt(pageNo), 10, null);
		

		request.setAttribute("pages", pages);
		return "untappeCommodity";
		
	}

	/**
	 * 架上商品查询
	 */
	public String useCommodity()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String depotName = request.getParameter("depotName")==null?"":request.getParameter("depotName");
		String productName = request.getParameter("productName")==null?"":request.getParameter("productName");
		
		String hql = "from Product where delflag = 0 and usestate = 1 ";
		
		if(!depotName.equals("")&&depotName!=null)
		{
			Depot depot = (Depot)stockpileDetailsBussiness.getObject("Depot", " and name = '"+depotName+"'");
			hql+= " and depot.id = "+depot.getId();
		}
		if(!productName.equals("")&&productName!=null)
		{
			Model model = (Model)stockpileDetailsBussiness.getObject("Model", " and delflag = 0  and name = '"+productName+"'");
			Property property = (Property)stockpileDetailsBussiness.getObject("Property", " and delflag = 0  and modelId = "+model.getModel());
			hql+=" and property.id = "+property.getId();
		}
		
		hql+="  order by barcode desc ";
		
		System.out.println("hql : "+hql);
		
		Pages pages=stockpileDetailsBussiness.exHqlObjectPages(hql, Integer.parseInt(pageNo), 10, null);
		

		request.setAttribute("pages", pages);
		return "useCommodity";

	}
}
