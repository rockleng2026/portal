<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>使用新的地址</title>
<style type="text/css">
.ss{width:600px; margin:0 auto;}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dowq{width:600px; height:260px; float:left; font-size:12px;}
.dowq_top{width:600px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dowq_top span{float:right; padding-right:10px; padding-top:1px;}
.dowq_top a{color:#FFFFFF; font-size:12px; font-weight:bold; text-decoration:none}
.dowq_nr{width:600px; border:1px solid #455c32; height:370px; float:left}
.tc_formq{width:600px; float:left; line-height:23px;}
.tc_formq dd{width:530px; float:left; text-align:right;}
.tc_formq dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_formq dt span{width:50px; float:right}
.tc_formq dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{width:145px; height:19px; border:1px solid #b2b2b2}
.footq{padding-right:15px}
.footq a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.footq a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footqb{border-bottom:1px solid #c3c3c3}
.tc_footqb a{text-decoration:none; color:#ff9002; clear:both}
.tc_footqb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightba{border-right:1px solid #c3c3c3}
.yq_tsq { background-color:#fcf3e4; border:1px solid #fddbad; line-height:25px; text-align:center; width:420px;}
.yqtsq {background-color:#fcf3e4; border:1px solid #fddbad; line-height:25px; text-align:right; width:430px; float:right;}
.xhbtq { color:#fe0000;}
.xttshsq { color:#666666;}
</style>
<script type="text/javascript"
			src="<%=basePath%>potal/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/potal/js/area.js" charset="gbk" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
<script type="text/javascript">
	function btnewaddress()
	{
		var a = document.getElementById("province2").value;
		var b = document.getElementById("city2").value;
		var c = document.getElementById("area2").value;
		var aaa=  findprovince(a);
		var bbb=findcity(b);
		var ccc =findareas(c);
		
		var youbian = $("#youbian").val();
		var jiedaodizhi = $("#jiedaodizhi").val();
		var xingming = $("#xingming").val();
		
		var dianhua1 = $("#dianhua1").val();
		var dianhua2 = $("#dianhua2").val();
		var dianhua3 = $("#dianhua3").val();

		var dianhua = dianhua1 +"-"+ dianhua2+"-"+dianhua3;
		var reg =  /(\d{3}-)?\d{8}|(\d{4}-)(\d{7})/g;
		if(!reg.test(dianhua))
		{
			alert("请输入正确的号码!");
			return false;
		}
		
		var shouji = $("#shouji").val();
		if(youbian == "")
		{
			$("#downMsg1").html("邮编不能为空!");
			return false;
		}
		if(jiedaodizhi == "")
		{
			$("#downMsg2").html("街道地址不能为空!");
			return false;
		}
		if(xingming == "")
		{
			$("#downMsg3").html("姓名不能为空!");
			return false;
		}
		if(shouji == "")
		{
			$("#downMsg4").html("手机不能为空!");
		}
		var cusids = $("#cusids").val();

		var aaa1 = encodeURI(aaa,"utf-8");
		var bbb1 = encodeURI(bbb,"utf-8");
		var ccc1 = encodeURI(ccc,"utf-8");
		var jiedao = encodeURI(jiedaodizhi,"utf-8");
		var xingming1 = encodeURI(xingming,"utf-8");
		$.ajax({
				type:"POST",
				url:"<%=basePath%>newaddresssalegoods.do",
				data:{
					"shi":aaa1,
					"sheng":bbb1,
					"qu":ccc1,
					"youbian":youbian,
					"jiedao":jiedao,
					"xingming":xingming1,
					"dianhua":dianhua,
					"shouji":shouji,
					"cusids":cusids
				},
				success:function(data)
				{
					if(data=="2")
					{
						alert("使用新地址失败!");
					}else
					{
						parent.document.getElementById('addressifo').innerHTML = data;
					}
				}
			});
		parent.document.getElementById("uname").innerHTML =xingming;
		parent.document.getElementById('addrow').style.display='none';
	}

	function onchangs3()
	{
		var obj = document.getElementById("Select3");
		var selectIndex = obj.selectedIndex;
		var values = obj.options[selectIndex].value;
		document.getElementById("ccc").value = values;
	}
	function closealls()
	{
		parent.document.getElementById('addrow').style.display='none';
	}
	
</script>
  </head>
  
  <body class="ss"  style="background-color: #ffffff;">
  <%
  	String cusids = request.getParameter("cusid");
  	request.setAttribute("cusids",cusids);
  %>
   <div class="dowq">
<div class="dowq_top">
<span><a href="javascript:closealls();">×</a></span>
&nbsp;&nbsp;&nbsp;使用新地址
</div>
<div class="dowq_nr" style="background-color: #ffffff;width: 607px;">
<input type="hidden" name="aaa"  id="aaa"/>
<input type="hidden" name="bbb"  id="bbb"/>
<input type="hidden" name="ccc"  id="ccc"/>
<input type="hidden" name="cusids" id="cusids" value="${cusids}"/>
<table width="100%" border="0" cellspacing="0"  cellpadding="0"  style="background-color: #ffffff;">
   <tr style="font-size: 12px;">
    <td width="15%"  height="35" align="right"  ><span class="xhbtq">*</span>&nbsp;新地址：</td>
    <td height="35" align="left"  >
	<select name="province2" id="province2">
</select><select name="city2" id="city2">
</select><select name="area2" id="area2"></select>
			<script type="text/javascript">
				BindProvince("province2","city2","area2");
			</script>
			</td>
    </tr>

   <tr style="font-size: 12px;">
    <td width="15%"  height="35" align="right"><span class="xhbtq">*</span>&nbsp;邮政编码：</td>
    <td height="35" align="left"><input id="youbian" type="text" name="youbian"  /> <FONT color=#ff0000 id="downMsg1"></FONT></td>
    </tr>
	<tr style="font-size: 12px;">
    <td width="15%"  height="70" align="right" valign="top"><span class="xhbtq">*</span>&nbsp;街道地址：</td>
    <td height="70" align="left" valign="top"><textarea name="jiedaodizhi" id="jiedaodizhi" cols="50" rows="4" ></textarea> <FONT color=#ff0000 id="downMsg2"></FONT></td>
    </tr>
	<tr style="font-size: 12px;">
    <td width="15%"  height="35" align="right">&nbsp;</td>
    <td height="35" align="left"><div class="yq_tsq">请填写街道地址，最少5个字，最多不能超过60个字，不能全部为数字或字母。</div></td>
    </tr>
	<tr style="font-size: 12px;">
    <td width="15%"  height="35" align="right"><span class="xhbtq">*</span>&nbsp;收货人姓名：</td>
    <td height="35" align="left"><div class="yqtsq">请正确填写姓名。请输入2-15个字之间，且其中不能含有null字样。</div><input id="xingming"  size="9" type="text" name="xingming" />
     <FONT color=#ff0000 id="downMsg3"></FONT>&nbsp;</td>
    </tr>
	<tr style="font-size: 12px;">
    <td width="15%"  height="35" align="right">电话：</td>
    <td height="35" align="left"><input type="text" value="86" readonly="readonly" id="dianhua1"  name="dianhua1"  size="5" />-<input type="text"  id="dianhua2" name="dianhua2" size="10"  />-<input type="text" id="dianhua3" name="dianhua3"  size="10" />&nbsp;<span class="xttshsq">手机和电话请至少填写一个，电话的格式：区号-电话号码-分机</span></td>
    </tr>
	<tr style="font-size: 12px;">
    <td width="15%"  height="35" align="right">手机：</td>
    <td height="35" align="left"><input id="shouji" type="text" name="shouji"  /> <FONT color=#ff0000 id="downMsg4"></FONT></td>
    </tr>
<%--	<tr>--%>
<%--    <td width="15%"  height="30" align="right">设置默认：</td>--%>
<%--    <td height="30" align="left"><form id="form1" name="form1" method="post" action="">--%>
<%--      <label>--%>
<%--        <input type="checkbox" name="checkbox" value="checkbox" />--%>
<%--        </label>--%>
<%--	&nbsp;设置为默认地址&nbsp;&nbsp;<span class="xttshsq">设置后系统将在购买时自动选中该收货地址</span></form>--%>
<%--    </td>--%>
<%--	</tr>--%>
	<tr style="font-size: 12px;">
	  <td  height="50" colspan="2" align="center"><input class="qr" type="button" style="" onclick="javascript:btnewaddress();" name="Submit" value="确认" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input class="qr" type="reset" onclick="closealls();" name="Submit2" value="取消" /></td>
	  </tr>
</table>

</div>


</div>
</body>
</html>
