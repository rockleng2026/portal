<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>classTypeManage.jsp</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/coverComment.js"></script>
    <script type="text/javascript" src="<%=basePath%>product_manage/js/classTypeManage.js" charset="GBK"></script>
     <script type="text/javascript" src="<%=basePath%>product_manage/js/add.js" charset="GBK"></script>
    <link type="text/css" rel="stylesheet" href="<%=basePath%>product_manage/css/classTypeManage.css">
  </head>
  
  <body>
  <input type="hidden" id="path" value="<%=basePath%>">
  <s:bean name="java.util.Date" id="date"></s:bean>
      <div>
			<form action="<%=basePath%>pdm/splitpagesClassprojt.do" method="post">
				<table border="1" width="80%" cellpadding="0" cellspacing="0"
					bordercolor="#DBECF3" align="center">
					<tr>
						<td colspan="3" bgcolor="#8DC7E9">
							<B>类目列表</B>
						</td>
					</tr>
					<tr bordercolor="#FFFFFF" height="35">
						<td bordercolor="#FFFFFF"  align="center">
							类目名称：
							<input type="text" id="conditionValues" name="conditionValues" value="${conditionValues }" onkeyup="if(event.keyCode==13)getfoucs();" onfocus="this.value=''"/>
							<input type="hidden" name="pager.offset" value="no">
							<input type="submit" value="查询" id="submid"/>
						</td>
					</tr>
				</table>

			</form>
		</div>
      <div id="showPages">
         <table align="center" border="0" width="80%" cellspacing="0" cellpadding="0">
              <tr>
                 <td colspan="5">
	                 <table border="1" width="7%" align="right"  bgcolor="#d6f1fc" >
	                 <tr>
	                    <td><a href="javascript:menuaddsa('f','no');" id="topPage" >增加超类</a></td>
	                 </tr>
	                 </table>
                 </td>
              </tr>
              <tr>
              <td>
           <c:choose>
                <c:when test="${empty page.pageList }">
               <table border="1" cellpadding="10" cellspacing="0" width="100%">
                <tr bgcolor="#d6f1fc">
                 <td>编号</td>
                 <td>类目名称</td>
                 <td>父类</td>
                 <td>录入时间</td>
                 <td>操作</td>
              </tr>
              <tr>
                 <td colspan="5"><font color="red" size="5"><center>对不起，未找到你查询的信息.</center></font></td>
              </tr>
              <tr bgcolor="#d6f1fc">
                 <td align="center" colspan="5"><a>首页</a>&nbsp;&nbsp;<a>上一页</a>&nbsp;&nbsp;<a>下一页</a>&nbsp;&nbsp;<a>尾页</a>&nbsp;&nbsp;<a>当前第1页</a>&nbsp;&nbsp;<a>总共1页</a></td>
              </tr>
           </table >
           </c:when>
           <c:otherwise>
            <table border="1" cellpadding="10" cellspacing="0" width="100%">
              <tr bgcolor="#d6f1fc">
                 <td>编号</td>
                 <td>类目名称</td>
                 <td>父类</td>
                 <td>录入时间</td>
                 <td>操作</td>
              </tr>
              <c:forEach items="${page.pageList }" var="c" varStatus="s">
              <tr onclick="tabselct(this)">
                 <td>${(s.index+1) }</td>
                 <td>${c.gdnames }</td>
                 <td><c:if test="${empty c.gdSuperId }">暂无父类</c:if><c:if test="${c.gdSuperId !=null }">${c.fatherName }</c:if></td>
                 <td><fmt:formatDate value="${c.gdWriteTime}" type="both"/></td>
                 <td><a href="javascript:menuaddsa('c','${c.gdcodes }','${c.gdnames }',${c.gdId });" >增加子类</a>&nbsp;&nbsp;<a href="javascript:updtFatherOrChild(${c.gdId },'${c.gdcodes }','${c.gdnames }',<c:if test="${empty c.gdSuperId }">'no'</c:if><c:if test="${c.gdSuperId !=null }">${c.gdSuperId }</c:if>)">修改</a>&nbsp;&nbsp;<a href="javascript:delFatherOrChild(${c.gdId })">删除</a>&nbsp;&nbsp;<a href="javascript:selFatherOrChild(${c.gdId })">详情</a></td>
              </tr>
              </c:forEach>
              <tr bgcolor="#d6f1fc">
                 <td align="center" colspan="5"><!-- 把pageNumber的值暴露出来，并赋给一个叫CurrentPage的变量，这个变量将被保存到Request中 -->
                 <pg:pager items="${page.totalNum }" url="pdm/splitpagesClassprojt.do" maxPageItems="15" export="currentPageNumber=pageNumber">
                  <pg:first>
                       <a href="${pageUrl }">首页</a>&nbsp;&nbsp;
                  </pg:first>
                  <pg:prev>
                      <a href="${pageUrl }">上一页</a>&nbsp;&nbsp;
                  </pg:prev>
                  <pg:next>
                      <a href="${pageUrl }">下一页</a>&nbsp;&nbsp;
                  </pg:next>
                  <pg:last>
                       <a href="${pageUrl }">尾页</a>&nbsp;&nbsp;
                  </pg:last>
                                                           当前第${(page.currentPage ) }页&nbsp;&nbsp;总共<c:out value="${page.totallyPage }"/>页
                 </pg:pager>
                 </td>
              </tr>
           </table >
             </c:otherwise>
           </c:choose>
              </td>
              </tr>
         </table>
      </div>
    
    <div id="Requirements">
        <div style="width:700px;height:200px;">
           <table border="1" cellspacing="0" id="superTab" width="100%" height="100%" cellpadding="5"  style="border:1px solid #9fcaea;color:#7a7162;">
             <tr bgcolor="#9fcaea"><td colspan="2" >类目详情</td></tr>
             <tr valign="middle"><td align="right" width="20%">父类编码:</td><td align="left" width="80%"><input type="text" name="detailsupcode" id="detailsupcode" readonly="readonly"/></td></tr>
             <tr valign="middle"><td align="right">父类名称:</td><td align="left"><input type="text" name="detailsupName"  id="detailsupName" readonly="readonly"/></td></tr>
              <tr valign="middle"><td align="right">当前编码:</td><td align="left"><input type="text" name="detailcode"  id="detailcode" readonly="readonly"/></td></tr>
               <tr valign="middle"><td align="right">当前名称:</td><td align="left"><input type="text" name="detailName"  id="detailName" readonly="readonly"/></td></tr>
             <tr valign="middle"><td align="right">录入时间:</td><td align="left"><input type="text" name="detailtime" id="detailtime" readonly="readonly" /></td></tr>
              <tr><td colspan="2">&nbsp;</td></tr>
          </table>
         </div>
          <div style="width:700px;">
           <table border="1" cellspacing="0" id="superTab" class="insertvalues" width="100%" style="border:1px solid #9fcaea;text-align: center;color:#7a7162;">
             <tr bgcolor="#d6f1ff">
                <td align="center" width="140">属性名称</td>
                <td align="center">属性值</td>
                <td align="center">属性信息</td>
             </tr>
          </table>
         </div>
         <div style="width: 700px;height:30px;background-color: #f2f2f2;height: 30px;border: 1px solid #9fcaea;">
          <div style="margin-left:40%;">
             <div class="ann" id="closeDetails">关闭</div>
           </div>
          </div>
    </div>
  </body>
</html>
