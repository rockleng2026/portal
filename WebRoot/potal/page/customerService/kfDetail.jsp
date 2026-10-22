<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    
    <title>客服处理完成-详情</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  <style type="text/css">
body{width:595px; margin:0 auto; font-size:12px; color:#282828}
img{border:0}
a{ color:#dd731f}
.dow_top{width:585px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.border_grey{ border:1px solid #C6C6C6; height:45px; float:left}
	.rz_title { width:28px; background-color:#5da601;}
	.rz_title { color:#fff; font-size:12px; font-weight:bold; padding:3px 0 3px 0; text-align:center;}
	.rz_content{ padding:10px;}
	.tab_bottom{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:2px;}
	.tab_bottomc{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:5px;}
	.tab_bottomb{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:10px;}
	.tab_bottom_c{ padding-top:16px; line-height:25px;}
	.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:5px; float:right}
	.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:25px; margin-right:auto; float:left}
	.font_color_hui{color:#7c7c7c}
	.font_color_cheng{color:#dd731f}
	.padleft{ padding-left:20px;}
</style>
<script type="text/javascript">
  //关闭
  function close(){
    window.history.go(-1);
  }
  
    //查看附件
 function xzfj(fj){
     window.location.href="downloadTaskUpload.do?url="+fj;
 }
 
  //查看运维单
  function getOperate(){
     if(document.getElementById('operate').style.display=='none'){
         document.getElementById('operate').style.display='block';
     }else{
         document.getElementById('operate').style.display='none';
     }
  }
</script>
  <body>
  <div class="dow_top"> <span><a href="javascript:close();">×</a></span> 故障单详情 </div>
<table width="100%" height="540" border="0" cellspacing="0" cellpadding="0" class="border_grey">
  <tr>
    <td><table align="center" width="98%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="59%" class="tab_bottom">客户姓名：${fault.customer.realName}</td>
        <td width="41%" class="tab_bottom">&nbsp;产品类型：${fault.proudcotType.questionName}</td>
      </tr>
      <tr>
        <td class="tab_bottom">IP/账号：
         <c:if test='${fault.ip=="-1"}'>
                                   未查询出IP地址
         </c:if>
         <c:if test='${fault.ip!="-1"}'>
             ${fault.ip}
         </c:if>
        </td>
        <td class="tab_bottom">&nbsp;问题类型：${fault.issueType.questionName}</td>
      </tr>
      <tr>
        <td class="tab_bottom">处理状态：处理完成</td>
        <td class="tab_bottom">&nbsp;手机号码：
        ${fault.customerphone}
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">网站域名：
         ${fault.wdnr}
        </td>
        <td class="tab_bottom">&nbsp;邮件地址：${fault.email}</td>
      </tr>
      <tr>
        <td colspan="2" class="tab_bottom_c">问题描述：${fault.descs}</td>
      </tr>
      
       <tr>
        <td colspan="2" class="tab_bottom_c">
          <a href="javascript:getOperate();">查看运维单</a>
        </td>
      </tr>
      
            <tr>
        <td colspan="2">
          <!-- 显示运维单信息的DIV -->
 <div style="width: 100%;height: 30px;display: none;" align="center" id="operate">
    <table border="1" cellspacing="1" cellpadding="1" class="border_grey">
     <tr>
       <td align="center" width="5%">编号</td>
       <td align="center" width="20%">运维单号</td>
       <td align="center" width="20%">上架单号</td>
       <td align="center" width="15%">仓库名称</td>
       <td align="center" width="20%">商品名称</td>
       <td align="center" width="20%">条形码</td>
     </tr>
     <c:if test="${empty oplist}">
                       该故障单无运维单信息...
     </c:if>
     
     <c:if test="${!empty oplist}">
      <c:forEach items="${oplist}" var="operate">
         <tr>
		    <TD align="center" width="5%">				  
			  ${operate.id}
		    </TD>
			<TD align="center" width="20%">
			  ${operate.operateNo}
		    </TD>
			<TD align="center" width="20%">
			<input type="hidden" id="upserverid" value="${operate.upserver.id}"/>
			  ${operate.upserver.upNo}
			</TD>
			<TD align="center" width="15%">
			  ${operate.depot.name}
			</TD>
			<TD align="center" width="20%">
			   ${operate.product.property.name}
			</TD>
			<td align="center" width="20%">
			   ${operate.product.barcode}
			</td>
		</tr>
       </c:forEach>
     </c:if>
    </table>
 </div>
        </td>
      </tr>
      
      
      <tr>
        <td colspan="2" class="tab_bottom_c"><table width="98%" border="0" class="border_grey"  cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td   class="rz_title"><p>附<br />
              件</p></td>
            <td   class="rz_content">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="94%">
                   <c:forEach items="${list}" var="data">
                     ${data.fjmc} <a href="javascript:xzfj('${data.fjlj}');">预览下载</a>,
                   </c:forEach>
                <span class="font_color_hui"></span></td>
              </tr>
              
            </table></td>
          </tr>
        </table></td>
        </tr>
        
        <tr>
	      <td class="tab_bottom" colspan="2">
	                         客服备注:${fault.temp}
	      </td>
        </tr>
        
        
        
        处理结果:
      <c:forEach items="${solvelist}" var="sl">  
      <tr>
        <td colspan="2" class="tab_bottom_c">处理描述：<span class="font_color_cheng">${sl.endTim}</span> 处理人<span class="font_color_cheng">${sl.employeeByEmpId.name}</span>回复：</td>
        </tr>
      <tr>
        <td colspan="2" class="tab_bottomb padleft">
           <c:if test="${sl.solveDepict==null || sl.solveDepict==''}">
                                      暂无回复内容...
           </c:if>
           <c:if test="${sl.solveDepict!=null || sl.solveDepict!=''}">
              ${sl.solveDepict}
           </c:if>
           
        </td>
        </tr>
      <tr>
      </c:forEach>
      
      
        <td colspan="2" class="tab_bottomb">客服评价：
            ${fault.appraise}
        </td>
      </tr>
      <tr>
        <td colspan="2" class="tab_bottomb">客户评分：
        ${fault.grades}  
         </td>
        </tr>
      <tr>
        <td colspan="2"><table width="100%"  height="50" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="41%"></td>
            <td width="10%"><div class="gb_btl"><a style="text-decoration:none;color: white;" href="javascript:close();">关闭</a></div></td>
            <td width="49%"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
  
  </body>
</html>
