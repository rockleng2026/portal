<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="x-ua-compatible" content="ie=7" />

<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/validators.js"></script>
	<link type="text/css" rel="stylesheet" href="<%=basePath%>Css/missionuse.css" />
	<script type="text/javascript">
	$(document).ready(function(){
	$("#sel").change(function(){
	 if(confirm("确定要修改本部门的主管？")==true){
	 
	 var val=$("#sel").find("option:selected").text();
	 var  a=$("#sel").val();
	if(a!=0){
	 document.getElementById("zhuguan").value=val;
	 }}
	});
	$("#sel1").change(function(){
	 if(confirm("确定要修改本部门的级别？")==true){
	 
	 var val=$("#sel1").find("option:selected").text();
	 var  a=$("#sel1").val();
	if(a!=0){
	 document.getElementById("islevel").value=a;
	 document.getElementById("islevel1").value=val;
	 }}
	});
	
	});
	
	</script>
	<style type="text/css">
	td{
	text-align: left;
	}
	</style>
</head>
<body>

<c:forEach items="${deptlists}" var="dept">
<div id="append_parent"></div><div id="ajaxwaitid"></div>
<div class="container" id="cpcontainer">


<input type="hidden" name="operation" value="edit">
<div class="itemtitle">
<table class="tb tb2 " id="tips">

				<tr>
					<th class="partition">
						${deptname} - 编辑部门详细信息
					</th>
					<th class="partition">
						<a  href="getallmissiontype.do" >返回部门信息列表</a>
					</th>
					
				</tr>
				</table>
</div>
<form name="cpform" method="post" action="editdepmentmissiontype.do">
<input type="hidden" name="formhash" value="ff5905c1" />
<input type="hidden" id="formscrolltop" name="scrolltop" value="" />
<input type="hidden" name="anchor" value="" />
<input type="hidden" name="type" value="group">
<table class="tb tb2 ">
<tr><td colspan="2" class="td27" s="1">部门名称:<a id="faq4519" class="faq"  href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">
<input name="deptname" type="text" class="txt"  value="${dept.name }" /></td>
<input type="hidden" name="deptid" value="${dept.id }"/>
<td class="vtop tips2" s="1"></td></tr>
<tr><td colspan="2" class="td27" s="1">部门编号:<a id="faq7551" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">
<input id="c1_v" type="text" class="txt" value="${dept.depNo }" name="depno" >
</td><td class="vtop tips2" s="1">如果要添加部门主管，请到部门信息管理的页面用职位管理来进行部门主管的添加。<br /></td></tr>
<tr><td colspan="2" class="td27" s="1">直属部门:<a id="faq7551" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<c:forEach items="${deptlist1}" var="dept1">
<tr class="noborder"><td class="vtop rowform">
<input id="c1_v" type="text" class="txt" value="${dept1.name }" name="" readonly="readonly" >
</c:forEach>
</td><td class="vtop tips2" s="1">如果要添加部门主管，请到部门信息管理的页面用职位管理来进行部门主管的添加。<br /></td></tr>
<tr><td colspan="2" class="td27" s="1">部门电话:
<a id="faq1ad3" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">
<input name="tel" value="${dept.tel }" type="text" class="txt"   /></td>
<td class="vtop tips2" s="1">该部门的电话，如果有事情拨打这个电话！</td></tr>
<tr><td colspan="2" class="td27" s="1">部门主管:</span>
<a id="faq4216" classs="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">

<input   id="zhuguan" value="${request.emplist }" type="text" class="txt" /> 
<br/><br/>
<select name="sel" id="sel"  onchange="cheangzg(this.value)">
<option  class="checked" value="0">下拉选择主管</option>
<c:forEach items="${deptlist2}" var="dept2">
<option value="${dept2.id }">${dept2.name }</option>
</c:forEach>
</select>

</td>
<td class="vtop tips2" s="1">如果要添加部门主管，请到部门信息管理的页面用职位管理来进行部门主管的添加。<br />
<Br/>要改变当前部门的主管。选择下拉框的人员
 <c:set value="${dept.isbj }" var="isbj"></c:set>
