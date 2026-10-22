<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>  
    <base href="<%=basePath%>">
    
    <title>添加工单配置</title>
    <script type="text/javascript" src="<%=path %>/js/jquery.js"></script>
   <script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=path %>/js/handlejson.js"></script>
		<script type="text/javascript">
		
		window.onload = function()
		{
			questioncategorylist('category','','');
			categorylist('departments','','');
		}
		
		
		
		function pjok(){ 
	var temp=document.getElementsByName("isAssess");
	for (i=0;i<temp.length;i++){ 
	//遍历Radio 
		if(temp[i].checked){ 
			//alert("你选择了"+temp[i].value);
			if(temp[i].value=="Y"){ 
				text.style.display='';				
			}
			else{
				text.style.display='none';
				
			}
		} 
	} 
} 		
		var i = 0;
		function addrow(){
		var count = parseInt($("#mark").val());
		var objid = "departments"+i 
		var str = "<table id='assesss"+count+"'><tr bgcolor='#ffffff' >"+
                                    "<td width='10%' align='right' valign='top'><label>部门：</label></td>"+
                                     "<td width='30%'><select id='"+objid+"'>"+
                                            "</select></td>"+
                                            "<td >"+
                                            " <a href='javascript:void(0);' onclick='addassessTime("+count+");'>增加考核时间</a>"+ 
                                             " <a href='javascript:void(0);' onclick='delassessTime("+count+");'>删除考核时间</a>"+ 
                                           " </td>"+
                                              "</tr>"+
                                             " <tr bgcolor='#ffffff'>"+
                                    "<td></td><td width='6%' align='left' valign='top'><label><FONT color=#ff0000>*</FONT>设置时间：</label>"+
                                     "<input name='duration' id='duration"+count+"' onblur = "+'"'+"checkValueByRules('duration"+count+"',['num'],'durationMsg"+count+"')"+'"'+"/>分钟<FONT color=#ff0000 id='durationMsg"+count+"'></FONT><input type='hidden' name='depId'/></td>"+
                                              "</tr>"+		
                                              "<tr bgcolor='#ffffff' >"+
                                    "<td></td><td width='6%' align='left' valign='top'><label><FONT color=#ff0000>*</FONT>考核描述：</label>"+
                                     "<input name='assess' id='assess"+count+"' onblur = "+'"'+"checkValueByRules('assess"+count+"','','assessMsg"+count+"')"+'"'+"/><FONT color=#ff0000 id='assessMsg"+count+"'></FONT></td>"+
                                              "</tr>"+	
                                              "</table>";
                                             $("#assesss"+(count-1)).after(str);
                                             categorylist(objid,'','');                                          
                                              $("#mark").val(count+1);
                                              i++;
		}
		 function delRow(){
    var count=parseInt($("#mark").val());
 	var nowrow = count-1;
    if( nowrow <= 0){
    	alert("至少一个部门");
    	return false;
    }
 	$('#assesss'+nowrow).remove();
 	$("#mark").val(count-1);
 }
 function addassessTime(id){
 var row = ($("#assesss"+id).find("tr").length-1)/2;
 var assessTime="<tr bgcolor='#ffffff' ><td></td>"+
                                    "<td width='6%' align='left' valign='top'><label><FONT color=#ff0000>*</FONT>设置时间： </label><input name='duration' id='duration"+id+row+"' onblur="+'"'+"checkValueByRules('duration"+id+row+"',['num'],'durationMsg"+id+row+"')"+'"'+"/>分钟<FONT color=#ff0000 id='durationMsg"+id+row+"'></FONT><input type='hidden' name='depId'/></td>"+
                                             " </tr>"+	
                                              "<tr bgcolor='#ffffff'>"+
                                    "<td></td><td width='10%' align='left' valign='top'><label><FONT color=#ff0000>*</FONT>考核描述：&nbsp;</label>"+
                                     "<input name='assess' id='assess"+id+row+"' onblur = "+'"'+"checkValueByRules('assess"+id+row+"','','assessMsg"+id+row+"')"+'"'+"/><FONT color=#ff0000 id='assessMsg"+id+row+"'></FONT></td>"+
                                              "</tr>";
                                              $("#assesss"+id+"  tr:last").after(assessTime);
 }
 
 function delassessTime(id){
 if($("#assesss"+id).find("tr").length <=3)
 {
 alert("不能在删除");
 return;
 }
 
 $("#assesss"+id+"  tr:last").remove();
  $("#assesss"+id+"  tr:last").remove();
 }
 
 function submitform(){
    var tables = $("#text table");
    for(var i=0; i<tables.length; i++){
        var tableid = tables.get(i).id;
        var dempId = $("#"+tableid+" select").val();
        $("#"+tableid+" input[name='depId'][type = 'hidden']").val(dempId);
    }

    form1.submit();
 }
		</script>
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
		<FORM  id ="form1" name=form1 action="addwocWorkOrderCfigur.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;新增工单配置(带*号的为必填项)
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
											<TR>
										<TD width="25%" height=30 align=right><FONT color=#ff0000>*</FONT>问题或工单名称：</TD>
										<TD width="75%" class=category><input type="hidden" id="is" name="is" value="0">
											   	<input onblur="checkValueByRules('questionName','','questionNameMsg')" name="questionName" id="questionName" type="text" value="${messageremind.typeName}"/>
											<FONT color=#ff0000 id="questionNameMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											<FONT color=#ff0000>*</FONT>所属上级名称：
										</TD>
										<TD width="75%" class=category>
											<select  id="category" name="questioncategoryid" style="width: 200px;">
												<option value="">--无上级--</option>
											</select>
										</TD>
									</TR>
									<TR> 	
										<TD align=right height=30>
											正常处理总时间：
										</TD>
										<TD class=category>
										 <INPUT id="tmp1" onblur="checkValueByRules('tmp1',['num'],'tmp1Msg')" type="text" name="tmp1" value="" />分钟
										<FONT color=#ff0000 id="tmp1Msg"></FONT>
											&nbsp;
											
										</TD>
									</TR>										
									<TR> 	
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
										 <INPUT id="remark" type="text" name="remark" value="" />
										
											&nbsp;
											
										</TD>
									</TR>
									
								<TR>
										
										<TD align=right height=30>
											是否需要考核：
										</TD>
										<TD class=category>
										 <INPUT id="yes" type="radio" name="isAssess" value="Y" style="border:0px" onclick="pjok()"/>是&nbsp;&nbsp;
										  <INPUT id="no" type="radio" name="isAssess" value="N" style="border:0px" onclick="pjok()" checked="checked"/>否										
											&nbsp;											
										</TD>
									</TR>
									<tr>
									<td colspan="2" id="text" style="display:none;">
									<a href="javascript:void(0);" onclick="addrow();">添加部门</a>
                                             <a href="javascript:void(0);" onclick="delRow();">删除部门</a>
									<table id="assesss0">
									<tr bgcolor="#ffffff" >
                                    <td width="10%" align="right" valign="top"><label><FONT color=#ff0000>*</FONT>部门：</label></td>
                                     <td width="30%"><select onblur="checkValueByRules('departments','','departmentsMsg')" id="departments" name="departments">
                                  
                                            </select><FONT color=#ff0000 id="departmentsMsg"></FONT></td>
                                            <td >
                                              <a href="javascript:void(0);" onclick="addassessTime('0');">增加考核时间</a>
                                              <a href='javascript:void(0);' onclick='delassessTime(0);'>删除考核时间</a>
                                            </td>
                                              </tr>		
                                              
                                              <tr bgcolor="#ffffff" ><td></td>
                                    <td width="6%" align="left" valign="top"><label><FONT color=#ff0000>*</FONT>设置时间： </label><input name="duration" id="duration" type="text" onblur="checkValueByRules('duration',['num'],'durationMsg')"/>分钟
                                    <FONT color=#ff0000 id="durationMsg"></FONT>
                                    <input type='hidden' name='depId'/></td>
                                              </tr>
                                              		
                                              <tr bgcolor="#ffffff" id="addassessTime" >
                                    <td></td><td width="10%" align="left" valign="top"><label><FONT color=#ff0000>*</FONT>考核描述：</label>
                                     <input name="assess" id="assess" type="text" onblur="checkValueByRules('assess','','assessMsg')"/>
                                     <FONT color=#ff0000 id="assessMsg"></FONT>
                                     <input type="hidden" value="1" id="mark" name="mark" /></td>
                                              </tr>	


</table>                                  
                                              </td>		
                                              </tr>	
									         <TR>
									         
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT  class=button type=button value=" 确认添加 " onclick="submitform();">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
									
									
								</TBODY>
							</TABLE>
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
		</FORM>
	</BODY>
</HTML>
