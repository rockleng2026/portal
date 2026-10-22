<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>分配任务</title>
   <LINK href="<%=basePath%>Css/style.css" type=text/css
			rel=stylesheet />
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
			<script src="<%=basePath%>js/data.js" type="text/javascript"></script>
			<script type="text/javascript">
				
				$(document).ready(function(){
					
					$("#tal").find("tr:even").css("background-color","#FFFFFF");
					$("#tal").find("tr:odd").css("background-color","#EEF7FD");	
				});
				
				
				
				var rowcount = 1;//行
			    function addRow(){
			    	var str ="<tr align='center' id='add"+rowcount+"'><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><select><option value='-1'>--请选择--</option></select></td></tr>"
			    	$("#addrows").before(str);
			    	rowcount++;
			    }
			    function delRow()
			    {
			    	var num = rowcount-1;
			    	$("#add"+num).remove();
			    	rowcount--;
			    }					
					
			</script>
			
<style>
BODY {
	BACKGROUND-COLOR: #ffffff
}
.evenclass{
background:#EEF7FD;
}
.sousuotjdiv {
	height:30px;
	width:200px;
	text-align:center;
	float:left;
	margin-left:15px;
}
</style>


</head>
<body>
	<div align="center" style="width:500px;">
			<div style=" width:100%; margin-top:30px;background:#f6f6f6; font-size:12px;" align="center">
  <div class="sousuotjdiv" >请选择项目：
    <select name="sect1" id="sect1" class="sousuotj">
     <option value=0>请选择</option>
    </select>
  </div>
    <div style=" height:30px; width:100px; text-align:center; margin-left:15px; font-size:12px; ">
    <input id="butn" type="button" value="查询" class="butt"/>
  </div>
</div>
</div>
<hr />
<div>
  <TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed border=0>
			<TBODY>
				<TR>
					<TD>
						
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										项目任务分配
									</TD>
									<TD align=right>&nbsp;
										
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->

							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 id="tal">

								<TBODY id="tbody1">
									<TR align="center" id="hao">

										<TD width="20%" class=category>
											任务名称
										</TD>
										<TD width="15%" class=category>
											任务功能
										</TD>
										<TD width="15%" class=category>
											任务描述
										</TD>
										<td width="15%" class=category>
											生成日期
										</td>
										<td width="15%" class=category>
											邀请人
										</td>
										
										<TD width="5%" class=category>
											删除
										</TD>
										
									</TR>
									<!--循环-->
									<div id="ct">
									
									</div>
									<TR>
                                              <TD align=middle>
                                             
											  <input type="hidden" id="typeid" name="typeid" value="28">
							               <a href="receiveInfomessage.do?typeid=28&messageid=517">个人公告</a>
											</TD>
											<TD align=middle>
												密码是多少
											</TD>
											<TD align=middle>
													<a href="javascript:void(0);" onclick="showInfo('517')">查看内容</a>
											</TD>
											
											<td align=middle>
											2012-09-18 
											</td>
											<TD align="middle">
											<input type="text" size="5" />
												<select>
													<option value="-1">--请选择--</option>
												</select>
											</TD>
											
											<TD align=middle>
												<input type="hidden" value="517" />
												<INPUT
													style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													type=checkbox value="517" name=ids>
											</TD>
											
										</TR>
										<TR>
                                              <TD align=middle>
                                             
											  <input type="hidden" id="typeid" name="typeid" value="28">
							               <a href="receiveInfomessage.do?typeid=28&messageid=517">个人公告</a>
											</TD>
											<TD align=middle>
												密码是多少
											</TD>
											<TD align=middle>
													<a href="javascript:void(0);" onclick="showInfo('517')">查看内容</a>
											</TD>
											
											<td align=middle>
											2012-09-18 
											</td>
											<TD align=middle>
											<input type="text" size="5"/>
												<select>
													<option value="-1">--请选择--</option>
												</select>
											</TD>
											
											<TD align=middle>
												<input type="hidden" value="517" />
												<INPUT
													style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													type=checkbox value="517" name=ids>
											</TD>
											
										</TR>
										<TR>
                                              <TD align=middle>
                                             
											  <input type="hidden" id="typeid" name="typeid" value="28">
							               <a href="receiveInfomessage.do?typeid=28&messageid=517">个人公告</a>
											</TD>
											<TD align=middle>
												密码是多少
											</TD>
											<TD align=middle>
													<a href="javascript:void(0);" onclick="showInfo('517')">查看内容</a>
											</TD>
											
											<td align=middle>
											2012-09-18 
											</td>
											<TD align=middle>
											<input type="text"  size="5" />
												<select>
													<option value="-1">--请选择--</option>
												</select>
											</TD>
											
											<TD align=middle>
												<input type="hidden" value="517" />
												<INPUT
													style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													type=checkbox value="517" name=ids>
											</TD>
											
										</TR>
										<TR>
                                              <TD align=middle>
                                             
											  <input type="hidden" id="typeid" name="typeid" value="28">
							               <a href="receiveInfomessage.do?typeid=28&messageid=517">个人公告</a>
											</TD>
											<TD align=middle>
												密码是多少
											</TD>
											<TD align=middle>
													<a href="javascript:void(0);" onclick="showInfo('517')">查看内容</a>
											</TD>
											
											<td align=middle>
												2012-09-18 
											</td>
											<TD align=middle>
											<input type="text" size="5" />
												<select>
													<option value="-1">--请选择--</option>
												</select>
											</TD>
											
											<TD align=middle>
												<input type="hidden" value="517" />
												<INPUT
													style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													type=checkbox value="517" name=ids>
											</TD>
											
										</TR>
										
									<tr align="right" id="addrows" >
										<td align="right" colspan="6">
										<input type="button"  value="增加" id="btn1" onclick="addRow();"/>
										<input type="button"  value="减少" id="btn2" onclick="delRow();"/>
										<INPUT id=chkall
											style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
											onclick=CheckAll(this.form) type=checkbox value=select
											name=chkall>
										全选(删除)

										<INPUT name="delbut" type=button class=button
											onclick="delMes()" value="删 除">
											</td>
									</tr>
									<tr align="center"><td colspan="6"><input type="button"  value="保存"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="取消"/>  </td></tr>
									</TBODY></TABLE></div>
									
	
</body>
</html>
