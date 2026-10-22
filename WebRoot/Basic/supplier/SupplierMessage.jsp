<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>供应商列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
    //新增保存按钮,点击保存,把id写到订单和任务的中间表里去
    function allChecked(){
       form1.action="<%=request.getContextPath()%>/selMarkBytemp2TaskProject.do";
       form1.submit();
    }
    
    
    //保存按钮的显示和隐藏
		function showbc(){
		  var marker2 = $("#marker2").val();
		  var taskid = $("#taskid").val();
		  if(marker2.length>0 && marker2!="" && taskid!=""){
		     document.getElementById("bc").style.display='block';
		  }else{
		     document.getElementById("bc").style.display='none';
		  }
		}
</script>

		<script type="text/javascript">
		
		function del(id)
		{
		var t=new Date();
		var url="delsupplierr.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="selectsupplierr.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}
		
		
		function orderby(obj)
		{
			var tag = $("#bl").val();
			if(null != tag && tag!= '' && tag == obj.id)
			{
			$("#"+obj.id).attr("href",obj.href.substring(0,obj.href.indexOf("?")));
			}
		}
		
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
		
		function selectsupplierr(pageNo){
			$("#form1 select").css("display","none");
			   
			var formdata = $("#form1").serialize();
			formdata = encodeURI(formdata);
			 $.ajax({
				  type: "POST",
				  url: "selectsupplierr.do?tage=y",
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
<body onload="showbc()">
		<FORM name=form2 action="selectsupplierr.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
						</TD>
						<TD align=right width="95%">
							供应商名称：
							<INPUT name="name" id="name">
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<FORM id="form1" name="form1" action="selectsupplierr.do" onsubmit="return check()">
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
										&nbsp;供应商记录查询
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
						<!--startprint-->
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>
									<TR align="center">
									     <TD width="5%" height=30 class=category>
											选择
										</TD>
										<TD id="tid" width="13%" height=30 class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											编号<br/>
											<input id="id" name="id" style="display: none" onkeyup="selectsupplierr(1)"/>
											<input id="bl" type="hidden" value="${tag }">
										</TD>
										<TD id="tsupplierCompany" width="12%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											公司名称<br/>
											<input id="supplierCompany" name="supplierCompany" style="display: none" onkeyup="selectsupplierr(1)"/>
										</TD>
										<TD id="tsupplierAddress" width="9%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											公司地址<br/>
											<input id="supplierAddress" name="supplierAddress" style="display: none" onkeyup="selectsupplierr(1)"/>
										</TD>
										<TD id="tsupplierOrigin" width="21%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											供应商来源<br/>
											<input id="supplierOrigin" name="supplierOrigin" style="display: none" onkeyup="selectsupplierr(1)"/>
										</TD>
										<TD id="tsupplierName" width="12%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											供应商负责人<br/>
											<input id="supplierName" name="supplierName" style="display: none" onkeyup="selectsupplierr(1)"/>
										</TD>
										<TD id="tdate" width="18%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											<a id="sdate" href="selectsupplierr.do?order=date" onclick="orderby(this);">建立日期</a><br/>
											<input id="date" name="date" style="display: none" onkeyup="selectsupplierr(1)"/>
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="8%" class=category>
													修改
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="8%" class=category>
													删除
												</TD>
											</c:if>
										</c:forEach>
										<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							        <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>
									</tbody>
								</TABLE>
									<!--循环-->
								<table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
									<tbody>
									
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
											<TD align=center>
											<input type="checkbox" id="ids" name="ids" value="${data.id}"/>
										</TD>
												<TD align=center height=25 width="13%">
													<a href="updatePagesupplierr.do?trim=info&id=${data.id }">详细信息</a> &nbsp;&nbsp;&nbsp;&nbsp; ${data.id}
												</TD>
												<TD align=center width="12%">
													${data.supplierCompany}
												</TD>
												<TD align=center width="9%">
													${data.supplierAddress}
												</TD>
												<TD align=center width="21%">
													${data.supplierOrigin}
												</TD>
												<TD align=center width="12%">
													${data.supplierName}
												</TD>
												<TD align=center width="18%">
													${data.date}
												</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="8%" align=center>
													<A href="updatePagesupplierr.do?id=${data.id }" target=right><IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0></A>
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="8%" align=center>
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</TD>
											</c:if>
										</c:forEach>
											</TR>
										</c:forEach>
									<!--循环结束-->
									<tr>
									  <td colspan="12" align="right">
									 <INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
										<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" /> 
									</td>
									</tr>
								<!--<tr>
								<td class=category colSpan=14 height=30>
										 <p:pages url="selectsupplierr.do"/>
									</td>
									</tr>
									-->
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
					<TD id="page"> <p:pages url="selectsupplierr.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</FORM>
	</BODY>
</HTML>