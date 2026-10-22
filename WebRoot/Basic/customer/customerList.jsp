<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdiv.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

<script type="text/javascript">
    //新增保存按钮,点击保存,把id写到订单和任务的中间表里去
    function allChecked(form){
       form.action="<%=request.getContextPath()%>/selMarkBytemp2TaskProject.do";
       form.submit();
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
		<SCRIPT language=javascript>
		function del(id)
		{
		var t=new Date();
		var url="delCustomer.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="getpageCustomer.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}
		
		//更多功能菜单选项
		function morefunction(id)
		{	
			//添加跟进记录	
			 $("#addfollowup").attr('href', "<%=request.getContextPath()%>/Basic/customer/followup.jsp?customerId="+id);	 
			 //查看跟进记录
			 $("#seefollowup").attr('href', "<%=request.getContextPath()%>/getpageIntentFollowUp.do?customerId="+id);
			 //增加交接记录
//			 $("#addcustomerMove").attr('href', "<%=request.getContextPath()%>/Basic/customer/customerMove.jsp?customerId="+id);
			 $("#addcustomerMove").attr('href', "<%=request.getContextPath()%>/moveCustomer.do?customerId="+id);
			  //查看交接记录
			 $("#seecustomerMove").attr('href', "<%=request.getContextPath()%>/getpageCustomerMove.do?customerId="+id);
			  //增加交接记录
			 $("#addcustomerTryout").attr('href', "<%=request.getContextPath()%>/Basic/customer/customerTryout.jsp?customerId="+id);
			  //查看交接记录
			 $("#seecustomerTryout").attr('href', "<%=request.getContextPath()%>/getpageCustomerTryout.do?customerId="+id);
			 showDiv('functionDiv','');
		}
</SCRIPT>

	</HEAD>
	<BODY onload="showbc()">
		<SCRIPT>

		function CheckAll(form)  {
		  for (var i=0;i<form.elements.length;i++)    {
		    var e = form.elements[i];
		    if (e.name != 'chkall'){
		      e.checked = form.chkall.checked;
		    
		    } 
		   }
		  }
		 function check(){	
		 	var o= document.form1.elements["ids"] 
		 	var isOk=false; 
			for(i=0;i<o.length;i++) 
			{
				if(o[i].checked)
				{ 
					isOk=true;
					break;
				}
			} 
			if(!isOk)
			{
				alert("请选择要删除的员工记录");
			}
			
		 	return isOk;
		}
		//字段查找
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

		function selectcustomer(pageNo){
			$("#form1 select").css("display","none");
			   
			var formdata = $("#form1").serialize();
			formdata = encodeURI(formdata);
			 $.ajax({
				  type: "POST",
				  url: "getpageCustomer.do?type2=1&tage=y",
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
function  subclick(){
  	 var event=arguments.callee.caller.arguments[0]||window.event;
  	 //alert(event.keyCode);
  	 if (event.keyCode == 13) {
  	 	selectisno();
  	 } 
}
		function selectisno()
		{
			var temp=document.getElementById("temp").value;
			var test=document.getElementById("test").value;
			if(temp==0)
			{
				alert("请选择查询条件！！！");
				return false;
			}
			if(test==""||test==null)
			{
				alert("请输入查询类容！！！");
				return false;
			}
			var reg = /^\d+$/g;//匹配数字
			var url="selectisnoCustomer.do";
			
			$.post(url,{temp:temp,test:test},function(data){
				if(data==0)
				{
					alert("此用户存在！！！");
				}
				else
				{
					alert("此用户不存在！！！");
				}
			});
			
		}
		
</SCRIPT>
		<FORM name='form1' action="" id="form1" method="get" >
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath()%>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							<SELECT id="temp" value="this.value">
								<option value="0">请选择查询的条件</option>
								<option value="qq">QQ</option>
								<option value="phone">电话</option>
								<option value="mobilePhone">手机</option>
							</SELECT>
							<input id="test" name="test" type="text" value="" onkeydown="subclick()"/>
							<input id="xx" name="xx" type="hidden" value=""/>
							<input id="" name="" value="查询" type="button" onclick="selectisno()" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" name="seach" value="筛选查询"  onclick="showDiv('filterDiv','')">
							&nbsp;
						</TD>
						
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;客户信息查询
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
						<input type="hidden" name="method" value="delEmployees">
							<FORM id="form1" name="form1" action="getpageCustomer.do?type2=1" onsubmit="return check()">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>
									<TR align="center">
									    <TD width="5%" height=30 class=category>
											选择
										</TD>
										<TD id="tcustomerId" width="13%" height=30 class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											编号<br/>
											<input id="customerId" name="customerId" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="trealName" width="12%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											客户姓名<br/>
											<input id="realName" name="realName" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tcustomerType" width="9%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											租用类型<br/>
											<input id="customerType" name="customerType" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<!-- 客户类型2 -->
										<td id="tcustomerType2" width="9%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
										           客户类型<br/>
										    <input id="customerType2" name="customerType2" style="display:  none" onkeyup="selectcustomer(1)" />
										</td>
										<TD id="temployee" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											负责人<br/>
											<input id="employee" name="employee.name" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tphone" width="12%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											客户电话<br/>
											<input id="phone" name="phone" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tqq" width="8%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											客户QQ<br/>
											<input id="qq" name="qq" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tqq" width="8%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											创建日期<br/>
											<input id="qq" name="qq" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tcustomerCompany" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											客户公司名称<br/>
											<input id="customerCompany" name="customerCompany" style="display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="5%" class=category>
													修改
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="5%" class=category>
													删除
												</TD>
											</c:if>
											<c:if test="${map.key==4}">-
												<TD width="8%" class=category>
													更多操作
												</TD>
											</c:if>
										</c:forEach>
										<input type="hidden" id="marker2" name="marker2" value="${marker }" />
						                <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>
									</TBODY>
									</table>
									<!--循环-->
									<table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
									<tbody align="center">
								
									<c:forEach items="${pages.pageList}" var="data">
											<TR>
											     <TD align=center>
											<input type="checkbox" id="ids" name="ids" value="${data.customerId}"/>
										</TD>
												<TD width="13%"  class=category align=middle height=25>
													${data.customerId}
												</TD>
												<TD width="12%" align=middle>
													${data.realName}
												</TD>
												<TD width="9%" align=middle>
													${data.customerType}
												</TD>
												
												
												<c:if test="${data.customerType2==3}">
												<td width="9%" align=middle>
												        正式客户
												</td>
												</c:if>
												
												
												<td></td>
												<TD width="10%" align=middle>
													${data.employee.name}
												</TD>
												<TD width="12%" align=middle>
													${data.phone}
												</TD>
												<TD width="8%" align=middle>
													${data.qq}
												</TD>
												<TD width="8%" align=middle>
													${data.date}
												</TD>
												<TD width="10%" align=middle>
													${data.customerCompany}
												</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="8%" align=middle>
													<a href="getCustomer.do?id=${data.customerId}" target=right><IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath()%>/images/res.gif" align=absMiddle border=0> </a>
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="5%" align=middle>
													<a href="javascript:void();" onclick="return del(${data.customerId});"><img src="<%=request.getContextPath()%>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</TD>
											</c:if>
											<c:if test="${map.key==4}">
												<TD width="5%" align=middle>
													<a href="javascript:morefunction('${data.customerId}');" >更多</a>
												</TD>
											</c:if>
											<td ></td>
										</c:forEach>
											</TR>
										</c:forEach>				
											<TR >
											<td colspan="9"></td>
											</tr>
									<!--循环结束-->
									<tr>
									  <td colspan="12" align="right">
									 <INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
										<input type="button" id="bc" value="保存" onclick="allChecked(this.form),closeWindeows(0)" /> 
									</td>
									</tr>
								</TBODY>
							</TABLE>
						</FORM>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
					</TD>
					<TD id="page"><p:pages url="getpageCustomer.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
<!--更多功能层 -->		
<div id="functionDiv" style="display:none; 200px;height: 150px;position:absolute; top:50%; left:0%;margin:60px;">		
   	<table id="search_table" width="100%"  border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC" >  
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right"> 功能层操作:</td>
		<td align="right"><a href="javascript:hideDiv('functionDiv','')">关闭</a></td> 
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户跟进:</td>
		<td><a id="addfollowup">增加跟进记录</a>
		&nbsp;&nbsp;&nbsp;<a id="seefollowup">查看跟进记录</a>
		</td> 
  	</tr>
  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户交接:</td>
		<td><a id="addcustomerMove">增加交接记录</a>
		&nbsp;&nbsp;&nbsp;<a id="seecustomerMove">查看交接记录</a></td>
  	</tr>
  	<tr height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户试用:</td>
		<td><a id="addcustomerTryout">增加试用记录</a>
		&nbsp;&nbsp;&nbsp;<a id="seecustomerTryout">查看试用记录</a></td>
  	</tr>
</table> 
</div> 
<div id="filterDiv" class="myDIV" style="display:none; 200px;height: 150px;background-color:gray;position:absolute; top:50%; left:0%;margin:60px;">		
<form id="filterform" name="filterform" method="post" action="getpageCustomer.do">
   	<table id="search_table" width="100%"  border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC" >
  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户主键编号:</td>
		<td>
	    <input type="text" name="customerId" id="customerId"/>
	    </td>
  	</tr>
  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户类型:</td>
						<td>
							<select name="customerType" id="customerType"
								value="${data.customerType}">
								<option value="租用">
									租用
								</option>
								<option value="托管">
									托管
								</option>
								<option value="百独">
									百独
								</option>
								<option value="百共">
									百共
								</option>
							</select>
						</td>		
					</tr>
					<tr height="20" bgcolor="#FFFFFF">
					  <td align="right">客户类型:</td>
					  <td>
					    <select name="customerType2" value="${data.customerType2}">
					      <option value="1">意向客户</option>
					      <option value="2">试用客户</option>
					      <option value="3">正式客户</option>
					      <option value="4">审核客户</option>
					    </select>
					  </td>
					</tr>
  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户名称:</td>
		<td><input type="text"  name="name" id="name"/></td>
  	</tr>
  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户公司:</td>
		<td><input type="text"  name="company" id="company"/></td>
  	</tr>
  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"> 客户建立时间:</td>
		<td>
		早于：<input type="text" id="timeb" onfocus="WdatePicker()">
		晚于：<input type="text" id="timee" onfocus="WdatePicker()">
		</td>
  	</tr>
	  	<tr  height="20" bgcolor="#FFFFFF">
		<td align="right"><input type="submit" name="add" value="筛选" /></td>
		<td align="left"><input type="button" name="exit" value="取消" onclick="hideDiv('filterDiv','')"/></td>
  	</tr>
</table> 
</form>
</div> 
	</BODY>
</HTML>
