package com.fuao.fajxc.action.purchasing;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.search.FlagTerm;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.DepartmentBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.bussiness.commodity.BatchBusiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.bussiness.purchase.PurReturnOrderBussiness;
import com.fuao.fajxc.bussiness.purchase.ToOrderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Batchexp;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.ReturnOrder;
import com.fuao.fajxc.vo.ReturnOrderInfo;
import com.fuao.fajxc.vo.Supplier;
import com.fuao.fajxc.vo.ToOrder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 采购退换商品Action
 * @author 14012
 *
 */
public class RejectionAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private SupplierBussiness supplierBussiness;
	private PurReturnOrderBussiness purReturnOrderBussiness;
	private EmployeeBussiness empBussiness;
	private DepartmentBussiness departBussiness;
	private ToOrderBussiness toOrderBussiness;
	private BatchBusiness batchBusiness;
	private AuditingBussiness audBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ReturnOrder returnOrder ;
	
	//添加动态记录
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
	
	Cookies ck = new Cookies();
	/**
	 * 增改页面跳转时，需要加载的数据
	 * @return
	 * @author 阙超强 14015 添加注释 2011-12-14
	 */
	@SuppressWarnings("unchecked")
	public String skippage()
	{
		//拿到传过来的采购退货单的ID
		Integer returnorderid = Integer.parseInt(request.getParameter("returnorderid"));
		String mark = request.getParameter("mark");
		String info =request.getParameter("info");
		
		//查询所有供应商
		List<Supplier> list = supplierBussiness.getAllSupplier();
		
		System.out.println(info);
		
		//map 5个
		Map map0 = new HashMap();
		map0.put("服务器配件采购", "服务器配件采购");
		map0.put("办公配件采购", "办公配件采购");
		map0.put("食品酒水采购", "食品酒水采购");
		map0.put("办公电脑采购", "办公电脑采购");
		map0.put("其他采购", "其他采购");
		
		Map map1 = new HashMap();
		map1.put("物流公司", "物流公司");
		map1.put("我方送货", "我方送货");
		map1.put("客户自提", "客户自提");
	
		Map map2 = new HashMap();
		map2.put("质量问题", "质量问题");
		map2.put("运输中损坏", "运输中损坏");
		map2.put("客户原因", "客户原因");
		map2.put("其他原因", "其他原因");
		
		Map map3 = new HashMap();
		map3.put("款到发货", "款到发货");
		map3.put("分期结款", "分期结款");
		map3.put("货到付款", "货到付款");
		
		Map map4 = new HashMap();
		map4.put("现金", "现金");
		map4.put("支票", "支票");
		map4.put("转账", "转账");
		map4.put("电汇", "电汇");
		map4.put("使用预付款", "使用预付款");
		
		//判断是否有供应商
		if(null != list && list.size()>0)
		{
			request.setAttribute("supplierlist", list);
			request.setAttribute("map0", map0);
			request.setAttribute("map1", map1);
			request.setAttribute("map2", map2);
			request.setAttribute("map3", map3);
			request.setAttribute("map4", map4);
			//判断跳转时传递的采购退货单标示ID是否存在
			if(returnorderid>0)
			{
				//根据标示ID拿出对应退货单对象信息
				ReturnOrder order = purReturnOrderBussiness.getObject(" and id = "+returnorderid);
				System.out.println(order.getId());
				//
				List<ReturnOrderInfo> infoList = toOrderBussiness.getObjectList("ReturnOrderInfo", " and returnOrder.id = "+order.getId());
				//拿到批次表详细
				List<Batchexp> exp = batchBusiness.getObjectList("Batchexp", " and toOrder.id in (select id from ToOrder where id = "+order.getToOrder().getId()+")");
				System.out.println("exp:"+exp.size());
				//将退货单信息放入请求
				request.setAttribute("returnorder", order);

				
				String empid=ck.getCookie(request, "employeeId");
				System.out.println("ck::::"+empid);
				boolean flag=audBussiness.checkemp(order.getPurReturnNo(), empid);
				System.out.println("saleActionflag:::::"+flag);
				if(flag){
					request.setAttribute("mark", "mark");
				}
				boolean flag1=audBussiness.checkemp1(order.getPurReturnNo(), empid);
				if(flag1)
				{
					request.setAttribute("quanxian", "quanxian");
				}

				if(mark.equals("find"))
				{
				
					if(null != info && ( info == "info" || info.equals("info"))){
						
						if(order.getPurReturnNo()!=null){
							String addhql2=" and orderNo='"+order.getPurReturnNo()+"'";
							
							List audList=audBussiness.someauditingOrder(addhql2);
							request.setAttribute("auditingList", audList);
							request.setAttribute("explist", exp);
							request.setAttribute("returnorderinfo", infoList);
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
					return "selectreturnorder";
				}
				if(exp.size()>0)
				{
					System.out.println("into exp size ");
					request.setAttribute("infoList", infoList);
				}
			}
			
			return "skippage";
		}
		
		return "failure";
	}
	
	/**
	 * 所有供应商列表
	 * @return
	 */
	public String getSupplierInfo()
	{
		Integer supplierid = Integer.parseInt(request.getParameter("supplierid"));
		Supplier supplier = supplierBussiness.getSupplier(supplierid);
		System.out.println("====================== suppliername + "+supplier.getSupplierName());
		try 
		{
			if(supplier.getId()>0)
			{
				String result = URLDecoder.decode(supplier.getSupplierName()+","+supplier.getMobilePhone()+","+supplier.getSupplierAddress(),"utf-8");
				request.setAttribute("supplier", supplier);
				System.out.println(result);
				response.getWriter().print(result);
			}
		} catch (Exception e) {
		}
		return null;
	}
	
	/**
	 * 添加或修改采购退货单
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String addPurReturnOrder()
	{
		System.out.println("==============================");
		
		try 
		{
			String[] batchexpId = request.getParameterValues("batchexpId"); //采购单详细id数组
			String[] model = request.getParameterValues("model");		
			String[] infoprice = request.getParameterValues("infoprice");
			String[] count = request.getParameterValues("count");
			String[] discount = request.getParameterValues("discount");
			String[] sum = request.getParameterValues("sum");
			
			Integer roid = Integer.parseInt(request.getParameter("returnorderid"));
			
			//添加采购退货单
			if(roid == 0)
			{
				System.out.println(" into roid = 0");
				
				
				if(returnOrder!=null)
				{
					FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
					String no = "CGTH-";
					no +=serial.getSerialNumber(); 
					
					System.out.println(no);
					returnOrder.setPurReturnNo(no);
					returnOrder.setDelflag("0");
					returnOrder.setReturnOrderVerify(0);
					returnOrder.setIsReturn(0);
					boolean result = purReturnOrderBussiness.addPurOrder(returnOrder);
					if(result)
					{
						int marker=audBussiness.addAuditingOrder("CGTH",no,"ReturnOrder",ck.getCookie(request, "filialemark"));
						ReturnOrder returnOrder = purReturnOrderBussiness.getObject(" and purReturnNO = '"+no+"'");
						System.out.println("marker:"+marker);	
						boolean flag = false;
						for(int i=0;i<model.length;i++)
						{
							Batchexp exp = (Batchexp)batchBusiness.getObjectList("Batchexp", " and id = "+batchexpId[i]).get(0);
							ReturnOrderInfo info = new ReturnOrderInfo();
							info.setReturnOrder(returnOrder);
							info.setBatchexp(exp);
							info.setModel(exp.getModel());
							info.setCount(Integer.parseInt(count[i]));
							info.setReturnprice(Double.parseDouble(infoprice[i]));
							info.setDiscount(Double.parseDouble(discount[i]));
							info.setSum(Double.parseDouble(sum[i]));
							info.setRemark("");
							flag = purReturnOrderBussiness.addPurOrderInfo(info);
						}
						if(flag)
						{
							/*阙超强 14015   添加记录动态信息*/
							//拿到登陆员工用户
//							Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
//							//添加记录到动态记录表
//							if(loginEmp != null){
//								Executerecord executerecord = new Executerecord();
//								executerecord.setEmployee(loginEmp);
//								executerecord.setContent("添加了一个采购退货单。");
//								executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
//								executerecord.setEntityId(result.getId().toString());
//								executerecord.setEntityName("ReturnOrder");
//								executerecord.setSeenEmpId("");
//								executeRecordBussiness.addData(executerecord);
//							}
							
							return "select";	
						}
					}
				}
			}
			//修改采购退货单
			if(roid>0)
			{
				System.out.println(" into roid != 0");
				if(returnOrder!=null)
				{
					ReturnOrder ro = purReturnOrderBussiness.getObject(" and id = "+roid);
				
					Department department = departBussiness.getDepartment(returnOrder.getDepartment().getId().toString());
					Employee employee = empBussiness.oneEmp(returnOrder.getEmployee().getId());
					Supplier supplier = supplierBussiness.getSupplier(returnOrder.getSupplier().getId());
					
					ro.setEmployee(employee);
					ro.setDepartment(department);
					ro.setSupplier(supplier);
					ro.setReturnTime(returnOrder.getReturnTime());
					ro.setReturnStyle(returnOrder.getReturnStyle());
					ro.setReturnReason(returnOrder.getReturnReason());
					ro.setReturnDescription(returnOrder.getReturnDescription());
					ro.setReturnTimeLimit(returnOrder.getReturnTimeLimit());
					ro.setPayappoint(returnOrder.getPayappoint());
					ro.setIsBilling(returnOrder.getIsBilling());
					ro.setBillingType(returnOrder.getBillingType());
					ro.setPayType(returnOrder.getPayType());
					ro.setPayAppointType(returnOrder.getPayAppointType());
					ro.setPaytraffic(returnOrder.getPaytraffic());
					ro.setTrafficOrdernum(returnOrder.getTrafficOrdernum());
					ro.setOrderGross(returnOrder.getOrderGross());
					ro.setTrafficcompany(returnOrder.getTrafficcompany());
					ro.setTrafficLinkman(returnOrder.getTrafficLinkman());
					ro.setTrafficphone(returnOrder.getTrafficphone());
					ro.setGrossmoney(returnOrder.getGrossmoney());
					ro.setRemark(returnOrder.getRemark());
					ro.setDelflag("0");
					ro.setBuytype(returnOrder.getBuytype());
					
					boolean result = purReturnOrderBussiness.editPurReturnOrder(ro);
					System.out.println("~~~~~~  result = "+result);
					if(result)
					{
						boolean flag1 = false ;
						List<ReturnOrderInfo> infoList =toOrderBussiness.getObjectList("ReturnOrderInfo", " and returnOrder.id = "+ro.getId());
						if(infoList.size()>0)
						{
							boolean flag = false;
							for(int i=0;i<infoList.size();i++) 						//删除原先详单数据
							{
								flag = purReturnOrderBussiness.deletePurReturnOrderInfo(infoList.get(i));     
							}
							System.out.println("f:"+flag);
							if(flag)
							{
								for(int i=0;i<model.length;i++)						//修改时，重新录入详单数据
								{
									Batchexp exp = (Batchexp)batchBusiness.getObjectList("Batchexp", " and id = "+batchexpId[i]).get(0);
									ReturnOrderInfo info = new ReturnOrderInfo();
									info.setReturnOrder(ro);
									info.setBatchexp(exp);
									info.setModel(exp.getModel());
									info.setCount(Integer.parseInt(count[i]));
									info.setReturnprice(Double.parseDouble(infoprice[i]));
									info.setDiscount(Double.parseDouble(discount[i]));
									info.setSum(Double.parseDouble(sum[i]));
									info.setRemark("");
									flag1 = purReturnOrderBussiness.addPurOrderInfo(info);
								}
							}
						}
						System.out.println("f1:"+flag1);
						if(flag1)
						{
							/*阙超强 14015   添加记录动态信息*/
							//拿到登陆员工用户
							Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
							//添加记录到动态记录表
							if(loginEmp != null){
								Executerecord executerecord = new Executerecord();
								executerecord.setEmployee(loginEmp);
								executerecord.setContent("修改了一个采购退货单。");
								executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
								executerecord.setEntityId(roid.toString());
								executerecord.setEntityName("ReturnOrder");
								executerecord.setSeenEmpId("");
								executeRecordBussiness.addData(executerecord);
							}
							
							return "select";	
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "failure";
	}
	
	/**
	 * 所有采购退货单列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String returnOrderList()
	{
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		List<ReturnOrder> returnorderlist = purReturnOrderBussiness.getObjectList("");
		Map map = (Map)ActionContext.getContext().get("map");
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String returnorderNum = request.getParameter("returnorderNum")==null?"":request.getParameter("returnorderNum");
		String hql="from ReturnOrder as tb where 1=1 and delflag!='1'";
		
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		
		if(!returnorderNum.equals("")||returnorderNum!="")
		{
			hql+=" and purReturnNo like '%"+returnorderNum+"%'";
		}
		hql+="order by tb.id desc";
		Pages pages = toOrderBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("option", map);
		if(null != returnorderlist && returnorderlist.size()>0)
		{
			request.getSession().setAttribute("returnorderlist", returnorderlist);
		}
		return "success";
	}
	
	/**
	 * 删除采购退货单
	 * 0 代表未审核
	 * 1代表审核通过，并且成功删除
	 * 2代表操作错
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String deleteReturnOrder()
	{
		String id = request.getParameter("id");
		try 
		{
			ReturnOrder order = purReturnOrderBussiness.getObject(" and id = "+id);
			boolean flag = false;
			if(order.getIsReturn()==0)
			{
				response.getOutputStream().print("0");			//未审核的单据不能被删除
			}
			else
			{
				List<ReturnOrderInfo> infoList = toOrderBussiness.getObjectList("ReturnOrderInfo", " and returnOrder.id = "+order.getId());
				if(infoList.size()>0)
				{
					boolean flag1 = false;
					//先删除退货详单，再删除退货单
					for(int i=0;i<infoList.size();i++)
					{
						flag1 = purReturnOrderBussiness.deletePurReturnOrderInfo(infoList.get(i));
					}
					if(flag1)
					{
						flag = purReturnOrderBussiness.deletePurReturnOrder(order);
					}
				}
				else
				{
					response.getOutputStream().print("2");
				}
				System.out.println(flag);
				if(flag)
				{
					response.getOutputStream().print("1");		//审核通过才能被删除
				}
				else
				{
					response.getOutputStream().print("2");		//出错，返回一个值
				}
			}
			
		} catch (Exception e) {
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public String selectModel()
	{
		response.setContentType("text/html;charset=GBK");
		String toOrderid = request.getParameter("toOrderid");
		
		List<Batchexp> exp = batchBusiness.getObjectList("Batchexp", " and toOrder.id = "+toOrderid+"");
		String str = "";
		if(exp.size()>0)
		{
			for(int i=0;i<exp.size();i++)
			{
				str+="<TR id='tr"+(i+1)+"'>" +
				"<TD align=center height=30 >" +
				"<input id='batchexpId"+(i+1)+"' name='batchexpId' type=\"hidden\"  value='"+exp.get(i).getId()+"'>"+
				"<input id='model"+(i+1)+"' name='model' type=\"hidden\" value='"+exp.get(i).getModel().getModel()+"'>"+
				"<input id='model"+(i+1)+"' name='modelName' type=\"text\" value='"+exp.get(i).getModel().getName()+"'></TD>"+
				"<TD align=center height=30 ><input id='count"+(i+1)+"' name='count' type=\"text\" name=\"\" onblur='onesum(\""+(i+1)+"\")' value='"+exp.get(i).getCount()+"'></TD>"+ 
				"<TD align=center height=30 ><input id='infoprice"+(i+1)+"' name='infoprice' type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='"+exp.get(i).getPrice()+"'></TD>"+
				"<TD align=center height=30 ><input id='discount"+(i+1)+"' name='discount' type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='"+exp.get(i).getDiscount()+"'></TD>"+
				"<TD align=center height=30 ><input id='sum"+(i+1)+"' name='sum' type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='"+exp.get(i).getSum()+"'></TD>"+
				"<TD align=center height=30 ><input value='删除' class='button' type='button'  onclick='delTr(\""+(i+1)+"\")' /></TD></TR>";
			}
		}
		System.out.println("str : "+str);
		PrintWriter pw = null;
		try 
		{
			pw = response.getWriter();
			if(exp.size()>0)
			{
				pw.print(str);
			}
			else
			{
				pw.print("");
			}
		} catch (Exception e) {
		}
		return null;
	}
	
	public String getBatchexpInfo()
	{
		String batchexpid = request.getParameter("modelid");
		Batchexp exp = (Batchexp)batchBusiness.getObjectList("Batchexp", " and id = "+batchexpid).get(0);
		String str = "";
		PrintWriter pw = null;
		try 
		{
			str += exp.getCount()+","+exp.getPrice()+","+exp.getDiscount()+","+exp.getSum();
			pw = response.getWriter();
			if(!str.equals(""))
			{
				pw.print(str);
			}
			else
			{
				pw.print("");
			}
			
		} catch (Exception e) {
		}
		return null;
	}
	
	/**
	 * 改变审核状态
	 * @return
	 */
	public String verifyState()
	{
		String id = request.getParameter("id")==null?"":request.getParameter("id");
		ReturnOrder order= (ReturnOrder)toOrderBussiness.getObjectList("ReturnOrder", " and id = "+id).get(0);
		order.setReturnOrderVerify(1);
		try 
		{
			boolean flag = purReturnOrderBussiness.editPurReturnOrder(order);
			if(flag)
			{
				response.getOutputStream().print("0");
			}
			else
			{
				response.getOutputStream().print("1");
			}
			
		} catch (Exception e) {
		}
		return null;
	}
	
	
	/**
	 * @param supplierBussiness the supplierBussiness to set
	 */
	public void setSupplierBussiness(SupplierBussiness supplierBussiness) {
		this.supplierBussiness = supplierBussiness;
	}

	public void setPurReturnOrderBussiness(
			PurReturnOrderBussiness purReturnOrderBussiness) {
		this.purReturnOrderBussiness = purReturnOrderBussiness;
	}

	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	public void setDepartBussiness(DepartmentBussiness departBussiness) {
		this.departBussiness = departBussiness;
	}

	public void setToOrderBussiness(ToOrderBussiness toOrderBussiness) {
		this.toOrderBussiness = toOrderBussiness;
	}

	public void setPurOrderBussiness(PurOrderBussiness purOrderBussiness) {
	}

	public void setBatchBusiness(BatchBusiness batchBusiness) {
		this.batchBusiness = batchBusiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	public Object getModel() {
		returnOrder = new ReturnOrder();
		return returnOrder;
	}
	public String get()
	{
		return "success";
	}

}
