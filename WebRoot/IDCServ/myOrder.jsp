	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
    <base href="<%=basePath%>">
    <title>My JSP 'myOrder.jsp' starting page</title>
	<link href="<%=basePath%>IDCServ/css/right.css" rel="stylesheet" type="text/css" />
	
<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
 
		<script type="text/javascript"
			src="<%=basePath%>/js/My97DatePicker/changedate.js"></script>
 <script type="text/javascript" src="<%=basePath%>/js/validators.js" ></script>
	
	<script>
	     function orderFlo(mns){
	        //alert(mns);
	        document.getElementById("salnos").value=mns;
	        document.getElementById("snoForms").submit();
	     }
</script>
	</head>
	<%  
       Customer c=(Customer)session.getAttribute("customer"); 
    %>
	<body>

	<jsp:include page="head.jsp"></jsp:include>
    <jsp:include page="left.jsp"></jsp:include>
    <form action="<%=basePath%>customFlowCustomerServer.do" target="_blank" id="snoForms" method="post">
        <input type="hidden" name="salnos" id="salnos"/>
    </form>
      <div class="dd1302">
		<DIV class=navigation>
		<DIV class="crumbs " data-spm="6"><A href="#">我是买家</A><SPAN>&gt;</SPAN>
		<A href="#">交易管理</A><SPAN>&gt;</SPAN>已买到的宝贝 
		</DIV>
		<DIV class="msg view-help">
		<P class="help naked"><A href="#" target=_blank>查看帮助</A> </P></DIV></DIV>
		 <DIV id=J_Remide class=remide-box data-spm="7">
		<H3>我的交易提醒：</H3>
		<UL>
		  <LI><A href="#">待付款<SPAN 
		  class=num>(0)</SPAN></A></LI>
		  <LI><A href="#">待确认收货<SPAN 
		  class=num>(1)</SPAN></A></LI>
		  <LI><A href="#">待评价<SPAN 
		  class=num>(0)</SPAN></A></LI></UL> </DIV> 
		<DIV class=bought-list>
		<DIV class="msg ash-bin">
		<A class=J_MakePoint href="#">订单回收站</A> <IMG class=new-flag src="<%=basePath%>IDCServ/image/T1sT5gXnJaXXXXXXXX-21-12.png"> 
		<DIV id=J_recyleTip class=msg>
		<P class=ok>成功移至订单回收站</P></DIV></DIV>
		<UL class="tabpanel clearfix">
		  <LI class=current>
		  <DIV class=ordertype><A class="ordertype-default J_MakePoint" href="#">全部订单<I class=trigger></I></A> 
		  <P class=ordertype-whole><A class="selected J_MakePoint" href="#" >全部订单</A> 
		  <A href="#">机票订单</A> 
		  <A href="#">淘花订单</A> 
		  <A href="#">理财订单</A> 
		  <A href="#">网游订单</A> 
		  <A href="#">酒店订单</A> 
		  <A href="#">交行黄金</A>  </P></DIV>
		  </LI>
		  <LI class=leading-tip>
		  <DIV class=tm-bubble>
		  <P class=title>三个月前的订单也在"全部订单"里哦！查购物历史，更方便！</P><S 
		  class=triangle></S></DIV>
		  </LI></UL></DIV>  
		 <FORM class="skin-gray clearfix bought-search" method=post action=>
		<INPUT value=1 type=hidden name=event_submit_do_query>            
		<INPUT id=myAction value=itemlist/QueryAction type=hidden name=action> 
		<INPUT value=0 type=hidden name=user_type> 
		<INPUT id=order type=hidden name=order> 
		<INPUT id=visibility type=hidden name=visibility> 
		<INPUT id=J_FormExpandCls type=hidden name=wrap> 
		<INPUT type=hidden name=queryBizType> 
		<span  style="display:inline;">查询条件：<select id="sel" class="sel" onchange="change1(this.value)">
		<option value="0">下拉选择：</option>
		<option value="1">是否收货：</option>
		<option value="2">时间：</option>
		<option value="4">订单编号：</option>
		</select>
