<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>新添单据</title>
<script type="text/javascript">
function addOrdertype()
{
  var orderTypeName=document.getElementById("orderTypeName").value;
  if(orderTypeName==null || orderTypeName=="")
  {
    alert("请输入单据类型名称");
    return false;
  }
  var orderTypeName1=encodeURI(orderTypeName);
  var beizhu=document.getElementById("beizhu").value;
  var beizhu1=encodeURI(beizhu);
  var url="addOrderTypeorderAction.do";
  $.post(url,{orderTypeName:orderTypeName1,beizhu:beizhu1},function (data){
  	if(data=="0")
  	{
  		alert("增加订单类型成功！！！");
  		window.location.href='<%=request.getContextPath() %>/orderTypeListorderAction.do';
  	}
  	else{
  		alert("添加失败！！！！！");
  	}
  
  });
}
</script>

</head>
<body>
<table width="1000" border="0" cellpadding="0" cellspacing="0" align="center" >
  <tr>
    <td align="center" colspan="2"><div class="dt01" style="background:url(<%=request.getContextPath() %>/images/setMeal/hdr.gif) repeat-x left center; ">
        <div class="left"><img src="<%=request.getContextPath() %>/images/setMeal/hdrl.gif" /></div>
        <div class="left" style="width:988px;">
          <h3>增加单据类型</h3>
        </div>
        <div class="right"><img src="<%=request.getContextPath() %>/images/setMeal/hdrr.gif" /></div>
      </div></td>
  </tr>
  <tr>
    <td width="400" align="right" height="30"> 单据类型名称： </td>
    <td width="600" align="left"><input id="orderTypeName" name="" type="text"/></td>
  </tr>
  <tr  style="background:#fff;" >
    <td width="400" align="right"> 备注： </td>
    <td width="600" align="left"><textarea id="beizhu" style="width:370px; height:70px;" ></textarea></td>
  </tr>
  <tr>
    <td align="center" colspan="2" height="50"><input id="" name="" type="button" value="提交"  onclick="addOrdertype()"/>&nbsp;&nbsp;
    <input id="input" name="input" type="button" value="重置"/></td>
  </tr>
</table>
</body>
</html>