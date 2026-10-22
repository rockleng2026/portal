<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>  
	<head>
    <base href="<%=basePath%>">
    <title>出售中的商品</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	
	<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/index2.css" />
	<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/goods.css" />
	
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>potal/js/new.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/data.js"></script>
	<script type="text/javascript">
		function onsubmitsg()
		{
			form2.action = "<%=request.getContextPath()%>/selectsalegoods.do";
			form2.submit();
		}
		
	function delsg(){
	var urls = "delSgsalegoods.do";
	var all=document.getElementsByName('ids');
	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++){
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length >=2)
	{
		alert("只能勾选一个");
		return ;
	}
	var id = allId[0];
	if(allId.length>0){
		delflag=true;
	}
	if(allId.length <=0){
		alert("请选择要操作的记录！");
		return false;
	}
	if(window.confirm("是否确认删除!"))
	{
	$.post(urls,{ids:allId,id:id},
	function (data)
	{
		if(data =="1")
		{
			alert("删除商品成功!");
			window.location.href="<%=request.getContextPath()%>/selectsalegoods.do";
		}
		if(data ==0)
		{
			alert("删除商品失败!");
		}
	});
	}
}
	</script>
  </head>
  
  <body style="background-color: #ffffff;">
<div class="middlebox">
<div class="middtop">
<span>您的位置<a class="gray" href="<%=basePath %>potal/page/desk.jsp">：首页></a><a href="javascript:void(0);" class="orange">出售中的商品</a></span>
</div>
<form name="form2"  action="" method="post" id="form2">
<div class="cs_box">
<div class="cs_top">出售中的商品</div>
<div class="cs_sp">
<div class="cs_ss">
<dl class="cs_ss_nc">
<dd>商品名称：</dd>
<dt><input name="saleName" id="saleName" type="text" value="${sgname}" class="Product" /></dt>
</dl>
<dl class="cs_ss_nc">
<dd>商家编码：</dd>
<dt><input name="sgcode" id="sgcode" type="text" value="${sgcode}" class="Product" /></dt>
</dl>
<dl class="cs_ss_jw">
<dd>价格：</dd>
<dt><input name="startMoney" id="startMoney" type="text" value="${startMoney}" class="Price" />到<input name="endMoney" id="endMoney" type="text" value="${endMoney}" class="Price"/></dt>
</dl>
<dl class="cs_ss_jw">
<span><a onclick="javascript:onsubmitsg();" href="javascript:void(0);" style="CURSOR:pointer">搜索</a></span>
<dd>总销量：</dd>
<dt><input name="startVolume" id="startVolume" type="text" value="${startVolume}" class="Price" />到<input name="endVolume" id="endVolume" type="text" value="${endVolume}" class="Price" /></dt>

</dl>
</div>
<div class="cs_sp_box" style="font-size: 12px;">
<div class="cs_sp_top">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="font-size: 12px;">
  <tr>
    <td width="234" height="26" align="center" bgcolor="#626262" class="bsbk">商品名称</td>
    <td width="104" height="26" align="center" bgcolor="#626262" class="bsbk">价格</td>
    <td width="79" height="26" align="center" bgcolor="#626262" class="bsbk">库存</td>
    <td width="67" height="26" align="center" bgcolor="#626262" class="bsbk">总销量</td>
    <td width="85" height="26" align="center" bgcolor="#626262" class="bsbk">创建时间</td>
    <td width="93" height="26" align="center" bgcolor="#626262" class="bssbk" style="color: #ffffff;">结束时间</td>
    <td width="87" height="26" align="center" bgcolor="#626262" class="bsz">操作</td>
  </tr>
</table>
</div>
<div class="cs_sp_gl">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size: 12px;">
<c:if test="${salegoods != null}">
	<c:forEach items="${pages.pageList}" var="sg">
  <tr>
    <td width="30" align="center" class="qls"><INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" type="checkbox" value="${sg.sgId}" name="ids"></td>
    <td colspan="9" valign="middle" class="qls">商家编码：${sg.sgcode}</td>
    </tr>
  <tr>
    <td width="30" height="75" align="center" class="cszt">已<br />
      推<br />荐</td>
    <td width="60" height="75" align="center" class="sptu"><img src="<%=basePath%>potal/images/sp_1.jpg" /></td>
    <td height="75" class="spmc" valign="top" width="134"><span><a href="detailSgsalegoods.do?sgid=${sg.sgId}">${sg.sgname}</a><a href="javascript:void(0);"><img src="<%=basePath%>potal/images/bi.jpg" /></a></span><p></p></td>
    <td width="104" height="75" align="center"><span class="hsz">￥</span><span class="cszt_2">${sg.sgPrice}</span><a href="javascript:void(0);"><img src="<%=basePath%>potal/images/bi.jpg" /></a></td>
    <td width="79" height="75" align="center"><span class="you10 shz">${sg.sgInventory}</span><img src="<%=basePath%>potal/images/bi.jpg" /></td>
    <td width="67" height="75" align="center">${sg.sgSalesVolume}</td>
    <td width="85" height="75" align="center" class="shz">${sg.sgtime}
      <p>09:56</p></td>
    <td width="93" height="75" align="center" class="shz">${sg.sgPuttime}
      <p>10:30</p></td>
    <td width="87" height="75" align="center" class="cs_cz"><a href="javascript:void(0);">编辑商品</a>
      <p><a href="<%=basePath%>sgOrdersalegoods.do?sgid=${sg.sgId}">代客购买</a></p></td>
  </tr>
  </c:forEach>
  
  </c:if>
  <c:if test="${salegoods == null}"><tr><td colspan="7">查无数据</td></tr></c:if>
</table>

</div>
	<div class="cs_sp_gl topbk">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size: 12px;">
	  <tr> 
	    <td width="30"><INPUT id="chkall" style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" onclick=CheckAll(this.form) type="checkbox" value="select" name="chkall"></td>
	    <td width="300" class="cs_qx"><a href="javascript:void(0);">全选</a><a onclick="javascript:delsg();" style="CURSOR:pointer;">删除</a><a href="#">设置促销</a><a href="#">放入库存</a><a href="#">设置运费</a></td>
	    <td width="420" class="cs_qx"><p:pages url="selectsalegoods.do"/></td>
	  </tr>
	</table>
	
	</div>
</div>
</div>
</div>
</form>
</div>
</body>
</html>