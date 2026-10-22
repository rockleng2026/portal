<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.utilinterface.PublicMissionType"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="x-ua-compatible" content="ie=7" /> 
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
a { text-decoration:none;}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; }
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:10px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
 .msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
  .msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.rz_box{ border-top:2px solid #4FA805;}
.main1 { width:500px; margin:0 auto;}
.yx_bt { line-height:30px; color:#fff; font-size:14px; font-weight:bold; background-color:#295a00;}
.yx_bt span { color:#81f106;}
.yx_bt a { text-decoration:none; color:#fff;}
.y_x { line-height:30px;  }
.yx_top { background-color:#f4f4f6; border-right:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000;}
.yx_topy { background-color:#f4f4f6; border-bottom:1px solid #c7c8c0;}
.yx_cd { border-bottom:2px solid #e0731e; color:#e1731e; font-size:16px; font-weight:bold; line-height:30px; padding-left:35px;}
.yx_cd span { font-size:12px; font-weight:normal;}
.wd_xx { font-weight:bold;}
.hui{ color:#3b393a; line-height:30px; font-size:12px;}
.hui a{color:#3b393a;}
.hui a:hover{ color:#FFF; background-color:#5da601;}
.td_bcolor{ border-bottom:1px solid #e6dcdd; border-right:1px solid #e6dcdd}
.yx_xhx { border-bottom:1px solid #e7e7e7;}
.wz_hs { color:#ff0000;}
.ss_hd { background-color:#e5e5e5; padding-left:5px; line-height:30px; width:350px;}
.tj_fj { color:#e1731c;}
.tj_fj a { color:#e1731c;}
.yx_an { background-color:#5da601; color:#fff; line-height:20px; width:50px; text-align:center;}
#l_h { line-height:25px;}
.xz_ry { padding-left:20px; line-height:20px; overflow-y:auto; height:90px; border:1px solid #e1dfe0; border-top-width:0px;}
.wz_cs { color:#e1731c; font-weight:bold;}
.xz_l { background-color:#e1dfe0; font-weight:bold; padding-left:5px;}
.zw_pd { padding-top:10px;}
.biaodan_2{width:418px; height:120px; border:1px solid #e9ecf1; border-top:1px solid #aaadb2; overflow:hidden}
</style>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript">
function load(){
	    var id=$("#id").val();
	    var logno=$("#logno").val();
		form1.action="add2message.do?id="+id+"&logno="+logno;
		form1.submit();
}
</script>
<form action="" method="post" name="form1" id="form1">
<div class="main1">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="yx_bt">
  <tr>
    <td width="15%" align="center">发送消息</td>
    <td width="17%" align="center">&nbsp;</td>
    <td width="17%" align="center">&nbsp;</td>
    <td width="17%" align="center">&nbsp;</td>
    <td width="17%" align="center">&nbsp;</td>
    <td width="17%" align="right"><a href="javascript:void();" onclick="yingcang()">×</a>&nbsp;&nbsp;</td>
  </tr>
</table>
</div>
<div class="main1">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="y_x">
  <tr>
    <td colspan="5" align="center" class="yx_top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="14%" align="right">消息类型：</td>
    <td width="86%" align="left"><label>
      <select><option value="<%=PublicMissionType.plantype%>">日志问询</option></select>
    </label></td>
    </tr>
  <tr>
    <td align="right">收件人：</td>
    <td align="left"><label>
      <input type="text" readonly="readonly"  value="${sche.employee.name }" style="width:400px;"/>
      <input type="hidden"  name="receiver.receiverer" value="${sche.employee.id }" />
      <input type="hidden" name="receiver.planid" value="${sche.id }"/>
      <input type="hidden" id="id" value="${id }" />
      <input type="hidden" id="logno" value="${logno }" />
    </label></td>
    </tr>
  <tr>
    <td align="right">标题：</td>
    <td align="left"><label>
      <input name="receiver.message.titleweb" type="text" style="width: 400px;"/>
    </label></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="left" class="tj_fj"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="6%"><img src="images/xtb_scfj.jpg" width="24" height="20" /></td>
          <td width="94%">添加附件 </td>
        </tr>
      </table></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="left"><div class="ss_hd">文件名.jpg&nbsp;&nbsp;正在上传&nbsp;&nbsp;删除</div></td>
    </tr>
  <tr>
    <td align="right" valign="top" class="zw_pd">内容：</td>
    <td align="left" class="zw_pd">
       <textarea name="receiver.message.messagecontent" cols="" rows="" class="biaodan_2"></textarea>
    </td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15%" height="39">&nbsp;</td>
        <td width="15%"><input name="" type="button" value="发送" onclick="load()"/></td>
        <td width="15%"><input name="" type="reset" value="重置"/></td>
        <td width="15%"><input name="" type="button" value="关闭" onclick="yingcang()"/></td>
        <td width="40%">&nbsp;</td>
      </tr>
    </table></td>
    </tr>
</table>
</td>
    </tr>
</table>
</div>
</form>