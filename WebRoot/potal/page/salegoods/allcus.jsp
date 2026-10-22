<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出售中的商品</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<base target="_self">
		<style type="text/css">
.yy{width:610px; margin:0 auto; }
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dowy{width:610px; height:230px; float:left;font-size:12px}
.dowy_top{width:610px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dowy_top span{float:right; padding-right:10px; padding-top:1px;}
.dowy_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dowy_nr{width:610px; border:1px solid #455c32;  float:left}
.tc_formy{width:610px; float:left; line-height:23px;}
.tc_formy dd{width:610px; float:left; text-align:right;}
.tc_formy dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_formy dt span{width:50px; float:right}
.tc_formy dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.footy{padding-right:15px}
.footy a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.footy a:hover{background:#5da500; color:#FFFFFF}	
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footyb{border-bottom:1px solid #c3c3c3}
.tc_footyb a{text-decoration:none; color:#ff9002; }
.tc_footyb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}
.ccc{ text-align:center;width:50px; line-height:20px;float:right; background-color:#7b7b7b;color:#fff;}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
.footy1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
</style>
		<script type="text/javascript"
			src="<%=basePath%>potal/js/jquery.min.js"></script>
		<script type="text/javascript">
	function onsubmitCus()
	{
		form1.action = "<%=basePath%>selectCussalegoods.do";
		form1.submit();
	}

	function selectCus(id, name,address,phone,email) {

		parent.document.getElementById('cusname').value= name;
		parent.document.getElementById('cusid').value= id;
		//parent.document.getElementById('phone').value=phone;
		//parent.document.getElementById('email').value=email;


			parent.document.getElementById('address2').value= address;
			var cusaddress = address+"("+name+"收)"+" "+phone;
			$.ajax({
				type:"POST",
				url:"selectDaddresssalegoods.do",
				data:{"cusid":id},
				dataType:"html", 
				success:function(data)
				{
						parent.document.getElementById('addressifo').innerHTML = data;
				}
			});
			parent.document.getElementById("uname").innerHTML =name;
			parent.document.getElementById("ress").innerHTML =address;

		parent.document.getElementById('addrow1').style.display='none'; 
	}
	function closediv()
	{
		parent.document.getElementById('addrow1').style.display='none';
	}
</script>
	</head>

	<body class="yy" style="font-size: 12px;">
		<div class="dowy" >
			<div class="dowy_top">
				<span><a href="javascript:closediv();">×</a> </span> 快捷选择用户
			</div>
			<form action="" method="post" id="form1">
	
				<div class="dowy_nr" style="width: 613px;">
					<table width="100%" border="0" cellspacing="0" height="202"
						cellpadding="0" style="background-color: #ffffff;" style="font-size: 12px;">
						<tr>
							<td height="32" colspan="6" align="right">
								<table width="100%" border="0" style="font-size: 12px;">
									<tr>
										<td>
											客户名称
											<input name="cusname" type="text" id="cusname"
												value="${cusname}" class="text1" />
										</td>
										<td>
											公司名称
											<input name="customerCompany" id="customerCompany"
												value="${customerCompany}" type="text" class="text1" />
										</td>
										<td>
											业务人员
											<input name="strempname" id="strempname" value="${strEmp}" type="text"
												class="text1" />
											<input type="hidden" id="vendition" value="${empinfo.id}"
												name="vendition" />
										</td>
										<td>
											<a onclick="javascript:onsubmitCus();" style="CURSOR:pointer;"><span class="ccc">查 询</span> </a>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr style="font-size: 12px;">
							<td width="86" height="26" align="center"
								class="tc_top tc_rightb">
								客户名称
							</td>
							<td width="119" height="26" align="center"
								class="tc_top tc_rightb">
								客户类型
							</td>
							<td width="120" height="26" align="center"
								class="tc_top tc_rightb">
								公司名称
							</td>
							<td width="100" height="26" align="center"
								class="tc_top tc_rightb">
								移动电话
							</td>
							<td width="102" height="26" align="center"
								class="tc_top tc_rightb">
								业务人员
							</td>
							<td width="143" height="26" align="center" class="tc_top">
								操作
							</td>
						</tr>
						<c:if test="${pages != null}">
							<c:forEach items="${pages.pageList}" var="cus">
								<tr style="font-size: 12px;">
									<c:if test="${cus.realName == ''}">
										<td width="86" height="26" align="center"
										class="tc_rightb tc_footyb">
										&nbsp;
									</td>
									</c:if>
									<c:if test="${cus.realName != ''}">
									<td width="86" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.realName}
									</td>
									</c:if>
									<c:if test="${cus.customerType2 == 10000}">
										<td width="119" height="26" align="center"
										class="tc_rightb tc_footyb">
										&nbsp;
										</td>
									</c:if>
									<c:if test="${cus.customerType2 == 3}">
									<td width="119" height="26" align="center"
										class="tc_rightb tc_footyb">
										正式客户
									</td>
									</c:if>
									<c:if test="${cus.customerCompany ==''}">
										<td width="120" height="26" align="center"
										class="tc_rightb tc_footyb">
										&nbsp;
									</td>
									</c:if>
									<c:if test="${cus.customerCompany !=''}">
									<td width="120" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.customerCompany}
									</td>
									</c:if>
									<c:if test="${cus.mobilePhone == ''}">
										<td width="100" height="26" align="center"
										class="tc_rightb tc_footyb">
										&nbsp;
									</td>
									</c:if>
									<c:if test="${cus.mobilePhone != ''}">
									<td width="100" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.mobilePhone}
									</td>
									</c:if>
									<c:if test="${cus.employee.name ==''}">
										<td width="102" height="26" align="center"
										class="tc_rightb tc_footyb">
										&nbsp;
									</td>
									</c:if>
									<c:if test="${cus.employee.name != ''}">
									<td width="102" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.employee.name}
									</td>
									</c:if>
									<td width="143" height="26" align="center" class="tc_footyb">
										<a href="#"> 详细</a>&nbsp;&nbsp;&nbsp;
										<a onclick="javascript:selectCus('${cus.customerId}','${cus.realName}','${cus.customerAddress==null?'暂无':cus.customerAddress}','${cus.mobilePhone}','${cus.email}');" style="CURSOR:pointer;"> 选择该用户</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${pages == null}">
							<tr style="font-size: 12px;">
								<td colspan="6">
									查无数据
								</td>
							</tr>
						</c:if>
						<tr style="font-size: 12px;">
							<td height="35" colspan="6" align="right" class="footy1">
								<p:pages url="selectCussalegoods.do?mark=depot"/>
							</td>
						</tr>
					</table>
				</div>
			</form>

		</div>
	</body>
</html>
