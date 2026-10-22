
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String basePath1 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
		<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
		<%@ taglib uri="/struts-tags" prefix="s"%>
		<%@ page language="java" contentType="text/html; charset=GBK"%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<%@ taglib prefix="s" uri="/struts-tags"%>
		<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>

		<title>无标题文档</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />

	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js">
</script>
	


		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
		<style type="text/css">
body {
	width: 760px;
	margin: 0 auto;
	font-size: 12px
}
.d1{

position:fixed;
 display: block;
 top: 190px;left:
  650px;z-index:10000;

}
img {
	border: 0
}

a {
	text-decoration: none
}

dl,dd,dt,p,input {
	padding: 0px;
	margin: 0px;
}

.dow {
	width: 760px;
	height: 230px;
	float: left
}

.dow_top {
	width: 750px;
	height: 26px;
	background: #3c8301;
	padding-left: 10px;
	float: left;
	line-height: 26px;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	overflow: hidden
}

.dow_top span {
	float: right;
	padding-right: 10px;
	padding-top: 1px;
}

.dow_top a {
	color: #FFFFFF;
	font-size: 14px;
	font-weight: bold;
	text-decoration: none
}

.dow_nr {
	width: 758px;
	border: 1px solid #455c32;
	float: left;
	padding-bottom: 10px;
}

.tc_form {
	width: 750px;
	float: left;
	line-height: 23px;
}

.tc_form dd {
	width: 530px;
	float: left;
	text-align: right;
}

.tc_form dt {
	width: 210px;
	float: left;
	text-align: left;
	padding-left: 10px;
}

.tc_form dt span {
	width: 50px;
	float: right
}

.tc_form dt span a {
	width: 45px;
	float: left;
	text-align: center;
	color: #FFFFFF;
	text-decoration: none;
	height: 21px;
	background: #519300;
	line-height: 21px;
}

.text {
	height: 19px;
	border: 1px solid #b2b2b2
}

.foot {
	padding-right: 15px
}

.foot a {
	height: 24px;
	padding: 5px;
	text-decoration: none;
	color: #000000
}

}
.foot a:hover {
	background: #5da500;
	color: #FFFFFF
}

.tc_top {
	background: #7b7b7b;
	color: #FFFFFF
}

.tc_footb {
	border-bottom: 1px solid #c3c3c3
}

.tc_footb a {
	text-decoration: none;
	color: #ff9002;
}

.tc_footb a:hover {
	background: #5da601;
	float: left;
	width: 100%;
	color: #FFFFFF;
	line-height: 26px;
	clear: both;
}

.tc_rightb {
	border-right: 1px solid #c3c3c3
}

/*hongbinma */
ul,ul li {
	margin: 0px;
	padding: 0px;
	list-style: none;
}

.foot1 {
	padding-right: 15px
}

.text1 {
	width: 145px;
	height: 19px;
	border: 1px solid #b2b2b2
}

.lb {
	height: 25px;
	border-bottom: 1px solid #295A00;
}

.lb li {
	text-align: center;
	font-size: 15px;
	margin-top: 10px;
	border: 1px solid #295A00;
	width: 115px;
	margin-left: 20px;
	padding: 5px 5px 3px 5px;
	border-bottom-width: 0px;
	position: relative;
	background-color: #fff;
	z-index: 1;
}

.msg {
	border: #FFDAAD 1px solid;
	line-height: 20px;
	background-color: #FFFBF2
}

.msgshow .c {
	background: url(images/c1.png) no-repeat 100px 0px;
	height: 7px;
	position: relative;
	margin-bottom: -1px;
	z-index: 1;
}

.rz_box {
	border-top: 2px solid #4FA805;
}

.main {
	width: 760px;
	margin: 0 auto;
}

.wzdh {
	line-height: 25px;
}

.wzls {
	color: #3b8801;
}

.wzcs {
	color: #ff6600;
}

