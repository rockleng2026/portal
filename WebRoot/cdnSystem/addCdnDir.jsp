<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addCdnUrl.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
  </head>
  
  <script type="text/javascript">
  	function addTr()
  	{
  		var count=document.getElementById("count").value;
  		count++;
  		var aa="<tr id='tr"+count+"'><td width='60%' align='center'><input type='text' id='url"+count+"' name='url"+count+"'></td>";
    		aa+="<td width='40%' align='center'><select id='dateTime"+count+"' name='dateTime"+count+"' value='this.value'>";
			aa+="<option value='1000毫秒' >1000毫秒</option><option value='5000毫秒' >5000毫秒</option><option value='12小时' >12小时</option>";
			aa+="<option value='24小时' >24小时</option><option value='7天' >7天</option></select></td></tr>";
		$("#addUrlTr").append(aa);
		document.getElementById("count").value=count;
		
  	
  	}
  	function delTr()
  	{
  		var count=document.getElementById("count").value;
  		if(count==1)
  		{
  			alert("没有可减少的行数了！！！ ");
  			return false;
  		}
  		$("#tr"+count+"").remove();
  		$("#count").val(count-1);
  	}
  
  </script>
  <body>
  <form id="form1" name="form1" action="cdnSystem/addCdnDirCdnSystemAction.Action" method="post">
    <table width="500px" align="center"  id="addUrlTr">
    	<tr>
    		<td align="center" colspan="2"><h1>增加url目录</h1></td>
    	</tr>
    	<tr>
    		<td align="right" colspan="2">
    		<input type="button" id="" name="" onclick="addTr()" value="增加一行"/>
    		<input type="button" id="" name="" onclick="delTr()" value="减少一行"/>
    		<input type="hidden" id="count"  name="count" value="1"/>
    		</td>
    	</tr>
    	<tr>
    		<td width="60%" align="center">rul目录</td>
    		<td width="40%" align="center">刷新时间</td>
    	</tr>
    	<tr>
    		<td width="60%" align="center"><input type="text" id="url1" name="url1"/></td>
    		<td width="40%" align="center">
				<select id="dateTime1" name="dateTime1" >
					<option value="1000毫秒" >1000毫秒</option>
					<option value="5000毫秒" >5000毫秒</option>
					<option value="12小时" >12小时</option>
					<option value="24小时" >24小时</option>
					<option value="7天" >7天</option>
				</select>
			</td>
    	</tr>
    	
    </table>
	<table width="500px" align="center">
		<tr>
    		<td align="center" colspan="2"><input type="submit" value="提交"/></td>
    	</tr>
	</table>
    </form>
    
  </body>
</html>
