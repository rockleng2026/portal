<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 

<title>无标题文档</title>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left;  padding-bottom:10px;}
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
.main { width:760px; margin:0 auto;}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.wcm_u { color:#295a01; line-height:70px; font-size:14px; padding-left:15px; font-weight:bold;}
.wcm_t { color:#b1afb0; font-size:12px; line-height:70px; font-weight:normal;}
.cont_bg { width:650px; margin-bottom:30px; padding-left:15px;}
.yjbk_h { width:179px; line-height:66px; background:url(images/yjbk_h.jpg) no-repeat; text-align:center;}
.yjbk_h a { text-decoration:none; color:#000000;}
.yjbk_h a:hover { color:#3b8801; background:url(images/yjbk_l.jpg) no-repeat; width:179px; display:block; line-height:66px; text-align:center;}
.zx_xx{width:595px; height:26px; background:#eeeeee; padding-left:10px; float:left; line-height:26px; color:#000000; font-size:12px; border:1px solid #a8a8a8; overflow:hidden}
.zx_xx span{float:right; padding-right:10px; padding-top:1px;}
.zx_xx a{color:#000000; font-size:14px; font-weight:bold; text-decoration:none}
.zxxx_nr{width:600px; border:1px solid #a8a8a8; border-top-width:0;  float:left; padding-left:5px; line-height:25px; height:190px; overflow-y:auto;}
.lbd { height:25px; border-bottom:1px solid #295A00;}
.lbd li{
text-align:center; font-size:15px;margin-top:10px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 2px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#daf9be; z-index:1; }
 #jb_xx { line-height:30px;}
 .hs_xh { color:#FF0000;}
 .dj_an { background-color:#50a806; color:#fff; line-height:30px; text-align:center;}
 .sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; margin-top:5px; }
	.sp_nav_tab .nomarl{ width:105px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; background-color:#daf9be;}
	.sp_nav_tab  li { float:left; text-align:center; margin-left:20px;}
	.sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
	.sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
	.td_top{ background-color:#bcbcbc; border-right:1px solid #ffffff; text-align:center; line-height:25px;}
	.td_top_center{ text-align:center; border:1px solid #bdbdbd}
	.td_top_td{ border-bottom:1px solid #bcbcbc; border-right:1px solid #bcbcbc; line-height:25px;}
		.td_top_tdr{border-right:1px solid #bcbcbc; line-height:25px;}
		.td_top_tdb{border-bottom:1px solid #bcbcbc}
		.text_color_lv{ color:#367701}
		.text_color_lv a{ color:#367701; text-decoration:none;}
		.text_color_lv a:hover{ color:red; text-decoration:none;}
.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:35px; margin-right:auto; float:left; border:0;}	
.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center;  margin-right:35px; float:right; border:0;}	
</style>
<SCRIPT type="text/javascript">
	
	function xzfj(fj){
     window.location.href="download1TaskUpload.do?url="+fj;
 }
 </script>
</head>

<body>
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;办公桌面&gt;员工信息&gt;<span class="wzcs">员工信息</span></div>
</div>
<div class="main">
<div class="dow_top">
<span><a href="#">×</a></span>
员工详细信息
</div>
<div class="dow_nr">
	 <ul class="sp_nav_tab">
<li class="nomarl">基本信息</li>
</ul>
	 <div class="main">
<table width="98%" border="0" cellspacing="0" cellpadding="0" id="jb_xx">
  <tr>
    <td width="80" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：      &nbsp;&nbsp;${empDetial.name }</td>
    <td width="23%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：<c:if test="${empDetial.sex==1||empDetial.sex==null}">
											男
											
											</c:if>
											<c:if test="${empDetial.sex==2}">
										
											女
											</c:if>
      </td>
    <td width="32%">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：   	${empDetial.age }   </td>
    <td width="16%" rowspan="4"><img src="${empDetial.photo }" width="120" height="139" /></td>
  </tr>
  <tr>
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出生日期：      &nbsp;&nbsp;	${empDetial.birth }</td>
    <td>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：     ${empDetial.nation } </td>
    <td>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历：    ${empDetial.education }  </td>
    </tr>
  <tr>
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;健康状况：      &nbsp;&nbsp;${empDetial.health}</td>
    <td>身&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高：     ${empDetial.stature } </td>
    <td>体&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;重：    ${empDetial.heft }  </td>
    </tr>
  <tr>
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系电话：      &nbsp;&nbsp;${empDetial.tel }</td>
    <td>员工工号：${empDetial.empNo }      </td>
    <td>部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：   ${empDetial.department.name }   </td>
    </tr>
  <tr>
    <td align="left">&nbsp;计算机水平：      &nbsp;&nbsp;	${empDetial.computeleve }</td>
    <td>外语水平：   ${empDetial.engleve }   </td>
    <td>婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;否：
      </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;入职时间：      &nbsp;&nbsp;${empDetial.entryTime}</td>
    <td>职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：   ${empDetial.workposition.name }  </td>
    <td>是否离职：
      <c:if test="${empDetial.isLeave==1}">在职</c:if>
      <c:if test="${empDetial.isLeave==0}">离职</c:if>
      </td>
    <td rowspan="4">&nbsp;</td>
  </tr>
  <tr>
    <td align="left">&nbsp;身份证号：${empDetial.cardid }</td>
 
    <td>员工级别：     
       <c:if test="${empDetial.empgrade.gradeNum==1}">一级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==2}">二级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==3}">三级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==4}">四级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==5}">五级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==6}">六级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==7}">七级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==8}">八级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==9}">九级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==10}">十级</c:if>
    <c:if test="${empDetial.empgrade.gradeNum==11}">十一级</c:if>
    
    
											 	</td>
    <td>紧急联系电话：      ${empDetial.urgenttel }</td>
    </tr>
  <tr>
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户籍地址：      &nbsp;&nbsp;${empDetial.censusreg }</td>
    <td>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：   ${empDetial.email }   </td>
    </tr>
  <tr>
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家庭住址：${empDetial.place }
      &nbsp;&nbsp;</td>
    <td>创建日期：    ${empDetial.time }  </td>
    </tr>
  <tr>
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;现&nbsp;&nbsp;住&nbsp;&nbsp;址：${empDetial.nowplace }
      &nbsp;&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="85" valign="top">兴趣特长爱好： </td>
          <td><label></label></td>
        </tr>
      </table></td>
    <td>${empDetial.specialty }</td>
  </tr>
</table>
<ul class="sp_nav_tab">
<li class="nomarl">教育阶段</li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center">
  <tr class="td_top">
    <td width="128" class="td_top">开始日期</td>
    <td width="134" class="td_top">结束日期</td>
    <td width="210" class="td_top">毕业院校</td>
    <td width="90" class="td_top">学历</td>
    <td>专业</td>
  </tr>
  
  <c:forEach items="${fplist}" var="fplist1">
  <c:if test='${fplist1.fieldRemark.id==2}'>
  <tr>
    <td class="td_top_td">${fplist1.temp2}</td>
    <td class="td_top_td">${fplist1.temp3}</td>
    <td class="td_top_td">${fplist1.temp1}</td>
    <td class="td_top_td">${fplist1.temp5}</td>
    <td class="td_top_tdb">${fplist1.temp4}</td>
   
  </tr>
  </c:if>
  </c:forEach>
  
</table>
<br />
<ul class="sp_nav_tab">
<li class="nomarl">家庭成员</li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center">
  <tr class="td_top">
    <td width="128" class="td_top">姓名</td>
    <td width="134" class="td_top">关系</td>
    <td width="210" class="td_top">工作单位</td>
    <td width="90" class="td_top">职位</td>
    <td>联系电话</td>
  </tr>
  <c:forEach items="${fplist}" var="fplist2">
  <c:if test='${fplist2.fieldRemark.id==1}'>
  <tr>
    <td class="td_top_td">${fplist2.temp1}</td>
    <td class="td_top_td">${fplist2.temp2}</td>
    <td class="td_top_td">${fplist2.temp4}</td>
    <td class="td_top_td">${fplist2.temp3}</td>
    <td class="td_top_tdb">${fplist2.temp5}</td>
   
  </tr>
  </c:if>
  </c:forEach>
</table>
<br />
<ul class="sp_nav_tab">
<li class="nomarl">工作经验</li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center">
  <tr class="td_top">
    <td width="128" class="td_top">开始日期</td>
    <td width="134" class="td_top">结束日期</td>
    <td width="210" class="td_top">公司名称</td>
    <td width="90" class="td_top">职位</td>
    <td>离职原因</td>
  </tr>
   <c:forEach items="${fplist}" var="fplist3">
  <c:if test='${fplist3.fieldRemark.id==3}'>
  <tr>
    <td class="td_top_td">${fplist3.temp2}</td>
    <td class="td_top_td">${fplist3.temp3}</td>
    <td class="td_top_td">${fplist3.temp1}</td>
    <td class="td_top_td">${fplist3.temp4}</td>
    <td class="td_top_tdb">${fplist3.temp5}</td>
 
  </tr>
  </c:if>
  </c:forEach>
 
</table>
<br />
<ul class="sp_nav_tab">
<li class="nomarl">附件信息</li>
</ul>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="60px">
  <tr>
    <td width="99" align="center" class="text_color_lv">预览附件：</td>
    <c:forEach  items="${fjlb1}" var="fjlb1">
    <td width="225"><table width="93%" border="0" cellspacing="0" cellpadding="0">
    
      <tr>
        <td width="22%" rowspan="2" align="center"><img src="<%=basePath%>potal/images/ygxx_rar.png" width="33" height="39" /></td>
        <td width="78%"><b class="hui"></b>${fjlb1.fjmc}<span><br/><a href="javascript:xzfj('${fjlb1.fjlj}')" onclick="xzfj('${fjlb1.fjlj}')" target="_blank">预览下载</a></td>
      </tr>

    </table></td>
         </c:forEach>
  </tr>
</table>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><input type="submit" name="Submit" value="确认" class="gb_btr" /></td>
    <td><input type="submit" name="Submit" value="取消" class="gb_btl" /></td>
  </tr>
</table>
</div>
</div>

</div>
</body>
</html>
