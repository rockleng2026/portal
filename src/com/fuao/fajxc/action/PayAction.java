package com.fuao.fajxc.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.customService.CustomerServiceBussiness;
import com.fuao.fajxc.bussiness.finance.ChargeBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.system.DocmentBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.Charge;
import com.fuao.fajxc.vo.CurrencyProcess;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.SaledFlow;
import com.fuao.fajxc.zfb.kjzf.AlipayNotify;
import com.opensymphony.xwork2.ModelDriven;
import com.yeepay.Configuration;
import com.yeepay.PaymentForOnlineService;

public class PayAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private DocmentBussiness docbussiness;
	private CustomerServiceBussiness cuserBuss;
	private SaleorderBussiness salordBuss;
	private ChargeBussiness chargeMoneyBuss;
	private CustomerServiceBussiness csbiz;
	private static Logger logger=Logger.getLogger(PayAction.class);
	public CustomerServiceBussiness getCsbiz() {
		return csbiz;
	}

	public void setCsbiz(CustomerServiceBussiness csbiz) {
		this.csbiz = csbiz;
	}

	public ChargeBussiness getChargeMoneyBuss() {
		return chargeMoneyBuss;
	}

	public void setChargeMoneyBuss(ChargeBussiness chargeMoneyBuss) {
		this.chargeMoneyBuss = chargeMoneyBuss;
	}

	public SaleorderBussiness getSalordBuss() {
		return salordBuss;
	}

	public void setSalordBuss(SaleorderBussiness salordBuss) {
		this.salordBuss = salordBuss;
	}

	public CustomerServiceBussiness getCuserBuss() {
		return cuserBuss;
	}

	public void setCuserBuss(CustomerServiceBussiness cuserBuss) {
		this.cuserBuss = cuserBuss;
	}

	public DocmentBussiness getDocbussiness() {
		return docbussiness;
	}

	public void setDocbussiness(DocmentBussiness docbussiness) {
		this.docbussiness = docbussiness;
	}

	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
		
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
		
	}
	
	String formatString(String text){ 
		if(text == null) {
			return ""; 
		}
		return text;
	}
	
	
	//检查并跳转到银行页面
	public String paycheck()
	{
	  
		System.out.println("编码格式："+request.getCharacterEncoding());
		try {
			request.setCharacterEncoding("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("编码格式2："+request.getCharacterEncoding());
		
		String result = "";
		PrintWriter  out = null;
		try{
		response.setContentType("text/html;charset=GBK");
		out = response.getWriter();
		String keyValue	   = formatString(Configuration.getInstance().getValue("keyValue"));   					// 商家密钥
		System.out.println(keyValue);
		String nodeAuthorizationURL = formatString(Configuration.getInstance().getValue("yeepayCommonReqURL"));  	// 交易请求地址
		System.out.println(nodeAuthorizationURL);
		// 商家设置用户购买商品的支付信息
		String    p0_Cmd = formatString("Buy");// 在线支付请求，固定值 ”Buy”
		String    p1_MerId = formatString(Configuration.getInstance().getValue("p1_MerId")); 		// 商户编号
		
		String    p2_Order = formatString(request.getParameter("p2_Order"));           					// 商户订单号
		String	  p3_Amt = formatString(request.getParameter("p3_Amt"));     // 支付金额
		String	  p4_Cur = formatString("CNY");	   		   							// 交易币种
		System.out.println(p4_Cur);
		String	  p5_Pid = "";	//金币
		// 商品名称
		String	  p6_Pcat = "";//点
		System.out.println(p5_Pid+p6_Pcat);
		// 商品种类 
		String 	  p7_Pdesc = "";	// 商品描述
		String 	  p8_Url = formatString(request.getParameter("p8_Url")); 		       						// 商户接收支付成功数据的地址
		String 	  p9_SAF = formatString(request.getParameter("0")); 			   							// p9_SAF需要填写送货信息 0：不需要  1:需要
		String 	  pa_MP = "";//商家扩展信息
		System.out.println("pa_MP:"+pa_MP);
		String    pd_FrpId = formatString(request.getParameter("pd_FrpId"));       	   					// 支付通道编码
		// 银行编号必须大写
		pd_FrpId = pd_FrpId.toUpperCase();
		String 	  pr_NeedResponse = formatString(request.getParameter("pr_NeedResponse"));    // 是否需要应答机制
		//先验证ID是否存在
//		PaycenterRecord pr = customerService.queryPayRecordByOid(p2_Order);
//		if(pr != null ){
//			out.print("-1");
//			return null;
//		}
		String 	hmac = formatString("");							               							// 交易签名串
	    // 获得MD5-HMAC签名
	    hmac = PaymentForOnlineService.getReqMd5HmacForOnlinePayment(p0_Cmd,
				p1_MerId,p2_Order,p3_Amt,p4_Cur,p5_Pid,p6_Pcat,p7_Pdesc,
				p8_Url,p9_SAF,pa_MP,pd_FrpId,pr_NeedResponse,keyValue);
	    result = hmac;
	    
	    System.out.println("hmac:"+hmac);
	    //写入订单
	    Cookies ck = new Cookies();
		String userid = ck.getCookie(request, "ckuid");
		
		//Customer customer=cuserBuss.getcustomer(Integer.parseInt(request.getParameter("scusId")));
		request.getSession().setAttribute("payCustoms", request.getSession().getAttribute("customer"));
	}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		System.out.println("1"+result);
		out.print(result);
	    return null;	
	}
	public String payMember()
	{
		String keyValue   = formatString(Configuration.getInstance().getValue("keyValue"));   // 商家密钥
		String r0_Cmd 	  = formatString(request.getParameter("r0_Cmd")); // 业务类型
		String p1_MerId   = formatString(Configuration.getInstance().getValue("p1_MerId"));   // 商户编号
		String r1_Code    = formatString(request.getParameter("r1_Code"));// 支付结果
		String r2_TrxId   = formatString(request.getParameter("r2_TrxId"));// 易宝支付交易流水号
		String r3_Amt     = formatString(request.getParameter("r3_Amt"));// 支付金额
		String r4_Cur     = formatString(request.getParameter("r4_Cur"));// 交易币种
		String r5_Pid="";
		String r8_MP="";
		try {
			r5_Pid = new String(formatString(request.getParameter("r5_Pid")).getBytes("iso-8859-1"),"gbk");
		    r8_MP = new String(formatString(request.getParameter("r8_MP")).getBytes("iso-8859-1"),"gbk");// 商户扩展信息
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}// 商品名称
		String r6_Order   = formatString(request.getParameter("r6_Order"));// 商户订单号
		String r7_Uid     = formatString(request.getParameter("r7_Uid"));// 易宝支付会员ID
		String r9_BType   = formatString(request.getParameter("r9_BType"));// 交易结果返回类型
		String hmac       = formatString(request.getParameter("hmac"));// 签名数据
		boolean isOK = false;
		// 校验返回数据包
		isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code, 
				r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
		if(isOK) {
			if(r1_Code.equals("1")) {
				// 产品通用接口支付成功返回-浏览器重定向
				if(r9_BType.equals("1")) {
					//
					Customer customer = (Customer) request.getSession().getAttribute("payCustoms");
					List<RechargeLog> cuLis=docbussiness.selAllKinddatas("from RechargeLog  r where r.customer.customerId="+customer.getCustomerId());
					String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
					RechargeLog pl=new RechargeLog();
					pl.setId(0);
					pl.setOrderno(r6_Order);
					pl.setRechargemonery(r3_Amt);
					pl.setRechargeTime(date);
					pl.setCustomer(customer);
					if(cuLis.size()>0){
						Double balance = 0.0;
						for (RechargeLog rechLog : cuLis) {
							balance+=Double.valueOf(rechLog.getBalanc());
						}
						pl.setBalanc((balance+Double.parseDouble(r3_Amt))+"");
					}else{
						pl.setBalanc(0+"");
					}
					docbussiness.saveRecharge(pl);
					//
					SaledFlow sdf = new SaledFlow();
					SaledFlow sdf1 = new SaledFlow();
					List<SaleOrder> sOrder=salordBuss.getOrdersDate("from SaleOrder s where s.saleOrderNo='"+r6_Order+"'");
					 Charge chag = new Charge();
					for (SaleOrder saleOrder : sOrder) {
						chag.setSaleOrder(saleOrder);
						sdf.setTsaleorders(saleOrder);
						sdf1.setTsaleorders(saleOrder);
						List<SaledFlow> sflow=salordBuss.getOrdersDate("from SaledFlow s where s.Tsaleorders.id="+saleOrder.getId());
					    for (SaledFlow sff : sflow) {
							if(sff.getDfContent().equals("相关人员已审核等待用户付款...")){
								sff.setDfstat(0+"");
								salordBuss.updtFlowInfo(sff);
							}
					    }
					}
					 System.out.println("callback方式:产品通用接口支付成功返回-浏览器重定向");
				     sdf.setDfId(0);
				     sdf1.setDfId(0);
				     sdf1.setDfContent("冲值成功...交易流水号:" + r2_TrxId+"...支付金额:" + r3_Amt);
				     sdf.setDfContent("等待财务审核...");
				     sdf1.setDftime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				     salordBuss.saveFlowInfo(sdf1);
				     try {
						Thread.sleep(300);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				     sdf.setDftime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				     salordBuss.saveFlowInfo(sdf);
				     request.getSession().setAttribute("salsnos",r6_Order);//转到输出流程时用的。
				     
				 	 FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,"EveryDaySerialNumber.dat");
					 String no = serial.getSerialNumber();
					 String cno = "SK-" + no;
					 chag.setChargeNo(cno);
				     chag.setDefrayMode("支付宝");
				     chag.setPayCode(r2_TrxId);
				     chag.setIsAuditing(0);
				     chag.setAccountPayable(Double.valueOf(r3_Amt));
				     chag.setPaymentAmount(Double.valueOf(r3_Amt));
				     chag.setCollectionTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				     chag.setPayerName(customer.getRealName());
				     chargeMoneyBuss.addCharge(chag);
				     //response.setHeader("refresh","1,URL="+request.getContextPath()+"/IDCServ/PayForSuccess.jsp");
					// 产品通用接口支付成功返回-服务器点对点通讯
				} else if(r9_BType.equals("2")) {
					// 如果在发起交易请求时	设置使用应答机制时，必须应答以"success"开头的字符串，大小写不敏感
					System.out.println("SUCCESS");
				  // 产品通用接口支付成功返回-电话支付返回		
				}
				// 下面页面输出是测试时观察结果使用
				System.out.println("<br>交易成功!<br>商家订单号:" + r6_Order + "<br>支付金额:" + r3_Amt + "<br>易宝支付交易流水号:" + r2_TrxId);
			}
		} else {
			System.out.println("交易签名被篡改!");
		}
			return "successPayfor";
	}


public String newpayMember(String r3_Amt,String r6_Order)
{
	//String keyValue   = formatString(Configuration.getInstance().getValue("keyValue"));   // 商家密钥
	//String r0_Cmd 	  = formatString(request.getParameter("r0_Cmd")); // 业务类型
	//String p1_MerId   = formatString(Configuration.getInstance().getValue("p1_MerId"));   // 商户编号
	//String r1_Code    = formatString(request.getParameter("r1_Code")!=null?request.getParameter("r1_Code"):"1");// 支付结果
	//String r2_TrxId   = formatString(request.getParameter("r2_TrxId"));// 易宝支付交易流水号
	//String r3_Amt     = formatString(request.getParameter("r3_Amt")!=null?request.getParameter("r3_Amt"):"10000");// 支付金额
	//String r4_Cur     = formatString(request.getParameter("人民币"));// 交易币种
	//String r5_Pid="";
	//String r8_MP="";
	//String r6_Order   = formatString(request.getParameter("r6_Order")!=null?request.getParameter("r6_Order"):request.getParameter("p2_Order"));// 商户订单号
	//String r7_Uid     = formatString(request.getParameter("r7_Uid")!=null?request.getParameter("r7_Uid"):"text");// 易宝支付会员ID
	//String r9_BType   = formatString(request.getParameter("r9_BType")!=null?request.getParameter("r9_BType"):"1");// 交易结果返回类型
	//String hmac       = formatString(request.getParameter("hmac"));// 签名数据
	//boolean isOK = true;
	// 校验返回数据包
	//isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code, 
	//		r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
	

	//
	Customer customer = (Customer) request.getSession().getAttribute("customer");
	List<RechargeLog> cuLis=docbussiness.selAllKinddatas("from RechargeLog  r where r.customer.customerId="+customer.getCustomerId());
	String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
	RechargeLog pl=new RechargeLog();
	pl.setId(0);
	pl.setOrderno(r6_Order);
	pl.setRechargemonery(r3_Amt);
	pl.setRechargeTime(date);
	pl.setCustomer(customer);
	if(cuLis.size()>0){
		Double balance = 0.0;
		for (RechargeLog rechLog : cuLis) {
			balance+=Double.valueOf(rechLog.getBalanc());
		}
		pl.setBalanc((balance+Double.parseDouble(r3_Amt))+"");
	}else{
		pl.setBalanc(0+"");
	}
	docbussiness.saveRecharge(pl);
	//
	
	List<Sale_orders> sOrder=salordBuss.getOrdersDate("from Sale_orders s where s.soNums='"+r6_Order+"'");
	 Charge chag = new Charge();
	for (Sale_orders saleOrder : sOrder) {
		chag.setOrders(saleOrder);
		

	}
	 String sql="update sale_orders set so_stat=2 where  so_nums='"+r6_Order+"'";
	 salordBuss.update(sql);
	 System.out.println("callback方式:产品通用接口支付成功返回-浏览器重定向");
    
   
     try {
		Thread.sleep(300);
	} catch (InterruptedException e) {
		e.printStackTrace();
	}
  
     
 	 FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,"EveryDaySerialNumber.dat");
	 String no = serial.getSerialNumber();
	 String cno = "SK-" + no;
	 String hql="From Employee where empNo='14032'";
	 List list=docbussiness.exHql(hql);
	 List<Employee> l3=list;
	 
	 chag.setEmployeeByEmpId(l3.get(0));
	 chag.setChargeNo(cno);
     chag.setDefrayMode("支付宝");
     chag.setPayCode("ssggsfas");
     chag.setIsAuditing(0);
     chag.setAccountPayable(Double.valueOf(r3_Amt));
     chag.setPaymentAmount(Double.valueOf(r3_Amt));
     chag.setCollectionTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
     chag.setPayerName(customer.getRealName());
     chargeMoneyBuss.addCharge(chag);
     
   //获取时间
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
		String str_date1 = formatter.format(currentTime); //将日期时间格式化 
		//request.setAttribute("sNum",sgorderNum);//这个和sgnum值一样
		//流程通用通用方法(定单状态---生成定单，待付款-定单号，生成时间，
		CurrencyProcess cp=new CurrencyProcess();
		cp.setPname("客户已付款待财务接受");//对应流程名字
		cp.setPnum(r6_Order);//对应定单编号
		cp.setPstat(3);//对应定单状态
		cp.setBegintime(str_date1);
		chargeMoneyBuss.save(cp);
     
   
		return "newsuccessPayfor";
}


public String yz() {
	try{
Map<String,String> params = new HashMap<String,String>();
Map requestParams = request.getParameterMap();
for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
	String name = (String) iter.next();
	String[] values = (String[]) requestParams.get(name);
	String valueStr = "";
	for (int i = 0; i < values.length; i++) {
		valueStr = (i == values.length - 1) ? valueStr + values[i]
				: valueStr + values[i] + ",";
	}
	//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
	valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
	params.put(name, valueStr);
}

//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
//商户订单号

String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"GBK");
	
//支付金额


String total_fee = new String(request.getParameter("total_fee").getBytes("ISO-8859-1"),"GBK");
//支付宝交易号

String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"GBK");