.wcm_u {
	color: #295a01;
	line-height: 70px;
	font-size: 14px;
	padding-left: 15px;
	font-weight: bold;
}

.wcm_t {
	color: #b1afb0;
	font-size: 12px;
	line-height: 70px;
	font-weight: normal;
}

.cont_bg {
	width: 650px;
	margin-bottom: 30px;
	padding-left: 15px;
}

.yjbk_h {
	width: 179px;
	line-height: 66px;
	background: url(images/yjbk_h.jpg) no-repeat;
	text-align: center;
}

.yjbk_h a {
	text-decoration: none;
	color: #000000;
}

.yjbk_h a:hover {
	color: #3b8801;
	background: url(images/yjbk_l.jpg) no-repeat;
	width: 179px;
	display: block;
	line-height: 66px;
	text-align: center;
}

.zx_xx {
	width: 595px;
	height: 26px;
	background: #eeeeee;
	padding-left: 10px;
	float: left;
	line-height: 26px;
	color: #000000;
	font-size: 12px;
	border: 1px solid #a8a8a8;
	overflow: hidden
}

.zx_xx span {
	float: right;
	padding-right: 10px;
	padding-top: 1px;
}

.zx_xx a {
	color: #000000;
	font-size: 14px;
	font-weight: bold;
	text-decoration: none
}

.zxxx_nr {
	width: 600px;
	border: 1px solid #a8a8a8;
	border-top-width: 0;
	float: left;
	padding-left: 5px;
	line-height: 25px;
	height: 190px;
	overflow-y: auto;
}

.lbd {
	height: 25px;
	border-bottom: 1px solid #295A00;
}

.lbd li {
	text-align: center;
	font-size: 15px;
	margin-top: 10px;
	border: 1px solid #295A00;
	width: 115px;
	margin-left: 20px;
	padding: 5px 5px 2px 5px;
	border-bottom-width: 0px;
	position: relative;
	background-color: #daf9be;
	z-index: 1;
}

#jb_xx {
	line-height: 30px;
}

.hs_xh {
	color: #FF0000;
}

.dj_an {
	background-color: #50a806;
	color: #fff;
	line-height: 20px;
	text-align: center;
	border: 0;
	width: 122px;
}

.sp_nav_tab {
	border-bottom: 1px solid #295A00;
	height: 26px;
	margin-top: 5px;
	line-height: 26px;
}

.sp_nav_tab .nomarl {
	width: 105px;
	line-height: 25px;
	border: 1px solid #295A00;
	border-bottom-width: 0;
	background-color: #daf9be;
	height: 26px;
}

.sp_nav_tab .tj_yh {
	width: 60px;
	line-height: 25px;
	margin-left: -8px;
	color: #295a00;
	height: 25px;
}

.sp_nav_tab .tj_jh {
	width: 25px;
	line-height: 25px;
	margin-left: 530px;
	padding-top: 3px;
	height: 25px;
}

.sp_nav_tab  li {
	float: left;
	text-align: center;
	margin-left: 20px;
}

.sp_nav_tab    .sq {
	width: 8px;
	height: 8px;
	background-color: #295A00;
	margin-top: 9px;
}

.sp_nav_tab .active {
	background-color: #fff;
	width: 95px;
	line-height: 25px;
	border: 1px solid #295A00;
	border-bottom-width: 0;
	position: relative;
	margin-top: 1px;
}

.td_top {
	background-color: #bcbcbc;
	border-right: 1px solid #ffffff;
	text-align: center;
	line-height: 25px;
}

.td_top_center {
	text-align: center;
	border: 1px solid #bdbdbd
}

.td_top_td {
	border-bottom: 1px solid #bcbcbc;
	border-right: 1px solid #bcbcbc;
	line-height: 25px;
}

.td_top_tdr {
	border-right: 1px solid #bcbcbc;
	line-height: 25px;
}

.td_top_tdb {
	border-bottom: 1px solid #bcbcbc
}

