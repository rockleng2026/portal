	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>详情</title>
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
</script>
</head>
<body>
   <div class="zhezhu">
     <div class="kzl_tz">
       <div class="kzl_tzt"><span><a href="javascript:colsediv()">X</a></span>库存总量详情</div>
       <div class="kzl_tzc">
          <dl>
           <dt>仓库位置：</dt><dd>${depot.name }</dd><dt>出库数量</dt><dd>${bnum }</dd>
           <dt>仓库总量：</dt><dd>${anum+cnum }</dd><dt>冻结数量</dt><dd>${cnum }</dd>
           <dt>可用数量：</dt><dd>${anum }</dd><dt>库管人员</dt><dd>${depot.employee.name }</dd>
          </dl>
       </div>
       <div class="kzl_tzm">
          <div class="kzl_tzm_t"><span>出入库详情</span></div>
          <div class="kzl_tzm_d"><ul>
           <li><span class="tzm_dl">日期</span><span class="tzm_dc">人员</span><span class="tzm_dm">单号</span><span class="tzm_dr">出入量</span><span class="tzm_dr">操作</span></li>
           <c:forEach items="${ck }" var="ck" begin="0" end="2">
            <li><span class="tzm_dl">${ck.storageDate }</span><span class="tzm_dc">${ck.employee.name }</span><span class="tzm_dm">${ck.storageNo }</span>
            <span class="tzm_dr">
           
            <c:out value="${fn:length(ck.storageInfos)}"></c:out>台(入库) 
            </span>
            <span class="tzm_dr">入库</span></li>
          	</c:forEach>
          	
          	    <c:forEach items="${rk }" var="rk" begin="0" end="1">
          	    <c:set value="1" var="num"></c:set>
            <li><span class="tzm_dl">${rk.time }</span><span class="tzm_dc">${rk.employee.name }</span><span class="tzm_dm">${rk.outboundNo  }</span><span class="tzm_dr"><c:out value="${fn:length(rk.outboundInfos)}"></c:out>台(出库) </span><span class="tzm_dr">出库</span></li>
          	</c:forEach>
          </ul></div>
          
       </div>
       <div class="kzl_tzd"> <input type="button" name="qd"  onclick="colsediv()" class="hh_button" value="关 闭"  /></div>
     </div>
     
  </div>
  <!--<div class="bk" style="height:506px;">

    <div class="bs">
      <div class="bs_t">您的位置：<a href="#">个人办公></a><a href="#">进销存管理></a><a href="#">出入库></a><span>库存总量列表</span></div>
      <div class="bsy">
         <div class="ck_lb">
            <div class="ck_lbl" style="width:535px;">
             <form class="border_radius" id="focus">
             <dl> <dt>库管人员</dt><dd> 
        <label><span>输入文本</span><input type="text" class="input_txt border_radius"  /></label> </dd>
      <dt> 仓库位置</dt><dd>  <label><span>输入文本</span><input type="text" class="input_txt border_radius" /></label></dd>       
        </dl>
   </form>
            </div>
            <div class="ck_lbr" style="width:240px;"><input type="button" name="qd" class="an" value="查询" style="margin-right:20px;" /><input type="button" name="qd" class="an" value="入库" style="margin-right:20px;" /><input type="button" name="qd" class="an" value="出库" /></div>
         </div>
           
       	<div class="czl_lbt">
          <div class="czl_lbt_q">选择</div>
          <div class="czl_lbt_w">库管人员</div>
          <div class="czl_lbt_e">仓库位置</div>
          <div class="czl_lbt_r">库存总量</div>
          <div class="czl_lbt_t">出库数量</div>
          <div class="czl_lbt_y">可用数量</div>
          <div class="czl_lbt_u">冻结数量</div>
          <div class="czl_lbt_i">操作</div>            
        </div>
        <div class="czl_table">
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr" style="border-top:solid 1px #4e9b0d; border-bottom:solid 1px #4e9b0d; background-color:#c0e967;">
             <div class="czl_td_q"><input type="checkbox" value="勾选" checked="checked" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div><div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div>
           <div class="czl_tr">
             <div class="czl_td_q"><input type="checkbox" value="勾选" /></div>
             <div class="czl_td_w">小李</div>
             <div class="czl_td_e">深圳仓库</div>
             <div class="czl_td_r">2000</div>
             <div class="czl_td_t">326</div>
             <div class="czl_td_y">100</div>
             <div class="czl_td_u">2</div>
             <div class="czl_td_i"><a href="#">详情</a></div>
           </div> 
        </div>
        
       
        
        
         
        
         <div class="bsy_h"></div> 
         <div class="bsy_d">
            <div class="bsy_dl">
             <span class="bys_dll"><input type="checkbox" name="qx" value="全选" /><label>全选</label></span> <span class="bys_dlr"> <a href="#">反选</a> <a href="#">删除</a></span> 
            </div >
            <div class="bsy_dr">
               <div class="bsy_drq">打印 ]</div>
               <div class="bsy_drw">转到 <input type="text" name="ym" class="ym" />  页</div>
               <div class="bsy_dre">页数：1/30页</div>
               <div class="bsy_drr"><a href="#">尾页</a></div>
               <div class="bsy_drt"><a href="#">下一页</a></div>
               <div class="bsy_drt"><a href="#">上一页</a></div>
               <div class="bsy_drr"><a href="#">首页</a></div>
               <div class="bsy_drq" style="width:85px; text-align:left;">[ 共<span>96</span>条记录 </div>
            </div>
         </div>
      </div>     
    </div>
  </div>-->
</body>
</html>
