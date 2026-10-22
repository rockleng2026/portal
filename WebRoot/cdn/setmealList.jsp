<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
    <base href="<%=basePath%>">
    	<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff 
}
</STYLE>
<SCRIPT language=javascript>
		//删除
		function del(id,endurl)
		{
		var t=new Date();
		var url="delCDNSetMealAction.do?t="+t;
		     if(confirm("你确定要删除该数据吗？"))
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href=endurl;
		             }else
		             {
		             	alert("删除失败");
		             }
		        }
		       );
		     }
		}
		function delShangPing(id)
		{
			var t=new Date();
			var url="goUpdate1CDNSetMealAction.do?t="+t;
			     if(confirm("你确定要强制结束该套餐吗？"))
			     {
			         $.post(url,{
			           id:id
			        },function(data)
			        {
			            if(data==1)
			             {
			                 alert("结束成功");
			                 window.location.href="getAllCDNSetMealAction.do";
			             }else
			             {
			             	alert("结束失败");
			             }
			        }
			       );
			     }

			}
		/*字段查找*/
		function showInput(obj){

		  var v = $("#"+obj.id).find("input,select").get(0); 
		    var inputid = v.id;
		    $("#"+inputid).css("display","");
		
		}
		
		function displayIput(obj){
		  var v = $("#"+obj.id).find("input,select").get(0); 
		    var inputid = v.id;
		    var vals = $("#selecttage").val();
		    if(vals != '1'){
		    $("#"+inputid).css("display","none");
		    }
		}
		
		function selectSetMeal(pageNo){
			$("#form1 select").css("display","none");
			   
			var formdata = $("#form1").serialize();
			formdata = encodeURI(formdata);
			 $.ajax({
				  type: "POST",
				  url: "getAllCDNSetMealAction.do?tage=y&pageNo=" + pageNo,
				  data:formdata,
				  success: function(data){
					  var data1 = new Array();
					  data1 = data.split("#");
						$("#infotable").html(data1[0]);
						$("#page").html(data1[1]);
					  }
				 });
			//$("#selecttage1").attr("value","0");
		}
		
		//
		function chselect()
		{
		 var vals = $("#selecttage").val();
		 if(vals=='1' ){
		  $("#selecttage").attr("value","0");
		 }else{
		     $("#selecttage").attr("value","1");
		     }
		}
</SCRIPT>
    <title>套餐列表</title>
  </head>
  <BODY>
	<FORM name=form2 action="getAllCDNSetMealAction.do" method="post">							
        <TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="30%">
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
							<a href="goAddCDNSetMealAction.do">新增套餐</a>
						</TD>
						<TD align=right width="70%">
							套餐名：
							<INPUT type="text" id="mealName" name="mealName"/>
							<INPUT class=button type=submit  value=" 查询 "/>
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed border=0>
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
										&nbsp;套餐列表
										<input type="hidden" id="selecttage" value="0">
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
						<form action="" id="form1" name="form1" method="post">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>
									<TR align="center">
										<TD id="tid" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											套餐编号<br/>
											<input id="id" name="id" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="tname" width="8%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											套餐名<br/>
											<input id="name" name="name" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="trealmtypename" width="8%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											域类型<br/>
											<input id="realmtypename" name="realmtype.name" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="tstarttime" width="8%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											活动开始时间<br/>
											<input id="starttime" name="starttime" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="tendtime" width="8%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											活动结束时间<br/>
											<input id="endtime" name="endtime" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="tusetime" width="8%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											套餐使用时长<br/>
											<input id="usetime" name="usetime" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="tchargeType" width="8%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											收费类型<br/>
											<select id="chargeType" name="chargeType" onclick="chselect();" onchange="selectSetMeal(1)" style="display:none">
												<option value="">全部</option>
												<option value="0">免费</option>
												<option value="1">赠送</option>
												<option value="2">收费中预付</option>
												<option value="3">后付</option>
											</select>
										</TD>
										<TD id="tprice" width="8%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											原价<br/>
											<input id="price" name="price" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD id="tpayprice" width="8%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											实际价格<br/>
											<input id="payprice" name="payprice" style="display: none" onkeyup="selectSetMeal(1)"/>
										</TD>
										<TD width="8%" align="center">
											修改
										</TD>
										<TD width="8%" align="center">
											删除
										</TD>
										<TD width="10%" align="center">
											查看详细
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							</form>
							<table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<tbody>
									<!--循环-->
									<c:if test="${empty pages.pageList}"><tr><td align="center" class=category>没有查找到套餐</td></tr></c:if>
									<c:if test="${!empty pages.pageList}">
									<c:forEach items="${pages.pageList}" var="data"  varStatus="num">
										<TR align="center">
											<TD width="10%" class=category>
												${data.id }
											</TD>
											<TD width="8%" class=category>
											<c:if test="${markstart[num.index]==0}">
											<a href="goInfoCDNSetMealAction.do?id=${data.id }" target=right title="活动没有开始"> <font style="color: #FF8040">${data.name }</font></a>
											
											</c:if>
												
												<c:if test="${markstart[num.index]==1}"><a href="goInfoCDNSetMealAction.do?id=${data.id }" target=right title="活动结束"> <font style="color: red;">${data.name }</font></a></c:if>
												<c:if test="${markstart[num.index]==2}"><a href="goInfoCDNSetMealAction.do?id=${data.id }" target=right title="活动进行中"> <font style="color:#FF00FF " >${data.name }</font></a></c:if>
												
											</TD>
											<TD width="8%" class=category>
												${data.realmtype.name }
											</TD>
											<TD width="8%" class=category>
												${data.starttime }
											</TD>
											<TD width="8%" align="center" class=category>
												${data.endtime }
											</TD>
											<TD width="8%" align="center" class=category>
												${date[num.index] }
											</TD>
												
											<TD width="8%" align="center" class=category>
												  <c:if test="${data.chargeType == '0'}">免费</c:if>
												  <c:if test="${data.chargeType == '1'}">赠送</c:if>
												  <c:if test="${data.chargeType == '2'}">收费中预付</c:if>
												  <c:if test="${data.chargeType == '3'}">后付</c:if>
											</TD>
											<TD width="8%" align="center" class=category>
												${data.price }
											</TD>
											<TD width="8%" align="center" class=category>
												${data.payprice }
											</TD>
									
											<TD width="8%" align="center">
											<c:if test="${markstart[num.index]==0}">
											<A href="goUpdateCDNSetMealAction.do?id=${data.id }" target=right>
													<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
												</a></c:if>
												
												<c:if test="${markstart[num.index]==1}">活动结束不能修改</c:if>
												<c:if test="${markstart[num.index]==2}">活动进行中不能修改</c:if>
												
												<input type="button" onclick="delShangPing(${data.id })" value="强制结束" />
											</TD>
											
											<TD width="8%" align=center>
											<c:if test="${markstart[num.index]==0||markstart[num.index]==1}">
											<a href="javascript:void();" onclick="return del(${data.id },'getAllCDNSetMealAction.do');">
													<img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 >
												</a></c:if>
												
												<c:if test="${markstart[num.index]==2}">活动进行中不能删除</c:if>
																						
												
											</TD>
											<TD width="10%" align=center>
												<a href="goInfoCDNSetMealAction.do?id=${data.id }" target=right> 查看详情</a>
											</TD>
										</TR>
									</c:forEach>
									</c:if>
									<!--循环结束-->
								</TBODY>
							</TABLE>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD id="page"><p:pages url="getAllCDNSetMealAction.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</html>
