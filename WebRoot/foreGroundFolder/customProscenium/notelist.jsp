<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0041)http://www.ebadu.com/manager/notelist.asp -->
<HTML><HEAD><TITLE>帮助留言</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META name=description 
content=进销存>
<META name=keywords 
content="进销存">
<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible><LINK rel="shortcut icon" 
href="../users/ico/zhhzw.ico"/>
<META name=GENERATOR content="MSHTML 8.00.6001.19154"/>
<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css"/>
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css"/>
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css"/>
</HEAD>
<BODY leftMargin=0 topMargin=0>
      <TABLE border=0 cellSpacing=1 cellPadding=2 width="95%" bgColor=#cccccc 
      align=center>
        <TBODY>
        <TR bgColor=#f0f0f0>
          <TD>&nbsp;当前操作-》帮助留言 </TD></TR></TBODY></TABLE><BR>
      <TABLE style="MARGIN-TOP: 8px" border=0 cellSpacing=0 cellPadding=0 
      width="95%" align=center height=30 bgcolor="#cccccc" >
        <TBODY>
        <TR >
          
          <TD style="BORDER-RIGHT: #ffffff 0px solid" height=13 
          width=53 
            align="center"><A 
            href="selectComMalfunctionDeclare.Action">所有问题</A></TD>
          <TD style="BORDER-RIGHT: #ffffff 0px solid" height=13 
           width=53 
            align="center"><A 
            href="selectComMalfunctionDeclare.Action?mark=Processing">正在处理</A></TD>
          <TD style="BORDER-RIGHT: #ffffff 0px solid" height=13 
           width=53 
            align="center"><A 
            href="selectComMalfunctionDeclare.Action?mark=untreated">未处理</A></TD>
          <TD height=13  
          width=53 align="center"><SPAN 
            style="BORDER-RIGHT: #ffffff 0px solid"><A 
            href="selectComMalfunctionDeclare.Action?mark=ProcessOK">处理成功</A></SPAN></TD></TR></TBODY></TABLE><BR>
      <table border="0" align=center cellpadding="2" cellspacing="1" width="95%" bgcolor="#CCCCCC">
<tr bgcolor="#F0F0F0">
<td width=6% align=center>序号</td>
<td width="13%" align="center">产品类型</td>
<td width="13%" align="center">问题类别</td>
<td width="29%" align="center">问题内容</td>
<td width="8%" align="center">您的评价</td>
<td width="13%" align="center">提交时间</td>
<td width="10%" align="center">处理状态</td>
<td width=8% align=center>操作</td>
</tr>
 <c:forEach items="${pages.pageList}" var="data" varStatus="status" >
<tr onmouseover="this.bgColor='#F5F5F5';" onmouseout="this.bgColor='ffffff';" bgcolor="#ffffff">
<td width="6%" align=center>${status.index}</td>
<td width="13%" align="center">${data.proudcotType.questionName}</td>
<td width="13%" align="center">${data.issueType.questionName}</td>
<td width="29%" align="left">${data.descs}</td>
<c:if test="${data.appraise == null }">
<td width="8%" align="center"><span style='color:#FF0000'>未评价</span></td>
</c:if>
<c:if test="${data.appraise == 1 }">
<td width="8%" align="center"><span style='color:#009F00'>满意</span></td>
</c:if>
<c:if test="${data.appraise == 2 }">
<td width="8%" align="center"><span style='color:FFAD76'>一般</span></td>
</c:if>
<c:if test="${data.appraise == 3 }">
<td width="8%" align="center"><span style='color:#FF0000'>不满意</span></td>
</c:if>
<td width="13%" align="center">${data.faultTime }</td>
<c:choose>
   <c:when test="${data.state == '-1'}">    
<td width="10%" align="center"><span style='color:#FF0000'>处理失败</span></td>
<td width="8%" align=center><a href="issueEvaluationMalfunctionDeclare.Action?id=${data.id}">查看</a></td>
   </c:when>
      <c:when test="${data.state == '0'}">    
<td width="10%" align="center"><span style='color:FFAD76'>等待客服处理...</span></td>
<td width="8%" align=center><a href="issueEvaluationMalfunctionDeclare.Action?id=${data.id}">查看</a></td>
   </c:when>
      <c:when test="${data.state == '1'}">    
<td width="10%" align="center"><span style='color:#009F00'>客服已接收</span></td>
<td width="8%" align=center><a href="issueEvaluationMalfunctionDeclare.Action?id=${data.id}">查看</a></td>
   </c:when>
    <c:when test="${data.state == '4' }">    
<td width="10%" align="center"><span style='color:#009F00'>处理成功</span></td>
<td width="8%" align=center><a href="issueEvaluationMalfunctionDeclare.Action?pj=pj&id=${data.id}">查看</a></td>
   </c:when>
   <c:when test="${data.state == '5' }">    
<td width="10%" align="center"><span style='color:#009F00'>处理成功</span></td>
<td width="8%" align=center><a href="issueEvaluationMalfunctionDeclare.Action?pj=no&id=${data.id}">查看</a></td>
   </c:when>
   <c:otherwise>  
<td width="10%" align="center"><span style='color:#FFAD76'>处理中.....</span></td>
<td width="8%" align=center><a href="issueEvaluationMalfunctionDeclare.Action?id=${data.id}">查看</a></td>
   </c:otherwise> 
</c:choose>

</tr>
    </c:forEach>
    <TR>								<TD class=category colSpan=14 height=30>
									<p:pages url="selectComMalfunctionDeclare.Action"/>
									</TD>
											</tr>
</table>
<BR>
</BODY></HTML>
