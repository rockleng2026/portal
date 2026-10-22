<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<base href="<%=basePath%>">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
		<title>My JSP 'MyOrder.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=basePath%>/js/jquery-1.7.2.min.js"></script>
	<style>
	.d1{
	
	  position: absolute;
	  z-index: 500;
	  width:100%;
	  top:0;
	  left:0;
	  background-color: black;
	 height: 100%;
	 filter:alpha(opacity=50);  -moz-opacity:0.5;  -khtml-opacity: 0.5;  opacity: 0.5; 
	}
	.d3{
	  z-index: 1000;
	  position: absolute;
	  width:700;
	  border: 6px;
	  left:25%;
	  top:20%;
	  border-color: #7BACCD;
	  border-style:solid;
	  background-color: white;
	}
	.odd{
	background-color:#DCF1FF;
	}
	.even{
	background-color: #cef;
	
	}
	.d2{
	font-size:small;
	font-style: italic;
	}
	img {border-width: 0px 0px 0px 0px} 
	a{
	outline-color: white;
	outline: 0px;
	text-decoration:none;
	border: 0px;
}
	</style>
	<script type="text/javascript">
	$(document).ready(function(){
	  $('table#t1 tr').mouseover(function(){
	  $(this).addClass("odd");
	  })
	    $('tr').mouseout(function(){
	     $(this).removeClass("odd");
	  })
	});
	function showdiv(a,p){
	   var tt = (new Date()).getTime();
	  		 var url = "pdm/showorderproductManager.do?orderid="+a+"&soNums="+p+"&tt="+tt;
			$("#d3").load(url);
            document.getElementById("d1").style.display="block";
            document.getElementById("d3").style.display="block";
          
	
	}
	function nextpage(a,p){
	     if(p>a){
           
            alert("已经是最后一页！");
            }else{
             $("#pageNo").val(p);
          
            $("#f1").submit();
            }
	
	}
	
	function closeWindow(){ 
	document.getElementById("d1").style.display="none"; 
	document.getElementById("d3").style.display="none"; 
	
	} 
	function onchange1(){
	
	var v1=$("#soStat1").val();
	$("#soStat").val(v1);
	
	
	}
	
	
	</script>

	</head>

	<body>
		<div>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>

<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
			<form name="f1" id="f1"  action="pdm/getsaleproductManager.do?" >
				<table align="center" border="1" style="" width="90%" cellpadding="0" cellspacing="0"
					bordercolor="#DBECF3">
					<tr>
						<td colspan="3" bgcolor="#8DC7E9">
							<B>订单列表</B>
						</td>

					</tr>
				
					<tr bordercolor="#FFFFFF" height="35">
						
						<td bordercolor="#FFFFFF" width="33%" align="center">
							订单编号：<input type="hidden" id="pageNo" name="pageNo" value="${pageNo }"/>
							<input type="text" name="sonums" value="${soNums }"/>
						</td>
						<td bordercolor="#FFFFFF" width="33%" align="center">
							商品名称：
							<input type="text" name="sgname"  value="${sgnames}"/>
						</td>
						
						<td bordercolor="#FFFFFF" align="center">
						订单状态：<input type="hidden"  id="soStat" name="soStat" value="${soStat}"/>
							<select style="width: 150" id="soStat1" name="soStat1" onchange="onchange1()">
								<option value="-1">
									---
								</option>
								<option value="0"> 
							                   待审核
								</option>
									<option value="1">
								已审核待付款
								</option>
									<option value="2">
								待付款审核
								</option>
									<option value="3">
								待生成上架单
								</option>
									<option value="4">
								待调拨往客服
								</option>
									<option value="5">
								待客服接收
								</option>
									<option value="6">
									待客服转运维
								</option>
									<option value="7">
									待运维接收
								</option>
									<option value="8">
									待运维上架
								</option>
									<option value="9">
								待客服确认
								</option>
									<option value="10" >
								上架单待审核
								</option>
								
							</select>
							<script type="text/javascript">
							
							$(document).ready(function(){
	var v1=$("#soStat").val();
	
 	$("#soStat1 [value='"+v1+"']").attr("selected","selected");
 

  });

	//window.attachEvent("onload",init);
//function init(){
//var v1=$("#soStat").val();
 //	$("#soStat1 [value='"+v1+"']").attr("selected","selected");

