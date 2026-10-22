<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script  type="text/javascript">

function clickcut()
{
	var count = $("#count").val();
	var sprice = $("#price1").text();

	if(count == "1")
	{
		alert("亲，不能在－了!");
		return false;
	}else
	{
		var num = count-1;
		$("#count").val(num);

		var moneyall=num*sprice;
		$("#money").text(moneyall);
		
		
	}
}
function clickadd()
{
	var count = $("#count").val();
	var sprice = $("#price1").text();
	
	if(Number(count) >= 100)
	{
		alert("亲，不能在＋了!");
		return false;	
	}
	else
	{
		var num = Number(count) +1;
		$("#count").val(num);
		var moneyall=num*sprice;
		$("#money").text(moneyall);
	}
}
function tj(a,b){

var allmoney=$("#money").text();
var count = $("#count").val();
location.href="<%=path %>/litscloud/web/litscloudcreatorderCustomerServerC.Action?sgcode="+a+"&sgid="+b+"&amoney="+allmoney+"&count="+count+"&tt="+(new Date()).getTime();
	
}

</script>
<style type="text/css">
.msc{
top:0%;
left:0%;
background-color:#0C9;
width: 100%;
height: 500%;
position: absolute;
z-index: 1001;

}
.jgc{
top:70%;
left:30%;
width: 806px;
height: 500px;
position: absolute;
z-index: 10000;
}
</style>
<div class="zf_xy">

   <div class="zf_xyt"><span><a href="javascript:colsediv()">关闭</a></span>确认订单</div>
    <c:forEach items="${sllist}" var="sllist">
   <div class="zf_xyc"> 
      <div class="zf_gm">
         <div class="zf_gmt">
           <div class="zf_gmt_t">
           
              <div class="zf_gmt_tq">配置</div>
              <!-- <div class="zf_gmt_tw"></div> -->
              <div class="zf_gmt_te">计费周期</div>
              <div class="zf_gmt_tr">数量<strong></strong></div>
              <div class="zf_gmt_tt">单价(原价：</div>
           </div>

           <div class="zf_gmt_c">
               <div class="zf_gmt_cq">
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">商品名称:</div>
                    <div class="zf_gmt_cqtr">${sllist.sgname}</div>
                  </div>
                  <div class="zf_gmt_cqt">
                    
                    <div class="zf_gmt_cqtr">    <c:set value="0" var="a"></c:set>

 
               
                   <c:set value="0" var="ba"></c:set>
                  
              <c:if test="${getpropertys!=null}">
              <s:iterator value="#request.getpropertys" var="mp" status="pm">
               <c:set value="${ba+1}" var="ba"></c:set>
                 <ul style="margin-left:26px;">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span><s:property value="#mp.value[0]" /></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><s:property value="#mp.value[1]" /></span>
          	    </ul>
          	   	<c:if test="${ba==3 || ba==6}"></c:if>
      			 </s:iterator>
      			 </c:if></div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">&nbsp;</div>
                    <div class="zf_gmt_cqtr">&nbsp; </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">&nbsp;</div>
                    <div class="zf_gmt_cqtr">&nbsp;   </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">&nbsp;</div>
                    <div class="zf_gmt_cqtr"> &nbsp;     </div>
                  </div>
                   
               </div>
               <!-- <div class="zf_gmt_cw">电信</div> -->
               <div class="zf_gmt_ce">1月</div>
               <div class="zf_gmt_cr">
            	<a onclick="javascript:clickcut();" href="javascript:void(0);" style="CURSOR: pointer"><img src="<%=basePath%>potal/images/ss_-.png" width="11" height="11" /></a>
												&nbsp;
												<label for="textfield3"></label>
												<input type="text" id="count" style="text-align: center;width: 10px;height: 11px"
													align="middle" name="count" value="1" onchange="peimoney()"
													class="jjtext" />
												&nbsp;
												<a onclick="javascript:clickadd();" style="CURSOR: pointer" href="javascript:void(0);"><img src="<%=basePath%>potal/images/ss_+.png" width="11" height="11" /></a></div>
               <div class="zf_gmt_ct"><span id="price1"><c:if test="${sllist.isActivity==0 || sllist.isActivity==null || sllist.isActivity==''}">${sllist.sgPrice}</c:if>
               <c:if test="${sllist.isActivity==1}">
               <c:if test="${date1>=sllist.activityStart || date1<=sllist.activityEnd }">
               ${sllist.activityPrice }</c:if>
            	<c:if test="${date1<sllist.activityStart || date1>sllist.activityEnd }">${sllist.sgPrice}</c:if>
            	</c:if><c:if test="${sllist.isActivity==1}">
               <c:if test="${date1>=sllist.activityStart || date1<=sllist.activityEnd }">(优惠价)</c:if></c:if>
               </span>
            	
               </div>
           </div>
           <div class="zf_gmt_d">总费用：<span id="money"><c:if test="${sllist.isActivity==0 || sllist.isActivity==null || sllist.isActivity==''}">${sllist.sgPrice}</c:if>
               <c:if test="${sllist.isActivity==1}">
               <c:if test="${date1>=sllist.activityStart || date1<=sllist.activityEnd }">
              ${sllist.activityPrice }</c:if>
            	<c:if test="${date1<sllist.activityStart || date1>sllist.activityEnd }"> ${sllist.sgPrice}</c:if>
            	</c:if></span>元<c:if test="${sllist.isActivity==1}">
               <c:if test="${date1>=sllist.activityStart || date1<=sllist.activityEnd }">(优惠价)</c:if></c:if>
            	</div>
         </div>
         <div class="zf_gmd">
           <div class="zf_gmdl"><a href="javascript:tj('${sllist.sgcode}','${sllist.sgId}')">确 &nbsp; 认</a></div>
           <div class="zf_gmdr"><a href="javascript:colsediv()">取 &nbsp; 消</a></div>
         </div>
      </div>
    
   </div>
   </c:forEach>
   <script type="text/javascript">
   function changemoney(){
}
    </script>
   <div class="zf_xyd"></div>
</div>

