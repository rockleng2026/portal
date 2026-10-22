<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>撤销</title>
<style>
.aa{ width:450px; font-size:14px; background-color:#3d3d3d; margin:150px auto auto 160px;}
.dows{width:450px; height:230px; float:left}
.dows_top{width:440px; height:26px; background:#ff6600; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dows_top span{float:right; padding-right:10px; padding-top:1px;}
.dows_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.gb_btrs{ background-color:#ff6600; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:180px;  float:left; border:0}
.gb_btls{ background-color:#ff6600; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-right:100px; float:right; border:0}
.tabs_b{ margin:25px 0 25px 0}
.table_bors{ border: 1px solid #ff6600; width:450px; background-color:#fff;}
</style>
<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
<script type="text/javascript">
function onchexiao(obj)
{	
			
			var rcid = obj;
			$.ajax({
				type:"POST",
				url:"<%=request.getContextPath()%>/updateRCsalegoods.do",
				data:{"rcid":rcid},
				success:function(data)
				{
					if(data =="1")
					{
						alert("撤销成功!");
						window.location.href="selectReourcesalegoods.do";
					}
					if(data == "2")
					{
						alert("撤销失败!");
						return false;
					}
				}
				});
}
</script>

<%
	String rcids = request.getParameter("obj");
	System.out.print(rcids);
%>
</head>

<body class="aa">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_bors">
  <tr>
    <td colspan="3">
    <div class="dows_top">
<span><a href="javascript:yingcangall();">×</a></span>
温馨提示
</div></td>
  </tr>
  <tr class="tabs_b">
    <td width="95" height="90" align="center" valign="middle"><img src="<%=basePath%>potal/images/zyhc_wh.png" width="73" height="72" /></td>
    <td width="355" colspan="2" valign="middle"><strong>确定要撤销资源核查单吗？撤销后不可恢复哦！</strong></td>
  </tr>
  <tr>
    <td colspan="3" height="45"><input type="button" style="CURSOR:pointer;" name="button" onclick="onchexiao('<%=rcids%>');" id="queDing" value="确定"  class="gb_btrs"  />      <input type="button" name="button" id="quXiao" onclick="javascript:yingcang1();" style="CURSOR:pointer;" value="取消" class="gb_btls"/></td>
  </tr>
</table>
</body>