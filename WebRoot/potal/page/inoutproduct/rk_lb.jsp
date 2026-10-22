	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
  function add(){
  
 		location.href="addshowWarehousing.do?potal=potal";
  
  
}
</script>
</head>
<body>
  <div class="bk" style="height:506px;">
    <div class="bs">
      <div class="bs_t">您的位置：个人办公>入库列表</span></div>
      <div class="bsy">
         <div class="ck_lb">
            <div class="ck_lbl">
             <form class="border_radius" id="focus" action="newwarehousingInfoWarehousing.do?potalckd=potal">
             <dl> <dt>入库日期</dt><dd> 
             <input type="hidden" value="potal" name="potalckd"/>
        <label><span>输入文本</span><input type="text" name="time" onclick='WdatePicker({dateFmt:"yyyy-MM-dd"})' value="${dtime  }" class="input_txt border_radius"  /></label> </dd>
      <dt> 入库单号</dt><dd>  <label><span>输入文本</span><input type="text" name="purNo" class="input_txt border_radius" value="${purNo  }"/></label></dd>
       <dt> 仓库位置</dt><dd>  <label><span>输入文本</span><input name="place" type="text" value="${depot }" class="input_txt border_radius" /></label></dd>
        </dl>

            </div>
            <div class="ck_lbr"><input type="submit" name="qd" class="an" value="查询" style="margin-right:20px;" /><input type="button" onclick="add()" name="qd" class="an" value="新增" /></div>
         </div>
              </form>
       	<div class="ck_lbt">
           <div class="ck_lbt_q">选择</div>
           <div class="ck_lbt_w">仓库位置</div>
           <div class="ck_lbt_e">入库单号</div>
           <div class="ck_lbt_r">入库日期</div>
           <div class="ck_lbt_t">入库类型</div>
           <div class="ck_lbt_y">入库价格</div>
           <div class="ck_lbt_u">操作</div>
        </div>
        <div class="ck_table">
        	<c:forEach items="${pages.pageList}" var="data" varStatus="status">
           <div class="ck_tr">
              <div class="ck_tdq"><input type="checkbox" name="ids" id="ids"/></div>
              <div class="ck_tdw">${data.depot.name}</div>
              <div class="ck_tde">${data.storageNo }</div>
              <div class="ck_tdr">${data.storageDate}</div>
              <div class="ck_tdt">${data.allType.typeName}</div>
              <div class="ck_tdy">${data.productPriceSum}</div>
              <div class="ck_tdu"> <a href="detailWarehousing.do?potal=potal&purNo=${data.storageNo }&cid=${data.storageId}&info=info">详情</a></div>
             
           </div> 
            </c:forEach>
         <div class="bsy_h"></div>
         <div class="bsy_d">
            <div class="bsy_dl">
             <span class="bys_dll"><!--  <input id="btnCheckAll" name="" type="checkbox" id="CheckAll" value="" class="check"/><label>全选</label></span><span class="bys_dlr"><a href="javascript:void(0)" id="btnCheckReverse"><label>反选</label></a><a href="#" id=""><label></label></a></span><span class="bys_dlr"><a href="#"><label>删除</label>--></a></span> 
            </div >
            <div class="bsy_dr">
              <p:pages url="newwarehousingInfoWarehousing.do?fy=fy"/>
            </div>
         </div>
      </div>     
    </div>
  </div>
</body>
</html>
