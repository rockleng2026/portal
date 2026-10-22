package com.fuao.fajxc.action.commodity;

import java.io.IOException;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.omg.CORBA.Request;

import com.fuao.fajxc.bussiness.commodity.CommodityBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityModelBussiness;
import com.fuao.fajxc.bussiness.commodity.CommodityTypeBussiness;
import com.fuao.fajxc.bussiness.commodity.ProductBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.CommodityTpye;

import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.ibm.icu.text.SimpleDateFormat;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import freemarker.template.SimpleDate;

public class CommodityAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request; // 定义request
	private HttpServletResponse response; // 定义response
	private Property property; // 定义字段属性对象
	private CommodityBussiness commbizimpl;// 注入BIZ
	private CommodityModelBussiness commodityModelBussiness; // 商品型号
	private CommodityTypeBussiness commodityTypeBussinessao;// 商品类型
	private ExecuteRecordBussiness executeRecordBussiness;  //添加动态记录
	private ProductBussiness productbussiness;
	
	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public ProductBussiness getProductbussiness() {
		return productbussiness;
	}

	public void setProductbussiness(ProductBussiness productbussiness) {
		this.productbussiness = productbussiness;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public CommodityModelBussiness getCommodityModelBussiness() {
		return commodityModelBussiness;
	}

	public void setCommodityModelBussiness(
			CommodityModelBussiness commodityModelBussiness) {
		this.commodityModelBussiness = commodityModelBussiness;
	}

	public CommodityTypeBussiness getCommodityTypeBussinessao() {
		return commodityTypeBussinessao;
	}

	public void setCommodityTypeBussinessao(
			CommodityTypeBussiness commodityTypeBussinessao) {
		this.commodityTypeBussinessao = commodityTypeBussinessao;
	}

	public CommodityBussiness getCommbizimpl() {
		return commbizimpl;
	}

	public void setCommbizimpl(CommodityBussiness commbizimpl) {
		this.commbizimpl = commbizimpl;
	}

	/**
	 * 获取对象
	 */
	public Object getModel() {
		property = new Property();
		return property;
	}

	/**
	 * 获取request对象
	 */
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	/**
	 * 获取response对象
	 */
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	/**
	 * 跳转到添加商品页面
	 * 
	 * @return
	 */
	public String addPage() {
		List ctype = commodityTypeBussinessao.getCommoditTypes();
		request.setAttribute("ctype", ctype);
		return "add";
	}
	
	public String addcomtype() {
		List ctype = commodityTypeBussinessao.getCommoditTypes();

        for(int i=0; i<ctype.size(); i++)
        {
        	
        }
		return "add";
	}

	/**
	 * 添加商品信息
	 * 
	 * @return
	 */
	public String add() {
		String modelid = request.getParameter("modelid");
		String porperid = request.getParameter("porperid");
		String typeId = request.getParameter("ctypeid");
		String mName = request.getParameter("medelNmae");
		if (typeId == null && typeId == "") {
			return "error";
		}
		Model model = new Model();
		CommodityTpye ct = commodityTypeBussinessao.getCommodityTpye(typeId);
		if (modelid != null && !modelid.equals("")) {
			model.setModel(Integer.parseInt(modelid));
		}

		model.setCommodityTpye(ct);
		model.setName(mName);
		model.setDelflag("0");
		Model model2 = commbizimpl.getModel(model);

		if (model2 != null) {
			if (porperid != null && !porperid.equals("")) {
				property.setId(Integer.parseInt(porperid));
			}
			property.setModel(model2);
			property.setDelflag("0");
			commbizimpl.addProperty(property);
			
//			Product p=new Product();
//			p.setProperty(property);
//			p.setUsestate(2);
//			p.setUseSum(0);
//			p.setDelflag("0");
//			try{
//				productbussiness.addProductObj(p);
//			}catch (Exception e) {
//				// TODO: handle exception
//				e.printStackTrace();
//			}
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加/修改了一个商品信息。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(porperid);
				executerecord.setEntityName("Property");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		}

		return "select";
	}
   /**
    * 获得商品的配置信息
    * @return
    */
	public String getPropertyInfo()
	{
		
	  String id=request.getParameter("id")==null?"":request.getParameter("id");
	  System.out.println("id====>"+id);
	  int pageNo=1;
	  String hql="from Property where id ="+id;
	  request.getSession().setAttribute("hql", hql);
	 Pages pages=commbizimpl.exHqlPages(hql, pageNo, 10, null);
	 System.out.println("getAllcount==="+pages.getAllCount());
	 request.setAttribute("pages", pages);
		return "propertyInfo";
	}
	/**
	 * 验证码是否唯一
	 * @return
	 * @throws IOException 
	 */
	public String valBarcode() throws IOException
	{
		String barcode=request.getParameter("name")==null?"":request.getParameter("name");
		String hql="from Product where delflag=0 and barcode= '"+barcode+"' ";
		List<Product> pList=productbussiness.getProductList(hql);
		if(pList.size()>0)
		{
			response.getWriter().print("1");
			
		}
		else 
		{
			
			response.getWriter().print("0");
		}
		return null;
	}
	public String select() {
		String hql = "from Property where delflag=0 ";
		String dpage = request.getParameter("pageNo");
		int pageNo = 1;
		
		String name = request.getParameter("cname");
		if (name != null && !name.equals("")) {
			hql += " and name like '%" + name + "%'";
		}
		
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
			if(null != request.getParameter("order"))
			{
				hql += " order by "+request.getParameter("order")+" desc";
			}else{
		hql += " order by id desc";
			}
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages = commbizimpl.exHqlPages(hql, pageNo, 10, null);
		Map map = (Map)ActionContext.getContext().get("map");
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("tag",request.getParameter("order"));
		request.getSession().setAttribute("option", map);
		return "success";
	}
	public void select1() {
		String hql = "from Property where delflag=0 ";
		String dpage = request.getParameter("pageNo");
		int pageNo = 1;
		
		String name = request.getParameter("cname");
		if (name != null && !name.equals("")) {
			hql += " and name like '%" + name + "%'";
		}
		
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		}else{
			if(null != request.getParameter("order"))
			{
				hql += " order by "+request.getParameter("order")+" desc";
			}else{
		hql += " order by id desc";
			}
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages = commbizimpl.exHqlPages(hql, pageNo, 10, null);
		Map map = (Map)ActionContext.getContext().get("map");
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("tag",request.getParameter("order"));
		request.getSession().setAttribute("option", map);
	}

	public void field() throws IOException {
		String id = request.getParameter("id");
		CommodityTpye ct = commodityTypeBussinessao.getCommodityTpye(id);
		response.setContentType("text/html;charset=GBK");
		StringBuffer str = new StringBuffer();

		str
				.append("<tr class=category><td align ='center' width=150>字段</td><td align ='center' width=150>属性名</td><td align ='left' >属性值</td></tr>");
		if (ct.getField().getTemp1() != null
				&& !ct.getField().getTemp1().equals("")) {
			str
					.append("<tr class=category><td align ='center' >temp1</td><td align ='center' >"
							+ ct.getField().getTemp1()
							+ "</td><td><input id='temp1' name='temp1' ></td></tr>");
		}
		if (ct.getField().getTemp2() != null
				&& !ct.getField().getTemp2().equals("")) {
			str
					.append("<tr class=category><td align ='center' >temp2</td><td align ='center' >"
							+ ct.getField().getTemp2()
							+ "</td><td><input id='temp2' name='temp2' ></td></tr>");
		}
		if (ct.getField().getTemp3() != null
				&& !ct.getField().getTemp3().equals("")) {
			str
					.append("<tr class=category><td align ='center' >temp3</td><td align ='center' >"
							+ ct.getField().getTemp3()
							+ "</td><td><input id='temp3' name='temp3' ></td></tr>");
		}
		if (ct.getField().getTemp4() != null
				&& !ct.getField().getTemp4().equals("")) {
			str
					.append("<tr class=category><td align ='center' >temp4</td><td align ='center' >"
							+ ct.getField().getTemp4()
							+ "</td><td><input id='temp4' name='temp4' ></td></tr>");
		}
		if (ct.getField().getTemp5() != null
				&& !ct.getField().getTemp5().equals("")) {
			str.append("<tr class=category><td align ='center' >temp5</td><td align ='center' >"
							+ ct.getField().getTemp5()
							+ "</td><td><input id='temp5' name='temp5' ></td></tr>");
		}
		if (ct.getField().getTemp6() != null
				&& !ct.getField().getTemp6().equals("")) {
			str.append("<tr class=category><td align ='center' >temp6</td><td align ='center' >"
							+ ct.getField().getTemp6()
							+ "</td><td><input id='temp6' name='temp6' ></td></tr>");
		}
		if (ct.getField().getTemp7() != null
				&& !ct.getField().getTemp7().equals("")) {
			str.append("<tr class=category><td align ='center' >temp7</td><td align ='center' >"
							+ ct.getField().getTemp7()
							+ "</td><td><input id='temp7' name='temp7' ></td></tr>");
		}
		if (ct.getField().getTemp8() != null
				&& !ct.getField().getTemp8().equals("")) {
			str.append("<tr class=category><td align ='center' >temp8</td><td align ='center' >"
							+ ct.getField().getTemp8()
							+ "</td><td><input id='temp8' name='temp8' ></td></tr>");
		}
		if (ct.getField().getTemp9() != null
				&& !ct.getField().getTemp9().equals("")) {
			str.append("<tr class=category><td align ='center' >temp9</td><td align ='center' >"
							+ ct.getField().getTemp9()
							+ "</td><td><input id='temp9' name='temp8' ></td></tr>");
		}
		if (ct.getField().getTemp10() != null
				&& !ct.getField().getTemp10().equals("")) {
			str.append("<tr class=category><td align ='center' >temp10</td><td align ='center' >"
							+ ct.getField().getTemp10()
							+ "</td><td><input id='temp10' name='temp10' ></td></tr>");
		}
		if (ct.getField().getTemp11() != null
				&& !ct.getField().getTemp11().equals("")) {
			str.append("<tr class=category><td align ='center' >temp11</td><td align ='center' >"
							+ ct.getField().getTemp11()
							+ "</td><td><input id='temp11' name='temp11' ></td></tr>");
		}
		if (ct.getField().getTemp12() != null
				&& !ct.getField().getTemp12().equals("")) {
			str.append("<tr class=category><td align ='center' >temp12</td><td align ='center' >"
							+ ct.getField().getTemp12()
							+ "</td><td><input id='temp12' name='temp12' ></td></tr>");
		}
		if (ct.getField().getTemp13() != null
				&& !ct.getField().getTemp13().equals("")) {
			str.append("<tr class=category><td align ='center' >temp13</td><td align ='center' >"
							+ ct.getField().getTemp13()
							+ "</td><td><input id='temp13' name='temp13' ></td></tr>");
		}
		if (ct.getField().getTemp14() != null
				&& !ct.getField().getTemp14().equals("")) {
			str.append("<tr class=category><td align ='center' >temp14</td><td align ='center' >"
							+ ct.getField().getTemp14()
							+ "</td><td><input id='temp14' name='temp14' ></td></tr>");
		}
		if (ct.getField().getTemp15() != null
				&& !ct.getField().getTemp15().equals("")) {
			str.append("<tr class=category><td align ='center' >temp15</td><td align ='center' >"
							+ ct.getField().getTemp15()
							+ "</td><td><input id='temp15' name='temp15' ></td></tr>");
		}
		if (ct.getField().getTemp16() != null
				&& !ct.getField().getTemp16().equals("")) {
			str.append("<tr class=category><td align ='center' >temp16</td><td align ='center' >"
							+ ct.getField().getTemp16()
							+ "</td><td><input id='temp16' name='temp16' ></td></tr>");
		}
		if (ct.getField().getTemp17() != null
				&& !ct.getField().getTemp17().equals("")) {
			str.append("<tr class=category><td align ='center' >temp17</td><td align ='center' >"
							+ ct.getField().getTemp17()
							+ "</td><td><input id='temp17' name='temp17' ></td></tr>");
		}
		if (ct.getField().getTemp18() != null
				&& !ct.getField().getTemp18().equals("")) {
			str.append("<tr class=category><td align ='center' >temp18</td><td align ='center' >"
							+ ct.getField().getTemp18()
							+ "</td><td><input id='temp18' name='temp18' ></td></tr>");
		}
		if (ct.getField().getTemp19() != null
				&& !ct.getField().getTemp19().equals("")) {
			str.append("<tr class=category><td align ='center' >temp19</td><td align ='center' >"
							+ ct.getField().getTemp19()
							+ "</td><td><input id='temp19' name='temp19' ></td></tr>");
		}
		if (ct.getField().getTemp20() != null
				&& !ct.getField().getTemp20().equals("")) {
			str.append("<tr class=category><td align ='center' >temp20</td><td align ='center' >"
							+ ct.getField().getTemp20()
							+ "</td><td><input id='temp20' name='temp20' ></td></tr>");
		}
		response.getWriter().println(str);

	}

	/**
	 * 跳转到修改商品页面
	 */
	public String uppage() {
		String id = request.getParameter("id");
		if (id != null && id != "") {
			int cid = Integer.parseInt(id);
			Property property = commbizimpl.getProperty(cid);
			CommodityTpye ct = commodityTypeBussinessao
					.getCommodityTpye(property.getModel().getCommodityTpye()
							.getId().toString());
			request.setAttribute("property", property);
			response.setContentType("text/html;charset=GBK");
			StringBuffer str = new StringBuffer();

			if (ct.getField().getTemp1() != null
					&& !ct.getField().getTemp1().equals("")) {
				str.append("<tr class=category><td align ='center' >temp1</td><td align ='center' >"
								+ ct.getField().getTemp1()
								+ "</td><td><input id='temp1' name='temp1' value='"
								+ property.getTemp1() + "'></td></tr>");
			}
			if (ct.getField().getTemp2() != null
					&& !ct.getField().getTemp2().equals("")) {
				str.append("<tr class=category><td align ='center' >temp2</td><td align ='center' >"
								+ ct.getField().getTemp2()
								+ "</td><td><input id='temp2' name='temp2' value='"
								+ property.getTemp2() + "'></td></tr>");
			}
			if (ct.getField().getTemp3() != null
					&& !ct.getField().getTemp3().equals("")) {
				str.append("<tr class=category><td align ='center' >temp3</td><td align ='center' >"
								+ ct.getField().getTemp3()
								+ "</td><td><input id='temp3' name='temp3' value='"
								+ property.getTemp3() + "'></td></tr>");
			}
			if (ct.getField().getTemp4() != null
					&& !ct.getField().getTemp4().equals("")) {
				str.append("<tr class=category><td align ='center' >temp4</td><td align ='center' >"
								+ ct.getField().getTemp4()
								+ "</td><td><input id='temp4' name='temp4' value='"
								+ property.getTemp4() + "'></td></tr>");
			}
			if (ct.getField().getTemp5() != null
					&& !ct.getField().getTemp5().equals("")) {
				str.append("<tr class=category><td align ='center' >temp5</td><td align ='center' >"
								+ ct.getField().getTemp5()
								+ "</td><td><input id='temp5' name='temp5' value='"
								+ property.getTemp5() + "'></td></tr>");
			}
			if (ct.getField().getTemp6() != null
					&& !ct.getField().getTemp6().equals("")) {
				str.append("<tr class=category><td align ='center' >temp6</td><td align ='center' >"
								+ ct.getField().getTemp6()
								+ "</td><td><input id='temp6' name='temp6' value='"
								+ property.getTemp6() + "'></td></tr>");
			}
			if (ct.getField().getTemp7() != null
					&& !ct.getField().getTemp7().equals("")) {
				str.append("<tr class=category><td align ='center' >temp7</td><td align ='center' >"
								+ ct.getField().getTemp7()
								+ "</td><td><input id='temp7' name='temp7' value='"
								+ property.getTemp7() + "'></td></tr>");
			}
			if (ct.getField().getTemp8() != null
					&& !ct.getField().getTemp8().equals("")) {
				str.append("<tr class=category><td align ='center' >temp8</td><td align ='center' >"
								+ ct.getField().getTemp8()
								+ "</td><td><input id='temp8' name='temp8' value='"
								+ property.getTemp8() + "'></td></tr>");
			}
			if (ct.getField().getTemp9() != null
					&& !ct.getField().getTemp9().equals("")) {
				str.append("<tr class=category><td align ='center' >temp9</td><td align ='center' >"
								+ ct.getField().getTemp9()
								+ "</td><td><input id='temp9' name='temp8' value='"
								+ property.getTemp9() + "'></td></tr>");
			}
			if (ct.getField().getTemp10() != null
					&& !ct.getField().getTemp10().equals("")) {
				str.append("<tr class=category><td align ='center' >temp10</td><td align ='center' >"
								+ ct.getField().getTemp10()
								+ "</td><td><input id='temp10' name='temp10' value='"
								+ property.getTemp10() + "'></td></tr>");
			}
			if (ct.getField().getTemp11() != null
					&& !ct.getField().getTemp11().equals("")) {
				str.append("<tr class=category><td align ='center' >temp11</td><td align ='center' >"
								+ ct.getField().getTemp11()
								+ "</td><td><input id='temp11' name='temp11' value='"
								+ property.getTemp11() + "'></td></tr>");
			}
			if (ct.getField().getTemp12() != null
					&& !ct.getField().getTemp12().equals("")) {
				str.append("<tr class=category><td align ='center' >temp12</td><td align ='center' >"
								+ ct.getField().getTemp12()
								+ "</td><td><input id='temp12' name='temp12' value='"
								+ property.getTemp12() + "'></td></tr>");
			}
			if (ct.getField().getTemp13() != null
					&& !ct.getField().getTemp13().equals("")) {
				str.append("<tr class=category><td align ='center' >temp13</td><td align ='center' >"
								+ ct.getField().getTemp13()
								+ "</td><td><input id='temp13' name='temp13' value='"
								+ property.getTemp13() + "'></td></tr>");
			}
			if (ct.getField().getTemp14() != null
					&& !ct.getField().getTemp14().equals("")) {
				str.append("<tr class=category><td align ='center' >temp14</td><td align ='center' >"
								+ ct.getField().getTemp14()
								+ "</td><td><input id='temp14' name='temp14' value='"
								+ property.getTemp14() + "'></td></tr>");
			}
			if (ct.getField().getTemp15() != null
					&& !ct.getField().getTemp15().equals("")) {
				str.append("<tr class=category><td align ='center' >temp15</td><td align ='center' >"
								+ ct.getField().getTemp15()
								+ "</td><td><input id='temp15' name='temp15' value='"
								+ property.getTemp15() + "'></td></tr>");
			}
			if (ct.getField().getTemp16() != null
					&& !ct.getField().getTemp16().equals("")) {
				str.append("<tr class=category><td align ='center' >temp16</td><td align ='center' >"
								+ ct.getField().getTemp16()
								+ "</td><td><input id='temp16' name='temp16' value='"
								+ property.getTemp16() + "'></td></tr>");
			}
			if (ct.getField().getTemp17() != null
					&& !ct.getField().getTemp17().equals("")) {
				str.append("<tr class=category><td align ='center' >temp17</td><td align ='center' >"
								+ ct.getField().getTemp17()
								+ "</td><td><input id='temp17' name='temp17' value='"
								+ property.getTemp17() + "'></td></tr>");
			}
			if (ct.getField().getTemp18() != null
					&& !ct.getField().getTemp18().equals("")) {
				str.append("<tr class=category><td align ='center' >temp18</td><td align ='center' >"
								+ ct.getField().getTemp18()
								+ "</td><td><input id='temp18' name='temp18' value='"
								+ property.getTemp18() + "'></td></tr>");
			}
			if (ct.getField().getTemp19() != null
					&& !ct.getField().getTemp19().equals("")) {
				str.append("<tr class=category><td align ='center' >temp19</td><td align ='center' >"
								+ ct.getField().getTemp19()
								+ "</td><td><input id='temp19' name='temp19' value='"
								+ property.getTemp19() + "'></td></tr>");
			}
			if (ct.getField().getTemp20() != null
					&& !ct.getField().getTemp20().equals("")) {
				str.append("<tr class=category><td align ='center' >temp20</td><td align ='center' >"
								+ ct.getField().getTemp20()
								+ "</td><td><input id='temp20' name='temp20' value='"
								+ property.getTemp20() + "'></td></tr>");
			}
			request.setAttribute("str", str);
		}
		return this.addPage();
	}

	//查看详细
	public String info() {
		String id = request.getParameter("id");
		if (id != null && id != "") {
			int cid = Integer.parseInt(id);
			Property property = commbizimpl.getProperty(cid);
			CommodityTpye ct = commodityTypeBussinessao
					.getCommodityTpye(property.getModel().getCommodityTpye()
							.getId().toString());
			request.setAttribute("property", property);
			response.setContentType("text/html;charset=GBK");
			StringBuffer str = new StringBuffer();

			if (ct.getField().getTemp1() != null
					&& !ct.getField().getTemp1().equals("")) {
				str.append("<tr class=category><td align ='center' >temp1</td><td align ='center' >"
								+ ct.getField().getTemp1()
								+ "</td><td>"
								+ property.getTemp1() + "</td></tr>");
			}
			if (ct.getField().getTemp2() != null
					&& !ct.getField().getTemp2().equals("")) {
				str.append("<tr class=category><td align ='center' >temp2</td><td align ='center' >"
								+ ct.getField().getTemp2()
								+ "</td><td>"
								+ property.getTemp2() + "</td></tr>");
			}
			if (ct.getField().getTemp3() != null
					&& !ct.getField().getTemp3().equals("")) {
				str.append("<tr class=category><td align ='center' >temp3</td><td align ='center' >"
								+ ct.getField().getTemp3()
								+ "</td><td>"
								+ property.getTemp3() + "</td></tr>");
			}
			if (ct.getField().getTemp4() != null
					&& !ct.getField().getTemp4().equals("")) {
				str.append("<tr class=category><td align ='center' >temp4</td><td align ='center' >"
								+ ct.getField().getTemp4()
								+ "</td><td>"
								+ property.getTemp4() + "</td></tr>");
			}
			if (ct.getField().getTemp5() != null
					&& !ct.getField().getTemp5().equals("")) {
				str.append("<tr class=category><td align ='center' >temp5</td><td align ='center' >"
								+ ct.getField().getTemp5()
								+ "</td><td>"
								+ property.getTemp5() + "</td></tr>");
			}
			if (ct.getField().getTemp6() != null
					&& !ct.getField().getTemp6().equals("")) {
				str.append("<tr class=category><td align ='center' >temp6</td><td align ='center' >"
								+ ct.getField().getTemp6()
								+ "</td><td>"
								+ property.getTemp6() + "</td></tr>");
			}
			if (ct.getField().getTemp7() != null
					&& !ct.getField().getTemp7().equals("")) {
				str.append("<tr class=category><td align ='center' >temp7</td><td align ='center' >"
								+ ct.getField().getTemp7()
								+ "</td><td>"
								+ property.getTemp7() + "</td></tr>");
			}
			if (ct.getField().getTemp8() != null
					&& !ct.getField().getTemp8().equals("")) {
				str.append("<tr class=category><td align ='center' >temp8</td><td align ='center' >"
								+ ct.getField().getTemp8()
								+ "</td><td>"
								+ property.getTemp8() + "</td></tr>");
			}
			if (ct.getField().getTemp9() != null
					&& !ct.getField().getTemp9().equals("")) {
				str.append("<tr class=category><td align ='center' >temp9</td><td align ='center' >"
								+ ct.getField().getTemp9()
								+ "</td><td>"
								+ property.getTemp9() + "</td></tr>");
			}
			if (ct.getField().getTemp10() != null
					&& !ct.getField().getTemp10().equals("")) {
				str.append("<tr class=category><td align ='center' >temp10</td><td align ='center' >"
								+ ct.getField().getTemp10()
								+ "</td><td>"
								+ property.getTemp10() + "</td></tr>");
			}
			if (ct.getField().getTemp11() != null
					&& !ct.getField().getTemp11().equals("")) {
				str.append("<tr class=category><td align ='center' >temp11</td><td align ='center' >"
								+ ct.getField().getTemp11()
								+ "</td><td>"
								+ property.getTemp11() + "</td></tr>");
			}
			if (ct.getField().getTemp12() != null
					&& !ct.getField().getTemp12().equals("")) {
				str.append("<tr class=category><td align ='center' >temp12</td><td align ='center' >"
								+ ct.getField().getTemp12()
								+ "</td><td>"
								+ property.getTemp12() + "</td></tr>");
			}
			if (ct.getField().getTemp13() != null
					&& !ct.getField().getTemp13().equals("")) {
				str.append("<tr class=category><td align ='center' >temp13</td><td align ='center' >"
								+ ct.getField().getTemp13()
								+ "</td><td>"
								+ property.getTemp13() + "</td></tr>");
			}
			if (ct.getField().getTemp14() != null
					&& !ct.getField().getTemp14().equals("")) {
				str.append("<tr class=category><td align ='center' >temp14</td><td align ='center' >"
								+ ct.getField().getTemp14()
								+ "</td><td>"
								+ property.getTemp14() + "</td></tr>");
			}
			if (ct.getField().getTemp15() != null
					&& !ct.getField().getTemp15().equals("")) {
				str.append("<tr class=category><td align ='center' >temp15</td><td align ='center' >"
								+ ct.getField().getTemp15()
								+ "</td><td>"
								+ property.getTemp15() + "</td></tr>");
			}
			if (ct.getField().getTemp16() != null
					&& !ct.getField().getTemp16().equals("")) {
				str.append("<tr class=category><td align ='center' >temp16</td><td align ='center' >"
								+ ct.getField().getTemp16()
								+ "</td><td>"
								+ property.getTemp16() + "</td></tr>");
			}
			if (ct.getField().getTemp17() != null
					&& !ct.getField().getTemp17().equals("")) {
				str.append("<tr class=category><td align ='center' >temp17</td><td align ='center' >"
								+ ct.getField().getTemp17()
								+ "</td><td>"
								+ property.getTemp17() + "</td></tr>");
			}
			if (ct.getField().getTemp18() != null
					&& !ct.getField().getTemp18().equals("")) {
				str.append("<tr class=category><td align ='center' >temp18</td><td align ='center' >"
								+ ct.getField().getTemp18()
								+ "</td><td>"
								+ property.getTemp18() + "</td></tr>");
			}
			if (ct.getField().getTemp19() != null
					&& !ct.getField().getTemp19().equals("")) {
				str.append("<tr class=category><td align ='center' >temp19</td><td align ='center' >"
								+ ct.getField().getTemp19()
								+ "</td><td>"
								+ property.getTemp19() + "</td></tr>");
			}
			if (ct.getField().getTemp20() != null
					&& !ct.getField().getTemp20().equals("")) {
				str.append("<tr class=category><td align ='center' >temp20</td><td align ='center' >"
								+ ct.getField().getTemp20()
								+ "</td><td>"
			 					+ property.getTemp20() + "</td></tr>");
			}
			request.setAttribute("str", str);
			return "info";
		}
		return id;
	}

	//商品套餐模块的查看详细*Commodity
	public String goInfo() {
		String strId = request.getParameter("id");
		int proId = 0;
		if (strId != null && strId != "") { proId = Integer.parseInt(strId);}
		String hql = "from Product where id = " + proId;
		Product product = (Product) executeRecordBussiness.exHql(hql);
		
		if (null != product) {
			int cid = product.getProperty().getId();
			Property property = commbizimpl.getProperty(cid);
			CommodityTpye ct = commodityTypeBussinessao
					.getCommodityTpye(property.getModel().getCommodityTpye()
							.getId().toString());
			request.setAttribute("property", property);
			response.setContentType("text/html;charset=GBK");
			StringBuffer str = new StringBuffer();

			if (ct.getField().getTemp1() != null
					&& !ct.getField().getTemp1().equals("")) {
				str.append("<tr class=category><td align ='center' >temp1</td><td align ='center' >"
								+ ct.getField().getTemp1()
								+ "</td><td>"
								+ property.getTemp1() + "</td></tr>");
			}
			if (ct.getField().getTemp2() != null
					&& !ct.getField().getTemp2().equals("")) {
				str.append("<tr class=category><td align ='center' >temp2</td><td align ='center' >"
								+ ct.getField().getTemp2()
								+ "</td><td>"
								+ property.getTemp2() + "</td></tr>");
			}
			if (ct.getField().getTemp3() != null
					&& !ct.getField().getTemp3().equals("")) {
				str.append("<tr class=category><td align ='center' >temp3</td><td align ='center' >"
								+ ct.getField().getTemp3()
								+ "</td><td>"
								+ property.getTemp3() + "</td></tr>");
			}
			if (ct.getField().getTemp4() != null
					&& !ct.getField().getTemp4().equals("")) {
				str.append("<tr class=category><td align ='center' >temp4</td><td align ='center' >"
								+ ct.getField().getTemp4()
								+ "</td><td>"
								+ property.getTemp4() + "</td></tr>");
			}
			if (ct.getField().getTemp5() != null
					&& !ct.getField().getTemp5().equals("")) {
				str.append("<tr class=category><td align ='center' >temp5</td><td align ='center' >"
								+ ct.getField().getTemp5()
								+ "</td><td>"
								+ property.getTemp5() + "</td></tr>");
			}
			if (ct.getField().getTemp6() != null
					&& !ct.getField().getTemp6().equals("")) {
				str.append("<tr class=category><td align ='center' >temp6</td><td align ='center' >"
								+ ct.getField().getTemp6()
								+ "</td><td>"
								+ property.getTemp6() + "</td></tr>");
			}
			if (ct.getField().getTemp7() != null
					&& !ct.getField().getTemp7().equals("")) {
				str.append("<tr class=category><td align ='center' >temp7</td><td align ='center' >"
								+ ct.getField().getTemp7()
								+ "</td><td>"
								+ property.getTemp7() + "</td></tr>");
			}
			if (ct.getField().getTemp8() != null
					&& !ct.getField().getTemp8().equals("")) {
				str.append("<tr class=category><td align ='center' >temp8</td><td align ='center' >"
								+ ct.getField().getTemp8()
								+ "</td><td>"
								+ property.getTemp8() + "</td></tr>");
			}
			if (ct.getField().getTemp9() != null
					&& !ct.getField().getTemp9().equals("")) {
				str.append("<tr class=category><td align ='center' >temp9</td><td align ='center' >"
								+ ct.getField().getTemp9()
								+ "</td><td>"
								+ property.getTemp9() + "</td></tr>");
			}
			if (ct.getField().getTemp10() != null
					&& !ct.getField().getTemp10().equals("")) {
				str.append("<tr class=category><td align ='center' >temp10</td><td align ='center' >"
								+ ct.getField().getTemp10()
								+ "</td><td>"
								+ property.getTemp10() + "</td></tr>");
			}
			if (ct.getField().getTemp11() != null
					&& !ct.getField().getTemp11().equals("")) {
				str.append("<tr class=category><td align ='center' >temp11</td><td align ='center' >"
								+ ct.getField().getTemp11()
								+ "</td><td>"
								+ property.getTemp11() + "</td></tr>");
			}
			if (ct.getField().getTemp12() != null
					&& !ct.getField().getTemp12().equals("")) {
				str.append("<tr class=category><td align ='center' >temp12</td><td align ='center' >"
								+ ct.getField().getTemp12()
								+ "</td><td>"
								+ property.getTemp12() + "</td></tr>");
			}
			if (ct.getField().getTemp13() != null
					&& !ct.getField().getTemp13().equals("")) {
				str.append("<tr class=category><td align ='center' >temp13</td><td align ='center' >"
								+ ct.getField().getTemp13()
								+ "</td><td>"
								+ property.getTemp13() + "</td></tr>");
			}
			if (ct.getField().getTemp14() != null
					&& !ct.getField().getTemp14().equals("")) {
				str.append("<tr class=category><td align ='center' >temp14</td><td align ='center' >"
								+ ct.getField().getTemp14()
								+ "</td><td>"
								+ property.getTemp14() + "</td></tr>");
			}
			if (ct.getField().getTemp15() != null
					&& !ct.getField().getTemp15().equals("")) {
				str.append("<tr class=category><td align ='center' >temp15</td><td align ='center' >"
								+ ct.getField().getTemp15()
								+ "</td><td>"
								+ property.getTemp15() + "</td></tr>");
			}
			if (ct.getField().getTemp16() != null
					&& !ct.getField().getTemp16().equals("")) {
				str.append("<tr class=category><td align ='center' >temp16</td><td align ='center' >"
								+ ct.getField().getTemp16()
								+ "</td><td>"
								+ property.getTemp16() + "</td></tr>");
			}
			if (ct.getField().getTemp17() != null
					&& !ct.getField().getTemp17().equals("")) {
				str.append("<tr class=category><td align ='center' >temp17</td><td align ='center' >"
								+ ct.getField().getTemp17()
								+ "</td><td>"
								+ property.getTemp17() + "</td></tr>");
			}
			if (ct.getField().getTemp18() != null
					&& !ct.getField().getTemp18().equals("")) {
				str.append("<tr class=category><td align ='center' >temp18</td><td align ='center' >"
								+ ct.getField().getTemp18()
								+ "</td><td>"
								+ property.getTemp18() + "</td></tr>");
			}
			if (ct.getField().getTemp19() != null
					&& !ct.getField().getTemp19().equals("")) {
				str.append("<tr class=category><td align ='center' >temp19</td><td align ='center' >"
								+ ct.getField().getTemp19()
								+ "</td><td>"
								+ property.getTemp19() + "</td></tr>");
			}
			if (ct.getField().getTemp20() != null
					&& !ct.getField().getTemp20().equals("")) {
				str.append("<tr class=category><td align ='center' >temp20</td><td align ='center' >"
								+ ct.getField().getTemp20()
								+ "</td><td>"
								+ property.getTemp20() + "</td></tr>");
			}
			request.setAttribute("str", str);
			return "info";
		}
		return strId;
	}
	
	
	public void del() throws IOException {

		String id = request.getParameter("id");
		if (id != null && id != "") {
			int cid = Integer.parseInt(id);
			Property property = commbizimpl.getProperty(cid);
			if (null != property) {
				property.setDelflag("1");
				boolean b = commbizimpl.del(property);
				if (b) {
					/*阙超强 14015   添加记录动态信息*/
					//拿到登陆员工用户
					Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
					//添加记录到动态记录表
					if(null != loginEmp){
						Executerecord executerecord = new Executerecord();
						executerecord.setEmployee(loginEmp);
						executerecord.setContent("删除了一个商品信息。");
						executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
						executerecord.setEntityId(property.getId().toString());
						executerecord.setEntityName("Property");
						executerecord.setSeenEmpId("");
						executeRecordBussiness.addData(executerecord);
					}
					
					response.getWriter().println(1);
				} else
					response.getWriter().println(0);

			}
		}
	}
	
	public String show(){
		String num = request.getParameter("num");//获得第num行 记录下标
		request.setAttribute("num", num);
		String hql = "from Property where delflag=0 ";
		String dpage = request.getParameter("pageNo");
		int pageNo = 1;
		
		String name = request.getParameter("cname");
		if (name != null && !name.equals("")) {
			hql += " and name like '%" + name + "%'";
		}
		
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = (String)request.getSession().getAttribute("hql");
		}else{
		hql += " order by id desc";
		request.getSession().setAttribute("hql", hql);
		}
		Pages pages = commbizimpl.exHqlPages(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		System.out.println("我在这里：。。。。。");
		return "showcommodity";
	}

}