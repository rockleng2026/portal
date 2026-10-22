<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加商品类型</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>  
		<script type="text/javascript">		
		function trcount()
		{
		commdity("superid","${ct.superid.id}","");
		  var table5 = $("#bill").find("tr").length;
		  if(table5 == 0)
		  {
		  table5 =1;
		  }
		$("#ProCount").attr("value",table5);
		}
		
		function showWind(id) {  
              var returnvalue= showModalDialog("<%=request.getContextPath() %>/commodity/marqueList.jsp"); 

 $("#"+id).val(returnvalue[1]);
 $("#"+id+"id").attr("value",returnvalue[0]);
 $("#cmodel").attr("value",returnvalue[3]);
 $("#modelid").attr("value",returnvalue[2]);     
}
		
		
		function Reset()
{
    var f=document.forms[0];alert(f.id);
    f.reset();
}
function getTD()
{
   var newtd=document.createElement("td");
   newtd.setAttribute("align","center");
   newtd.style.backgroundColor="#ffffff";
   newtd.className="font02";
   return newtd;
}

function getTD2()
{
   var newtd=document.createElement("td");
   newtd.setAttribute("align","center");
   newtd.colSpan=5;
   newtd.style.backgroundColor="#ffffff";
   newtd.className="font02";
   return newtd;
}