//} 
							
							
							</script>
						</td>
					</tr>
					<Tr bordercolor="#FFFFFF" height="35">
						<td bordercolor="#FFFFFF" width="33%" align="center">
							商品编号：
							<input type="text" name="Sgcode" value="${sgcode }"/>
						</td>
						<td bordercolor="#FFFFFF" width="33%" align="center">
							录入时间：
							 <input  value="${stime }" class="Wdate" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" mindate="#F{$('htStart').value}"  name="sgtime" id="htEnd"  />
						</td>
						<td bordercolor="#FFFFFF" align="left">
							&nbsp;
						</td>
					</Tr>
					<tr bordercolor="#FFFFFF" height="35">
						<td colspan="3" align="center">
							<input type="button" onclick="tj()" value="查询" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
						</td>

					</tr>
				</table>
			</form>
 <script type="text/javascript">
 
  function tj(){
  $("#pageNo").val(1);
  
  $("#f1").submit();
  }
 </script>
		</div>
		<div class="d2">
			<table border="1" id="t1" align="center" width="90%" cellpadding="0" cellspacing="0" bordercolor="#818181">
				<tr  height="25">
				<Th>订单信息</Th>
				<Th>商品信息</Th>
				<Th>审核状态</Th>
				<Th>订单操作</Th>
				</tr>
				
				<c:forEach items="${solist1}" var="solist">
				
				<TR >
					<td colspan="2">
						<SPAN class=no><LABEL>
								订单编号：${solist.soNums }
								<SPAN class=order-num><SPAN class=deal-time>录入时间：${solist.soOrderTime }</SPAN>
					</TD>
				
					
					<TD align="center">
					审核状态：<c:if test="${solist.soStat==0 }">待审核</c:if>
					<c:if test="${solist.soStat==null || solist.soStat=='' }">待接收</c:if>
					<c:if test="${solist.soStat==1 }">已审核待付款</c:if>
					<c:if test="${solist.soStat==2 }">待付款审核</c:if>
					<c:if test="${solist.soStat==3 }">待生成上架单</c:if>
					<c:if test="${solist.soStat==4 }">待调拨往客服</c:if>
					<c:if test="${solist.soStat==5 }">待客服接收</c:if>
					<c:if test="${solist.soStat==6 }">待客服转运维</c:if>
					<c:if test="${solist.soStat==7 }">待运维接收</c:if>
					<c:if test="${solist.soStat==8 }">待运维上架</c:if>
						<c:if test="${solist.soStat==9 }">待客服确认</c:if>
						<c:if test="${solist.soStat==10 }">上架单待审核</c:if>
					</TD>
					<TD align="center">
					
							 <A href="javascript:showdiv('${solist.soId}','${solist.soNums}')">订单详情</A> </SPAN>
					</TD>


				</TR>
				
					<c:forEach items="${list1}" var="list1">
					<c:if test="${list1.sale_orders.soId eq solist.soId}">
					<TR id=item201007230650516 class="order-bd last" c>
					<TD bordercolor="#FFFFFF" width="8%">
						<IMG src="<%=basePath%>IDCServ/image/T1Dnz9XgXXXXc2MdTa_090557.jpg_sum.jpg" width="100px" height="50px">

						
					</TD>
					<TD align="left" bordercolor="#FFFFFF" colspan="4">
					<SPAN class=desc> 商品名称:${list1.sale_goods.sgname}</SPAN>
					<br/><br/>
							<span>商品编号:${list1.sale_goods.sgcode}</SPAN>
					</TD>
						</tr>
					</c:if>
				
					</c:forEach>
				
				</c:forEach>
				<set value="${pageNo }" var="pageNo"></set>
				<set value="${gageNoall }" var="gageNoall"></set>
				<tr  height="25"><td colspan="5" align="center"><font size="-1"><a  href="pdm/getsaleproductManager.do?pageNo=1">首页</a>&nbsp;&nbsp;<a href="pdm/getsaleproductManager.do?pageNo=${pageNo-1}">上一页</a>&nbsp;&nbsp;<a href="javascript:nextpage(${gageNoall },${pageNo+1})">下一页</a>&nbsp;&nbsp;<a href="pdm/getsaleproductManager.do?pageNo=${gageNoall}">尾页</a>&nbsp;&nbsp;<a>总${gageNoall}页</a>&nbsp;&nbsp;<a>第${pageNo}页</a></font></td></tr>
			</table>
			
		
				<div class="d1" style="display: none;z-index: 500;" id="d1"></div>
				<div style="display: none;z-index: 1000; width: 700px;" class="d3" id="d3">
			
				
				</div>
				
		</div>
		
	</body>
	
</html>