<tr><td colspan="2" class="td27" s="1">是否是半级机构:
<a id="faq361c" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder">
<c:if test="${dept.isbj==1}">
<td class="vtop rowform">
<ul><li class="checked"><input class="radio" type="radio" name="isbj" value="1" checked>&nbsp;是</li>
<li><input class="radio" type="radio" name="isbj" value="0" >&nbsp;否</li></ul></td>
</c:if>
<c:if test="${dept.isbj!=1}">
<td class="vtop rowform">
<ul><li class="checked"><input class="radio" type="radio" name="isbj" value="1" >&nbsp;是</li>
<li><input class="radio" type="radio" name="isbj" value="0" checked>&nbsp;否</li></ul></td>
</c:if>
<td class="vtop tips2" s="1">选择“否”将是普通的部门，选择是将是半级机构，如果上一级别机构为3级，则此部门为3.5级别</td></tr>

</table>
<table class="tb tb2 ">
<tr><td colspan="2" class="td27" s="1">是否是分公司&nbsp;&nbsp;:
<a id="faq361c" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder">
<c:if test="${dept.fiiale==1}">
<td class="vtop rowform">
<ul><li class="checked"><input class="radio" type="radio" name="fiiale" value="1" checked>&nbsp;是</li>
<li><input class="radio" type="radio" name="fiiale" value="0" >&nbsp;否</li></ul></td>
</c:if>
<c:if test="${dept.fiiale!=1}">
<td class="vtop rowform">
<ul><li class="checked"><input class="radio" type="radio" name="fiiale" value="1" >&nbsp;是</li>
<li><input class="radio" type="radio" name="fiiale" value="0" checked>&nbsp;否</li></ul></td>
</c:if>
<td class="vtop tips2" s="1">选择“否”将是普通的部门，选择是将分公司，如果是半级机构请不要选择分公司</td></tr>
<tr><td colspan="2" class="td27" s="1">分公司标识:</span>
<a id="faq4216" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">
<input name="filialemark" value="${dept.filialemark }" type="text" class="txt"  /></td>
<td class="vtop tips2" s="1">如果要添加部门主管，请到部门信息管理的页面用职位管理来进行部门主管的添加。<br />
<span class="smalltxt" style="color:#F00"></span></td></tr>
<tr><td colspan="2" class="td27" s="1">部门所属级别:

<a id="faq9fb4" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">

<input type="hidden" id="islevel" name="islevel" value="${dept.deptgrade.dgNum}"/>

<input name="islevel1" id="islevel1" value="${dept.deptgrade.dgName}" type="text" class="txt"  readonly="readonly" /></td>

<td class="vtop tips2" s="1">
<select name="sel1" id="sel1"  >
<option  class="checked" value="0">下拉选择部门级别</option>
<c:forEach items="${gradlist}" var="gradlist">
<c:forEach items="${deptlist1}" var="dept4">
<c:if test="${gradlist.dgNum >dept4.deptgrade.dgNum}">
<option value="${gradlist.dgNum}">${gradlist.dgName }</option>
</c:if>
</c:forEach>
</c:forEach>
</select>
<br/>

部门等级分7个级别，第一级别为福奥，如果要改变此部门的级别请点击改变级别功能</td></tr>
<tr><td colspan="2" class="td27" s="1">部门创建时间:
<a id="faq9fb4" class="faq" href="#" target="_blank" style="display:none">&nbsp;&nbsp;&nbsp;</a></td></tr>
<tr class="noborder"><td class="vtop rowform">
<input name="islevel" value="${dept.time }" type="text" class="txt"  readonly="readonly" /></td>
<td class="vtop tips2" s="1">此时间为创建部门的时间，不能进行修改</td></tr>
<tr>
<tr>
<td colspan="15"><div class="fixsel">
<input type="submit" class="btn" id="submit_detailsubmit" name="detailsubmit"  value="提交" /></div></td></tr>
</table>

</form>
</c:forEach>
</div>
</body>
</html>

