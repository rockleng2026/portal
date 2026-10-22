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
    
    <title>My JSP 'chengedeptment.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


<meta http-equiv="x-ua-compatible" content="ie=7" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>Css/missionuse.css" />
<SCRIPT type=text/JavaScript>
var admincpfilename = 'admin.php', IMGDIR = 'template/artery_free22/image/', STYLEID = '5', VERHASH = 'H70', IN_ADMINCP = true, ISFRAME = 1, STATICURL='static/', SITEURL = 'http://yx30.com/', JSPATH = 'static/js/';
</SCRIPT>

<SCRIPT type=text/javascript src="<%=basePath%>js/common.js"></SCRIPT>

<SCRIPT type=text/javascript src="<%=basePath%>/admincp.js"></SCRIPT>

<SCRIPT type=text/javascript>
if(ISFRAME && !parent.document.getElementById('leftmenu') && !parent.parent.document.getElementById('leftmenu')) {
	redirect(admincpfilename + '?frames=yes&' + document.URL.substr(document.URL.indexOf(admincpfilename) + admincpfilename.length + 1));
}
</SCRIPT>
<script type="text/javascript">
function load(){

   herf="";

}

</script>
</head>
<body onload="load();">
<DIV id=append_parent></DIV>
<DIV id=ajaxwaitid></DIV>
<DIV id=cpcontainer class=container>
<SCRIPT type=text/JavaScript>parent.document.title = '游戏山林 管理中心 - 论坛 - 版块管理';if(parent.$('admincpnav')) parent.$('admincpnav').innerHTML='论坛&nbsp;&raquo;&nbsp;版块管理&nbsp;&nbsp;<a target="main" title="添加到常用操作" href="admin.php?action=misc&operation=custommenu&do=add&title=%B0%E6%BF%E9%B9%DC%C0%ED&url=action%253Dforums">[+]</a>';</SCRIPT>

<DIV class=itemtitle>
<H3>版块管理</H3></DIV>
<TABLE id=tips  class="tb tb2 ">
  <TBODY>
  <TR>
    <TH class=partition>技巧提示</TH></TR>
  <TR>
    <TD class=tipsblock s="1">
      <UL id=tipslis>
        <LI>版主用户名为粗体，则表示该版主权限可继承到下级版块</LI></UL></TD></TR></TBODY></TABLE>
<SCRIPT type=text/JavaScript>
var forumselect = '<optgroup label="--有图为证"><option value="2">美女</option></optgroup>';
var rowtypedata = [
	[[1, ''], [1,'<input type="text" class="txt" name="newcatorder[]" value="0" />', 'td25'], [5, '<div><input name="newcat[]" value="新分区名称" size="20" type="text" class="txt" /><a href="javascript:;" class="deleterow" onClick="deleterow(this)">删除</a></div>']],
	[[1, ''], [1,'<input type="text" class="txt" name="neworder[{1}][]" value="0" />', 'td25'], [5, '<div class="board"><input name="newforum[{1}][]" value="新版块名称" size="20" type="text" class="txt" /><a href="javascript:;" class="deleterow" onClick="deleterow(this)">删除</a><select name="newinherited[{1}][]"><option value="">继承指定版块设置</option>' + forumselect + '</select></div>']],
	[[1, ''], [1,'<input type="text" class="txt" name="neworder[{1}][]" value="0" />', 'td25'], [5, '<div class="childboard"><input name="newforum[{1}][]" value="新版块名称" size="20" type="text" class="txt" /><a href="javascript:;" class="deleterow" onClick="deleterow(this)">删除</a>&nbsp;<label><input name="inherited[{1}][]" type="checkbox" class="checkbox" value="1">&nbsp;继承上级版块设置</label></div>']],
];
</SCRIPT>

