<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gb2312"%>
    <%@ page import="com.fuao.fajxc.util.yeepay.*" %>
    <%@ page import="java.text.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
<title>Insert title here</title>
<script type="text/javascript">
 
 $("#buyCount").bind("propertychange", buyYellowBoy);
//根据购买金币数量算出价格
	function buyYellowBoy()
	{
	if((/[^\d]/).test($("#buyCount").val()))
	{
	     $("#buyCount").val("");
	     $("#p3_Amt").val(0);
	}
	else if((/[\d]/).test($("#buyCount").val()))
	{
		var price=1;
		var count=$("#buyCount").val();
		var money=count*price;
		$("#p3_Amt").val(money);
		$.post('/pal/pay.do?method=setCount',{count:count});
    }
	}
	
	
	function SaveData(){
	var p3_Amt = $("#p3_Amt").val();
		if(p3_Amt == ''||p3_Amt=='0'){
			alert('请输入充值金额');
			$("#p3_Amt").focus();
			return false;
		}

        var pd_FrpId = $(':radio[name=pd_FrpId][checked]').val(); 		
		if(pd_FrpId == undefined || pd_FrpId == ""){
			alert("\u8bf7\u9009\u62e9\u4ed8\u6b3e\u94f6\u884c!");
			return false;
		}
		
		var p2_Order = $("#p2_Order").val();
		var p4_Cur = $("#p4_Cur").val();
		var p5_Pid = $("#p5_Pid").val();
		var p6_Pcat = $("#p6_Pcat").val();
		var p7_Pdesc = $("#p7_Pdesc").val();
		var p8_Url = $("#p8_Url").val();
		var p9_SAF = $("#p9_SAF").val();
		var pa_MP = $("#pa_MP").val();
		var pr_NeedResponse = $("#pr_NeedResponse").val();
		var uid = $("#uid").val();
		var la = $("#la").val();
		var url="paycheckOnlinepayment.Action";
		//定义缓存处理变量
		var nowDate = (new Date()).getTime();
		
	$.post("paycheckOnlinepayment.Action",{
        p2_Order:p2_Order,
		p3_Amt:p3_Amt,
		pd_FrpId:pd_FrpId,
		p4_Cur:p4_Cur,
		p5_Pid:p5_Pid,
		p6_Pcat:p6_Pcat,
		p7_Pdesc:p7_Pdesc,
		p8_Url:p8_Url,
		p9_SAF:p9_SAF,
		pa_MP:pa_MP,
		pr_NeedResponse:pr_NeedResponse,
		uid:uid,
		la:la

},function(data){
	
	$("#hmac").val($.trim(data));
		     $("#Form1").submit();
	});
	}
</script>
</head>
<%!	String formatString(String text){ 
			if(text == null) {
				return ""; 
			}
			return text;
		}
%>
<%

	String keyValue = formatString(Configuration.getInstance().getValue("keyValue"));   					// 商家密钥
	String nodeAuthorizationURL = formatString(Configuration.getInstance().getValue("yeepayCommonReqURL"));  	// 交易请求地址
	String p1_MerId = formatString(Configuration.getInstance().getValue("p1_MerId")); 		// 商户编号
	 String path = request.getContextPath();
	 %>