</span>
  <div id="d1" style="display: none;">
		<span style="margin-left: 200px">从：</span><input   class="Wdate" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd '})" maxdate="#F{$('htEnd').value}" name="begintime" id="htStart"  />
		<span>到：</span> <input  class="Wdate" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd '})" mindate="#F{$('htStart').value}"  name="begintime" id="htEnd"  /></div>
		<br/><input  id="inp" maxLength="30" style="color: green;margin-left: 180px;" size="50" title="请选选择查询条件在填写要查询的内容" alt="请选选择查询条件在填写要查询的内容" value="" type="text" name="inp" onfocus="chang2(this)" style="display: block"/>
		<br/>
		<BUTTON style="display: inline;margin-left: 330px" id="but" class="J_MakePoint button search-btn" type="button" onclick="selby()">搜索</BUTTON> 
	
	
		<A class="J_MakePoint less-filter" href="#" >精简筛选条件</A> </SPAN>
		<UL id=J_MoreControl class=search-filter>
		  <LI class=col1><LABEL>成交时间:</LABEL>&nbsp;&nbsp; 从 
		  <INPUT size=10 type=text name=bizOrderTimeBegin> 到 
		  <INPUT size=10 type=text name=bizOrderTimeEnd> </LI>
		  <LI class=col2><LABEL for=J_NickName>卖家昵称：</LABEL>&nbsp;&nbsp;
		  <INPUT size=15 type=text name=sellerNick> </LI>
		  <LI class=col3><LABEL for=J_ReviewStatus>评价状态：</LABEL> 
		  <SELECT class=J_NiceSelect name=commentStatus> 
		  <OPTION selected value=ALL>全部</OPTION> <OPTION value=I_HAS_NOT_COMMENT>需我评价</OPTION> 
		  <OPTION value=I_HAS_COMMENT>我已评价</OPTION> 
		  <OPTION value=OTHER_HAS_COMMENT>对方已评</OPTION> 
		  <OPTION value=ALL_COMMENT>双方已评</OPTION></SELECT> </LI>
		  <LI class="col1 "><LABEL for=J_TradeStatus>交易状态：</LABEL> 
		  <SELECT class=J_NiceSelect name=auctionStatus> 
		  <OPTION selected value=ALL>全部</OPTION> 
		  <OPTION value=NOT_PAID>等待买家付款</OPTION> 
		  <OPTION value=PAID>买家已付款</OPTION> <OPTION value=SEND>卖家已发货</OPTION> 
		  <OPTION value=SUCCESS>交易成功</OPTION> <OPTION value=DROP>交易关闭</OPTION> 
		  <OPTION value=REFUNDING>退款中的订单</OPTION></SELECT> </LI>
		  <LI class=col2><LABEL for=J_AfterServiceStatus>售后服务：</LABEL> 
		  <SELECT class=J_NiceSelect name=tradeDissension> 
		  <OPTION selected value=ALL>全部</OPTION> 
		  <OPTION value=ACCUSED>已投诉</OPTION> <OPTION value=REFUNDING>退款中</OPTION></SELECT> </LI></UL></FORM> 
		  <div class="widt">
		  <FORM method=post action="">
		<div class="widt">
		<TABLE id=J_BoughtTable class=bought-table data-spm="9">
		  <COLGROUP>
		  <COL class=selector>
		  <COL class=baobei>
		  <COL class=price>
		  <COL class=quantity>
		  <COL class=after-service>
		  <COL class=amount>
		  <COL class=trade-status>
		  <COL class=operate>
		  <COL class=other></COLGROUP>
		  <THEAD>
		  <TR class=col-name>
		    <TH></TH>
		    <TH class=baobei>宝贝</TH>
		    <TH class=price>单价(元)</TH>
		    <TH class=quantity>数量</TH>
		    <TH class=after-service>售后</TH>
		    <TH class=amount>实付款(元)</TH>
		    <TH class=trade-status>交易状态</TH>
		    <TH class=remark>交易操作</TH>
		    </TR>
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  <TR class="toolbar skin-gray">
		    <TD colSpan=7><LABEL>   <INPUT onclick="selectAll();" id="Checkbox4" type="checkbox" name="Checkbox4">
