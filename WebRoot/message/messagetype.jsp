<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%@ taglib uri="/struts-tags" prefix="s" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>消息类型管理</title>    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>				
<style type="text/css">

</style>  
<script type="text/javascript">
	function deltype(id)
		{
		var t=new Date();
		var url="delmessagetype.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="getmessagetype.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}



function addtype(typeid,typename){
	//设置所属父类型id
	$("#superid").attr("value",typeid);
	$("#typefrom").attr("action","addmessagetype.do");
}

function updatetype(typeid,superid,type,voname,tablename,describetype){
    alert("updatetype");
	//设置所属父类型id
	$("#typeid").attr("value",typeid);
	$("#type").attr("value",type);
	$("#superid").attr("value",superid);
	$("#voname").attr("value",voname);
	$("#tablename").attr("value",tablename);
	$("#describetype").attr("value",describetype);
	$("#typefrom").attr("action","updatemessagetype.do");
}
function tijiao(){
	if($("#type").val()==null || $("#type").val()=="")
	{
		alert("请输入类型名称 ！！！！");
		return false;
	}
	if($("#voname").val()==null || $("#voname").val()=="")
	{
		alert("请输入类型对象实体类名称 ！！！！");
		return false;
	}
	if($("#describetype").val()==null || $("#describetype").val()=="")
	{
		alert("请输入类型的备注 ！！！！");
		return false;
	}
}
</script>
</head>  
<body>
   <div class="conSet" id="showmsg">
  <table width="52%" border="0" align="center" cellpadding="3" cellspacing="1"  class="space tableBg">
	<tr>
		<td>
  <script type="text/javascript" src="js/dtree.js"></script>
	<div class="dtree" bgcolor="#cccccc">
	
	</div>
	</td>
	</tr>
</table>
  <div id="apDiv1">
	<form id="typefrom" name="typefrom"  method="post" action="addmessagetype.do" onsubmit="return tijiao()" >
	<input type="hidden" name="delflag" value="0" />
	<input type="hidden" name="messagetypeid" value="${data.messagetypeid }"/>
   	<table id="search_table" width="100%"  border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC" >
	 <tr  height="20" bgcolor="#FFFFFF">
		<td align="right">所属类型名称:</td>
		<td>
		 <input type="hidden" name="typeid" id="typeid" >
	<select name="superid" id="superid">
         <c:forEach items="${messagetypes}" var="data1">
	    <option  value='${data1.messagetypeid}' name="superid"  <c:if test="${data.superid==data1.messagetypeid }">selected='selected'</c:if>>${data1.type}</option>
	    </c:forEach>
     </select>
		</td>
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right">类型名称:</td>
		<td><input type="text"  name="type" id="type" value="${data.type }"/></td>
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right">类型对象实体类名称:</td>
		<td><input type="text"  name="voname" id="voname" value="${data.voname }"/></td>
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right"> 类型备注:</td>
		<td>
		<textarea name="describetype" id="describetype" rows="10" cols="50">${data.describetype }</textarea>
		</td>
  	</tr>
	  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"><input type="submit" name="add"  value="提交"/></td>
		<td align="left"><input type="button" name="exit" value="取消"/></td>
  	</tr>
</table> 
</form> 
  </div>
</div>
</body>
</html>
