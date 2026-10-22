<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>IP列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<base target="_self"/> 
</head>

<SCRIPT type="text/javascript">
	function del1(url,href){
	var all=document.getElementsByName('ids');
	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++){
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length>0){
		delflag=true;
	}
	if(!delflag){
		alert("请选择要操作的记录！");
		return false;
	}
	if(!delflag){
		return false;
	}
	$.post(url,{ids:allId},
	function (data)
	{
		
			alert(data);
			window.location.href=href;
	});
}

function onclickState(ipcid)
{
    var s = "#"+state;
	var ipcstate = $(s).attr("class");
}
function btnselect()
{
	form2.action = "<%=request.getContextPath() %>/selectIpmanager.do";
	form2.submit();
}
function btnempty()
{
	$("#ipaddress").val('');
	$("#ipname").val('');
	form2.action = "<%=request.getContextPath() %>/selectIpmanager.do";
	form2.submit();
}

</SCRIPT>
<body>
		<form name="form2"  action="" method="post" id="form2">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							IP地址：
							<INPUT type="text" id="ipaddress" name="ipaddress"  value="${ipcaddresss}"/>
							IP名称：
							<INPUT type="text" id="ipname" name="ipname" value="${ipcnames}" />
							<INPUT class=button type="button" onclick="javascript:btnselect();"  value="查询 ">&nbsp;&nbsp;
							<INPUT class=button type="button" onclick="javascript:btnempty();"  value="清空 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
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
										&nbsp;Ip记录表
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
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									<TD width="15%" height=30 class=category>
											IP地址
										</TD>
										<TD width="15%" height=30 class=category>
											IP名称
										</TD>
										<TD width="8%" class=category>
											IP运营商
										</TD>
<!--										<TD width="10%" class=category>-->
<!--											销售价格-->
<!--										</TD>-->
<!--										<TD width="10%" class=category>-->
<!--											制定人-->
<!--										</TD>-->
<!--										<TD width="11%" class=category>-->
<!--											制定时间-->
<!--										</TD>-->
<!--										<TD width="9%" class=category>-->
<!--											详细记录-->
<!--										</TD>-->
<!--										<TD width="9%" class=category>-->
<!--											流程跟踪-->
<!--										</TD>-->
										
										<TD width="10%" class=category>
											状态
										</TD>
										<TD width="10%" class=category>
											修改
										</TD>
										<TD width="10%" class=category>
											删除
										</TD>
									</TR>


									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
													${data.ipcaddress}
												</TD>
												<TD align=middle>
													${data.ipcname}
												</TD>
												<TD align=middle>
													${data.ipcarrier}
												</TD>
												
											
												<c:if test="${data.ipcstate =='0'}">
													<TD align=middle>
														<div id="${data.ipcId}" class="${data.ipcstate}"><a href="#"  onclick="onclickState('${data.ipcId}');" >未使用</a></div>
													</TD>
												</c:if>
												<c:if test="${data.ipcstate =='1'}">
													<TD align=middle>
														<div id="${data.ipcId}" class="${data.ipcstate}"><a href="#"  onclick="onclickState('${data.ipcId}');" >已使用</a></div>
													</TD>
												</c:if>
												
												
												<TD align="middle">
												<A
														href="updateUImanager.do?ipcid=${data.ipcId}"
														target=right><IMG style="CURSOR: hand" 
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
													</a>
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.ipcId}" name=ids>
												</TD>
											</TR>
											</c:forEach>
									<!--循环结束-->
									<TR>
										<TD colspan="6"><p:pages url="selectIpmanager.do"/></TD>
									</TR>


									
									
									<TD class=category colSpan=12 height=30 align="right">
										<div><a href="addUI1manager.do?str=aaaa">批量添加</a> </div>							     
								     	<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														
														<INPUT name="delbut" type="button" class="button"
															onclick="del1('delIpmanager.do','selectIpmanager.do')"
															value="删 除" />
															<INPUT name="delbut" type="button" class="button"
															onclick="del1('updateState1manager.do','selectIpmanager.do')"
															value="使用" />
															<INPUT name="delbut" type="button" class="button"
															onclick="del1('updateState0manager.do','selectIpmanager.do')"
															value="禁用" />
														
									</TD>
								</TBODY>
							</TABLE>
					
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
<%--				<TR>--%>
<%--					<TD>--%>
<%--						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">--%>
<%--					</TD>--%>
<%--					<TD> <p:pages url="selectIpmanager.do"/></TD>--%>
<%--					<TD>--%>
<%--						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">--%>
<%--					</TD>--%>
<%--				</TR>--%>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
