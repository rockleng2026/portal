	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
   Cookies ck = new Cookies();
   String empN3ame =ck.getCookie(request, "employeeName");
		String empId=ck.getCookie(request,"employeeId");
		
 %>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
  <base href="<%=basePath%>">
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<title>出库列表</title>
<link href="<%=basePath%>potal/css/stylecrk.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
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

  
    		  $(".changecolor1").bind("click", function () { 
               $(".changecolor1").css("background-color","#50a806");
            });
              $(".changecolor2").bind("click", function () { 
               $(".changecolor2").css("background-color","#50a806");
            });
            // 全选 
            $("#btnCheckAll").bind("click", function () { 
                $("[name = ids]:checkbox").attr("checked", true); 
            }); 
              
            // 全不选 
            $("#btnCheckNone").bind("click", function () { 
                $("[name = ids]:checkbox").attr("checked", false); 
            }); 
  
            // 反选 
            $("#btnCheckReverse").bind("click", function () { 
                $("[name = ids]:checkbox").each(function () { 
                    $(this).attr("checked", !$(this).attr("checked")); 
                }); 
            }); 
  
            // 全不选 
            $("#btnSubmit").bind("click", function () { 
                var result = new Array(); 
                $("[name = ids]:checkbox").each(function () { 
                    if ($(this).is(":checked")) { 
                        result.push($(this).attr("value")); 
                    } 
                }); 
  
                alert(result.join(",")); 
            }); 
 })
 function xinzeng(){
	alert(1);
	 location.href="addshow1Outbound.do?potalckd=potal";	

	 }
</script>
</head>
<body>
  <div class="bk" style="height:506px;">
    <div class="bs">
      <div class="bs_t">您的位置:<a href="#">个人办公></a><a href="#">进销存管理></a><a href="#">出入库></a><span>出库列表</span></div>
      <div class="bsy">
         <div class="ck_lb">
            <div class="ck_lbl">
             <form class="border_radius" id="focus" action="outBoundInfoOutbound.do?potalckd=potal" method="post">
             <dl> <dt>出库日期</dt><dd> 
        <label><span>输入文本</span><input type="text" class="input_txt border_radius"  onclick='WdatePicker({dateFmt:"yyyy-MM-dd"})' name="datetime"  value="${dtime  }"/></label> </dd>
      <dt> 出库单号</dt><dd>  <label><span>输入文本</span><input type="text" class="input_txt border_radius" name="purNo"  value="${purNo  }"/></label></dd>
       <dt> 仓库位置</dt><dd>  <label><span>输入文本</span><input type="text" class="input_txt border_radius"  name="depot" value="${depot }"/></label></dd>
        </dl>
  
            </div>
            <div class="ck_lbr"><input type="submit" name="qd" class="an" value="查询" style="margin-right:20px;" /><input type="button" name="qd" class="an" value="新增" onclick="xinzeng()"/></div>
         </form>
         </div>
           
       	<div class="ck_lbt">
           <div class="ck_lbt_q">选择</div>
           <div class="ck_lbt_u">出库单号</div>
           <div class="ck_lbt_e">出库日期</div>
           <div class="ck_lbt_y">仓库位置</div>
           <div class="ck_lbt_t">出库类型</div>
           <div class="ck_lbt_r">审核状态</div>
           <div class="ck_lbt_w">操作</div>
        </div>
        <c:set value="0" var="num"></c:set>
        <div class="ck_table">
        <c:forEach items="${pages.pageList}" var="data" >
           <div class="ck_tr">
               <c:set value="${num+1}" var="num"></c:set>
              <div class="ck_tdq">${num}<!--  <input name="ids" type="checkbox" id="ids"  class="check" value="${data.id}"/>--></div>
              <div class="ck_tdu">${data.outboundNo }</div>
              <div class="ck_tde">${data.time }</div>
              <div class="ck_tdy">${data.depot.name}</div>
              <div class="ck_tdt">${data.allType.typeName}</div>
              <div class="ck_tdr"><c:if test="${data.auditingState==0 || data.auditingState==null  }">未审核</c:if><c:if test="${data.auditingState==1 || data.auditingState==8}">已审核</c:if></div>
              <div class="ck_tdw"><a href="delckdOutbound.do?bj=bj&potalckd=potal&cid=${data.id }&outNo=${data.outboundNo}&info=info">弃用</a> <a href="detailOutbound.do?potalckd=potal&cid=${data.id }&outNo=${data.outboundNo}&info=info">详情 ${auditingFlag}</a></div>
           </div> 
           </c:forEach>
        </div>
         <div class="bsy_h"></div>
         <div class="bsy_d">
            <div class="bsy_dl">
             <span class="bys_dll"><!--<input id="btnCheckAll" name="" type="checkbox" id="CheckAll" value="" class="check"/><label>全选</label></span><span class="bys_dlr"><a href="javascript:void(0)" id="btnCheckReverse"><label>反选</label></a><a href="#" id=""><label></label></a></span><span class="bys_dlr"><a href="#"><label>删除</label></a>  --></span> 
            </div >
            <div class="bsy_dr">
                 <p:pages url="outBoundInfoOutbound.do?potalckd=potal"/>
            </div>
         </div>
      </div>     
    </div>
  </div>
</body>
</html>
