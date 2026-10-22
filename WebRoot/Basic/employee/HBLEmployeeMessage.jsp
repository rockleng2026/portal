<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>    
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
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
function showPage(dc){
     $("#dc").val(dc);
     var name=encodeURI($("#name").val(),"utf-8");
     var xl=encodeURI($("#education").val(),"utf-8");
     $("#ename").val(name);
     $("#xl").val(xl);
	 form2.action="<%=request.getContextPath()%>/select2emp.do";
	 form2.submit();
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
</HEAD>
<BODY onload="showbc()">
		<FORM id="form2" name=form2 action="" method="post">
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						员工姓名：
					</th>
					<TD>
						<INPUT type="text" id="name" value="${emp.name }">
						<input type="hidden"  name="emp.name" id="ename" value="" />
						<input type="hidden" name="emp.education" id="xl"> 
					</TD>
					<th>
					        所属部门：
					</th>
					<td>
					   <select id="dept" name="emp.department.id">
					      <option value="-1">--请选择--</option>
					      <c:forEach items="${deptlist}" var="dept">
					          <option value="${dept.id }" <c:if test="${emp.department.id==dept.id}">selected</c:if>>${dept.name }</option>   
					      </c:forEach>
					   </select>
					</td>
				   <th>工号：</th>
				   <td>
				      <input type="text" name="emp.empNo" value="${emp.empNo }" />
				   </td>
				</tr>
				<tr>
				  <th>
					        性别：
					</th>
					<td>
					   <select id="sex" name="emp.sex">
					       <option value="-1">--请选择--</option>
					       <option value="1" <c:if test="${emp.sex==1}">selected</c:if> >男</option>
					       <option value="2" <c:if test="${emp.sex==2}">selected</c:if>>女</option>
					   </select>
					</td>
					<th>
					       学历：
					</th>
					<td>
					   <select id="education">
					       <option value="-1">--请选择--</option>
					       <option value="初中" <c:if test="${emp.education=='初中'}">selected</c:if>>初中</option>
					       <option value="高中" <c:if test="${emp.education=='高中'}">selected</c:if>>高中</option>
					       <option value="大专" <c:if test="${emp.education=='大专'}">selected</c:if>>大专</option>
					       <option value="本科" <c:if test="${emp.education=='本科'}">selected</c:if>>本科</option>
					       <option value="硕士" <c:if test="${emp.education=='硕士'}">selected</c:if>>硕士</option>
					       <option value="博士" <c:if test="${emp.education=='博士'}">selected</c:if>>博士</option>
					       <option value="其它" <c:if test="${emp.education=='其它'}">selected</c:if>>其它</option>
					   </select>
					</td>
				   <th>是否在职：</th>
				   <td>
					   <select id="isLeave" name="emp.isLeave">
						       <option value="-1">--请选择--</option>
						       <option value="1" <c:if test="${emp.isLeave==1 }">selected</c:if> >在职</option>
						       <option value="0" <c:if test="${emp.isLeave==0 }">selected</c:if>>离职</option>
					   </select>
				   </td>
				</tr>
				<tr>
				   <th>入职时间：</th>
				   <td>
				       <input type="text" name="rzbegintime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${rzbegintime }" />至
				       <input type="text" name="rzendtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${rzendtime }" />
				   </td>
				   <th>出生日期：</th>
				   <td colspan="3">
				       <input type="text" name="csbegintime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${csbegintime }" />至
				       <input type="text" name="csendtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${csendtime }" />
				   </td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showPage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showPage(1)"  ><span    class=icon_xls>导出</span></button>
						<input type="hidden" name="dc" id="dc" value="">
					</td>
				</tr>
			</table>
			</div>
			</div>
		</FORM>
		
	<FORM id="form1" name=form1 action="selectemp.do?funid=14" method="post">
		<div id="resulthight">
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    	   <TR align="center">
				<th>
					姓名
					<input type="hidden" id="marker2" name="marker2" value="${marker }" />
		            <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
				</th>
				<th>性别</th>
				<th>生日</th>
				<th>联系电话</th>
				<th>学历</th>
				<th>所属部门</th>
				<th>职位</th>
				<th>工号</th>
				<th>入职时间</th>
				<th>是否在职</th>
				<th align="center">操作
				</th>
		 </TR>    
		<tbody id="infotable">
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
						<c:set var="birthDate" scope="request" value="${data.birth}"  />
						${data.birth}
					</TD>
					<TD align=right>
						${data.tel}
					</TD>
					<TD align=center>
						${data.education}
					</TD>
					<TD align=left>
						${data.department.name}
					</TD>
					<TD align=center>
						${data.groups.groupName}
					</TD>
					<TD align=left>
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
						<c:if test="${data.isLeave==1}"><a href="javascript:addOperationDepart(${data.id})">审核业务额度</a></c:if>
						<c:if test="${data.isLeave==0}">不能操作</c:if>
						&nbsp;&nbsp;	&nbsp;&nbsp;
						<a href="detailemp.do?cid=${data.id}">详细信息</a>
							&nbsp;&nbsp;	&nbsp;&nbsp;
						 <a href="chengpositionemp.do?cid=${data.id}">岗位管理</a>
						 &nbsp;&nbsp;	&nbsp;&nbsp;
					<c:forEach items="${option}" var="data1">
						<c:if test="${data1.key==2}">
						<A
							href="showemp.do?id=${data.id}"
							target=right><IMG style="CURSOR: hand" 
								hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
						</a>
						</c:if>
						</c:forEach>
							&nbsp;&nbsp;	&nbsp;&nbsp;
						<input type="hidden" id="abc" value="${data.id}">
						<INPUT
							style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
							type=checkbox value="${data.id }" name=ids>    
	               
						<c:if test="${data.isLeave==1}">
						  <c:if test="${data.isqj!='1'}">
						    <a  id="${data.id}" name="${data.name}" href="#" onclick="showqj(this)">请假</a>
						  </c:if>
						  <c:if test="${data.isqj=='1'}">
							<font style="font-weight: bold;" color="red">请假</font>
						  </c:if>
						  	&nbsp;&nbsp;	&nbsp;&nbsp;
						  <a href="#"  name="${data.id}" id="lz" onclick="showlz(this)">离职</a> 
						</c:if>
							&nbsp;&nbsp;	&nbsp;&nbsp;
						<c:if test="${data.isLeave==0}"><font style="font-weight: bold;" color="red">离职</font></c:if>
					</TD>
				</TR>
				</c:if>
				<c:if test="${emp.department.depNo ==111 && data.department.depNo == 111}">
				<TR>
					<TD align=center height=25 >
						<span>${data.name}</span>
					</TD>
					<TD align=center>
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
					<TD align=right>
						${data.tel}
					</TD>
					<TD align=center>
						${data.education}
					</TD>
					<TD align=left>
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
						<c:if test="${data.isLeave==1}"><a href="javascript:addOperationDepart(${data.id})">增加业务</a></c:if>
						<c:if test="${data.isLeave==0}">不能操作</c:if>
				
						<a href="detailemp.do?cid=${data.id}">详细信息</a>
						
						<a href="chengpositionemp.do?cid=${data.id}">职位管理</a>
					
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
					
						<c:if test="${data.isLeave==1}">
							<a href="#"  name="${data.id}" id="lz" onclick="showlz(this)">离职</a>  
						</c:if>
						<c:if test="${data.isLeave==0}"><font style="font-weight: bold;" color="red">离职</font></c:if>
					</TD>
				</TR>
				</c:if>
			</c:forEach>
		</tbody>  
		<tr>
			<TD align=right colspan="15">
				<INPUT id=chkall
					style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
					onclick=CheckAll(this.form) type=checkbox value=select
					name=chkall>
				全选
				<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
				<c:forEach items="${option}" var="data1">
					<c:if test="${data1.key==3}">
					  <button  name="delbut" onclick="del('delemp.do','selectemp.do')"><span class=icon_delete>删除</span></button>
					</c:if>
					</c:forEach>
			</TD>
		</tr> 
		<TR>
			<TD id="page" colspan="15"><p:pages url="select2emp.do?deptid=all&funid=14" /></TD>
		</TR>
    	</table>
    	</div>
	</FORM>
	
	<!-- 员工离职 -->
	<div id="yglz" style="display:none;">
		<div id="fd" style="filter:alpha(opacity=100);opacity:1;float: right;" >
        <div class="contentup" style="width: 500px;">   
         <table  style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
              <tr>
                 <th align="center" colspan="2">员工离职</th>
              </tr>
              <tr>
                 <th width="30%">离职时间：</th>
                 <td align="left" width="70%">
			         <input type="text" name="leavetime" id="leavetime" onclick="WdatePicker()"  class="Wdate" style="width: 90px;"  />
			         <input type="hidden" name="empid" id="empid" value="" />
			     </td>
              </tr>
              <tr>
			     <th align="right">离职原因：</th>
			     <td align="left">
	                <textarea rows="7" cols="40" name="leavereason" id="leavereason"></textarea>
	             </td>
			  </tr>
			  <tr>
			    <td colspan="2" align="center">
			       <button type="submit" id="tj" onclick="tj()" ><span class="icon_find">提交</span></button>
			       <button type="button"  id="clos" onclick="closlz()" ><span class="icon_close">关闭</span></button>
			    </td>
			  </tr>
         </table>
		</div></div>
	</div>
	
	<!-- 员工请假 -->
	<div id="ygqj" style="display:none;">
		<div id="fd" style="filter:alpha(opacity=100);opacity:1;float: right;" >
        <div class="contentup" style="width: 580px;">   
        <form action="<%=request.getContextPath()%>/addLeaveemp.do" method="post" onsubmit="return qj();"> 
        <table  style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
             <tr><th colspan="2" align="center">员工请假单</th></tr>
             <tr>
			     <th align="right" width="30%">请假人：</th>
			     <td align="left" width="70%">
			        <input type="text" size="10" id="empname" value="" readonly="readonly">
			        <input type="text" size="10" id="qjempid" name="leavesimple.empid" value="">
			     </td>
			 </tr>
			 <tr>
			     <th align="right">请假类型：</th>
			     <td align="left">
			        <select name="leavesimple.leavetype">
			           <option value="0">休假(假)</option>
			           <option value="1">病假</option>
			           <option value="2">事假</option>
			           <option value="3">其他</option> 
			        </select>
			     </td>
			 </tr>
			 <tr>
			     <th align="right" width="30%">请假时间：</th>
			     <td align="left" width="70%">
			                         自<input type="text" name="leavesimple.begintime" id="begintime" value=""  onclick="WdatePicker()" class="Wdate" style="width: 90px;"  />
			                         到<input type="text" name="leavesimple.endtime" id="endtime" value=""  onclick="WdatePicker()" class="Wdate" style="width: 90px;"  />
			                         总共请假<input type="text" name="" size="2" value="" style="height: 15px;" />天
			     </td>
			 </tr>
			 <tr>
			     <th align="right" width="30%">请假理由：</th>
			     <td align="left" width="70%">
			         <textarea rows="4" cols="60" name="leavesimple.content" id="content"></textarea>
			     </td>
			 </tr>
			 <tr>
			     <td align="center" colspan="2">
			                        主管签字：<input type="text" size="10" name="leavesimple.superson" id="superson" value="">
			                        经理签字：<input type="text" size="10" name="leavesimple.manager" id="manager" value="">
			                        行政签字：<input type="text" size="10" name="leavesimple.admin" id="admin" value="">
			     </td>
			 </tr>
			  <tr>
			    <td align="center" colspan="2">
			       <button type="submit" id="qjtj" ><span class="icon_find">提交</span></button>
			       <button type="button"  id="qjclos" onclick="closlz()" ><span class="icon_close">关闭</span></button>
			    </td>
			 </tr>
        </table>
		</form>
		</div></div>
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
		
		function addOperationDepart(empid){
		   var tt = new Date().getTime();
		   var url = "addOperationemp.do?empid="+empid+"&tt="+tt;
		   showWindwoButton('','员工业务审核管理','750','550',url);
		}
</script>
</HTML>
