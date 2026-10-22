<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加套餐</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
  </head>
    <script type="text/javascript">
		function setMealPro(url)
		{
		　 　window.open(url);
		}
	</script>
  <body>
  	<FORM  id ="form1" name=form1 action="addSetMealAction.do" method="post" onsubmit="return addValidators()">
  <TABLE cellSpacing=0 cellPadding=0 width="1000" border=0 align="center" class="dt04">
    <TBODY>
      <TR>
        <TD class="dt05">添加套餐(带<span>*</span>号的为必填项) </TD>
      </TR>
      <TR>
        <TD><TABLE cellSpacing=0 cellPadding=0 align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR>
                <TD width="25%" height=30 align=right> 套餐类型： </TD>
                <TD width="25%" align="left">
                  <c:if test="${empty otList}">没有类型<a title="点击添加类型" href="addOrderTypeorderAction.do">点击添加</a></c:if>
                  <c:if test="${!empty otList}">
                  <select id="ordertype" name="ordertype.id" >
                  	<c:forEach items="${otList}" var="ot" >
                    	<option value="${ot.id }">${ot.name }</option>
                    </c:forEach>
                  </select>
                  </c:if>
                </TD>
                <TD width="10%" height=30 align=right> 套餐名称： </TD>
                <TD width="40%" align="left">
                	<INPUT onblur="checkValueByRules('name','','nameMsg')" id="name" name="name"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
                </TD>
              </TR>
              <TR>
                <TD align=right width="24%" height=30> 活动开始时间： </TD>
                <TD width="24%" align="left">
                	<INPUT onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onblur="checkValueByRules('startTime','','birthMsg')" id="startTime" name="startTime"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="birthMsg"></FONT>
                </TD>
                <TD align=right width="11%" height=30> 活动结束时间： </TD>
                <TD width="41%" align="left">
                	<input onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onblur="checkValueByRules('endTime','','endMsg')" type="text" id="endTime" name="endTime"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="endMsg"></FONT>
                </TD>
              </TR>
              <TR>
                <TD align=right width="24%" height=30> 实际价格： </TD>
                <TD width="24%" align="left"><input onblur="checkValueByRules('payPrice',['money'],'paypriceMsg')" id="payPrice" name="payPrice"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="paypriceMsg"></FONT>
                  </TD>
                <TD align=right width="11%" height=30> 收费类型： </TD>
                <TD width="41%" align="left"><select id="chargeMode" name="chargeMode" >
                    <option value="0">免费</option>
                    <option value="1">赠送</option>
                    <option value="2">预付</option>
                    <option value="3">后付</option>
                  </select></TD>
              </TR>
              <TR>
                <TD width="24%" align=right height=30> 原价： </TD>
                <TD colspan="3" align="left"><input onblur="checkValueByRules('totalPrice',['money'],'priceMsg')" id="totalPrice" name="totalPrice"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="priceMsg"></FONT>
                  </TD>
              </TR>
              <TR>
                <TD align=right width="24%"> 套餐描述： </TD>
                <TD colspan="3" align="left"><textarea style="width:500px; height:170px;" id="describe" name="describe"></textarea></TD>
              </TR>
              <TR>
                <TD align=right height=30 width="24%"> 选择套餐属性： </TD>
                <TD colspan="3" align="left">
                	<c:if test="${empty smProList }">没有可选属性<a href="goAddSetMealProAction.do">点击添加</a></c:if>
                	<c:if test="${!empty smProList }">
                	<c:forEach items="${smProList}" var="smp" varStatus="status">
	                	<input type="checkbox" name="property" value="${smp.id }" />
	                	<a title="点击查看属性详细" onclick="setMealPro('goSetMealProAction.do?id=${smp.id }&type=info')">${smp.name }</a>
	                  	&nbsp;&nbsp;&nbsp;&nbsp;
	                  	<c:if test="${status.index % 5 == 4 }"><br/></c:if>
                  	</c:forEach>
                  	</c:if>
               	</TD>
              </TR>
              <TR>
                <TD height=50 width="24%">&nbsp;</TD>
                <TD colspan="3" align="left"><INPUT class=button type=submit value="确认添加 ">
                  <INPUT class=button type=reset value=" 重置 ">
                  <input type="hidden" id="delflag" name="delflag" value="0" />
                  <input type="hidden" id="exitScfj" name="exitScfj" value="0" />
                  <input type="hidden" id="auditState" name="auditState" value="0" />
                </TD>
              </TR>
            </TBODY>
          </TABLE></TD>
      </TR>
    </TBODY>
  </TABLE>
</FORM>
  </body>
</html>
