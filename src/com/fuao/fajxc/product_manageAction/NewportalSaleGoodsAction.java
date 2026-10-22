package com.fuao.fajxc.product_manageAction;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import test.StringUtil;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.server.UpserverBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.product_manageDao.prodect_OrderDao;
import com.fuao.fajxc.product_manageService.Product_orderService;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.PageBuilder;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.City;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Freeze;
import com.fuao.fajxc.vo.GoodsClass_expand;
import com.fuao.fajxc.vo.Goods_dict;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Operate;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.PurOrderInfo;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.SaleGoods_mids;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.ToOrder;
import com.fuao.fajxc.vo.ToOrderprinfo;
import com.fuao.fajxc.vo.Tresourcecheck;
import com.fuao.fajxc.vo.UpServer;
import com.fuao.fajxc.vo.VerifyOrderEmployee;
import com.fuao.fajxc.vo.Workorder;
import com.fuao.fajxc.vo.WorkpositionEmployee;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;
import com.sun.org.apache.xerces.internal.dom.AttrImpl;

/*
 * 新系统3.0改编
 * author:wangxiong
 * email:wangxiong@fuao...
 * time:2013.1.19
 */

public class NewportalSaleGoodsAction extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(NewportalSaleGoodsAction.class);

	private HttpServletRequest request;
	private HttpServletResponse response;
	private Product_orderService product_CommentService;
	private prodect_OrderDao pdao;
	private String saleName;// 商品名称
	private String sgcode;// 商品编码
	private String startMoney;// 商品起始价格
	private String endMoney;// 商品价格
	private String startVolume;// 总销量起始
	private String endVolume;// 总销量结束
	private Object[] ids;// 要删除的id
	private String cusname;// 客户名称
	private String customerCompany;// 客户公司名称
	private String vendition;// 业务负责人
	private String empname;// 员工姓名
	private Sale_orders orders;// 订单
	private String soNum;// 订单号
	private String soStat;// 订单状态
	private String curName;// 客户名称
	private UpServer ups;
	private UpserverBussiness upb;
	public ExecuteRecordBussiness executeRecordBussiness;
	private AuditingBussiness audBussiness;
	private Object[] objs;
	Cookies ck = new Cookies();

	private String rvid;// 核实单编号
	private String empnames;// 申请人
	private String depotid;// 仓库id
	private String strempname;
	private String demo;
	private String soNums;

	// 获得上架单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
			"EveryDaySerialNumber.dat");

	
	/*
	 * 订单商品详细
	 */
	public String sodetailSg()
	{
		try {
			String soId = request.getParameter("soId");
			String hql = "from Sale_orders as so where 1=1 and so.soId="+new Integer(soId);
			Sale_orders orders = (Sale_orders) pdao.execHQL(hql).get(0);
			request.setAttribute("so",orders);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "sodetailSg";
	}
	
	/*
	 * 生成工单
	 */
	public String updConkout()
	{
		try {
			String soId = request.getParameter("soId");
			String hql = "from UpServer as u where 1=1 and u.soOrders.soId="+new Integer(soId);
			UpServer ser = (UpServer) pdao.execHQL(hql).get(0);
			
			UpServer upse = (UpServer)upb.getObjectById(UpServer.class, ser.getId());
			int soid = upse.getSoOrders().getSoId();
			Sale_orders so = (Sale_orders)upb.getObjectById(Sale_orders.class, soid);
			so.setSoStat(5);
			upb.updateObj(so);
			int a = upse.getConkout().getId();
			System.out.println(a);
			Questioncategory qu = (Questioncategory)upb.getObjectById(Questioncategory.class, 7);
			ConkOut oldconk = (ConkOut)upb.getObjectById(ConkOut.class, a);
			oldconk.setState("0");
			oldconk.setStatus(0);
			oldconk.setBzf(0);
			oldconk.setProudcotType(qu);
//			con.setState("0");  //客户已提交
			upb.updateObj(oldconk);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 生成工单(袁天龙)
	 * @return
	 */
	public String addCon(){
		String soId = request.getParameter("soId");
		String hql = "from UpServer as u where 1=1 and u.soOrders.soId="+new Integer(soId);
		UpServer upserver = (UpServer) pdao.execHQL(hql).get(0);
		int customerid = upserver.getSoOrders().getCustomer().getCustomerId();
		
		
		ConkOut con = new ConkOut();
		Conkoutask coa = new Conkoutask();
		String conkOutNo = "KF-"+serial.getSerialNumber();
		con.setConkOutNo(conkOutNo);  //故障单号
		Customer customer2 = (Customer)upb.getObjectById(Customer.class, upserver.getSoOrders().getCustomer().getCustomerId());
		con.setCustomer(customer2);
		
		con.setState("0");  // 0:客户提交初始状态  1:客服接收 2:提交到运维 3:运维处理完成 4:客户确认,已处理
		con.setDescs("上架单故障处理");
		con.setDelflag("0");
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = new Date();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		con.setFaultTime(new java.sql.Timestamp(new java.util.Date().getTime()));
		Questioncategory q = (Questioncategory)upb.getObjectById(Questioncategory.class,7);
		Product prop = (Product)upb.getObjectById(Product.class, 6);
		con.setIssueType(q);
		con.setIp("no");
		con.setCustomerphone(upserver.getSoOrders().getCustomer().getPhone());  //电话号码
		con.setEmail(upserver.getSoOrders().getCustomer().getEmail());  //邮箱
		con.setProduct(prop);
//		con.setWdnr("暂无");
//		con.setEmail("暂无");
		con.setUpserverid(upserver.getId());
//		con.setState("100");
		con.setStatus(0);
		con.setBzf(0);
		upb.addUpserver(con);
		System.out.println(con.getId());
		upserver.setConkout(con);
		System.out.println(upserver.getId());
		upb.updateObj(upserver);
		
		Date dt = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		coa.setDescs(con.getDescs());
		coa.setFaultTime(sd.format(dt));
		coa.setState(0);
		coa.setConkout(con);
		upb.addUpserver(coa);
		
		//工单生成后,需要更改该上架单对应订单的状态:客服待接收
		Sale_orders so = upserver.getSoOrders();
		so.setSoStat(5);  //状态为5,客服待接收
		upb.updateObj(so);
		
		return null;
	}
	
	
	/*
	 * 修改状态
	 */
	public String updatestat()
	{
		try {
			String soId = request.getParameter("soId");
			String sql = "update sale_orders set so_stat =13 where so_id="+soId;
			boolean flag = pdao.updateRC(sql);
			if(flag ==true)
			{
				logger.info("success");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 *  修改单价
	 */
	public String updateprices()
	{
		try {
			String soId = request.getParameter("soId");
			String sgId = request.getParameter("sgId");
			String prices = request.getParameter("prices");
			String count = request.getParameter("count");//个数
			String devprice = request.getParameter("delprice");//商品价格
			String delprice = request.getParameter("devprice");//邮费
			
			double moneys =  new Double(devprice) * new Integer(count);
			moneys += new Double(delprice);
			String updso = "update sale_orders set sg_price ="+moneys +" , prices ="+new Double(devprice) +" where 1=1 and so_id ="+ new Integer(soId);
			
			boolean falg = pdao.updateRC(updso);
			if(falg ==true)
			{
				logger.info("update success");
			}
		} catch (Exception e) {
			logger.error("updateprices"+NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * 修改邮费的价格
	 */
	public String updatedevliprice()
	{
		try {
			String soId = request.getParameter("soId");
			String sgId = request.getParameter("sgId");
			String prices = request.getParameter("prices");
			String count = request.getParameter("count");
			String devprice = request.getParameter("delprice");
			
			String hqls = "from Sale_orders as s where 1=1 and soId = "+new Integer(soId);
			Sale_orders saleOrders = (Sale_orders) pdao.execHQL(hqls).get(0);
			double price1 = 0.0;
			String updso = "update sale_orders " ;
			if(saleOrders.getDevilvprice()>new Double(devprice))
			{
				price1 = saleOrders.getDevilvprice() - new Double(devprice);
				double price = saleOrders.getSgPrice();
				price -= price1;
				updso += " set sg_price="+price +" , devilvprice ="+new Double(devprice) +" ";
			}else
			{
				price1 = new Double(devprice) -saleOrders.getDevilvprice() ;
				double price =  saleOrders.getSgPrice();;
				price += price1;
				updso += " set sg_price="+price +" , devilvprice ="+new Double(devprice) +" ";
			}
			updso += " where 1=1 and so_id="+new Integer(soId);
//			double price = new Double(prices) * new Integer(count);
//			price += new Double(devprice);
			logger.info(updso);
			
			boolean falg = pdao.updateRC(updso);
			if(falg == true)
			{
				logger.info("update success");
			}
		} catch (Exception e) {
			logger.error("updatedevliprice"+NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * 修改价格
	 */
	public String updateSgAndSo()
	{
		try {
			String soId = request.getParameter("soId");
			String sgId = request.getParameter("sgId");
			String prices = request.getParameter("prices");
			String count = request.getParameter("count");
			String devprice = request.getParameter("devprice");
			
			
//			String updsg = "update sale_goods set sg_price ="+new Double(prices)+" where 1=1 and sg_id = "+ new Integer(sgId);
			
//			boolean falg1 = pdao.updateRC(updsg); 
//			double sgprice = new Double(prices)*new Integer(count);
//			sgprice += new Double(devprice);
			String updso = "update sale_orders set sg_price ="+new Double(prices) +" where 1=1 and so_id = "+ new Integer(soId);
			boolean falg2 = pdao.updateRC(updso);
			if(falg2 ==true)
			{
				logger.info("success update");
			}
		} catch (Exception e) {
			logger.info("updateSgAndSo"+NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * 提交订单审核
	 */
	public String submitsg()
	{
		try {
			logger.info("start submitsg");
			String soid = request.getParameter("soId");
			String hqls = "from Sale_orders as s where 1=1 and soId = "+new Integer(soid);
			
			Sale_orders saleOrders = (Sale_orders) pdao.execHQL(hqls).get(0);
			String statchang = saleOrders.getStatchang().toString();
			
			String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='XXTXSDD'";
			List list = pdao.execHQL(hql);
			if(null != list && 0<list.size() && null !=statchang && "1".equals(statchang))
			{
				// 添加审批
				int marker = product_CommentService.addAuditingOrder2("XXTXSDD",
						saleOrders.getSoNums(), "Sale_orders", ck.getCookie(
								request, "filialemark"));
				logger.info(marker);
				
				String updso = "update sale_orders set statchang =0 where 1=1 and so_id ="+new Integer(soid);
				boolean falg = pdao.updateRC(updso);
				if(falg == true)
				{
					logger.info("update success");
				}
			}
			else
			{
				String upsql = "update sale_orders set so_stat =3 ,statchang =0 where 1=1 so_id ="+saleOrders.getSoId();
				boolean falg = pdao.updateRC(upsql);
			}
		} catch (Exception e) {
			logger.error("submitsg"+NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "selectso";
	}
	
	
	/*
	 * 修改收获的地址UI
	 */
	public String updateaddressUI() {
		try {
			String addressid = request.getParameter("addressid");
			String cusid = request.getParameter("cusid");
			request.setAttribute("cusid", cusid);
			String hqls = "from DeliveryAddress as da where 1=1 and da.addressId="
					+ new Integer(addressid);
			DeliveryAddress address = (DeliveryAddress) pdao.execHQL(hqls).get(
					0);

			String chengshi = "";
			String city = "";
			String qu = "";
			if (null != address.getNetherlands()
					&& !"".equals(address.getNetherlands())) {
				String[] addr = address.getNetherlands().trim().split(" ");
				chengshi = addr[0];
				city = addr[1];
				qu = addr[2];

			}
			String dianhua1 = "";
			String dianhua2 = "";
			if (null != address.getPhones() && !"".equals(address.getPhones())) {
				String[] dianhua = address.getPhones().trim().split("-");
				dianhua1 = dianhua[1];
				dianhua2 = dianhua[2];

			}
			request.setAttribute("dianhua1", dianhua1);
			request.setAttribute("dianhua2", dianhua2);
			request.setAttribute("province3", chengshi.trim());
			request.setAttribute("city3", city.trim());
			request.setAttribute("area3", qu.trim());

			request.setAttribute("address", address);
		} catch (Exception e) {
			logger.error("updateaddress"
					+ NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "updaddress";
	}

	/*
	 * 修改收获的地址
	 */
	public String updateaddress() {
		try {
			// 修改的ID
			String addressid = request.getParameter("addressid");
			// 市
			String shi = URLDecoder
					.decode(request.getParameter("shi"), "utf-8");
			// 省
			String sheng = URLDecoder.decode(request.getParameter("sheng"),
					"utf-8");
			// 区
			String qu = URLDecoder.decode(request.getParameter("qu"), "utf-8");
			// 邮编
			String youbian = request.getParameter("youbian");
			// 街道地址
			String jiedao = URLDecoder.decode(request.getParameter("jiedao"),
					"utf-8");
			// 姓名
			String xingming = URLDecoder.decode(request
					.getParameter("xingming"), "utf-8");
			// 电话
			String dianhua = request.getParameter("dianhua");
			// 手机
			String shouji = request.getParameter("shouji");
			// 客户的ID
			String cusid = request.getParameter("cusid");

			String hqlcus = "from Customer as c where 1=1 and c.customerId ="
					+ new Integer(cusid);
			Customer customer = (Customer) this.pdao.execHQL(hqlcus).get(0);

			String updress = "update delivery_address set netherlands= '"
					+ (shi + " " + sheng + " " + qu)
					+ "' , particular_address ='" + jiedao + "',consignee='"
					+ xingming + "',mobile='" + shouji + "',phone='" + dianhua
					+ "',postalcode='" + youbian + "' where address_id ="
					+ new Integer(addressid);
			boolean flag = pdao.updateRC(updress);
			if (flag == true) {
				// 重新查询一边改客户的地址
				String hql = "from DeliveryAddress as da where 1=1 and da.customer.customerId";
				if (cusid != null && !cusid.equals("")) {
					hql += "=" + new Integer(cusid);
				} else {
					hql += "=" + 0;
				}
				List listda = pdao.execHQL(hql);
				String strTemp = "<table width='100%'  border='0' cellspacing='0' cellpadding='0' id='newaddressid' style='font-size: 12px;'>";

				if (listda != null && listda.size() > 0) {
					for (int i = 0; i < listda.size(); i++) {
						DeliveryAddress address = (DeliveryAddress) listda
								.get(i);
						if (address.getDef() != null
								&& "1".equals(address.getDef())) {
							strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
									+ "<td width='91%' align='left' class='td_center'>"
									+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='"
									+ address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ " ("
									+ address.getConsignee()
									+ "收)   "
									+ address.getMobile() + "' />";
							strTemp += address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ " ("
									+ address.getConsignee()
									+ "收)   "
									+ address.getMobile()
									+ "默认地址 &nbsp;<a href='javascript:void(0);' class='lv' onclick='changaddress("
									+ address.getAddressId() + ","
									+ customer.getCustomerId()
									+ ");'>修改本地址</td></tr>";
						}

						// String defaultress =
						// address.getNetherlands()+"|"+address.getParticularAddress()+"|("+address.getConsignee()+")  "+address.getmo;\
						if (address.getDef() != null
								&& !"1".equals(address.getDef())) {
							strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td><td width='91%' align='left' class='td_center'>"
									+ "<input name='radio' type='radio' value='"
									+ address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ "("
									+ address.getConsignee()
									+ "收)"
									+ address.getMobile()
									+ "' id='address' onclick='onclickshow();' />"
									+ "<span id='cuscomaddress'>"
									+ address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ "("
									+ address.getConsignee()
									+ "收)"
									+ address.getMobile()
									+ ""
									+ "</span>&nbsp;&nbsp;设为<a href='javascript:void(0);' onclick='defaultaddress("
									+ address.getAddressId()
									+ ","
									+ customer.getCustomerId()
									+ ");'>默认地址 </a>&nbsp;&nbsp;"
									+ "<a href='javascript:void(0);' class='lv' onclick='changaddress("
									+ address.getAddressId()
									+ ","
									+ customer.getCustomerId()
									+ ");'>修改本地址</a></td></tr>";
						}
					}
				} else {
					strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
							+ "<td width='91%' align='left' class='td_center'>"
							+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='radio' />无收获地址</td></tr>";
				}
				strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td>"
						+ "<td width='91%' align='left' class='td_center'>"
						+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='wu' />"
						+ "无(虚拟地址)</td></tr></table>";
				response.setCharacterEncoding("utf-8");
				response.getWriter().print(strTemp);
			}
		} catch (Exception e) {
			logger.error("updateaddress"
					+ NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 设置为默认的地址
	 */
	public String defaultAddress() {
		try {
			// 地址
			String addressid = request.getParameter("addressid");
			// cusid客户地址
			String cusid = request.getParameter("cusid");
			String hqlcus = "from Customer as c where 1=1 and c.customerId ="
					+ new Integer(cusid);
			Customer customer = (Customer) this.pdao.execHQL(hqlcus).get(0);

			String hqls = "from DeliveryAddress as da where 1=1 and da.addressId="
					+ new Integer(addressid);

			DeliveryAddress address1 = (DeliveryAddress) pdao.execHQL(hqls)
					.get(0);

			// String defaultress =
			// address1.getNetherlands()+" "+address1.getParticularAddress()+" ("+address1.getConsignee()+"收)   "+address1.getMobile();

			// update
			boolean flag = pdao.update(cusid, addressid);

			if (flag == true) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}

			// if(flag ==true)
			// {
			// String hql =
			// "from DeliveryAddress as da where 1=1 and da.customer.customerId";
			// if (cusid != null && !cusid.equals("")) {
			// hql += "=" + new Integer(cusid);
			// } else {
			// hql += "=" + 0;
			// }
			// List listda = pdao.execHQL(hql);
			// String strTemp =
			// "<table width='100%'  border='0' cellspacing='0' cellpadding='0' id='newaddressid' style='font-size: 12px;'>";
			//						
			//						
			// if (listda != null && listda.size() > 0) {
			// for (int i = 0; i < listda.size(); i++)
			// {
			// DeliveryAddress address = (DeliveryAddress) listda.get(i);
			//						
			// if(address.getDef() != null && "1".equals(address.getDef()))
			// {
			// strTemp +=
			// "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
			// + "<td width='91%' align='left' class='td_center'>"
			// +
			// "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='radio' />";
			// strTemp +=
			// address.getNetherlands()+" "+address.getParticularAddress()+" ("+address.getConsignee()+"收)   "+address.getMobile()+"默认地址 &nbsp;修改本地址</td></tr>";
			// }
			// // String defaultress =
			// address.getNetherlands()+"|"+address.getParticularAddress()+"|("+address.getConsignee()+")  "+address.getmo;
			// if(address.getDef() != null && !"1".equals(address.getDef()))
			// {
			// strTemp +=
			// "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td><td width='91%' align='left' class='td_center'>"
			// + "<input name='radio' type='radio' value='"
			// + address.getNetherlands()+" " + address.getParticularAddress()
			// + "("
			// + address.getConsignee()
			// + "收)"
			// + address.getMobile()
			// + "' id='address' onclick='onclickshow();' />"
			// + "<span id='cuscomaddress'>"
			// + address.getNetherlands()+" " + address.getParticularAddress()
			// + "("
			// + address.getConsignee()
			// + "收)"
			// + address.getMobile()
			// + ""
			// +
			// "</span>&nbsp;&nbsp;设为<a href='javascript:void(0);' onclick='defaultaddress('"+address.getAddressId()+"','"+customer.getCustomerId()+"');'>默认地址 </a>&nbsp;&nbsp;&nbsp;"
			// + "<a href='javascript:void(0);'>修改本地址</a></td></tr>";
			// }
			// }
			// } else {
			// strTemp +=
			// "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
			// + "<td width='91%' align='left' class='td_center'>"
			// +
			// "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='radio' />无默认地址</td></tr><tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td><td width='91%' align='left' class='td_center'><input name='radio' type='radio' onclick='onclickshow();'  value='noaddress' />无收获地址!</td></tr>";
			// }
			// strTemp +=
			// "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td>"
			// + "<td width='91%' align='left' class='td_center'>"
			// +
			// "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='wu' />"
			// + "无</td></tr></table>";
			// response.setCharacterEncoding("utf-8");
			// response.getWriter().print(strTemp);
			// }
			// else
			// {
			// response.getWriter().print("2");
			// }
			// request.setAttribute("address", address);
			// String hqlcus = "";
		} catch (Exception e) {
			logger.error("defaultAddress"
					+ NewportalSaleGoodsAction.class.getName());
		}
		return null;
	}

	/*
	 * 使用新的地址
	 */
	public String newaddress() {
		try {
			// 市
			String shi = URLDecoder
					.decode(request.getParameter("shi"), "utf-8");
			// 省
			String sheng = URLDecoder.decode(request.getParameter("sheng"),
					"utf-8");
			// 区
			String qu = URLDecoder.decode(request.getParameter("qu"), "utf-8");
			// 邮编
			String youbian = request.getParameter("youbian");
			// 街道地址
			String jiedao = URLDecoder.decode(request.getParameter("jiedao"),
					"utf-8");
			// 姓名
			String xingming = URLDecoder.decode(request
					.getParameter("xingming"), "utf-8");
			// 电话
			String dianhua = request.getParameter("dianhua");
			// 手机
			String shouji = request.getParameter("shouji");
			// cusid
			String cusid = request.getParameter("cusids");

			// 往delivaddress添加一条数据
			String hqlcus = "from Customer as c where 1=1 and c.customerId ="
					+ new Integer(cusid);
			Customer customer = (Customer) this.pdao.execHQL(hqlcus).get(0);
			DeliveryAddress address1 = new DeliveryAddress();
			address1.setCustomer(customer);
			address1.setConsignee(xingming);
			address1.setNetherlands(shi + " " + sheng + " " + qu);
			address1.setParticularAddress(jiedao);
			address1.setMobile(shouji);
			address1.setPhones(dianhua);
			address1.setPostalcode(youbian);
			address1.setDef("0");

			DeliveryAddress ress = pdao.add(address1);
			if (ress != null) {
				String str = shi + " " + sheng + " " + qu + " " + jiedao + " "
						+ xingming + "(收) " + shouji;
				String hql = "from DeliveryAddress as da where 1=1 and da.customer.customerId";
				if (cusid != null && !cusid.equals("")) {
					hql += "=" + new Integer(cusid);
				} else {
					hql += "=" + 0;
				}
				List listda = pdao.execHQL(hql);
				String strTemp = "<table width='100%'  border='0' cellspacing='0' cellpadding='0' id='newaddressid' style='font-size: 12px;'>";

				if (listda != null && listda.size() > 0) {
					for (int i = 0; i < listda.size(); i++) {
						DeliveryAddress address = (DeliveryAddress) listda
								.get(i);
						if (address.getDef() != null
								&& "1".equals(address.getDef())) {
							strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
									+ "<td width='91%' align='left' class='td_center'>"
									+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='"
									+ address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ " ("
									+ address.getConsignee()
									+ "收)   "
									+ address.getMobile() + "' />";
							strTemp += address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ " ("
									+ address.getConsignee()
									+ "收)   "
									+ address.getMobile()
									+ "默认地址 &nbsp;<a href='javascript:void(0);' class='lv' onclick='changaddress("
									+ address.getAddressId() + ","
									+ customer.getCustomerId()
									+ ");'>修改本地址</td></tr>";
						}

						// String defaultress =
						// address.getNetherlands()+"|"+address.getParticularAddress()+"|("+address.getConsignee()+")  "+address.getmo;\
						if (address.getDef() != null
								&& !"1".equals(address.getDef())) {
							strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td><td width='91%' align='left' class='td_center'>"
									+ "<input name='radio' type='radio' value='"
									+ address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ "("
									+ address.getConsignee()
									+ "收)"
									+ address.getMobile()
									+ "' id='address' onclick='onclickshow();' />"
									+ "<span id='cuscomaddress'>"
									+ address.getNetherlands()
									+ " "
									+ address.getParticularAddress()
									+ "("
									+ address.getConsignee()
									+ "收)"
									+ address.getMobile()
									+ ""
									+ "</span>&nbsp;&nbsp;设为<a href='javascript:void(0);' onclick='defaultaddress("
									+ address.getAddressId()
									+ ","
									+ customer.getCustomerId()
									+ ");'>默认地址 </a>&nbsp;&nbsp;"
									+ "<a href='javascript:void(0);' class='lv' onclick='changaddress("
									+ address.getAddressId()
									+ ","
									+ customer.getCustomerId()
									+ ");'>修改本地址</a></td></tr>";
						}
					}
				} else {
					strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
							+ "<td width='91%' align='left' class='td_center'>"
							+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='radio' />无收获地址</td></tr>";
				}
				strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td>"
						+ "<td width='91%' align='left' class='td_center'>"
						+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='wu' />"
						+ "无(虚拟地址)</td></tr></table>";
				response.setCharacterEncoding("utf-8");
				response.getWriter().print(strTemp);
			} else {
				response.getWriter().print("2");
			}

		} catch (Exception e) {
			logger.error("newaddress"
					+ NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 查询库存中的商品
	 */
	public String findpro() {
		try {
			String commid = request.getParameter("commid");
			String strTemp = "";
			String hqlmodel = "from Model as sg where 1=1 ";
			if (commid != null && !commid.equals("")) {
				hqlmodel += " and sg.commodityTpye.id=" + new Integer(commid);
			}
			int count = 0;
			Map productMap = new HashMap();
			List listmodel = pdao.execHQL(hqlmodel);
			OK: if (listmodel != null && listmodel.size() > 0) {
				for (int i = 0; i < listmodel.size(); i++) {
					Model model = (Model) listmodel.get(i);
					String hqlproty = "from Property as pp where 1=1 and pp.model.model ="
							+ model.getModel();
					List listproty = pdao.execHQL(hqlproty);
					if (listproty != null && listproty.size() > 0) {
						for (int m = 0; m < listproty.size(); m++) {
							Property property = (Property) listproty.get(m);
							String hqlproducts = "select id,propertyId,usestate,useSum,barcode ,depotId,storageInfoId,count(*)" +
							" as num from product where propertyId="+ property.getId()+" and usestate=2 GROUP BY propertyId,depotId";
							List listproduct = pdao.execSQL(hqlproducts);

							if (listproduct != null && listproduct.size() > 0) {
								for (int n = 0; n < listproduct.size(); n++) {
									if (count >= 6) {
										break OK;
									}
									Object [] goods = (Object[]) listproduct.get(n);
									
									strTemp += "<li><table width='100%' border='0' cellspacing='8' cellpadding='0'>"
											+ "<tr><td><input type='checkbox' name='checkbox' value='"
											+ goods[0]
											+ "'  id='pro"
											+ goods[0]
											+ "sss' /><label for='checkbox'></label>"
											+ "</td><td title='"
											+ property.getName()
											+ "' style='CURSOR:pointer;'>";
									if (property.getName()
											.toString().length() > 10) {
										strTemp += property
												.getName().substring(0, 12);
									} else {
										strTemp += property
												.getName();
									}
									String hqldept = "from Depot as d where 1=1 and d.id = "+new Integer(goods[5].toString());
									Depot depot = (Depot) pdao.execHQL(hqldept).get(0);
									strTemp += "</td>"
									// +"<td>可用"+goods.getSgInventory()+"</td>"
											+ "<td>"
											+ depot.getName()
											+ "</td>"
											+ "<td align='right'>可用"
											+ goods[7]
											+ "台</td>"
											+ "<input type='hidden' id='pro"
											+ goods[0]
											+ "zong' value='"
											+ goods[7]
											+ "'/>"
											+ "<input type='hidden' id='pro"
											+ goods[0]
											+ "name' value='"
											+ property.getName()
											+ "'/>"
											+ "<input type='hidden' id='pro"
											+ goods[0]
											+ "dept' value='"
											+ depot.getName()
											+ "'/>"
											+ "<input type='hidden' id='showcommid' value='"
											+ commid
											+ "'/>"
											+ "<td align='center'><label for='textfield'></label>"
											+ "<img src='potal/images/ss_-.png' id='pro"
											+ goods[0]
											+ "'  style='CURSOR:pointer;' width='11' height='11' onclick='onclickCur(this);' />"
											+ "<input name='textfield' value='1' type='text' id='pro"
											+ goods[0]
											+ "s' size='2' width=25px />"
											+ "<img src='potal/images/ss_+.png' id='pro"
											+ goods[0]
											+ "ss' style='CURSOR:pointer;' onclick='onclickadd(this);' width='11' height='11' />"
											+ "</td></tr></table></li>";
									count++;
								}
							}
						}
					}
				}
			}
			strTemp += "`" + commid;
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(strTemp);
		} catch (Exception e) {
			logger.error("findpro" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
			return "error";
		}
		return null;
	}

	/*
	 * 资源搜索
	 */
	public String findCommRC() {
		try {
			String rcname = request.getParameter("rcname");
			String demo = request.getParameter("demo");
			if (null == demo) {
				demo = "2";
			}
			// StringBuffer hqlcomm = new StringBuffer();
			String hqlcomm = "from CommodityTpye as ct where 1=1 ";

			if (null != rcname && !"".equals(rcname)) {
				String str = URLDecoder.decode(rcname, "utf-8");
				hqlcomm += " and ct.typeName like '%" + str + "%'";
			} else {
				hqlcomm += " and ct.id in(0)";
			}
			List list = new ArrayList();
			List listcomm = this.pdao.execHQL(hqlcomm);
			String strTemp = "";
			// 为不确认为第几栏目,只查找三级
			strTemp += "<div class='xb_sst'>您搜索的结果如下：（找到"
					+ listcomm.size()
					+ "条相关匹配项）</div><div class='xb_ssbd'>"
					+ "<table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0'>";
			if (null != listcomm && 0 < listcomm.size()) {
				// 循环查找上级是否还有父级栏目
				for (int i = 0; i < listcomm.size(); i++) {
					CommodityTpye commodityTpye = (CommodityTpye) listcomm
							.get(i);
					if (null != commodityTpye) {
						logger
								.info(commodityTpye.getId().toString()
										+ "...."
										+ commodityTpye.getSuperid().getId()
												.toString());
						if (commodityTpye.getId().toString().equals(
								commodityTpye.getSuperid().getId().toString())) {
							// 说明没有父级的栏目了.这就到头了不用在往下面去 查找了
							strTemp += "<tr style='font-size: 12px;'><td class='xb_tdwz'><a href ='javascript:void(0);' style='text-decoration: none;color: black;'>查无数据</a></td><td>&nbsp;</td></tr>";
						} else {
							// 说明有父级的栏目，根据这个父id查找
							String sqlcomm2 = " from CommodityTpye as ct where 1=1 and ct.id ="
									+ commodityTpye.getSuperid().getId();
							List listcomm2 = this.pdao.execHQL(sqlcomm2);
							if (listcomm2 != null && listcomm2.size() > 0) {
								for (int m = 0; m < listcomm2.size(); m++) {
									CommodityTpye commodityTpye1 = (CommodityTpye) listcomm2
											.get(m);
									if (null != commodityTpye1) {
										// 上一级的菜单//如果找的当前的
										logger.info(commodityTpye1.getId()
												.toString()
												+ "...."
												+ commodityTpye1.getSuperid()
														.getId().toString());
										if (commodityTpye1.getId().toString()
												.equals(
														commodityTpye1
																.getSuperid()
																.getId()
																.toString())) {
											// 说明这是最上级的了,.这就到头了不用在往下面去 查找了
											strTemp += "<tr style='font-size: 12px;'><td class='xb_tdwz'>"
													+ (i + 1)
													+ "、<a href ='javascript:void(0);' style='text-decoration: none;color: black;' onclick='checkfindpro("
													+ commodityTpye.getId()
													+ ")'>"
													+ commodityTpye
															.getTypeName()
													+ "</a></td><td>&nbsp;</td></tr>";
										} else {
											// 在查找下一级
											String hqlcomm3 = "from CommodityTpye as ct where 1=1 and ct.id ="
													+ commodityTpye1
															.getSuperid()
															.getId();
											List listcomm3 = this.pdao
													.execHQL(hqlcomm3);
											if (null != listcomm3
													&& 0 < listcomm3.size()) {
												for (int n = 0; n < listcomm3
														.size(); n++) {
													CommodityTpye commodityTpye2 = (CommodityTpye) listcomm3
															.get(n);
													if (null != commodityTpye2) {
														// 说明这是最上级的了,.这就到头了不用在往下面去
														// 查找了，这是完全的1、2、3级栏目，一下的没有了。想要加的话，那自己加。这个方法不通用。
														if (commodityTpye2
																.getId()
																.toString()
																.equals(
																		commodityTpye2
																				.getSuperid()
																				.getId()
																				.toString())) {
															strTemp += "<tr style='font-size: 12px;'><td class='xb_tdwz'>"
																	+ (i + 1)
																	+ "、<a href ='javascript:void(0);' style='text-decoration: none;color: black;' onclick='checkfindpro("
																	+ commodityTpye1
																			.getId()
																	+ ")'>"
																	+ commodityTpye1
																			.getTypeName()
																	+ "</a>/<a href ='javascript:void(0);' style='text-decoration: none;color: black;' onclick='checkfindpro("
																	+ commodityTpye
																			.getId()
																	+ ")'>"
																	+ commodityTpye
																			.getTypeName()
																	+ "</a></td><td>&nbsp;</td></tr>";
														} else {
															strTemp += "<tr style='font-size: 12px;'><td class='xb_tdwz'>"
																	+ (i + 1)
																	+ "、<a href ='javascript:void(0);' style='text-decoration: none;color: black;' onclick='checkfindpro("
																	+ commodityTpye2
																			.getId()
																	+ ")'>"
																	+ commodityTpye2
																			.getTypeName()
																	+ "</a>/<a href ='javascript:void(0);' style='text-decoration: none;color: black;' onclick='checkfindpro("
																	+ commodityTpye1
																			.getId()
																	+ ")'>"
																	+ commodityTpye1
																			.getTypeName()
																	+ "</a>/<a href ='javascript:void(0);' style='text-decoration: none;color: black;' onclick='checkfindpro("
																	+ commodityTpye
																			.getId()
																	+ ")'>"
																	+ commodityTpye
																			.getTypeName()
																	+ "</a></td><td>&nbsp;</td></tr>";
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			} else {
				strTemp += "<tr style='font-size: 12px;'><td><a href ='javascript:void(0);'>查无数据</a></td><td>&nbsp;</td></tr>";
			}
			if (demo != null && demo.equals("2")) {
				// 总共出现的次数
				int num1 = StringUtil.getSubNum(strTemp, "<tr");
				// 第N次出现的位子,超过五个就截取总4
				int num3 = StringUtil.getStringNum(strTemp, "<tr", 5);

				if (num3 == 0) {
					logger.info(strTemp);
				} else {
					strTemp = strTemp.substring(0, num3 - 1);
				}
				// 只截取五条
			}
			logger.info(strTemp);
			strTemp += "<tr><td class='xb_tdwz'><div class='xb_ckgd'><a href='javascript:void(0);' onclick='selectallcomm();'>点击查看更多</a></div></td>"
					+ "<td>&nbsp;</td></tr><tr><td class='xb_tdwz'>&nbsp;</td><td>&nbsp;</td></tr></table></div>";

			response.setCharacterEncoding("utf-8");
			response.getWriter().print(strTemp);
		} catch (Exception e) {
			logger.error("findcommRC"
					+ NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
			return "error";
		}
		return null;
	}

	/*
	 * 部门订单
	 */
	public String selectdeptsg() {
		try {
			logger.info("start selectdeptsg");
			String demo = request.getParameter("demo");
			if (null == demo && "".equals(demo)) {
				demo = "sg";
			}
			request.setAttribute("demo", demo);

			// 得到当前登入人
			Employee employee = this.getEmp();
			if (employee != null) {
				// 查看是否有权限
				// if (employee.getWorkposition() != null) {
				// Integer id = employee.getWorkposition().getWorkgrade()
				// .getId();
				// String empwordgrad = id.toString();
				// if (empwordgrad != null && !empwordgrad.equals("")) {
				// if (empwordgrad.equals("3") || empwordgrad.equals("4")) {
				// request.setAttribute("workgrad", "mark");
				// }
				// }
				// }
				logger.info(employee.getDepartment().getEmployee().getId());
				logger.info(employee.getId());
				if (null != employee.getDepartment().getEmployee().getId()
						&& !"".equals(employee.getDepartment().getEmployee()
								.getId().toString())) {
					if (employee.getId().toString().equals(
							employee.getDepartment().getEmployee().getId()
									.toString())) {
						request.setAttribute("workgrad", "mark");
					}
				}
			}

			// 如果当前登入人为部门主管，或者经理，那么当前登入人当前部门下的所以人员关联的客户
			// 根据当前登入人的部门查找该部门的所有的员工,以及子部门的员工

			WorkpositionEmployee empposition = (WorkpositionEmployee) request
					.getSession().getAttribute("empposition");

			String sonIds = pdao.exeSql("select getChildDeptLst("
					+ empposition.getEmployee().getDepartment().getId() + ")");

			// logger.info(deptids);

			String selectemp = "from Employee as e where 1=1 and e.department.id ="
					+ new Integer(sonIds);
			List listemp = this.pdao.execHQL(selectemp);
			StringBuffer empbuffer = new StringBuffer();
			if (null != listemp) {
				for (int em = 0; em < listemp.size(); em++) {
					Employee emp = (Employee) listemp.get(em);
					empbuffer.append(emp.getId() + ",");
				}
			}
			logger.info(empbuffer);

			String empids = "";
			if (null != empbuffer) {
				empids = empbuffer.substring(0, empbuffer.length() - 1);
			} else {
				empids = "0";
			}

			String hql = "from SaleGoods_mids as sgm where 1=1";
			// 商品名称
			if (saleName != null && !saleName.equals("")) {
				hql += " and sgm.sale_goods.sgname like '%" + saleName + "%'";
				request.setAttribute("saleName", saleName);
			}
			// 订单号
			if (soNum != null && !soNum.equals("")) {
				hql += " and sgm.sale_orders.soNums like '%" + soNum + "%'";
				request.setAttribute("soNum", soNum);
			}
			// 订单状态-
			if (soStat != null && !soStat.equals("") && !soStat.equals("-1")) {
				hql += " and sgm.sale_orders.soStat =" + new Integer(soStat);
				request.setAttribute("soStat", soStat);
			}
			// 买家昵称
			if (curName != null && !curName.equals("")) {
				hql += " and sgm.sale_orders.customer.customerName like '%"
						+ curName + "%'";
				request.setAttribute("curName", curName);
			}

			hql += " and sgm.sale_orders.employee.id in(" + empids
					+ ") order by sgm.sale_orders.soId desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");

			Pages page = pdao
					.paginationQuery(hql, new Integer(pageNo), 3, null);
			request.setAttribute("pages", page);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "deptsoList";
	}

	/*
	 * 部门核实单
	 */
	public String selectdeptrc() {
		try {
			logger.info("start selectdeptsg");
			String demo = request.getParameter("demo");
			if (null == demo && "".equals(demo)) {
				demo = "rc";
			}
			request.setAttribute("demo", demo);

			// 得到当前登入人
			Employee employee = this.getEmp();
			if (employee != null) {
				// 查看是否有权限
				// if (employee.getWorkposition() != null) {
				// Integer id = employee.getWorkposition().getWorkgrade()
				// .getId();
				// String empwordgrad = id.toString();
				// if (empwordgrad != null && !empwordgrad.equals("")) {
				// if (empwordgrad.equals("3") || empwordgrad.equals("4")) {
				// request.setAttribute("workgrad", "mark");
				// }
				// }
				// }
				logger.info(employee.getDepartment().getEmployee().getId());
				logger.info(employee.getId());
				if (null != employee.getDepartment().getEmployee().getId()
						&& !"".equals(employee.getDepartment().getEmployee()
								.getId().toString())) {
					if (employee.getId().toString().equals(
							employee.getDepartment().getEmployee().getId()
									.toString())) {
						request.setAttribute("workgrad", "mark");
					}
				}
			}

			WorkpositionEmployee empposition = (WorkpositionEmployee) request
					.getSession().getAttribute("empposition");

			String sonIds = pdao.exeSql("select getChildDeptLst("
					+ empposition.getEmployee().getDepartment().getId() + ")");

			// 如果当前登入人为部门主管，或者经理，那么当前登入人当前部门下的所以人员关联的客户
			// 根据当前登入人的部门查找该部门的所有的员工,以及子部门的员工以及子部门

			String selectemp = "from Employee as e where 1=1 and e.department.id in ("
					+ sonIds + ")";
			List listemp = this.pdao.execHQL(selectemp);
			StringBuffer empbuffer = new StringBuffer();
			if (null != listemp) {
				for (int em = 0; em < listemp.size(); em++) {
					Employee emp = (Employee) listemp.get(em);
					empbuffer.append(emp.getId() + ",");
				}
			}
			logger.info(empbuffer);

			String empids = "";
			if (null != empbuffer) {
				empids = empbuffer.substring(0, empbuffer.length() - 1);
			} else {
				empids = "0";
			}

			String hql = "from Tresourcecheck as trc where 1=1 ";

			// /核单编号
			if (rvid != null && !rvid.equals("")) {
				hql += " and trc.rvid like '%" + rvid + "%'";
				request.setAttribute("rvid", rvid);
			}
			// 申请人
			if (empnames != null && !empnames.equals("")) {
				String str = URLDecoder.decode(empnames, "utf-8");
				hql += " and trc.empid.name like '%" + str + "%'";
				request.setAttribute("empnames", str);
			}
			// 仓库
			if (depotid != null && !depotid.equals("")) {
				hql += " and trc.depot.id = " + new Integer(depotid);
				request.setAttribute("depotid", depotid);
			}
			hql += " and trc.empid.id in(" + empids + ") order by trc.id desc";

			// 关于这个主管的部门下的人员来查询这些代客操作人员下所有订单人

			// pageNo
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 15,
					null);
			request.setAttribute("pages", page);
			request.setAttribute("listRC", page.getPageList());

			// 查询所有的资源类型
			String hqldepot = "from Depot";
			List listdepot = pdao.execHQL(hqldepot);
			request.setAttribute("listdepot", listdepot);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "deptlistrc";
	}

	/*
	 * 我的资源核实单
	 */
	public String selectmyrc() {
		try {
			logger.info("=start selectmyrc=");
			String demo = request.getParameter("demo");
			if (null == demo && "".equals(demo)) {
				demo = "rc";
			}
			request.setAttribute("demo", demo);

			String hql = "from Tresourcecheck as trc where 1=1 ";

			// /核单编号
			if (rvid != null && !rvid.equals("")) {
				hql += " and trc.rvid like '%" + rvid + "%'";
				request.setAttribute("rvid", rvid);
			}
			// 申请人
			if (empnames != null && !empnames.equals("")) {
				String str = URLDecoder.decode(empnames, "utf-8");
				hql += " and trc.empid.name like '%" + str + "%'";
				request.setAttribute("empnames", str);
			}
			// 仓库
			if (depotid != null && !depotid.equals("")) {
				hql += " and trc.depot.id = " + new Integer(depotid);
				request.setAttribute("depotid", depotid);
			}
			Employee employee = this.getEmp();
			if (employee != null) {
				hql += " and trc.empid.id =" + employee.getId();
			}

			hql += " order by trc.id desc";

			// pageNo
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 15,
					null);
			request.setAttribute("pages", page);
			request.setAttribute("listRC", page.getPageList());

			// 查询所有的资源类型
			String hqldepot = "from Depot";
			List listdepot = pdao.execHQL(hqldepot);
			request.setAttribute("listdepot", listdepot);

		} catch (Exception e) {
			logger.error("==" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "selectRC";
	}

	/*
	 * 我的客户订单
	 */
	public String selectmysg() {
		try {
			logger.info("selemysg start");
			String demo = request.getParameter("demo");
			if (null == demo && "".equals(demo)) {
				demo = "sg";
			}
			request.setAttribute("demo", demo);
			String hql = "from SaleGoods_mids as sgm where 1=1";
			// 商品名称
			if (saleName != null && !saleName.equals("")) {
				hql += " and sgm.sale_goods.sgname like '%" + saleName + "%'";
				request.setAttribute("saleName", saleName);
			}
			// 订单号
			if (soNum != null && !soNum.equals("")) {
				hql += " and sgm.sale_orders.soNums like '%" + soNum + "%'";
				request.setAttribute("soNum", soNum);
			}
			// 订单状态-
			if (soStat != null && !soStat.equals("") && !soStat.equals("-1")) {
				hql += " and sgm.sale_orders.soStat =" + new Integer(soStat);
				request.setAttribute("soStat", soStat);
			}
			// 买家昵称
			if (curName != null && !curName.equals("")) {
				hql += " and sgm.sale_orders.customer.customerName like '%"
						+ curName + "%'";
				request.setAttribute("curName", curName);
			}
			// 当前登入人的客户,代客操作人
			Employee employee = (Employee) request.getSession().getAttribute(
					"emp");
			if (employee != null) {
				hql += " and sgm.sale_orders.employee.id =" + employee.getId();
			}

			hql += " order by sgm.sale_orders.soId desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");

			Pages page = pdao
					.paginationQuery(hql, new Integer(pageNo), 3, null);
			request.setAttribute("pages", page);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "allso";
	}

	/*
	 * 商品详情请求
	 */
	public String detailSg() {
		try {
			String sgid = request.getParameter("sgid");

			Sale_goods goods = (Sale_goods) pdao.get(Sale_goods.class,
					new Integer(sgid));
			request.setAttribute("sg", goods);
			String imgstr = goods.getSgImg();
			List imgList = new ArrayList();
			if (null != imgstr && !imgstr.equals("")) {
				String[] str = imgstr.trim().split("|");
				for (int m = 0; m < str.length; m++) {
					String str1 = str[m];
					imgList.add(str1);
				}
			}
			request.setAttribute("imgList", imgList);
			System.out.println("w.......,=" + goods.getSgAttribute());
			String attrstr = goods.getSgAttribute();
//		     得到商品属性
			   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
			   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//			   attributMap.put(label, value)
			   if(attrstr == null || attrstr.trim().equals("")){
					logger.info("组合商品属性：该商品无特殊属性");
				}else{
					String[] str1 = attrstr.split("@");//第一次分割
					if(str1.length != 4){
						logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
					}else{
						String  input_str = str1[0];//文本
						String  select_str = str1[1];//下拉
						String  checkbox_str = str1[2];//多选
						String  radio_str = str1[3];//单选
						
						attr_map = buildMap(attr_map,input_str);
						attr_map = buildMap(attr_map,select_str);
						attr_map = buildMap(attr_map,checkbox_str);
						attr_map = buildMap(attr_map,radio_str);
						
						for (Iterator it = attr_map.keySet().iterator(); it
								.hasNext();) {
							String label = (String) it.next();
							logger.info("label="+label);
						}
					}
				}
			   StringBuffer sb = new StringBuffer();
			   Set set = goods.getGoods_dict().getGoodsClass_expands();
				if(set == null || set.size()== 0){//无属性
					logger.info("类目编码为"+goods.getGoods_dict().getGdcodes()+"无类目属性");
				}else{
					for (Iterator it = set.iterator(); it.hasNext();) {
						GoodsClass_expand gde = (GoodsClass_expand) it.next();
						//用|分割
						sb.append(gde.getGeTemp1());
						sb.append("|");
						sb.append(gde.getGeTemp2());
						sb.append("|");
						sb.append(gde.getGeTemp3());
						sb.append("|");
						sb.append(gde.getGeTemp4());
						sb.append("|");
						sb.append(gde.getGeTemp5());
						sb.append("|");
						sb.append(gde.getGeTemp6());
						sb.append("|");
						sb.append(gde.getGeTemp7());
						sb.append("|");
						sb.append(gde.getGeTemp8());
						sb.append("|");
						sb.append(gde.getGeTemp9());
						sb.append("|");
						sb.append(gde.getGeTemp10());
						sb.append("|");
						sb.append(gde.getGeTemp11());
						sb.append("|");
						sb.append(gde.getGeTemp12());
						sb.append("|");
						sb.append(gde.getGeTemp13());
						sb.append("|");
						sb.append(gde.getGeTemp14());
						sb.append("|");
						sb.append(gde.getGeTemp15());
						break;//只得到第一条数据
					}
					String dict_attr_str = sb.toString();
					
					String[] ge_temp = dict_attr_str.split("\\|");
					logger.info("ge_temp.length="+ge_temp.length);
					int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
					for(int j=0;j<ge_temp.length;j++){
						if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
							logger.info("为空不处理");
						}else{
							//alert("ge_temp["+j+"]="+ge_temp[j]);
							String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
							logger.info("str2.length="+str2.length);
							logger.info("str2="+ge_temp[j]);
							
							if(str2.length != 6){//去掉不规范数据
								logger.info("数据不规范");
							}else{
								
								String tag =str2[0];
								
								String label = str2[1];
								String tips  = str2[2];
								String keystr  = str2[3];
								String valuestr  = str2[4];
								String specflag  = str2[5];
								
								//logger.info("第"+j+"轮,tag="+tag);
								//logger.info("第"+j+"轮,label="+label);
								//logger.info("第"+j+"轮,keystr="+keystr);
								//logger.info("第"+j+"轮,valuestr="+valuestr);
								//logger.info("第"+j+"轮,specflag="+specflag);
								String tagid = "";//标签的id值
								String tagname = "";//标签的name值
								if(tag.equals("1")){//文本框
									//文本框
									//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
									tagid = "input"+j;
									tagname = "input"+j; 
									//这里keystr 在文本框中默认是1 不需要填入
									String[] str3_value = valuestr.split("-");
									String inputstr = "";
									if(attr_map.containsKey(label)){
										String[]  ss = {label,str3_value[0]};
										attributMap.put(j,ss );
									}
								}else if(tag.equals("2")){//下拉框
									tagid = "select"+j;
									tagname = "select"+j;
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									//logger.info(str3_key.length+"----"+str3_value.length);
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("下拉框中的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									String optkey = "";
									if(attr_map.containsKey(label)){
										optkey = attr_map.get(label)[3];
										for(int i=0;i<str3_key.length;i++){//
											if(optkey.equals(str3_key[i])){
												String[]  ss = {label,str3_value[i]};
												attributMap.put(j,ss );
											}
										}
										
									}
								}else if(tag.equals("3")){//多选框
									//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
									tagid = "checkbox"+j;
									tagname = "checkbox"+j;
									
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("多选框的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									if(specflag.trim().equals("0")){
										String checkkeys = "";
										String ckvaluestr = "";
										if(attr_map.containsKey(label)){
											checkkeys = attr_map.get(label)[3];
											String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
											
											for(int i=0;i<str3_key.length;i++){
												String ckstr = "";//定义一个变量 是否选中
												for (int k = 0; k < checkkey.length; k++) {
													if(checkkey[k].equals(str3_key[i])){
														ckstr="checked='checked'";
														ckvaluestr += str3_value[i]+",";
														break;
													}//满足条件 选中 并推出当前循环
												}
											}
										}
										if(ckvaluestr.equals("")){
											ckvaluestr = "无";
										}else{
											ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
										}
										
										String[]  ss = {label,ckvaluestr};
										attributMap.put(j,ss );
										
									}else if(specflag.trim().equals("1")){
										
										
									}else{//规格鉴别标识错误
										logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
									}
								}else if(tag.equals("4")){//单选框
									tagid = "radio"+j;
									tagname = "radio"+j;
									//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("多选框的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									String radiokey = "";
									
									if(attr_map.containsKey(label)){
										radiokey = attr_map.get(label)[3];
										for(int i=0;i<str3_key.length;i++){
											String ckstr = "";
											if(radiokey.equals(str3_key[i])){
												ckstr = "checked";
												String[]  ss = {label,str3_value[i]};
												attributMap.put(j,ss );
											}
										}
									}
								}else{
									logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
								}
							}
						}
					}
				}
			   
		     request.setAttribute("getpropertys",attributMap);
		     
		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "detailsg";
	}
	private HashMap<String, String[]> buildMap(HashMap<String, String[]> attr_map, String input_str) {
		  if(input_str.equals("无")){
				logger.info("组合商品属性：该商品无文本属性");
			}else{
				String[] str2 = input_str.split(";");//第二次分割 //		2|2|CPU|2;2|4|disk|2
				for (int i = 0; i < str2.length; i++) {
					String  tagstr = str2[i];
					String[] str3 = tagstr.split("\\|");//第三次分割
					if(str3.length !=4){
						logger.error("组合商品属性-数据问题：文本标识数据;分割，数组长度不为4");
					}else{
						String serial = str3[0];//属性序号
						String tagserial = str3[1];//标签序号 1文本 2 下拉 3多选 4单选
						String label = str3[2];//label名称 唯一标识 整体用他来区分每个属性
						String value = str3[3];//显示的值
						
						if(attr_map.containsKey(label)){
							logger.error("label标识有重复的,请核查数据"+label);
						}else{
							attr_map.put(label,str3);
						}
					}
				}
				
			}
		  return attr_map;
		}

	/*
	 * 商品更多请求
	 */
	public String selectAll() {
		String strTemp = "";
		try {
			logger.info("selectAll start");
			String commid = request.getParameter("commid");
			String comm1 = request.getParameter("comm1");
			String comm2 = request.getParameter("comm2");
			String comm3 = request.getParameter("comm3");

			String hqlmodel = "from Model as sg where 1=1 ";
			if (commid != null && !commid.equals("")) {
				hqlmodel += " and sg.commodityTpye.id=" + new Integer(commid);
			}
			if (comm1 != null && !comm1.equals("")) {
				hqlmodel += " and sg.commodityTpye.typeName like '%" + comm1
						+ "%'";
			}
			if (comm3 != null && !comm1.equals("")) {
				hqlmodel += " and sg.commodityTpye.typeName like '%" + comm3
						+ "%'";
			}
			if (comm2 != null && !comm1.equals("")) {
				hqlmodel += " and sg.commodityTpye.typeName like '%" + comm2
						+ "%'";
			}
			Map productMap = new HashMap();
			List listmodel = pdao.execHQL(hqlmodel);
			if (listmodel != null && listmodel.size() > 0) {
				for (int i = 0; i < listmodel.size(); i++) {
					Model model = (Model) listmodel.get(i);
					String hqlproty = "from Property as pp where 1=1 and pp.model.model ="
							+ model.getModel();
					List listproty = pdao.execHQL(hqlproty);
					if (listproty != null && listproty.size() > 0) {
						for (int m = 0; m < listproty.size(); m++) {
							Property property = (Property) listproty.get(m);
							String hqlproduct = "select id,propertyId,usestate,useSum,barcode ,depotId,storageInfoId,count(*)" +
							" as num from product where propertyId="+ property.getId()+" and usestate=2 GROUP BY propertyId,depotId";
							List listproduct = pdao.execSQL(hqlproduct);

							if (listproduct != null && listproduct.size() > 0) {
								for (int n = 0; n < listproduct.size(); n++) {
									Object [] goods = (Object[]) listproduct.get(n);
									
									strTemp += "<li><table width='100%' border='0' cellspacing='8' cellpadding='0'>"
											+ "<tr><td><input type='checkbox' name='checkbox' value='"
											+ goods[0]
											+ "'  id='pro"
											+ goods[0]
											+ "sss' /><label for='checkbox'></label>"
											+ "</td><td title='"
											+ property.getName()
											+ "' style='CURSOR:pointer;'>";
									if (property.getName()
											.toString().length() > 10) {
										strTemp += property
												.getName().substring(0, 12);
									} else {
										strTemp += property
												.getName();
									}
									String hqldept = "from Depot as d where 1=1 and d.id = "+new Integer(goods[5].toString());
									Depot depot = (Depot) pdao.execHQL(hqldept).get(0);
									strTemp += "</td>"
									// +"<td>可用"+goods.getSgInventory()+"</td>"
											+ "<td>"
											+ depot.getName()
											+ "</td>"
											+ "<td align='right'>可用"
											+ goods[7]
											+ "台</td>"
											+ "<input type='hidden' id='pro"
											+ goods[0]
											+ "zong' value='"
											+ goods[7]
											+ "'/>"
											+ "<input type='hidden' id='pro"
											+ goods[0]
											+ "name' value='"
											+ property.getName()
											+ "'/>"
											+ "<input type='hidden' id='pro"
											+ goods[0]
											+ "dept' value='"
											+ depot.getName()
											+ "'/>"
											+ "<input type='hidden' id='showcommid' value='"
											+ commid
											+ "'/>"
											+ "<td align='center'><label for='textfield'></label>"
											+ "<img src='potal/images/ss_-.png' id='pro"
											+ goods[0]
											+ "'  style='CURSOR:pointer;' width='11' height='11' onclick='onclickCur(this);' />"
											+ "<input name='textfield' value='1' type='text' id='pro"
											+ goods[0]
											+ "s' size='2' width=25px />"
											+ "<img src='potal/images/ss_+.png' id='pro"
											+ goods[0]
											+ "ss' style='CURSOR:pointer;' onclick='onclickadd(this);' width='11' height='11' />"
											+ "</td></tr></table></li>";
								}
							}
						}
					}
				}
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(strTemp);

		} catch (Exception e) {
			logger.error("==" + NewportalSaleGoodsAction.class.getName());
		}
		return null;
	}

	/*
	 * 资源核查的详情请求
	 */
	public String detailRC() {
		try {
			String rcids = request.getParameter("rcids");
			String hql = "from Tresourcecheck as trc where 1=1 and trc.id="
					+ new Integer(rcids);
			Tresourcecheck tresourcecheck = (Tresourcecheck) pdao.execHQL(hql)
					.get(0);

			request.setAttribute("trc", tresourcecheck);
			if (tresourcecheck != null) {
				String hqlsg = " from Sale_goods as sg where 1=1 and sg.sgId ="
						+ new Integer(tresourcecheck.getSaleGoods().getSgId());
				Sale_goods sg = (Sale_goods) pdao.execHQL(hqlsg).get(0);
				request.setAttribute("sg", sg);
			}
		} catch (Exception e) {
			logger.error("====" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "detail";
	}

	/*
	 * 撤销请求
	 */
	public String updateRC() {
		try {
			String rcid = request.getParameter("rcid");
			String hqlrcid = "update t_resourceCheck set isstate ='4' where id="
					+ new Integer(rcid);
			boolean falg = pdao.updateRC(hqlrcid);
			if (falg == true) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}

		} catch (Exception e) {
			logger.error("+++=" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 商品的详情
	 */
	public String selectDetial() {
		String sgidinfo = request.getParameter("sgidinfo");

		String hqlsg = "from Sale_goods where 1=1 ";
		if (sgidinfo != null && !sgidinfo.equals("") && !sgidinfo.equals("-1")) {
			hqlsg += "and sgId=" + new Integer(sgidinfo);
		} else {
			hqlsg += "and sgId=0";
		}
		Sale_goods saleGoods = (Sale_goods) pdao.execHQL(hqlsg).get(0);
		String strTemp = "";
		if (saleGoods != null) {
			strTemp += "<tr><td width='25%' align='right' class='font_color_hui'>商品名称："
					+ "</td><td width='27%'>&nbsp;&nbsp;"
					+ saleGoods.getSgname()
					+ "</td>"
					+ "<td width='19%' align='right' class='font_color_hui'>商品编码：</td>"
					+ "<td width='29%'>&nbsp;&nbsp;"
					+ saleGoods.getSgcode()
					+ "</td></tr><tr>"
					+ "<td align='right' class='font_color_hui'>商品录入人："
					+ "</td><td>&nbsp;&nbsp;"
					+ saleGoods.getSgUsername()
					+ "</td><td align='right' class='font_color_hui'>"
					+ "商品价格：</td><td>&nbsp;&nbsp;"
					+ saleGoods.getSgPrice()
					+ "</td></tr><tr>"
					+ "<td align='right' class='font_color_hui'>商品规格：</td><td>"
					+ "&nbsp;&nbsp;"
					+ saleGoods.getSgNorms()
					+ "</td><td align='right' class='font_color_hui'>"
					+ "商品单位：</td><td>&nbsp;&nbsp;"
					+ saleGoods.getSgUnit()
					+ "</td></tr><tr>"
					+ "<td align='right' class='font_color_hui'>商品详情：</td><td>&nbsp;&nbsp;"
					+ saleGoods.getSgDetails()
					+ "</td><td align='right'>&nbsp;"
					+ "</td><td>&nbsp;</td></tr>";
		}
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(strTemp);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	public String addRC() {
		try {

			String depotids = request.getParameter("depotids");
			String cityid = request.getParameter("cityid");
			String sgid = request.getParameter("sgidinfo");
			String nowTime = request.getParameter("nowTime");
			String rvids = request.getParameter("rvids");
			String empid = request.getParameter("empid");

			Tresourcecheck tresourcecheck = new Tresourcecheck();

			// 仓库
			String hqldepot = "from Depot where 1=1 and id="
					+ new Integer(depotids);
			Depot depot = (Depot) pdao.execHQL(hqldepot).get(0);
			// 地区
			String hqlcity = "from City where 1=1 and id ="
					+ new Integer(cityid);
			City city = (City) pdao.execHQL(hqlcity).get(0);
			// 产品
			String hqlsg = "from Sale_goods where 1=1 and sgId="
					+ new Integer(sgid);
			Sale_goods saleGoods = (Sale_goods) pdao.execHQL(hqlsg).get(0);
			// emp
			String hqlemp = "from Employee where 1=1 and id = "
					+ new Integer(empid);
			Employee employee = (Employee) pdao.execHQL(hqlemp).get(0);

			tresourcecheck.setEmpid(employee);
			tresourcecheck.setCity(city);
			tresourcecheck.setDepot(depot);
			tresourcecheck.setSaleGoods(saleGoods);
			tresourcecheck.setStarttime(nowTime);
			tresourcecheck.setIsstate("0");
			tresourcecheck.setAudtitingFlag(0);
			tresourcecheck.setRvid(rvids);

			pdao.add(tresourcecheck);

//			int marker = audBussiness.addAuditingOrderRC("CSDN", rvids,
//					"Tresourcecheck", "");
			int marker = audBussiness.addAuditingOrderRC("CSDN", tresourcecheck.getRvid(), "Tresourcecheck", "");

			response.getWriter().print("1");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 新增资源核实单
	 */
	public String addRCUI() {
		try {
			logger.info("addRC start");
			String demo = request.getParameter("demo");
			if (null == demo && "".equals(demo)) {
				demo = "rc";
			}
			request.setAttribute("demo", demo);
			// 生成一个资源核实单编号
			// 当前登入人
			Employee employee = (Employee) request.getSession().getAttribute(
					"emp");
			request.setAttribute("emps", employee);
			// 随机一个编号
			String rvids = "RC";

			SimpleDateFormat sm = new SimpleDateFormat("yyyyMMddHHssdd");
			rvids += sm.format(new Date());
			double num = Math.random() * 10000;
			Integer num1 = (int) num;
			rvids += num1 + "";
			logger.info("=======" + rvids);
			request.setAttribute("rvids", rvids);
			// 得到当前的时间
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String nowTime = dateFormat.format(new Date());
			request.setAttribute("nowTime", nowTime);
			// 仓库
			String hqldepot = "from Depot";
			List listdepot = pdao.execHQL(hqldepot);
			request.setAttribute("listdepot", listdepot);
			// 地区
			String hqlcity = "from City";
			List listCity = pdao.execHQL(hqlcity);
			request.setAttribute("listCity", listCity);
			// 产品
			String hqlsg = "from Sale_goods";
			List listPro = pdao.execHQL(hqlsg);
			request.setAttribute("listPro", listPro);

		} catch (Exception e) {
			logger.error("==" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}

		return "addUI";
	}

	/*
	 * 删除资源核实单
	 */
	public String delRC() {
		try {
			int count = product_CommentService.delRC(objs);
			if (count > 0) {
				response.getWriter().print("1");
			}
			if (count < 0) {
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.error("+++" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	public String selectReource() {
		try {
			logger.info("=start selectReoure=");
			String demo = request.getParameter("demo");
			if (null == demo && "".equals(demo)) {
				demo = "rc";
			}
			request.setAttribute("demo", demo);
			String hql = "from Tresourcecheck as trc where 1=1 ";

			// /核单编号
			if (rvid != null && !rvid.equals("")) {
				hql += " and trc.rvid like '%" + rvid + "%'";
				request.setAttribute("rvid", rvid);
			}
			// 申请人
			if (empnames != null && !empnames.equals("")) {
				String str = URLDecoder.decode(empnames, "utf-8");
				hql += " and trc.empid.name like '%" + str + "%'";
				request.setAttribute("empnames", str);
			}
			// 仓库
			if (depotid != null && !depotid.equals("")) {
				hql += " and trc.depot.id = " + new Integer(depotid);
				request.setAttribute("depotid", depotid);
			}

			hql += " order by trc.id desc";

			// pageNo
			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 15,
					null);
			request.setAttribute("pages", page);
			request.setAttribute("listRC", page.getPageList());

			// 查询所有的资源类型
			String hqldepot = "from Depot";
			List listdepot = pdao.execHQL(hqldepot);
			request.setAttribute("listdepot", listdepot);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName()
					+ ".selectResource");
		}
		return "selectRC";
	}

	/*
	 * 添加资源核实单
	 */
	public String addResource() {
		try {
			// 添加资源核实单

			// 审批
		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 添加一个上架单
	 */
	public String addUpserverSalegoods() {
		try {
			// 添加上架单

			// 审批

			// 改订单状态a
			// 同时要添加多条数据,所以要先添加基础数据,再把组合数据分解之后,进行修改操作.
			logger.info("addupser start");

			UpServer upserver = new UpServer(); // 上架单对象

			Product p = new Product();
			// upserver.setProduct(pro);
			String upNos = request.getParameter("upNos");
			upserver.setUpNo(upNos);
			// 根据销售订单号查询其对象
			// int saleorderId = upserver.getSoOrders().getSoId();
			String soNum = request.getParameter("soNum");
			String hqlsoNum = "from Sale_orders as so where 1=1 and so.soNums ='"
					+ soNum + "'";
			Sale_orders sg = (Sale_orders) pdao.execHQL(hqlsoNum).get(0);
			upserver.setSoOrders(sg);
			upserver.setCustomer(sg.getCustomer()); // 设置客户信息
			upserver.setServerLocation(null); // 设置仓库
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			// Date dt1 = sdf.parse(ups.getDowntimeString()); //下架时间
			// Date dt2 = sdf.parse(ups.getUptimeString()); //上架时间
			// upserver.setUptime(new Timestamp(dt1.getTime())); // 上架时间
			// upserver.setDowntime(new Timestamp(dt2.getTime())); //下架时间
			// upserver.setIpnum(0); //ip数量
			// upserver.setMaintenancePass(null); //维护口令
			// upserver.setServerIp(ups.getServerIp());
			// upserver.setBandwidthThrottling(ups.getBandwidthThrottling());
			// //带宽限制
			upserver.setDelflag(0); // 删除标识
			upserver.setUpFlag(4); // 上架标识 4待上架、1上架、2下架
			upserver.setAudtitingFlag(0); // 审核状态
			Employee employee = (Employee) request.getSession().getAttribute(
					"emp");
			// Date dt1 = sdf.parse(ups.getDowntimeString()); //下架时间
			// Date dt2 = sdf.parse(ups.getUptimeString()); //上架时间
			// upserver.setUptime(new Timestamp(dt1.getTime())); // 上架时间
			// upserver.setDowntime(new Timestamp(dt2.getTime())); //下架时间
			// upserver.setIpnum(0); //ip数量
			// upserver.setMaintenancePass(null); //维护口令
			// upserver.setServerIp(ups.getServerIp());
			// upserver.setBandwidthThrottling(ups.getBandwidthThrottling());
			// //带宽限制
			upserver.setDelflag(0); // 删除标识
			upserver.setUpFlag(0); // 上架标识 4下架、1 2 上架 0 待上架
			upserver.setAudtitingFlag(0); // 审核状态
			Employee employees = (Employee) request.getSession().getAttribute(
					"emp");

			upserver.setEmployee(employees); // 设置上架人员
			upserver.setTemp("00"); // 备注
			UpServer upServer2 = pdao.add(upserver);
			
			//如果没有审核流程的话。那就默认的审核通过
			
			String hqlsg = " update sale_orders set so_stat =11 where so_id="
					+ sg.getSoId();
			boolean falg = pdao.updateRC(hqlsg);
			if (falg == true) {
				logger.info("success update stat ==11");
			}
			
			
			//客服中心
//			ConkOut con = new ConkOut();
//			Conkoutask coa = new Conkoutask();
//			String conkOutNo = "KF-"+serial.getSerialNumber();
//			con.setConkOutNo(conkOutNo);  //故障单号
////			Customer customer2 = (Customer)upb.getObjectById(Customer.class, upserver.getSoOrders().getCustomer().getCustomerId());
//			con.setCustomer(sg.getCustomer());
//			
//			con.setState("0");  // 0:客户提交初始状态  1:客服接收 2:提交到运维 3:运维处理完成 4:客户确认,已处理
//			con.setDescs("上架单故障处理");
//			con.setDelflag("0");
////			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			Date d = new Date();
//			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			con.setFaultTime(new java.sql.Timestamp(new java.util.Date().getTime()));
//			Questioncategory q = (Questioncategory)upb.getObjectById(Questioncategory.class,7);
//			Product prop = (Product)upb.getObjectById(Product.class, 6);
//			con.setIssueType(q);
//			con.setIp("no");
//			con.setProduct(prop);
//	//		con.setWdnr("暂无");
//	//		con.setEmail("暂无");
//			con.setUpserverid(upserver.getId());
//	//		con.setState("100");
//			con.setStatus(0);
//			con.setBzf(0);
//			upb.addUpserver(con);
//			System.out.println(con.getId());
//			upserver.setConkout(con);
//			System.out.println(upserver.getId());
//			upb.updateObj(upserver);
//			
//			Date dt = new Date();
//			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
//			coa.setDescs(con.getDescs());
//			coa.setFaultTime(sd.format(dt));
//			coa.setState(0);
//			coa.setConkout(con);
//			upb.addUpserver(coa);
			
			
			
			
			
			

			// /////////////生成工单///////////////////
			Workorder wo = new Workorder();
			String gdNo = "GD-" + serial.getSerialNumber();
			wo.setUpserver(upserver);
			// wo.setSaleorder(sg);
			wo.setSaleOrders(sg); // 工单设置销售订单
			wo.setWorkorderNo(gdNo);
			wo.setProblemType("上架单");
			wo.setProblemInfo("服务器故障");
			wo.setStatus(1); // 客服处理
			wo.setTemp("客服中心处理");
			upb.addUpserver(wo);
			logger.info("upb.addUpserver(wo)");
			// /////////向审核流程表写入上架单记录////////////////////
			// AuditingOrderTab aot = new AuditingOrderTab();
			// Employee employee2 =
			// (Employee)request.getSession().getAttribute("emp");
			// aot.setDepartment(employee2.getDepartment());
			// aot.setEmployeeByEmpId(employee2);
			// aot.setOrderNo(upserver.getUpNo());
			// aot.setHandlestate(1); //1表示审核中

			// 审核表
//			 UpServer result = upb.addReturnUpServer(upserver);
			String salehql = " update Sale_orders set soCheckStat = 1  where  soNums = '"
					+ upserver.getSoOrders().getSoNums() + "'";
			boolean flag = upb.executeHql(salehql);
			
			String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='SJ'";
			List list = pdao.execHQL(hql);
			if(null != list && 0<list.size())
			{
				int marker = audBussiness.addAuditingOrder2("SJ", upserver
						.getUpNo(), "UpServer", ck
						.getCookie(request, "filialemark"));
				logger.info(marker+upserver
						.getUpNo()+ck
						.getCookie(request, "filialemark"));
				if (marker == 0) {
					response.getWriter().print("0");
				} else if (marker == 2) {
					/* 阙超强 14015 添加记录动态信息 */
					// 添加记录到动态记录表
					Employee loginEmp = this.getEmp();
					if (null == loginEmp) {
						request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
						return "no";
					}
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个服务器上架单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(upserver.getId().toString());
					executerecord.setEntityName("UpServer");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
					
					response.getWriter().print("2");
				} else {
					response.getWriter().print("1");
				}
			}
			else
			{
				//默认审核通过的上架单
				String upsql = "update upserver set audtitingFlag =1 where id ="+upServer2.getId();
				boolean flags = pdao.updateRC(upsql);
				
				//上架单审核通过，修改订单的状态
				String hqlsgs = " update sale_orders set so_stat =4 where so_id="
					+ sg.getSoId();
				boolean falgss = pdao.updateRC(hqlsgs);
				if (falgss == true) {
					logger.info("success update stat ==4");
				}
			}
				
			// ///////////完成添加上架单,再生成运维单/////////////////
			// 根据销售订单号查询其对象
			// 获得上架单号
			// request.setAttribute("ywNo", ywNo);

			String proids = request.getParameter("proids");
			logger.info("proid"+proids);	
			String temp = "";
			if (proids != null && !proids.equals("")) {
				temp = proids.substring(0, proids.length() - 1);
				System.out.println(proids);
				
			
				
				
			}
			//String [] ids=proids.split(",");//商品id的list
			String ids[]=proids.split(",");
			logger.info(ids);
			String idlist="";
			for (int i = 0; i < ids.length; i++) {//根据商品数量关联相应的商品
				String name="pro"+ids[i].toString();
				String num=request.getParameter(name);
				System.out.println(num);
				logger.info(num+"num");
				if(ids[i]!=null && !ids[i].equals("")){
				if(!num.equals("1")){
					String prohql="from Product as p where 1=1 and p.id="+ids[i];
					logger.info(prohql+"prohql");
					List listpro = pdao.execHQL(prohql);
					Product pro=new Product();
					logger.info(i+"i");
					pro=(Product)listpro.get(0);//根据商品属性名字查找相同商品
					String prohql2="from Product  as pro where 1=1 and usestate=2 and pro.property.id="+pro.getProperty().getId()+"and depot.id="+pro.getDepot().getId();
					List listpro1 = pdao.execHQL(prohql2);	
					
					List<Product> prolist=listpro1;
						for (int j = 0; j <Integer.parseInt(num); j++) {
							idlist+=prolist.get(j).getId()+",";
							logger.info("idlist"+prolist.get(j).getId());
					}
					
				}else {
				
				idlist+=ids[i]+",";
				}
				}
				
			}
			logger.info("idlist"+idlist);	
			if(idlist!=""){
				temp = idlist.substring(0, idlist.length() - 1);
				
			}
			String hqlpro = "from Product as p where 1=1 and p.id in("
					+ temp.trim() + ")";
			logger.info("hqlpro"+hqlpro);	
			List listpro = pdao.execHQL(hqlpro);
			
			String box = "";
			int id = 0;
			for (int j = 0; j < listpro.size(); j++) {
				
				Product pt = (Product) listpro.get(j);
				/**----------------------14032 6.8*/ 
				
				
				pt.setUsestate(1);//在使用
				pt.setIsfreeze(1);//把选择的商品冻结，以后不能选择
				upb.updateObj(pt);//更新类
				Operate operate = new Operate(); // 运维单对象
				String ywNo = "YW-" + serial.getSerialNumber();

				// id = Integer.parseInt(box.substring(3, box.length()));
				// Product pro = (Product)upb.getObjectById(Product.class, id);
				operate.setProduct(pt);
				//pt.setIsfreeze(1);
				upb.updateObj(pt);
				operate.setOperateNo(ywNo);
				int sid = sg.getSoId(); // 从页面隐藏域里得到选中的销售订单id
				Sale_orders sgd = (Sale_orders) upb.getObjectById(
						Sale_orders.class, sid);
				operate.setSaleOrders(sgd); // 设置上架单
				// Strins=g upNo = upserver.getUpNo(); //得到上架单号,根据该单号查询对象
				List<UpServer> uplist = upb.getUpserverByUpNo(upNos);
				if (uplist.size() > 0) {
					Object obj = uplist.get(0);
					UpServer ups = (UpServer) obj;
					operate.setUpserver(ups); // 设置上架单
				}
				Date upDate = new Date();
				operate.setUptime(upDate); // 设置上架时间
				Object object = upb.getObjectById(Depot.class, pt.getDepot()
						.getId());
				Depot depot = (Depot) object;
				operate.setDepot(depot); // 设置仓库
				Employee emp = (Employee) request.getSession().getAttribute(
						"emp");
				operate.setEmployee(emp); // 设置上架人员
				upb.addUpserver(operate);

				List lst = upb.getAll("from Freeze where product.id="
						+ pt.getId());
				if (lst.size() > 0) {
					Freeze freeze = (Freeze) lst.get(0);
					freeze.setFreezeFlag(0);
				}
			}
		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}

		return "successpage";
	}

	public String success()
	{
		return "success";
	}
	
	/*
	 * 搜索
	 */
	public String sousuoComm() {
		try {

			String comm1 = request.getParameter("comm1");
			String comm2 = request.getParameter("comm2");
			String comm3 = request.getParameter("comm3");
			if (comm1 != null && !comm1.equals("")) {
				String hqlone = "from CommodityTpye as ct where 1=1 ";
			} else if (comm2 != null && !comm2.equals("")) {

			} else {

			}

		} catch (Exception e) {
			logger.error("==" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 根据Comm读取一级、二级、三级目录
	 */
	public String findComm() {
		try {
			String commid = request.getParameter("commid");
			String indexs = request.getParameter("indexs");
			String comm1 = request.getParameter("comm1");
			String comm2 = request.getParameter("comm2");
			String comm3 = request.getParameter("comm3");
			String soNum = request.getParameter("soNum");
			String upNo = request.getParameter("upNo");
			CommodityTpye type = new CommodityTpye();
			// index ==1 为一级目录
			String strTemp = "";
			String strDemo = "$";
			if (indexs != null && indexs.equals("1")) {
				// 根据commid查询一级目录下的二级目录
				String hqlone = "from CommodityTpye as ct where 1=1 and ct.superid.id =1 and id not in(1) ";
				if (commid != null && !commid.equals("")) {
					hqlone += " and ct.id=" + new Integer(commid);
				}
				if (comm1 != null && !comm1.equals("")) {
					String comms = URLDecoder.decode(comm1, "utf-8");
					hqlone += " and ct.typeName like '%" + comms + "%'";

				}
				List listone = pdao.execHQL(hqlone);
				if (listone != null && listone.size() > 0) {
					for (int k = 0; k < listone.size(); k++) {
						CommodityTpye onetpye = (CommodityTpye) listone.get(k);
						strDemo += "<li><a href='javascript:void(0);' onclick='oneshow("
								+ onetpye.getId()
								+ ",1)' style='CURSOR:pointer;'><span>&gt;</span>"
								+ onetpye.getTypeName() + "</a></li>";
					}
				} else {
					strDemo += "<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
				}
				if (listone != null && listone.size() > 0) {
					CommodityTpye commOne = (CommodityTpye) listone.get(0);
					String hqltwo = "from CommodityTpye as ct where 1=1  and ct.superid.id="
							+ commOne.getId();

					if (comm2 != null && !comm2.equals("")) {
						String comms1 = URLDecoder.decode(comm2, "utf-8");
						hqltwo += " and ct.typeName like '%" + comms1 + "%'";
					}
					List twoCommtype = pdao.execHQL(hqltwo);
					if (twoCommtype != null && twoCommtype.size() > 0) {
						for (int i = 0; i < twoCommtype.size(); i++) {
							CommodityTpye twoComm = (CommodityTpye) twoCommtype
									.get(i);
							strTemp += "<li><a href='javascript:void(0);' onclick='twoshow("
									+ twoComm.getId()
									+ ",2)' style='CURSOR:pointer;'><span>&gt;</span>"
									+ twoComm.getTypeName() + "</a></li>";
						}
						// 随机二级目录下的一个三级目录显示
						CommodityTpye threeComm = (CommodityTpye) twoCommtype
								.get(0);
						if (threeComm != null) {
							String hqlthree = "from CommodityTpye as ct where 1=1 and ct.superid.id="
									+ threeComm.getId();
							// 不为空
							if (comm3 != null && !comm2.equals("")) {
								String comms2 = URLDecoder.decode(comm3,
										"utf-8");
								hqlthree += " and ct.typeName like '%" + comms2
										+ "%'";
							}
							List threeCommtype = pdao.execHQL(hqlthree);
							strTemp += "*";
							for (int l = 0; l < threeCommtype.size(); l++) {
								CommodityTpye tpye = (CommodityTpye) threeCommtype
										.get(l);
								strTemp += "<li><a href='javascript:void(0);' onclick='javascript:threeshow("
										+ tpye.getId()
										+ ",3);' style='CURSOR:pointer;'><span>&gt;</span>"
										+ tpye.getTypeName() + "</a></li>";
							}
						} else {
							// 为空状态
							strTemp += "*<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
						}
					}
				} else {
					strTemp += "<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
					strTemp += "*<li><a href='javascript:void(0);'  style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
				}
			} else if (indexs != null && indexs.equals("2")) {
				// 显示二级目录
				String hqltwoComm = "from CommodityTpye as ct where 1=1 ";

				if (comm2.equals("") && commid.equals("")) {
					String hqltwoCommaa = "from CommodityTpye as ct where 1=1 and ct.superid.id =1 and id not in(1)";
					type = (CommodityTpye) pdao.execHQL(hqltwoCommaa).get(0);
					// 都为空的状态
					hqltwoComm += " and ct.superid.id =" + type.getId()
							+ " and id not in(1)";
				}
				if (comm2 != null && !comm2.equals("")) {
					String comms2 = URLDecoder.decode(comm2, "utf-8");
					String id = request.getSession().getAttribute("twoid")
							.toString();
					hqltwoComm += " and ct.typeName like '%" + comms2
							+ "%' and ct.superid.id =" + new Integer(id);
				}
				if (commid != null && !commid.equals("")) {
					hqltwoComm += " and ct.id=" + new Integer(commid);
				}

				List Commtwo = pdao.execHQL(hqltwoComm);
				if (Commtwo != null && Commtwo.size() > 0) {
					for (int i = 0; i < Commtwo.size(); i++) {
						CommodityTpye comms = (CommodityTpye) Commtwo.get(i);
						strDemo += "<li><a href='javascript:void(0);' onclick='twoshow("
								+ comms.getId()
								+ ",2)' style='CURSOR:pointer;'><span>&gt;</span>"
								+ comms.getTypeName() + "</a></li>";
					}
				} else {
					strDemo += "<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
				}
				if (Commtwo != null && Commtwo.size() > 0) {
					// 二级目录下的三级
					CommodityTpye thressComms = (CommodityTpye) Commtwo.get(0);
					String hqltwo = "from CommodityTpye as ct where 1=1 and ct.superid.id="
							+ thressComms.getId();
					if (comm3 != null && !comm3.equals("")) {
						String comms3 = URLDecoder.decode(comm3, "utf-8");
						hqltwo += " and ct.typeName like '%" + comms3 + "%'";
					}

					List threeComms = pdao.execHQL(hqltwo);
					if (threeComms != null && threeComms.size() > 0) {
						for (int i = 0; i < threeComms.size(); i++) {
							CommodityTpye comm = (CommodityTpye) threeComms
									.get(i);
							strTemp += "<li><a href='javascript:void(0);' onclick='javascript:threeshow("
									+ comm.getId()
									+ ",3);' style='CURSOR:pointer;'><span>&gt;</span>"
									+ comm.getTypeName() + "</a></li>";
							;
						}
					}
				} else {
					strTemp += "<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
				}
			} else {

				// 通过搜索得到三级的目录
				String hqltwoComms = "from CommodityTpye as ct where 1=1 ";
				String hqlmodel = "from Model as sg where 1=1 ";
				if (comm3 != null && !comm3.equals("")) {
					String commas = URLDecoder.decode(comm3, "utf-8");
					String id = request.getSession().getAttribute("threeid")
							.toString();
					hqltwoComms += " and ct.typeName like '%" + commas
							+ "%' and ct.superid.id =" + new Integer(id);
				}
				if (commid != null && !commid.equals("")) {
					hqltwoComms += " and ct.id =" + new Integer(commid);
					hqlmodel += " and sg.commodityTpye.id=" + commid;
				}

				if (comm3.equals("") && commid.equals("")) {
					String hqltwoCommaa = "from CommodityTpye as ct where 1=1 and ct.superid.id =1 and id not in(1)";
					// 以及目录下的栏目
					type = (CommodityTpye) pdao.execHQL(hqltwoCommaa).get(0);
					// 二级目录下
					if (type != null) {
						String hqltwoCommas = "from CommodityTpye as ct where 1=1  and ct.superid.id ="
								+ type.getId();
						CommodityTpye ctype = (CommodityTpye) pdao.execHQL(
								hqltwoCommas).get(0);
						hqltwoComms += " and ct.superid.id =" + ctype.getId();
						hqlmodel += " and sg.commodityTpye.id=" + ctype.getId();
					} else {
						hqltwoComms += " and ct.superid.id =" + 0
								+ " and id not in(1)";
					}
					// 都为空的状态
				}

				List hqlthrees = pdao.execHQL(hqltwoComms);
				if (hqlthrees != null && hqlthrees.size() > 0) {
					for (int s = 0; s < hqlthrees.size(); s++) {
						CommodityTpye types = (CommodityTpye) hqlthrees.get(s);

						strTemp += "<li><a href='javascript:void(0);' onclick='javascript:threeshow("
								+ types.getId()
								+ ",3);' style='CURSOR:pointer;'><span>&gt;</span>"
								+ types.getTypeName() + "</a></li>";
						;
					}
					CommodityTpye typeinfo = (CommodityTpye) hqlthrees.get(0);
					hqlmodel += " and sg.commodityTpye.id=" + typeinfo.getId();
				} else {
					strTemp += "<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>";
					hqlmodel += " and sg.commodityTpye.id=" + 0;
				}
				//
				// String hqlmodel =
				// "from Sale_goods as m where 1=1 and m.commodityTpye.id="+ new
				// Integer(commid);
				// 得到类型

				Map productMap = new HashMap();
				List listmodel = pdao.execHQL(hqlmodel);
				int count = 0;

				strTemp += "`";
				OK: if (listmodel != null && listmodel.size() > 0) {
					for (int i = 0; i < listmodel.size(); i++) {
						Model model = (Model) listmodel.get(i);
						String hqlproty = "from Property as pp where 1=1 and pp.model.model ="
								+ model.getModel();
						List listproty = pdao.execHQL(hqlproty);
						if (listproty != null && listproty.size() > 0) {
							for (int m = 0; m < listproty.size(); m++) {
								Property property = (Property) listproty.get(m);
								String hqlproduct = "select id,propertyId,usestate,useSum,barcode ,depotId,storageInfoId,count(*)" +
								" as num from product where propertyId="+ property.getId()+" and usestate=2 GROUP BY propertyId,depotId";
								List listproduct = pdao.execSQL(hqlproduct);

								if (listproduct != null
										&& listproduct.size() > 0) {
									for (int n = 0; n < listproduct.size(); n++) {
										if (count >= 6) {
											break OK;
										}
										Object [] goods = (Object[]) listproduct.get(n);
										
										strTemp += "<li><table width='100%' border='0' cellspacing='8' cellpadding='0'>"
												+ "<tr><td><input type='checkbox' name='checkbox' value='"
												+ goods[0]
												+ "'  id='pro"
												+ goods[0]
												+ "sss' /><label for='checkbox'></label>"
												+ "</td><td title='"
												+ property.getName()
												+ "' style='CURSOR:pointer;'>";
										if (property.getName()
												.toString().length() > 10) {
											strTemp += property
													.getName().substring(0, 12);
										} else {
											strTemp += property
													.getName();
										}
										String hqldept = "from Depot as d where 1=1 and d.id = "+new Integer(goods[5].toString());
										Depot depot = (Depot) pdao.execHQL(hqldept).get(0);
										strTemp += "</td>"
										// +"<td>可用"+goods.getSgInventory()+"</td>"
												+ "<td>"
												+ depot.getName()
												+ "</td>"
												+ "<td align='right'>可用"
												+ goods[7]
												+ "台</td>"
												+ "<input type='hidden' id='pro"
												+ goods[0]
												+ "zong' value='"
												+ goods[7]
												+ "'/>"
												+ "<input type='hidden' id='pro"
												+ goods[0]
												+ "name' value='"
												+ property.getName()
												+ "'/>"
												+ "<input type='hidden' id='pro"
												+ goods[0]
												+ "dept' value='"
												+ depot.getName()
												+ "'/>"
												+ "<input type='hidden' id='showcommid' value='"
												+ commid
												+ "'/>"
												+ "<td align='center'><label for='textfield'></label>"
												+ "<img src='potal/images/ss_-.png' id='pro"
												+ goods[0]
												+ "'  style='CURSOR:pointer;' width='11' height='11' onclick='onclickCur(this);' />"
												+ "<input name='textfield' value='1' type='text' id='pro"
												+ goods[0]
												+ "s' size='2' width=25px />"
												+ "<img src='potal/images/ss_+.png' id='pro"
												+ goods[0]
												+ "ss' style='CURSOR:pointer;' onclick='onclickadd(this);' width='11' height='11' />"
												+ "</td></tr></table></li>";
										count++;
									}
								}
							}
						}
					}
				}
			}
			// 不为空
			if (indexs != null && !indexs.equals("3")) {
				strTemp += "?";
				// String hqlmodel =
				// "from Sale_goods as m where 1=1 and m.commodityTpye.id="+ new
				// Integer(commid);
				// 得到类型
				String hqlmodel = "from Model as sg where 1=1 ";
				if (commid != null && !commid.equals("")) {
					hqlmodel += " and sg.commodityTpye.id="
							+ new Integer(commid);
				}
				if (comm1 != null && !comm1.equals("")) {
					hqlmodel += " and sg.commodityTpye.typeName like '%"
							+ comm1 + "%'";
				}
				int count = 0;
				Map productMap = new HashMap();
				List listmodel = pdao.execHQL(hqlmodel);
				OK: if (listmodel != null && listmodel.size() > 0) {
					for (int i = 0; i < listmodel.size(); i++) {
						Model model = (Model) listmodel.get(i);
						String hqlproty = "from Property as pp where 1=1 and pp.model.model ="
								+ model.getModel();
						List listproty = pdao.execHQL(hqlproty);
						if (listproty != null && listproty.size() > 0) {
							for (int m = 0; m < listproty.size(); m++) {
								Property property = (Property) listproty.get(m);
								String hqlproduct = "select id,propertyId,usestate,useSum,barcode ,depotId,storageInfoId,count(*)" +
										" as num from product where propertyId="+ property.getId()+" and usestate=2 GROUP BY propertyId,depotId";
								List listproduct = pdao.execSQL(hqlproduct);

								if (listproduct != null
										&& listproduct.size() > 0) {
									for (int n = 0; n < listproduct.size(); n++) {
										if (count >= 6) {
											break OK;
										}
										Object [] goods = (Object[]) listproduct.get(n);
										
										strTemp += "<li><table width='100%' border='0' cellspacing='8' cellpadding='0'>"
												+ "<tr><td><input type='checkbox' name='checkbox' value='"
												+ goods[0]
												+ "'  id='pro"
												+ goods[0]
												+ "sss' /><label for='checkbox'></label>"
												+ "</td><td title='"
												+ property.getName()
												+ "' style='CURSOR:pointer;'>";
										if (property.getName()
												.toString().length() > 10) {
											strTemp += property
													.getName().substring(0, 12);
										} else {
											strTemp += property
													.getName();
										}
										String hqldept = "from Depot as d where 1=1 and d.id = "+new Integer(goods[5].toString());
										Depot depot = (Depot) pdao.execHQL(hqldept).get(0);
										strTemp += "</td>"
										// +"<td>可用"+goods.getSgInventory()+"</td>"
												+ "<td>"
												+ depot.getName()
												+ "</td>"
												+ "<td align='right'>可用"
												+ goods[7]
												+ "台</td>"
												+ "<input type='hidden' id='pro"
												+ goods[0]
												+ "zong' value='"
												+ goods[7]
												+ "'/>"
												+ "<input type='hidden' id='pro"
												+ goods[0]
												+ "name' value='"
												+ property.getName()
												+ "'/>"
												+ "<input type='hidden' id='pro"
												+ goods[0]
												+ "dept' value='"
												+ depot.getName()
												+ "'/>"
												+ "<input type='hidden' id='showcommid' value='"
												+ commid
												+ "'/>"
												+ "<td align='center'><label for='textfield'></label>"
												+ "<img src='potal/images/ss_-.png' id='pro"
												+ goods[0]
												+ "'  style='CURSOR:pointer;' width='11' height='11' onclick='onclickCur(this);' />"
												+ "<input name='textfield' value='1' type='text' id='pro"
												+ goods[0]
												+ "s' size='2' width=25px />"
												+ "<img src='potal/images/ss_+.png' id='pro"
												+ goods[0]
												+ "ss' style='CURSOR:pointer;' onclick='onclickadd(this);' width='11' height='11' />"
												+ "</td></tr></table></li>";
										count++;
									}
								}
							}
						}
					}
				}
			}
			strTemp += strDemo;
			request.setAttribute("comm1", comm1);
			request.setAttribute("comm2", comm1);
			request.setAttribute("comm3", comm3);
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(strTemp);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 待客填写上架单
	 */
	public String addUpserver() {
		try {
			logger.info("===addUpserver start");
			// 生成上架单号
			String usNums = request.getParameter("usNums");
			if (usNums != null && !usNums.equals("")) {
				request.setAttribute("usNum", usNums);
			} else {
				SimpleDateFormat sm = new SimpleDateFormat("yyyyMMddHHssdd");
				String usNum = "us-";
				usNum += sm.format(new Date());
				Random rd = new Random();
				int num = (int) (rd.nextDouble() * 100000);
				usNum += num;

				logger.info("上架单号：+++" + usNum);
				request.setAttribute("usNum", usNum);
			}
			// 订单号
			String soNum = request.getParameter("soNum");
			String hql = "from SaleGoods_mids as sm where 1=1  and sm.sale_orders.soNums ='"
					+ soNum + "'";
			SaleGoods_mids goodsMids = (SaleGoods_mids) pdao.execHQL(hql)
					.get(0);
			request.setAttribute("smg", goodsMids);
			request.setAttribute("soNum", soNum);

			// 商品类型
			// 一级类型，二级类型，三级类型...
			// 首先默认的一个商品类型
			// 查询第一级的、
			Map commtype = new HashMap();
			String sqlone = "from CommodityTpye as ct where 1=1 and ct.superid.id =1 and id not in(1)";
			List oneCommtype = pdao.execHQL(sqlone);
			List threeCommtype = null;

			if (oneCommtype != null && oneCommtype.size() > 0) {
				// 查询二级目录，设置默认的栏目
				CommodityTpye goodsDict = (CommodityTpye) oneCommtype.get(0);
				request.setAttribute("commids", goodsDict.getId());
				request.getSession().setAttribute("twoid", goodsDict.getId());
				String sqltwo = "from CommodityTpye as ct where 1=1 and ct.superid.id="
						+ goodsDict.getId();
				List twoCommList = pdao.execHQL(sqltwo);
				if (null != twoCommList && 0 < twoCommList.size()) {
					request.setAttribute("twoCommList", twoCommList);
				}
				// 在查询三级目录，设置默认的栏目
				if (twoCommList != null && twoCommList.size() > 0) {
					CommodityTpye goodsDict1 = (CommodityTpye) twoCommList
							.get(0);
					request.getSession().setAttribute("threeid",
							goodsDict1.getId());
					String sqlthree = "from CommodityTpye as ct where 1=1 and ct.superid.id="
							+ goodsDict1.getId();
					threeCommtype = pdao.execHQL(sqlthree);
					if (null != threeCommtype && 0 < threeCommtype.size()) {
						request.setAttribute("threeCommtype", threeCommtype);
					}
				}
				// 查询父目录下商品类型的所以商品
				// 随意一个父目录下的商品
				Map productMap = new HashMap();
				List listproduct = new ArrayList();
				String hqlmodel = "from Model as sg where 1=1 and sg.commodityTpye.id="
						+ goodsDict.getId();
				List listmodel = pdao.execHQL(hqlmodel);
				if (listmodel != null && listmodel.size() > 0) {
					for (int i = 0; i < listmodel.size(); i++) {
						Model model = (Model) listmodel.get(i);
						String hqlproty = "from Property as pp where 1=1 and pp.model.model ="
								+ model.getModel();
						List listproty = pdao.execHQL(hqlproty);
						if (listproty != null && listproty.size() > 0) {
							for (int m = 0; m < listproty.size(); m++) {
								Property property = (Property) listproty.get(m);
								String hqlproduct = "from Product  as pro where 1=1 and usestate=2 and isfreeze<>1  and pro.property.id="
										+ property.getId();
								listproduct = pdao.execHQL(hqlproduct);
								logger.info(listproduct.size());
								if (null != listproduct
										&& 0 < listproduct.size()) {
									productMap.put(listproduct.size(),
											listproduct);
								}
							}
						}
					}
				}
				if (null != productMap && 0 < productMap.size()) {
					request.setAttribute("map", productMap);
				}
			}
			if (null != oneCommtype && 0 < oneCommtype.size()) {
				request.setAttribute("oneCommtype", oneCommtype);
			}

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "addUS";
	}

	/*
	 * 出售中的商品请求
	 */
	public String select() {
		try {
			// 商品名称
			String hql = "from Sale_goods as sg where 1=1 ";
			if (saleName != null && !saleName.equals("")) {
				hql += " and sg.sgname like '%" + saleName + "%'";
				request.setAttribute("sgname", saleName);
			}
			// 商品编码
			if (sgcode != null && !sgcode.equals("")) {
				hql += " and sg.sgcode like '%" + sgcode + "%'";
				request.setAttribute("sgcode", sgcode);
			}
			// 商品起始价格
			if (startMoney != null && !startMoney.equals("")) {
				hql += " and sg.sgPrice > " + new Double(startMoney);
				request.setAttribute("startMoney", startMoney);
			}
			// 商品结束价格
			if (endMoney != null && !endMoney.equals("")) {
				hql += " and sg.sgPrice < " + new Double(endMoney);
				request.setAttribute("endMoney", endMoney);
			}
			// 总销量起始
			if (startVolume != null && !startVolume.equals("")) {
				hql += " and sg.sgSalesVolume > " + new Integer(startVolume);
				request.setAttribute("startVoume", startVolume);
			}
			// 总销量end
			if (endVolume != null && !endVolume.equals("")) {
				hql += " and sg.sgSalesVolume < " + new Integer(endVolume);
				request.setAttribute("endVolume", endVolume);
			}
			hql += " and sg.sgStat =1 order by sg.id desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");

			Pages page = pdao
					.paginationQuery(hql, new Integer(pageNo), 3, null);
			request.setAttribute("pages", page);
			request.setAttribute("salegoods", page.getPageList());
		} catch (Exception e) {
			logger.error("=====" + NewportalSaleGoodsAction.class.getName()
					+ " error");
		}
		return "select";
	}

	/*
	 * 出售中的商品删除请求
	 */
	public String delSg() throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		int i = 0;

		i = product_CommentService.undercarriage(id, "xxttjsp", "Goods_dict",
				ck.getCookie(request, "filialemark"));

		if (i == 1) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
		return null;
	}

	/*
	 * 生成订单请求
	 */
	public String sgOrder() {
		try {
			// 生成一个订单号
			SimpleDateFormat sm = new SimpleDateFormat("yyyyMMddHHmmss");
			String sgorderNum = "sg-";
			sgorderNum += sm.format(new Date());
			Random rd = new Random();
			int num = (int) (rd.nextDouble() * 10000);
			sgorderNum += num;

			logger.info("订单号：+++" + sgorderNum);
			request.setAttribute("sgnum", sgorderNum);

			// 商品id
			String sgid = request.getParameter("sgid");
			// 根据商品id得到商品
			Sale_goods goods = (Sale_goods) pdao.get(Sale_goods.class,
					new Integer(sgid));
			request.setAttribute("sggood", goods);

			// 得到当前的登入人
			Employee employee = (Employee) this.request.getSession()
					.getAttribute("emp");
			request.setAttribute("emps", employee);
			
			String imgstr = goods.getSgImg();
			List imgList = new ArrayList();
			if (null != imgstr && !imgstr.equals("")) {
				String[] str = imgstr.trim().split("|");
				for (int m = 0; m < str.length; m++) {
					String str1 = str[m];
					imgList.add(str1);
				}
			}
			request.setAttribute("imgList", imgList);
			System.out.println("w.......,=" + goods.getSgAttribute());
			String attrstr = goods.getSgAttribute();
//		     得到商品属性
			   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
			   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//			   attributMap.put(label, value)
			   if(attrstr == null || attrstr.trim().equals("")){
					logger.info("组合商品属性：该商品无特殊属性");
				}else{
					String[] str1 = attrstr.split("@");//第一次分割
					if(str1.length != 4){
						logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
					}else{
						String  input_str = str1[0];//文本
						String  select_str = str1[1];//下拉
						String  checkbox_str = str1[2];//多选
						String  radio_str = str1[3];//单选
						
						attr_map = buildMap(attr_map,input_str);
						attr_map = buildMap(attr_map,select_str);
						attr_map = buildMap(attr_map,checkbox_str);
						attr_map = buildMap(attr_map,radio_str);
						
						for (Iterator it = attr_map.keySet().iterator(); it
								.hasNext();) {
							String label = (String) it.next();
							logger.info("label="+label);
						}
					}
				}
			   StringBuffer sb = new StringBuffer();
			   Set set = goods.getGoods_dict().getGoodsClass_expands();
				if(set == null || set.size()== 0){//无属性
					logger.info("类目编码为"+goods.getGoods_dict().getGdcodes()+"无类目属性");
				}else{
					for (Iterator it = set.iterator(); it.hasNext();) {
						GoodsClass_expand gde = (GoodsClass_expand) it.next();
						//用|分割
						sb.append(gde.getGeTemp1());
						sb.append("|");
						sb.append(gde.getGeTemp2());
						sb.append("|");
						sb.append(gde.getGeTemp3());
						sb.append("|");
						sb.append(gde.getGeTemp4());
						sb.append("|");
						sb.append(gde.getGeTemp5());
						sb.append("|");
						sb.append(gde.getGeTemp6());
						sb.append("|");
						sb.append(gde.getGeTemp7());
						sb.append("|");
						sb.append(gde.getGeTemp8());
						sb.append("|");
						sb.append(gde.getGeTemp9());
						sb.append("|");
						sb.append(gde.getGeTemp10());
						sb.append("|");
						sb.append(gde.getGeTemp11());
						sb.append("|");
						sb.append(gde.getGeTemp12());
						sb.append("|");
						sb.append(gde.getGeTemp13());
						sb.append("|");
						sb.append(gde.getGeTemp14());
						sb.append("|");
						sb.append(gde.getGeTemp15());
						break;//只得到第一条数据
					}
					String dict_attr_str = sb.toString();
					
					String[] ge_temp = dict_attr_str.split("\\|");
					logger.info("ge_temp.length="+ge_temp.length);
					int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
					for(int j=0;j<ge_temp.length;j++){
						if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
							logger.info("为空不处理");
						}else{
							//alert("ge_temp["+j+"]="+ge_temp[j]);
							String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
							logger.info("str2.length="+str2.length);
							logger.info("str2="+ge_temp[j]);
							
							if(str2.length != 6){//去掉不规范数据
								logger.info("数据不规范");
							}else{
								
								String tag =str2[0];
								
								String label = str2[1];
								String tips  = str2[2];
								String keystr  = str2[3];
								String valuestr  = str2[4];
								String specflag  = str2[5];
								
								String tagid = "";//标签的id值
								String tagname = "";//标签的name值
								if(tag.equals("1")){//文本框
									//文本框
									//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
									tagid = "input"+j;
									tagname = "input"+j; 
									//这里keystr 在文本框中默认是1 不需要填入
									String[] str3_value = valuestr.split("-");
									String inputstr = "";
									if(attr_map.containsKey(label)){
										String[]  ss = {label,str3_value[0]};
										attributMap.put(j,ss );
									}
								}else if(tag.equals("2")){//下拉框
									tagid = "select"+j;
									tagname = "select"+j;
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									//logger.info(str3_key.length+"----"+str3_value.length);
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("下拉框中的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									String optkey = "";
									if(attr_map.containsKey(label)){
										optkey = attr_map.get(label)[3];
										for(int i=0;i<str3_key.length;i++){//
											if(optkey.equals(str3_key[i])){
												String[]  ss = {label,str3_value[i]};
												attributMap.put(j,ss );
											}
										}
										
									}
								}else if(tag.equals("3")){//多选框
									//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
									tagid = "checkbox"+j;
									tagname = "checkbox"+j;
									
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("多选框的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									if(specflag.trim().equals("0")){
										String checkkeys = "";
										String ckvaluestr = "";
										if(attr_map.containsKey(label)){
											checkkeys = attr_map.get(label)[3];
											String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
											
											for(int i=0;i<str3_key.length;i++){
												String ckstr = "";//定义一个变量 是否选中
												for (int k = 0; k < checkkey.length; k++) {
													if(checkkey[k].equals(str3_key[i])){
														ckstr="checked='checked'";
														ckvaluestr += str3_value[i]+",";
														break;
													}//满足条件 选中 并推出当前循环
												}
											}
										}
										if(ckvaluestr.equals("")){
											ckvaluestr = "无";
										}else{
											ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
										}
										
										String[]  ss = {label,ckvaluestr};
										attributMap.put(j,ss );
										
									}else if(specflag.trim().equals("1")){
										
										
									}else{//规格鉴别标识错误
										logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
									}
								}else if(tag.equals("4")){//单选框
									tagid = "radio"+j;
									tagname = "radio"+j;
									//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
									String[] str3_key = keystr.split("-");//第三次分割
									String[] str3_value = valuestr.split("-");
									
									if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
										logger.info("多选框的选项数据没有或者不匹配");
										continue;//终止本次循环下面的操作
									}
									
									String radiokey = "";
									
									if(attr_map.containsKey(label)){
										radiokey = attr_map.get(label)[3];
										for(int i=0;i<str3_key.length;i++){
											String ckstr = "";
											if(radiokey.equals(str3_key[i])){
												ckstr = "checked";
												String[]  ss = {label,str3_value[i]};
												attributMap.put(j,ss );
											}
										}
									}
								}else{
									logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
								}
							}
						}
					}
				}
			   
		     request.setAttribute("getpropertys",attributMap);

		} catch (Exception e) {
			logger.error("++" + NewportalSaleGoodsAction.class.getName()
					+ "...sgOrder");
			e.printStackTrace();
		}

		return "sgorder";
	}

	/*
	 * 查询所有的客户
	 */
	public String selectCus() {
		try {
			String demo = request.getParameter("flag");
			if (null == demo) {
				demo = "2";
			}
			request.setAttribute("demo", demo);
			String hql = "from Customer as c where 1=1 ";
			// 客户名称
			if (cusname != null && !cusname.equals("")) {
				hql += " and c.customerName like '%" + cusname + "%'";
				request.setAttribute("cusname", cusname);
			}
			// 公司名称
			if (customerCompany != null && !customerCompany.equals("")) {
				hql += " and c.customerCompany like '%" + customerCompany
						+ "%'";
				request.setAttribute("customerCompany", customerCompany);
			}
			// 业务负责人
			if (strempname != null && !strempname.equals("")) {
				String str = URLDecoder.decode(strempname, "utf-8");
				hql += " and c.employee.name like '%" + str + "%'";

				request.setAttribute("strEmp", str);
			}
			hql += " and c.customerType2 =3 order by c.customerId desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
					null);
			request.setAttribute("pages", page);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		if(request.getParameter("cust")!=null){
			return "newselectcus";
		}else{
			return "selectcus";
			
		}
	
	}
	/**
	 * 查询客户层 客户列表——关联出入库
	 * 23.5.14 14032
	 * @return
	 */
     
	public String selectcust(){
		
		String ckname=request.getParameter("product");//出库单号
		String hql="From Customer   where 1=1"; 
		
		if(ckname!=null){
			
			hql+="  and customerName like '%"+ckname+"%'";
		}
		hql+="  and customerType2 =3 order by id desc";
		String pageNo = request.getParameter("pageNo") == null ? "1"
		: request.getParameter("pageNo");
		Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
		null);
		request.setAttribute("pages", page);
		return "newselectcus";
	}
	/*
	 * 
	 * 所有的出库单
	 */
	public String selectckd(){
		
		String ckname=request.getParameter("product");//出库单号
		String hql="From Outbound  "; 
		
		if(ckname!=null){
			
			hql+=" where outboundNo like '%"+ckname+"%'";
		}
		hql+=" order by id desc";
		String pageNo = request.getParameter("pageNo") == null ? "1"
		: request.getParameter("pageNo");
		Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
		null);
		request.setAttribute("pages", page);
		return "selectckd";
	}
	/*
	 * 所有仓库 
	 */
	public String selectdepto(){
		
		String ckname=request.getParameter("deptoname");//仓库名字
		
		String hql="FROM  Depot ";
		if(ckname!=null){
			
			hql+=" where  name='"+ckname+"'";
		}
		String pageNo = request.getParameter("pageNo") == null ? "1"
				: request.getParameter("pageNo");
		Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
				null);
		request.setAttribute("pages", page);
		if(request.getParameter("div")!=null){
			return "selectdepto";
		}else{
		return "selectdepto1";
		}
	}
	/*
	 * 所有仓库
	 */
	public String selectproduct(){
		
		String ckname=request.getParameter("product");//产品名字
		String depotid=request.getParameter("depotid");
		String hql="FROM  Property where delflag=0";
		if(ckname!=null){
			
			hql+=" and  name like '%"+ckname+"%'";
		}
		String pageNo = request.getParameter("pageNo") == null ? "1"
				: request.getParameter("pageNo");
		Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
				null);
		request.setAttribute("pages", page);
		return "selectproduct";
	}
public String selectproduct1(){
		
		String ckname=request.getParameter("product");//产品名字
		String depotid=request.getParameter("depotid");
		if(depotid!=null){
			request.getSession().setAttribute("sdepotid", depotid);
			
		}else{
			
			depotid=(String)request.getSession().getAttribute("sdepotid");
			
		}
		String hql="FROM  Product where delflag=0 and usestate=2 and  depot.id="+Integer.parseInt(depotid);
		if(ckname!=null){
			
			hql+=" and  barcode like '%"+ckname+"%'";
		}
		String pageNo = request.getParameter("pageNo") == null ? "1"
				: request.getParameter("pageNo");
		Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
				null);
		request.setAttribute("pages", page);
		return "selectproduct1";
	}
	/**
	 * 所有采购单查询
	 * @return
	 */
	 public String selectpurOrder(){
		 String purid=request.getParameter("purorder");//采购单di
		 
		 String hql="FROM  PurOrder where Delflag!='1'";
		 if(purid!=null){
			 
			 hql+=" and purOrderNo like '%"+purid+"%'";
			 
		 }
		 
		 String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
					null);
			request.setAttribute("pages", page);
		 return "selectpurOrder";
	 }
	 /**
	  * puroreder info
	  */
	
	 /*
	  * 
	  * 查询采购单详情
	  */
	 public void selectpruOinfo(){
		 
		 String str="";
		 String purOrder=request.getParameter("purOrder");
		 String hql="From PurOrderInfo where purOrder.purOrderNo='"+purOrder+"'";//根据请购单获得详情
		 List purlist=pdao.execHQL(hql);
		 PurOrderInfo pui=new PurOrderInfo();//采购单具详情
		
		
		 
		 
		 Model mo=new Model();//s商品详情
		 
		 
		 if(purlist.size()>0){
			 
			 pui=(PurOrderInfo)purlist.get(0);
			 
			 
			 
			 mo=pui.getModel();
			
			 
		 }
		 Double  num=pui.getSum();//总和
		 Double  pirce=pui.getPrice();//单价
		 Integer  con=pui.getCount();//数量
		 String  name=mo.getName();//名称
		 String  ss= mo.getCommodityTpye().getTypeName();//商品类型
		 
		 str=Double.toString(num)+","+Double.toString(pirce)+","+
		 String.valueOf(con)+","+name+","+ss+","+purOrder;
		 System.out.println(str);
		 try {
			 response.setContentType("text/html; charset=GBK");
			response.getWriter().print(str);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	 }
	 public void selectckdnr(){
		 
		 String str="";
		 String purOrder=request.getParameter("purOrder");
		 String hql="From OutboundInfo where outbound.outboundNo='"+purOrder+"'";//根据请购单获得详情
		 List purlist=pdao.execHQL(hql); 
		
		 for (int i = 0; i < purlist.size(); i++) {
			 OutboundInfo pui=new OutboundInfo();//采购单具详情
			 pui=(OutboundInfo)purlist.get(i);
			 Product pr=new Product();
			 pr=pui.getProduct();
			
			
			 str+=Double.toString(pr.getProperty().getPprice())+","+Double.toString(pr.getUseSum())+","+
			 String.valueOf(purlist.size())+","+pr.getProperty().getModel().getName()+","+pr.getBarcode()+","+pr.getProperty().getModel().getCommodityTpye().getTypeName()+","+purOrder+"|";
			 System.out.println(str);
		}
		 try {
			 response.setContentType("text/html; charset=GBK");
			response.getWriter().print(str);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 
		 
	 }
	/*
	 * 添加出款单
	 */
	 public String adddepot(){
		 String CKBum=request.getParameter("CKBum");//出库单号
		 String cktime=(String)request.getParameter("cksj");//出库时间
		 String depid=request.getParameter("depid");//仓库位置
		 String cklx=request.getParameter("cklx");//出库类型
		 String cksl=request.getParameter("cksl");//出库数量
		 String ckzj=request.getParameter("ckzj");//出库价格
		 String bz=request.getParameter("bz")!=null?request.getParameter("bz"):"";//出库价格
		 String plist=request.getParameter("productlist");//商品列表
		 String[] list=plist.split(",");
		 
		 DateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		 format.setLenient(false);  //要转换字符串 str_test  String str_test ="2011-04-24";  
		 try {  
	     Timestamp ts = new Timestamp(format.parse(cktime).getTime());   
		 System.out.println(ts.toString()); 
		 
		 
		 Employee employee=(Employee)request.getSession().getAttribute("emp");
		 String sql="from Depot where id="+Integer.parseInt(depid);
		 List depotlist=pdao.execHQL(sql);
		 Depot depot=(Depot)depotlist.get(0);
		 AllType at=new AllType();
		 String  atsql="from AllType where id="+Integer.parseInt(cklx);
		 List    alltlist=pdao.execHQL(atsql);
		 at=(AllType)alltlist.get(0);
		 Outbound ob=new Outbound();
		 ob.setDelflag("0");
		 ob.setEmployee(employee);
		 ob.setDepot(depot);
		 ob.setTime(cktime);
		 ob.setAllType(at);
		 ob.setOutboundNo(CKBum);
		 ob.setAuditingState(0);
		 pdao.add(ob);
		for (int i = 0; i < list.length; i++) {
			
		
		 String prostl="FROM Product where id="+Integer.parseInt(list[i]);
		 List    prostllist=pdao.execHQL(prostl);
		 Product product =new Product();
		 product=(Product)prostllist.get(0);
		 product.setUsestate(2);
		 Object p= pdao.Update(product);
		 OutboundInfo oinfo=new OutboundInfo();
		 oinfo.setOutbound(ob);
		 oinfo.setProduct((Product)p);
		 pdao.add(oinfo);
		 
			}
		 
		 } 
		 catch (Exception e) { 
			 // TODO Auto-generated catch block   
			 e.printStackTrace();  
		 }
		 return "adddepot";
	 }
	/*
	 * 查询所有的客户
	 */
	public String selectCus2() {
		try {
//			String demo = request.getParameter("flag");
//			if (null == demo) {
//				demo = "2";
//			}
//			request.setAttribute("demo", demo);
			String hql = "from Customer as c where 1=1 ";
			// 客户名称
			if (cusname != null && !cusname.equals("")) {
				hql += " and c.customerName like '%" + cusname + "%'";
				request.setAttribute("cusname", cusname);
			}
			// 公司名称
			if (customerCompany != null && !customerCompany.equals("")) {
				hql += " and c.customerCompany like '%" + customerCompany
						+ "%'";
				request.setAttribute("customerCompany", customerCompany);
			}
			// 业务负责人
			if (strempname != null && !strempname.equals("")) {
				String str = URLDecoder.decode(strempname, "utf-8");
				hql += " and c.employee.name like '%" + str + "%'";

				request.setAttribute("strEmp", str);
			}
			hql += " and c.customerType2 =3 order by c.customerId desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
					null);
			request.setAttribute("pages", page);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "selectcus2";
	}
	
	/*
	 * 查询所有的人员请求
	 */
	public String selectEmp() {
		try {
			String hql = "from Employee as e where 1=1 ";
			if (empname != null && !empname.equals("")) {
				hql += " and e.name like '%" + empname + "%'";
				request.setAttribute("empnames", empname);
			}
			hql += " order by e.id desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
					null);
			request.setAttribute("pages", page);
		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "selectemp";
	}

	/*
	 * 查询所有的人员请求
	 */
	public String selectEmpInfo() {
		try {
			String hql = "from Employee as e where 1=1 ";
			if (empname != null && !empname.equals("")) {
				hql += " and e.name like '%" + empname + "%'";
				request.setAttribute("empname", empname);
			}
			hql += " order by e.id desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
					null);
			request.setAttribute("pages", page);
		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "selectemp";
	}

	/*
	 * 查询客户关联的多个地址表
	 */
	public String selectDaddress() {
		try {
			String cusid = request.getParameter("cusid");
			String hqlcus = "from Customer as c where 1=1 and c.customerId ="
					+ new Integer(cusid);
			Customer customer = (Customer) this.pdao.execHQL(hqlcus).get(0);

			String hql = "from DeliveryAddress as da where 1=1 and da.customer.customerId";
			if (cusid != null && !cusid.equals("")) {
				hql += "=" + new Integer(cusid);
			} else {
				hql += "=" + 0;
			}
			List listda = pdao.execHQL(hql);
			String strTemp = "<table width='100%'  border='0' cellspacing='0' cellpadding='0' id='newaddressid' style='font-size: 12px;'>";

			if (listda != null && listda.size() > 0) {
				for (int i = 0; i < listda.size(); i++) {
					DeliveryAddress address = (DeliveryAddress) listda.get(i);
					if (address.getDef() != null
							&& "1".equals(address.getDef())) {
						strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
								+ "<td width='91%' align='left' class='td_center'>"
								+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='"
								+ address.getNetherlands()
								+ " "
								+ address.getParticularAddress()
								+ " ("
								+ address.getConsignee()
								+ "收)   "
								+ address.getMobile() + "' />";
						strTemp += address.getNetherlands()
								+ " "
								+ address.getParticularAddress()
								+ " ("
								+ address.getConsignee()
								+ "收)   "
								+ address.getMobile()
								+ "默认地址 &nbsp;<a href='javascript:void(0);' class='lv' onclick='changaddress("
								+ address.getAddressId() + ","
								+ customer.getCustomerId()
								+ ");'>修改本地址</td></tr>";
					}

					// String defaultress =
					// address.getNetherlands()+"|"+address.getParticularAddress()+"|("+address.getConsignee()+")  "+address.getmo;\
					if (address.getDef() != null
							&& !"1".equals(address.getDef())) {
						strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td><td width='91%' align='left' class='td_center'>"
								+ "<input name='radio' type='radio' value='"
								+ address.getNetherlands()
								+ " "
								+ address.getParticularAddress()
								+ "("
								+ address.getConsignee()
								+ "收)"
								+ address.getMobile()
								+ "' id='address' onclick='onclickshow();' />"
								+ "<span id='cuscomaddress'>"
								+ address.getNetherlands()
								+ " "
								+ address.getParticularAddress()
								+ "("
								+ address.getConsignee()
								+ "收)"
								+ address.getMobile()
								+ ""
								+ "</span>&nbsp;&nbsp;设为<a href='javascript:void(0);' onclick='defaultaddress("
								+ address.getAddressId()
								+ ","
								+ customer.getCustomerId()
								+ ");'>默认地址 </a>&nbsp;&nbsp;"
								+ "<a href='javascript:void(0);' class='lv' onclick='changaddress("
								+ address.getAddressId()
								+ ","
								+ customer.getCustomerId()
								+ ");'>修改本地址</a></td></tr>";
					}
				}
			} else {
				strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'><b class='jszt'>寄送至</b></td>"
						+ "<td width='91%' align='left' class='td_center'>"
						+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='radio' />无收获地址</td></tr>";
			}
			strTemp += "<tr style='font-size: 12px;'><td width='9%' align='center' class='td_center'>&nbsp;</td>"
					+ "<td width='91%' align='left' class='td_center'>"
					+ "<input name='radio' onclick='onclickshow();' type='radio' id='radio' value='wu' />"
					+ "无(虚拟地址)</td></tr></table>";
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(strTemp);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 添加销售订单
	 */
	public String addsaleorder() {
		try {
			logger.info("add sale_orders start");
			// 订单状态，默认状态2
			
			// 审批状态,默认状态0
			orders.setSoCheckStat(0);//
			orders.setMeetPrice(0);//默认应付价为0
			
			String delivprice = request.getParameter("delivprice");
			if(null == delivprice && "".equals(delivprice))
			{
				delivprice = "0";
			}
			double delivprices = new Double(delivprice);
			orders.setDevilvprice(delivprices);//邮费
			// 下订单时间
			SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd HH:ss");
			orders.setSoOrderTime(sm.format(new Date()));//下订单时间
			// 客户
			String cusid = request.getParameter("cusid");
			Customer customer = null;
			if (cusid != null && !cusid.equals("")) {
				customer = (Customer) pdao.get(Customer.class, new Integer(
						cusid));
			}
			orders.setCustomer(customer);//关联客户
			// 得到商品
			String sgid = request.getParameter("sgid");
			double price = 0.0;
			double sumprice = 0.0;
			Sale_goods goods = null;
			goods = (Sale_goods) pdao.get(Sale_goods.class, new Integer(
						sgid));
			price = goods.getSgPrice();
			
			// 得到数量
			SaleGoods_mids goodsMids = new SaleGoods_mids();
			String count = request.getParameter("count");
			if (count != null && !count.equals("")) {
				sumprice = price * new Integer(count);
				sumprice += delivprices;
				goodsMids.setSoOrderNumber(new Integer(count));//商品数量
				orders.setCount(new Integer(count));//商品数量
			} else {
				sumprice = price * 1;
				sumprice += delivprices;
				goodsMids.setSoOrderNumber(1);
				orders.setCount(new Integer(count));//商品数量
			}
			// 价格
//			orders.setSgPrice(sumprice);//总价
			orders.setSgPrice(price);//单价  6-20 冷改
			// 送货方式
			String sgDelivtype = request.getParameter("sotype");
			orders.setSgDelivtype(sgDelivtype);//邮寄方式
			// 送货地址
			String finaladdress = request.getParameter("finaladdress");
			orders.setSgAddress(finaladdress);//邮寄地址
			
			// 代客操作人
			String empid = request.getParameter("empid");

			Employee employee = (Employee) pdao.get(Employee.class,
					new Integer(empid));
			orders.setEmployee(employee);//关联员工
			
			Questioncategory qu = null;
			orders.setAllTypeByOrdertype(qu);//不做处理

			String statchang = request.getParameter("statchang");
			orders.setStatchang(new Integer(statchang));//提交并审核或者直接提交标识
			
			//商品详情
			String divsg = request.getParameter("divsgs");
			orders.setDivsg(divsg);//商品详情
			orders.setPrices(sumprice);//总价格
			
			if(goods.getSgchecks().equals("0"))
			{
				orders.setSoStat(1);//实物订单 不是上架类型
			}else
			{
				orders.setSoStat(0);//上架类型 
				String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='XXTXSDD'";
				List list = pdao.execHQL(hql);
				if(null != list && 0<list.size() && null !=statchang && "0".equals(statchang))
				{
					// 添加审批
					int marker = product_CommentService.addAuditingOrder2("XXTXSDD",
							orders.getSoNums(), "Sale_orders", ck.getCookie(
									request, "filialemark"));
				}else if(null != statchang && "1".equals(statchang))
				{
					
				}
			}
			
			
			// /添加销售订单
			Sale_orders saleOrders = pdao.add(orders);
			//			
			// 添加商品与订单的中间表

			goodsMids.setSale_goods(goods);
			goodsMids.setSale_orders(saleOrders);
			goodsMids.setSoCheckStat(0);//待审核
			
			pdao.addsm(goodsMids);
			
			String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='XXTXSDD'";
			List list = pdao.execHQL(hql);
			if(null == list && 0>=list.size())
			{
				String upsql = "update sale_orders set so_stat =3 where so_id ="+saleOrders.getSoId();//不明白
				boolean falg = pdao.updateRC(upsql);
			}
			
//			logger.info("===marker" + marker);
			
			

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName()
					+ ".addsaleorder");
			e.printStackTrace();
		}
		return "selectso";
	}

	/*
	 * 查看订单
	 */
	public String selectsorder() {
		try {
			logger.info("==start");
			String demo = request.getParameter("demo");
			if (null == demo) {
				demo = "sg";
			}
			request.setAttribute("demo", demo);
			String hql = "from SaleGoods_mids as sgm where 1=1";
			// 商品名称
			if (saleName != null && !saleName.equals("")) {
				hql += " and sgm.sale_goods.sgname like '%" + saleName + "%'";
				request.setAttribute("saleName", saleName);
			}
			// 订单号
			if (soNums != null && !soNums.equals("")) {
				hql += " and sgm.sale_orders.soNums like '%" + soNums + "%'";
				request.setAttribute("soNums", soNums);
			}
			// 订单状态-
			if (soStat != null && !soStat.equals("") && !soStat.equals("-1")) {
				hql += " and sgm.sale_orders.soStat =" + new Integer(soStat);
				request.setAttribute("soStat", soStat);
			}
			// 买家昵称
			if (curName != null && !curName.equals("")) {
				hql += " and sgm.sale_orders.customer.customerName like '%"
						+ curName + "%'";
				request.setAttribute("curName", curName);
			}

			hql += " order by sgm.sale_orders.soId desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");

			Pages page = pdao
					.paginationQuery(hql, new Integer(pageNo), 3, null);
			request.setAttribute("pages", page);
		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "allso";
	}

	public Sale_orders getOrders() {
		return orders;
	}

	public void setOrders(Sale_orders orders) {
		this.orders = orders;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public Product_orderService getProduct_CommentService() {
		return product_CommentService;
	}

	public void setProduct_CommentService(
			Product_orderService productCommentService) {
		product_CommentService = productCommentService;
	}

	public prodect_OrderDao getPdao() {
		return pdao;
	}

	public void setPdao(prodect_OrderDao pdao) {
		this.pdao = pdao;
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

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public String getSaleName() {
		return saleName;
	}

	public void setSaleName(String saleName) {
		this.saleName = saleName;
	}

	public String getocode() {
		return sgcode;
	}

	public void setSgcode(String sgcode) {
		this.sgcode = sgcode;
	}

	public String getStartMoney() {
		return startMoney;
	}

	public void setStartMoney(String startMoney) {
		this.startMoney = startMoney;
	}

	public String getEndMoney() {
		return endMoney;
	}

	public void setEndMoney(String endMoney) {
		this.endMoney = endMoney;
	}

	public String getStartVolume() {
		return startVolume;
	}

	public void setStartVolume(String startVolume) {
		this.startVolume = startVolume;
	}

	public String getEndVolume() {
		return endVolume;
	}

	public void setEndVolume(String endVolume) {
		this.endVolume = endVolume;
	}

	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public String getCusname() {
		return cusname;
	}

	public void setCusname(String cusname) {
		this.cusname = cusname;
	}

	public String getCustomerCompany() {
		return customerCompany;
	}

	public void setCustomerCompany(String customerCompany) {
		this.customerCompany = customerCompany;
	}

	public String getVendition() {
		return vendition;
	}

	public void setVendition(String vendition) {
		this.vendition = vendition;
	}

	public String getEmpname() {
		return empname;
	}

	public void setEmpname(String empname) {
		this.empname = empname;
	}

	public String getSoNum() {
		return soNum;
	}

	public void setSoNum(String soNum) {
		this.soNum = soNum;
	}

	public String getSoStat() {
		return soStat;
	}

	public void setSoStat(String soStat) {
		this.soStat = soStat;
	}

	public String getCurName() {
		return curName;
	}

	public void setCurName(String curName) {
		this.curName = curName;
	}

	public UpServer getUps() {
		return ups;
	}

	public void setUps(UpServer ups) {
		this.ups = ups;
	}

	public UpserverBussiness getUpb() {
		return upb;
	}

	public void setUpb(UpserverBussiness upb) {
		this.upb = upb;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	/**
	 * 获得当前登录员工信息
	 * 
	 * @return
	 * @time 2012-01-10 14:14:10
	 */
	public Employee getEmp() {
		Object object = request.getSession().getAttribute("emp");
		Employee loginEmp = null;
		if (null != object) {
			loginEmp = (Employee) object;
		}
		return loginEmp;
	}

	public String getRvid() {
		return rvid;
	}

	public void setRvid(String rvid) {
		this.rvid = rvid;
	}

	public String getEmpnames() {
		return empnames;
	}

	public void setEmpnames(String empnames) {
		this.empnames = empnames;
	}

	public String getDepotid() {
		return depotid;
	}

	public void setDepotid(String depotid) {
		this.depotid = depotid;
	}

	public Object[] getObjs() {
		return objs;
	}

	public void setObjs(Object[] objs) {
		this.objs = objs;
	}

	public String getStrempname() {
		return strempname;
	}

	public void setStrempname(String strempname) {
		this.strempname = strempname;
	}

	public String getDemo() {
		return demo;
	}

	public void setDemo(String demo) {
		this.demo = demo;
	}

	public String getSoNums() {
		return soNums;
	}

	public void setSoNums(String soNums) {
		this.soNums = soNums;
	}

}
