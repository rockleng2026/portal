<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>新添单据</title>

</head>
<body>
	<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" colspan="2"><div class="dt01" style="background:url(<%=request.getContextPath() %>/images/setMeal/hdr.gif) repeat-x left center; ">
       <div class="left"><img src="<%=request.getContextPath() %>/images/setMeal/hdrl.gif" /></div>
        <div class="left" style="width:988px;">
          <h3>单据类型详细信息</h3>
        </div>
        <div class="right"><img src="<%=request.getContextPath() %>/images/setMeal/hdrr.gif" /></div>
      </div></td>
  </tr>
    	<tr class="dt03">
        	<td width="450" align="right" height="35" >
            	单据类型名称：
            </td>
            <td width="550" align="left">
            		${orderType.name}
            </td>
        </tr>
        <tr>
        	<td  width="450" align="right" >
            	备注：
            </td>
            <td width="550" align="left">
					${orderType.temp1}
            </td>
            
        </tr>

    </table>
</body>
</body>
	<SCRIPT type="text/javascript">
		function del(id)
		{
		alert(id);
			var url="delOrderType.do";
				$.post(url,{id:id},function(data){
				if(data==1)
				{
					alert("删除成功！！！");
					window.location.href='<%=request.getContextPath() %>/goListOrderType.do';
				}
				else
				{
					alert("删除失败！！！");
				}
			});
		}
	</SCRIPT>
</html>
