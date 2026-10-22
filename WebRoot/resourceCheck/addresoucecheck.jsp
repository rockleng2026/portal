<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
%>

<html>
	<head>

		<title>创建问题</title>
		
		<jsp:include page="/common/inc_css.jsp" flush="true"></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true"></jsp:include>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<jsp:include page="/js/cha.jsp" flush="true"></jsp:include>
		<script language="javascript">
	
	function onchangmodels()
	{
		$("#models").val($("#modelid").val());
	}
	function onchangcitys()
	{
		$("#citys").val($("#cityid").val());
	}
	function onchangeles()
	{
		$("#eles").val($("#eleid").val());
	}
	function onchangpro()
	{
		$("#pids").val($("#proid").val());
	}

	function onsubmitRC()
	{
		var mess = $("#messages").val();
		if(mess == "no")
		{
			alert("无审批流程");
			return false;
		}
		form1.action = "addResourceReCheck.do";
		form1.submit();
	}

	
	//修改
	function onupdate()
	{
		form1.action ="<%=request.getContextPath() %>/updateRCReCheck.do";
		form1.submit();
	}
	
</script>
	</head>
	<body>
	<form id="form1" method="post" onsubmit="return false;">
			<input type="hidden" name="models" id="models"  />
			<input type="hidden" name="citys" id="citys" />
			<input type="hidden" name="eles" id="eles" />
			<input type="hidden" name="pids" id="pids"/>
			<input type="hidden" id="messages" name="messages" value="${message}"/>
			<input type="hidden" id="time1" />
			<input type="hidden" value="${trc.audtitingFlag}"  name="audtitingFlag" id="audtitingFlag"/>
			<input type="hidden" value="${trc.id}" name="rcid" id="rcid"/>
			<input type="hidden" value="${trc.empid.id}" name="empid" id="empid"/>
			<div id="resulthight">
				<table style="width: 100%;" border="0" align="center"
					cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju">
					<tr>
						<th align="left" colspan="2">
							<img style="float: left;"
								src="<%=request.getContextPath()%>/icons/png/64.png" width="20"
								height="20"></img>
							<h3 style="text-align: left;">
								创建问题 
							</h3>
						</th>
					</tr>
					<tr>
						<th>
							 资源核实编号：
							<font color="red">(*)</font>
						</th>
						<td>
						<c:if test="${trc == null}">
							<input type="text" id="rvid"
								name="tresourcecheck.rvid"  value="${rvid}" readonly="readonly" />
								<FONT id="empMsg" color=#ff0000></FONT>
								</c:if>
								<c:if test="${trc != null}">
									<input type="text" id="rvid"
								name="tresourcecheck.rvid"  value="${trc.rvid}" readonly="readonly" />
								<FONT id="empMsg" color=#ff0000></FONT>
								</c:if>
						</td>
					</tr>
					
					<tr>
						<th>
							申请人：
							<font color="red">(*)</font>
						</th>
						<td>
						<c:if test="${trc ==null}">
							<input type="text"  value="${emps.name}" readonly="readonly"  />
							</c:if>
							<c:if test="${trc != null}">
								<input type="text"  value="${trc.empid.name}" readonly="readonly"  />
							</c:if>
						</td>
					</tr>
					
					<tr>
						<th>
							商品名称：
							<font color="red">(*)</font>
						</th>
						<td>
						<select id="proid" onchange="onchangpro();">
						<c:if test="${trc != null}">
								<option value="${trc.saleGoods.sgId}">${trc.saleGoods.sgname}</option>
							</c:if>
						<option value="-1">--请选择商品名称--</option>
						
						<c:forEach items="${listPro}" var="pro">
							<option value="${pro.sgId}">${pro.sgname}</option>	
						</c:forEach>
						</select>
						<FONT id="contentMsg" color=#ff0000></FONT>
						</td>
					</tr>
					<tr>
						<th>
							地区：
							<font color="red">(*)</font>
						</th>
						<td>
							<select id="cityid" onchange="onchangcitys();">
							<c:if test="${trc != null}">
								<option value="${trc.city.id}">${trc.city.name}</option>
							</c:if>
								<option value="-1">--请选择--</option>
								<c:forEach items="${listCity}" var="city">
									<option value="${city.id}">${city.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>
							仓库：
							<font color="red">(*)</font>
						</th>
						<td>
							<select id="eleid" onchange="onchangeles();">
							<c:if test="${trc != null}">
								<option value="${trc.depot.id}">${trc.depot.name}</option>
							</c:if>
								<option value="-1">--请选择--</option>
								<c:forEach items="${listeleHouce}" var="eleh">
									<option value="${eleh.id}">${eleh.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>
							 资源核实时间：
							<font color="red">(*)</font>
						</th>
						<td>
						<c:if test="${trc ==null}">
							<input type="text" id="nowtime"
								name="tresourcecheck.starttime" onblur="checkValueByRules('nowtime','','empMsg')" value="${nowTime}" readonly="readonly" />
								<FONT id="empMsg" color=#ff0000></FONT>
								</c:if>
								<c:if test="${trc != null}">
									<input type="text" id="nowtime"
								name="tresourcecheck.starttime" onblur="checkValueByRules('nowtime','','empMsg')" value="${trc.starttime}" readonly="readonly" />
								<FONT id="empMsg" color=#ff0000></FONT>
								</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<c:if test="${emps !=null}">
							<button name='cha' style="CURSOR:hand;" class="button" onclick="javascript:onsubmitRC();">
								<span class="icon_save">保存</span>
							</button>
							</c:if>
							<c:if test="${message != null}">
								<button name='cha' style="CURSOR:hand;" class="button" onclick="">
								<span class="icon_save">无审批流程</span>
							</button>
							</c:if>
							<c:if test="${trc !=null}">
								<button name='cha' class="button" style="CURSOR:hand;" onclick="onupdate();">
								<span class="icon_save">修改</span>
							</button>
							</c:if>
							<c:if test="${question ==null}">
								<button type="button" style="CURSOR:hand;" onclick="resetjsp1();">
								<span class="icon_clear">清空</span>
								</button>
							</c:if>
							<c:if test="${question !=null}">
								<button type="reset" onclick="onreset1();"><span class="icon_clear">重置</span></button>
							</c:if>
							<button type="button" style="CURSOR:hand;" onclick="closeWindeows(0)">
								<span class="icon_close">关闭</span>
							</button>
						</td>
					</tr>
				</table>
			</div>
			</form>
	</body>
</html>
