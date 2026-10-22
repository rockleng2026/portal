<%
/* *
 功能：支付宝页面跳转同步通知页面
 版本：3.2
 日期：2011-03-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 该页面可在本机电脑测试
 可放入HTML等美化页面的代码、商户业务逻辑程序代码
 TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
 TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.fuao.fajxc.zfb.kjzf.*"%>
<%@ page import="com.fuao.fajxc.action.* " %>
<%@ page import="com.fuao.fajxc.vo.*" %>
<%@ page import="java.text.*" %>

<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>支付宝页面跳转同步通知页面</title>
  </head>
  <body>
<%
	//获取支付宝GET过来反馈信息
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
		/*
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
	  
	     
	 /*
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
	     
	   
			return "newsuccessPayfor";
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
		     
		     out.println("验证成功<br />");
				return "newsuccessPayfor";
				**/
		//newpayMember(total_fee,out_trade_no);
		//该页面可做页面美工编辑
		
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
		
		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//http://localhost:8080/FAJxc/zfb_jsfk/return_url.jsp?body=asd&buyer_email=18613619096&buyer_id=2088902697558524&exterface=create_direct_pay_by_user&is_success=T&notify_id=RqPnCoPT3K9%252Fvwbh3I73%252Bl5pBTTDvkwEsM1puiepnc%252BIK680QhyDcCXlFdgaWrI%252FQAt5&notify_time=2013-04-12+16%3A11%3A29&notify_type=trade_status_sync&out_trade_no=11121&payment_type=1&seller_email=a-logo%4021cn.com&seller_id=2088002026588045&subject=1212&total_fee=0.01&trade_no=2013041250377952&trade_status=TRADE_SUCCESS&sign=b64276e38d4d1fe15afb042b3f47aa7f&sign_type=MD5
		//该页面可做页面美工编辑
		out.println("验证失败");
	}
%>
  </body>
</html>