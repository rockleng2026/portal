<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

		<script type="text/javascript" src="js/jquery.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/verifyorder.js" charset="gbk"></script>
<title>流程单信息表</title>

</head>
	<body>
	<FORM name="" action="addPurReturnOrderRejection.do" method="post">
			<TABLE  cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD width="100%">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 width="100%"
								align=center border=1>
								<TBODY>			
								<TR>
										<TD width="100%" height=30 align="center"  colspan="3">
											<h1>新增流程单信息</h1>
										</TD>
									</TR>																				
									<TR >
										<TD width="200px" height=30 align=right> 
											流程单类型：
										</TD>
										<TD width="200px" class=category>
											&nbsp;
											<s:select name="xxx" id="remark" onblur="checkValueByRules('remark','','remarkMsg')" onchange="selmark1 (this)" list="%{#request.doclist}" headerKey="-1" headerValue="请选择" listKey="id" listValue="aname" value="this.value"  ></s:select>
											<FONT color=#ff0000 id="remarkMsg">*</FONT>
										</TD>
										<TD  width="200px" class=category>
										          标识：
											<INPUT disabled="disabled" style="WIDTH: 200px" name="otbs" id="ot"   onblur="checkValueByRules('ot',['en_num'],'ordertypeMsg')">
											&nbsp;
											<FONT color=#ff0000 id="ordertypeMsg">*</FONT>
										</TD>
									</TR>	
									<TR>
									    <td  width="200px" height=30 align=right>请选择审核类型：</td>
										<TD width="600px" class=category colspan="2">
											<input id="adddepartment"  type="button" name="adddepartment" onclick="add()" value="按员工审核"/>
											<input type="button" onclick="showDept()" value="按部门审核"/>
										</TD>
									</TR>	
									<tr>
										<td colspan="3">
										   <table  width="1245px" border="1" bgcolor="white"  id="department"></table>
										   <div id="mydiv"  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px; display: none;">
										     <table id="tab" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
										         <c:forEach items="${deptlist}" var="dept">
										             <tr>
										                <td><input type="checkbox" name="depts" id="${dept.id }" onclick="checkEmp(this)" />${dept.name }</td>
										             </tr>
										         </c:forEach>
										     </table>
										   </div>
										</td>
									</tr>
									<tr align="center">
										<td>
										</td>
										<td align="center" ><font>请根据员工的审核的先后顺序输入由小到大的数字！！（同时审核或多人需一人审核是输入相同的数字）</font></td>
										<td></td>
									</tr>
									<tr>
									    <!-- 按部门选择员工得到顺序排列 -->
										<td colspan="3" id="aaa" style="display: none;" ></td>
										<!-- 直接选择部门 -->
										<td style="display: none;" colspan="3" id="bbb"></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										 <!-- 得到按部门选择部门和员工编号 -->
										<td align="left" id="selectDe"><input type="text" id="bmId" value=""/><input type="text" id="ygId" value=""/><input type="button" onclick="ssss()" value="确定"/></td>
										<!-- 得到按部门选择部门编号 -->
										<td align="left" id="selectD"><input type="text" id="bbmId" value=""/><input type="button" onclick="ssss()" value="确定"/></td>
									</tr>
									<tr >
										<td></td>
											<td id="bbb"  width="1245px">
											<table id="deltable"></table>
											</td>
										<td></td>
									</tr>
									<TR>
										
										<TD colspan="3" align="center">
										    <!-- 标识是按部门审还是按员工审核 -->
										    <input type="hidden" id="flag" value="" />
											<INPUT type="button" name="returnTime" id="returnTime" onclick="addverify()" value="添加">
											&nbsp;
											
											<INPUT type="reset"  name="returnTime" id="returnTime" value="重置">
										</TD>
									</TR>	
								</TBODY>
							</TABLE>
						</TD>
						<TD>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		
	</body>
</html>