<FORM id=cpform method=post name=cpform action=admin.php?action=forums 
autocomplete="off"><INPUT value=ff5905c1 type=hidden name=formhash><INPUT 
id=formscrolltop type=hidden name=scrolltop><INPUT type=hidden name=anchor>
<DIV style="LINE-HEIGHT: 30px; HEIGHT: 30px"><A onclick=show_all() 
href="javascript:;">全部展开</A> | <A onclick=hide_all() 
href="javascript:;">全部折叠</A> <INPUT id=srchforumipt class=txt> <INPUT class=btn onclick="return srchforum()" value=搜索 type=submit></DIV>
<TABLE  border="1" class="tb tb2 ">
  <TBODY>
  <TR class=header>
    <TH></TH>
    <TH>显示顺序</TH>
    <TH>版块名称</TH>
    <TH></TH>
    <TH>版主</TH>
    <TH><A 
     
      href="javascript:;">批量编辑</A></TH></TR>
          <c:forEach items="${deptlist}" var="dept">
           <c:if test="${dept.parentId==1}">
            <TR class=hover>
    <TD class=td25 onclick="toggle_group('group_1', $('a_group_1'))"><A 
      id=a_group_1 href="javascript:;">[-]</A></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[1]></TD>
    <TD>
      <DIV class=parentboard><INPUT class="txt" value="${dept.name}" name=name[1]></DIV></TD>
    <TD class="td23 lightfont" align=right>(gid:1)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox 
      onclick="checkAll('value', this.form, 'g1', 'gc1', 1)" value=1 
      type=checkbox name=gc1> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR>
			   				 
				               
	<!-- 2循环 -->			             <c:forEach items="${deptlist}" var="dept1" >
				                         <c:if test="${dept1.parentId==dept.id}">
				                              <c:set value="${pcms3+1 }" var="pcms3"></c:set>
				                	                <TR class=hover>
    <TD class=td25 onclick="toggle_group('group_1', $('a_group_1'))"><A 
      id=a_group_1 href="javascript:;">[-]</A></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[1]></TD>
    <TD>
      <DIV class=parentboard><INPUT class="txt" value="${dept1.name}" name=name[1]></DIV></TD>
    <TD class="td23 lightfont" align=right>(gid:1)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox 
      onclick="checkAll('value', this.form, 'g1', 'gc1', 1)" value=1 
      type=checkbox name=gc1> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR>
							                         			
				<!-- 3循环 -->			             <c:forEach items="${deptlist}" var="dept2" >
							                         <c:if test="${dept2.parentId==dept1.id}">
							                         
							                         <c:set value="${pcms2+1 }" var="pcms2"></c:set>
							                         <c:set value="${pcms+1 }" var="pcms"></c:set>
							                                <TR class=hover>
    <TD class=td25 onclick="toggle_group('group_1', $('a_group_1'))"><A 
      id=a_group_1 href="javascript:;">[-]</A></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[1]></TD>
    <TD>
      <DIV class=parentboard><INPUT class="txt" value="${dept.name}" name=name[1]></DIV></TD>
    <TD class="td23 lightfont" align=right>(gid:1)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox 
      onclick="checkAll('value', this.form, 'g1', 'gc1', 1)" value=1 
      type=checkbox name=gc1> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR>
				     	<!-- 4循环 -->						         <c:forEach items="${deptlist}" var="dept3">
										                         <c:if test="${dept3.parentId==dept2.id}">
										                          <c:set value="${pcms1+1 }" var="pcms1"></c:set>
										                                <TR class=hover>
    <TD class=td25 onclick="toggle_group('group_1', $('a_group_1'))"><A 
      id=a_group_1 href="javascript:;">[-]</A></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[1]></TD>
    <TD>
      <DIV class=parentboard><INPUT class="txt" value="${dept.name}" name=name[1]></DIV></TD>
    <TD class="td23 lightfont" align=right>(gid:1)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox 
      onclick="checkAll('value', this.form, 'g1', 'gc1', 1)" value=1 
      type=checkbox name=gc1> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR>
										<!-- 5循环 -->		<c:forEach items="${deptlist}" var="dept4">
													                         <c:if test="${dept4.parentId==dept3.id}">
													                              <TR class=hover>
    <TD class=td25 onclick="toggle_group('group_1', $('a_group_1'))"><A 
      id=a_group_1 href="javascript:;">[-]</A></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[1]></TD>
    <TD>
      <DIV class=parentboard><INPUT class="txt" value="${dept.name}" name=name[1]></DIV></TD>
    <TD class="td23 lightfont" align=right>(gid:1)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox 
      onclick="checkAll('value', this.form, 'g1', 'gc1', 1)" value=1 
      type=checkbox name=gc1> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR>
													                        </c:if>
													                         </c:forEach> 
										                     </c:if>
										                         </c:forEach> 
							                         
							                         
							                         
							                       </c:if>
							                         </c:forEach> 
				                         
				                         
				                      </c:if>
				                       </c:forEach> 
                		 </c:if>
	
			   			 </c:forEach> 
			
		    
  <TR class=hover>
    <TD class=td25 onclick="toggle_group('group_1', $('a_group_1'))"><A 
      id=a_group_1 href="javascript:;">[-]</A></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[1]></TD>
    <TD>
      <DIV class=parentboard><INPUT class=txt value=有图为证 name=name[1]></DIV></TD>
    <TD class="td23 lightfont" align=right>(gid:1)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox 
      onclick="checkAll('value', this.form, 'g1', 'gc1', 1)" value=1 
      type=checkbox name=gc1> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR>
  <TBODY id=group_1>
  <TR class=hover>
    <TD class=td25></TD>
    <TD class=td25><INPUT class=txt value=0 name=order[2]></TD>
    <TD>
      <DIV class=board><INPUT class=txt value=美女 name=name[2]><A 
      class=addchildboard onclick="addrowdirect = 1;addrow(this, 2, 2)" 
      href="">添加子版块</A></DIV></TD>
    <TD class="td23 lightfont" align=right>(fid:2)</TD></TD>
    <TD class=td23><A title=编辑本版块版主 
      href="">无 
      / 添加版主</A></TD>
    <TD width=160><INPUT class=checkbox onclick="multiupdate(this, 2)" value=2 
      type=checkbox chkvalue="g1"> <A class=act title=编辑本版块设置 
      href="">编辑</A><A 
      class=act title=将本版块的设置复制到其他版块 
      href="">设置复制</A><A 
      class=act title=删除本版块及其中所有帖子 
      href="">删除</A></TD></TR></TBODY>
  <TBODY>
  <TR>
    <TD></TD>
    <TD colSpan=4>
      <DIV class=lastboard><A class=addtr onclick="addrow(this, 1, 1)" 
      href="">添加新版块</A></DIV></TD>
    <TD>&nbsp;</TD></TR></TBODY>
  <TBODY>
  <TR>
    <TD></TD>
    <TD colSpan=4>
      <DIV><A class=addtr onclick="addrow(this, 0)" 
      href="">添加新分区</A></DIV></TD>
    <TD class=bold><A 
     
      href="javascript:;">批量编辑</A></TD></TR>
  <TR>
    <TD colSpan=15>
      <DIV class=fixsel><INPUT id=submit_editsubmit class=btn title="按 Enter 键可随时提交您的修改" value=提交 type=submit name=editsubmit></DIV></TD></TR>
  <SCRIPT type=text/JavaScript>_attachEvent(document.documentElement, 'keydown', function (e) { entersubmit(e, 'editsubmit'); });</SCRIPT>
  </TBODY></TABLE></FORM></DIV></BODY></HTML>
