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

		<SCRIPT language=javascript>
function getvalue(typeid,typename,modelid,modelname)
{
                var ral=new Array(4);
    ral[0]=typeid;
     ral[1]=typename;
      ral[2]=modelid;
       ral[3]=modelname;
    window.returnValue = ral;
    window.close();
}
function dialogInfo(id)
{
	var url="selectinfo1Outbound.do";
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
function selectp(typeid,typename,id,name){

var obj=$("#num").val();
//alert(obj+"num");
$("#types"+obj).val(typeid);
$("#models"+obj).attr("value",id);
$("#type"+obj).attr("value",typename);
$("#model"+obj).attr("value",name);
$("#dianji").click();   
}
	
</SCRIPT>
<body>
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<TD align=right width="95%">
							商品名称：
							<INPUT id=cname name=cname>
							<INPUT class=button type="button" onclick="selectinfo('select1Commodity.do?mark=custom&cusname','cname')"   value=" 查询 ">
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
										&nbsp;商品信息查询
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
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
						<input type="text" id="num" name="num" value="${num }">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
								<TBODY>
									<TR align="center">
										<TD width="20%" height=30 class=category>
											商品名称
										</TD>
										<TD width="20%" class=category>
											商品类型
										</TD>
										<TD width="20%" class=category>
											商品型号
										</TD>

										<TD width="20%" class=category>
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
									<c:forEach items="${pages.pageList}" var="data" >
									<c:if test="${data.model.commodityTpye.del == 0 and data.model.delflag ==0}">
											<TR id="tr${data.id }" ondblclick="getvalue('${data.model.commodityTpye.id}','${data.model.commodityTpye.typeName}','${data.model.name}','${data.model.model}')" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=center>
													${data.name}
												</TD>
												<TD align=center>
													${data.model.commodityTpye.typeName}
												</TD>
												<TD align=center>
													${data.model.name}
												</TD>
													<TD align=center>
													${data.time }
												</TD>
												<TD align=center>
													<a href="#" onclick="dialogInfo(${data.id })">	详细信息</a>
												</TD>
												<TD align=center>
													<input type="button" onclick="selectp('${data.model.commodityTpye.id}','${data.model.commodityTpye.typeName}','${data.model.model}','${data.model.name}')"  value="选择该商品3"/>
												</TD>
											</TR>
											</c:if>
											</c:forEach>
									<!--循环结束-->
									<tr>
								<td class=category colSpan=14 height=30>
										 <pp:pages1 url="showCommodity.do" param="num=${num}"  />
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
					<TD></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>
		<div >
				<table name="selectinfo" id="selectinfo"  class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
				</table>
			</div>
	</BODY>
</HTML>