<body alink="center">
<form id="Form1" method="post" action="<%=nodeAuthorizationURL %>" target="_blank"><!-- /pal/pay/bank/reqpay.jsp -->
			<div class="Case_CF_R">
			 <div class="top">
      <h2>充值中心</h2>
      <ul class="manage-tab">
        <li ><a style="cursor:hand" onclick="divClassM('myYellowBoy','/pal/pay.do?method=myYellowBoy')">账户余额</a></li>       
        <li ><a style="cursor:hand" onclick="divClassM('consumeDetail','/pal/pay/bank/consumeDetail.jsp')">消费详情</a></li>
        <li><a style="cursor:hand" onclick="divClassM('orderDetail','/pal/pay/bank/orderDetail.jsp')">订单详细</a></li>
    </ul>  
  </div>
  <div class="Case_Title">
					<div class="F_Title"> 
						在线支付费用 
					</div>
				</div>
				<div class="Case_Content">
					<div style="height: 612px; overflow: auto">
						<div class="Detailed" style="margin-top: 20px;">

							<div class="Detailed_T"></div>

							<div class="Detailed_M">
								<table>
									<tr>
										<td class="Tab">
											订单ID：
										</td>
										<td>
										<%String date=new SimpleDateFormat("yyyy-MM-ddHHmmss").format(Calendar.getInstance().getTime());  %>
										
											<input style="width: 200px" type="text" name="p2_Order"
												id="p2_Order" size="50" value="FUAO<%=date%>" readonly="readonly">
											<font color="red">*</font>
										</td>
									</tr>
									<tr>
										<td class="Tab">
											需要充值的用户名：
										</td>
										<td>
											<input style="width: 200px" type="text" name="buyCount"
												id="buyCount" size="50" value="张三" onchange="" onblur="checkValueByRules('buyCount','','buyCountMsg')"  >
											<font color="red">*</font><FONT color=#ff0000 id="buyCountMsg"></FONT>
										</td>
									</tr>
									<tr>
										<td class="Tab">
											充值金额：
										</td>
										<td>
											<input style="width: 200px" type="text" name="p3_Amt" 
												id="p3_Amt" size="50" value="" onblur="checkValueByRules('p3_Amt',['num'],'p3_AmtMsg')">
											<font color="red">*</font><FONT color=#ff0000 id="p3_AmtMsg"></FONT>
										</td>
									</tr>																		
								</table>
								
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='ICBC-NET' /><img src='<%=path %>/images/bankicon/gongshang.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='CMBCHINA-NET' /><img src='<%=path %>/images/bankicon/zhaohang.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='ABC-NET' /><img src='<%=path %>/images/bankicon/nongye.gif'/>								
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='CCB-NET' /><img src='<%=path %>/images/bankicon/jianshe.gif'/>
								<br />
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='BCCB-NET' /><img src='<%=path %>/images/bankicon/beijing.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='BOCO-NET' /><img src='<%=path %>/images/bankicon/jiaotong.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='CMBC-NET' /><img src='<%=path %>/images/bankicon/minsheng.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='CIB-NET' /><img src='<%=path %>/images/bankicon/xingye.gif'/><br />
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='CEB-NET' /><img src='<%=path %>/images/bankicon/guangda.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='BOC-NET' /><img src='<%=path %>/images/bankicon/zhongguo.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='PINGANBANK-NET' /><img src='<%=path %>/images/bankicon/pingan.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='ECITIC-NET' /><img src='<%=path %>/images/bankicon/zhongxin.gif'/><br />
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='SDB-NET' /><img src='<%=path %>/images/bankicon/shenfa.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='POST-NET' /><img src='<%=path %>/images/bankicon/youzheng.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='SPDB-NET' /><img src='<%=path %>/images/bankicon/shangpufa.gif'/>
								<input type='radio' name='pd_FrpId' id='pd_FrpId' value='HKBEA-NET' /><img src='<%=path %>/images/bankicon/dongya.gif'/><br />
								
								
                                <input type='hidden' name='uid'  id="uid" value='test'>
                                <input type='hidden' name='p0_Cmd'   value='Buy'>
								<input type='hidden' name='p1_MerId' value='<%=p1_MerId %>'>
                                <input type="hidden" name="p4_Cur" id="p4_Cur" value="CNY"/>
                                <input type="hidden" name="p5_Pid" id="p5_Pid" value="金币" />
								<input type="hidden" name="p6_Pcat" id="p6_Pcat" value="点" />
								<input type="hidden" name="p7_Pdesc" id="p7_Pdesc" value="商品描述" />
								<% 
								
								Properties p = new Properties();
								p.load(getClass().getResourceAsStream("/pro.properties"));
								String callB=p.getProperty("callbackBank");
								System.out.println("callB:"+callB); %>
								<input type="hidden" name="p8_Url" id="p8_Url" value="<%=callB %>"/>
								<input type="hidden" name="p9_SAF" id="p9_SAF" value="0"/>
								<input type="hidden" name="pa_MP" id="pa_MP" value="商家扩展信息" />
								<input type="hidden" name="pr_NeedResponse" id="pr_NeedResponse" value="0"/>
								<input type='hidden' name='hmac'  id="hmac"   value=''>
								<input id="la" type="hidden" value="金币">
								<div class="Detailed_B">
									<INPUT id="btnreturn" onclick="history.go(-1)" type="button"
										value="返回" name="btnClose" >
									<INPUT id="btnSave" onclick="javascript:SaveData()"
										type="button" value="下一步" >
								</div>
							</div>
						</div>
					</div>
				</div>				
			</div>
		</form>
</body>
</html>