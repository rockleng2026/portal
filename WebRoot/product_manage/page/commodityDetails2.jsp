<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <base href="<%=basePath%>">
  </head>
	<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
  <script type="text/javascript">
     $(function(){
		var imgs=$('#imgs').val();
		  var imgvalue=  imgs.split('|');
		    if(imgvalue!=""){
		  for(var i=1; i<imgvalue.length; i++){
		  	if(imgvalue[i]!=""){
		    $('#imgshow').append("<td><img style='width: 100;height: 100;border: 1px solid;' src='"+imgvalue[i]+"'/></td>");
		  	}
		    }
		  }
		});
		
		   function release(id){
     $.post("pdm/shenheproductManager.do",{'id':id},function(data){
           alert('审核成功');  
     window.location.href="detailsproductManager.do?id="+id;
      $('#shenhe').html('商品审核通过');
     });

   }
   
   
   function  fanhui(){
     //window.location.href="/FAJxc/pdm/List1productManager.do?v=3";
      history.go(-1);
   }
  </script>
  <body>
  <input type="hidden" id="orderNo" value="${sa.sgcode}" />
  <input type="hidden" id="tab" value="Sale_goods">
  <input type="hidden" id="filed" value="sgCheckGoods">
 <input type="hidden" id="orderName" value="sgcode">
   <div  style="border: solid #97C4E3; width: 904px; background-color: FFFFFF; "  >

  <table width="957" height="588"  cellpadding="0" cellspacing="0" style="border: 1px solid ;"   border="1px;" bordercolor="#7D7D7D" >
    <tr> <td align="center" height="50">商品编号：</td><td >${sa.sgcode}</td><td align="center">商品类型：</td><td>${sa.goods_dict.gdnames}</td></tr>
    <tr><td align="center" height="200">商品属性</td><td colspan="4">
       <s:iterator value="#request.getpropertys" var="mp" status="pm">
           <div style="border-bottom-style: outset;border-bottom-color: gray;border-bottom-width: 1px;overflow: auto;"><span><s:property value="#mp.value[0]" />:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color:green;"><s:property value="#mp.value[1]" /></span></div>
             <br/>
       </s:iterator>
    </td></tr>
    <tr> <td align="center" height="30">商品名称：</td><td >${sa.sgname}</td><td align="center">商品价格/元：</td><td>${sa.sgPrice }</td></tr>
    <tr> <td align="center" height="30">商品规格：</td><td colspan="3">${sa.sgNorms}</td></tr>
    <tr> <td align="center" height="30">录入人：</td><td >${sa.sgUsername}</td>
    <td align="center">商品状态：</td>
    <td>
    <c:if test="${sa.sgStat==0}">仓库中的商品</c:if>
    <c:if test="${sa.sgStat==1}">出售中的商品</c:if>
    <c:if test="${sa.sgStat==2}">发布待审核商品</c:if>
    
    </td></tr>
    <tr> <td align="center" height="50">商品图片：</td>
    
    <td colspan="3" style="height: 120px;">
        <div style="">
        <input type="hidden" id="imgs" value="${sa.sgImg }">
        <table>
           <tr id="imgshow">
           
           </tr>
        </table>
        </div>
    </td>
    
    </tr>
    <tr><td align="center" height="30">数量:</td><td align="center">${sa.sgnumbers }&nbsp;${sa.sgUnit}</td><td align="center">生成上架单:</td><td align="center">
    <c:if test="${sa.sgchecks1 ==1}">
      要生成上架单，<font color="red">使用方式：</font>
       <c:if test="${sa.sgchecks2 ==1}">
                                 托管
       </c:if>
     <c:if test="${sa.sgchecks2 ==2}">
                                  租用
       </c:if>
    </c:if>
    <c:if test="${sa.sgchecks1 ==0}">
       否
    </c:if>
    </td>
    </tr>
    <tr> <td align="center" height="30">创建时间：</td><td >${sa.sgtime}</td><td align="center">发布时间：</td><td>${sa.sgPuttime}</td></tr>
    <tr> <td align="center" height="30">审核状态：</td> <TD class=category colspan="3" id="shenhe">
                                    <c:if test="${sa.sgStat==2}">
										<c:if test="${mark=='mark'}"><!-- 编号值      表名，  是否审核，编号字段 -->
											<input type="button" value="接收" onClick="incepttime('${sa.sgcode}','Sale_goods','sgStat','sgcode')"/>
											  <c:set value="1" var="mflag" scope="session"></c:set>
										</c:if>
									</c:if>
									    <c:if test="${mflag==1}">
										<c:if test="${mark == 'no' && mark!='mark'}">
										  	<c:if test="${flage==0 }">
												<input type="button" value="审核"  onclick="completemission('${sa.sgStat}',2)">
											</c:if>
											<c:if  test="${flage==1 ||flage==2}"><span style="color:green;">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</span></c:if>
											   <c:if test="${aot.auditingFlag==2}"><span style="color:red;">未通过</span></c:if><span style="color:red;">--审核意见：${aot.tmp }</span>
										   </c:if>
									   </c:if>
										<br>
										
				                  	</c:if>
										</TD>
  
   </tr>

     <tr> <td align="center" colspan="4"  height="30"><input type="button" value="确定" onclick="fanhui();"/></td></tr>
  </table>
      <jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
    </div>
 
    
  </body>
</html>
