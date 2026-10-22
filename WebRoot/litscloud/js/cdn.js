function div1(){
	document.getElementById("content1").style.display="block";
	document.getElementById("content2").style.display="none";
	document.getElementById("content3").style.display="none";
	document.getElementById("content4").style.display="none";
	document.getElementById("content5").style.display="none";	
	}
function div2(){
	document.getElementById("content1").style.display="none";
	document.getElementById("content2").style.display="block";
	document.getElementById("content3").style.display="none";
	document.getElementById("content4").style.display="none";
	document.getElementById("content5").style.display="none";	
	}	
function div3(){
	document.getElementById("content1").style.display="none";
	document.getElementById("content2").style.display="none";
	document.getElementById("content3").style.display="block";
	document.getElementById("content4").style.display="none";
	document.getElementById("content5").style.display="none";	
	}
function div4(){
	document.getElementById("content1").style.display="none";
	document.getElementById("content2").style.display="none";
	document.getElementById("content3").style.display="none";
	document.getElementById("content4").style.display="block";
	document.getElementById("content5").style.display="none";	
	}
function div5(){
	document.getElementById("content1").style.display="none";
	document.getElementById("content2").style.display="none";
	document.getElementById("content3").style.display="none";
	document.getElementById("content4").style.display="none";
	document.getElementById("content5").style.display="block";	
	}
