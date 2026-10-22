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
    
    <title>故障单待分配--转接</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
  </head>
  <style type="text/css">
body{width:595px; margin:0 auto; font-size:12px; color:#282828}
img{border:0}
a{ color:#dd731f}
.dow_top{width:585px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
	.border_grey{ border:1px solid #C6C6C6;margin-bottom:10px; float:left}
	.rz_title { width:28px; background-color:#5da601;}
	.rz_title { color:#fff; font-size:12px; font-weight:bold; padding:3px 0 3px 0; text-align:center;}
	.rz_content{ padding:0px;}
	.tab_bottom{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:2px;}
	.tab_bottomc{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:5px;}
	.tab_bottomb{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:10px;}
	.tab_bottom_c{ padding-top:16px; line-height:25px;}
	.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:5px; float:right}
	.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:25px; margin-right:auto; float:left}
	.font_color_hui{color:#7c7c7c}
	.font_color_cheng{color:#dd731f}
	.padleft{ padding-left:20px;}
	.bgtd{ background-color:#e8e8e8}
	.tdtdtop{ border-top:4px solid #fff;}
	.tdnrtop{line-height:25px;}
	.tdma{ margin-top:10px;}
	.tab_bottomb{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:10px;}
</style>
<script type="text/javascript">
   //选择运维区域后，现则运维组
   function getOperate(){
     var qy = $("#ywqy").val();
     $.post('<%=request.getContextPath()%>/getOperategroupFault.do',{"gid":qy},function(data){
        $("#group").html(data);
     });
   }
   

   
   //关闭
   function close(){
      window.history.go(-1);
   }
   
   //转接
   function zjsub(){
      var conid = $("#conkoutid").val();
      var gid = $("#group").val();
      var temp2=encodeURI(encodeURI($("#temp").val(),"utf-8"));  //客服备注
      window.location.href="<%=request.getContextPath()%>/zhuanjieSubFault.do?conid="+conid+"&gid="+gid+"&temp="+temp2;
   }
  
  //查看附件
 function xzfj(fj){
     window.location.href="downloadTaskUpload.do?url="+fj;
 }
</script>
  <body>
   <div class="dow_top"> <span><a href="javascript:close();">×</a></span> 故障单转接 </div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="border_grey">
  <tr>
    <td><table align="center" width="98%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="59%" class="tab_bottom">客户姓名：${fault.customer.realName}
           <input type="hidden" id="conkoutid" value="${fault.id}"/>
        </td>
        <td width="41%" class="tab_bottom">&nbsp;
                                产品类型：${fault.proudcotType.questionName}
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">IP/账号：
         <c:if test='${ fault.ip!=null  &&   fault.ip=="-1"}'>
                                   未查询出IP地址
         </c:if>
         <c:if test='${fault.ip!=null  &&  fault.ip!="-1"}'>
             ${fault.ip}
         </c:if>
        </td>
        <td class="tab_bottom">&nbsp;
                         问题类型：${fault.issueType.questionName}
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">处理状态：  
                               未转接         
        </td>
        <td class="tab_bottom">&nbsp;手机号码：
            ${fault.customerphone}
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">网站域名：
        <c:if test="${fault.wdnr==null}">
                               暂无
         </c:if>
         <c:if test="${fault.wdnr!=null}">
              ${fault.wdnr}
         </c:if>
        </td>
        <td class="tab_bottom">&nbsp;邮件地址：
        <c:if test="${fault.email==null}">
                               暂无
         </c:if>
         <c:if test="${fault.email!=null}">
              ${fault.email}
         </c:if>
        </td>
      </tr>
      <tr>
        <td colspan="2" class="tab_bottom_c">
                          问题描述：${fault.descs}
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
                <td width="10%" height="49" rowspan="2" align="center">
                </td>
                <td width="90%">
                <c:forEach items="${fjlist}" var="data">
                  ${data.fjmc} <a href="javascript:xzfj('${data.fjlj}');">预览下载</a>,
                </c:forEach>
                <span class="font_color_hui"></span>
                </td>
              </tr>
              
            </table></td>
          </tr>
        </table></td>
        </tr>
        

      <tr>
        <td class="tab_bottomb">运维区域：
          <label for="select"></label>
          <select name="select" id="ywqy" onchange="getOperate()">
            <option value="-1">请选择</option>
            <c:forEach items="${missiointypelist}" var="data">
              <option value="${data.id}">${data.name}</option>
            </c:forEach>
          </select>	
          
          <select name="select2" id="group">
            <option value="-1">请选择</option>
          </select>
          </td>
      </tr>
      
      <tr>
        <td colspan="2" class="tab_bottomb"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="11%" valign="top">客服备注：
              <label for="textfield"></label></td>
            <td width="89%">
              <textarea name="co.temp" id="temp" cols="60" rows="5"></textarea>
            </td>
            </tr>
           
          </table></td>
      </tr>

      <tr>
        <td colspan="2">
        <br /><table width="100%"  height="50" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="34%"></td>
              <td width="16%"><div class="gb_btl"><a style="text-decoration:none;color: white;" href="javascript:zjsub();">转接</a></div></td>
              <td width="50%"><div class="gb_btl"><a style="text-decoration:none;color: white;" href="javascript:close();">关闭</a></div></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
    
  </body>
</html>
