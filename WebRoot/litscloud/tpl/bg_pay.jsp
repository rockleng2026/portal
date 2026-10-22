<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <%@ page import="com.fuao.fajxc.util.yeepay.*" %>
    <%@ page import="java.text.*,java.util.*" %>
    <%@ page import="com.fuao.fajxc.action.customService.CustomServiceAction"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

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
<base href="<%=basePath %>" />
<title>立云-后台（在线支付）</title>
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
</head>
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
			return;
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

<body>
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心</div> 
          <div class="bg_c">
              <div class="bg_ct"><ul>
                <li><a href="bg_data.html" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">我的<br />账户</a></li>
                <li><a href="bg_indent.html">自助<br />管理</a></li>
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>
                    <li><a href="bg_data.html" >个人资料</a></li>
                    <li><a href="bg_pay.html" style="background-image:url(litscloud/images/bg_06.jpg); color:#000; background-repeat:no-repeat;">在线支付</a></li>
                    <li><a href="bg_password.html">修改密码</a></li>
                    <li><a href="bg_zhaopass.html">忘记密码</a></li>
                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
          </div> 
          <div class="bg_d">
           <form id="Form1" method="post" action="<%=nodeAuthorizationURL %>"/>
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_dqt"><font color="green">您的订单(<%=request.getParameter("ordernum")!=null?request.getParameter("ordernum"):"" %>${sgnum!=null?sgnum:''  })已生成，选择银行卡进行支付  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="litscloud/ucenter/my_order.jsp">返回我的订单页面</a></font></div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"><input style="width: 200px" type="hidden" name="p3_Amt" 
												id="p3_Amt" size="50" value="<%=request.getParameter("salMonys") %>" onblur="checkValueByRules('p3_Amt',['num'],'p3_AmtMsg')" readonly="readonly">
													<input style="width: 200px" type="hidden" name="p2_Order"
												id="p2_Order" size="50" value="<%=request.getParameter("ordernum")!=null?request.getParameter("ordernum"):"" %>${sgnum!=null?sgnum:''  }" readonly="readonly">
												
												</div>
                    </div>
                    <div class="bg_pay">
                       <div class="bg_pay_l">
                          <div class="bg_pay_c"> 
                             <div class="bg_pay_ct"> <a href="litscloud/tpl/bg_zfsy.jsp"><img src="litscloud/images/chinabank_logonew.jpg" /></a><a href="#"><img src="litscloud/images/alipay.jpg" style="margin-left:80px;" /></a></div>
                             <div class="bg_pay_cc">　 轻松一点，即时自动入款到您帐户,24小时实时在线支付，零手续费，即时到帐，安全便捷！ </div>
                             <div class="bg_pay_cm">其 他 支 付 方 式 </div>
                             <div class="bg_pay_cw">
                               <div class="bg_pay_cwl"><input type='radio' name='pd_FrpId' id='pd_FrpId' value='ICBC-NET' /><img src="litscloud/images/044.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>95588　0130　21064　54498</span><br />
复　制：9558801302106454498<br />
姓　名：汪冕<br />
开户行：中国工商银行安徽合肥市东陈岗分行</div>
                             </div>
                             <div class="bg_pay_cw" style="background-color:#f4f4f4;">
                               <div class="bg_pay_cwl"><input type='radio' name='pd_FrpId' id='pd_FrpId' value='ABC-NET' /><img src="litscloud/images/046.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>622848 066150 3558818</span><br /> 
复　制: 6228480661503558818<br />
姓　名：汪冕<br />
开户行：中国农业银行合肥市新站综合试验区支行</div>
                             </div>
                             <div class="bg_pay_cw">
                               <div class="bg_pay_cwl"><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CCB-NET' /><img src="litscloud/images/045.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>4367 4216 3802 0972 334</span><br />
复　制：4367421638020972334<br />
姓　名：汪冕<br />
开户行：中国建设银行合肥市青年路支行</div>
                             </div>
                             <div class="bg_pay_cw" style="background-color:#f4f4f4;">
                               <div class="bg_pay_cwl"><input type='radio' name='pd_FrpId' id='pd_FrpId' value='CMBCHINA-NET' /><img src="litscloud/images/051.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>6225 8855 1064 0873</span><br /> 
复　制: 6225885510640873<br />
姓　名：汪冕<br />
开户行：招商银行安徽合肥市马鞍山路支行</div>
                             </div>
                                <div class="bg_pay_cw">
                               <div class="bg_pay_cwl"><input type='radio' name='pd_FrpId' id='pd_FrpId' value='BOC-NET' /><img src="litscloud/images/052.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>6216 6663 0000 0302 567</span><br />
复　制：6216666300000302567<br />
姓　名：汪冕<br />
开户行：中国银行合肥市铜陵北路支行</div>
                             </div>
                             <div class="bg_pay_cw" style="background-color:#f4f4f4;">
                               <div class="bg_pay_cwl"><img src="litscloud/images/053.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>6228 7700 1000 1300 696</span><br /> 
