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
    
    <title>修改套餐</title>
    
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
  	<FORM  id ="form1" name=form1 action="updateSetMealAction.do" method="post" onsubmit="return addValidators()">
  <TABLE cellSpacing=0 cellPadding=0 width="1000" 
				border=0 align="center">
    <TBODY>
      <TR>
        <TD class="dt05">修改套餐(带*号的为必填项) </TD>
      </TR>
      <TR>
        <TD class="dt04"><TABLE  cellSpacing=0 cellPadding=0
								align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR>
                <TD width="25%" height=30 align=right> 套餐类型： </TD>
                <TD width="25%" align="left">
                	<c:if test="${empty otList}">没有类型<a title="点击添加类型" href="addOrderTypeorderAction.do">点击添加</a></c:if>
                  	<c:if test="${!empty otList}">
                  	<select id="ordertype" name="ordertype.id" >
                  	<c:forEach items="${otList}" var="ot" >
                    	<option value="${ot.id }" <c:if test="${ot.id == data.id }">selected="selected"</c:if>>${ot.name }</option>
                    </c:forEach>
                  	</select>
                  </c:if>
                </TD>
                <TD width="10%" height=30 align=right> 套餐名称： </TD>
                <TD width="40%" align="left">
                	<INPUT onblur="checkValueByRules('name','','nameMsg')" id="name" name="name" value="${data.name }"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
                  </TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30> 活动开始时间： </TD>
                <TD width="25%" align="left">
                	<INPUT onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onblur="checkValueByRules('startTime','','starttimeMsg')" id="startTime" name="startTime" value="${data.startTime }"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="starttimeMsg"></FONT>
                  </TD>
                <TD align=right width="10%" height=30> 活动结束时间： </TD>
                <TD width="40%" align="left">
                	<input onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onblur="checkValueByRules('endTime','','endtimeMsg')" type="text" id="endTime" name="endTime" value="${data.endTime }"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="endtimeMsg"></FONT>
                  </TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30> 实际价格： </TD>
                <TD width="25%" align="left"><input onblur="checkValueByRules('payPrice',['money'],'paypriceMsg')" id="payPrice" name="payPrice" value="${data.payPrice }"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="paypriceMsg"></FONT>
                  </TD>
                <TD align=right width="10%" height=30> 收费类型： </TD>
                <TD width="40%" align="left"><select id="chargeMode" name="chargeMode" >
                    <option value="0" <c:if test="${data.chargeMode == 0 }">selected="selected"</c:if>>免费</option>
                    <option value="1" <c:if test="${data.chargeMode == 1 }">selected="selected"</c:if>>赠送</option>
                    <option value="2" <c:if test="${data.chargeMode == 2 }">selected="selected"</c:if>>预付</option>
                    <option value="3" <c:if test="${data.chargeMode == 3 }">selected="selected"</c:if>>后付</option>
                  </select></TD>
              </TR>
              <TR>
                <TD width="25%" align=right height=30> 原价： </TD>
                <TD width="25%" align="left"><input onblur="checkValueByRules('totalPrice',['monry'],'priceMsg')" id="totalPrice" name="totalPrice" value="${data.totalPrice }"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="priceMsg"></FONT>
                  </TD>
              </TR>
              <TR>
                <TD align=right width="25%"> 套餐描述: </TD>
                <TD colspan="3" align="left"><textarea id="describe" style="width:500px; height:170px;" name="describe">${data.describe }</textarea></TD>
              </TR>
              <TR>
                <TD align=right height=30 width="25%"> 选择套餐属性: </TD>
                <TD align="left" colspan="3" width="75%">
                	<c:if test="${empty smProList }">没有可选属性<a href="goAddSetMealProAction.do">点击添加</a></c:if>
                	<c:if test="${!empty smProList }">
                	<c:forEach items="${smProList}" var="smp" varStatus="status">
	                	<input type="checkbox" name="property" value="${smp.id }" <c:forEach items="${smProList2 }" var="smp2"><c:if test="${smp2.id == smp.id }"> checked="checked"</c:if></c:forEach>/>
	                	<a title="点击查看属性详细" onclick="setMealPro('goSetMealProAction.do?id=${smp.id }&type=info')">${smp.name }</a>
	                  	&nbsp;&nbsp;&nbsp;&nbsp;
	                  	<c:if test="${status.index % 5 == 4 }"><br/></c:if>
                  	</c:forEach>
                  	</c:if>
              </TR>
              <TR>
                <TD height=30></TD>
                <TD colspan="3" height="50" align="left"><INPUT class=button type=submit value="确认修改 ">
                  <INPUT class=button type=reset value=" 重置 ">
                  <input type="hidden" id="id" name="id" value="${data.id }" />
                  <input type="hidden" id="delflag" name="delflag" value="${data.delflag }" />
                  <input type="hidden" id="exitScfj" name="exitScfj" value="${data.exitScfj }" />
                  <input type="hidden" id="auditState" name="auditState" value="${data.auditState }" />
                  <input type="hidden" id="buildTime" name="buildTime" value="${data.buildTime }" />
                  <input type="hidden" id="uuid" name="uuid" value="${data.uuid }" />
                </TD>
              </TR>
            </TBODY>
          </TABLE></TD>
        <TD><br/></TD>
      </TR>
    </TBODY>
  </TABLE>
</FORM>
  </body>
</html>
