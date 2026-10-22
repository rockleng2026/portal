<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>Insert title here</title>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/validators.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/data.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/showDialog.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/editTable.js"></script>

	<script type="text/javascript">
		var countPath = '<%=request.getContextPath()%>';
		
	</script>
	<script type="text/javascript">
	//form提交验证
	
	function check()
	{
	     var input = $(":input[type='text']");
	   for( var i=0;i<input.length;i++)
	   {
	    if( input.eq(i).attr("value")=='' || input.eq(i).attr("value")==null)
	    {
	    alert("请输入完整的条形码");
	    return false;
	    }

	   }
	}
	
	//自动生成条形码
	function createBarCode(){
	     var myDate = new Date();
	     var date = myDate.getFullYear()+""+ myDate.getMonth()+""+myDate.getDate(); 
	     var mytime=myDate.toLocaleTimeString(); //获取当前时间
	     var rq = mytime.replace(/\:/ig,"");
	     var barcode = date+rq;
	     var input = $(":input[type='text']");
	   for( var i=0;i<input.length;i++)
	   {
	     input.eq(i).attr("value","TXM-"+barcode+i);

	   }
	}
	
	
	</script>
	<LINK href="<%=request.getContextPath()%>/Css/style.css" type=text/css
		rel=stylesheet>
	<LINK href="Css/style.css" type=text/css rel=stylesheet>
	<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY><%int i=0; %>
	<%request.setAttribute("storggeinfo",request.getParameter("storggeinfo"));
	  request.setAttribute("sorage",request.getParameter("sorage"));
	 %>
	 <form action="addIncomeStorageWarehousing.do" method="post" onsubmit=" return check()">
	<input type = "button" value="自动生成条形码" onclick="createBarCode()">
		<table>
	<c:forEach items="${map}" var="mapp">
	
	<tr><td width="100px" height="20"><font color="blue" >报益单：</font></td><td width="200px"><font color="blue" >${mapp.key }</font></td></tr>
	<tr><td><font color="blue" >报益详细</font></td></tr>
	<c:forEach items="${mapp.value }" var="income">
	
	

	<tr ><td width="50">商品型号</td><td>入库数量</td></tr>
	<tr><td>${income.model.name }</td><td>${income.count }</td></tr>
        
	
	<tr><td>条形码<%=i %>：</td><c:forEach begin="1" end="${income.count}"><td><input type="text" name="barcode<%=i %>" width="25" size="25"/><input name="model<%=i %>" type="hidden" value="${income.model.model }"/></td></c:forEach>	</tr>
      <%i++;  %>
	</c:forEach> 
	
	</c:forEach>  
		<tr><td><input type="submit" value="提交<%=i %>"/></td></tr>
		</table>
		</form>
	</BODY>
</HTML>
