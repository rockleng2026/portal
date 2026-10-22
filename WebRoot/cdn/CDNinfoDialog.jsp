<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta   http-equiv="Pragma"   content="no-cache"> 
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>商品列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
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
function closeCDN()
{
alert("aaa");
this.window.opener=null;
window.close();
}
</SCRIPT>
<body >
		<FORMname=form2 action="selectCommodity.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<TD align=right width="95%">
							套餐名称：
							<INPUT name=cname>
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
							<a href="#" onclick="closeCDN()" >关闭</a>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
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
										&nbsp;套餐查询
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="20%" height=30 class=category>
											套餐名称
										</TD>
										
										<TD width="20%" class=category>
											流量
										</TD>
										<TD width="20%" class=category>
											宽带
										</TD>

										<TD width="20%" class=category>
											HIT连接数
										</TD>
										<TD width="20%" class=category>
											价格
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
													
												</TD>
												<TD align=center>
													
												</TD>
													<TD align=center>
													
												</TD>
												</TD>
													<TD align=center>
													
												</TD>
												
											</TR>
											</c:if>
											</c:forEach>
											
									<!--循环结束-->
									
									<tr>
								<td class=category colSpan=14 height=30>
										 <p:pages url="showCommodity.do"/>
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
	</BODY>
</HTML>