function showContent(index)
{
       var e = document.getElementById("content"+index);
       e.style.display = "";
       
       for(var i=1; i<6; i++)
       {
        if(i != index)
        {
            var e2 = document.getElementById("content"+i);
            e2.style.display = "none";
            document.getElementById("tab"+i).className="";
         }
         else
         {
            document.getElementById("tab"+i).className="tabSelected";
         }
       }
}
var count=6;
var count1=2;
var count2=2;
function addCDN()
{	


	//alert(1111);
	var cuRealmName=document.getElementById("cuRealmName").value;
    if(cuRealmName==null||cuRealmName=="")
	{
		alert("请输入域名！！！");
		$("#cuRealmName").focus();
		return false;
	}
	var switchOpen=document.getElementById("switch").value;
	if(switchOpen==null||switchOpen==""||switchOpen=="0")
	{
		alert("请选择服务开启状态！！！");
		$("#switch").focus();
		return false;	
	}

	var IP="";
	var yunyingshang="";
	var IPaddress="";
	var duank="";
	for(var i=1;i<count2;i++)
	{
		var ipaa=document.getElementById("IP"+i+"").value;
		if(ipaa==null||ipaa=="")
		{
			alert("请输入IP！！！！");
			$("#IP"+i+"").focus();
			return false;
		}
		
	   var ss = ipaa.split(".");
	   if(ss.length != 4)
	   {
		   alert("输入IP有误！！！！");
		   $("#IP"+i+"").focus();
	      return false;
	   }
	   var ic=0;
	   for(ic=0;ic<ss.length;ic++)
	   {
	      if ( (/^\d+$/.test(ss[ic])==false) || parseInt(ss[ic]) < 0 || parseInt(ss[ic])>255)
	      {
	    	  	alert("输入的IP有误！！！！");
	    	  	$("#IP"+i+"").focus();
	        	return false;
	      }
	   }
	  var national1=document.getElementById("national1").value;
		var national2=document.getElementById("national2").value;
		var national3=document.getElementById("national3").value;
		if(i==(count2-1))
		{
			IP+=ipaa;
			var yyy=document.getElementById("yunyingshang"+i+"").value;
				if(yyy==null||yyy=="")
					{
						alert("请选择运营商！！！");
						$("yunyingshang"+i+"").focus();
						return false;
					}
					yunyingshang +=yyy;
			duank+=document.getElementById("duankou"+i+"").value;
			if(national1=="国家")
					{	
					var ipar=document.getElementById("IPaddress"+i+"").value;
						
						IPaddress+=ipar;
					}
				else
					{
						IPaddress+=national1+"　"+national2+"省(州)"+national3+"市(县)";
					
					}
		}
		else{
			IP+=ipaa+"/";
			var yyy=document.getElementById("yunyingshang"+i+"").value;
				if(yyy==null||yyy=="")
					{
						alert("请选择运营商！！！");
						$("yunyingshang"+i+"").focus();
						return false;
					}
					yunyingshang +=yyy+",";
			duank+=document.getElementById("duankou"+i+"").value+"/";
			if(national1=="国家")
					{
					var ipar=document.getElementById("IPaddress"+i+"").value;
						IPaddress+=ipar+"/";
					}
				else
					{
						IPaddress+=national1+"　"+national2+"省(州)"+national3+"市(县)"+"/";
					}
		}
	}

	
	
	var IPqujian1=document.getElementById("IPqujian").value;
	var PVqujian1=document.getElementById("PVqujian").value;
	var fujiandaxiao1=document.getElementById("fujiandaxiao").value;
	var wenjiandaxiao1=document.getElementById("wenjiandaxiao").value;
	
	var wenjiandaxiao=encodeURI(wenjiandaxiao1);
	var IPqujian=encodeURI(IPqujian1);
	var fujiandaxiao=encodeURI(fujiandaxiao1);
	var PVqujian=encodeURI(PVqujian1);
	
	
	var address=document.getElementById("address").value;
	var beianhao=document.getElementById("beianhao").value;
	if(address=="国内加速")
	{
		if(beianhao==null||beianhao=="")
			{
				alert("请输入备案号！！！");
				$("#beianhao").focus();
				return false;
			}
	}
	else
		{
			beianhao="";
		}
	var yumingleixing=document.getElementById("yumingleixing").value;
	if(yumingleixing==null||yumingleixing=="" ||yumingleixing=="0")
	{
		alert("请选择域名类型 ！！！！！！");
		$("#yumingleixing").focus();
		return false;
	}
	var taocanleixing=document.getElementById("taocanleixing").value;
	
	if(taocanleixing==null||taocanleixing==""||taocanleixing=="4")
	{
		alert("请选择套餐！！！！");
		$("#taocanleixing").focus();
		return false;
	}
	//alert(111111);
	var taocanId="";
	var rd=document.getElementsByName("a");
	
		 for ( var i = 0; i < rd.length; i++) {
			if (rd[i].checked == true) {
		
				taocanId=rd[i].value;
		}
	}
	if(taocanId==null||taocanId=="")
		{
			alert("请选择套餐！！！！");
			return false;
		}
	//alert(1112222);
	var huancun="";
	var test="";
	var time="";
	var timedanwei="";
	alert("count="+count);
	for(var i=1;i<count;i++)
	{
		var hc=document.getElementById("huancun"+i+"").value;//是否缓存
		
		if(hc!=null&&hc!=""&&hc!="0")
		{
				if(i==(count-1))
					huancun+=hc;
				else
					huancun+=hc+",";
			var tt=document.getElementById("test"+i+"").value;//缓存内容
			if(tt==null||tt=="")
			{
				alert("请输入缓存内容！！！！");
				$("#test"+i+"").focus();
				return false;
			}
				if(i==(count-1))
					test+=tt;
				else
					test+=tt+",";
			var t=document.getElementById("time"+i+"").value;//缓存时间
			if(t==null||t=="")
			{
			
				alert("请输入缓存时间！！！！");
				$("#time"+i+"").focus();
				return false;
			}
				if(i==(count-1))
					time+=t;
				else
					time+=t+",";
			var tdw=document.getElementById("timedanwei"+i+"").value;//缓存时间单位
			
			if(tdw==null||tdw==""||tdw=="0")
			{
				alert("请选择缓存时间单位！！！！");
				$("#timedanwei"+i+"").focus();
				return false;
			}
				if(i==(count-1))
					timedanwei+=tdw;
				else
					timedanwei+=tdw+",";
		}
	}
	//alert(2222);
	var operator="";
	var daaddress="";
	var huiyuan="";
	for(var i=1;i<count1;i++)
	{
		var o=document.getElementById("operator"+i+"").value;
		if(o!=null&&o!=""&&o!="0")
		{
				if(i==(count1-1))
					operator+=o;
				else
					operator+=o+",";
			var da=document.getElementById("daaddress"+i+"").value;
			if(da==null||da==""||da=="0")
			{
				alert("请选择打地区！！！！");
				$("#daaddress"+i+"").focus();
				return false;
			}
				if(i==(count1-1))
					daaddress+=da;
				else
					daaddress+=da+",";
			
			var hy=document.getElementById("huiyuan"+i+"").value;
			if(hy==null||hy=="")
			{
				alert("请输入回源IP！！！");
				$("#huiyuan"+i+"").focus();
				return false;
			}
				if(i==(count1-1))
					huiyuan+=hy;
				else
					huiyuan+=hy+",";
		}
	}
	//alert(33333);
	t=encodeURI(test);
	var daa=encodeURI(daaddress);
	var op=encodeURI(operator);
	

	
	var IPaddress1=encodeURI(IPaddress);
	var address1=encodeURI(address);
    var	beianhao1=encodeURI(beianhao);
	var wenjiandaxiao=encodeURI(wenjiandaxiao1);
	var IPqujian=encodeURI(IPqujian1);
	var fujiandaxiao=encodeURI(fujiandaxiao1);
	var PVqujian=encodeURI(PVqujian1);
	
	var yys=encodeURI(yunyingshang);
	var IPadd=encodeURI(IPaddress);
	var url="addtaocanCDNsaleOrderAction.Action";
	$.post(url,{
		cuRealmName:cuRealmName,//域名
		taocanId:taocanId,//套餐ID
		switchOpen:switchOpen,//是否开启
		huancun:huancun,//是否缓存
		test:t,//缓存内容
		time:time,//缓存时间
		timedanwei:timedanwei,//缓存时间的单位
		operator:op,//运营商
		daaddress:daa,//大地址
		huiyuan:huiyuan,//回源IP
		IP:IP,//IP
		yunyingshang:yys,//运营商
		IPaddress:IPadd,//Ip地址
		duankou:duank,//端口
		address:address1,//国内或者国外加速
		beianhao:beianhao1,//备案号
		IPqujian:IPqujian,//IP区间数
		PVqujian:PVqujian,//PV区间数
		fujiandaxiao:fujiandaxiao,//附件大小
		wenjiandaxiao:wenjiandaxiao//多数文件大小
	},function(data){
		if(data=="1")
		{
			alert("添加成功！！！！");
			window.location.href='showcdnlist3CDNsaleOrderAction.Action';
		}
		else if(data=="3")
		{
			alert("添加失败 免费套餐也被使用！！！！");
		}
		else if(data=="0")
		{
			alert("域名已被使用！！！！");
		}
		else if(data=="4")
		{
			alert("添加失败 赠送套餐也被使用！！！！");
		}
		else{
			alert("添加失败！！！！");
		}
	});
}
function xuanze()
{
	var taocanleixing=document.getElementById("taocanleixing").value;
	
	var yumingleixing=document.getElementById("yumingleixing").value;
	if(yumingleixing==null||yumingleixing=="")
	{
		alert("请选择域名类型 ！！！！！！");
		return false;
	}
		var rd=document.getElementsByName("a");
		if(rd.length==0)
			{
				$("#taocanNo").remove();
			}
		var rdl=rd.length;
		 for ( var i = 0; i < rdl; i++) {
				$("#tr"+rd[0].value+"").remove();
			}
	
	url="taocan3CDNsaleOrderAction.Action";
	$.post(url,{taocan:taocanleixing,yuming:yumingleixing},function(data){
		$("#taocan").append(data);
	});

}	
//增加缓存规则
function inserttr()
{
	var bb ="<tr class='dcn_tr' id='tr"+count+"'>";
         bb+="<td width='14%'  class='dcn_bottom' ><select id='huancun"+count+"' name='' value='this.value' onblur='shifou(this.value,'"+count+"')' class='dcn_fwq' style='width:120px;'><option value='0'>是否缓存</option><option value='1' >缓存</option><option value='2'>不缓存</option></select></td>";
         bb+="<td width='58%' class='dcn_bottom'><input id='test"+count+"' name='' type='text' title='CDNrefresh'  value='输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)' onFocus='this.value=''' onBlur='if(!value){value=defaultValue;}' class='dcn_yz' style='width:530px;' /></td>";
         bb+="<td width='14%' class='dcn_bottom' ><input id='time"+count+"' name='' type='text'  value='输入数字' onFocus='this.value=''' onBlur='if(!value){value=defaultValue;}' class='dcn_yz' style='width:120px;' /> </td>";
         bb+="<td width='14%' class='dcn_bottom' ><select id='timedanwei"+count+"' name='' value='this.value'  class='dcn_fwq' style='width:120px;'><option value='0'>时间单位</option><option value='h'>小时</option><option value='d'>天</option><option value='m'>月</option></select></td>";
       bb+="</tr>";
    $("#hcrule").append(bb);
	//var aa="<tr id='tr"+count+"'><td><select id='huancun"+count+"' name='' value='this.value' onblur=shifou(this.value,'"+count+"') ><option value='0'>请选择！</option><option value='1'>缓存</option><option value='2'>不缓存</option></select></td>";
	//aa+="<td><input id='test"+count+"' name='' type='text' title='CDNrefresh' class='cdninput' /></td>";
	//aa+="<td><input id='time"+count+"' name='' type='text' class='cdntimeinput' /></td>";
	//aa+="<td><select id='timedanwei"+count+"' name='' value='this.value' onchange='xuanze()'' class='cdnopinput'><option value='0'>请选择！</option><option value='h'>小时</option><option value='d'>天</option><option value='m'>月</option></select></td><tr>";
	//$("#intr").append(aa);
	count++;
}
//减少缓存规则
function jianshao()
{
	var conn=count-1;
	$("#tr"+conn+"").remove();
	count--;
}
//增加回源
function insert1()
{
	var bb="<tr class='dcn_tr' id='tr1"+count1+"'><td width='20%' class='dcn_bottom'><select id='operator"+count1+"' name='' value='this.value' class='dcn_fwq' style='width:180px;'>";
        bb+="<option value='0'>请选择运营商！</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option>";
		bb+="<option value='联通'>联通</option><option value='教育网'>教育网</option><option value='移动'>移动</option>option value='铁通'>铁通</option>";
		bb+="<option value='网通'>网通</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option>";
		bb+="<option value='长城宽带'>长城宽带</option>";
        bb+="</select> </td><td width='20%' class='dcn_bottom'>";
        bb+="<select id='daaddress"+count1+"' name='' class='dcn_fwq' style='width:180px;'>";
        bb+="<option value='0'>请选择地区！</option><c:forEach items='${disname}' var='dislist'><option value='${dislist }'>${dislist }</option></c:forEach></select></td>";
        bb+="<td width='35%' class='dcn_bottom'><input id='huiyuan1' name='' type='text' value='' class='dcn_yz' style='width:330px;' /></td><td width='20%' class='dcn_xib dcn_bottom'>回源IP<span>(多个IP请用/分割)</span></td>";
        bb+="</tr>";
        $("#hysz").append(bb);
	//var aa="<tr id='tr1"+count1+"'><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id='operator"+count1+"' name='' value='this.value'><option value='0'>请选择运营商！</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option><option value='联通'>联通</option><option value='教育网'>教育网</option><option value='网通'>移动</option><option value='铁通'>铁通</option><option value='网通'>网通</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option><option value='长城宽带'>长城宽带</option></td>";
	//aa+="<td><select id='daaddress"+count1+"' );'><option value='0'>请选择地区！</option><c:forEach items='${disname}' var='dislist'><option value='${dislist }'>${dislist }</option></c:forEach></select></td>";
	//aa+="<td><input id='huiyuan"+count1+"' name='' type='text'/><FONT color=#ff0000>回源IP</FONT></td>";					
	//$("#huiyuan").append(aa);
	count1++;
}
//减少回源
function jianshao1()
{
	var conn1=count1-1;
	$("#tr1"+conn1+"").remove();
	count1--;
}

