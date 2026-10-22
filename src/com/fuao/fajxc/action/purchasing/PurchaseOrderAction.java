package com.fuao.fajxc.action.purchasing;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.util.StringUtils;

import com.fuao.fajxc.action.basic.EmployeeAction;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.bussiness.purchase.RequisitioningBusssiness;
import com.fuao.fajxc.bussiness.purchase.ToOrderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Convert;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.ApplyBuy;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Batchexp;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 采购订单Action
 * @author 14012
 *
 */
public class PurchaseOrderAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	private static Logger logger = Logger.getLogger(EmployeeAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private PurOrder purorder;                                    
	private PurOrderBussiness purBussiness;
	private EmployeeBussiness empBussiness;
	private RequisitioningBusssiness requisitioningBusssiness;
	private SupplierBussiness supplierBussiness;
	private ToOrderBussiness toOrderBussiness;
	private AuditingBussiness audBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;
	private Convert ct = new Convert();
//	 String pmtStr=URLDecoder.decode("utf-8");
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	Cookies ck = new Cookies();
	//获得所有型号字符串
	private String mode;
	//获得所有单价字符串
	private String infoprice;
	//获得所有折扣字符串
	private String discount;
	//获得所有数量字符串
	private String count;
	//获得所有总价格字符串
	private String sum;
	
	//要删除的id数组
	private Object[] ids;
	//获得请购单Id数组
	private String allplease;
	//获得采购订单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	
	

	

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	/**
	 * @return the allplease
	 */
	public String getAllplease() {
		return allplease;
	}

	/**
	 * @param allplease the allplease to set
	 */
	public void setAllplease(String allplease) {
		this.allplease = allplease;
	}

	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}
	
	/**
	 * @return the requisitioningBusssiness
	 */
	public RequisitioningBusssiness getRequisitioningBusssiness() {
		return requisitioningBusssiness;
	}

	/**
	 * @param requisitioningBusssiness the requisitioningBusssiness to set
	 */
	public void setRequisitioningBusssiness(
			RequisitioningBusssiness requisitioningBusssiness) {
		this.requisitioningBusssiness = requisitioningBusssiness;
	}

	public void setToOrderBussiness(ToOrderBussiness toOrderBussiness) {
		this.toOrderBussiness = toOrderBussiness;
	}

	/**
	 * @return the mode
	 */
	public String getMode() {
		return mode;
	}

	

	/**
	 * @param mode the mode to set
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * @return the infoprice
	 */
	public String getInfoprice() {
		return infoprice;
	}

	/**
	 * @param infoprice the infoprice to set
	 */
	public void setInfoprice(String infoprice) {
		this.infoprice = infoprice;
	}

	/**
	 * @return the discount
	 */
	public String getDiscount() {
		return discount;
	}

	/**
	 * @param discount the discount to set
	 */
	public void setDiscount(String discount) {
		this.discount = discount;
	}

	/**
	 * @return the count
	 */
	public String getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(String count) {
		this.count = count;
	}

	/**
	 * @return the sum
	 */
	public String getSum() {
		return sum;
	}

	/**
	 * @param sum the sum to set
	 */
	public void setSum(String sum) {
		this.sum = sum;
	}

	
	
	
	/**
	 * @return the supplierBussiness
	 */
	public SupplierBussiness getSupplierBussiness() {
		return supplierBussiness;
	}

	/**
	 * @param supplierBussiness the supplierBussiness to set
	 */
	public void setSupplierBussiness(SupplierBussiness supplierBussiness) {
		this.supplierBussiness = supplierBussiness;
	}

	/**
	 * @return the empBussiness
	 */
	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}

	/**
	 * @param empBussiness the empBussiness to set
	 */
	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}

	/**
	 * @return the purBussiness
	 */
	public PurOrderBussiness getPurBussiness() {
		return purBussiness;
	}

	/**
	 * @param purBussiness the purBussiness to set
	 */
	public void setPurBussiness(PurOrderBussiness purBussiness) {
		this.purBussiness = purBussiness;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}

	public Object getModel() {
		purorder=new PurOrder();
		return purorder;
	}

	/**
	 * 显示采购订单
	 * @return
	 */
	public String get()
	{
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		
 		System.out.println(1111111);
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		//页码
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		String isList=request.getParameter("is");
		System.out.println("isList is------------------"+isList);
		//模糊查找的采购订单编号
		String purNo=request.getParameter("purNo");
		if(purNo!=null){
			addhql+=" and purOrderNo like '%"+purNo+"%'";
		}
		System.out.println("addhql"+addhql);
		String hql="from PurOrder where delflag=0"+addhql;
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+id;
		}
		hql += " order by id desc";
		System.out.println("hql:"+hql);
		System.out.println("pageNo:"+pageNo);
		Pages pages=purBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages"+pages);
		request.setAttribute("pages", pages);
		if (isList!=null) {
			System.out.println(222222);
			return "List";
		}
		return "success";
	}
	/**
	 * 进入添加页面
	 * @return
	 */
	public String addShow()
	{
		//获得采购订单号集合
		String cgouNum="CGO-"+serial.getSerialNumber();
		request.setAttribute("CGO", cgouNum);
		System.out.println(cgouNum);
		//获得供应商集合
		List suppList=supplierBussiness.selSupplier("");
		request.getSession().setAttribute("suppList", suppList);

		return "add";
	}
	
	/**
	 * 添加采购订单
	 * @return
	 */
	public String add()
	{
		System.out.println("add");
		PurOrder flag = this.addAndedit("add");
		
		try
		{
			if(flag != null){
				int marker = audBussiness.addAuditingOrder2("CGO",purorder.getPurOrderNo(),"PurOrder",ck.getCookie(request, "filialemark"));
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
			
			/*添加动态 author 14015*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个采购订单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(flag.getId().toString());
				executerecord.setEntityName("PurOrder");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
		}
		catch(Exception ex)
		{
			logger.error("添加采购订单时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**采购单
	 * 添加和修改共用的方法
	 * @return
	 */
	public PurOrder addAndedit(String addOredit)
	{
		//获得添加返回的返回值
		PurOrder purOrder = null;
		try {
//			String s1=ct.stgConvet(purorder.getAccountType());
//			String s2=ct.stgConvet(purorder.getAccountName());
//			String s3=ct.stgConvet(purorder.getRemarks());
			
			 String s1=URLDecoder.decode(purorder.getAccountType(),"utf-8");
			 String s2=URLDecoder.decode(purorder.getAccountName(),"utf-8");
			 String s3=URLDecoder.decode(purorder.getRemarks(),"utf-8");
			 purorder.setAccountType(s1);
				purorder.setAccountName(s2);
				purorder.setRemarks(s3);
			 
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(purorder.getApplyArray()!=null)
			purorder.setApplyArray(purorder.getApplyArray().substring(0,purorder.getApplyArray().lastIndexOf(",")));	

		if(addOredit.equals("add"))
		{
		
			purOrder = purBussiness.addPurOrderReturn(purorder);
		}
		else
		{
			System.out.println("ID:"+purorder.getId());
			purOrder = purBussiness.addPurOrderReturn(purorder);
			String sedit=request.getParameter("id");
			String addhql=" and purOrderId="+sedit;
			boolean flag2=purBussiness.delPurOrderInfo(addhql);
		}
		
		boolean Infoflag=false;
		if(purOrder != null)
		{
			String[] modes=mode.split("-");
			String[] infoprices=infoprice.split("-");
			String[] discounts=discount.split("-");
			String[] counts=count.split("-");
			String[] sums=sum.split("-");
			for(int i=0;i<modes.length;i++)
			{
				PurOrderInfo pinfo=new PurOrderInfo();
				Model mod=new Model();
				mod.setModel(Integer.parseInt(modes[i]));
				pinfo.setModel(mod);
				pinfo.setPurOrder(purorder);
				pinfo.setCount(Integer.parseInt(counts[i]));
				pinfo.setDiscount(Double.parseDouble(discounts[i]));
				pinfo.setSum(Double.parseDouble(sums[i]));
				pinfo.setPrice(Double.parseDouble(infoprices[i]));
				pinfo.setPriceDelflag(0);
				Infoflag = purBussiness.addPurOrderInfo(pinfo);
			}
		}
		if((purOrder != null) && Infoflag)
		{
			return purOrder;
		}
		return null;
	}
	
	
	
	/**
	 * 查看采购订单详细
	 * @return
	 */
	public String detail()
	{
		String cid=request.getParameter("cid");
		String purNo=request.getParameter("purNo");
		String info = request.getParameter("info");//获得info
		System.out.println("cid"+cid);
		System.out.println("*******************************************");
		System.out.println(purNo);
		if(cid!=null){
			String addhql=" and id="+Integer.parseInt(cid);
			List list=purBussiness.selSomePurOrder(addhql);
			System.out.println("listSize:"+list.size());
			request.setAttribute("cgoList", list.get(0));
			
			//获得请购单
			PurOrder po=(PurOrder) list.get(0);
			String apparray=po.getApplyArray();
			if(apparray!=null&&apparray!=""){
				List list1=requisitioningBusssiness.getObjList("from ApplyBuy where id in ("+apparray+")");
				System.out.println("listSize="+list1.size());
				request.setAttribute("applyList", list1);
			}
			if(null != info && ( info == "info" || info.equals("info"))){
				if(purNo!=null){
					String addhql2=" and orderNo='"+purNo+"'";
					
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
			// 判断当前登录是部门审核还是员工审核？
			
			boolean flag =	audBussiness.checkemp(purNo, empid);//aa
			if(flag)
				request.setAttribute("mark", "mark");
			
			boolean flag1=audBussiness.checkemp1(purNo, empid);
			if(flag1){
				request.setAttribute("quanxian", "quanxian");
			}
			if(purNo!=null){
				String addhql2=" and orderNo='"+purNo+"'";
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
			}
		}
		return "detail";
	}
	
	/**
	 * 删除采购订单
	 * @return
	 */
	public String delete()
	{
		System.out.println("delete");
		boolean flag=purBussiness.delPurOrder(ids);
		try
		{
			if(flag){
				
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了采购订单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("PurOrder");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			logger.error("采购订单删除时错误！",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改采购订单显示
	 * @return
	 */
	public String updateShow()
	{
		//获得供应商集合
		List suppList=supplierBussiness.selSupplier("");
		request.getSession().setAttribute("suppList", suppList);
		//获得用户集合
		List list1=empBussiness.selEmps("");
		request.getSession().setAttribute("empList", list1);
		boolean flag=false;
		String cid=request.getParameter("cid");
		if(cid!=null)
		{
			String addhql=" and id="+Integer.parseInt(cid);
			PurOrder purO=(PurOrder) purBussiness.selSomePurOrder(addhql).get(0);
			request.setAttribute("purList",purO);
		}
		return "add";
	}
	
	/**
	 * 根据采购详细id删除采购订单中的采购详细信息
	 * @return
	 */
	public String delPurInfo()
	{
		String infoId=request.getParameter("infoId");
		if(infoId!=null)
		{
			String addhql=" and id="+Integer.parseInt(infoId);
			boolean flag=purBussiness.delPurOrderInfo(addhql);
			System.out.println("flag"+flag);
			try
			{
				if(flag)
					response.getWriter().print("0");
				else
					response.getWriter().print("1");
			}
			catch(Exception ex)
			{
				logger.error("删除采购详细时出错",ex);
				ex.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 根据采购订单id修改所有采购详细
	 * @return
	 */
	public String edit()
	{
		PurOrder purOrder = this.addAndedit("edit");
		try
		{
			if(purOrder != null){
				response.getWriter().print("0");
				
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个采购订单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(purOrder.getId().toString());
					executerecord.setEntityName("PurOrder");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
			}
			else{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			logger.error("修改采购订单时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	

	/**
	 * 根据purid获取purOrderInfo表中列表
	 * @return
	 */
	public String selectModel()
	{
		response.setContentType("text/html;charset=GBK");
		String purid = request.getParameter("purid");
		List<PurOrderInfo> infoList = purBussiness.getPurOrderInfoById(" and purOrder.id = "+purid);
		String str = "";
		if(purid.length()>0)
		{
			for(int i=0;i<infoList.size();i++)
			{			
				int actualcount = 0;
				int purcount = infoList.get(i).getCount();
				if(null != infoList.get(i).getActualcounnt()){
				 actualcount = infoList.get(i).getActualcounnt();
				}
				if(purcount==actualcount)
				{
					str+="<TR id='tr"+(i+1)+"'>" +
					"<TD align=center height=30 >" +
					"<input type=\"hidden\"  value='"+infoList.get(i).getId()+"'>"+
					"<input type=\"text\" value='"+infoList.get(i).getModel().getName()+"' readonly='readonly'></TD>"+
					"<TD align=center height=30 ><input type=\"text\" name=\"\" onblur='onesum(\""+(i+1)+"\")' value='"+infoList.get(i).getCount()+"' readonly='readonly'></TD>"+
					"<TD align=center height=30 ><input  onblur='onesum(\""+(i+1)+"\")' value='"+actualcount+"' readonly='readonly'></TD>"+ 
					"<TD align=center height=30 ><input type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='0.00' readonly='readonly'></TD>"+
					"<TD align=center height=30 ><input type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='1.0' readonly='readonly'></TD>"+
					"<TD align=center height=30 ><input name='sum' onblur='onesum(\""+(i+1)+"\")' value='0.00' readonly='readonly'></TD>"+
					"<TD align=center height=30 ><input value='到齐' class='button' type='button'  onclick='delTr(\""+(i+1)+"\")' readonly='readonly'/></TD></TR>";
				}
				else
				{
					str+="<TR id='tr"+(i+1)+"'>" +
					"<TD align=center height=30 >" +
					"<input id='purorderinfoid"+(i+1)+"' name='purorderinfoid' type=\"hidden\"  value='"+infoList.get(i).getId()+"'>"+
					"<input id='model"+(i+1)+"' name='model' type=\"text\" value='"+infoList.get(i).getModel().getName()+"'></TD>"+
					"<TD align=center height=30 ><input id='purcount"+(i+1)+"' name='purcount' type=\"text\" name=\"\" onblur='onesum(\""+(i+1)+"\")' value='"+(infoList.get(i).getCount()-actualcount)+"'></TD>"+
					"<TD align=center height=30 ><input id='count"+(i+1)+"' name='count' type=\"text\" name=\"\" onblur='onesum(\""+(i+1)+"\")' value='0'></TD>"+ 
					"<TD align=center height=30 ><input id='infoprice"+(i+1)+"' name='infoprice' type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='0.00'></TD>"+
					"<TD align=center height=30 ><input id='discount"+(i+1)+"' name='discount' type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='1.0'></TD>"+
					"<TD align=center height=30 ><input id='sum"+(i+1)+"' name='sum' type=\"text\" onblur='onesum(\""+(i+1)+"\")' value='0.00'></TD>"+
					"<TD align=center height=30 ><input value='删除' class='button' type='button'  onclick='delTr(\""+(i+1)+"\")' /></TD></TR>";
				}
			}
		}
		System.out.println(str);
	 	PrintWriter pw;
		try {
			pw = response.getWriter();
			if(infoList.size() > 0){
				pw.write(str);
			}else{
				pw.write("");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String getPurModelCount()
	{
		response.setContentType("text/html;charset=GBK");
		System.out.println("======================================");
		String infoid = request.getParameter("infoid");
		List<PurOrderInfo> infoList = purBussiness.getPurOrderInfoById(" and id = "+infoid);
		PurOrderInfo info = infoList.get(0);
		System.out.println("count :"+info.getCount());
	 	PrintWriter pw;
		try {
			pw = response.getWriter();
			if(info.getId() > 0){
				System.out.println("count1 :"+info.getCount());
				pw.write(info.getCount()+"");
			}else{
				pw.write("");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 采购订单中弹出请购单信息
	 * @return
	 */
	public String please()
	{
		String hql="from ApplyBuy where delflag=0 ";
		String dpage=request.getParameter("pageNo");
		int pageNo=1;
		if(dpage != null && !dpage.equals(""))
		{
			 pageNo=Integer.parseInt(dpage);
		}
		String name = request.getParameter("applyBuyNo");
		if(name !=null && !name.equals(""))
		{
			hql +=" and applyBuy like '%"+name+"%'";
		}
		hql+=" order by id desc";
		Pages pages=requisitioningBusssiness.paginationQuery(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		return "please";
	}
	
	/**
	 * 获得所有请购单Id查询所有请购单数据跳转到添加采购单页并读取
	 * @return
	 */
	public String copyId()
	{
		System.out.println("copyId......");
		String addhql="";
		//拿到editTable.js里面传过来的值 allplease（请购ID集合string类型 用 - 隔开）遍历出来成数组
		String[] allP=allplease.split("-");
		for(int i=0;i<allP.length;i++)
		{
			addhql+=allP[i]+",";
		}
		//组装hql语句 据ID查出所有请购单
		addhql=addhql.substring(0, addhql.lastIndexOf(","));
		System.out.println("addhql2:"+addhql);
		
		String hql="from ApplyBuy where id in ("+addhql+")";
		List list=requisitioningBusssiness.getObjList(hql);
		System.out.println("size:"+list.size());
		
		//丢到请求
		request.setAttribute("copyList", list);
		
		//获得采购订单号集合
		String cgouNum="CGO-"+serial.getSerialNumber();
		request.setAttribute("CGO", cgouNum);
		
		//获得登录人信息
		String empName =ck.getCookie(request, "employeeName");
		String empId=ck.getCookie(request,"employeeId");
		
		request.setAttribute("empName", empName);
		request.setAttribute("empId", empId);
		return "add";
	}
	
	public static void main(String[] args)
	{
		String aa="a,b,";
		System.out.println(aa.substring(0,aa.lastIndexOf(",")));
	}

}
