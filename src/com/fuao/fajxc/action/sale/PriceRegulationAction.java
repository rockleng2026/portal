package com.fuao.fajxc.action.sale;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.action.basic.EmployeeAction;
import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.bussiness.sale.PriceRegulationBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Priceregulation;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class PriceRegulationAction implements ServletRequestAware,ServletResponseAware,ModelDriven {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private PriceRegulationBussiness priceRegBussiness;
	private static Logger logger = Logger.getLogger(EmployeeAction.class);
	private Object[] ids;
	private Priceregulation priceReg;
	Cookies ck = new Cookies();
	private PurOrderBussiness purBussiness;
	//获得采购订单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	private AuditingBussiness audBussiness;
	

	

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}


	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}


	public PurOrderBussiness getPurBussiness() {
		return purBussiness;
	}


	public void setPurBussiness(PurOrderBussiness purBussiness) {
		this.purBussiness = purBussiness;
	}


	public PriceRegulationBussiness getPriceRegBussiness() {
		return priceRegBussiness;
	}


	public void setPriceRegBussiness(PriceRegulationBussiness priceRegBussiness) {
		this.priceRegBussiness = priceRegBussiness;
	}


	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
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

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}

	public Object getModel() {
		priceReg=new Priceregulation();
		return priceReg;
	}
	
	/**
	 * 查找价格调整记录
	 * @return
	 */
	public String select()
	{
		String marker=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker);
		request.setAttribute("taskid", taskid);
		
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找
		String modelName=request.getParameter("modelName");
		String typeName=request.getParameter("typeName");
		System.out.println("modelName"+modelName);
		if(modelName!=null&&modelName!=""){
			addhql+=" and model.name='"+modelName+"'";
		}
		if(typeName!=null&&typeName!="")
		{
			addhql+=" and model.commodityTpye.typeName='"+typeName+"'";
		}
		System.out.println("addhql"+addhql);
		String hql="from Priceregulation where delflag=0"+addhql;
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by id desc";
		
		System.out.println("hql:"+hql);
		System.out.println("pageNo:"+pageNo);
		Pages pages=priceRegBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages"+pages);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	/**
	 * 查找价格调整历史记录
	 * @return
	 */
	public String history()
	{
		String id=request.getParameter("cid");
		String priceNo=request.getParameter("priceNo");
		//获取info的信息
		String info = request.getParameter("info");	
		if(id!=null)
		{
			Priceregulation pg=(Priceregulation) priceRegBussiness.someRegulation(" and id="+Integer.parseInt(id)).get(0);
			request.setAttribute("nowpg", pg);
			List list=priceRegBussiness.someRegulation(" and model.model="+pg.getModel().getModel()+" order by id desc");
			request.setAttribute("historypg", list);
		}
		
		
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(priceNo!=null){
				String addhql2=" and orderNo='"+priceNo+"'";
				
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0){
					
					String depid = ck.getCookie(request, "departmentId");
					
					for(int i=0; i<audList.size(); i++){
						
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						
						if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 ){
							
							//表示未审核
							request.setAttribute("flage", 0);
							
						}else if(aot.getDepartment().getId() == Integer.parseInt(depid)&&
								(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2)){
							
							//表示已经审核
							request.setAttribute("flage", 1);
							
							request.setAttribute("aot", aot);
							
						}
					}
					
				}				
			}
		}
		
		String empid=ck.getCookie(request, "employeeId");
		System.out.println("ck::::"+empid);
		boolean flag=audBussiness.checkemp(priceNo, empid);
		System.out.println("saleActionflag:::::"+flag);
		if(flag){
			request.setAttribute("mark", "mark");
		}
		boolean flag1=audBussiness.checkemp1(priceNo, empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		return "history"; 
	}
	
	/**
	 * 添加显示页面
	 */
	public String addShow()
	{
		//获得单号
		String priNo="PR-"+serial.getSerialNumber();
		request.setAttribute("preg",priNo);
		
		return "add";
	}
	
	/**
	 * 计算采购价格
	 */
	public String enumRug()
	{
		String modelId=request.getParameter("modelId");
		if(modelId!=null)
		{
			List list=purBussiness.selsomePurOrderinfo(2, Integer.parseInt(modelId));
			Double sums=0.0;
			for(int i=0;i<list.size();i++)
			{
				PurOrderInfo purInfo=(PurOrderInfo) list.get(i);
				sums+=purInfo.getPrice();
			}
			try
			{
				if(sums>0)
					sums=sums/2;
				response.getWriter().print(sums);
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 根据型号查找是否有价格记录
	 */
	public String lookup()
	{
		List list=priceRegBussiness.someRegulation(" and delflag=0 and modelId="+priceReg.getModel().getModel());
		int listSize=list.size();
		try
		{
			if(listSize>0)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加价格调整
	 */
	public String add()
	{
		String mark=request.getParameter("mark");
		System.out.println("mark:"+mark);
		if(mark!=null&&mark.equals("have1")){
			boolean flag0=priceRegBussiness.updateModel(" and model.model="+priceReg.getModel().getModel());
			System.out.println("markFlag:"+flag0);
		}
		System.out.println("pricNo"+priceReg.getPriceRegNo());
		System.out.println("auditing:"+priceReg.getAuditingState());
		boolean flag=priceRegBussiness.addRegulation(priceReg);
		try
		{
			if(flag){
				System.out.println(11111);
				System.out.println(priceReg.getPriceRegNo());
				int marker=audBussiness.addAuditingOrder("PR",priceReg.getPriceRegNo(),"Priceregulation",ck.getCookie(request, "filialemark"));
				System.out.println("marker:"+marker);
				if(marker==0)
					response.getWriter().print("0");
				else if(marker==2)
					response.getWriter().print("2");
				else
					response.getWriter().print("1");
			}
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			logger.error("添加价格调整时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 更新显示
	 */
	public String updateShow()
	{
		String id=request.getParameter("cid");
	    if(id!=null)
	    {
	    	Priceregulation pre=(Priceregulation)priceRegBussiness.someRegulation(" and id="+Integer.parseInt(id)).get(0);
	    	System.out.println("pre:"+pre);
	    	request.setAttribute("oneReg", pre);
	    }
		return "add";
	}
	
	/**
	 * 修改价格记录
	 */
	public String edit()
	{
		boolean flag=priceRegBussiness.editRegulation(priceReg);
		try
		{
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 删除价格记录
	 */
	public String del()
	{
		boolean flag=priceRegBussiness.delRegulation(ids);
		try
		{
			if(flag){
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			logger.error("删除时错误！",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
}
