package com.fuao.fajxc.action.purchasing;
import java.io.IOException;


import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.commodity.BatchBusiness;
import com.fuao.fajxc.bussiness.commodity.CommodityModelBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.bussiness.purchase.ToOrderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Batch;
import com.fuao.fajxc.vo.Batchexp;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.fuao.fajxc.vo.ToOrder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 到货单
 * @author 14015
 *
 */
public class ToOrderAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private ToOrderBussiness toOrderBussiness;
		private PurOrderBussiness purOrderBussiness;
		private CommodityModelBussiness commodityModelBussiness;
		private AuditingBussiness audBussiness;
		private BatchBusiness batchBusiness;
		private HttpServletRequest request;
		private HttpServletResponse response;
		private ToOrder ToOrder;
		//添加动态的业务类
		private ExecuteRecordBussiness executeRecordBussiness;
		
		public ExecuteRecordBussiness getExecuteRecordBussiness() {
			return executeRecordBussiness;
		}

		public void setExecuteRecordBussiness(
				ExecuteRecordBussiness executeRecordBussiness) {
			this.executeRecordBussiness = executeRecordBussiness;
		}

		Cookies ck=new Cookies();

		public CommodityModelBussiness getCommodityModelBussiness() {
			return commodityModelBussiness;
		}

		public void setCommodityModelBussiness(
				CommodityModelBussiness commodityModelBussiness) {
			
			this.commodityModelBussiness = commodityModelBussiness;
		}

		public ToOrderBussiness getToOrderBussiness() {
			return toOrderBussiness;
		}

		public void setToOrderBussiness(ToOrderBussiness toOrderBussiness) {
			this.toOrderBussiness = toOrderBussiness;
		}

		public void setPurOrderBussiness(PurOrderBussiness purOrderBussiness) {
			this.purOrderBussiness = purOrderBussiness;
		}
	

		public void setBatchBusiness(BatchBusiness batchBusiness) {
			this.batchBusiness = batchBusiness;
		}

		public void setAudBussiness(AuditingBussiness audBussiness) {
			this.audBussiness = audBussiness;
		}

		public Object getModel() {
			ToOrder =new ToOrder();
			return ToOrder;
		}
		/**
		 * 得到request
		 */
		public void setServletRequest(HttpServletRequest arg0) {
			this.request=arg0;
			
		}
		
		/**
		 * 得到response
		 */
		public void setServletResponse(HttpServletResponse arg0) {
			this.response=arg0;
			
		}
		
		/*
		 * 添加到货单信息对象
		 */
		public String add(){
			System.out.println("~~~~~~~~~~~~~~~~~~进入添加到货单~~~~~~~~~~~~~~~");
			
			System.out.println("pici : "+ToOrder.getPiciNo());
			String[] purorderinfoid = request.getParameterValues("purorderinfoid"); //采购单详细id数组
			String[] model = request.getParameterValues("model");		
			String[] infoprice = request.getParameterValues("infoprice");
			String[] count = request.getParameterValues("count");
			String[] discount = request.getParameterValues("discount");
			String[] purcount = request.getParameterValues("purcount");
			String[] sum = request.getParameterValues("sum");
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = df.format(new Date());

			try 
			{
				ToOrder.setDelflag("0");
				ToOrder.setToOrderVerify(0);
				ToOrder.setStorageState(0);
				ToOrder toOrder = toOrderBussiness.addReturnData(ToOrder);
				/*阙超强 14015   添加记录动态信息*/
				if(null != toOrder){
					//拿到登陆员工用户
					Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
					//添加记录到动态记录表
					if(loginEmp != null){
						Executerecord executerecord = new Executerecord();
						executerecord.setEmployee(loginEmp);
						executerecord.setContent("添加了一个到货单。");
						executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
						executerecord.setEntityId(toOrder.getId().toString());
						executerecord.setEntityName("ToOrder");
						executerecord.setSeenEmpId("");
						executeRecordBussiness.addData(executerecord);
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			ToOrder toorder = (ToOrder)toOrderBussiness.getObjectList("ToOrder", " and piciNO = '"+ToOrder.getPiciNo()+"'").get(0);
			boolean flag = false;
			//添加批次详细表
			for(int i=0;i<model.length;i++)
			{
				System.out.println(model[i]+"    "+infoprice[i]+"    "+count[i]);
				List<PurOrderInfo> list = purOrderBussiness.getPurOrderInfoById(" and id = "+purorderinfoid[i]);
				PurOrderInfo pInfo = (PurOrderInfo)list.get(0);
				Model m = commodityModelBussiness.getModel(pInfo.getModel().getModel().toString());
				AllType all = (AllType)toOrderBussiness.getObjectList("AllType"," and typeName = '新购入库' ").get(0);
				
				Batchexp exp = new Batchexp();
				exp.setToOrder(toorder);
				exp.setPrice(Double.parseDouble(infoprice[i]));
				exp.setCommodityTpye(m.getCommodityTpye());
				exp.setModel(m);
				exp.setCount(Integer.parseInt(count[i]));
				exp.setAllType(all);
				exp.setDelflag("0");
				exp.setPurcount(Integer.parseInt(purcount[i]));
				exp.setDiscount(Double.parseDouble(discount[i]));
				exp.setSum(Double.parseDouble(sum[i]));
				exp.setAudit("0");
				
				int batchexpresult = batchBusiness.addBatchexp(exp);
				System.out.println("result : "+batchexpresult);
				if(batchexpresult>0)
				{
					int actualcounnt = Integer.parseInt(count[i]);
					if(null != pInfo.getActualcounnt()){
					 actualcounnt = pInfo.getActualcounnt()+Integer.parseInt(count[i]);
					}
					System.out.println("act : "+actualcounnt);
					pInfo.setActualcounnt(actualcounnt);
					flag = purOrderBussiness.updatePurOrderInfo(pInfo);
					System.out.println("flag : "+flag);
				}
				
			}
			if(flag)
			{
				int marker=audBussiness.addAuditingOrder("DH",toorder.getToOrderNum(),"ToOrder",ck.getCookie(request, "filialemark"));
				System.out.println("marker:"+marker);	
			}
			
			
			
			return	"select";
		}
		
		/*
		 * 删除到货单信息对象
		 */
		public void del(){
			try {
				String id=request.getParameter("id");
				ToOrder data=toOrderBussiness.getToOrderdata(id);
				data.setDelflag("1");
				toOrderBussiness.updateData(data);
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个到货单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("ToOrder");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print(1);
			} catch (Exception e) {
				try {
					response.getWriter().print(0);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		
		/*
		 * 更改到货单信息对象
		 */
		public String update(){
			try {
				System.out.println("进入修改页面 ————————————————————");
				
				String[] batchids = request.getParameterValues("batchids");
				String[] model = request.getParameterValues("model");		//采购单详细id数组
				String[] infoprice = request.getParameterValues("infoprice");
				String[] count = request.getParameterValues("count");
				String[] discount = request.getParameterValues("discount");
				String[] purcount = request.getParameterValues("purcount");
				String[] sum = request.getParameterValues("sum");
				System.out.println(batchids.length );
				
				for(int i=0;i<batchids.length;i++)
				{
					Batchexp exp = (Batchexp)batchBusiness.getObjectList("Batchexp", " and id = "+batchids[i]).get(0);
					exp.setPrice(Double.parseDouble(infoprice[i]));
					exp.setCount(Integer.parseInt(count[i]));
					exp.setPurcount(Integer.parseInt(purcount[i]));
					exp.setDiscount(Double.parseDouble(discount[i]));
					exp.setSum(Double.parseDouble(sum[i]));
					
					int result1 = batchBusiness.updateBatchexp(exp);
					System.out.println(batchids[i]+"      "+model[0] );
				}
				
				
				String id=request.getParameter("ToOrderid");
				ToOrder.setId(Integer.parseInt(id));
				ToOrder.setDelflag("0");
				ToOrder.setToOrderVerify(0);
				ToOrder.setStorageState(0);
				toOrderBussiness.updateData(ToOrder);
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("修改了一个到货单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(ToOrder.getId().toString());
					executerecord.setEntityName("ToOrder");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "select";
		}
		
		/*
		 * 根据条件进行筛选查询到货单信息
		 */
		public String getpage(){
			
			String marker2=request.getParameter("marker");
			String taskid=request.getParameter("taskid");
			String id = request.getParameter("id");
			
			request.setAttribute("marker", marker2);
			request.setAttribute("taskid", taskid);
			
			
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String toorderNum = request.getParameter("toorderNum")==null?"":request.getParameter("toorderNum");
			String isList=request.getParameter("is");
			System.out.println("isList is------------------"+isList);
			
			Map map = (Map)ActionContext.getContext().get("map");
			String ToOrderId=request.getParameter("ToOrderId");//到货单主键编号
			String timeb=request.getParameter("timeb");//到货单就建立开始时间
			String timee=request.getParameter("timee");//到货单就建立开始时间
			String hql=" from ToOrder as tb where 1=1 and delflag='0' and storageState = 0";
			
			if(id!=null && !id.equals("")){
				int sid = Integer.parseInt(id);
				hql += " and id="+sid;
			}
			
			if(ToOrderId!=null &&!"".equals(ToOrderId)){
				hql+=( " and tb.id ="+ ToOrderId);
			}
			if(!toorderNum.equals("")||toorderNum!="")
			{
				hql+=" and toOrderNum like '%"+toorderNum+"%'";
			}
			hql+=" order by tb.id desc";
			System.out.println("hql is "+hql);
			Pages pages=toOrderBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			request.getSession().setAttribute("option", map);
			if (isList!=null) {
				return "toorderlist";
			}
			return "listToOrder";
		}
		
		/**
		 * 页面跳转数据
		 * @return
		 */
		public String skippage()
		{
			String mark = request.getParameter("mark");
			System.out.println(" ~~~~~~~~~~~~~~  mark:  "+mark);
			FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
			FileEveryDaySerialNumber serial1 = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
			String no = "DH-";
			String pici = "PC-";
			pici+=serial1.getSerialNumber();
			no +=serial.getSerialNumber(); 	
			
			request.setAttribute("number", no);
			request.setAttribute("pici", pici);
			return "ToOrder";
		}
		
		/*
		 * 获取单个到货单信息对象
		 */
		public String get(){
			try {
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				String id=request.getParameter("id");
				String mark = request.getParameter("mark");
				//获取info的信息
				String info = request.getParameter("info");
				System.out.println("mark : "+mark);
				ToOrder data=toOrderBussiness.getToOrderdata(id);
				List<Batchexp> expList = batchBusiness.getObjectList("Batchexp", " and toOrder.id = "+data.getId()+"");
				
				List<PurOrderInfo> plist = purOrderBussiness.getPurOrderInfoById( " and purOrder.id = "+data.getPurOrder().getId());
				
				request.setAttribute("data", data);
				request.setAttribute("explist", expList);
				request.setAttribute("purorderinfo", plist);

				
			if (null != info && (info == "info" || info.equals("info"))) {

				if (data.getToOrderNum() != null) {
					String addhql2 = " and orderNo='" + data.getToOrderNum()
							+ "'";

					List audList = audBussiness.someauditingOrder(addhql2);
					request.setAttribute("auditingList", audList);
					if (null != audList && audList.size() > 0) {

						String depid = ck.getCookie(request, "departmentId");

						for (int i = 0; i < audList.size(); i++) {

							AuditingOrderTab aot = (AuditingOrderTab) audList
									.get(i);

							if (aot.getDepartment().getId() == Integer
									.parseInt(depid)
									&& aot.getAuditingFlag() == 0) {

								// 表示未审核
								request.setAttribute("flage", 0);

							} else if (aot.getDepartment().getId() == Integer
									.parseInt(depid)
									&& (aot.getAuditingFlag() == 1 || aot
											.getAuditingFlag() == 2)) {

								// 表示已经审核
								request.setAttribute("flage", 1);

								request.setAttribute("aot", aot);

							}
						}

					}
				}
				String empid=ck.getCookie(request, "employeeId");
				System.out.println("ck::::"+empid);
				boolean flag=audBussiness.checkemp(data.getToOrderNum(), empid);
				System.out.println("saleActionflag:::::"+flag);
				if(flag){
					request.setAttribute("mark", "mark");
				}
				boolean flag1=audBussiness.checkemp1(data.getToOrderNum(), empid);
				if(flag1)
				{
					request.setAttribute("quanxian", "quanxian");
				}
				return "selecttoorder";
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "ToOrder";
		}
		
		/**
		 * 改变审核状态
		 * @return
		 */
		public String verifyState()
		{
			String id = request.getParameter("id")==null?"":request.getParameter("id");
			ToOrder order = (ToOrder)toOrderBussiness.getObjectList("ToOrder", " and id = "+id).get(0);
			order.setToOrderVerify(1);
			try 
			{
				boolean flag = toOrderBussiness.updateData(order);
				if(flag)
				{
					response.getOutputStream().print("0");
				}
				else
				{
					response.getOutputStream().print("1");
				}
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			return null;
		}
}
