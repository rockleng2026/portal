<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.fuao.fajxc.vo.Tresourcecheck"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
	<title>资源核实单详情</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js"></script>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
    </head>
    <script type="text/javascript">
    	function btnsubmit()
    	{
			var content = encodeURI(encodeURI($("#content").val(),"utf-8"));
			form1.action = "<%=request.getContextPath() %>/resultRCReCheck.do?content="+content;
			form1.submit();
        }
		function btnhistory()
		{
			window.history.go(-1);
		}
    </script>      
<body>
<form action="" method="post" id="form1">
     <div id="resulthight">
     <% Tresourcecheck trc = (Tresourcecheck)request.getAttribute("trc");
	%>
	
	<input type="hidden" id="rcid" name="rcid" value="<%=trc.getId()%>"/>
											<input type="hidden" id="tab" value="Tresourcecheck">
											<input type="hidden" id="filed" value="audtitingFlag">
											<input type="hidden" id="orderName" value="rvid">
<%--     <input type="hidden" name="filename" id="filename" value="<%=newQuestion1.getQuestioninfo()%>" />--%>
    	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    		<tr align="left">
    			<td colspan="2" align="left"><h3><img src="<%=request.getContextPath() %>/icons/img.gif"></img>回复</h3></td>
    		</tr>
			<tr style="height: 30px;"> 
				<td class="rightbold" width="30%">核查编号：</td>
				<td width="70%"><%=trc.getRvid()%></td>
			</tr>
			<tr> 
				 <td class="rightbold">申请人：</td>
				<td width="70%"><%=trc.getEmpid().getName()%></td>
			</tr>

			<tr>
				<td class="rightbold">商品名称：</td>
				<td width="70%" style="height: 100px;">
					<%=trc.getSaleGoods().getSgname()%> 
					<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju">
						<tr><td class="rightbold">商品编码</td><td width="70%">${sg.sgcode}</td></tr>
						<tr><td class="rightbold">商品录入人</td><td width="70%">${sg.sgUsername}</td></tr>
						<tr><td class="rightbold">商品价格</td><td width="70%">${sg.sgPrice}</td></tr>
						<tr><td class="rightbold">商品规格</td><td width="70%">${sg.sgNorms}</td></tr>
						<tr><td class="rightbold">商品单位</td><td width="70%">${sg.sgUnit}</td></tr>
						<tr><td class="rightbold">商品详情</td><td width="70%">${sg.sgDetails}</td></tr>
					</table>
				</td>
			</tr>
			 <tr> 
			 	<td class="rightbold">地区：</td>
			 	<td><%=trc.getCity().getName()%></td>
			 </tr>
			 <tr> 
			 	<td class="rightbold">仓库：</td>
			 	<td><%=trc.getDepot().getName()%></td>
			 </tr>
			 <tr> 
			 	<td class="rightbold">截止时间：</td>
			 	<td><%=trc.getStarttime()%></td>
			 </tr>
			 <tr>
			 	<td class="rightbold">状态：</td>
			 	<td>
	    			<%if(trc.getIsstate().equals("0")){ %>
	    				未审批
	    			<%} %>
	    			<%if(trc.getIsstate().equals("1")){ %>
	    				已审批
	    			<%} %>
	    			<%if(trc.getIsstate().equals("2")){ %>
	    				已回复
	    			<%} %>
	    			<%if(trc.getIsstate().equals("3")){ %>
	    				拒批
	    			<%} %>
	    		</td>
			 </tr>
			 <tr>
			 	<td class="rightbold">回复人</td>
			 	<td>${emps.name}</td>
			 </tr>
			<tr>
				<td class="rightbold">回复内容</td>
				<td>
					<textarea name="content" id="content" class="textarea"  style='width:300px;height:100px;'></textarea>
					<font>(例：xx仓库有xx商品,余多少；或xx仓库无xx商品。)</font>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button name='cha' style="CURSOR:hand;" class="button" onclick="javascript:btnsubmit();">
								<span class="icon_save">确定</span>
					 </button>
				</td>
				
			</tr>
		</table>
	</div>
</form>
<jsp:include page="/resourceCheck/result.jsp"></jsp:include>
	</body>

</html>