<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>账户管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	
	<style>
	body{ width:760px; font-size:14px;}
	.main { width:760px; margin:0 auto;}
	.wzdh { line-height:25px;}
	.wzls { color:#3b8801;}
	.wzcs { color:#ff6600;}
	 ul ,ul li{ margin:0px; padding:0px; list-style:none;}
	.sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; }
	.sp_nav_tab .nomarl{ width:105px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; background-color:#EAFED9;}
	.sp_nav_tab  li { float:left; text-align:center; margin-left:20px;}
	.sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
	.sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
	.font_color_hui{ color:#8c8c8c;}
	.font_color_lv{ color:#295a01;}
	.d2{z-index: 100004;position:absolute;left:22%;top:22%;}
	a{text-decoration: none; color: #4FA805;}
	</style>
	<script type="text/javascript" src="<%=request.getContextPath()%>/potal/js/someJs.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/potal/js/someJs.js"></script>
	<script type="text/javascript">
	
	
	//弹出添加一行。
	function addrow()
	{
		 $("#addrow").load("<%=path%>/potal/page/accountManager/updatePwd.jsp");
		 $("#addrow").css("display","block");
	}
	
	function yingcang()
	{
		 $("#addrow").css("display","none");
	}
	// 选择分岗
	function fgwop(){
		var fgwopid=$("#fgwop").val();
		if(confirm("确定切换岗位？")){
			parent.location.href="<%=request.getContextPath()%>/potalsLogin.do?fgwopid="+fgwopid;
		}
	}
	</script>
 </head>
  
<body>
  <div class="main">
<div class="wzdh">
<span class="wzls">&nbsp;&nbsp;您的位置</span><span class="font_color_hui">：首页&gt;办公桌面&gt;</span><span class="wzcs">账户管理</span>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right"><span class="font_color_lv"><a href="javascript:addrow();"  onmouseover="changeColor(this)" onmouseout="huifuColor(this)">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp; ${empposition.workposition.name }&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<!-- 选择分岗 -->
		<select name="fgwop" id="fgwop" onchange="fgwop()">
		　　<option value="-1">--请选择岗位--</option>
		    <c:forEach items="${fglist}" var="workposition">
		    	<option value="${workposition.id}">${workposition.name}</option>
		    </c:forEach>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;
   </td>
  </tr>
</table>

<ul class="sp_nav_tab">
<li class="nomarl">员工简要信息</li>
</ul>
<table width="100%" border="0" cellspacing="0" cellpadding="15">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td width="17%" align="right" class="font_color_hui">姓名：</td>
          <td width="35%">&nbsp;&nbsp;${emp.name }</td>
          <td width="19%" align="right" class="font_color_hui">工号：</td>
          <td width="29%">&nbsp;&nbsp;${emp.empNo }
              <input type="hidden" id="password" value="${user.password }"/>
              <input type="hidden" id="uid" value="${user.userId }"/>
          </td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">性别：</td>
          <td>&nbsp;&nbsp;<c:if test="${emp.sex==1}">男</c:if><c:if test="${emp.sex==2}">女</c:if></td>
          <td align="right" class="font_color_hui">年龄：</td>
          <td>&nbsp;&nbsp;${emp.age }</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">邮件：</td>
          <td>&nbsp;&nbsp;${emp.email }</td>
          <td align="right" class="font_color_hui">联系电话：</td>
          <td>&nbsp;&nbsp;${emp.tel }</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">部门：</td>
          <td>&nbsp;&nbsp;${emp.department.name }</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<br /><br />
<ul class="sp_nav_tab">
<li class="nomarl">登录情况</li>
</ul>
<table width="100%" border="0" cellspacing="0" cellpadding="15">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td width="16%" align="right" class="font_color_hui">IP地址：</td>
          <td width="36%">&nbsp;&nbsp;${loginstate['IP'] }</td>
          <td width="19%" align="right" class="font_color_hui">本次登录时间：</td>
          <td width="29%">&nbsp;&nbsp;${loginstate['bclogintime'] }</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">当前登录岗位：</td>
          <td>&nbsp;&nbsp;${empposition.workposition.name }</td>
          <td align="right" class="font_color_hui">上次登录时间：</td>
          <td>&nbsp;&nbsp;${loginstate['sclogintime'] }</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
</div> 

<!-- 弹出一行 -->
<div id="addrow" class="d2"></div> 
</body>
</html>
