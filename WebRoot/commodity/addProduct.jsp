<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加商品</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
				<base href="<%=basePath%>">
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js">
</script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<script type="text/javascript">
		
		window.onload = function(){
			commdity("ctypeid","${property.model.commodityTpye.id}","")
		}
function getFiled(){
   var nowDate = (new Date()).getTime();
   var deptid = $("#ctypeid").val();
   var url = "fieldCommodity.do";
   $("#bill").empty();
   $.post(url,{
	    id:deptid
	},function(data){
	 $("#bill").append(data);
	 });
}
		
		</script>
		<script type="text/javascript">	
function uploadImage() {
var files=$("#fileupload").val();
		if(files == null || files == "")
		{
		alert("请选择要上传的文件");
		return;
		}
	$(document)
			.ready(
					function() {
						var options = {
							url : "uploadFileuploadAction.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									$("#tipDiv").html(data[0]);
									$("#showImage").html("<img height='200' src='<%=path%>/"+data[1]+"'/>");
									$("#img").attr("value",data[1])
								} else {
									$("#tipDiv").html(msg);
								}
							}
						};
						
						$("#form1").ajaxSubmit(options);
						return false;
					});
}
</script>
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
											&nbsp;添加商品信息(带*号的为必填项)
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
											<INPUT onblur="checkValueByRules('name','','nameMsg')" style="WIDTH: 200px" id="name" name="name" value="${property.name }" />
											&nbsp;
											<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
										<td rowspan="6"> <div id="showImage"  ><c:if test="${property != null}"><IMG src="<%=request.getContextPath() %>/${property.img }" height='200'/></c:if></div></td>
									</TR>
									<tr>
					<td height="25" align=right>
						商品图片：
					</td>
					<td>
						<input id="fileupload" name="fileupload" type="file" />
						<input type="button" 
							onclick="uploadImage()" value="上传"/><input id="img" name="img" type="hidden" value="${property.img }">
						<div id="tipDiv"></div>
					</td>
</tr>
									<TR>
										<TD align=right height=30>
											商品类型：
										</TD>
										<TD width="50%" class=category>
										<select id="ctypeid" name="ctypeid"  onchange="getFiled()">
										</select>
											
											<FONT color=#ff0000 id="addressMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											商品型号：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="medelNmae" id="modelName"  onblur="checkValueByRules(this,'','capacityMsg')" value="${property.model.name }">
											
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="capacityMsg" color="red"></font>
										</TD>
									</TR>
								
										<TR>
										<TD align=right height=30>
											建立商品日期：
										</TD>
										<TD class=category>
										 <INPUT id="time" onblur="checkValueByRules('time',['birth'],'timeMsg')"  style="WIDTH: 150px" name="time"
												onclick="WdatePicker()" value="${property.time }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="time"></FONT>点击输入框获取时间
										</TD>
									</TR>
									</TBODY>
                                     </table>
                                  
                                    <table id="bill"  width="100%" >
                                    <tbody>
									<tr class=category><td align ="center" width=100px>字段</td><td align ="center" width=100px>属性名</td><td align ="left" >属性值</td></tr>
									${str }
									<tr class=category><td align ="center" width=100px>pcode</td><td align ="center" width=100px>商品编码</td><td align ="left" ><input type="text" name="pcord" id="pcord" value="${property.pcord }"/></td></tr>
									<tr class=category><td align ="center" width=100px>specifications</td><td align ="center" width=100px>商品规格</td><td align ="left" ><input type="text" name="specifications" id="spec" value="${property.specifications }"/></td></tr>
									<tr class=category><td align ="center" width=100px>unit</td><td align ="center" width=100px>商品单位</td><td align ="left" ><input type="text" name="unit" id="unit" value="${property.unit }"/></td></tr>
								    <tr class=category><td align ="center" width=100px>pprice</td><td align ="center" width=100px>商品价格</td><td align ="left" ><input type="text" onblur="checkValueByRules('pprice',['money'],'priceMsg')" name="pprice" id="pprice" value="${property.pprice }"/>&nbsp;
											<FONT color=#ff0000 id="priceMsg"></FONT><FONT color=#ff0000>*</FONT></td></tr>
								</TBODY>
							</TABLE>
							
						</TD>
					
					</TR>

										<TD height=30>
											
										</TD>
										<TD class=category align="center">
										
											<c:if test="${str == null}"><INPUT  class=button type=submit value=" 确认添加 "></c:if>
											<c:if test="${str != null}"><INPUT  class=button type=submit value=" 确认修改 "></c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
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