全选</LABEL>  
			  <A class="J_MakePoint toolbtn long-toolbtn" href="#">批量确认</A> 
			  <SPAN style="DISPLAY: none">如想使用信用卡付款，请只选择带有 
			  <IMG src="<%=basePath%>IDCServ/image/xcard.png"> 标识的宝贝</SPAN> </TD>
		    <TD class=last-col>
		      <DIV class=paginator-top>
		      <DIV class="paginator-previous-grey g-u" href="">
			  <SPAN class="paginator-arrow paginator-arrow-left-grey"></SPAN></DIV>
			  <A class="paginator-next g-u J_MakePoint" href="selOrderCustomerServer.do?pageNo=${pageNo-1}">上一页 
			  <A class="paginator-next g-u J_MakePoint" href="selOrderCustomerServer.do?pageNo=${pageNo+1}">下一页 
			  <SPAN class="paginator-arrow paginator-arrow-right-orange"></SPAN></A></DIV></TD></TR></THEAD>
		  <TBODY class=" xcard">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		    
		    <c:forEach items="${orderlist }" var="orderlist">
		  <TR class=order-hd>
		    <TD colSpan=8><SPAN class=no><LABEL>
			<INPUT class=selector value=201007230650516 type=checkbox name=biz_order_id> 
		      订单编号：<SPAN class=order-num></SPAN>${orderlist.saleOrderNo } &nbsp;&nbsp;</LABEL>
			  <INPUT value=201007230650516 type=hidden name=payOrderId_201007230650516> 
			  <INPUT value=WAIT_BUYER_CONFIRM_GOODS type=hidden name=tradeStatus_201007230650516> </SPAN><SPAN 
		      class=deal-time>开始时间：${orderlist.beginTime }</SPAN> 
		      <SPAN 
		      class=deal-time>结束时间：${orderlist.endTime }</SPAN> 
			  <SPAN class=seller><A class="nickname J_MakePoint" href="#">${orderlist.customer.realName }</A> 
			  <SPAN class="J_WangWang J_MakePoint"></SPAN></SPAN>
			  <INPUT value=663305204 type=hidden name=sellerId> 
			  <INPUT value=497491605 type=hidden name=buyerId> 
			  <INPUT value=201007230650516 type=hidden name=payOrderId_201007230650516> 
			  <INPUT value=WAIT_BUYER_CONFIRM_GOODS type=hidden name=tradeStatus_201007230650516> </TD></TR>
		  <TR id=item201007230650516 class="order-bd last">
		    <TD class=baobei colSpan=2><A hideFocus class="pic s50" href="#" target=_blank>
			<IMG src="<%=basePath%>IDCServ/image/T1Dnz9XgXXXXc2MdTa_090557.jpg_sum.jpg"> </A>
			<SPAN class=desc>
			<A class=baobei-name href="#" target=_blank> ${orderlist.property.name}</A>
			<SPAN class=good-icons><A href="#" target=_blank><IMG src="<%=basePath%>IDCServ/image/T1S4ysXh8pXXXXXXXX-52-16.png"></A>      </SPAN>
		      <DIV class=spec><SPAN>ip数量: ${orderlist.ipNum }</SPAN><SPAN>宽带总数: ${orderlist.bw }</SPAN>
		      <br/><SPAN>服务器配置: ${orderlist.serverConfiguration }</SPAN> </DIV></SPAN></TD>
		    <TD class=price title=120.00>${orderlist.price }</TD>
		    <TD class=quantity title=1>${orderlist.productNum} </TD>
		    <TD class=after-service>
			<A class="tousu-weiquan J_MakePoint J_HasBuy J_ApplyRepayTrigger" href="#" >投诉</A> 
			<A class="tousu-weiquan J_MakePoint J_HasBuy J_ApplyRepayTrigger" href="#" >评价</A>    </TD>
		    <TD class=amount rowSpan=1><STRONG>${orderlist.productNum*orderlist.price }</STRONG> 
		    <br/>
		      	付费类型：${orderlist.allTypeByPayStyle.typeName}
		   </TD>
		    <TD class=trade-status rowSpan=1>
	
		    <c:forEach items="${listUP}" var="up">
		    <c:if test="${up.saleOrder.id==orderlist.id}">
		    <c:if test="${up.upFlag==1}">
			 <A >已上架</A><SPAN>
			</c:if>
			 <c:if test="${up.upFlag==2}">
			 <A >已下架</A><SPAN>
			</c:if>
			 <c:if test="${up.upFlag!=2 && up.upFlag!=1}">
			 <A >未上架</A><SPAN>
			</c:if>
			   </c:if>
		       </c:forEach>
			<A class="detail-link J_MakePoint" href="#" >订单详情</A> </SPAN>
			<A class="view-logistics J_MakePoint" href="#" target=_blank>查看物流</A> </TD>
		    <TD class=operate rowSpan=1><SPAN class=skin-blue>
		
			<Br/>
			<c:if test="${orderlist.isgetorder!=1}"><a class="tousu-weiquan J_MakePoint J_HasBuy J_ApplyRepayTrigger" href="javascript:orderFlo('<c:out value="${orderlist.saleOrderNo }"/>');">订单流程</a></c:if>
			<c:forEach items="${listUP}" var="up">
		    <c:if test="${up.saleOrder.id==orderlist.id}">
			   
			  
		    <c:if test="${up.upFlag==1}">  <c:if test="${orderlist.isgetorder!=1}"><A class="tousu-weiquan J_MakePoint J_HasBuy J_ApplyRepayTrigger" href="qrOrderCustomerServer.do?id=${orderlist.id}"   >确认上架</A>
		   </c:if> </c:if>
		 
		       <c:if test="${orderlist.isgetorder==1}"><A class="small-long-btn button J_MakePoint">已确认上架</A>
		       </c:if>
		       </c:if>
		      </c:forEach>
		       	   <!--   <c:if test="${orderlist.auditingState==0}">
			 <A >未审核</A><SPAN>
			 </c:if>
			 <c:if test="${orderlist.auditingState==1}">
			 <A >已审核</A><SPAN>
			 </c:if>
			  <c:if test="${orderlist.auditingState==3}">
			 <A >待用户确认</A><SPAN>
			 </c:if>--> 
		     </SPAN></TD>
		     
		    
		    </TR>
		    
		      
		  
		    </c:forEach>
		    </TBODY>
		  <TBODY class="close-order">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order xcard" data-status="TRADE_FINISHED" 
		  data-orderid="162794786420516" data-isarchive="false">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order xcard" data-status="TRADE_FINISHED" 
		  data-orderid="229660922820516" data-isarchive="false">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order" data-status="TRADE_FINISHED" 
		  data-orderid="225367408480516" data-isarchive="false">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order xcard" data-status="TRADE_FINISHED" 
		  data-orderid="160462019660516" data-isarchive="false">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order xcard" data-status="TRADE_FINISHED" 
		  data-orderid="180262874710516" data-isarchive="false">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" close-order xcard" data-status="CREATE_CLOSED_OF_TAOBAO" 
		  data-orderid="160116972970516" data-isarchive="false">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order xcard" data-status="TRADE_FINISHED" 
		  data-orderid="220302481370516" data-isarchive="false">
		  </TBODY>
		  <TBODY class=" success-order" data-status="TRADE_FINISHED" 
		  data-orderid="151136856960516" data-isarchive="false">
		  </TBODY>
		  <TBODY class=" success-order" data-status="TRADE_FINISHED" 
		  data-orderid="195318563920516" data-isarchive="true">
		  </TBODY>
		  <TBODY class=" success-order" data-status="TRADE_FINISHED" 
		  data-orderid="157895674780516" data-isarchive="true">
		  </TBODY>
		  <TBODY class=" success-order" data-status="TRADE_FINISHED" 
		  data-orderid="188126640920516" data-isarchive="true">
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  </TBODY>
		  <TBODY class=" success-order" data-status="TRADE_FINISHED" 
		  data-orderid="188027528380516" data-isarchive="true"></TBODY>
		  <TBODY class=" success-order xcard" data-status="TRADE_FINISHED" 
		  data-orderid="156056999980516" data-isarchive="true"></TBODY>
		  <TFOOT>
		  <TR class=sep-row>
		    <TD colSpan=8></TD></TR>
		  <TR class="toolbar skin-gray">
		    <TD colSpan=3><LABEL>   <INPUT onclick="selectAll();" id="Checkbox4" type="checkbox" name="Checkbox4">全旋
