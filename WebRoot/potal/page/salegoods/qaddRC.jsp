<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />

		<title>添加资源核实单</title>
		<style type="text/css">
		.cc{width:575px; font-size:12px;}
		.main2 {width:575px; margin:0 auto;}
		.wzdh {line-height:25px;}
		.wzls {color:#3b8801;}
		.wzcs {color:#ff6600;}
		.dow3{width:575px; height:230px; float:left}
		.dow3_top{width:575px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden; margin-bottom:10px;}
		.dow3_top span{float:right; padding-right:10px; padding-top:1px;}
		.dow3_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
			 ul ,ul li{ margin:0px; padding:0px; list-style:none;}
			.sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; }
			.sp_nav_tab .nomarl{ width:105px;  margin-top:1px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; background-color:#EAFED9;}
			.sp_nav_tab  li { float:left; text-align:center; margin-left:20px;}
			.sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
			.sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
			.font_color_hui{ color:#8c8c8c; text-align:left; padding-left:20px; font-weight:bold;}
			.font_color_lv{ color:#295a01;}
		.dow3_top {width:565px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
		.gb_btr4{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:20px; float:left;border:0}
		.gb_btl4{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center;margin-right:20px; float:right; border:0}
		.hong{ color:#FF0000;}
		</style>
			<script type="text/javascript" src="<%=basePath%>/js/jquery-1.4.js"></script>
<%--			<script type="text/javascript" src="<%=request.getContextPath()%>/js/validators.js" charset="gbk"></script>--%>
	<script type="text/javascript">
	

	function checkValueByRules(objOrId,rules,msg){
		
		//正则表达式
		var reg = new Object();
		reg["phone"] = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/g;//手机号
		reg["tel"] = /(\d{3}-)?\d{8}|(\d{4}-)(\d{7})/g;//电话
		reg["cardno"] = /\d{17}[\d|x|X]|\d{15}/g;//身份证卡
		reg["cn"] =   /[^\x00-\xff]+/g;//匹配中文
		reg["en_num"] = /[\w]/g;//匹配英文和数字
		reg["num"] = /^\d+$/g;//匹配数字
		//reg["zip"] = /^[a-z]([a-z0-9])+@([a-z0-9])+[\.][a-z]{2,3}$/; //邮编
		reg["zip"] = /^[1-9][0-9]{5}$/;//邮编
		reg["money"] = reg["float"] = /^-?\d*\.?\d+$/; //货币、浮点型    
		reg["email"] = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;  ///^[a-z]([a-z0-9])+@([a-z0-9])+[\.][a-z]{2,3}$/  QQ邮箱验证不了，已经修改好了
		reg["birth"] = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
		reg["password"] = /^[a-zA-Z-0-9]{1}[a-zA-Z0-9_\$\.]{5,15}$/;
		reg["depNum"] =/^(\d{3})$/;   //匹配只有三位数字
		reg["bandcard"]=/^(\d{19})|(\d{16})$/g;    //匹配银行卡号
		
		//提示语			
		
		var regMsg = new Object();
		regMsg["phone"] = "您输入的手机或电话有误，请重新输入！";
		regMsg["tel"] = "您输入的电话号码有误，请重新输入！";
		regMsg["cardno"] = "您输入的身份证号码有误，请重新输入！";
		regMsg["cn"] = "您输入的非汉字，请重新输入！";
		regMsg["en_num"] = "您输入的非英语或数字，请重新输入！";
		regMsg["num"] = "请输入整数";
		regMsg["zip"] = "您输入的邮编不正确，请重新输入！";
		regMsg["float"] = "您输入的数字数据有误，请重新输入！";
		regMsg["money"] = "您输入的货币格式数据有误，请重新输入！";
		regMsg["email"] = "您输入的电子邮箱有误，请重新输入！";
		regMsg["birth"] = "您输入的日期格式有误，请重新输入！";
		regMsg["password"] = "必须是6-16位的数字、字母以及$_小数点组成";
		regMsg["depNum"]="您输入的部门编号格式有误（例：140、130），请重新输入！";
		regMsg["bandcard"] = "您输入的银行卡账号有误，请重新输入！";
		regMsg["gatheringName"] ="你输入的收款名称有误!";
		regMsg["bankName"] = "你输入的开户行有误";
		regMsg["payerName"] = "你输入的付款人有误";
		
		
		var msgs=$("#"+msg);
		//alert(msgs);
		var obj = null;//声明对象句柄
		var isObj = false;
		if(typeof(objOrId) == "string" )	{
			obj = $("#"+objOrId);
		}else if(typeof(objOrId) == "object"){
			obj = $(objOrId);
			isObj = true;
		}
		
		if(obj != null ){
			var value = obj.val();//获取输入框的值
			//alert(value);
			if(value == null || value == "" ){//判断是否空值
				if(!isObj){
					msgs.html("该项不能为空！");
					flag = false;
					return false;//若空值则返回
				}else{
					msgs.html("");
					flag=true;
				}
			} else if(rules != null && typeof(rules) == "object" && rules.length > 0 ){//验证规则
				for( var j=0;j<rules.length;j++ ){
					if( reg[rules[j]] == null || reg[rules[j]] == "" ){	break;}
					
					if( !reg[rules[j]].test($.trim(value)) ){//判断是否不匹配
					    //alert(rules[j]+"--"+reg[rules[j]]);
						if(rules[j]=="phone" && reg['tel'].test(value)){
							break;
						}
						msgs.html(regMsg[rules[j]]);
						flag = false;
						break;
					}else {
						msgs.html("");
						flag = true;
					}
				}
			} else {
				msgs.html("");
				flag = true;
			}
		}
		
		if(rules.toString().indexOf(".do") != -1 && rules !='' && rules != null)
		{
			var name = $("#"+objOrId).val();
			//alert("name"+name);
			
			var url = rules;
			//alert(url);
			//alert(name);
//			name = encodeURIComponent(name)
			name = encodeURI(encodeURI(name));
			//alert(name);
			 var method = 'POST';
			 
			$.ajax({
	          type: method,
	          async:false,
	          url: url,
	          data: "name="+name,
	          //data: "name="+name,
	          success: function(date) {
	            if(date == "1")
				{
					msgs.html("<font color='#F73809'>该项已经存在</font>");
					$("#is").val("1");
					flag = true;
					$("#"+objOrId).focus();
				}else if(date == 2){
					msgs.html("<font color='#F73809'>输入不合法</font>");
					$("#is").val("1");
					flag = true;
					$("#"+objOrId).focus();
				}else{
					msgs.html("<font color='#1AE61A'>该项可以添加</font>");
				}
	      }
	       });
			//$.post(url,{name:encodeURIComponent(name)},
			//		function(date){
			//	if(date == 1)
			//	{
			//		msgs.html("名称已经存在");
			//		$("#is").val("1");
			//		flag = true;
			//		$("#"+objOrId).focus();
			//	}
			//		}
			//		);
		}
		
	}
	
	function onchangDemo()
	{
		var obj = document.getElementById("select5");
		var selectIndex = obj.selectedIndex;
		var values = obj.options[selectIndex].value;
		$("#sginfos").attr("value",values);
		$.ajax({
			type:"POST",
			url:"selectDetialsalegoods.do",
			data:{"sgidinfo":values},
			success:function(data)
			{
				$("#tabid").empty();
				$("#tabid").html(data);
			}
		});
	}
	
	function onchanginfo()
	{
		var obj = document.getElementById("select1");
		var selectIndex = obj.selectedIndex;
		var values = obj.options[selectIndex].value;
		$("#cityid").attr("value",values);
	}
	
	function  onchangs()
	{
		var obj = document.getElementById("select2");
		var selectIndex = obj.selectedIndex;
		var values = obj.options[selectIndex].value;
		$("#depotids").attr("value",values);
		var depotids = $("#depotids").val();
	}
	
	
	function onsubmitRC()
	{
		var nowTime = $("#nowTime").val();
		var cityid = $("#cityid").val();
		var depotids = $("#depotids").val();
		var sgid = $("#sginfos").val();
		var empid = $("#empid").val();
		var rvids = $("#rvids").val();

		if(cityid == "" || cityid =="-1")
		{
			$("#downMsg1").html("地区不能为空!");
			return false;
		}
		if(sgid == "" || sgid =="-1")
		{
			$("#downMsg3").html("商品不能为空!");
			return false;
		}	
		if(depotids == "" || depotids =="-1")
		{
			$("#downMsg2").html("仓库不能为空!");
			return false;
		}		

		var demo = $("#demo").val();
		$.ajax({
			type:"POST",
			url:"addRCsalegoods.do",
			data:{
				"cityid":cityid,
				"depotids":depotids,
				"sgidinfo":sgid,
				"empid":empid,
				"rvids":rvids,
				"nowTime":nowTime
			},
			success:function(data)
			{
				if(data == "1")
				{
					alert("添加成功!");
					if(demo == 'rc')
					{
						parent.location.href = "<%=basePath%>selectReourcesalegoods.do";
					}
					if(demo == 'myrc')
					{
						parent.location.href = "<%=basePath%>selectmyrcsalegoods.do";
					}
					if(demo == 'deptrc')
					{
						parent.location.href = "<%=basePath%>selectdeptrcsalegoods.do";
					}
				}					
				if(data =="2")
				{
					alert("添加失败!");
				}
			}
			});
	}
	function yingcang()
	{
		parent.document.getElementById('addrow').style.display='none';
	}
		
		
	</script>
	</head>
	<body class="cc" >
	<div style="border:1px solid #666666;width: 575px;">
	<form action="" method="post" onsubmit="return false;">
		<div class="main2" style="background-color: #ffffff">
		<input type="hidden" id="sginfos" name="sginfos" />
		<input type="hidden" id="cityid" name="cityid" value=""/>
		<input type="hidden" id="depotids" name="depotids" value=""/>
		<input type="hidden" id="demo" name="demo" value="${demo}"/>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<div class="dow3_top">
							<span><a href="javascript:yingcang();">×</a>
							</span> 新增资源核查单
						</div>
						<br />
					</td>
				</tr>
			</table>
			<ul class="sp_nav_tab">
				<li class="nomarl">
					基本信息
				</li>
			</ul>
			<br />
			<table width="100%" border="0" cellspacing="8" cellpadding="0"
				class="table_top" style="background-color: #ffffff;">
				  <tr>
    <td width="26%" class="font_color_hui">&nbsp;&nbsp;&nbsp;<span class="hong">*</span>&nbsp;&nbsp;核查编号：</td>
    <td width="32%">    <input type="text" value="${rvids}" name="rvids" id="rvids" /></td>
    <td width="42%" style="color:#999999;"><img src="<%=request.getContextPath()%>/potal/images/zhgl_v_l.png" width="15" height="17" align="top" />&nbsp;&nbsp;该项不能为空</td>
    </tr>
 				 <tr>
					<td class="font_color_huis">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="hongs">*</span>&nbsp;&nbsp;申 请人：
					</td>
					<td>
						<input type="text" value="${emps.name}" name="shenQinRen"
							id="shenQinRen" />
						<input type="hidden" value="${emps.id}" id="empid" name="empid" />
					</td>

					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="font_color_huis">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="hongs">*</span>&nbsp;&nbsp;商 品名称：
					</td>
					<td>
						<select name="select5" id="select5" onchange="onchangDemo();" onblur="checkValueByRules('select5','','downMsg');" style="width: 155px;">
							<option value="-1">
								---请选择商品---
							</option>
							<c:forEach items="${listPro}" var="pro">
								<option value="${pro.sgId}">
									${pro.sgname}
								</option>
							</c:forEach>
						</select>
						<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="downMsg3"></FONT>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="font_color_huis">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="hongs">*</span>&nbsp;&nbsp;地 区：
					</td>
					<td>
						<select name="diQu" id="select1" onchange="onchanginfo();" onblur="checkValueByRules('select1','','downMsg1');"  style="width: 155px;">
							<option value="-1">
								---请选择地区---
							</option>
							<c:forEach items="${listCity}" var="city">
								<option value="${city.id}">
									${city.name}
								</option>
							</c:forEach>
						</select>
						<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="downMsg1"></FONT>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top" class="font_color_huis">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="hongs">*</span>&nbsp;&nbsp;仓 库：
					</td>
					<td colspan="2">
						<label for="textfield"></label>
						<select name="cangKu" id="select2" onchange="onchangs();" onblur="checkValueByRules('select2','','downMsg2');"  style="width: 155px;">
							<option value="-1">
								---请选择仓库---
							</option>
							<c:forEach items="${listdepot}" var="dt">
								<option value="${dt.id}">
									${dt.name}
								</option>
							</c:forEach>
						</select>
						<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="downMsg2"></FONT>
					</td>
				</tr>
				<tr>
					<td valign="top" class="font_color_huis">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="hongs">*</span>&nbsp;&nbsp;创 建时间：
					</td>
					<td colspan="2">
						<input type="text" value="${nowTime}" name="nowTime"
							id="nowTime" />
					</td>
				</tr>
			</table>
			<ul class="sp_nav_tab">
				<li class="nomarl">
					商品属性
				</li>
			</ul>
			<table width="100%" border="0" cellspacing="0" cellpadding="15">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="5"  id="tabid">
							<tr>
								<td width="100%" align="left" class="font_color_hui">
									无
						      </td>
				  </tr>
			</table>
			<table width="100%" border="0" cellspacing="8" cellpadding="0">
				<tr>
					<td>
						<input type="button" onclick="onsubmitRC();" style="CURSOR:pointer;" name="button" id="button" value="确认"
							class="gb_btl4" />
					</td>
					<td>
						<input type="button" onclick="yingcang();" style="CURSOR:pointer;" name="button2" id="button2" class="gb_btr4"
							value="取消" />
					</td>
				</tr>
			</table>
</td></tr></table>
		</div>
</form></div>
	</body>
</html>

