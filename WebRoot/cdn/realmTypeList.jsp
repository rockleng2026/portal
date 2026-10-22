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
<SCRIPT language=javascript><!--
		//删除
		function del(id,endurl)
		{
		var t=new Date();
		var url="delCDNRealmTypeAction.do?t="+t;
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
		
		function selectRealmType(pageNo){
			$("#form1 select").css("display","none");
			   
			var formdata = $("#form1").serialize();
			formdata = encodeURI(formdata);
			 $.ajax({
				  type: "POST",
				  url: "getAllCDNRealmTypeAction.do?tage=y&pageNo=" + pageNo,
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
		
--></SCRIPT>
    <title>套餐域类型列表</title>
  </head>
  <BODY>
	<FORM name=form2 action="" method="post">							
        <TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="30%">
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
							<a href="goAddCDNRealmTypeAction.do">新增类型</a>
						</TD>
						<TD align=right width="70%">
							类型名：
							<INPUT type="text" id="typeName" name="typeName"/>
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
										&nbsp;域名类型列表
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
										<TD id="tid" width="15%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											类型编号<br/>
											<input id="id" name="id" style="display: none" onkeyup="selectRealmType(1)"/>
										</TD>
										<TD id="tname" width="15%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											类型名称<br/>
											<input id="name" name="name" style="display: none" onkeyup="selectRealmType(1)"/>
										</TD>
										<TD width="15%" align="center">
											修改
										</TD>
										<TD width="15%" align="center">
											删除
										</TD>
										<TD width="40%" align="center">
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							</form>
							<table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<tbody>
									<!--循环-->
									<c:if test="${empty pages.pageList}"><tr><td align="center" class=category>没有查找到域名类型</td></tr></c:if>
									<c:if test="${!empty pages.pageList}">
									<c:forEach items="${pages.pageList}" var="data" >
										<TR align="center">
											<TD width="15%" class=category>
												${data.id }
											</TD>
											<TD width="15%" class=category>
												${data.name }
											</TD>
											
									
											<TD width="15%" align="center">
												<A href="goUpdateCDNRealmTypeAction.do?id=${data.id }" target=right>
													<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
												</a>
											</TD>
											
											<TD width="15%" align=center>											
												<a href="javascript:void();" onclick="return del(${data.id },'getAllCDNRealmTypeAction.do');">
													<img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 >
												</a>
											</TD>
											<TD width="40%" align="center">
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
					<TD id="page"><p:pages url="getAllCDNRealmTypeAction.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</html>
