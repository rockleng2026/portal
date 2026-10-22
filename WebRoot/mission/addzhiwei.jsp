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
    
    <title>My JSP 'addzhiwei.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
         $(function(){
         $('#sect').click(function(){
             if(document.getElementById('sect').options.length==1){
                 $.ajax({
               type:'post',
               url:'addoptionmissiontype.do',
               success:function(data){
                  $('#sect').append(data);
               }
            });
             }
         });
         });
         function mss(mp){
             if($('#wname').val()=='' || $('#wsname').val()=='' || $('#sect').val()=='请选择' || $('#wcname').val()==''){
                  alert("请把信息填写完整");
                  return false;
             }else{
             
                return true;
             }
         }
    </script>
  </head>
   
  <body>
  <div>    
  <c:forEach items="${gradelist}" var="data"  varStatus="count">

     <table  align="center"   border="1" cellpadding="0" cellspacing="0" >
        <tr>
           <th>r职位名称</th>
           <th>职位简写</th>
            <th>部门</th>
             <th>权限级别</th>
              <th>操作</th>
        </tr>

        <tr>
         <td>${data.name }</td>
          <td>${data.shortname }</td> 
           <td>${data.department.name }</td>
            <td>${data.workgrade.name }</td>
             <td><a>修改</a>/<a>删除</a></td>
      
      </tr>
  
      </table>
    
   </c:forEach> 
   </div>
    <div align="center">
      <form action="addpositionsmissiontype.do" method="post" onsubmit="return mss();">
      <input type="hidden" name="workpos.department.name" value="<%=request.getAttribute("ids")%>">
      <table  align="center"   border="1" cellpadding="0" cellspacing="0" >
        <tr>
         <td colspan="5">职位名称：*<input  name="workpos.name" id="wname" type="text" /></td>
      
      </tr>
        <tr>  <td colspan="5">职位缩写：*<input  name="workpos.shortname" id="wsname" type="text"  /></td>
      
      </tr>
        <tr>  
        <td colspan="5">职位权重：*
        <select id="sect" name="workpos.workgrade.id" >
      <option>请选择</option>
  
        </select></td>
        </tr>
      <tr> 
      <td colspan="5"> 职位描述：*
        <textarea rows="5" cols="40" name="workpos.workcontent" id="wcname"></textarea>
      
      </td>
      </tr>
      <tr> 
         <td><input type="submit" value="提交"></td>
         <td><input type="reset" value="重置"></td>
      </tr>
      </table>
    </form>
    
    
    
    </div>
  </body>
</html>