function shifou(aa,i)
{
	
	if(aa==2)
		{
			document.getElementById("time"+i+"").value="0";
			document.getElementById("timedanwei"+i+"").value="h";
		}
}
function Ipaddress(zhi)
{
	var ip=document.getElementById("IP"+zhi+"").value;
	if(ip==null||ip=="")
		{
			alert("请输入IP！！！！");
			return false;
		}
		
	   var ss = ip.split(".");
	   if(ss.length != 4)
	   {
		   alert("输入IP有误！！！！");
	      return false;
	   }
	   var i=0;
	   for(i=0;i<ss.length;i++)
	   {
	      if ( (/^\d+$/.test(ss[i])==false) || parseInt(ss[i]) < 0 || parseInt(ss[i])>255)
	      {
	    	  	alert("输入的IP有误！！！！");
	        	return false;
	      }
	   }
	url="ipselectCDNsaleOrderAction.Action";
	$.post(url,{ip:ip},function(data){
		var at=data.split(",");
		document.getElementById("yunyingshang"+zhi+"").value=at[0];
		document.getElementById("IPaddress"+zhi+"").value=at[1];
	});
}
	//window.onload = function()
	//{
		//setup();
	//}
function determine()
{
	var cuRealmName=document.getElementById("cuRealmName").value;
	if(cuRealmName==""||cuRealmName==null)
		{
			alert("请输入域名！！！");
			return false;
		}
	
	var url="yumingCDNsaleOrderAction.Action";
	$.post(url,{cuRealmName:cuRealmName},function(data){
		if(data==0)
			{
				alert("域名也被占用！！！！！");
				return false;
			}
			
	});
}

