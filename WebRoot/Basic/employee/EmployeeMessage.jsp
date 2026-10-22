<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>    
		<title>Insert title here</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
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
function chselect()
{
 var vals = $("#selecttage").val();
 //var vals1 = $("#selecttage1").val();
 if(vals=='1' ){
  $("#selecttage").attr("value","0");
 }else{
     $("#selecttage").attr("value","1");
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
    //alert(vals);
    if(vals != '1'){
    $("#"+inputid).css("display","none");
    }
}

function selectemp(pageNo){
//alert(pageNo);
$("#form1 select").css("display","none");
   
var formdata = $("#form1").serialize();
//alert(formdata);
formdata = encodeURI(formdata);
 $.ajax({
	  type: "POST",
	  url: "selectemp.do?tage=s&pageNo="+pageNo,
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


function showborder(obj){			
	var v = obj.id;
	var content=$("#"+v).text();		
	$("#"+v).find(":eq(0)").hide();
	$("#"+v).find(":eq(1)").show();
}
function hideborder(obj){			
	var v = obj.id;
	var content=$("#"+v).text();		
	$("#"+v).find(":eq(1)").hide();
	$("#"+v).find(":eq(0)").show();
}
function showbutton(obj){
	var up=document.getElementsByName("update");
	for(var i=0;i<up.length;i++){
		var b=up[i].value;
		up[i].style.display="none";
	}
	var v=obj.name;
	$("#"+v).show();
	var vid=obj.id;
	var dd=$(":input[name='"+v+"']").val();
}
// 显示离职操作
function showlz(obj){
	$("#ygqj").hide();
	var empid=obj.name;
	$("#leavereason").html("");
	$("#leavetime").val("");
	$("#empid").val(empid);
	$("#yglz").show();
}
//显示请假操作
function showqj(obj){
	var empname=obj.name;
	var empid=obj.id;
    $("#empname").val(empname);
    $("#qjempid").val(empid);
	$("#yglz").hide();
	$("#ygqj").show();
}
// 关闭离职操作
function closlz(){
	// 清空所有
	$("#ygqj td input").val("");
	$("#content").html("");
	$("#qjclos").val("关闭");
	$("#qjtj").val("提交");
	$("#yglz").hide();
	$("#ygqj").hide();
}
// 离职原因提交
function tj(){
	var empid= $("#empid").val();
	var leavereason=$("#leavereason").html();
	var leavetime=$("#leavetime").val();	
	window.location.href="<%=request.getContextPath()%>/leaveemp.do?empid="+empid+"&leavereason="+leavereason+"&leavetime="+leavetime;
}
//请假单提交
function qj(){	
	var begintime= $("#begintime").val();
	if(begintime.length<=0){
		alert("请选择请假开始时间！");
		return false;
	}
	var endtime= $("#endtime").val();
	if(endtime.length<=0){
		alert("请选择请假结束时间！");
		return false;
	}
	var content= $("#content").html();
	if(content.length<=0){
		alert("请填明请假原因！");
		return false;
	}
	var superson= $("#superson").val();
	if(superson.length<=0){
		alert("请征求主管签字同意！");
		return false;
	}
	var manager= $("#manager").val();
	if(manager.length<=0){
		alert("请征求经理签字同意！");
		return false;
	}
	var admin= $("#admin").val();
	if(admin.length<=0){
		alert("请征求行政签字同意！");
		return false;
	}
}

</script>
<script type="text/javascript">
   function selectf(){
     var  values= $('#ename').val();
   $('#ename2').attr('value',values);
   }


 $(function(){
  $.post('selectfemp.do',function(data){
      $('#ename').attr('value',data);
      $('#ename2').attr('value',data);
  
  });
  });



</script>




</HEAD>
<BODY onload="showbc()">
搜索条件：
		<FORM id="form2" name=form2 action="selectemp.do?funid=14&ss=321" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<TD align=right width="95%">
							员工姓名：
							<INPUT name="ename" id="ename"> 
							<input type="hidden" name="ename2" id="ename2"/>
							
							
							<input type="hidden" id="selecttage" value="0">
							<INPUT class=button type=submit onclick="selectf()" value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		
		<FORM id="form1" name=form1 action="selectemp.do?funid=14" method="post">
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
										&nbsp;员工信息查询
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>                                    
									<TR align="center">
										<TD width="80" id="tdname" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											姓名<input id="name" name="name" style="display: none" onkeyup="selectemp(1)">
										</TD>
										<TD width="50" id="tdsex" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											性别<select id="sex" name="sex"  onclick="chselect();" onchange="selectemp(1)" style="display:none"><option value="">请选择</option><option value=2>女</option><option value=1>男</option></select>
										       
										</TD>
										<TD width="50" id="tdage" height=30 class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											<a href="selectemp.do?order=age">年龄</a><input id="age" width="50" name="age" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="90" id="tdbirth" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											生日<input width="90" id="birth" name="birth" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="100" id="tdtel" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											联系电话<input id="tel" name="tel" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="60" id="tdeducation" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											学历<input id="education" name="education" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="100" id="tddepartment" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											所属部门<input id="department"  name="department.name" style="display: none"  onkeyup="selectemp(1)" >
										</TD>
										<TD width="80" id="tdgroupName" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											职位<input id="groupName" name="groups.groupName" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="80" id="tdempNo" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											工号<input id="empNo" name="empNo" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="90" id="tdentryTime" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											入职时间<input id="entryTime" name="entryTime" style="display: none"  onkeyup="selectemp(1)">
										</TD>
										<TD width="70" id="tdisLeave" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											是否在职<select onclick="chselect();" onchange="selectemp(1)" id="isLeave" name="isLeave" style="display:none"><option value=''>请选择</option><option value='0'>离职</option><option value='1'>在职</option></select>
										</TD>
										<TD width="80" class=category >
											详细信息
										</TD>
										<TD width="60" class=category>
											修改|删除
										</TD>
										<TD width="60" class=category>
											离职
										</TD>
										<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							            <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>                                
                                    </table>
									<!--循环-->
                             <table id="infotable" class="toptable grid">
									<c:forEach items="${pages.pageList}" var="data" >
											<c:if test="${data.department.depNo!=111}">
											<TR>
												
												<TD align=center height=25>
													<span>${data.name}</span>												
												</TD>
												<TD align=center >
												    <c:if test="${data.sex==1}"><span>男</span></c:if>
													<c:if test="${data.sex==2}"><span>女</span></c:if>
												</TD>
												<TD align=center>
													${data.age}
												</TD>
												<TD align=center>
													<c:set var="birthDate" scope="request" value="${data.birth}"  />
													${data.birth}
												</TD>
												<TD align=center>
													${data.tel}
												</TD>
												<TD align=center>
													${data.education}
												</TD>
												<TD align=center>
													${data.department.name}
												</TD>
												<TD align=center>
													${data.groups.groupName}
												</TD>
												<TD align=center>
													${data.empNo}
												</TD>
												<TD align=center>
													${data.entryTime}
												</TD>
												<TD align=center>
													<c:if test="${data.isLeave==1}">在职</c:if>
													<c:if test="${data.isLeave==0}">离职</c:if>
												</TD>
												<TD align=center>
													<a href="detailemp.do?cid=${data.id}">详细信息</a>
												</TD>
												<TD align=center>
												<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==2}">
													<A
														href="showemp.do?id=${data.id}"
														target=right><IMG style="CURSOR: hand" 
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
													</a>
													</c:if>
													</c:forEach>
													<input type="hidden" id="abc" value="${data.id}">
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>    
												</TD>
												<TD align=center>
													<c:if test="${data.isLeave==1}">
													  <c:if test="${data.isqj!='1'}">
														<input type="button" id="${data.id}" name="${data.name}" onclick="showqj(this)"  style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; " value="请假">
													  </c:if>
													  <c:if test="${data.isqj=='1'}">
														<font style="font-weight: bold;" color="red">请假</font>
													  </c:if>
													<input type="button" id="lz" value="离职"  name="${data.id}" onclick="showlz(this)" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/> 
													</c:if>
													<c:if test="${data.isLeave==0}"><font style="font-weight: bold;" color="red">离职</font></c:if>
												</TD>
											</TR>
											</c:if>
											<c:if test="${emp.department.depNo ==111 && data.department.depNo == 111}">
											<TR>
												<TD align=center height=25  onmouseover="showborder(this)" onmouseout="hideborder(this)" id="${1+10}">
													<span>${data.name}</span>
													<input style="width:80%; display: none; background-color: #eef7fe" value="${data.name}" />
												</TD>
												<TD align=center  onmouseover="showborder(this)" onmouseout="hideborder(this)" id="${1+100}">
												    <c:if test="${data.sex==1}"><span>男</span></c:if>
													<c:if test="${data.sex==2}"><span>女</span></c:if>
												    <input style="width:80%; display: none; background-color: #eef7fe" value="(${data.sex==1}?'男':'女')" />
												</TD>
												<TD align=center>
													${data.age}
												</TD>
												<TD align=center>
													<c:set var="birthDate" scope="request" value="${data.birth}"  />
													${data.birth}
												</TD>
												<TD align=center>
													${data.tel}
												</TD>
												<TD align=center>
													${data.education}
												</TD>
												<TD align=center>
													${data.department.name}
												</TD>
												<TD align=center>
													${data.groups.groupName}
												</TD>
												<TD align=center>
													${data.empNo}
												</TD>
												<TD align=center>
													${data.entryTime}
												</TD>
												<TD align=center>
													<c:if test="${data.isLeave==1}">在职</c:if>
													<c:if test="${data.isLeave==0}">离职</c:if>
												</TD>
												<TD align=center>
													<a href="detailemp.do?cid=${data.id}">详细信息</a>
												</TD>
												<TD align=center>
													<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==2}">
													<A
														href="showemp.do?id=${data.id}"
														target=right><IMG style="CURSOR: hand" 
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
													</a>
													</c:if>
													</c:forEach>
														<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>											
												</TD>
												<TD align=center>
													<c:if test="${data.isLeave==1}">
														<input type="button" id="lz" name="${data.id}" onclick="showlz(this)" value="离职" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/> 
													</c:if>
													<c:if test="${data.isLeave==0}"><font style="font-weight: bold;" color="red">离职</font></c:if>
												</TD>
											</TR>
											</c:if>
											</c:forEach>
											</table>
											<table>
											<TR>
											</tr>
									<!--循环结束-->
                                 <tr>
									<TD class=category colSpan=14 height=30>
										<TABLE cellSpacing=0 cellPadding=0 width="100%">
											<TBODY>
												<TR>
													<TD style="COLOR: #ff0000" align=left width="10%">
														&nbsp;
													</TD>
													<TD align=right width="80%">
												
														<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
														<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
														<INPUT name="delbut" type=button class=button
															onclick="del('delemp.do','selectemp.do')"
															value="删 除">
															</c:if>
															</c:forEach>
													</TD>
												</TR>
											</TBODY>
										</TABLE>
									</TD>
								</tr>
							</TABLE>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD id="page"><p:pages url="selectemp.do?deptid=all&funid=14" /></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</FORM>
	
	<!-- 员工离职 -->
	<div id="yglz" style="display:none;">
		<div id="fd" style="filter:alpha(opacity=100);opacity:1;float: right;" >
        <div class="contentup" style="width: 500px;">        
        <TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed 
				border=0>
				<TBODY>
					<TR>
						<th align="center" width="100%">员工离职</th>
					</TR>
					<tr>
					   <td>
					     <table  class="toptable grid" cellSpacing=1 cellPadding=4 width="500px;"
								align=center border=1>
							 <tr>
							     <td align="right" width="30%">离职时间：</td>
							     <td align="left" width="70%"  class=category>
							         <input type="text" name="leavetime" id="leavetime" onclick="WdatePicker()" />
							         <input type="hidden" name="empid" id="empid" value="" />
							     </td>
							 </tr>
							 <tr>
							     <td align="right" width="30%">离职原因：</td>
							     <td align="left" width="70%" class=category>
					                <textarea rows="7" cols="40" name="leavereason" id="leavereason"></textarea>
					             </td>
							 </tr>
						</table>  
					   </td>
					</tr>					
					 <tr>
					    <td width="100%" align="center">
					       <input type="button" id="clos" value="关闭"  onclick="closlz()" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/>
					       <input type="button" id="tj" value="提交" onclick="tj()" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/>
					    </td>
					 </tr>
				</TBODY>
		</TABLE>
		</div></div>
	</div>
	
	<!-- 员工请假 -->
	<div id="ygqj" style="display:none;">
		<div id="fd" style="filter:alpha(opacity=100);opacity:1;float: right;" >
        <div class="contentup" style="width: 580px;">   
        <form action="<%=request.getContextPath()%>/addLeaveemp.do" method="post" onsubmit="return qj();"> 
        <TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed 
				border=0>
				<TBODY>
					<TR>
						<th align="center" width="100%">员工请假单</th>
					</TR>
					<tr>
					   <td>
					     <table  class="toptable grid" cellSpacing=1 cellPadding=4 width="500px;"
								align=center border=1>
							 <tr>
							     <td align="right" width="25%">请假人：</td>
							     <td align="left" width="75%"  class=category>
							        <input type="text" size="10" id="empname" value="" readonly="readonly">
							        <input type="hidden" size="10" id="qjempid" name="leavesimple.empid" value="">
							     </td>
							 </tr>
							 <tr>
							     <td align="right" width="30%">请假类型：</td>
							     <td align="left" width="70%" colspan="3"  class=category>
							        <select name="leavesimple.leavetype">
							           <option value="0">休假(假)</option>
							           <option value="1">病假</option>
							           <option value="2">事假</option>
							           <option value="3">其他</option> 
							        </select>
							     </td>
							 </tr>
							 <tr>
							     <td align="right" width="30%">请假时间：</td>
							     <td align="left" width="70%"  class=category  colspan="3" >
							                         自<input type="text" name="leavesimple.begintime" id="begintime" value=""  onclick="WdatePicker()" size="15" />
							                         到<input type="text" name="leavesimple.endtime" id="endtime" value=""  onclick="WdatePicker()" size="15" />
							                         总共请假<input type="text" name="" size="2" value="" style="height: 15px;" />天
							     </td>
							 </tr>
							 <tr>
							     <td align="right" width="30%">请假理由：</td>
							     <td align="left" width="70%"  class=category  colspan="3">
							         <textarea rows="4" cols="60" name="leavesimple.content" id="content"></textarea>
							     </td>
							 </tr>
							 <tr>
							     <td align="center" width="10%"  class=category colspan="4">
							                        主管签字：<input type="text" size="10" name="leavesimple.superson" id="superson" value="">
							                        经理签字：<input type="text" size="10" name="leavesimple.manager" id="manager" value="">
							                        行政签字：<input type="text" size="10" name="leavesimple.admin" id="admin" value="">
							     </td>
							 </tr>
						</table>  
					   </td>
					</tr>					
					 <tr>
					    <td width="100%" align="center">
					       <input type="button" id="qjclos" value="关闭"  onclick="closlz()" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/>
					       <input type="submit" id="qjtj" value="提交" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/>
					    </td>
					 </tr>
				</TBODY>
		</TABLE>
		</form>
		</div></div>
	</div>
	
	
<p><style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
a{color:#5e5e5e;text-decoration:none;}
a:hover{color:#3366cc;text-decoration:underline;}
/* box */
.box{position:absolute;width:468px;left:50%;height:auto;z-index:100;background-color:#fff;border:1px #8FA4F5 solid;padding:1px;}
.box h2{height:25px;font-size:14px;background-color:#3366cc;position:relative;padding-left:10px;line-height:25px;color:#fff;}
.box h2 a{position:absolute;right:5px;font-size:12px;color:#fff;}
.box .mainlist{padding:10px;}
.box .mainlist li{height:24px;line-height:24px;}
.box .mainlist li span{margin:0 5px 0 0;font-family:"宋体";font-size:12px;font-weight:400;color:#ddd;}
#TB_overlayBG{background-color:#666;position:absolute;z-index:99;left:0;top:0;display:none;width:100%;height:100%;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
</style></p>
<div id="TB_overlayBG">&nbsp;</div>
<div style="display:none" class="box">
<h2>业务添加<a class="close" href="javascript:guanbi()">关闭</a></h2>
<div class="mainlist" id="postionDiv">

</div>
<div>
</div>
</div>

	
	    <script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
</BODY>
<script type="text/javascript">
		function del(id,endurl)
		{
		var t=(new Date()).getTime();
		var url="delMalfunctionDeclare.do?t="+t;
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
		             alert("删除失败")
		             }
		        }
		        );
		     }
		}
		function guanbi(){
		$("#TB_overlayBG").css("display","none");
		$(".box ").css("display","none");
		}
		
		function addOperationDepart(empid){
		   // alert(2);
			var tt = (new Date()).getTime();
		    var url = "addOperationemp.do?empid="+empid+"&tt="+tt;
			$("#postionDiv").load(url);
			$("#TB_overlayBG").css({display:"block",height:$(document).height()});
		    $(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		   });
		}
</script>
</HTML>
