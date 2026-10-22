	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>入库列表</title>
   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
  <base href="<%=basePath%>">
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
			src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
<link href="<%=basePath%>potal/css/stylecrk.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
 $(document).ready(function(){
   $("#focus .input_txt").each(function(){
     var thisVal=$(this).val();
     //判断文本框的值是否为空，有值的情况就隐藏提示语，没有值就显示
     if(thisVal!=""){
       $(this).siblings("span").hide();
      }else{
       $(this).siblings("span").show();
      }
     //聚焦型输入框验证 
     $(this).focus(function(){
       $(this).siblings("span").hide();
      }).blur(function(){
        var val=$(this).val();
        if(val!=""){
         $(this).siblings("span").hide();
        }else{
         $(this).siblings("span").show();
        } 
      });
    })   
  })
 function fs(aa){
	 document.getElementById(aa).className="dsxg"
	 }
	  function lk(aa){
	 document.getElementById(aa).className="czl_tr"	 
	 }
 
 function detil(val){
 alert(val);
      var a=$("#a"+val).val();//此仓库的可用数量
      var b=$("#b"+val).val();//此仓库的 出库熟练
      var c=$("#c"+val).val();//此仓库的 出库熟练
     var tt = (new Date()).getTime();
     var url="<%=basePath%>depotdetilWarehousing.do?id="+val+"&tt="+tt+"&anum="+a+"&bnum="+b+"&cnum="+c;  
     $("#c1").load(url);
   	 $("#c1").show();
 	 $("#BgDiv").show();
 	
 }
 function colsediv(){
 	 $("#c1").hide();
 	 $("#BgDiv").hide();
   
 
 }
 function rklist(){
 
 location.href="<%=basePath%>newwarehousingInfoWarehousing.do?potalckd=potal";
 
 }
 function cklist(){
 
 location.href="<%=basePath%>outBoundInfoOutbound.do?potalckd=potal";
 
 }	
</script>
<style type="text/css">
.c1{
   width: 500;
   height: 300;
   left:15%;
   top: 10%;
   position: absolute;
   z-index: 1000;


}
   #BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}

</style>
</head>
<body>
  <div class="bk" style="height:506px;">
    <div class="bs">
      <div class="bs_t">您的位置：个人办公><span>库存总量列表</span></div>
      <div class="bsy">
         <div class="ck_lb">
            <div class="ck_lbl" style="width:535px;">
             <form class="border_radius" id="focus" action="seldepotWarehousing.do">
             <dl> <dt>库管人员</dt><dd> 
        <label><span>输入文本</span><input type="text" class="input_txt border_radius"  name="empname"/></label> </dd>
      <dt> 仓库位置</dt><dd>  <label><span>输入文本</span><input type="text" class="input_txt border_radius" name="depname" /></label></dd>       
        </dl>
   
            </div>
            <div class="ck_lbr" style="width:240px;"><input type="submit" name="qd" class="an" value="查询" style="margin-right:20px;" /><input type="button" name="qd" onclick="rklist()" class="an" value="入库" style="margin-right:20px;" /><input type="button" onclick="cklist()" name="qd" class="an" value="出库" /></div>
         </div>
           </form>
       	<div class="czl_lbt">
          <div class="czl_lbt_q">选择</div>
          <div class="czl_lbt_w">库管人员</div>
          <div class="czl_lbt_e">仓库位置</div>
          <div class="czl_lbt_r"><span title="可使用的+冻结的(不包括出库的)">库存总量</span></div>
          <div class="czl_lbt_t"><span title="使用状态为2的">可用数量</span></div>
          <div class="czl_lbt_y"><span title="使用状态为1并且不是冻结字段不是1的(可为空)">出库数量</span></div>
          <div class="czl_lbt_u"><span title="冻结字段为 1的或者是出库待审核的">冻结数量</span></div>
          <div class="czl_lbt_i">操作</div>            
        </div>
      
        
        <div class="czl_table">
           <c:set value="1" var="trid"></c:set>
         <s:iterator value="#request.depot" var="depot1">
            <c:set value="${trid+1}" var="trid"></c:set>
          <div class="czl_tr" id="tr${trid}" onmouseover="fs('tr${trid}');" onmouseout="lk('tr${trid}');">
             <div class="czl_td_q">${trid }</div>
             <div class="czl_td_w"><s:property value="employee.name" /> </div>
             <div class="czl_td_e"><s:property value="name" /> </div>
            
 	  		 <div class="czl_td_r">
 	  		<s:iterator value="#request.cuountlist" var="mp"  status="pm"><!-- 总库存=可用+冻结 -->
       	<s:if test="#depot1.name==#mp.key">
     
        
        <s:iterator value="#request.cuountlist2" var="mp2" >
       <s:if test="#depot1.name==#mp2.key">
       
       <s:property value="#mp2.value+#mp.value" />       
       </s:if>
   </s:iterator>
       </s:if>
   </s:iterator>
 	  		 
 	  		 </div>
             <div class="czl_td_t"><s:iterator value="#request.cuountlist" var="mp" status="pm"><!-- 可用 -->
       <s:if test="#depot1.name==#mp.key">
       <s:property value="#mp.value" />       
        <input type="hidden" id="a<s:property value="id" />" value="<s:property value="#mp.value" />"/> 
       </s:if>
 	  </s:iterator></div>
 	  
 	  
             <div class="czl_td_y"><s:iterator value="#request.cuountlist1" var="mp1"  status="pm"><!-- 出库-->
       <s:if test="#depot1.name==#mp1.key">
       <s:property value="#mp1.value" />   
       <input type="hidden" id="b<s:property value="id" />" value="<s:property value="#mp1.value" />"/>    
       </s:if>
   </s:iterator></div>
             <div class="czl_td_u"><s:iterator value="#request.cuountlist2" var="mp2" ><!-- 冻结-->
       <s:if test="#depot1.name==#mp2.key">
        <input type="hidden" id="c<s:property value="id" />" value="<s:property value="#mp2.value" />"/> 
       <s:property value="#mp2.value" />       
       </s:if>
   </s:iterator></div>
             <div class="czl_td_i"><a href="javascript:detil(<s:property value="id" />)">详情</a></div>
           </div>
         
          
         
         
     	 </s:iterator>
        </div>
        
   
        
         
        
         <div class="bsy_h"></div>
         <div class="bsy_d">
            <div class="bsy_dl">
             <span class="bys_dll"><!--  <input type="checkbox" name="qx" value="全选" /><label>全选</label></span> <span class="bys_dlr"> <a href="#">反选</a> <a href="#">删除</a>--></span> 
            </div >
            <div class="bsy_dr">
               <p:pages url="seldepotWarehousing.do"/>
            </div>
         </div>
      </div>     
    </div>
  </div>
  <div class="c1" id="c1" style="display: none">
  
  
  </div>
  <div id="BgDiv" style="display: none" ></div>
</body>
</html>
