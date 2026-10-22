<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%String path = request.getContextPath(); %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<SCRIPT type="text/javascript">
			function showDilalogFile(url,id)
			{
				returnvalues= showModalDialog(url,"","dialogWidth=600px;dialogHeight=600px");
				window.location.href="showOrder1CDNsaleOrderAction.do?id="+id;
			}
			function selectGroup()
			{
				var groupId=document.getElementById("groupId").value;
				var cusId=document.getElementById("cusID").value;
				var cuRealmName=document.getElementById("cuRealmName").value;
				$.post("addGroupIPCDNsaleOrderAction.do",{groupId:groupId,cusId:cusId,cuRealmName:cuRealmName},function(data){
					if(data==0)
					{
						alert("分组成功");
					}
				});
			}
			
			function editconf(CuRealmName)
			{
				 var cuRealmName=CuRealmName.replace(".","_").replace(".","_");
				 window.location.href="<%=path%>/cdn/templateconfig.jsp?cuRealmName="+cuRealmName;	
			}
			function openService(id,num,RealmName)
			{
				$.post("openServiceCDNsaleOrderAction.do",{id:id,num:num,RealmName:RealmName},function(data){
					if(data==0&&num==1)
					{
						alert("开启成功");
						location.reload();
					}
					else if(data==0&&num==2)
					{
						alert("关闭成功");
						location.reload();
					}
					else if(data==3&&num==1)
					{
						alert("没有写入配置文件");
						location.reload();
					}
					else if(num==1)
					{
						 alert("开启失败");
						 location.reload();
					}
					else
					{
						 alert("关闭失败");
						 location.reload();
					}
				});
			}
			
	    </SCRIPT>
		<base target="_self">
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
 
  <body>
  	<h1>详细信息：</h1>
    <table width="100%" align="center"   bgColor=#fff8ed border=1>
    <tr>	<font >审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
					 </tr>
					 <tr>
					 	<td colspan="4" align="center">
					 		${markfanhui }
					 	</td>
					 </tr>
    	<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">CDN编号</td>
			<td width="30%">${cdnsale.saleOrderNo }
			<input type="hidden" id="orderNo" value="${cdnsale.saleOrderNo }" />
			<input type="hidden" id="tab" value="CDNsaleOrder">
			<input type="hidden" id="filed" value="auditingState">
			<input type="hidden" id="orderName" value="saleOrderNo">
				
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">申请时间</td>
			<td width="30%">${cdnsale.time }</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">IP区间数</td>
			<td width="30%">${cdnsale.IPinterval}
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">PV区间数</td>
			<td width="30%">${cdnsale.PVinterval}</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">客户名称</td>
			<td width="30%">${cdnsale.customer.realName}
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">客户电话</td>
			<td width="30%">${cdnsale.customer.mobilePhone}</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">客户QQ</td>
			<td width="30%">${cdnsale.customer.qq}
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">客户邮箱</td>
			<td width="30%">${cdnsale.customer.email}</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">附件平均数</td>
			<td width="30%">${cdnsale.accessoryfile }
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">多数文件大小</td>
			<td width="30%">${cdnsale.mostfile}</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">加速</td>
			<td width="30%">${jiasu }
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">备案号</td>
			<td width="30%">${cdnsale.recordsNO}</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">开始运行时间</td>
			<td width="30%">${cdnsale.starttime }</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">结束运行时间</td>
			<td width="30%">${cdnsale.endtime }</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">实际价格</td>
			<td width="30%">${cdnsale.price }元</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">付费类型</td>
			<td width="30%">
			<c:if test="${cdnsale.setmeal.chargeType==0 }">免费</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==1 }">赠送</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==2 }">预付费</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==3 }">后付费</c:if>
			</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">服务状态</td>
			<td width="30%">
				<c:if test="${cdnsale.serverFlag==1 }">开启</c:if>
				<c:if test="${cdnsale.serverFlag==2 }">关闭</c:if>
				<c:if test="${cdnsale.auditingState==1 }">
					
					<c:if test="${cdnsale.writeflag==1}">
					<c:if test="${cdnsale.serverFlag==2 }">
						<input type="button" value="开启服务"  onclick="openService(${cdnsale.id},1,'${cdnsale.cuRealmName }')"/>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${cdnsale.auditingState==1 }">
					
					<c:if test="${cdnsale.writeflag==1}">
				<c:if  test="${cdnsale.serverFlag==1 }"> 
					<input type="button" value="关闭服务"  onclick="openService(${cdnsale.id},2,'${cdnsale.cuRealmName }')"/>
					</c:if>
				</c:if>
				</c:if>
				<!-- 
				<a href="">dasdasdas</a>
				 -->
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">审核状态</td>
			<td width="30%">
				<c:if test="${cdnsale.auditingState==0 }">未审核</c:if>
				<c:if test="${cdnsale.auditingState==1 }">审核通过</c:if>
				<c:if test="${cdnsale.auditingState==2 }">审核未通过</c:if>
				<c:if test="${cdnsale.auditingState==8 }">审核中</c:if>
			</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">客户域名</td>
			<td width="30%">${cdnsale.cuRealmName }
			<SELECT id="groupId" value="this.value">
				<c:forEach items="${cdngroup}" var="data">
					<option value="${data.id }">${data.groupName }</option>					
				</c:forEach>
			</SELECT>
			<input type="button" value="保存" onclick="selectGroup()" />
			
			<input type="hidden" id="cusID" value="${cusid}" />
						<input type="hidden" id="cuRealmName" value="${realmName }" />
			
			</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">系统域名</td>
			<td width="30%">${cdnsale.syRealmName }</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">套餐名</td>
			<td width="30%">${cdnsale.setmeal.name }</td>
			<td width="20%" bgcolor="#c4d8ed" align="right">域名类型</td>
			<td width="30%">${cdnsale.setmeal.realmtype.name }</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">套餐描述</td>
			<td width="80%" colspan="3">${cdnsale.setmeal.name }</td>
		</tr>
		
		<tr>
			<td colspan="4" height="50" align="center">套餐详细</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="center">套餐名称</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">宽带</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">单价</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">原价</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">优惠价</td>
		</tr>
		<c:forEach items="${property}" var="datapro">
		<tr>
			<td width="20%"  align="center">${datapro.name }</td>
			<td width="20%"  align="center">${datapro.flow }<font color="red">G</font></td>
			<td width="20%"  align="center">${datapro.bandwidth }<font color="red">G/元</font></td>
			<td width="20%"  align="center">${datapro.hitnum }<font color="red">元</font></td>
			<td width="20%"  align="center">${datapro.flow1 }<font color="red">元</font></td>
		</tr>
		</c:forEach>
	</table>
	<table width="100%" align="center"   bgColor=#fff8ed border=1>
		<tr>
			<td colspan="5" height="50" align="center">IP</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="center">IP</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">端口</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">IP所在地</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">运营商</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">写入文件</td>
		</tr>
 		<c:if test="${cdnlist==null}">
 		<tr>
			<td colspan="5" height="40" align="center">没有IP！！！</td>
		</tr>
 		</c:if>
		<c:forEach items="${cdnlist}" var="dataip">
		<tr>
			<td width="20%" align="center">${dataip.ip }</td>
			<td width="20%"  align="center">${dataip.port }</td>
			<td width="20%"  align="center">${dataip.address }</td>
			<td width="20%" align="center">${dataip.tmoblie }</td>
			<td width="20%"  align="center">
				<c:if test="${dataip.CDNsaleorder.auditingState==0 }">未审核</c:if>
				<c:if test="${dataip.CDNsaleorder.auditingState==1 }">
					审核通过
					<c:if test="${dataip.CDNsaleorder.writeflag==0}">
						<input type="button" onclick="showDilalogFile('showToFileCDNsaleOrderAction.do?id=${dataip.id }',${dataip.CDNsaleorder.id })" value='写入文件' />
						<input type="button" onclick="editconf('${dataip.CDNsaleorder.cuRealmName}')" value='查看文件' />
					</c:if>
					<c:if test="${dataip.CDNsaleorder.writeflag==1}">
						已经写入文件
					</c:if>
				</c:if>
				<c:if test="${dataip.CDNsaleorder.auditingState==2 }">审核未通过</c:if>
				<c:if test="${dataip.CDNsaleorder.auditingState==8 }">审核中</c:if>
			</td>
		</tr>
		</c:forEach>
    </table>
	<table width="100%" align="center"   bgColor=#fff8ed border=1>
		<tr>
			<td colspan="3" height="50" align="center">缓存规则</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="center">是否缓存</td>
			<td width="60%" bgcolor="#c4d8ed" align="center">缓存内容</td>
			<td width="25%" bgcolor="#c4d8ed" align="center">缓存时间</td>
		</tr>
 		<c:if test="${cachelist==null}">
 		<tr>
			<td colspan="3" height="40" align="center">没有缓存规则！！！</td>
		</tr>
 		</c:if>
		<c:forEach items="${cachelist}" var="datacache">
		<tr>
			<td width="15%"  align="center">
				<c:if test="${datacache.cacheflag==1 }">缓存</c:if>
				<c:if test="${datacache.cacheflag==2 }">不缓存</c:if>
			</td>
			<td width="60%"  align="center">${datacache.cachecontent }</td>
			<td width="25%"  align="center">${datacache.contentime }</td>
		</tr>
		</c:forEach>
    </table>
    <table width="100%" align="center"   bgColor=#fff8ed border=1>
		<tr>
			<td colspan="3" height="50" align="center">回源IP</td>
		</tr>
		<tr>
			<td width="30%" bgcolor="#c4d8ed" align="center">运营商</td>
			<td width="30%" bgcolor="#c4d8ed" align="center">大地区</td>
			<td width="40%" bgcolor="#c4d8ed" align="center">回源IP</td>
		</tr>
		<c:if test="${districtlist==null}">
 		<tr>
			<td colspan="3" height="40" align="center">没有回源IP！！！</td>
		</tr>
 		</c:if>
		<c:forEach items="${districtlist}" var="datadis">
		<tr>
			<td width="30%"  align="center">${datadis.tmoblie }</td>
			<td width="30%"  align="center">${datadis.districtName }</td>
			<td width="40%"  align="center">${datadis.ip }</td>
		</tr>
		</c:forEach>
	</table>
	<table>
		<c:if test="${quanxian=='quanxian'}">
			<TR>
				<TD height=30 align=right>
					<h3>审核操作:</h3>
				</TD>
				<TD class=category colspan="3">
					<c:if test="${mark=='mark'}">
						<input type="button" value="接收" onClick="incepttime('${cdnsale.saleOrderNo }','CDNsaleOrder','auditingState','saleOrderNo')"/>
					</c:if>
					<c:if test="${mark != 'mark'}">
			  			<c:if test="${flage==0||flage==null}">
			  				<input type="button" value="审核" onclick="completemission('${data.id }',2)">
			  			</c:if>
			   			<c:if  test="${flage==1 ||flage==2}">
			   				您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：
			   				<c:if test="${aot.auditingFlag==1}">通过</c:if>
			  		 		<c:if test="${aot.auditingFlag==2}">未通过</c:if>
			  		 		--审核意见：${aot.tmp }
			  			</c:if>
			   		</c:if>
					<br>
				</TD>
			</TR>
		</c:if>
	</table>
  <jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
  </body>
</HTML>
