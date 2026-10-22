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
		
		function del(id,endurl)
		{
		var t=new Date();
		var url="delCDNSetMealPropertyAction.do?t="+t;
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
		
		function selectSetMealProperty(pageNo){
			$("#form1 select").css("display","none");
			   
			var formdata = $("#form1").serialize();
			formdata = encodeURI(formdata);
			 $.ajax({
				  type: "POST",
				  url: "getAllCDNSetMealPropertyAction.do?tage=y&pageNo=" + pageNo,
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
</SCRIPT>
    <title>套餐属性列表</title>
  </head>
  <BODY>
	<FORM name=form2 action="getAllCDNSetMealPropertyAction.do" method="post">							
        <TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="30%">
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
							<a href="goAddCDNSetMealPropertyAction.do">新增商品属性</a>
						</TD>
						<TD align=right width="70%">
							商品名称名：
							<INPUT type="text" id="propertyName" name="propertyName"/>
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
										&nbsp;商品属性列表
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
									<!-- onmouseover="showInput(this)" onMouseOut="displayIput(this)" -->
										<TD id="tid" width="5%" class=category >
											商品编号<br/>
											<input id="id" name="id" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tname" width="6%" class=category >
											商品名称<br/>
											<input id="name" name="name" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tflow" width="5%" class=category >
											带宽<br/>
											<input id="flow" name="flow" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tbandwidth" width="5%" class=category >
											单价<br/>
											<input id="bandwidth" name="bandwidth" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="thitnum" width="6%" align="center" class=category >
											原价<br/>
											<input id="hitnum" name="hitnum" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tflow1" width="5%" align="center" class=category >
											优惠价<br/>
											<input id="flow1" name="flow1" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<!-- 
										<TD id="tflow2" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											流量-类别2<br/>
											<input id="flow2" name="flow2" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tflow3" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											流量-类别3<br/>
											<input id="flow3" name="flow3" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tflow4" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											流量-类别4<br/>
											<input id="flow4" name="flow4" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tbandwidth1" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											带宽-类别1<br/>
											<input id="bandwidth1" name="bandwidth1" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tbandwidth2" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											带宽-类别2<br/>
											<input id="bandwidth2" name="bandwidth2" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tbandwidth3" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											带宽-类别3<br/>
											<input id="bandwidth3" name="bandwidth3" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="tbandwidth4" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											带宽-类别4<br/>
											<input id="bandwidth4" name="bandwidth4" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="thitnum1" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											hit连接数-类别1<br/>
											<input id="hitnum1" name="hitnum1" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="thitnum2" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											hit连接数-类别2<br/>
											<input id="hitnum2" name="hitnum2" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="thitnum3" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											hit连接数-类别3<br/>
											<input id="hitnum3" name="hitnum3" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										<TD id="thitnum4" width="5%" align="center" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											hit连接数-类别4<br/>
											<input id="hitnum4" name="hitnum4" style="display: none" onkeyup="selectSetMealProperty(1)"/>
										</TD>
										 -->
										<TD width="4%" align="center">
											修改
										</TD>
										<TD width="4%" align="center">
											删除
										</TD>
										<TD width="5%" align="center">
											查看详细
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							</form>
							<table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<tbody>
									<!--循环-->
									<c:if test="${empty pages.pageList}"><tr><td align="center" class=category>没有查找到套餐属性</td></tr></c:if>
									<c:if test="${!empty pages.pageList}">
									<c:forEach items="${pages.pageList}" var="data" >
										<TR align="center">
											<TD width="5%" class=category>
											${data.id }
										</TD>
										<TD width="6%" class=category>
											<a href="dealCDNSetMealPropertyAction.do?id=${data.id }&type=info" target=right> ${data.name }</a>
										</TD>
										<TD width="5%" class=category>
											${data.flow } <font color="red"> G</font>
										</TD>
										<TD width="5%" class=category>
											${data.bandwidth } <font color="red"> G/元</font>
										</TD>
										<TD width="6%" align="center" class=category>
											${data.hitnum } <font color="red"> 元</font>
										</TD>
										<TD width="5%" align="center" class=category>
											${data.flow1 } <font color="red"> 元</font>
										</TD>
										<!-- 
										<TD width="5%" align="center" class=category>
											${data.flow2 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.flow3 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.flow4 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.bandwidth1 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.bandwidth2 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.bandwidth3 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.bandwidth4 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.hitnum1 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.hitnum2 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.hitnum3 }
										</TD>
										<TD width="5%" align="center" class=category>
											${data.hitnum4 }
										</TD>
										 -->
										<TD width="4%" align="center">
											<A href="dealCDNSetMealPropertyAction.do?id=${data.id }&type=update" target=right>
												<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
											</a>
										</TD>
										
										<TD width="4%" align=center>											
											<a href="javascript:void();" onclick="return del(${data.id },'getAllCDNSetMealPropertyAction.do');">
												<img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 >
											</a>
										</TD>
										<TD width="5%" align=center>
											<a href="dealCDNSetMealPropertyAction.do?id=${data.id }&type=info" target=right> 查看详情</a>
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
					<TD id="page"><p:pages url="getAllCDNSetMealPropertyAction.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</html>
