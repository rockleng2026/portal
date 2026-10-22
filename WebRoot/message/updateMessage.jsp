<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
        <title>更新消息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/showDialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>

		<LINK href="<%=request.getContextPath()%>/Css/setMeal/css.css"
			type="text/css" rel="stylesheet">
			
			<script type="text/javascript"
		src="<%=request.getContextPath()%>/cdn/js/jquery-1.3.2.min.js"></script>			
<script type="text/javascript">
  	function selbysuperid(){
 		var surperid=$("#allType").val();
 		
 		var mes=$("#mesty");
 		mes.empty();
 		var messageid = $("#messageid").val();
 		
 		$.post('selbysuperid1message.do',{surperid:surperid,messageid:messageid},
 		function (data){
 			if(data!=1)
 				mes.append(data);
 		});
 	}
 	window.onload = selbysuperid;
 	
 	function sbt()
 	{
 	
 	 var messageid=$("#messageid").val();
 	 var allType= $("#allType").val();
 	 var mesty=   $("#mesty").val();
 	// alert("mesty"+mesty);
 	 if(allType==null || allType=="")
	{
		alert("请输入类型名称 ！！！！");
		return false;
	}
	if(mesty==null || mesty=="")
	{
		alert("请输入类型对象实体类名称 ！！！！");
		return false;
	}
 	
 	  var messageTitle = $("#messageTitle").val(); 
 	  if(messageTitle==null || messageTitle=="" )
 	  {
 	    alert("请输入消息标题！！");
 	    return false;
 	  }
 	   
 	    var messageContent = $("#messageContent").val(); 
 	  if(messageContent==null || messageContent=="" )
 	  {
 	    alert("请输入消息内容！！");
 	    return false;
 	  }
 	  
 	  var messageTitle1=encodeURI(messageTitle);
 	   var messageContent1=encodeURI(messageContent);
 	  var url="updateMessagemessage.do";
 	  $.post(url,{messageid:messageid, //消息id
 	              allType:allType, //类型名称
 	              mesty:mesty,     //类型对象实体类名称
 	              messageTitle:messageTitle1,//消息标题
 	              messageContent:messageContent1 //消息内容
 	              },function (data){
 	                  if(data==0)
 	                  {
 	                   alert("修改成功");
 	                   window.location.href='<%=request.getContextPath()%>/messendmessage.do';
 	                 }
 	                  else
 	                  {
 	                    alert("修改失败");
 	                  }
 	              
 	              
 	              });
 	  
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
	<form id="typefrom" name="typefrom"  method="post" action="addmessage.do" >
	<input type="hidden" name="delflag" value="0" />
	<input type="hidden" name="messagetypeid" value=""/>
   	<table id="search_table" width="100%"  border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC" >
	 <tr  height="20" bgcolor="#FFFFFF">
		<td align="right">消息类型:</td>
		<td id="tdtd">
		 <input type="hidden" name="typeid" id="typeid">
          		<input type="hidden" id="allType" value="${messagetypes.superid}"/>
            	<input type="text" disabled="disabled" id="" value="${messagetypes.type}">
				<select style="width:100px;height:22px;" name="messagetypeByMessagetype.messagetypeid" id="mesty">
						<option value="-1">请选择</option>	
				</select>
		</td>
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right">消息标题:</td>
		<td>
			<input type="text"  name="messageTitle" id="messageTitle" value="${data.titleweb }"/>
			<input type="hidden" id="messageid" name="messageid" value="${data.messageid }"/>
		</td>
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right">消息内容:</td>
		<td><textarea name="messageContent" id="messageContent" rows="10" cols="50">${ data.messagecontent}</textarea></td>
  	</tr>
  	
	  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"><input type="button" name="update"  value="修改" onclick="sbt()"/></td>
		<td align="left"><input type="button" name="exit" value="取消"/></td>
  	</tr>
</table> 
</form> 
  </div>
</div>
</body>
</html>

     
  </body>
</html>
