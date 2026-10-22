<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>讨论问题</title>
		<jsp:include page="/common/inc_css.jsp" flush="true"></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true"></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true"></jsp:include>
       <script>
				function onsumbits()
				{
					var creattime = $("#creattime").val();
					var endTime = $("#endTime").val();
					if(creattime == "" && endTime != "")
					{
						alert("开始时间不能为空!");
						$("creattime").focus();
						return false;
					}
					if(creattime != "" && endTime == "")
					{
						alert("结束时间不能为空!");
						$("#endTime").focus();
						return false;
					}
					if(creattime > endTime)
					{
						alert("开始时间不能大于结束时间!");
						return false;
					}
					$("#form1").submit();
				}
				function onchangepname()
				{
					var pname =$("#pname").children('option:selected').val();
					$("#pname1").val(pname);
				}
				function onchangecreater()
				{
					var creater =$("#creater").children('option:selected').val();
					$("#creater1").val(creater);
				}
       </script>
	</head>

	<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" onsubmit=""
			action="selectQuestionProject.do">
			<input type="hidden" value="" name="pname1" id="pname1"  />
			<input type="hidden" value="" name="creater1" id="creater1" />
			<div id="box2" class="box2"
				style='border: #89aad7 1px solid; margin-bottom: 10px;'>
				<div class="searchDiv" id="searchDiv">
					<!-- 查询条件开始 -->
					<br />

					<table style="width: 100%; height: 100%" border="0" align="center"
						cellspacing="0" cellpadding="0" id="tablesearch">
						<tr class="height24">
							<th align="center">
								项目名称：
							</th>
							<td align="left">
								<select id="pname" onchange="onchangepname();">
									<option value="-1">
										--请选择--
									</option>
									<c:forEach items="${newPro}" var="newpro">
										<option value="${newpro.id}">
											${newpro.projectname}
										</option>
									</c:forEach>
								</select>
							</td>
							<th align="center">
								创建人：
							</th>
							<td>
								<select id="creater" onchange="onchangecreater();">
									<option value="-1">
										--请选择--
									</option>
									<c:forEach items="${newpartList}" var="newpart">
										<option value="${newpart.id}">
											${newpart.employee.name}
										</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr class="height24">
							<th align="center">
								开始时间：
							</th>
							<td>
								<input type="text" id="creattime" name="creattime"  class="Wdate" style="width: 90px;" onclick=
	WdatePicker();
value="" />
							</td>
							<th align="center">
								结束时间：
							</th>
							<td>
								<input type="text" name="endTime" id="endTime" class="Wdate" style="width: 90px;" onclick=
	WdatePicker();
value="" />
							</td>
							<th align="center">
								问题名称：
							</th>
							<td>
								<input type="text" name="revertnum" id="revertnum1" value="" />
							</td>
						</tr>

						<tr>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
							<td valign="top">
								<br />
							</td>
						</tr>
						<tr class="height24">
							<td colspan="8"
								style="padding-top: 4px; padding-bottom: 4px; text-align: center;"
								align="left">
								<input name="zuanquswjgbm" id="zuanquswjgbm" type="hidden"
									value="" />
<%--								<input type="button" value="查询" onclick="onsumbits();"/>--%>
								<button type="button" onclick="onsumbits();"><span class="icon_find">查询</span></button>
								<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
								<input name="daonum" value="1" type="hidden" />
							</td>
						</tr>

					</table>
				</div>
			</div>
		</form>

		<!-- 数据显示  -->
		<div id="resulthight">
			<table style="width: 100%;" border="0" align="center" cellpadding="0"
				cellspacing="0" class="tableStyle" id="youshuju">
				<tr align="center">
					<th>
						所在项目
					</th>
					<th>
						问题名称
					</th>
					<th>
						创建人
					</th>
					<th>
						创建时间
					</th>
					<th>
						回复
					</th>
				</tr>


				<!-- start 循环问题(分页) -->
				<c:forEach items="${pages.pageList}" var="question">
					<tr align="center">
						<td>
							${question.newProject.projectname}
						</td>
						<td>
							${question.questionname}
						</td>
						<td>
							${question.newParticipator.employee.name}
						</td>
						<td>
							${question.lastdate}
						</td>
						<td>
							<a href="selectIdQuestionProject.do?id=${question.id}&indexdemo=${question.indexdemos}">详情回复</a>
						</td>
					</tr>
				</c:forEach>
				<!-- end 循环问题 -->
				<tr>
					
					<td colspan="5">
						<p:pages url="selectQuestionProject.do"/>
					</td>
					
				</tr>
			</table>
			<table>
				
			</table>
		</div>
			</table>
			</div>
			</div>
		</form>
	</body>
</html>