.text_color_lv {
	color: #367701
}

.text_color_lv a {
	color: #367701;
	text-decoration: none;
}

.gb_btl {
	background-color: #4FA805;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 25px;
	text-align: center;
	margin-left: 35px;
	margin-right: auto;
	float: left;
	border: 0;
}

.gb_btr {
	background-color: #4FA805;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 25px;
	text-align: center;
	margin-right: 35px;
	float: right;
	border: 0;
}

.gb_bth {
	background-color: #7b7b7b;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	border: 0;
}

.gb_bths {
	background-color: #7b7b7b;
	color: #fff;
	width: 80px;
	line-height: 20px;
	text-align: center;
	border: 0;
}

.ls_clj {
	color: #3a7907;
}

.ls_clj a {
	color: #3a7907;
}

.ls_clj a:hover {
	color: #ff6600;
}

.newadd {
	border: 0px;
	text-align: center;
}
</style>
	<script type="text/javascript">
                    
				function emailisok()
{
	
	var email=document.getElementById("email").value;
	if (email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
	{
		$("#cemail").html("");
		return true;
	}
	else
	{
		 $("#cemail").html("输入有误！！");
		 return false;
	}

	
}
function tj(){

var a=1;
$("input:text", document.forms[0]).each(function(){

if(this.value==""){

					if($(this).parent().prev().find("span").html()=="*")
					{
						alert($(this).parent().prev().html().split(";")[1]+"不能为空！");	
						
					};	
					 a++;
					return false;
}

}); 
if($("#deptlist").val()=="-1"){


  alert("请选择部门!");
  return;
}
if(a==1){
var t1 = $("table[id$='table1']>tbody").children("tr").length;
var t2 = $("table[id$='table2']>tbody").children("tr").length;
var t3 = $("table[id$='table3']>tbody").children("tr").length;
 var xueLi1=$("#xueLi").find("option:selected").text();

$("#formaddss").attr("action","addEmpemp.do?t1="+t1+"&t2="+t2+"&t3="+t3+"&xueLi1="+xueLi1);
$("#formaddss").submit();
}
}
 
  function uploadImage11() {
	        var img1=$('#img1').val();
		
									  
		var files=$("#fileupload").val();
		alert(files);
		if(files == null || files == "")
		{
		alert("请选择要上传的文件");
		
		return;
		}
	$(document)
			.ready(
					function() {
						var options = {
						    url : "uploademp.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									
									var pathi=$('#pathi').val();
									var va=pathi+data[1];
								    
								   $('#imga1').attr('src',va);
								   $('#img1').attr('value',va);
								   
									
								} else {
								
								}
							}
						};
						
						$("#formaddss").ajaxSubmit(options);
						return false;
					});
                  }		
	

	$(document).ready(function(){ 
 	$("#scfjs").bind("click",function(){
    $("#fileupload").click();
	});
	
	$("#deptlist").bind("change",function(){
	 var deptid=$("#deptlist").val();
	$.ajax({
	   url:'selworkpositionemp.do',
	   type:'post',
	   data:{deptid:deptid},
	   success:function(res){
	   $("#zhiWei").remove();
	   $("#d2").append('<select id="zhiWei" name="zhiWei"></select>');
	  $("#zhiWei").append(res);
	   
	   }
	
	
	});
	
	});
	$("#jb_xx :text").click(function(){
	
	

		
	});
 	});
  function aaaa() {
 		uploadImage11();
	   

 }

	function addtr(obj)
	
	{	
	
	 var intGridviewRowCount = $("table[id$='"+obj+"']>tbody").children("tr").length;
	var ida=intGridviewRowCount+1;
	var ids=ida+obj;
	alert(ids);
	var inputid=""
	 var name1="";
	  var name2="";
	  var name3="";
	  var name4="";
	  var name5="";
	if(obj=="table1"){
	  name1="begintime";
	  name2="endtime";
	   name3="schoolname";
	  name4="xueli";
	  name5="zhuanye";
	}else if(obj=="table2"){
	   name1="tname";
	   name2="guanxi";
	   name3="danwei";
	   name4="position";
	   name5="phone"
	
	}else{
	 name1="btime";
	   name2="etime";
	   name3="conname";
	  name4="positiontwo";
	   name5="leavename";
	
	}
	var rq="yyyy-MM-dd";
	
	    if(obj=="table2"){
		var trNode = "<tr id='"+ids+"'  height='24'> <td class='td_top_td'><input name='"+name1+ida+"' class='newadd' type='text' style='width: 100px' size='70px'/></td> <td class='td_top_td'><input type='text' name='"+name2+ida+"' class='newadd' style='width: 100px' size='70px'/></td> <td class='td_top_td'><input name='"+name3+ida+"' type='text' class='newadd' style='width: 100px' size='70px'/> </td><td class='td_top_td'><input class='newadd' name='"+name4+ida+"' type='text' style='width: 100px' size='70px'/></td><td class='td_top_td'><input name='"+name5+ida+"' id='"+name5+ida+"' class='newadd' type='text' style='width: 100px' size='70px' /></td><td class='td_top_tdb ls_clj'><a  onclick='deltr1("+'"'+ids+'"'+")'>删除</a></td></tr>";
		//trNode.css("border","1px solid red");
	
		$("#"+obj).find("tr:last").after(trNode);
		}else{
		var trNode = "<tr id='"+ids+"'  height='24'> <td class='td_top_td'><input name='"+name1+ida+"' onclick='WdatePicker({dateFmt:"+'"'+"yyyy-MM-dd"+'"'+"})' class='newadd' type='text' style='width: 100px' size='70px'/></td> <td class='td_top_td'><input type='text' name='"+name2+ida+"' onclick='WdatePicker({dateFmt:"+'"'+"yyyy-MM-dd"+'"'+"})' class='newadd' style='width: 100px' size='70px'/></td> <td class='td_top_td'><input name='"+name3+ida+"' type='text' class='newadd' style='width: 100px' size='70px'/> </td><td class='td_top_td'><input class='newadd' name='"+name4+ida+"' type='text' style='width: 100px' size='70px'/></td><td class='td_top_td'><input name='"+name5+ida+"' class='newadd' type='text' style='width: 100px' size='70px'/></td><td class='td_top_tdb ls_clj'><a  onclick='deltr1("+'"'+ids+'"'+")'>删除</a></td></tr>";
		//trNode.css("border","1px solid red");
		
		$("#"+obj).find("tr:last").after(trNode);
		
		}
	}
	function aa(a){
	alert(a);
	}
	 function deltr1(index){   
   alert(index);
    //alert(index);   
   //  alert("tr[id=\'"+index+"\']");   
     //  $table=$("#tab tr");   
    //   if(index>$table.length)   
     //      return;   
     //   else   
    // {   
          $("tr[id='"+index+"']").remove();    
            //$("tr:gt('"+index+"')").each                 
        //  for(var temp=index+1;temp<=$table.length;temp++)   
       //  {   
                //$("#tab").append("<tr id="+(temp-1)+"><td align=\'center\'>"+(temp-2)+"</td><td //align=\'center\'>jQuery"+(temp-2)+"</td><td align=\'center\'><a href=\'#\' onclick=\'deltr("+(temp-1)+")\'>删除//</a></td></tr>");         //      $("tr[id=\'"+temp+"\']").replaceWith("<tr id="+(temp-1)+"><td align=\'center\'>"+(temp-2)+"</td><td //align=\'center\'>jQuery"+(temp-2)+"</td><td align=\'center\'><a href=\'#\' onclick=\'deltr("+(temp-1)+")\'>删除//</a></td></tr>");   
        //  }      
      //  }      
   }   
 
	

