<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%><%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
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
		
		<script type="text/javascript">
	function onsubmitCus()
	{
		form1.action = "<%=basePath%>selectCussalegoods.do";
		form1.submit();
	}
function sub(){
	
		
		$("sub").submit();

		}
function closediv()
{
	parent.document.getElementById('addrow1').style.display='none';
}
function selectcust(a,b,c){
	parent.document.getElementById('addrow1').style.display='none';
	parent.selectcust(a,b,c);
}

</script>


	<body class="yy" style="font-size: 12px;">
		<div class="dowy" >
			<div class="dowy_top">
				<span><a href="javascript:closediv();">×</a> </span> 仓库用户选择
			</div>
			
	
				<div class="dowy_nr" style="width: 613px;">
					<table width="100%" border="0" cellspacing="0" 
						cellpadding="0" style="background-color: #ffffff;" style="font-size: 12px;">
						
						<tr height="32">
							<td height="32" colspan="6" >
								<form action="selectcustsalegoods.do" id="sub" method="post">
								<table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-color: yellow;" >
									<tr>
									
										<td colspan="3"  align="right">
											客户姓名
											<input name="product" id="product" value="" type="text"
												class="text1" />
											
										</td>
										<td>
											<input type="submit" value="查 询" class="ccc"/>
										</td>
										
									</tr>
								</table>
								</form>
							</td>
						</tr>
						
						<tr style="font-size: 12px;">
							<td width="86" height="26" align="center"
								class="tc_top tc_rightb">
								客户名称
							</td>
							<td width="119" height="26" align="center"
								class="tc_top tc_rightb">
								客户帐号
							</td>
							<td width="120" height="26" align="center"
								class="tc_top tc_rightb">
								 负责人
							</td>
							<td width="100" height="26" align="center"
								class="tc_top tc_rightb">
								 客户公司名称
							</td>
							<td width="102" height="26" align="center"
								class="tc_top tc_rightb">
								客户电话
							</td>
							<td width="143" height="26" align="center" class="tc_top">
								选择该客户
							</td>
						</tr>
						<c:if test="${pages != null}">
							<c:forEach items="${pages.pageList}" var="cus">
								<tr style="font-size: 12px;">
									
			
									<td width="86" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.customerName}
									</td>
									
					
									<td width="119" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.customerName}
									</td>
										
									<td width="120" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.employee.name}
									</td>
									
									
									<td width="100" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.customerCompany}
									</td>

									<td width="102" height="26" align="center"
										class="tc_rightb tc_footyb">
										${cus.phone}
									</td>
									
									<td width="143" height="26" align="center" class="tc_footyb">
		
										<a onclick="javascript:selectcust('${cus.customerId}','${cus.customerName}','${cus.phone}');" style="CURSOR:pointer;"> 选择该商品</a>
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
								<p:pages url="selectcustsalegoods.do"/>
							</td>
						</tr>
					</table>
				</div>
			

		</div>