function addProElement() 
{
      var table1 = document.getElementById('bill');
      var proStart=document.getElementById("ProCount");

      var maxNO=proStart.value;

      if(maxNO == "21")
      {
      alert("您不可以在添加字段了，请联系管理员");
      return;
      }
      var endidx=table1.rows.length;
    
      var newtr =table1.insertRow(endidx);
      
      newtr.id="pro"+maxNO;
      proStart.value=parseInt(maxNO)+1;
       newtd=getTD();
      newtd.innerHTML="temp"+maxNO;
      newtr.appendChild(newtd);
       newtd=getTD();
      newtd.innerHTML='<input name="temp'+maxNO+'"  id="temp'+maxNO+'"  type="text"  />';
     
      newtr.appendChild(newtd);
 }
 
 function CancelTr()
 {   
   var tableObj=document.getElementById('bill');
    tableObj.deleteRow(tableObj.rows.length-1);
    var start=$("#ProCount").val();
    var trcount =tableObj.rows.length;
    if(trcount == 0)
    {
    trcount=1;
    }

   $("#ProCount").attr("value",trcount);
    
     //dtr.parentNode.removeChild(dtr);
 }
		
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
									$("#ico").attr("value",data[1])
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
	<BODY onload ="trcount()">
		<FORM  id ="form1" name=form1 action="addcommodityTpye.do" method="post" onsubmit="return addValidators()">
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								
								<TBODY>
								
											<TR>
										<TD width="20%" height=30 align=right>商品类型名称：</TD>
										<TD width="50%" class=category><input type ="hidden" id ="ProCount" value="1"/>
											<INPUT onblur="checkValueByRules('typeName','','nameMsg')" style="WIDTH: 200px" id="typeName" name="typeName" value="${ct.typeName }" />
											&nbsp;
											<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
										<td rowspan="6" class=category> <div id="showImage"  ><c:if test="${property != null}"><IMG src="<%=request.getContextPath() %>/${property.img }" height='200'/></c:if></div></td>
									</TR>
				
								
										
									<TR>
										<TD align=right height=30>
											商品类型父类：
										</TD>
										<TD class=category >
										 <select id="superid" name="superid">
										 
										 </select>
										</TD>
									</TR><TR>
										<TD align=right height=30>
											图标地址：
										</TD>
										<td class=category>
						<input id="fileupload" name="fileupload" type="file" />
						<input type="button" 
							onclick="uploadImage()" value="上传"/><input id="ico" name="ico" type="hidden" value="${property.img }">
						<div id="tipDiv"></div>
					</td>
									</TR><TR>
										<TD align=right height=30>
											是否多选：
										</TD>
										<TD class=category>
										 <INPUT style="border: 0px" id="ischeckbox" name="ischeckbox" value="1" type="radio" checked="checked"/>是 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										  <INPUT style="border: 0px" id="ischeckbox" name="ischeckbox" value="2" type="radio"/>否
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="time"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											建立商品类型日期：
										</TD>
										<TD class=category>
										 <INPUT id="time" onblur="checkValueByRules('time',['birth'],'timeMsg')"  style="WIDTH: 150px" name="time" value="${ct.time }"
												onclick="WdatePicker()"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="time"></FONT>点击输入框获取时间
										</TD>
									</TR>
									
									<TR>
										<TD align=left height=30>
											<h3>商品类型字段</h3> <s:property value="#org.ct.field.temp1"/>
										</TD>
										<TD class=category>
										
										</TD>
									</TR>
									</TBODY>
                                     </table>
                                    <c:if test="${!empty ct}"><input type="hidden" name = "fid" id="fid" value="${ct.field.id }"/><input type="hidden" name = "ctid" id="ctid" value="${ct.id }"/></c:if>
                                    <table id="bill" >
                                    <tbody>
                                
									<tr><td align ="center" width=100>字段</td><td align ="center" width=200>属性值</td></tr>
									<c:if test="${!empty ct}">
									<s:if test="#request.ct.field.temp1 != null"><tr class=category><td align ="center" width=100>temp1</td><td align ="center" width=200><input name="temp1" id ="temp1" value="${ct.field.temp1 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp2 != null"><tr class=category><td align ="center" width=100>temp2</td><td align ="center" width=200><input name="temp2" id="temp2" value="${ct.field.temp2 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp3 != null"><tr class=category><td align ="center" width=100>temp3</td><td align ="center" width=200><input name="temp3" id="temp3" value="${ct.field.temp3 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp4 != null"><tr class=category><td align ="center" width=100>temp4</td><td align ="center" width=200><input name="temp4" id="temp4" value="${ct.field.temp4 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp5 != null"><tr class=category><td align ="center" width=100>temp5</td><td align ="center" width=200><input name="temp5" id="temp5" value="${ct.field.temp5 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp6 != null"><tr class=category><td align ="center" width=100>temp6</td><td align ="center" width=200><input name="temp6" id="temp6" value="${ct.field.temp6 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp7 != null"><tr class=category><td align ="center" width=100>temp7</td><td align ="center" width=200><input name="temp7" id="temp7" value="${ct.field.temp7 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp8 != null"><tr class=category><td align ="center" width=100>temp8</td><td align ="center" width=200><input name="temp8" id="temp8" value="${ct.field.temp8 }"/></td></tr></s:if>
                                    <s:if test="#request.ct.field.temp9 != null"><tr class=category><td align ="center" width=100>temp9</td><td align ="center" width=200><input name="temp9" id="temp9" value="${ct.field.temp9 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp10 != null"><tr class=category><td align ="center" width=100>temp10</td><td align ="center" width=200><input name="temp10" id="temp10" value="${ct.field.temp10 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp11 != null"><tr class=category><td align ="center" width=100>temp11</td><td align ="center" width=200><input name="temp11" id="temp11" value="${ct.field.temp11}"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp12 != null"><tr class=category><td align ="center" width=100>temp12</td><td align ="center" width=200><input name="temp12" id="temp12" value="${ct.field.temp12 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp13 != null"><tr class=category><td align ="center" width=100>temp13</td><td align ="center" width=200><input name="temp13" id="temp13" value="${ct.field.temp13 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp14 != null"><tr class=category><td align ="center" width=100>temp14</td><td align ="center" width=200><input name="temp14" id="temp14" value="${ct.field.temp14 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp15 != null"><tr class=category><td align ="center" width=100>temp14</td><td align ="center" width=200><input name="temp15" id="temp15" value="${ct.field.temp15 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp16 != null"><tr class=category><td  align ="center" width=100>temp16</td><td align ="center" width=200><input name="temp16" id="temp16" value="${ct.field.temp16 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp17 != null"><tr class=category><td align ="center" width=100>temp17</td><td align ="center" width=200><input name="temp17" id="temp17" value="${ct.field.temp17 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp18 != null"><tr class=category><td align ="center" width=100>temp18</td><td align ="center" width=200><input name="temp18" id="temp18" value="${ct.field.temp18 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp19 != null"><tr class=category><td align ="center" width=100>temp19</td><td align ="center" width=200><input name="temp19" id="temp19" value="${ct.field.temp19 }"/></td></tr></s:if>
									<s:if test="#request.ct.field.temp20 != null"><tr class=category><td align ="center" width=100>temp20</td><td align ="center" width=200><input name="temp20" id="temp20" value="${ct.field.temp20 }"/></td></tr></s:if>
									</c:if>
								</TBODY>
							</TABLE>
						</TD>
					
					</TR>

										<TD height=30>
											
										</TD>
										<TD class=category>
										<input class=button  type ="button" value="添加字段" onclick="addProElement();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT  class=button type=button value=" 删除字段 " onclick="CancelTr();">
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
					<tr align ="center"><td></td>	
						<td>
						<c:if test="${empty ct}"><INPUT  class=button type=submit value=" 确认添加 "></c:if>
						<c:if test="${!empty ct}"><INPUT  class=button type=submit value=" 确认修改 "></c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<INPUT class=button type=reset value=" 重置 ">
						&nbsp;&nbsp;&nbsp;&nbsp;
						</TD>
					</tr>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
