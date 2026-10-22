<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.WorkLog"%>
<%@page import="com.fuao.fajxc.vo.AuditingOrderTab"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>全部日志列表</title>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.main { width:760px; margin:0 auto;}
.top_cx{
	.dow{width:760px; height:230px; float:left}
}
.top_cx td{font-size: 12px;}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:0px solid #455c32;  float:left}
.dow_nr td{font-size:12px;line-height: 26px;}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF;height: 26px;}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#5da500; }

.tc_rightb{border-right:1px solid #c3c3c3;}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;} 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.tab ul li { width:90px; line-height:25px; float:left;text-align:center; background-color:#E8E8E8; margin-left:2px;}
.tab ul  .active{ background-color:#4FA805; color:#fff; font-size:12px; }
.tab div{ clear:both; border-top:1px solid #4FA805; }
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; width:60px; line-height:25px; text-align:center; margin-left:auto; margin-right:auto;}
.msg_green{ border:#4FA805 1px solid; line-height:20px; background-color:#FFF;width:223px;}
 .msgshow_green .c2{background:url(images/c2.png) no-repeat 100px 0px; height:11px; position:relative; margin-bottom:-1px;  z-index:1; }
 .size{ font-size:12px;}
 .dvr{ float:right; margin-right:5px;}
 
  #bgzy_bk { border-left:1px solid #c3c3c3; border-right:1px solid #c3c3c3;}
 .ahovestyle{background-color:#5da601;color:#FFFFFF;}
 .showview{border-bottom:1px solid #c3c3c3;border-right:1px solid #c3c3c3;font-size: 12px;}
.cbx{width: 12px;height: 12px;}
.gb_bb{color:#4FA805; line-height:25px; font-size:12px;height:25px;
text-align:center;cursor:hand;margin:3px; width:100%;}
 a{text-decoration: none;}
 a:hover{color:red;}
</style>
<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<link href="<%=path%>/potal/css/thickbox.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path%>/potal/js/thickbox.js"></script>
<script type="text/javascript" src="<%=path %>/potal/js/newPortalworkLogJs.js"></script>
<!-- 输入框移上去的样式变化JS  -->
</head>
<body>
<div class="dow">
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;工作日志&gt;<span class="wzcs">日志管理</span>
</div>
</div>
<div style="line-height:50px;" class="top_cx">
<form id="Form1" action="selectOtherWorkLogNewportal.do?clear=0&type=${LogType}" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="70%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right">选择部门</td>
              <td>
                <label for="select"></label>
                <select id="departmentID" name="departmentID" onchange="t(this)"  style="width:100px;">
					<option  id="deparmentID" value="-1">请选择:</option>
					<c:forEach items="${deparments}" var="department">
						<option  id="deparmentID" value="${department.id}">${department.name}</option>
					</c:forEach>
				</select>
               </td>
            </tr>
          </table></td>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right">选择员工</td>
              <td>
                <label for="select2"></label>
               <select id="employeeID"  name="employeeID" style="width:100px;">
					<option  id="deparmentID" value="-1">请选择:</option>
					<c:forEach items="${employees}" var ="employee">
						<option name="employeeID" value="${employee.id}">${employee.name}</option>
					</c:forEach>
				</select>
              </td>
            </tr>
          </table></td>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right">选择时间</td>
              <td>
                <label for="textfield"></label>
                <input name="selectDate" type="text" id="textfield" size="10" onclick="WdatePicker();" /> 
              </td>
            </tr>
          </table></td>
        </tr>
      </table></td>
      <td width="30%">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="31%" ><div class="gb_bt" onclick="topquery()" title="查询" style="cursor: pointer;">查询</div></td>
          <td width="41%"><div class="gb_bt" onclick="y()" title="批量批阅" style="cursor: pointer;">批量批阅</div></td>
          <td width="31%">&nbsp; <div class="gb_bt" onclick="q()" title="对比" style="display:none; cursor: pointer;">对比</div></td>
        </tr>
      </table>
      </td>
    </tr>
  </table>
 </form>
</div>
  <div class="outline tab">
	<ul>
	   	<li <c:if test="${LogType==0}"> class='active' </c:if> id="cxrz"><a  href="selectOtherDayWorkLogNewportal.do" style="text-decoration:none;">日志列表</a></li>
	    <li <c:if test="${LogType==1}"> class='active' </c:if> id="cxzz"><a  href="selectOtherMonthWorkLogNewportal.do" style="text-decoration:none;" >周志列表</a></li>
	    <li <c:if test="${LogType==2}"> class='active' </c:if> id="cxyz"><a  href="selectOtherWeekWorkLogNewportal.do" style="text-decoration:none;">月志列表</a></li>
	</ul>
</div>
  <div class="dow_nr">
 <form id="form2" name=form2 action="" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">   
   <tr>
						<td  width="5%" height="12" align="center" class="tc_top tc_rightb">
							选择
						</td>
						<td  width="10%" height="26" align="center" class="tc_top tc_rightb">
							姓名
						</td>
						<td  width="15%" height="26" align="center" class="tc_top tc_rightb">
							部门
						</td>
						<td  width="14%" height="26" align="center" class="tc_top tc_rightb">
							职位
						</td>
						<td  width="10%" align="center" class="tc_top tc_rightb">类型</td>
						<td width="15%" height="26" align="center"	class="tc_top tc_rightb">
							时间
						</td>
						<td width="15%" height="26" align="center"	class="tc_top tc_rightb">
							领导批注
						</td>
						<td width="8%" height="26" align="center"	class="tc_top tc_rightb">
							内容
						</td>
						<td width="8%" align="center" class="tc_top tc_rightb">
							操作
						</td>
					</tr>
    <c:if test="${empty pages.pageList}">
		<tr><td align="center" colspan="8" class="tc_rightb">无日志............</td></tr>
	</c:if>
	<c:if test="${!empty pages.pageList}">
	    <c:forEach items="${pages.pageList}" var="data" >
		<tr>
				<td class="tc_footb tc_rightb" align="center">
						<input type="checkbox" value="${data.id}"　name="ids" id="ids" class="cbx" />
				</td>
				<td class="tc_footb tc_rightb" align="center">
					${data.employeeByEmpId.name }
				</td>
				<td class="tc_footb tc_rightb" align="center">
					${data.employeeByEmpId.department.name } 
				</td>
				<td class="tc_footb tc_rightb" align="center">
					<!--  ${data.employeeByEmpId.workposition.name }&nbsp; -->
					${data.employeeByEmpId.groups.groupName}&nbsp;
				</td>
				<td class="tc_footb tc_rightb" align="center">
				   <c:if test="${data.type == 0}">工作日志</c:if>
				   <c:if test="${data.type == 1}">工作周志</c:if>
				   <c:if test="${data.type == 2}">工作月志</c:if>&nbsp;
				</td>
				<td class="tc_footb tc_rightb" align="center">
					${data.recordTime }&nbsp;
				</td>
				<td class="tc_footb tc_rightb" id="td${data.id}" align="center">
						　<% int i = 0 ;%>
							<c:forEach items="${audlist}" var="aud">
								<c:if test="${data.isView == 0}">
								<c:if test="${data.logNo==aud.orderNo}">
									<%  i = 1; %>
									<a href="goAddNewReplyWorkLogNewportal.do?logNo=${data.logNo }&audid=${aud.id }&id=${data.id}" id="${data.id }"  name="view">添加批注</a>
								</c:if>
							</c:if>
							</c:forEach>
							<c:if test="${data.isView == 0}">
								<%if(i==0) {%>
									<a href="goAddNewReplyWorkLogNewportal.do?logNo=${data.logNo}&audid=${aud.id }&id=${data.id}" id="${data.id }"  name="view">添加批注</a>
								<%}%>
							</c:if>
					<c:if test="${data.isView == 1}"><a href="goSeeReply2WorkLogNewportal.do?id=${data.id }&logNo=${data.logNo }" id="${data.id }"  > <font color="#ff0000" name="view">批注待查看</font></a></c:if>
					<c:if test="${data.isView == 2}"><a href="goSeeReply2WorkLogNewportal.do?id=${data.id }" id="${data.id }" name="view" > 批注已查看</a></c:if>
				</td>				
				<td align="center" class="showview" >
					<a class="thickbox gb_bb" href="<%=path %>/resultByLidWorkLogNewportal.do?logid=${data.id }&height=300&width=500" >查看缩略</a>
				</td>
				<td class="tc_footb tc_rightb" align="center" id="td${data.id}" >
					<center>
						<a name="view"  id="button${data.id}"  class="gb_bb" style="cursor: pointer;" onClick="showInfo3('${data.id}')" >详情</a>
					</center>								
				</td>
		</tr>
	</c:forEach>
	</c:if>
    <tr>
      <td colspan="8" align="right" class="foot1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="24%" align="left">
           <input id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"  class="cbx"
											onclick="CheckA(this.form)" type=checkbox value=select name=chkall />全选/反选&nbsp;
		   
		  </td>
          <td id="page" colspan="7" width="76%">
              <c:if test="${mark==0}"><p:pages  url="selectOtherDayWorkLogNewportal.do?type=0"/></c:if>
			  <c:if test="${mark==1}"><p:pages url="selectOtherMonthWorkLogNewportal.do?type=1"/></c:if>
			  <c:if test="${mark==2}"><p:pages url="selectOtherWeekWorkLogNewportal.do?type=2"/></c:if>
			  <c:if test="${mark==4}"><p:pages url="obscureselect1WorkLogNewportal.do?type=4"/></c:if>
          </td>
        </tr>
      </table>
      </td>
    </tr>
  </table>
</form>
</div>
</div>
<!--演示内容开始-->
<script type="text/javascript">
function ms(obj){
	
	 $.ajax({
		  type: "post",
		  url: "resultByLidWorkLogNewportal.do",
		  data: {
			  "logid":obj
			  },
		  success: function(data){			  
				  $("#contentmore").html(data);
		  }
	});
	
}
</script>

<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}

/* cover-list */
.cover-list{width:670px;margin:20px auto;}
.cover-list li{float:left;margin:0 15px 15px 0;display:inline;width:152px;height:150px;overflow:hidden;}
/* detail-frame */
.detail-frame{display:none;}
.arrow-left{position:absolute;width:6px;height:9px;top:30px;left:0;margin-left:-6px;background:url(<%=path%>/potal/images/arrow_gray.gif) no-repeat;}
.arrow-right{position:absolute;width:6px;height:9px;top:30px;left:320px;background:url(<%=path%>/potal/images/arrow_gray.gif) no-repeat -6px 0;}
.detail-tip{position:absolute;width:300px;background:#fff;border:1px solid #ddd;padding:10px;}
.detail-tip h2{font-size:12px;line-height:18px;color:#3366cc;}
.detail-tip p{margin:10px 0 0 0;font-size:14px;}
</style>
<div class="dvr" style="display: none" id="contentmore"></div>
</body>
</html>