//交易状态
String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"GBK");
logger.info(trade_no);
//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

//计算得出通知验证结果
boolean verify_result = AlipayNotify.verify(params);

if(verify_result){//验证成功
	//////////////////////////////////////////////////////////////////////////////////////////
	//请在这里加上商户的业务逻辑程序代码

	//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
	if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
		//判断该笔订单是否在商户网站中已经做过处理
			//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
			//如果有做过处理，不执行商户的业务程序
	}
	
	
	logger.info(total_fee);
	logger.info(out_trade_no);
	return newpayMember(total_fee,out_trade_no);
	//该页面可做页面美工编辑
	
	//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
	
	//////////////////////////////////////////////////////////////////////////////////////////
	}else{
	//http://localhost:8080/FAJxc/zfb_jsfk/return_url.jsp?body=asd&buyer_email=18613619096&buyer_id=2088902697558524&exterface=create_direct_pay_by_user&is_success=T&notify_id=RqPnCoPT3K9%252Fvwbh3I73%252Bl5pBTTDvkwEsM1puiepnc%252BIK680QhyDcCXlFdgaWrI%252FQAt5&notify_time=2013-04-12+16%3A11%3A29&notify_type=trade_status_sync&out_trade_no=11121&payment_type=1&seller_email=a-logo%4021cn.com&seller_id=2088002026588045&subject=1212&total_fee=0.01&trade_no=2013041250377952&trade_status=TRADE_SUCCESS&sign=b64276e38d4d1fe15afb042b3f47aa7f&sign_type=MD5
	//该页面可做页面美工编辑
	return "newsuccessPayfor";
}
	}catch (Exception e) {
		logger.error(e.getMessage());
	}
	return "";
	}
	
}