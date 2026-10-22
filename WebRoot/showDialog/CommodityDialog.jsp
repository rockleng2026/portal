<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta   http-equiv="Pragma"   content="no-cache"> 
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>商品列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<base target="_self">
</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<SCRIPT type="text/javascript">
function dialogInfo(id)
{
	var url="selectinfoOutbound.do";
	$.post(url,{id:id,mark:"server"},function(data){
		
			$("#selectinfo").append(data);
			$("#selectList").css("display","none");
			$("#close").css("display","");
	});
}
function closeInfo()
{
	$("#selectinfo").html("");
	$("#close").css("display","none");
	$("#selectList").css("display","");
}
function serverselect(id,pid,serverName,typename,xinghao,tx)
{
		alert(111);
		alert(id+" "+pid+" "+serverName+" "+typename+" "+xinghao+" "+tx);
		var url="findServiceLocationOutbound.do?tt="+(new Date()).getTime();
	$.post(url,{serverid:id,parentid:pid},function(data){
		  var datali=data.split('#');
		  			$("#serverId").attr("value",id);
		  			$("#productid").attr("value",id);
		  			$("#server").attr("value",serverName);
			       $("#serverLocation").attr("value",datali[0]);
			        var num=$("#num").val();
			        if(num==null||num==undefined)
			        {
			       if(datali.length>1)
			       {
					var ipli=datali[1].split(';');
					var ipss="";
					for(var i=0;i<ipli.length;i++)
					{
						var s=ipli[i].split(',');
						ipss+="<input type='checkbox' id='serverIp' name='serverIp' value="+s[0]+"#"+s[1]+" />"+s[1]+"&nbsp;&nbsp;";
					}  
						document.getElementById("liip").innerHTML=ipss;
					
					}
					}
					 $("#serverName").attr("value",serverName);
					
				
					 if(num!=null&&num!=undefined)
					 {
					 	$("#code"+num+"").attr("value",tx);
					 	$("#codeId"+num+"").attr("value",id);
					 	$("#pname"+num+"").attr("value",serverName);
					 	$("#pmodel"+num+"").attr("value",xinghao);
					 	$("#ptype"+num+"").attr("value",typename);
					 	$("#models"+num+"").attr("value",id);
					 	$("#model"+num+"").attr("value",xinghao);
					 	$("#barcode"+num+"").attr("value",tx);
					 }
					$("#dianji").click();
		
	});
}
function selectP(url)
{
	$("#dialog-modal").load(url);
} 
</SCRIPT>

		
<body>
<%String addH=request.getParameter("addH");
  String server=request.getParameter("server");
 %>
					<c:set value="<%=addH %>" var="addH"></c:set>
					<c:set value="<%=server %>" var="server"></c:set>
					
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							商品名称：
							<INPUT name=name>
							
							<c:if test="${not empty addH&& empty server}">
					<INPUT class=button type=submit onclick="selectP('showDialogOutbound.do?mark=commodity&addH=${addH}')"  value=" 查询 ">
					</c:if>
					<c:if test="${not empty server &&empty addH}">
					<INPUT class=button type=submit onclick="selectP('showDialogOutbound.do?mark=commodity&server=${server }')"  value=" 查询 ">
					</c:if>
					<c:if test="${empty addH&&empty server}">
					<INPUT class=button type=submit onclick="selectP(showDialogOutbound.do?mark=commodity)"  value=" 查询 ">
					</c:if>
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		
		<div id="selectList" name="selectList">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
			
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;商品记录查询
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="13%" height=30 class=category>
											商品名称
										</TD>
										<TD width="13%" height=30 class=category>
											条形码
										</TD>
										<TD width="12%" class=category>
											商品类型
										</TD>
										<TD width="9%" class=category>
											商品型号
										</TD>

										<TD width="30%" class=category>
											建立日期
										</TD>
										<TD width="10%" class=category>
											详细信息
										</TD>
										<TD width="10%" class=category>
											选择商品
										</TD>
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data">
											<TR id="tr${data.id }" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=middle>
													${data.property.name}
												</TD>
												<TD align=middle>
													${data.barcode}
												</TD>
												<TD align=middle>
													${data.property.model.commodityTpye.typeName}
												</TD>
												<TD align=middle>
													${data.property.model.name}
												</TD>
													<TD align=middle>
													${data.property.time }
												</TD>
												<TD align=middle>
												<a href="#" onclick="dialogInfo(${data.id })">	详细信息</a>
										</TD>
											<TD align=middle>
											<input type="button" value="选择该商品" onclick="serverselect('${data.id }','${data.parentId }','${data.property.name}','${data.property.model.commodityTpye.typeName}','${data.property.model.name}','	${data.barcode}')" />
										</TD>
											</TR>
										
											</c:forEach>
											
									<!--循环结束-->
									
									<tr>
								<td class=category colSpan=14 height=30>
										
									</td>
									</tr>
								</TBODY>
							</TABLE>
							
						</FORM>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD>
					<c:if test="${not empty addH&& empty server}">
					<pp:pages1 url="showDialogOutbound.do" key="addH" value="${addH}" param="mark=commodity&num=${num}"/>
					</c:if>
					<c:if test="${not empty server }">
					<pp:pages1 url="showDialogOutbound.do" key="server" value="${server}" param="mark=commodity&num=${num}"/>
					</c:if>
					<c:if test="${empty server&& empty addH }">
					<pp:pages1 url="showDialogOutbound.do" param="mark=commodity&num=${num}"/>
					</c:if>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>
		<div>
		<table name="selectinfo" id="selectinfo"  class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
					
				</table>
	</BODY>
</HTML>