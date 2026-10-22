<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>添加客户跟进记录</title>
    <link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/customer.css" />
</head>
<body>
<div >
<div >
<br/><span><img src="<%=basePath%>potal/images/customer/xx.png" onClick="removeDiv0()" /></span>新增客户跟进记录</div>
<div >
<table width="400" height="264" border="0" cellpadding="0" cellspacing="0">
<form id="form1" name="form1" method="post" action="customerrecordNewportalCustomer1.do?userid=${emp.id }&custid=<%=request.getParameter("custid") %>">
  <tr>
    <td width="100" align="center" valign="middle">跟进日期：</td>
    <%
    
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 

java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

String str_date1 = formatter.format(currentTime); //将日期时间格式化 

    
     %>
    <td valign="middle"><input type="text"  class="text1" value="<%=str_date1 %>"/>&nbsp;</td>
  </tr>
  <tr>
    <td width="100" align="center">跟进方式：</td>
    <td><input id="c1" name="c1" type="checkbox" value="1" />面谈<input name="c1" id="c3" type="checkbox" value="2"  />
    电话<input id="c2" name="c1" type="checkbox" value="3" />短信<input name="c1"  id="c4" name="" type="checkbox" value="4" />其他</td>
  </tr>
  <tr>
    <td width="100" align="center" valign="top">跟进内容：</td>
    <td><textarea name="gznr" id="te1" cols="" rows="" class="rea1" ></textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <label>
        <input type="button" onclick="sub()" id="s1"  value="提交" class="an1" />
        </label>
      <label>
      <input type="reset" name="Submit2" value="重置"  class="an1 "/>
      </label>
   
    </td>
  </tr>
   </form>
</table>
<SCRIPT type="text/javascript">

function sub(){
var chbSize=0;
$("input[type='checkbox'][name='c1']").each(function () {                
    if ($(this).attr("checked") == true) {    
                   chbSize++;              
                         }           
                        });
                        
             if(document.getElementById('te1').value==""){
                        
                      alert("跟进内容不能为空");
                        }else if(chbSize==0){
 
  alert("跟进方式不能为空！谢谢。");
  
  
 }else{
  $("#form1").submit();
   
 }

}


</SCRIPT>

</div>

</div>
</body>
</html>
