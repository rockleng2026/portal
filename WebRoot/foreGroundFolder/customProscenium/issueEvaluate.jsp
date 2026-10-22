<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META name=description
content=福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管>
<META name=keywords 
content="福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管-IDC基础业务品牌运营商 自我完善-不断创新-行业领先-专业服务|游戏服务器|福奥科技网站建设|福奥科技网络公司|福奥科技网络公司|福奥科技网站建设|福奥科技域名注册">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>问题评价</title>
<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css"/>
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css"/>
<style type="text/css"> 
<!--
.container {
	WIDTH: 973px;
	HEIGHT: 302px
}
.container A IMG {
	WIDTH: 973px;
	HEIGHT: 302px
}
.container IMG {
	BORDER-BOTTOM-STYLE: none;
	BORDER-RIGHT-STYLE: none;
	BORDER-TOP-STYLE: none;
	BORDER-LEFT-STYLE: none
}
.td_f A IMG {
	PADDING-BOTTOM: 0px;
	MARGIN: 0px;
	PADDING-LEFT: 0px;
	PADDING-RIGHT: 0px;
	PADDING-TOP: 0px
}
.num {
	POSITION: absolute;
	WIDTH: 90px;
	FLOAT: right;
	TOP: 270px;
	LEFT: 850px}
