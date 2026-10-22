<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'orderVerify.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <style>
    table tr td{
      word-break:break-all;
    }
    </style>
  </head>
  
  <body>
    <jsp:include page="head.jsp"></jsp:include>
     <jsp:include page="left.jsp"></jsp:include>
   <form action="">
    
   <h5>当前操作—》 确认订单</h5>
   <c:forEach items="${str}" var="orderlist">
   
  
   <hr/>
      <table style="margin-left: 100px;" cellpadding="10" cellspacing="15" border="0" >
         <tr><td>订单号:</td> <td>${orderlist.saleOrderNo}</td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td >机位大小:</td><td>${orderlist.spaceSize}</td>
         </tr>
         
         <tr>
             <td>IP:</td><td colspan="3">${orderlist.ipNum}</td>
             <td>机器数量:</td><td>${orderlist.productNum }</td>
         </tr>
         
         <tr><td>宽带数量:</td> <td>${orderlist.bw}</td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td>订单价格:</td><td>${orderlist.price}</td>
         </tr>
         
         <tr>
           <td>付费类型:</td> 
           <td>${orderlist.allTypeByPayStyle.typeName}</td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td>订单类型:</td>
           <td>	${orderlist.allTypeByOrdertype.questionName}</td>
         </tr>
         
         <tr><td>付费状态:</td> <td>${orderlist.allTypeByPayStatus.typeName}</td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td>开始时间:</td><td>${orderlist.beginTime}</td>
         </tr>
         
         <tr><td>经办人:</td> <td>${orderlist.employee.id}</td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td>结束时间:</td><td>${orderlist.endTime}</td>
         </tr>
         
         <tr>
         <td>服务器配置:</td><td colspan="4">${orderlist.serverConfiguration}</td> 
         </tr>
         
          <tr><td></td> <td></td>
           <td><a href="<%=basePath%>qdorderCustomerServer.do?id=${orderlist.id}"><img src="<%=basePath%>IDCServ/image/confim.gif"/></a></td><td></td>
         </tr>
   
      </c:forEach>
      
      
      </table>
   
   
   
   
   </form>
    <jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