</script>
	</head>

	<body>
		<div class="main">
			<div class="wzdh">
				<span class="wzls">您的位置</span>：首页&gt;办公桌面&gt;员工信息&gt;
				<span class="wzcs">新增员工信息</span>
			</div>
		</div>
		<div class="main">
			<div class="dow_top">
				<span><a href="#">×</a>
				</span> 新增员工信息
			</div>
			<div class="dow_nr">
				
				<div class="main">
					<form name="formaddss" id="formaddss" method="post" action="addEmpemp.do">
						<table width="98%" border="0" cellspacing="0" cellpadding="0"
							id="jb_xx">
							<ul class="sp_nav_tab">
					<li class="nomarl">
						基本信息
					</li>
				</ul><tr>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;姓 名：
								</td>
								<td align="left">
									<input type="text" id="name" onblur="checkValueByRules3('name','')" name="xingMing" size="8" />
								</td>
								<td width="81" align="right">
									<span class="hs_xh">*</span>&nbsp;性 别：
									<label></label>
								</td>
								<td width="98">
									<input type="radio" name="xingBie" value="1" checked="checked" />
									男
									<input type="radio" name="xingBie" value="2" />
									女
								</td>
								<td width="97" align="right">
									<span class="hs_xh">*</span>&nbsp;年 龄：
								</td>
								<td width="119">
									<input type="text" name="nianLing" size="8" />
								</td>

								<td width="125" rowspan="4" valign="bottom">
									<input type="hidden" id="img1" name="img1" value="" />
									<img src="potal/images/sc_tt.jpg" id="imga1" width="122" height="110" />
								</td>
							</tr>
							<tr>
								<td width="112" align="right">
									<span class="hs_xh">*</span>&nbsp;出生日期：
								</td>
								<td width="113" align="left">
									<input type="text" name="chuShengRiQi" size="8"  onclick='WdatePicker({dateFmt:"yyyy-MM-dd"})'/>
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;民 族：
								</td>
								<td>
									<input type="text" name="MinZu" size="7" />
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;学 历：
								</td>
								<td>
									<select id="xueLi" name="xueLi" style="width: 110px;">
										<option value="0">
											高中
										</option>
										<option value="1">
											中专
										</option>
										<option value="2">
											大专
										</option>
										<option value="3">
											大专
										</option>
										<option value="4">
											本科
										</option>
										<option value="5">
											研究生
										</option>
										<option value="6">
											硕士
										</option>

									</select>
								</td>
							</tr>
							<tr>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;健康状况：
								</td>
								<td align="left">
									<input type="text" name="jianKangZhuangKuang" size="8" />
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;身 高：
								</td>
								<td>
									<input type="text" name="shenGao" id="shenGao" size="7" onblur="checkValueByRules3('shenGao',['float'])"/>
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;体 重：
								</td>
								<td>
									<input type="text" name="tiZhong" size="8" />
								</td>
							</tr>
							<tr>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;联系电话：
								</td>
								<td align="left">
									<input type="text" id="lianXiDianHua" name="lianXiDianHua" size="8"  onblur="checkValueByRules3('lianXiDianHua',['phone'])"/>
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;员工工号：
								</td>
								<td>
									<input type="hidden" value="0" id="ygh"/>
									<input type="text" name="yuanGongGongHao" id="yuanGongGongHao" size="7"  onblur="CheckFormTwoempno(this.value)" />
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;部 门：
								</td>
								<td>
									${deptlist}
								</td>
							</tr>
							<tr>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;计算机水平：
								</td>
								<td align="left">
									<input type="text" name="jiSuanJiShuiPing" size="8" />
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;外语水平：
								</td>
								<td>
									<input type="text" name="waiYuShuiPing" size="7" />
								</td>
								<td align="right">
									<span class="hs_xh">*</span>&nbsp;婚 否：
									<label></label>
								</td>
								<td>
									<label>
										<input type="radio" name="weiHun" value="radiobutton"  />
										已婚&nbsp;
										<input type="radio" name="weiHun" value="radiobutton" checked="checked" />
										未婚
									</label>
								</td>
								<td >
								
									<div style=" display: block;">
										<span style="display: none" ><a
											href="javascript:void(0);" 
											onmouseover="showpic()" onmouseout="hidepic()"></a> <a
											href="javascript:void(0);" id="pic_delete" title="删除"
											onclick="delpic()" style="padding: left : 20px">删除</a> </span>
										<div style="position:relative;top: 0px; left: 8px;width: 120px;">
												<input type="file" name="fileupload" size="1"
													id="fileupload" onchange="uploadImage11()"
													style="overflow: hidden; height: 18px; width: 120px; opacity: 0; filter: alpha(Opacity = 0);" />
											
										</div>
												<div class="d1" style="position:absolute; display: block;top: 200px;left: 646px;z-index:1000" >
											<p class="dj_an"
													style=" display: block;width: 120px; hight: 20px;" />上传照片
												</p>
										</div>
									</div>
									
								</td>
							</tr>


							<input id="pathi" style="margin-bottom: 20px;" type="hidden"
								value="<%=basePath1%>">
								<tr>
									<td align="right">
									<%   java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat(
			"yyyy-MM-dd ");
		 // 得到当前时间
		 	Date now = new Date();
			String nowstr = dateFormat2.format(now);%>
										<span class="hs_xh">*</span>&nbsp;入职时间：
									</td>
									<td align="left">
										<input type="text" name="ruZhiShiJian" size="8" onclick='WdatePicker({dateFmt:"yyyy-MM-dd"})'/>
									</td>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;职 位：
									</td>
									<td>
										<div id="d2">
											<select id="zhiWei" name="zhiWei">

											</select>
										</div>
									</td>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;是否离职：
										<label></label>
									</td>
									<td>
										<input type="radio" name="liZhi" value="radiobutton"  checked="checked"/>
										在职&nbsp;
										<input type="radio" name="liZhi" value="radiobutton" />
										离职
									</td>
									<td rowspan="4">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;身份证号码：
									</td>
									<td align="left">
										<input type="text" id="shenFenZhengHaoMa" name="shenFenZhengHaoMa" size="8"  onblur="CheckFormTwoidcard(this.value)"/>
										<input type="hidden" id="sfj" value="0"/>
									</td>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;员工级别：
									</td>
									<td>
										<select name="yuanGongJiBie">
											<option value="1">
												一级
											</option>
											<option value="2">
												二级
											</option>
											<option value="3">
												三级
											</option>
											<option value="4">
												四级
											</option>
											<option value="5">
												五级
											</option>
											<option value="6">
												六级
											</option>
											<option value="7">
												七级
											</option>
											<option value="8">
												八级
											</option>
											<option value="9">
												九级
											</option>
											<option value="10">
												十级
											</option>
											<option value="11">
												十一级
											</option>
										</select>
									</td>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;紧急联系电话：
									</td>
									<td>
										<input type="text" name="jinJiLianXiDianHua" id="jinJiLianXiDianHua" size="9" onblur="checkValueByRules3('jinJiLianXiDianHua',['phone'])"/>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="left">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="28%" align="right">
													<span class="hs_xh">*</span>&nbsp;户籍地址：
												</td>
												<td width="72%">
													<input type="text" name="huJiDiZhi" size="38" />
												</td>
											</tr>
										</table>
									</td>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;邮 箱：
									</td>
									<td>
									<input type="hidden" id="yxdz" value="0"/>
									
										<input type="text" id="" name="youXiang" size="9" onblur="emailisok()"/>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="left">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="28%" align="right">
													<span class="hs_xh">*</span>&nbsp;家庭住址：
												</td>
												<td width="72%">
													<input type="text" name="jiaTingZhuZhi" size="38" />
												</td>
											</tr>
										</table>
									</td>
									<td align="right">
										<span class="hs_xh">*</span>&nbsp;创建日期：
									</td>
									<td>
										<input type="text" name="chuangJianRiQi" size="9"  value="<%=nowstr %>" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="left">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="28%" align="right">
													<span class="hs_xh">*</span>&nbsp;现 住 址：
												</td>
												<td width="72%">
													<input type="text" name="xianZhuZhi" size="38" />
												</td>
											</tr>
										</table>
									</td>
									<td colspan="2">
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
								</tr>
								<tr>
									<td colspan="6">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="113" align="right" valign="top">
													兴趣特长爱好：
												</td>
												<td width="507">
													<label>
														<textarea name="xingQuTeChangAiHao" cols="55" rows="5"></textarea>
													</label>
												</td>
											</tr>
										</table>
									</td>
									<td>
										&nbsp;
									</td>
								</tr>
						</table>

						<ul class="sp_nav_tab">
							<li class="nomarl">
								教育阶段
							</li>
							<li class="tj_jh">
								<img src="<%=basePath %>potal/images/xtb_jh.jpg" />
							</li>
							<li class="tj_yh ls_clj">
								<a href="javascript:addtr('table1')">添加一行</a>
							</li>
						</ul>
						<table width="98%" border="0" cellspacing="0" cellpadding="0"
							class="td_top_center" id="table1">
							<tr class="td_top">
								<td width="126" class="td_top">
									开始日期
									
								</td>
								<td width="126" class="td_top">
									结束日期
								</td>
								<td width="199" class="td_top">
									毕业院校
								</td>
								<td width="88" class="td_top">
									学历
								</td>
								<td width="139" class="td_top">
									专业
								</td>
								<td width="65">
									操作
								</td>
							</tr>

						</table>
						<br />
						<ul class="sp_nav_tab">
							<li class="nomarl">
								家庭成员
							</li>
							<li class="tj_jh">
								<img src="<%=basePath %>potal/images/xtb_jh.jpg" />
							</li>
							<li class="tj_yh ls_clj">
								<a href="javascript:addtr('table2')">添加一行</a>
							</li>
						</ul>
						<table width="98%" border="0" cellspacing="0" cellpadding="0"
							class="td_top_center" id="table2">
							<tr class="td_top">
								<td width="128" class="td_top">
									姓名
								</td>
								<td width="134" class="td_top">
									关系
								</td>
								<td width="210" class="td_top">
									工作单位
								</td>
								<td width="90" class="td_top">
									职位
								</td>
								<td width="148" class="td_top">
									联系电话
								</td>
								<td width="65">
									操作
								</td>
							</tr>

						</table>
						<br />
						<ul class="sp_nav_tab">
							<li class="nomarl">
								工作经验
							</li>
							<li class="tj_jh">
								<img src="<%=basePath %>potal/images/xtb_jh.jpg" />
							</li>
							<li class="tj_yh ls_clj">
								<a href="javascript:addtr('table3')">添加一行</a>
							</li>
						</ul>
						<table width="98%" border="0" cellspacing="0" cellpadding="0"
							class="td_top_center" id="table3">
							<tr class="td_top">
								<td width="128" class="td_top">
									开始日期
								</td>
								<td width="134" class="td_top">
									结束日期
								</td>
								<td width="210" class="td_top">
									公司名称
								</td>
								<td width="90" class="td_top">
									职位
								</td>
								<td width="148" class="td_top">
									离职原因
								</td>
								<td width="65">
									操作
								</td>
							</tr>

						</table>
					</form>
					<br />
					<ul class="sp_nav_tab">
						<li class="nomarl">
							附件信息
						</li>
					</ul>
			<jsp:include page="/potal/page/employee/uploadfile.jsp"></jsp:include>
					<br />
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<input type="button" onclick="tj()" name="Submit" value="确认"
									class="gb_btr" />
							</td>
							<td>
								<input type="submit" name="Submit" value="取消" class="gb_btl" />
							</td>
						</tr>
					</table>
	</body>
</html>