function add(){
	var bb="<div class='dcn_c' id='addaddress"+count2+"'>";
        bb+="<div class='dcn_ct'> <div class='dcn_cl'>请 输 入 源 站 IP：</div>";
          bb+="<div class='dcn_cr dcn_an'><input type='text' value='' id='IP"+count2+"' name='' onblur='Ipaddress("+count2+")' class='dcn_yz' style='margin-right:10px;' /> 端口： <input type='text' id='duankou"+count2+"' name='' value='80' class='dcn_yz' style='width:80px; float:none;' /> <sub class='dcn_xib'>(有多个IP请点击后面增加按钮)</sub></div></div>";
          bb+="<div class='dcn_ct'>";
          bb+="<div class='dcn_cl'>源站服务器机房位置：</div>";
          bb+="<div class='dcn_cr'><input type='text' value='' id='IPaddress"+count2+"' name='' disabled='disabled' class='dcn_yz' style='margin-right:10px;' /> <sub class='dcn_xib' style='float:left; margin-right:10px;'>(地址有误请右边选择修正)</sub> <select id='yunyingshang"+count2+"' name='' value='this.value' class='dcn_fwq'>";
             bb+="<option value='0'>运营商</option>";
			bb+="<option value='华数'>华数</option>";
			bb+="<option value='电信'>电信</option>";
			bb+="<option value='单线'>单线</option>";
			bb+="<option value='联通'>联通</option>";
			bb+="<option value='教育网'>教育网</option>";
			bb+="<option value='移动'>移动</option>";
			bb+="<option value='铁通'>铁通</option>";
			bb+="<option value='网通'>网通</option>";
			bb+="<option value='搜索引擎'>搜索引擎</option>";
			bb+="<option value='分省'>分省</option>";
			bb+="<option value='分大洲'>分大洲</option>";
			bb+="<option value='长城宽带'>长城宽带</option>";
			bb+="<option value='其他'>其他</option>";
           bb+="</select><div  style='display:none'><select id='national1' name='tzfxx[0].tzfgj' style='width: 70px;'><option>国家</option></select>";
            bb+="<select id='national2' name='tzfxx[0].tzfsf' style='width: 80px;'><option>省份、州</option></select>";
            bb+="<select id='national3' name='tzfxx[0].tzfgj' style='width: 85px;'><option>市(区县)</option></select><div></div>";
           bb+="</div>";
       bb+="</div>";
       $("#addaddress"+(count2-1)+"").append(bb);
	//var aa="<tr id='addaddress"+count2+"'><td width='15%' align='left' colspan='4'>请输入源站IP：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
//	aa+="  <input id='IP"+count2+"' name='' type='text' onblur='Ipaddress("+count2+")'' /> 端口：<input id='duankou"+count2+"' name='' type='text' value='80' />";
	//aa+="<br />源站服务器机房位置：<input id='IPaddress"+count2+"' name='' type='text' disabled='disabled' /><FONT color=#ff0000>(地址有误请右边选择修正)</FONT>";			
	//aa+="<select id='yunyingshang"+count2+"' name='' value='this.value'><option value='0'>运营商</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option><option value='联通'>联通</option><option value='教育网'>教育网</option><option value='网通'>移动</option><option value='铁通'>铁通</option><option value='中国'>中国</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option><option value='长城宽带'>长城宽带</option><option value='其他'>其他</option></select>";
	//aa+="<div  style='display:none'><select id='national1' name='tzfxx[0].tzfgj' style='width: 70px;'><option>国家</option></select>";
	//aa+="<select id='national2' name='tzfxx[0].tzfsf' style='width: 80px;'><option>省份、州</option></select>";
//	aa+="<select id='national3' name='tzfxx[0].tzfgj' style='width: 85px;'><option>市(区县)</option></select><div></td></tr>";
						
	//$("#addaddress"+(count2-1)+"").append(aa);
	
	count2++;
}
function jianshaoIP()
{
	if(count2==2)
	{
		alert("必须有一个IP地址！！");
	}
	else
	{
		$("#addaddress"+(count2-1)+"").remove();
		count2--;
	}
}