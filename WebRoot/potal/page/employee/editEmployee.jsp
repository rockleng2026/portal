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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<SCRIPT type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js">  
</SCRIPT>
<script type="text/javascript">
	$(function(){
			$("#jb_xx :text").blur(function(){
				if($(this).val()==""){
					if($(this).parent().prev().find("span").html()=="*")
					{
						alert($(this).parent().prev().html().split(";")[1]+"不能为空！");	
					};	
				}
			});
	});
</script>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
a { text-decoration:none}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left; padding-bottom:10px;}
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
 .dj_an { background-color:#50a806; color:#fff; line-height:20px; text-align:center; border:0; width:122px;}
 .sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; margin-top:5px; }
	.sp_nav_tab .nomarl{ width:105px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; background-color:#daf9be;}
	.sp_nav_tab .tj_yh{ width:60px; line-height:25px; margin-left:-8px; color:#295a00;}
	.sp_nav_tab .tj_jh{ width:25px; line-height:25px; margin-left:530px; padding-top:3px;}
	.sp_nav_tab  li { float:left; text-align:center; margin-left:20px;}
	.sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
	.sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
	.td_top{ background-color:#bcbcbc; border-right:1px solid #ffffff;  border-bottom:1px solid #ffffff; text-align:center; line-height:25px;height:25px;}
	.td_top_center{ text-align:center; border:1px solid #bdbdbd}
	.td_top_td{ border-bottom:1px solid #bcbcbc; border-right:1px solid #bcbcbc; border-bottom:1px solid #bcbcbc; line-height:25px;height:25px;}
		.td_top_tdr{border-right:1px solid #bcbcbc; line-height:25px;}
		.td_top_tdb{border-bottom:1px solid #bcbcbc}
		.text_color_lv{ color:#367701}
		.text_color_lv a{ color:#367701; text-decoration:none;}
.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:35px; margin-right:auto; float:left; border:0;}	
.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center;  margin-right:35px; float:right; border:0;}	
.gb_bth{ background-color:#7b7b7b; color:#fff; width:50px; line-height:20px; text-align:center; border:0;}
.gb_bths{ background-color:#7b7b7b; color:#fff; width:80px; line-height:20px; text-align:center; border:0;}
.ls_clj { color:#3a7907;}
.ls_clj a { color:#3a7907;}
.ls_clj a:hover { color:#ff6600;}
</style>
</head>

<body>
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;办公桌面&gt;员工信息&gt;<span class="wzcs">编辑员工信息</span></div>
</div>
<div class="main">
<div class="dow_top">
<span><a href="#">×</a></span>
编辑员工信息
</div>
<div class="dow_nr">
	 <ul class="sp_nav_tab">
<li class="nomarl">基本信息</li>
</ul>
	 <div class="main">
	 <table width="98%" border="1" cellspacing="0" cellpadding="0" id="jb_xx">
  <tr>
    <td align="right"><span class="hs_xh">*</span>&nbsp;姓　　名：</td>
    <td align="left"><input type="text" name="xingMing" size="8" /></td>
    <td width="81" align="right"><span class="hs_xh">*</span>&nbsp;性　　别：
      <label></label></td>
    <td width="98"><input type="radio" name="xingBieNan" value="radiobutton" />
男　
  <input type="radio" name="xingBieNan" value="radiobutton" />
女 </td>
    <td width="97" align="right"><span class="hs_xh">*</span>&nbsp;年　　龄：      </td>
    <td width="119"><input type="text" name="nianLing" size="8" /></td>
    <td width="125" rowspan="4" valign="bottom"><img src="images/yg_tx.jpg" alt="更换头像" width="122" height="139" /></td>
  </tr>
  <tr>
    <td width="112" align="right"><span class="hs_xh">*</span>&nbsp;出生日期：</td>
    <td width="113" align="left"><input type="text" name="chuShengRiQi" size="8" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;民　　族：      </td>
    <td><input type="text" name="MinZu" size="7" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;学　　历：      </td>
    <td width="110"><select name="xueLi" style="width: 110">
      <option value="0">本科　　</option>
      <option value="0">1</option>
      <option value="0">2</option>
    </select></td>
  </tr>
  <tr>
    <td align="right"><span class="hs_xh">*</span>&nbsp;健康状况：</td>
    <td align="left"><input type="text" name="jianKangZhuangKuang" size="8" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;身　　高：      </td>
    <td><input type="text" name="shenGao" size="7" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;体　　重：      </td>
    <td><input type="text" name="tiZhong" size="8" /></td>
  </tr>
  <tr>
    <td align="right"><span class="hs_xh">*</span>&nbsp;联系电话：</td>
    <td align="left"><input type="text" name="lianXiDianHua" size="8" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;员工工号：      </td>
    <td><input type="text" name="yuanGongGongHao" size="7" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;部　　门：      </td>
    <td><select name="buMen" style="width: 110">
      <option value="0">创意中心</option>
      <option value="0">1</option>
      <option value="0">2</option>
    </select></td>
  </tr>
  <tr>
    <td align="right"><span class="hs_xh">*</span>&nbsp;计算机水平：</td>
    <td align="left"><input type="text" name="jiSuanJiShuiPing" size="8" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;外语水平：      </td>
    <td><input type="text" name="waiYuShuiPing" size="7" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;婚　　否：
      <label></label></td>
    <td><label>
    <input type="radio" name="yiHun" value="radiobutton" />
已婚&nbsp;
<input type="radio" name="weiHun" value="radiobutton" />
未婚 </label></td>
    <td valign="top"><input type="submit" name="Submit" value="更换头像" class="dj_an" /></td>
  </tr>
  <tr>
    <td align="right"><span class="hs_xh">*</span>&nbsp;入职时间：</td>
    <td align="left"><input type="text" name="ruZhiShiJian" size="8" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;职　　位：      </td>
    <td><select name="zhiWei">
      <option value="0">主管　　</option>
      <option value="0">1</option>
      <option value="0">2</option>
    </select></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;是否离职：
      <label></label></td>
    <td><input type="radio" name="zaiZhi" value="radiobutton" />
在职&nbsp;
<input type="radio" name="liZhi" value="radiobutton" />
离职 </td>
    <td rowspan="4">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><span class="hs_xh">*</span>&nbsp;身份证号码：</td>
    <td align="left"><input type="text" name="shenFenZhengHaoMa" size="8" /></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;员工级别：      </td>
    <td><select name="yuanGongJiBie">
      <option value="0">六级　　</option>
      <option value="0">1</option>
      <option value="0">2</option>
    </select></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;紧急联系电话：      </td>
    <td><input type="text" name="jinJiLianXiDianHua" size="9" /></td>
  </tr>
  <tr>
    <td colspan="4" align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="28%" align="right"><span class="hs_xh">*</span>&nbsp;户籍地址：</td>
          <td width="72%"><input type="text" name="huJiDiZhi" size="38" /></td>
        </tr>
      </table></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;邮　　箱：      </td>
    <td><input type="text" name="youXiang" size="9" /></td>
  </tr>
  <tr>
    <td colspan="4" align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="28%" align="right"><span class="hs_xh">*</span>&nbsp;家庭住址：</td>
          <td width="72%"><input type="text" name="jiaTingZhuZhi" size="38" /></td>
        </tr>
      </table></td>
    <td align="right"><span class="hs_xh">*</span>&nbsp;创建日期：      </td>
    <td><input type="text" name="chuangJianRiQi" size="9" /></td>
  </tr>
  <tr>
    <td colspan="4" align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="28%" align="right"><span class="hs_xh">*</span>&nbsp;现　住　址：</td>
          <td width="72%"><input type="text" name="xianZhuZhi" size="38" /></td>
        </tr>
      </table></td>
    <td colspan="2">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="113" align="right" valign="top">兴趣特长爱好： </td>
          <td width="507"><label>
            <textarea name="xingQuTeChangAiHao" cols="55" rows="5"></textarea>
          </label></td>
        </tr>
      </table></td>
    <td>&nbsp;</td>
  </tr>
</table>
	   <ul class="sp_nav_tab">
<li class="nomarl">教育阶段</li>
<li class="tj_jh"><img src="images/xtb_jh.jpg" /></li>
<script type="text/javascript">
	function addtr(obj)
	{	
		var $trNode = $("#table4").find("tr:eq(0)").clone(true);
		$trNode.css("border","1px solid red");
		
		$("#"+obj).find("tr:last").after($trNode);
		
	}
	$(function(){
		$("[name=del]").click(function(event){
			event.preventDefault();
			$(this).parent().parent().remove();	
		});	
	});
	
	function deltr(obj)
	{
		alert($(obj).html());
	}
</script>
<li class="tj_yh ls_clj"><a href="javascript:addtr('table1')">添加一行</a></li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center" id="table1">
  <tr class="td_top">
    <td width="126" class="td_top">开始日期</td>
    <td width="126" class="td_top">结束日期</td>
    <td width="199" class="td_top">毕业院校</td>
    <td width="88" class="td_top">学历</td>
    <td width="139" class="td_top" >专业</td>
    <td width="65">操作</td>
  </tr>
  <tr>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">北京大学 </td>
    <td class="td_top_td">本科</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"> <a name="del" href="#" >删除</a>  </td>
  </tr>
  <tr>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">北京大学 </td>
    <td class="td_top_td">本科</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#" >删除</a></td>
  </tr>
   <tr>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">北京大学 </td>
    <td class="td_top_td">本科</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#" >删除</a></td>
  </tr>
</table>
<br />
<ul class="sp_nav_tab">
<li class="nomarl">家庭成员</li>
<li class="tj_jh"><img src="images/xtb_jh.jpg" /></li>
<li class="tj_yh ls_clj"><a href="javascript:addtr('table2')">添加一行</a></li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center" id="table2">
  <tr class="td_top">
    <td width="128" class="td_top">姓名</td>
    <td width="134" class="td_top">关系</td>
    <td width="210" class="td_top">工作单位</td>
    <td width="90" class="td_top">职位</td>
    <td width="148" class="td_top">联系电话</td>
    <td width="65">操作</td>
  </tr>
  <tr>
    <td class="td_top_td">艾鑫</td>
    <td class="td_top_td">父女</td>
    <td class="td_top_td">学校</td>
    <td class="td_top_td">教授</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
  </tr>
  <tr>
    <td class="td_top_td">白微</td>
    <td class="td_top_td">母女</td>
    <td class="td_top_td">学校</td>
    <td class="td_top_td">教授</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
  </tr>
 <tr>
    <td class="td_top_td">艾鑫</td>
    <td class="td_top_td">父女</td>
    <td class="td_top_td">学校</td>
    <td class="td_top_td">教授</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
  </tr>
</table>
<br />
<ul class="sp_nav_tab">
<li class="nomarl">工作经验</li>
<li class="tj_jh"><img src="images/xtb_jh.jpg" /></li>
<li class="tj_yh ls_clj"><a  href="javascript:addtr('table3')">添加一行</a></li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center" id="table3">
  <tr class="td_top">
    <td width="128" class="td_top">开始日期</td>
    <td width="134" class="td_top">结束日期</td>
    <td width="210" class="td_top">公司名称</td>
    <td width="90" class="td_top">职位</td>
    <td width="148" class="td_top">离职原因</td>
    <td width="65">操作</td>
  </tr>
  <tr>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">立云科技 </td>
    <td class="td_top_td">主管</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
  </tr>
  <tr>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">立云科技 </td>
    <td class="td_top_td">主管</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
  </tr>
  <tr>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">2012年9月</td>
    <td class="td_top_td">立云科技 </td>
    <td class="td_top_td">主管</td>
    <td class="td_top_td">广告设计</td>
    <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
  </tr>
</table>
<br />
<ul class="sp_nav_tab">
<li class="nomarl">附件信息</li>
</ul>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="td_top_center" id="load">
  <tr class="td_top">
    <td width="98" align="center" class="td_top">序号</td>
    <td width="205" class="td_top">名称</td>
    <td width="440">上传路径</td>
   </tr>
  <tr>
    <td class="td_top_td">1</td>
    <td class="td_top_td"><select name="select">
      <option value="0">身份证</option>
      <option value="0">1</option>
      <option value="0">2</option>
    </select></td>
    <td class="td_top_td"><label>
      <input type="file" name="file" size="30" />
    </label></td>
    </tr>
  <tr id="lastNode">
    <td height="40">&nbsp;</td>
    <td>&nbsp;</td>
    <td class="td_top_td">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="15%">&nbsp;</td>
            <td width="18%"><input type="submit" name="Submit" value="上传" class="gb_bth" /></td>
            <td width="18%"><input type="submit" name="button" id="addLoad" value="增加" class="gb_bth" /></td>
            <td width="15%"><input type="submit" name="button" id="jianLoad" value="减少" class="gb_bth" /></td>
            <td width="34%"><input type="submit" name="button" id="renounceLoad" value="放弃上传" class="gb_bths" /></td>
          </tr>
        </table>
    </td>
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
<div style="display:none;">
	<table id="table4" style="border:1px solid #bcbcbc;">
    	<tr>
            <td class="td_top_td" style=" border-right: 1px solid #bcbcbc;"></td>
            <td class="td_top_td"  style=" border-right: 1px solid #bcbcbc;"></td>
            <td class="td_top_td"  style=" border-right: 1px solid #bcbcbc;"></td>
            <td class="td_top_td"  style=" border-right: 1px solid #bcbcbc;"></td>
            <td class="td_top_td"  style=" border-right: 1px solid #bcbcbc;"></td>
            <td class="td_top_tdb ls_clj"><a name="del" href="#">删除</a></td>
 		</tr>
         <tr>
    <td class="td_top_td">1</td>
    <td class="td_top_td"><select name="select">
      <option value="0">身份证</option>
      <option value="0">1</option>
      <option value="0">2</option>
    </select></td>
    <td class="td_top_td"><label>
      <input type="file" name="file" size="30" />
    </label></td>
    </tr>
    </table>
</div>
<script type="text/javascript">
$(function(){
	
	//增加的上传事件
	$("#addLoad").click(function(){
		// copy 一份副本
		var $trNode = $("#table4 tr").eq(1).clone(true);
		
		var shuzi = parseInt($("#lastNode").prev().find("td:eq(0)").html())+1;
		if($("#lastNode").prev().hasClass("td_top")){
			 shuzi = 1;
		}
		$trNode.find("td:eq(0)").html(shuzi);
		$("#lastNode").before($trNode);
	});	
	
	//减少的上传事件
	$("#jianLoad").click(function(){
		if($("#lastNode").prev().hasClass("td_top")){
			 $("#table4 tr").eq(1).find("td:eq(0)").html(0);
			
			return;
		}
		$("#lastNode").prev().remove();
	});
}); 
</script>
</body>
</html>