</LABEL>  <A id=J_BatchReceive2 
		      class="J_MakePoint toolbtn long-toolbtn" href="javascript:void(0)" 
		      data-point-url="listbought.1.11">批量确认</A> </TD>
		    <TD class=page-nav-cell colSpan=5>
		    <p:pages url="listnewProject.do?funid=14" />
		      <UL class=page-nav>
		      <c:set value="1" var="squ"></c:set>
		      <c:forEach items="${pagenum }" var="num1">
		      
		        <LI class="${squ==pageNo?'curr-page':'' }"><A class="selected J_MakePoint" href="selOrderCustomerServer.do?pageNo=${squ }">${squ }</A> </LI>
		        
		        <c:set value="${squ+1 }" var="squ"></c:set>
		        </c:forEach>
		         <LI>...</LI><LI><SPAN>共${request.pagessize }页 &nbsp;</SPAN> </LI>
		        <LI><SPAN>到第 <INPUT id="J_PageNum" size=2 type="text" name="pageNum" onblur="topag(this.value)" value="" maxlengh="4" > <SPAN>页</SPAN> 
		        </SPAN></LI></UL></TD></TR></TFOOT></TABLE>
		</DIV><!--end bought-list-->
		
		  </div>
		
		</div>
	
		<script type="text/javascript">
		function topag(a){
		
			 location.href="selOrderCustomerServer.do?pageNo="+a;
			
			}
		function change1(a){
		
		document.getElementById("htStart").value="";
		document.getElementById("htEnd").value="";
		if(a=="1"){
		document.getElementById("inp").style.display="block";
		document.getElementById("d1").style.display="none";
		
		document.getElementById("inp").value="已收货请填写1，为收获填写0";
		}else if(a=="2"){
		document.getElementById("inp").style.display="none";
		document.getElementById("d1").style.display="block";
		
		}else if(a=="3"){
		document.getElementById("inp").style.display="none";
		document.getElementById("d1").style.display="block";
	
		}else if(a=="4"){
		document.getElementById("inp").style.display="block";
		document.getElementById("d1").style.display="none";
	
		document.getElementById("inp").value="模糊查询:填写订单号的区域数字或全数字";
		}
	    
		}
	 function chang2(a){
	 a.value="";
	 }
		$(document).ready(function(){
  $("#but").click(function(){
  	var selvar=$("#sel").val();
  	var sta=$("#htStart").val();
  	var endvar=$("#htEnd").val();;
  	var inpvar=$("#inp").val();
  
  	$.ajax({
  	  type:'post',
           url:'selOrderCustomerServer.do',
           data:{selvar:selvar,inpvar:inpvar,htStart:sta,htEnd:endvar},
           success:function(res){
              location.reload();
           }
  	});
  });
});


		</script>
		
    <jsp:include page="bottom.jsp"></jsp:include>
	</body>
	</html>
