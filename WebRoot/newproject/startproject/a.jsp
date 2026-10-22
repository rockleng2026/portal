<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>进入日志页面</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript">
		function nsrmx(){
            var url = "<%=path%>/test.jsp";
			showWindwoButton('id','社保费分户台账','800','550',url);
		}
   </script>
  </head>
  
<body>
	<h3 align="center">保存成功，你现在可以添加<a href="goAddworknotepad.do">工作日志。</a></h3>
</body>
</html>