.num LI {
	TEXT-ALIGN: center;
	LINE-HEIGHT: 15px;
	LIST-STYLE-TYPE: none;
	MARGIN: 1px;
	WIDTH: 15px;
	FONT-FAMILY: Arial;
	FLOAT: left;
	HEIGHT: 15px;
	COLOR: #86a2b8;
	FONT-SIZE: 12px;
	CURSOR: pointer;
	background-image: url(http://www.ebadu.com/user/images/flash/flashbutton.gif);
	background-repeat: no-repeat;
	background-position: -15px 0px;
}
.num LI.on {
	LINE-HEIGHT: 15px;
	WIDTH: 15px;
	BACKGROUND: url(http://www.ebadu.com/user/images/flash/flashbutton.gif) no-repeat;
	HEIGHT: 15px;
	COLOR: #ffffff
}
-->
</style>


</head>
<body leftmargin="0" topmargin="0">


<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js" ></script>
<script src="<%=request.getContextPath()%>/jquery.KinSlideshow-1.2.1.min.js" type="text/javascript"></script>
<SCRIPT type=text/javascript src="<%=request.getContextPath()%>/js/global__3132109.js"></SCRIPT>
 
<!--top end-->

<script language="JavaScript" src=include/language.js></script>
<table height=206 cellspacing=1 cellpadding=0 width="973" border=0 align=center style="margin-top:5px;">
<tr>
<td width="973" valign="top" bgcolor="#e4e5e5">
<!--right start-->

 <script type="text/javascript">
 function sub(id){
 var desc = $("#content").val();
 
  var pj = ($("input[name='pj']:checked").val());
  
  var yawp = "";

  if(pj == "3")
  {
  yawp =  $("#texts").val();
   yawp = encodeURI(yawp);
  
  }
 
 var url = "addEvaluationMalfunctionDeclare.do";
          desc = encodeURI(desc);
		 
		 
 $.post(url,{
 desc:desc,
 id:id,
 pj:pj,
 yawp:yawp
 },function(date){
 if(date == "1")
 {
 alert("您需要上次提出的问题处理后在能继续提问。或者提出新的问题");
 return;
 }else if(date == "2")
 {
 alert("一个问题最多只能追加5次问答。您可以去有问必答中心提新问题");
 return;
 }
 if(date != null && date != '')
 {
 alert("您的问题提交成功。我们会尽快给您处理");
 $("#ask").html(date);
 $("#content").val("");
 $("#texts").val("");
 }
 });
 
 }
 function pjj(id)
 {
 var texts = $("#texts").val();

texts = encodeURI(texts);
 var pj = $('input[name=pj][checked]').val();
$.post("estimateMalfunctionDeclare.Action",{
id:id,
pj:pj,
texts:texts
},function(date){
alert("您的评价成功。感谢您对我们工作的支持");
window.location.href="selectComMalfunctionDeclare.Action";

})
 }
 </script>
<table border="0" align=center cellpadding="2" cellspacing="1" width="95%" bgcolor="#CCCCCC">
<tr bgcolor="#F0F0F0">
  <td> &nbsp;当前操作-》<a href=notelist.jsp>帮助留言</a></td>
</tr></table><br>
 
<table border="0" align=center cellpadding="9" cellspacing="1" width="95%" bgcolor="#CCCCCC">
<tr bgcolor="#FFFFFF">
<td height=23 align=left bgcolor=#f0f0f0>&nbsp;产品类型：${conkout.proudcotType.questionName } ┊ 问题类别：${conkout.issueType.questionName }</td>
</tr>
</table>
<div id ="ask">
<table border="0" align=center cellpadding="9" cellspacing="1" width="95%" bgcolor="#CCCCCC">
<tr bgcolor="#FFFFFF">
  <td bgcolor="#f0f0f0">&nbsp;技术信息：
    ┊ 处理状态：
    <c:choose>
   <c:when test="${conkout.state == '-1'}">    
<span style='color:#FF0000'> 处理失败</span>
   </c:when>
      <c:when test="${conkout.state == '0'}">    
<span style='color:#FF0000'> 等待客服处理...</span>
   </c:when>
      <c:when test="${conkout.state == '1'}">    
<span style='color:#FF0000'> 客服已接收</span>
   </c:when>
    <c:when test="${conkout.state == '4' || conkout.state == '5'}">    
<span style='color:#FF0000'> 处理成功</span>
   </c:when>
   <c:otherwise>  
<span style='color:#FF0000'> 处理中.....</span>
   </c:otherwise> 
</c:choose> ┊ 当前评价：<c:if test="${conkout.appraise == null }"><span style='color:#009F00'>未评价</span></c:if>
    <c:if test="${conkout.appraise == 1 }"><span style='color:#009F00'>满意</span></c:if>
    <c:if test="${conkout.appraise == 2 }"><span style='color:#009F00'>一般</span></c:if>
    <c:if test="${conkout.appraise == 3 }"><span style='color:#009F00'>不满意</span></c:if>
    </td>
</tr>
</table>
<br>

<table border="0" align=center cellpadding="9" cellspacing="1" width="95%" bgcolor="#CCCCCC">
<c:forEach items="${conkout.conkoutAsks}" var ="coa">
 <c:if test="${coa.descs != null && coa.descs != ''}">
<tr bgcolor="#ffffff">
<td colspan="2" bgcolor="#f0f0f0">&nbsp;问：${coa.descs }</td>
</tr>
</c:if>

 <c:if test="${coa.solveDepict != '' && coa.solveDepict != null && (coa.isMain == '2' || coa.isMain == '3' )}">
<tr bgcolor="#ffffff">
  <td colspan="2" bgcolor="#f0f0f0">&nbsp;答： ${coa.solveDepict }</td>
</tr>
 </c:if>
  </c:forEach>
</table>
<br />

 </div>
<br/><br/>
 <c:if test="${pj != 'no'}">
<form action="?id=53548&action=action" method="post" name="form1" onsubmit="return check()">
<c:if test="${pj !='pj' }">
<c:if test="${conkout.state == '-1'}">
<table width="95%" border="0" align="center" cellpadding="9" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="20" bgcolor="#FFFFFF">&nbsp;<strong style="color:#666666"><img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/tips.png" width="17" height="20" hspace="0" align="absmiddle" />&nbsp;问题内容</strong></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><textarea id="content"  name="content" style="font-size: 9pt ;border: 1px Solid #c0c0c0 ; Height:100px ;width:570px;"></textarea></td>
  </tr>
 
</table>
<br />
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><input type="button" name="but" value=" 提交提问 " onclick = "sub(${conkout.id});" class="bt" />
        <input type="reset" name="Reset2" value=" 重新填写 " class="bt" /></td>
    </tr>
  </table>
  </c:if>
</c:if>
 <c:if test="${pj == 'pj'}">
 <table width="95%" border="0" align="center" cellpadding="9" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="20" bgcolor=""> </td>
  </tr>

 
</table>
  <table border="0" align=center cellpadding="9" cellspacing="1" width="95%" bgcolor="#CCCCCC">
 
<tr bgcolor="#ffffff">
<td colspan="2">&nbsp;<strong style="color:red"><img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/tips.png" width="17" height="20" hspace="0" align="absmiddle" />尊敬的客户您好。您的问题我们已经为您解决。为了能给您提供更好的服务。请对我们的工作做出评价</strong></td>
</tr>
<tr bgcolor="#ffffff">
<td colspan="2"><input name="pj" type="radio" checked="checked" value="1" />
  满意　
  <input name="pj" type="radio" value="2"/>
  一般　
  <input name="pj"  type="radio" value="3" />
  不满意 <a href="#" onclick="pjok()" id="jy"></a><a name="khpj" id="khpj"></a></td>
</tr>
<tr bgcolor="#ffffff" >
<td width="6%" align="right" valign="top"><label>原因：</label></td>
<td width="94%"><textarea name="texts" cols="40" rows="5" id="texts"></textarea>
  <span class="STYLE1">  *请留下您的意见或者是建议</span></td>
</tr>
</table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><input type="button" name="but" value=" 评价 " onclick = "pjj(${conkout.id});" class="bt" />
        </td>
    </tr>
  </table>
</c:if>
</form></c:if>
  
 
<TR bgColor=#ffffff>
  <TD bgcolor="#FFFFFF">&nbsp;</TD>
</TR>
<TR bgColor=#ffffff>
  <TD colSpan=2>&nbsp;</TD>
</TR>

<!--mid end-->
</table></body>
</html>