复　制: 6228770010001300696<br />
姓　名：刘传勇<br />
开户行：徽商银行合肥新站支行</div>
                             </div>
                             <div class="bg_pay_cw">
                               <div class="bg_pay_cwl"><input type='radio' name='pd_FrpId' id='pd_FrpId' value='POST-NET' /><img src="litscloud/images/050.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>9551 0036 1000 0943 171</span><br />
复　制：9551003610000943171<br />
姓　名：汪冕<br />
开户行：邮政储蓄合肥市太湖东路邮政所</div>
                             </div>
                             <div class="bg_pay_cw" style="background-color:#f4f4f4;">
                               <div class="bg_pay_cwl"><img src="litscloud/images/066.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>wangzhao319@hotmail.com</span><br /> 
复　制: wangzhao319@hotmail.com<br />
姓　名：刘传勇<br /></div>
                             </div>
                                <div class="bg_pay_cw">
                               <div class="bg_pay_cwl"><img src="litscloud/images/055.gif" /></div>
                               <div class="bg_pay_cwr">帐　号：<span>100003522</span><br />
姓　名：汪冕<br />
                             </div>
                          </div>
                        <div class="bg_pay_cm" style="height:35px; line-height:35px;">公司账户</div>  
                            <div class="bg_pay_cw">
                               <div class="bg_pay_cwl"><img src="litscloud/images/052.gif" /></div>
                               <div class="bg_pay_cwr">开户行：中国银行----合肥新站开发区支行 <br />
帐　号：188719140166<br />
收款人名称：安徽八度网络科技有限公司<br />


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
				</div>
                          </div>
                        <div class="bg_pay_cd">银行或邮政汇款注意事项：<br />
1. 请将付款底单信息（汇票号码、日期等）扫描后发客服处，由客服转交给财务确认<br />
2. 请务必注明您的会员号或订单号等信息<br />
3. 发送付款底单信息请务必及时，如此会加快您的业务开展的步伐，避免耽误时间<br />
4. 注意事项：银行电汇底单须有银行加盖的转讫章；邮局收据上应有邮局日戳<br />
5. 八度网络所有报价均为不含税，如果您需要开发票，请在汇款时加8%的税点<br />
6. 招行、工行、农行、邮局汇款均是立即到帐，建行、中行为2个小时到帐，企业帐号3-5天内到帐。<br />
关于退款：<br />
1. 我公司承诺属产品质量问题且确认无法解决的均可以退款<br />
2. 退款时请填写退款申请表<br />
3. 请邮寄退款申请表及证件（个人或企业）至公司<br />
4. 我们将在收到申请表之后的7个工作日内给您办理退款手续<br />
5. 款项将退还到您注册的会员名下。<br /> 
</div>   
   <div class="bg_pay_ce"> <div class="bg_anc"><a href="javascript:SaveData()">下一步</a></div></div>
                        </form>  
                       </div>
                       </div>
                       <div class="bg_pay_r">
                         <div class="bg_pay_rc">
                            <div class="bg_pay_rct">立云公告</div>
                            <div class="bg_pay_rcc"><ul>
                               <li><a href="#">[通知]<span>OSS服务部分VIP下线通知</span></a></li>
                               <li><a href="#">[通知]<span>3月19日23:00起OSS服务升级</span></a></li>
                               <li><a href="#">[通知]<span>3月20日11:00起云服务升级</span></a></li>
                               <li><a href="#">[通知]3月网站备案信息抽查评估通知</a></li>
                               <li><a href="#">[通知]3月15日20:00起SLB服务升级</a></li>
                               <li><a href="#">[通知]3月14日22:00起云监控升级</a></li>
                            </ul></div>
                            <div class="bg_pay_rcm">
                              <a href="#"><img src="litscloud/images/bg_17.png" /></a>
                            </div>
                            <div class="bg_pay_rct" style="margin-top:20px;">热点活动</div>
                            <div class="bg_pay_rcd"><ul>
                               <li><a href="#"><span>免费备案，还送时间啦</span></a></li>
                               <li><a href="#"><span>第二波免费数据迁移倒计时</span></a></li>
                               <li><a href="#">推荐云服务器，送集分宝</a></li>
                            </ul></div>
                            <div class="bg_pay_rct" style="margin-top:10px;">热点话题<span class="blue"><a href="#" style="font-size:12px;">去论坛</a></span></div>
                            <div class="bg_pay_rcb"><ul>
                              <li><dl><a href="#">简述云服务器对比VPS</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">如何提高网站的打开速度</a></dl><dt>来自：<span>wanghaifei</span></dt></li>
                              <li><dl><a href="#">CPU、内存多少才够用？</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">网站访问速度快才是硬道理</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">如何节省网站访问流量？</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">阿里云弹性计算服务篇</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">云服务器配置满意度调查，说出来！</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">尖舌上的更换操作系统，为啥换？</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">云服务器教程征集令，说出你的困惑。</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                            </ul></div>
                         </div>
                       </div>
                    </div>
                </div>  
                
             </div>
             <div class="bg_dd"></div>
          </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
