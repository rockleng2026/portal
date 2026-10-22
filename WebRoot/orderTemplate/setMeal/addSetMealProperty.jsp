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
    
    <title>添加套餐属性</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
  </head>
   <script type="text/javascript">
		function showInfo()
		{
			var nowDate = (new Date()).getTime();
			var productId = $("#product").val();
			if(productId != -1){
				var url = "<%=request.getContextPath() %>/commodity/goInfoCommodity.do?id=" + productId + "&dd=" + nowDate;
				$("#showContent").load(url);
				$("#closeContent").html("×");
			}else{
				this.cleanC();
			}
		}
		
		function cleanC(){
			$("#showContent").html("<br/>");
			$("#closeContent").html("");
		}
		//据类型获得其所有型号
		function getProModel(){
			var date = new Date();
			var proType = $("#proType").val();
			if(proType != -1){
		   		var url="selectModelSetMealProAction.do?date="+date;
	 			$.post(url,{id:proType},
	 				function(data){
	 					if(data != ""){
	 						$("#proModel").html(data);
	 					}else{
	 						$("#proModel").html("<option value='-1'>未找到此商品型号</option>");
	 					}
	 				}
	 			)
 			}else{
 				$("#proModel").html("<option value='-1'>请选择商品型号</option>");
 			}
		}
		//据型号获得其所有商品/产品
		function getProduct(){
			var date = new Date();
			var proModel = $("#proModel").val();
			if(proModel != -1){
		   		var url="selectProductSetMealProAction.do?date="+date;
	 			$.post(url,{id:proModel},
	 				function(data){
	 					if(data != ""){
	 						$("#product").html(data);
	 					}else{
	 						$("#product").html("<option value='-1'>未找到此型号商品</option>");
	 					}
	 				}
	 			)
 			}else{
 				$("#product").html("<option value='-1'>请选择商品</option>");
 			}
		}
</script>
  <body>
  	<FORM  id ="form1" name=form1 action="addSetMealProAction.do" method="post" onsubmit="return addValidators()">
  <TABLE cellSpacing=0 cellPadding=0 width="1000"  align="center" border=0>
    <TBODY>
      <TR>
        <TD class="dt05">添加套餐属性 </TD>
      </TR>
      <TR>
        <TD class="dt04"><TABLE cellSpacing=0 cellPadding=0	align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR>
                <TD width="25%" height=30 align=right> 套餐属性名： </TD>
                <TD width="25%" align="left"><INPUT id="name" name="name" onblur="checkValueByRules('name','','nameMsg')"/>
                  <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"> </FONT>
                  </TD>
                <TD width="10%" height=30 align=right>价格：</TD>
                <TD width="40%" align="left"><INPUT id="price" name="price" onblur="checkValueByRules('price',['money'],'priceMsg')"/><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="priceMsg"></FONT></TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30> 数量 ：</TD>
                <TD width="25%" align="left"><INPUT onblur="checkValueByRules('num',['num'],'numMsg')" id="num" name="num" /><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="numMsg"></FONT>
                </TD>
                <TD align=right width="10%" height=30> 单位： </TD>
                <TD width="40%" align="left"><input onblur="checkValueByRules('unit','','unitMsg')" type="text" id="unit" name="unit" /><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="unitMsg"></FONT>
                </TD>
              </TR>
              <c:if test="${empty proList}">无库存产品了</c:if>
              <c:if test="${!empty proList}">
              <tr>
                <td width="25%" align=right height=30>选择产品：</td>
                <TD align="left"colspan="3">
                	<!-- 产品一级S -->
                	<select id="proType" onchange="getProModel()" style="width: 160">
                		<option value="-1">请选择商品类型</option>
						<c:forEach items="${typeList}" var="proType">
							<option value="${proType.id }">${proType.typeName }</option>
	                  	</c:forEach>
                  	</select>
                	<!-- 产品一级E -->
                	<!-- 产品二级S -->
                	<select id="proModel" onchange="getProduct()" style="width: 160">
                		<option value="-1">请选择商品型号</option>
                  	</select>
                	<!-- 产品二级E -->
                	<!-- 产品三级S -->
                	<select id="product" name="product.id"  onchange="showInfo();" onclick="showInfo();" style="width: 160">
                		<option value="-1">请选择商品</option>
                	</select>如下拉框自动收缩，请双击下拉框。
                  	<!-- 产品三级E -->
                </TD>
              </tr>
              <TR>
                <TD height=30>&nbsp;</TD>
                <TD align="left"colspan="3" height="50"><INPUT class=button type=submit value="确认添加">
                  <INPUT class=button type=reset value=" 重置 ">
                  <input type="hidden" id="delflag" name="delflag" value="0" />
                  <input type="hidden" id="existScfj" name="existScfj" value="0" />
                </TD>
              </TR>
              </c:if>
            </TBODY>
          </TABLE></TD>
      </TR>
    </TBODY>
  </TABLE>
  <div id="closeContent" onclick="cleanC()" align="center" title="点击关闭"></div>
  <div id="showContent"></div>
</FORM>
  </body>
</html>