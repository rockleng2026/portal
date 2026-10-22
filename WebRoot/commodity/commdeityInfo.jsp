<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加商品</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="addCommodity.do" method="post" onsubmit="return addValidators()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE  cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											<a href="javascript:history.go(-1);">返回上一页</a>

											
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
						</TD>
					
					<TR>
						<TD>&nbsp;</TD>
						<TD>
						<input type="hidden" id ="modelid" name="modelid" value="${property.model.model }"/>
						<input type="hidden" id="porperid" name = "porperid" value="${property.id }">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								
								<TBODY>
											<TR>
											
										<TD width="25%" height=30 align=right>商品名称：</TD>
										<TD width="50%" class=category><input type ="hidden" id ="ProCount" value="1"/>
											${property.name }
											
										</TD>
										<td rowspan ="6"><div>${prperty.img} <c:if test="${property.img != null}"><img src="<%=request.getContextPath() %>${property.img }" height='200'></c:if><c:if test="${property.img == null}"><H3>此商品暂无图片</H3></c:if></div></td>
									</TR>
									<TR>
										<TD align=right height=30>
											商品类型：
										</TD>
										<TD width="50%" class=category>
										${property.model.commodityTpye.typeName }
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											商品型号：
										</TD>
										<TD class=category>
											${property.model.name }
											
										</TD>
									</TR>
								
										<TR>
										<TD align=right height=30>
											建立商品日期：
										</TD>
										<TD class=category>
										 
												${property.time }
											
										</TD>
									</TR>
									</TBODY>
                                     </table>
                                  
                                    <table id="bill"  width="100%" >
                                    <tbody>
									<tr class=category><td align ="center" width=100px>字段</td><td align ="center" width=100px>属性名</td><td align ="left" >属性值</td></tr>
									${str }
								</TBODY>
							</TABLE>
							
						</TD>
					
					</TR>

									</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
					
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
