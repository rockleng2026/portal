<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
    <%@ page import="com.fuao.fajxc.util.yeepay.*" %>
    <%@ page import="java.text.*,java.util.*" %>
    <%@ page import="com.fuao.fajxc.action.customService.CustomServiceAction"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>payMoney</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
 <link href="<%=request.getContextPath()%>/IDCServ/css/main.css" rel="stylesheet" type="text/css" />
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
	var flags=1;
	var p3_Amt = $("#p3_Amt").val();
		if(p3_Amt == ''||p3_Amt=='0'){
			alert('请输入充值金额');
			$("#p3_Amt").focus();
			flags=0;
			return false;
		}

        var pd_FrpId = $(':radio[name=pd_FrpId][checked]').val(); 		
		if(pd_FrpId == undefined || pd_FrpId == ""){
			alert("\u8bf7\u9009\u62e9\u4ed8\u6b3e\u94f6\u884c!");
			flags=0;
			return false;
		}
		if(flags==1){
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
		var cuid=$('#scusId').val();
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
		scusId:cuid,
		la:la

},function(data){
	
	$("#hmac").val(data);
		     $("#Form1").submit();
	});
	}
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
    request.setCharacterEncoding("UTF-8");
	//String keyValue = formatString(Configuration.getInstance().getValue("keyValue"));   					// 商家密钥
	String nodeAuthorizationURL = formatString(Configuration.getInstance().getValue("yeepayCommonReqURL"));  	// 交易请求地址
	String p1_MerId = formatString(Configuration.getInstance().getValue("p1_MerId")); 		// 商户编号
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<body>
<jsp:include page="head.jsp"></jsp:include>
<div class="dd10">
  <form id="Form1" method="get" action="<%=nodeAuthorizationURL %>"><!-- /pal/pay/bank/reqpay.jsp -->
  <table cellspacing="1" class="dd1201">
  	<tr class="dd1202">
    	<td>订单号</td><td>支付用户：</td><td>金额（元）</td>
    </tr>
   
    <tr class="dd1203">
    	<td>
    	<input type="hidden" name="scusId" id="scusId" value="<%=request.getParameter("cusId")%>"> 
										
											<input style="width: 200px" type="text" name="p2_Order"
												id="p2_Order" size="50" value="<%=request.getParameter("salnos")%>" readonly="readonly">
    	</td><td>
    	<input style="width: 200px" type="text" name="buyCount"
												id="buyCount" size="50" value="<%=request.getParameter("flagsnos") %>" readonly="readonly"  onblur="checkValueByRules('buyCount','','buyCountMsg')"  >
											<FONT color=#ff0000 id="buyCountMsg"></FONT>
    	</td><td>
    	<input style="width: 200px" type="text" name="p3_Amt" 
												id="p3_Amt" size="50" value="<%=request.getParameter("salMonys") %>" onblur="checkValueByRules('p3_Amt',['num'],'p3_AmtMsg')" readonly="readonly">
											<FONT color=#ff0000 id="p3_AmtMsg"></FONT></td>
    </tr>
  </table> 
    <div class="dd1204">还差一步，请立即选择支付支付（请在24小时内支付，否则订单会被自动取消！）</div>
    <div class="dd1009" style="width:940px; background:#fafafa">
        	<ul>
                <li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='ICBC-NET' /><img src='<%=path %>/images/bankicon/gongshang.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CMBCHINA-NET' /><img src='<%=path %>/images/bankicon/zhaohang.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='ABC-NET' /><img src='<%=path %>/images/bankicon/nongye.gif'/></li>						
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CCB-NET' /><img src='<%=path %>/images/bankicon/jianshe.gif'/></li>
                <li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='BCCB-NET' /><img src='<%=path %>/images/bankicon/beijing.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='BOCO-NET' /><img src='<%=path %>/images/bankicon/jiaotong.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CMBC-NET' /><img src='<%=path %>/images/bankicon/minsheng.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CIB-NET' /><img src='<%=path %>/images/bankicon/xingye.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CEB-NET' /><img src='<%=path %>/images/bankicon/guangda.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='BOC-NET' /><img src='<%=path %>/images/bankicon/zhongguo.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='PINGANBANK-NET' /><img src='<%=path %>/images/bankicon/pingan.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='ECITIC-NET' /><img src='<%=path %>/images/bankicon/zhongxin.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='SDB-NET' /><img src='<%=path %>/images/bankicon/shenfa.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='POST-NET' /><img src='<%=path %>/images/bankicon/youzheng.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='SPDB-NET' /><img src='<%=path %>/images/bankicon/shangpufa.gif'/></li>
				<li><input type='radio' name='pd_FrpId' id='pd_FrpId' value='HKBEA-NET' /><img src='<%=path %>/images/bankicon/dongya.gif'/></li>
                <div class="clear"></div>
            </ul>
        </div>
        <input type='hidden' name='uid'  id="uid" value='test'>
        <input type='hidden' name='p0_Cmd'   value='Buy'>
		<input type='hidden' name='p1_MerId' value='<%=p1_MerId %>'>
        <input type="hidden" name="p4_Cur" id="p4_Cur" value="CNY"/>
        <input type="hidden" name="p5_Pid" id="p5_Pid" value="金币" />
		<input type="hidden" name="p6_Pcat" id="p6_Pcat" value="点" />
		<input type="hidden" name="p7_Pdesc" id="p7_Pdesc" value="商品描述" />
		<% 						
		//Properties p = new Properties();
		//p.load(getClass().getResourceAsStream("/pro.properties"));
		//String callB=p.getProperty("callbackBank");
		//System.out.println("callB:"+callB); %>
		<input type="hidden" name="p8_Url" id="p8_Url" value="<%=basePath %>payMemberOnlinepayment.Action"/>
		<input type="hidden" name="p9_SAF" id="p9_SAF" value="0"/>
		<input type="hidden" name="pa_MP" id="pa_MP" value="商家扩展信息" />
		<input type="hidden" name="pr_NeedResponse" id="pr_NeedResponse" value="0"/>
		<input type='hidden' name='hmac'  id="hmac" >
		<input id="la" type="hidden" value="金币">
		<div class="Detailed_B" style="float:right;">
			<a id="btnSave" onclick="javascript:SaveData()"><img src="<%=path %>/IDCServ/image/confim.gif"/></a>
		</div>
      </form>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
</body>
</html>
	